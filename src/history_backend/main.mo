
import Principal "mo:base/Principal";
import Timer "mo:base/Timer";
import Debug "mo:base/Debug";
import List "mo:base/List";
import Order "mo:base/Order";
import Array "mo:base/Array";
import Container "../backend/Container";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

actor {
  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  type Item = {
    bid : Nat;
    content : Blob;
  };

  type Bid = {
    price : Nat;
    time : Nat;
    originator : Principal.Principal;
  };

  type AuctionId = Nat;

  type AuctionOverview = {
    id : AuctionId;
    item : Item;
    createdAt : Time.Time;
  };

  type AuctionDetails = {
    item : Item;
    bidHistory : [Bid];
    createdAt : Time.Time;
  };

  type Auction = {
    id : AuctionId;
    item : Item;
    var bidHistory : List.List<Bid>;
    createdAt : Time.Time;
  };

 // Структура для представления пользователя и его кошелька
type User = {
  id: Text;
  wallet: Wallet;
};

// Структура кошелька
type Wallet = {
  balance: Nat;
};

// База данных пользователей
  stable var users = List.nil<User>();
  
  stable var auctions = List.nil<Auction>();
  // stable var wallets = List.nil<Wallet>();
  stable var idCounter = 0;


  func newAuctionId() : AuctionId {
    let id = idCounter;
    idCounter += 1;
    id;
  };

  public func newAuction(item : Item) : async () {
    let id = newAuctionId();
    let bidHistory = List.nil<Bid>();
    let createdAt = Time.now();
    let newAuction = { id; item; var bidHistory; createdAt};
    auctions := List.push(newAuction, auctions);
  };

  public query func getOverviewList() : async [AuctionOverview] {
    func getOverview(auction : Auction) : AuctionOverview = {
      id = auction.id;
      item = auction.item;
      createdAt = auction.createdAt;
    };
    let overviewList = List.map<Auction, AuctionOverview>(auctions, getOverview);
    List.toArray(List.reverse(overviewList));
  };


// public func getTodaysOverviewList() : async [AuctionOverview] {
//     let today = Date.localDateNow();
    
//     // Function to check if an auction was created today
//     func isTodaysAuction(auction : Auction) : Bool {
//         let auctionDate = Date.fromTime(auction.createdAt / 1000); // Assuming createdAt is in milliseconds
//         return auctionDate.year == today.year  auctionDate.month  today.month  auctionDate.day == today.day;
//     };
    
//     // Function to convert auction to overview
//     func getOverview(auction : Auction) : AuctionOverview {
//         return { id = auction.id; item = auction.item; createdAt = auction.createdAt; };
//     };

//     // Filter auctions created today and map them to overview
//     let todaysAuctions = Array.filter(isTodaysAuction, auctions);
//     let overviewList = Array.map<Auction, AuctionOverview>(getOverview, todaysAuctions);

//     // Reverse the list if needed
//     let reversedOverviewList = Array.reverse(overviewList);

//     reversedOverviewList;
// };


  func findAuction(auctionId : AuctionId) : Auction {
    let result = List.find<Auction>(auctions, func auction = auction.id == auctionId);
    switch (result) {
      case null Debug.trap("Inexistent id");
      case (?auction) auction;
    };
  };

  public query func getAuctionDetails(auctionId : AuctionId) : async AuctionDetails {
    let auction = findAuction(auctionId);
    let bidHistory = List.toArray(List.reverse(auction.bidHistory));
    { item = auction.item; bidHistory; createdAt = auction.createdAt};
  };

  func minimumPrice(auction : Auction) : Nat {
    switch (auction.bidHistory) {
      case null 1;
      case (?(lastBid, _)) lastBid.price + 1;
    };
  };

  public shared (message) func makeBid(auctionId : AuctionId, price : Nat) : async () {
    let originator = message.caller;
   
    let auction = findAuction(auctionId);
    if (price < minimumPrice(auction)) {
      Debug.trap("Price too low");
    };
   
  };

public query func decodeBlobToText(blob: Blob) : async ?Text {
  let text : ?Text = Text.decodeUtf8(blob);
  return text;
};

//   // Function to get wallet balance based on user ID
// // Modify your function to take a Principal directly
// public func getWalletBalance(principal: Principal) : async Nat {
//   let user = Principal.id;
//     // Find the user with the provided principal
//     if (let user = List.find({ user = principal.id }, users)) {
//         return user.wallet
//     } else {
//         // Handle case where user is not found
//         return 0
//     }
// };

// public shared ({ caller }) func register() : async () {
//   let userId = caller; // Assuming caller represents the user ID
//     let userWallet = getWalletBalance(userId);
//     if(Principal.isAnonymous(caller)){
//       let user : User = {
//         id;
//         wallet; 
//     };
//     users := List.push(user, users);
//         return;
//     };
//     let user : User = {
//         id;
//         wallet; 
//     };
//     users := List.push(user, users);
// };

};


  //  type Wallet = {
  //   owner : Principal.Principal;
  //   balance : Nat;
  // };

  // public shared (message) func deposit(amount : Nat) : async () {
  //   let caller = message.caller;
  //   let existingWallet = List.find<Wallet>(wallets, func wallet = wallet.owner == caller);
  //   // switch (existingWallet) {
  //   //   case null {
  //   //     // Create a new wallet for the user
  //   //     let newWallet = { owner = caller; balance = amount };
  //   //     wallets := List.push(newWallet, wallets);
  //   //   };
  //   //   case (?wallet) {
  //   //     let balance = wallet.balance;
  //   //     // Update the existing wallet balance
  //   //     wallet.balance : balance + amount;
  //   //   };
  //   // };
  // };

  // func getWallet(owner : Principal.Principal) : Wallet {
  //   let wallet = List.find<Wallet>(wallets, func w = w.owner == owner);
  //   switch (wallet) {
  //     case null Debug.trap("User does not have a wallet");
  //     case (?w) w;
  //   };
  // };
