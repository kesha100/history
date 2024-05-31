import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory } from '../../declarations/icp_ledger_canister/icp_ledger_canister.did';


const canisterId = "ryjl3-tyaaa-aaaaa-aaaba-cai";
// Create an HTTP agent
const agent = new HttpAgent({ host: 'https://ic0.app' });

// Create an actor with the agent and the canister's IDL
const ledgerActor = Actor.createActor(idlFactory, {
    agent,
    canisterId,
});

export async function getAccountBalance(accountIdentifier: Uint8Array) {
    try {
      const balance = await ledgerActor.account_balance({ account: accountIdentifier });
      return balance;
    } catch (error) {
      console.error('Error fetching account balance:', error);
      throw error;
    }
  }