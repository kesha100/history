import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory } from '../../declarations/icp_ledger_canister/icp_ledger_canister.did.js';

// Ensure the canisterId is correctly defined
const canisterId = "be2us-64aaa-aaaaa-qaabq-cai";
if (!canisterId) {
  console.error("Canister ID is undefined");
} else {
  console.log("Canister ID:", canisterId);
}

// Create an HTTP agent
const agent = new HttpAgent({
  host: 'http://127.0.0.1:4943/?canisterId=br5f7-7uaaa-aaaaa-qaaca-cai&id=be2us-64aaa-aaaaa-qaabq-cai'
});

if (process.env.NODE_ENV === 'development') {
  agent.fetchRootKey();
}

// Check if the agent is created successfully
if (!agent) {
  console.error("Agent creation failed");
} else {
  console.log("Agent created successfully");
}

// Create an actor with the agent and the canister's IDL
export const ledgerActor = Actor.createActor(idlFactory, {
  agent,
  canisterId,
});

// Check if the actor is created successfully
if (!ledgerActor) {
  console.error("Actor creation failed");
} else {
  console.log("Actor created successfully");
}
