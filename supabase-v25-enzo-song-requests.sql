-- Accra Life V27: shared per-venue music request queues
-- Run this script once in Supabase SQL Editor for project kpyugkfbkzkuumcpkzkb.
-- This stores queue metadata and YouTube video IDs only; it does not download music.
create table if not exists public.club_song_requests (
  id uuid primary key default gen_random_uuid(),
  venue_id text not null default 'enzo' check (venue_id in ('enzo','nightclub','church','gym','labadi','eastlegon','osu','mall')),
  requester_id uuid not null references public.players(id) on delete cascade,
  requester_name text not null default 'Player',
  song_title text not null check (char_length(song_title) between 1 and 120),
  artist_name text not null check (char_length(artist_name) between 1 and 120),
  youtube_video_id text not null check (youtube_video_id ~ '^[A-Za-z0-9_-]{11}$'),
  status text not null default 'pending' check (status in ('pending','playing','played','rejected')),
  created_at timestamptz not null default now(),
  accepted_at timestamptz
);
create index if not exists club_song_requests_venue_status_created_idx
  on public.club_song_requests (venue_id, status, created_at desc);
alter table public.club_song_requests enable row level security;
grant select, insert, update on public.club_song_requests to authenticated;
alter table public.club_song_requests drop constraint if exists club_song_requests_venue_id_check;
alter table public.club_song_requests add constraint club_song_requests_venue_id_check
  check (venue_id in ('enzo','nightclub','church','gym','labadi','eastlegon','osu','mall'));
drop policy if exists "Signed-in players can see Enzo song requests" on public.club_song_requests;
drop policy if exists "Players can request Enzo songs as themselves" on public.club_song_requests;
drop policy if exists "Signed-in Enzo visitors can operate demo DJ queue" on public.club_song_requests;
drop policy if exists "Signed-in players can see venue music requests" on public.club_song_requests;
drop policy if exists "Players can request venue songs as themselves" on public.club_song_requests;
drop policy if exists "Signed-in players can operate demo venue queues" on public.club_song_requests;
create policy "Signed-in players can see venue music requests"
  on public.club_song_requests for select to authenticated
  using (venue_id in ('enzo','nightclub','church','gym','labadi','eastlegon','osu','mall'));
create policy "Players can request venue songs as themselves"
  on public.club_song_requests for insert to authenticated
  with check (auth.uid() = requester_id and venue_id in ('enzo','nightclub','church','gym','labadi','eastlegon','osu','mall') and status = 'pending');
create policy "Signed-in players can operate demo venue queues"
  on public.club_song_requests for update to authenticated
  using (venue_id in ('enzo','nightclub','church','gym','labadi','eastlegon','osu','mall'))
  with check (venue_id in ('enzo','nightclub','church','gym','labadi','eastlegon','osu','mall'));
notify pgrst, 'reload schema';
-- Optional: enable Realtime for this table in Supabase Dashboard > Database > Publications.
-- The frontend also polls every 3.5 seconds, so queue refresh works without Realtime.
