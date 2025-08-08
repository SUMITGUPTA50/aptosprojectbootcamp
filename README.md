📦 MyModule::Tipping
A simple Move module for sending tips in AptosCoin between accounts while tracking the total amount a recipient has received.

✨ Features
TipBox resource for each user to store their total received tips.

Initialize TipBox for new accounts.

Send tips from one account to another in AptosCoin.

Track cumulative tips received by any account.

📜 How It Works
1. TipBox Resource
move
Copy
Edit
struct TipBox has key, store {
    total_received: u64
}
Stored under a recipient’s account.

Tracks the sum of all AptosCoin tips they have ever received.

2. initialize_tipbox
move
Copy
Edit
public fun initialize_tipbox(account: &signer)
Creates a TipBox for a user.

Must be called before receiving tips, otherwise send_tip will fail.

3. send_tip
move
Copy
Edit
public fun send_tip(sender: &signer, recipient: address, amount: u64) acquires TipBox
Withdraws amount of AptosCoin from the sender.

Deposits it into the recipient's account.

Updates the recipient's TipBox.total_received.

🛠️ Usage
1. Publish the Module
bash
Copy
Edit
aptos move publish --named-addresses MyModule=default
2. Initialize Your TipBox
bash
Copy
Edit
aptos move run --function-id '<account_address>::Tipping::initialize_tipbox'
3. Send a Tip
bash
Copy
Edit
aptos move run \
  --function-id '<account_address>::Tipping::send_tip' \
  --args address:<recipient_address> u64:<amount>
⚠️ Important Notes
A recipient must have a TipBox initialized before receiving tips.

If borrow_global_mut<TipBox> fails, it means the recipient’s TipBox is missing.

This module currently works only with AptosCoin. You can extend it for other coins by replacing the AptosCoin type.

📄 License
MIT License – feel free to use, modify, and share.
