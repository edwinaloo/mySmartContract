import { mySmartContract_backend } from "../../declarations/mySmartContract_backend";
// script.js

async function vote(option) {
  const response = await fetch('https://<YOUR_CANISTER_ID>.ic0.app/vote', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ option }),
  });

  const result = await response.json();
  console.log(result);
}

async function getTally() {
  const response = await fetch('https://<YOUR_CANISTER_ID>.ic0.app/tallyVotes');
  const result = await response.text();
  document.getElementById('tallyResult').innerText = result;
}
