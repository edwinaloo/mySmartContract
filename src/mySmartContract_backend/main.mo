actor {
  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
};


// VotingContract.mo

import Shared "mo:base/Shared";

type VoteOptions = { option1: Nat; option2: Nat };

public type VotingContract = {
  options: VoteOptions;
  votes: HashMap.Text<Nat>;
};

public shared(VotingContract) func vote(option: Text) : async () {
  switch (option) {
    case "option1" {
      // Validate eligibility and update votes
      VotingContract { votes = votes { ["option1"] += 1; }; ... }
    };
    case "option2" {
      // Validate eligibility and update votes
      VotingContract { votes = votes { ["option2"] += 1; }; ... }
    };
    default {
      // Handle invalid option
      throw("Invalid option");
    };
  };
};

public shared(VotingContract) func tallyVotes() : async Text {
  let totalVotes = votes["option1"] + votes["option2"];
  return "Option1: " # Nat.toText(votes["option1"])
       # ", Option2: " # Nat.toText(votes["option2"])
       # ", Total Votes: " # Nat.toText(totalVotes);
};

actor {
  shared(VotingContract);
};
