ACCRA LIFE V27 — LIVE GAME LEADERBOARD UPDATE

WHAT CHANGED
- The Games page now shows a Live leaderboard while a player is inside a game.
- It refreshes every 2.5 seconds and shows ranks, player name, current verified score, correct answers, and marks the signed-in player.
- Only players with an active recent attempt for the same game appear. A player in Brain Arena will not appear in the Logic Lab list.
- Completed-score history and the existing leaderboard remain available.
- This is a shared live score board, not synchronized multiplayer question delivery: players play their own attempts in the same game and can compare progress.

FILES
- The website files at the ZIP root preserve the V27 website.
- supabase/functions/accra-life-games/index.ts contains the updated Edge Function source. Deploy this updated function to the existing Supabase project before testing the new live leaderboard.

DEPLOYMENT
1. Deploy the complete ZIP folder to the existing Netlify site's manual deploy area (do not create a new site).
2. In the existing Supabase project, update/deploy the Edge Function named accra-life-games using the source at supabase/functions/accra-life-games/index.ts. Keep JWT verification enabled. Do not put the service-role key into website files; Supabase supplies it as a server-side function secret.
3. Sign in to Accra Life in two separate browser sessions/accounts.
4. Open Games in both sessions and start the same game (for example, Brain Arena).
5. As each player answers, the other session's live leaderboard should update within a few seconds.

TEST STATUS
- Inline JavaScript syntax was checked with Node.js.
- ZIP integrity is checked after packaging.
- A full authenticated browser test with two accounts was not available here, so verify on a test deploy before relying on it.
