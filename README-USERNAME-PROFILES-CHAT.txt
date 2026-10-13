ACCRA LIFE V28 — USERNAME SEARCH, SHAREABLE PROFILES, PRIVATE CHAT, AND GAME-MONEY SHORTCUTS

WHAT THIS UPDATE ADDS
- A Find People box in Social where signed-in users can search for another player's exact username (with or without @).
- Share my profile button, using the phone's Share sheet when available, or copying/prompting with a shareable link.
- A public profile card with username, level, and experience.
- Message button from a profile that opens a private conversation thread.
- Conversation history and a send-message box inside the chat modal.
- Send game money shortcut from profiles and chats, using the existing send_player_money RPC and existing simulated game wallet.
- Open chat and send game money shortcuts beside recent messages.
- Keeps the existing virtual payment sandbox and all existing site features in this package.

IMPORTANT LIMITS
- This is a prepared website package; it has NOT been deployed to Netlify by this ZIP creation step.
- Username search, profile details, messaging, and game-money transfers rely on the existing Supabase tables/policies and send_player_money RPC. They must be tested with two separate signed-in accounts.
- The game-money shortcut uses Accra Life's existing in-game simulation currency. It does not use the separate local-only payment sandbox, MTN MoMo, Telecel Cash, or real money.
- A shared profile URL pre-fills the username search after the recipient opens Accra Life and signs in; they can then open Social and tap Search.
- No database schema changes or payment-provider connections were made in this package.

DEPLOYMENT SAFETY
- Do not upload this ZIP as a standalone replacement without extracting it first.
- Deploy the complete site folder together so index.html, app.js, styles.css, config.js, the games page, and Supabase setup files remain together.
- Keep a copy of the current working Netlify deployment before replacing files.
- After deploying, sign in with two test accounts and test: search username, open profile, share profile, send message, reply, send a small amount of virtual game money, and verify both balances/transaction histories.
