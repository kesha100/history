
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
import Result "mo:base/Result";
import Blob "mo:base/Blob";
import Error "mo:base/Error";
import IcpLedger "canister:icp_ledger_canister";

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
    bidHistory : List.List<Bid>
  };

  type AuctionDetails = {
    item : Item;
    bidHistory : List.List<Bid>;
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
      bidHistory = auction.bidHistory;
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
    { item = auction.item; bidHistory = auction.bidHistory; createdAt = auction.createdAt};
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

type Time = Int;
let now = Time.now();

public query func getHighestBidAuction() : async AuctionDetails {
    func getOverview(auction : Auction) : AuctionOverview = {
        id = auction.id;
        item = auction.item;
        bidHistory = auction.bidHistory;
        createdAt = auction.createdAt;
    };
     func isToday(timestamp: Time) : Bool  {
    let today = Time.now() / 86400; // Convert current time to days since epoch
    let createdAtDay = timestamp / 86400; // Convert auction creation time to days since epoch
    return today == createdAtDay;
};
    var id : Nat = 0;
    let highestBidAuction = List.map<Auction, AuctionOverview>(auctions, getOverview);
    let a = List.toIter(highestBidAuction);
    var auc = List.nil<Auction>();
    let c = List.toIter(auc);
    // for (b in a){
    //   if(isToday(b.createdAt)){
    //     let new = { id = b.id; item = b.item; var bidHistory = b.bidHistory; createdAt = b.createdAt};
    //     auc := List.push(new, auc);
    //   }else{
    //     Debug.trap("not found auction");
    //   };
    // };

    for (auction in a) {
        for (auction1 in a) {
            if (auction.item.bid > auction1.item.bid) {
                   id := auction.id;
            
            };
        };
    };
    let auction = findAuction(id);
    // let bidHistory = List.toArray(List.reverse(auction.bidHistory));
    { item = auction.item; bidHistory = auction.bidHistory; createdAt = auction.createdAt};
};

public query func getHighestBid() : async Nat{
   func getOverview(auction : Auction) : AuctionOverview = {
        id = auction.id;
        item = auction.item;
        bidHistory = auction.bidHistory;
        createdAt = auction.createdAt;
    };
   let highestBidAuction = List.map<Auction, AuctionOverview>(auctions, getOverview);
    let a = List.toIter(highestBidAuction);
    var bid1 : Nat = 0;
     for (auction in a) {
        for (auction1 in a) {
            if (auction.item.bid > auction1.item.bid) {
                 bid1 := auction.item.bid;
            
            };
        };
    };
    let bid : Nat = bid1;
    return bid;
};
};