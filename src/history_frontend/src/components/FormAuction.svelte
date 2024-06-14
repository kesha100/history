<script>
  import { backend } from "$lib/canisters";
  import { onMount } from 'svelte';
  import down from '../assets/down.png';
  import { ledgerActor } from "../agentledger.ts";
  import { Principal } from "@dfinity/principal";

  let startingBid = 0;
  let fileData = '';
  let fileContent = null;
  let uploading = false;
  let alertGreen = false;
  let balance;

  let bidresult = 0;

  let accountIdentifier = "qcssp-q4zmm-t4kfs-iax73-h2xcu-ccrzq-luv6f-5jl3k-xe65y-zs37e-cae";
  let accountIdentifier2 = Principal.fromText(accountIdentifier);

  async function handleFileChange(event) {
    const file = event.target.files[0];
    if (file) {
      fileContent = new Uint8Array(await file.arrayBuffer());
    }
    fileData = `${file.name} | ${Math.round(file.size / 1000)} kB`;
  }

  async function createNewAuction() {
    uploading = true;
    if (!fileContent) {
      alert("Please select a file to auction");
      uploading = false;
      return;
    }

    if (startingBid <= 0) {
      alert("Please enter a valid starting bid");
      uploading = false;
      return;
    }
    try {
      uploading = false;
      const item = {
        bid: startingBid, 
        content: fileContent, 
      };
      const response = await backend.newAuction(item);
      console.log(response);

      fileContent = null;
      startingBid = 0;
      alertGreen = true;
      fileData = '';
    } catch (error) {
      uploading = false;
      console.error("Error in creating a new auction:", error);
    }
  }

  onMount(async () => {
    const overviewList = await backend.getHighestBid();
    bidresult = Number(overviewList);
  });

  onMount(async () => {
    try {
        let decimals = await ledgerActor.archives();
        console.log('Decimals:', decimals);
    } catch (error) {
        console.error('Error fetching decimals:', error);
    }
});
async function getAccountBalance() {
  try {
    let subaccount = new Uint8Array(32);
    balance = await ledgerActor.account_identifier({ owner: accountIdentifier2, subaccount: [subaccount]});
    
    // const fin_transfer = await ledgerActor.transfer({
    //   to: balance,
    //   fee: { e8s: 10000 },
    //   memo: 12345,
    //   from_subaccount: [],
    //   created_at_time: [{ timestamp_nanos: 1622548800000000000 }],
    //   amount: {e8s:3} 
    // })
    console.log(balance);
    // console.log(fin_transfer);
  } catch (error) {
    console.error('Error fetching account balance:', error);
    throw error;
  }
}

async function getApproveResult(){
  try {
    const approveResult = await ledgerActor.icrc2_approve({
      spender: { owner: accountIdentifier2, subaccount: [] },
      amount: 4,
      from_subaccount : [],
      expected_allowance : [],
      expires_at : [],
      fee : [],
      memo : [],
      created_at_time : [],
    });
    console.log(approveResult);
  } catch (error) {
    console.log(error);
  }
}

</script>

<main class="p-4 mt-9 border-t border-solid border-white ">
  <h1>Create story</h1>
  <div class="flex justify-center mt-9 mb-9"><img src={down} alt="..."/></div>
  <p class="text-center text-2xl">Current top bid: {bidresult}</p>

  <form class="flex align-baseline border-2 border-[#C2BE2B] rounded-[20px] p-6" on:submit|preventDefault={createNewAuction}>

    <div class="flex items-center gap-10 flex-col">
      <div>
        <label for="bill" class="block mb-2 text-m font-medium text-gray-900 dark:text-white">your bid</label>
        <input id="bill" bind:value={startingBid} type="number" class="bg-[#C2BE2B] p-4 rounded-2xl w-full"/>
      </div>
      <div class="w-[200px]">
        <label for="files" class="bg-[#C2BE2B] p-4 rounded-2xl">Select Txt File</label>
        <input id="files" type="file" style="visibility:hidden;" on:change={handleFileChange}>
        <p>{fileData}</p>
      </div>
    </div>
    <button type="submit" class="pt-6 w-[200px] pr-10 pb-6 pl-10 border border-3 border-[#C2BE2B] rounded-3xl">Submit</button>
  </form>

  <button on:click={getAccountBalance}>Check Balance</button>
  <button on:click={getApproveResult}>Check Result</button>

  {#if alertGreen}
  <div class="bg-green-100 border border-green-400 text-green-900 px-9 py-3 rounded fixed bottom-9 right-9 transition-transform duration-300 transform hover:-translate-y-1" role="alert">
    <strong class="font-bold">Story created!</strong>
      <span class="absolute top-0 bottom-0 right-0 px-2 py-3">
        <svg class="fill-current h-6 w-6 text-green-800" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
      </span>
    </div>
  {/if}
</main>

{#if uploading}
  <p>Uploading...</p>
{/if}

<style>
  form{
    display: flex;
    flex-direction: column;
    gap: 30px;
    margin: auto;
    max-width: 600px;
  }
</style>