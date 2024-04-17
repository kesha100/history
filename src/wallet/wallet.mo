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


// import Array "mo:base/Array";
// // import HashMap "mo:base?HashMap";
// import Nat "mo:base/Nat";
// import List "mo:base/List";
// import Bool "mo:base/Bool";
// import HashMap "mo:base/HashMap";
// import Hash "mo:base/Hash";
// import Result "mo:base/Result";
// import Text "mo:base/Text";


// type User = {
//   id: Nat;
//   wallet: Nat;
// };

// type Transaction = {
//   userId: Nat;
//   amount: Nat;
// };

// type UsersDB = HashMap.HashMap(Nat, User);

// type TransactionsDB = Array.Transaction;

// var usersDB : UsersDB = HashMap.empty();
// var transactionsDB : TransactionsDB = [];

// func userExists(userId: Nat) : Bool {
//   switch (usersDB.get(userId)) {
//     case (?user) { return true; }
//     case (_) { return false; }
//   };
// };

// public func debitICP(user_id: Nat, amount: Nat) : Bool {
//   if (!userExists(user_id)) {
//     return false; 
//   }
  
//   let user = usersDB.get(user_id);
  
//   if (user.wallet < amount) {
//     return false;
//   }
  
//   usersDB.put(user_id, {user with wallet = user.wallet - amount});
  
//   transactionsDB := Array.append(transactionsDB, {userId = user_id; amount = amount});
  
//   return true; 
// };


// Структура для представления пользователя и его кошелька
// type User = {
//   id: Text;
//   wallet: Wallet;
// };

// // Структура кошелька
// type Wallet = {
//   balance: Nat
// };

// type Transaction = {
//   userId: Nat;
//   amount: Nat;
// };

// type UsersDB = HashMap.HashMap<Nat, User>;

// type TransactionsDB = [Transaction];

// var transactionsDB : TransactionsDB = [];


// // База данных пользователей
// var users : [User] = [];

// actor {

// func userExists(userId: Nat) : Bool {
//   switch (usersDB.get(userId)) {
//     case (?user) { return true; };
//     case _ { return false; };
//   }
// };


// public func debitICP(user_id: Nat, amount: Nat) : async Bool {{
//   // function body
//    if (not userExists(user_id)) {
//     return false;
//   };

//  let user = switch (usersDB.get(user_id)) {
//     case (?user) user;
//     case _ { return false; }
//   };

//   if (user.wallet < amount) {
//     return false;
//   };
  
//   usersDB.put(user_id, {user with wallet = user.wallet - amount});
  
//   transactionsDB := Array.push(transactionsDB, {userId = user_id; amount = amount});
  
//   return true; 

// }}
// public func debitICP(user_id: Nat, amount: Nat) : async Bool {
//   if (not userExists(user_id)) {
//     return false;
//   };
  
//   let user = switch (usersDB.get(user_id)) {
//     case (?user) user;
//     case _ { return false; }
//   };
  
//   if (user.wallet < amount) {
//     return false;
//   };
  
//   usersDB.put(user_id, {user with wallet = user.wallet - amount});
  
//   transactionsDB := Array.push(transactionsDB, {userId = user_id; amount = amount});
  
//   return true; 
// }

// };