// };

// import Principal "mo:base/Principal";
// import Timer "mo:base/Timer";
// import Debug "mo:base/Debug";
// import List "mo:base/List";
// import Array "mo:base/Array";
// import Wallet "../wallet/wallet";
// actor {
//   public query func greet(name : Text) : async Text {
//     return "Hello, " # name # "!";
//   };

//   type Item = {
//     title : Text;
//     description : Text;
//     content : Blob;
//   };

//   type Bid = {
//     price : Nat;
//     time : Nat;
//     originator : Principal.Principal;
//   };

//   type AuctionId = Nat;

//   type AuctionOverview = {
//     id : AuctionId;
//     item : Item;
//   };

//   type AuctionDetails = {
//     item : Item;
//     bidHistory : [Bid];
//     remainingTime : Nat;
//   };

//   type Auction = {
//     id : AuctionId;
//     item : Item;
//     var bidHistory : List.List<Bid>;
//     var remainingTime : Nat;
//   };

 
  
//   stable var auctions = List.nil<Auction>();
//   stable var idCounter = 0;

//   func tick() : async () {
//     for (auction in List.toIter(auctions)) {
//       if (auction.remainingTime > 0) {
//         auction.remainingTime -= 1;
//       };
//     };
//   };

//   let timer = Timer.recurringTimer(#seconds 1, tick);

//   func newAuctionId() : AuctionId {
//     let id = idCounter;
//     idCounter += 1;
//     id;
//   };

//   public func newAuction(item : Item, duration : Nat) : async () {
//     let id = newAuctionId();
//     let bidHistory = List.nil<Bid>();
//     let newAuction = { id; item; var bidHistory = bidHistory; var remainingTime = duration };
//     auctions := List.push(newAuction, auctions);
//   };

//   public query func getOverviewList() : async [AuctionOverview] {
//     func getOverview(auction : Auction) : AuctionOverview = {
//       id = auction.id;
//       item = auction.item;
//     };
//     let overviewList = List.map<Auction, AuctionOverview>(auctions, getOverview);
//     List.toArray(List.reverse(overviewList));
//   };

//   func findAuction(auctionId : AuctionId) : Auction {
//     let result = List.find<Auction>(auctions, func auction = auction.id == auctionId);
//     switch (result) {
//       case null Debug.trap("Inexistent id");
//       case (?auction) auction;
//     };
//   };

//   public query func getAuctionDetails(auctionId : AuctionId) : async AuctionDetails {
//     let auction = findAuction(auctionId);
//     let bidHistory = List.toArray(List.reverse(auction.bidHistory));
//     { item = auction.item; bidHistory; remainingTime = auction.remainingTime };
//   };

//   func minimumPrice(auction : Auction) : Nat {
//     switch (auction.bidHistory) {
//       case null 1;
//       case (?(lastBid, _)) lastBid.price + 1;
//     };
//   };

//   public shared (message) func makeBid(auctionId : AuctionId, price : Nat) : async () {
//     let originator = message.caller;
//     if (Principal.isAnonymous(originator)) {
//       Debug.trap("Anonymous caller");
//     };
//     let auction = findAuction(auctionId);
//     if (price < minimumPrice(auction)) {
//       Debug.trap("Price too low");
//     };
//     let time = auction.remainingTime;
//     if (time == 0) {
//       Debug.trap("Auction closed");
//     };

//      // Deduct the bid amount from the user's wallet
//     let wallet = getWalletForUser(originator);
//     if (wallet.balance < price) {
//         Debug.trap("Insufficient funds");
//     };
    
//     let newBid = { price; time; originator };
//     auction.bidHistory := List.push(newBid, auction.bidHistory);
//   };

//     type Wallet = {
//       balance : Nat;
//     };

//     type UserWalletPair = {
//         userPrincipal : Principal;
//         wallet : Wallet;
//     };
//     var userWallets : [UserWalletPair] = [];

//     public query func getWalletForUser(userPrincipal: Principal) : Wallet {
//       var userWalletOpt = userWallets.find<Wallet>(pair, pair.userPrincipal == userPrincipal );

//       switch (userWalletOpt) {
//       case null Debug.trap("not found");
//       case (?userWalletOpt) userWalletOpt;
//     };

//   };

//     // persist chunks in bucket
//   public func putFileChunks(fileId: FileId, chunkNum : Nat, fileSize: Nat, chunkData : Blob) : async () {
//     let b : Bucket = await getEmptyBucket(?fileSize);
//     let _ = await b.putChunks(fileId, chunkNum, chunkData);
//   };

//   // save file info 
//   public func putFileInfo(fi: FileInfo) : async ?FileId {
//     let b: Bucket = await getEmptyBucket(?fi.size);
//     Debug.print("creating file info..." # debug_show(fi));
//     let fileId = await b.putFile(fi);
//     fileId
//   };
// };