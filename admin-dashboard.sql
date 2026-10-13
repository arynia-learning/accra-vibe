-- Accra Life owner dashboard and privacy-conscious visit analytics.
-- Additive migration: does not delete or alter existing gameplay data.
-- Owner access is restricted to the verified Supabase Auth email below.

create table if not exists public.site_visits (
  id bigint generated always as identity primary key,
  visitor_id uuid not null,
  page_path text not null default '/',
  user_id uuid null references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists site_visits_created_at_idx on public.site_visits (created_at desc);
create index if not exists site_visits_visitor_created_idx on public.site_visits (visitor_id, created_at desc);
create index if not exists site_visits_user_created_idx on public.site_visits (user_id, created_at desc);

alter table public.site_visits enable row level security;
revoke all on table public.site_visits from anon, authenticated;

create or replace function public.record_site_visit(p_visitor_id uuid, p_page_path text)
returns boolean
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_path text;
begin
  if p_visitor_id is null then return false; end if;
  v_path := left(coalesce(nullif(p_page_path, ''), '/'), 180);
  -- Ignore admin pages and obvious malformed paths.
  if v_path like '/admin%' or left(v_path, 1) <> '/' then return false; end if;
  -- Avoid double-counting repeated reloads of the same page in 15 seconds.
  if exists (
    select 1 from public.site_visits sv
    where sv.visitor_id = p_visitor_id
      and sv.page_path = v_path
      and sv.created_at > now() - interval '15 seconds'
  ) then return true; end if;
  insert into public.site_visits(visitor_id, page_path, user_id)
  values (p_visitor_id, v_path, auth.uid());
  return true;
end;
$$;

revoke all on function public.record_site_visit(uuid, text) from public;
grant execute on function public.record_site_visit(uuid, text) to anon, authenticated;

create or replace function public.get_admin_dashboard_stats()
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_email text;
  v_result jsonb;
begin
  v_email := lower(coalesce(auth.jwt() ->> 'email', ''));
  if v_email <> 'adwoashowgirl0242@gmail.com' then
    raise exception 'Administrator access required' using errcode = '42501';
  end if;

  select jsonb_build_object(
    'generatedAt', now(),
    'visitsToday', (select count(*) from public.site_visits where created_at >= date_trunc('day', now())),
    'visits7Days', (select count(*) from public.site_visits where created_at >= now() - interval '7 days'),
    'visits30Days', (select count(*) from public.site_visits where created_at >= now() - interval '30 days'),
    'visits90Days', (select count(*) from public.site_visits where created_at >= now() - interval '90 days'),
    'visitsByDay', coalesce((
      select jsonb_agg(jsonb_build_object('day', d.day, 'visits', coalesce(v.visits, 0)) order by d.day)
      from (select generate_series(date_trunc('day', now()) - interval '6 days', date_trunc('day', now()), interval '1 day') as day) d
      left join (select date_trunc('day', created_at) as day, count(*) as visits from public.site_visits where created_at >= date_trunc('day', now()) - interval '6 days' group by 1) v on v.day = d.day
    ), '[]'::jsonb),
    'visitsAllTime', (select count(*) from public.site_visits),
    'uniqueVisitors30Days', (select count(distinct visitor_id) from public.site_visits where created_at >= now() - interval '30 days'),
    'registeredPlayers', (select count(*) from public.players),
    'newPlayersToday', (select count(*) from public.players where created_at >= date_trunc('day', now())),
    'activePlayersToday', (select count(distinct player_id) from public.player_activity_log where completed_at >= date_trunc('day', now())),
    'activePlayers7Days', (select count(distinct player_id) from public.player_activity_log where completed_at >= now() - interval '7 days'),
    'onlineNow', (select count(*) from public.player_locations where updated_at >= now() - interval '2 minutes'),
    'recentPlayers', coalesce((
      select jsonb_agg(jsonb_build_object('username', p.username, 'displayName', p.display_name, 'createdAt', p.created_at)
                       order by p.created_at desc)
      from (select username, display_name, created_at from public.players order by created_at desc limit 8) p
    ), '[]'::jsonb),
    'revenue', null,
    'revenueStatus', 'Mobile Money payment provider is not connected yet. No revenue is being reported.',
    'realMoneyTransfersStatus', 'Real-money transfer integration is not connected yet; existing game-wallet transfers are virtual currency only.'
  ) into v_result;
  return v_result;
end;
$$;

revoke all on function public.get_admin_dashboard_stats() from public, anon;
grant execute on function public.get_admin_dashboard_stats() to authenticated;
