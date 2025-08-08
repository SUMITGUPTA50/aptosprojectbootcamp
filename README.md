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
Code :module MyModule::Tipping {
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// TipBox resource storing total tips received
    struct TipBox has key, store {
        total_received: u64,
    }

    /// Creates a TipBox for a user to receive tips
    public fun initialize_tipbox(account: &signer) {
        move_to(account, TipBox { total_received: 0 });
    }

    /// Sends a tip in AptosCoin to a recipient's TipBox
    public fun send_tip(sender: &signer, recipient: address, amount: u64) acquires TipBox {
        let tip = coin::withdraw<AptosCoin>(sender, amount);
        coin::deposit<AptosCoin>(recipient, tip);

        let tipbox = borrow_global_mut<TipBox>(recipient);
        tipbox.total_received = tipbox.total_received + amount;
    }
}
📄 License
MIT License – feel free to use, modify, and share.
 <img width="1783" height="914" alt="Screenshot 2025-08-08 171309" src="https://github.com/user-attachments/assets/b169d55e-5164-464f-b3cf-3ab903ebd1b9" />

```Transaction submitted: https://explorer.aptoslabs.com/txn/0xb361f1d1402eee48e9b1b7d7774cc7bda760d4e86429eb2e99c26fc1e5bf389f?network=devnet

{
  "Result": {
    "transaction_hash": "0xb361f1d1402eee48e9b1b7d7774cc7bda760d4e86429eb2e99c26fc1e5bf389f",
    "gas_used": 1945,
    "gas_unit_price": 100,
    "sender": "c41c21ede4a9bbdc249df6f13d66a0cecd4886067b3b1d92082d54ed605672dc",
    "sequence_number": 0,
    "replay_protector": {
      "SequenceNumber": 0
    },<img width="1783" height="914" alt="Screenshot 2025-08-08 171309" src="https://github.com/user-attachments/assets/2ab95a6c-cd5c-4146-ba55-ff0598c5a59c" />

    "success": true,
    "timestamp_us": 1754650138067651,
    "version": 27893143,
    "vm_status": "Executed successfully"
  }
}
PS C:\Users\sumit\OneDrive\Desktop\aptosworkshop> aptos account fund-with-faucet
{
{
  "Result": "Added 100000000 Octas to account 0xc41c21ede4a9bbdc249df6f13d66a0cecd4886067b3b1d92082d54ed605672dc"
}```
