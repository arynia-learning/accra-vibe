ACCRA LIFE — V24: PLAYABLE UPSA CLASSROOM

FOCUS OF THIS BUILD
This version improves the UPSA lecture-hall experience instead of adding more unrelated menus.

- The classroom has a lecture board, lecturer, door, room sign and two rows of desks.
- Eight named student NPCs are visible in the classroom and have seated poses and listening / note-taking states.
- Your character starts by the classroom door, rather than in the middle of the room.
- Movement controls animate the character walking to the new position; on a computer, use arrow keys or WASD.
- “Sit at a desk” makes the character walk to the nearest desk before sitting.
- “Attend lecture” moves the character to a desk if needed, then changes the character to a seated studying pose with a writing animation.
- “Stand up” visibly changes the character's pose.
- “Leave location” walks the character to the classroom door before returning to the map.
- Clicking a student NPC gives a short contextual dialogue line.
- Other venue scenes and the existing Accra Life systems are retained.
- Realtime presence still depends on Supabase Realtime being available and other real players using the same deployed version.

HONEST TEST STATUS
JavaScript syntax and ZIP integrity checks are performed on this package. A full browser session and a multi-account live multiplayer test are not available in this build environment, so deploy to a test site or your existing site and verify the in-game behavior.

DEPLOY TO YOUR EXISTING NETLIFY SITE
1. Download and unzip this package.
2. Keep index.html, app.js, styles.css and config.js together in one folder.
3. Open your existing site in the Netlify dashboard: https://app.netlify.com/
4. Deploy the extracted folder to the existing site's manual deploy area. Do not create a new site.
5. Open your existing Accra Life public link and refresh. If the old version remains cached, try a private browser tab.

The Supabase client key in config.js is a public publishable key. Never add a service-role key to a public game package.


V25 — ENZO LOUNGE INTERACTIVE DJ & SONG REQUESTS

NEW FEATURES
- The map destination is labelled Enzo Lounge (Osu, Accra).
- Song request form asks for song title, artist, and a YouTube link.
- A shared request queue is stored in Supabase and refreshes every 3.5 seconds.
- A demo DJ control can start the next pending request; all clients see the shared now-playing state.
- Players tap “Play song here” to open the accepted YouTube video in an embedded player with sound. Mobile browsers may block autoplay, so each player may need to tap to start playback. Some videos do not allow embedding.
- The player does not download or host copyrighted songs. Use official/authorized uploads and respect rights-holder restrictions.
- DJ controls are intentionally open to all authenticated players for this prototype; production should restrict them to authorized DJ/staff roles and use an atomic server-side queue RPC.

REQUIRED SUPABASE SETUP
1. Open Supabase Dashboard for project kpyugkfbkzkuumcpkzkb.
2. Go to SQL Editor and run supabase-v25-enzo-song-requests.sql.
3. Deploy the five web files to your EXISTING Netlify site: index.html, app.js, styles.css, config.js, README.txt.
4. Sign in, open the map, enter Enzo Lounge, submit a song request with a valid YouTube link, then tap DJ play next.
5. To test shared queue, open the game in a second signed-in account/browser and visit Enzo. It should see the queue and now-playing track; tap Play song here on that device to hear it.

LIMITATIONS / TEST STATUS
- The song request data and status synchronize through Supabase polling, not frame-perfect audio synchronization.
- Audio playback is YouTube embedded playback; availability, embedding, ads, and autoplay are controlled by YouTube and browser settings. This does not guarantee every submitted song will play.
- This package has JavaScript syntax and ZIP integrity checks. No authenticated end-to-end browser test or real two-account test was available during build.
- No database changes were applied automatically. Run the SQL migration above before testing the request queue.


V26 PHONE AUDIO TROUBLESHOOTING UPDATE
- The song player now loads a visible YouTube embed with controls and an explicit unmuted parameter.
- A direct Open song in YouTube fallback is shown if mobile embedded playback remains silent or the video blocks embedding.
- On iPhone, browsers may require a second tap on the YouTube player play button. Check phone volume and Silent Mode.
- A database status of playing only means the DJ queue selected that song; it cannot prove audio is audible on every listener device.


V27 — UNIVERSAL VENUE MUSIC + PRIVATE SERVICE SEARCH
- Adds a venue-specific shared music request queue at Enzo Lounge, church, gym, Labadi Beach, East Legon lounges, Osu and Accra Mall/cafe hangout.
- Each venue has its own queue; Enzo continues using the existing 'enzo' queue key so previous requests remain visible.
- Shared venue requests still require a YouTube video link. The Find this song on YouTube button opens search results so a player can choose a video and paste its link. This avoids pretending title-only requests can identify a single authorized playable recording.
- Adds private personal music search buttons for YouTube, Spotify and Apple Music. These open the selected service's search page/app where available. This is not a deep authenticated Spotify/Apple Music integration and personal playback does not broadcast into the venue queue.
- Each signed-in listener must start playback on their own device; a shared queue does not guarantee synchronized audio across phones.
- Supabase project policy and venue check constraint were updated directly for the listed venues and verified. The migration SQL is included for reference/new environments; do not rerun it casually against an already modified schema without reviewing it.
- JavaScript syntax checked. Not browser/device tested, not deployed to Netlify.

PUBLISH V27
1. Extract the ZIP.
2. Deploy index.html, app.js, styles.css, config.js and README.txt to the existing Netlify site (do not create a new site).
3. Sign in and test Enzo first, then enter church/gym/beach and try a separate request. For shared playback, use a valid authorized YouTube video URL. Personal service search opens the provider's own website/app.


V27 — BRAIN GAMES ADD-ON
- Added accra-life-games.html alongside the existing V27 website files.
- Added a Games link to the existing Accra Life navigation without removing existing sections.
- Games page includes Brain Arena, Logic Lab, Quick Fire, recent scores and leaderboard.
- The games page uses the same Supabase project and requires a signed-in Accra Life session.
- Games use virtual points only; no entry fees, cash prizes or withdrawals are enabled.
- This package has not been deployed to Netlify or tested in a live authenticated browser session.

DEPLOY THIS PACKAGE
1. Download and extract this ZIP.
2. Deploy the complete extracted folder to the existing Accra Life Netlify site's manual deploy area.
3. Do not upload only index.html or only accra-life-games.html. Deploy the complete folder to preserve V27.
4. After Netlify reports Published, sign in to Accra Life, tap Games, and test each game plus the leaderboard.
