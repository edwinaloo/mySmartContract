module mySmartContract_backend {

  // Import statements go here if needed

  // Declarations and definitions follow
  actor {
    public query func greet(name: Text) : async Text {
      return "Hello, " # name # "!";
    };

    // Other actor logic goes here
  };

  import Shared "mo:base/Shared";

  type VoteOptions = { option1: Nat; option2: Nat };

  public actor VotingContract = {
    options: VoteOptions;
    votes: HashMap.Text<Nat>;
  };

  public shared(VotingContract) func vote(option: Text) : async Text {
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
};

// Frontend code
async function vote(option) {
  const response = await fetch('https://bkyz2-fmaaa-aaaaa-qaaaq-cai.ic0.app/vote', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ option }),
  });

  const result = await response.json();
  console.log(result);
}
