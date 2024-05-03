<script>
  import { backend } from "$lib/canisters";

  let startingBid = 0;
  let fileData = '';
  let fileContent = null;
  let uploading = false;
  let alertGreen = false;

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

</script>

<main class="p-4 mt-9 border-t border-solid border-white border-b border-solid border-white">
  <h1>Create story</h1>
  <form class="flex align-baseline" on:submit|preventDefault={createNewAuction}>

    <div class=" lg:flex flex-space-between items-center gap-10 sm:column">
      <div>
        <label for="bill" class="block mb-2 text-m font-medium text-gray-900 dark:text-white">your bid</label>
        <input id="bill" bind:value={startingBid} type="number" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl w-full"/>
      </div>
      <div>
        <p>Current top bid: 300</p>
      </div>
    </div>

    <div>
      <label for="files" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl">Select Txt File</label>
      <input id="files" type="file" style="visibility:hidden;" on:change={handleFileChange}>

    </div>
    <p>{fileData}</p>
    <button type="submit" class="pt-3 pr-10 pb-3 pl-10 border border-solid border-white rounded-3xl">Submit</button>

  </form>
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