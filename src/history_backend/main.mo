
import Principal "mo:base/Principal";
import Timer "mo:base/Timer";
import Debug "mo:base/Debug";
import List "mo:base/List";

actor {
  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  type Item = {
    title : Text;
    description : Text;
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
  };

  type AuctionDetails = {
    item : Item;
    bidHistory : [Bid];
    remainingTime : Nat;
  };

  type Auction = {
    id : AuctionId;
    item : Item;
    var bidHistory : List.List<Bid>;
    var remainingTime : Nat;
  };
  stable var auctions = List.nil<Auction>();
  stable var idCounter = 0;

  func tick() : async () {
    for (auction in List.toIter(auctions)) {
      if (auction.remainingTime > 0) {
        auction.remainingTime -= 1;
      };
    };
  };

  /// Install a timer:
  let timer = Timer.recurringTimer(#seconds 1, tick);

  func newAuctionId() : AuctionId {
    let id = idCounter;
    idCounter += 1;
    id;
  };

  public func newAuction(item : Item, duration : Nat) : async () {
    let id = newAuctionId();
    let bidHistory = List.nil<Bid>();
    let newAuction = { id; item; var bidHistory; var remainingTime = duration };
    auctions := List.push(newAuction, auctions);
  };
  public query func getOverviewList() : async [AuctionOverview] {
    func getOverview(auction : Auction) : AuctionOverview = {
      id = auction.id;
      item = auction.item;
    };
    let overviewList = List.map<Auction, AuctionOverview>(auctions, getOverview);
    List.toArray(List.reverse(overviewList));
  };

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
    { item = auction.item; bidHistory; remainingTime = auction.remainingTime };
  };

  func minimumPrice(auction : Auction) : Nat {
    switch (auction.bidHistory) {
      case null 1;
      case (?(lastBid, _)) lastBid.price + 1;
    };
  };

  public shared (message) func makeBid(auctionId : AuctionId, price : Nat) : async () {
    let originator = message.caller;
    if (Principal.isAnonymous(originator)) {
      Debug.trap("Anonymous caller");
    };
    let auction = findAuction(auctionId);
    if (price < minimumPrice(auction)) {
      Debug.trap("Price too low");
    };
    let time = auction.remainingTime;
    if (time == 0) {
      Debug.trap("Auction closed");
    };
    let newBid = { price; time; originator };
    auction.bidHistory := List.push(newBid, auction.bidHistory);
  };
};
