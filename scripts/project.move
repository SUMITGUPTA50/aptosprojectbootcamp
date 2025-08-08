module MyModule::Tipping {
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