
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
import Nat64 "mo:base/Nat64";
import Int "mo:base/Int";
import Trie "mo:base/Trie";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import IcpLedger "canister:icp_ledger_canister";
import LT           "../ledger/ledger";
import Helpers "helpers";
import DateTime "mo:datetime/DateTime";

import Types "/Types";
import Account "../transaction/Account";

actor {
public type Subaccount = Blob;
  public type Account = {
    owner : Principal;
    subaccount : ?Subaccount;
  };

let Ledger = actor "ryjl3-tyaaa-aaaaa-aaaba-cai" : LT.Self;
let icp_fee : Nat64 = 10_000;

  public  func transferICP(    transferFrom : Principal, transferTo : [Nat8],transferAmount : Nat64) : async LT.TransferResult {
      let res =  await Ledger.transfer({
        memo: Nat64 = 0;
        from_subaccount = ?Helpers.getSubaccount(transferFrom);
        to = transferTo;
        //  The amount of ICP, minus the necessary transaction fee
        amount = { e8s = transferAmount - icp_fee };
        fee = { e8s = icp_fee };
        created_at_time = ?{ timestamp_nanos = Nat64.fromNat(Int.abs(Time.now())) };
      });
  };


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
    month : Nat;
    // bidHistory : List.List<Bid>
  };
  type ListMonth = {
  january : List.List<Auction>;
  february : List.List<Auction>;
  march : List.List<Auction>;
  april : List.List<Auction>;
  may : List.List<Auction>;
  june : List.List<Auction>;
  july : List.List<Auction>;
  august : List.List<Auction>;
  september : List.List<Auction>;
  october : List.List<Auction>;
  november : List.List<Auction>;
  december : List.List<Auction>;
};

  type AuctionDetails = {
    item : Item;
    // bidHistory : List.List<Bid>;
    createdAt : Time.Time;
  };

  type Auction = {
    id : AuctionId;
    item : Item;
    // bidHistory : List.List<Bid>;
    createdAt : Time.Time;
    month : Nat;
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
    let dateTime : DateTime.DateTime = DateTime.fromTime(Time.now());
    let month = dateTime.dayOfYear();
    let newAuction = { id; item; var bidHistory; createdAt; month};
    auctions := List.push(newAuction, auctions);
  };

  public query func getOverviewList() : async [AuctionOverview] {
    func getOverview(auction : Auction) : AuctionOverview = {
      id = auction.id;
      item = auction.item;
      createdAt = auction.createdAt;
      month = auction.month;
      // bidHistory = auction.bidHistory;
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
    // let bidHistory = List.toArray(List.reverse(auction.bidHistory));
    { item = auction.item;  createdAt = auction.createdAt};
  };

  // func minimumPrice(auction : Auction) : Nat {
  //   switch (auction.bidHistory) {
  //     case null 1;
  //     case (?(lastBid, _)) lastBid.price + 1;
  //   };
  // };

  // public shared (message) func makeBid(auctionId : AuctionId, price : Nat) : async () {
  //   let originator = message.caller;
   
  //   let auction = findAuction(auctionId);
  //   if (price < minimumPrice(auction)) {
  //     Debug.trap("Price too low");
  //   };
   
  // };

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
        // bidHistory = auction.bidHistory;
        createdAt = auction.createdAt;
        month = auction.month;
    };
      let dateTime1 : DateTime.DateTime = DateTime.fromTime(Time.now());
      
      let today  = dateTime1.dayOfYear;
      let yesterday : Nat = today() - 1;

    var id : Nat = 0;
    var bidAuc : Nat = 0;
    let highestBidAuction = List.map<Auction, AuctionOverview>(auctions, getOverview);
    let a = List.toIter(highestBidAuction);
   
for (auction in a) {
    if (auction.month == yesterday) {
      if(auction.item.bid > bidAuc){
        bidAuc := auction.item.bid;
        id := auction.id;
      };
    };
  
};
    let auction = findAuction(id);
    { item = auction.item;  createdAt = auction.createdAt};
};

public query func getHighestBid() : async Nat{
   func getOverview(auction : Auction) : AuctionOverview = {
        id = auction.id;
        item = auction.item;
        // bidHistory = auction.bidHistory;
        createdAt = auction.createdAt;
        month = auction.month;
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

public query func groupAuctionByMonths() :async ListMonth {

  func getOverview(auction : Auction) : AuctionOverview = {
    id = auction.id;
    item = auction.item;
    createdAt = auction.createdAt;
    month = auction.month;
  };

var list1 : List.List<Auction> = List.nil<Auction>();
var list2 : List.List<Auction> = List.nil<Auction>();
var list3 : List.List<Auction> = List.nil<Auction>();
var list4 : List.List<Auction> = List.nil<Auction>();
var list5 : List.List<Auction> = List.nil<Auction>();
var list6 : List.List<Auction> = List.nil<Auction>();
var list7 : List.List<Auction> = List.nil<Auction>();
var list8 : List.List<Auction> = List.nil<Auction>();
var list9 : List.List<Auction> = List.nil<Auction>();
var list10 : List.List<Auction> = List.nil<Auction>();
var list11 : List.List<Auction> = List.nil<Auction>();
var list12 : List.List<Auction> = List.nil<Auction>();
  let highestBidAuction = List.map<Auction, AuctionOverview>(auctions, getOverview);
  let a = List.toIter(highestBidAuction);

  for (auction in a) {
    if(auction.month >= 1 and auction.month <= 30){
      list1 := List.push(auction, list1);
    };
    if(auction.month >= 31 and auction.month <= 60 ){
      list2 := List.push(auction, list2);
    };
    if(auction.month >= 61 and auction.month <= 90 ){
      list3 := List.push(auction, list3);
    };
    if(auction.month >= 91 and auction.month <= 120 ){
      list4 := List.push(auction, list4);
    };
    if(auction.month >= 121 and auction.month <= 150 ){
      list5 := List.push(auction, list5);
    };
    if(auction.month >= 151 and auction.month <= 180 ){
      list6 := List.push(auction, list6);
    };
    if(auction.month >= 181 and auction.month <= 210 ){
      list7 := List.push(auction, list7);
    };
    if(auction.month >= 211 and auction.month <= 240){
      list8 := List.push(auction, list8);
    };
    if(auction.month >= 241 and auction.month <= 270){
      list9 := List.push(auction, list9);
    };
    if(auction.month >= 271 and auction.month <= 300 ){
      list10 := List.push(auction, list10);
    };
    if(auction.month >= 301 and auction.month <= 330 ){
      list11 := List.push(auction, list11);
    };
    if(auction.month >= 331 and auction.month <= 365){
      list12 := List.push(auction, list12);
    };
    
  };
let listMonth = {
   january = list1;
   february = list2;
   march = list3;
   april = list4;
   may = list5;
   june = list6;
   july = list7;
   august = list8;
   september = list9;
   october = list10;
   november = list11;
   december = list12;
};
  return listMonth;
};

};