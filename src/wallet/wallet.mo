// import Text "mo:base/Text";
// import ICP "mo:base/ICP";
// import Principal "mo:base/Principal";
// import Result "mo:base/Result";
// import ICPLedger "mo:base/icp_ledger";

// type Wallet = {
//     userPrincipal : Principal;
//     balance : Nat;
//     // Add any other properties you need for a wallet
// };

// actor {
//   public func transferICP(to: Principal, amount: ICP.Tokens) : async Result<ICPLedger.BlockIndex, ICPLedger.Error> {
//     let args: ICPLedger.TransferArgs = {
//       memo = 0;
//       amount = amount;
//       fee = { e8s = 10_000 };
//       from_subaccount = null;
//       to = Principal.toAccountIdentifier(to);
//       created_at_time = null;
//     };
//     ICPLedger.transfer(args)
//   };
//   type Wallet = {
//     balance : Nat;
//   };
// };


// type Wallet = {
//     userPrincipal : Principal;
//     balance : Nat;
//     // Add any other properties you need for a wallet
// };

// actor {
//     var userWallets : [Wallet] = [];

//     public func addUserWallet(userPrincipal: Principal, balance: Nat) : async () {
//         let newWallet = { userPrincipal = userPrincipal; balance = balance };
        
//     };
//    module WalletModule {
//     type Wallet = {
//         // Define your Wallet type fields here
//         balance : Nat;
//         // Other fields...
//     };

//     // Define a static function that returns a static instance of Wallet
//     public func getStaticWallet() : Wallet {
//         return {
//             balance = 1000; // Static balance value
//             // Other static field initializations...
//         };
//     };
// };

// };


