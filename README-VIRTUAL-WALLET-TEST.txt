ACCRA LIFE V27 — VIRTUAL WALLET TEST MODE

This package preserves the existing Accra Life V27 website, game page, game Edge Function source, styling, configuration, and SQL file. The app.js wallet panel now includes a separate local-only payment sandbox for testing the user interface and basic deposit/withdrawal steps.

WHAT WAS ADDED
- Separate Payment Sandbox in Wallet.
- Add virtual test funds (up to GH₵10,000 per test action).
- Request a virtual test withdrawal, with a balance check.
- Test transaction history saved in this browser/device, separately for each signed-in player.
- A button to simulate a withdrawal status update.
- Reset control for the local test wallet.
- Existing Accra Life game-currency wallet and transactions remain separate and unchanged.

IMPORTANT LIMITATIONS
- These are fictional test funds. No real money moves.
- The sandbox is local browser storage and is not a secure or authoritative wallet ledger. It must not be used for cash competitions or real deposits/withdrawals.
- No Mobile Money or bank provider is connected in this build.
- The simulated withdrawal status is not a real payout confirmation.
- Do not enable real-money entry fees, prizes, or withdrawals until applicable Ghanaian legal/regulatory requirements and payment-provider approval have been confirmed.

TEST STEPS
1. Upload all website files together to the existing Netlify site (do not upload only app.js).
2. Sign in to Accra Life.
3. Open Wallet.
4. Under “Payment sandbox · Virtual money only,” enter 10 and choose “Add test funds.” The test balance should increase by GH₵10.
5. Enter 4 and choose “Request test withdrawal.” The balance should decrease by GH₵4 and a pending test request should appear.
6. Tap “Simulate payout status.” It should mark the request “SIMULATED COMPLETE · NOT PAID.” No money is sent.
7. Refresh the page and revisit Wallet; test data should remain on that browser/device. Clearing browser website data removes it.
8. Use “Reset test wallet” to clear the test balance and test history.

DEPLOYMENT STATUS
This ZIP is a prepared package only. It has not been uploaded to Netlify or tested against a live production session by this change.
