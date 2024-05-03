<script>
  import { backend } from "$lib/canisters";

  let startingBid = 0;
  let fileData = '';
  let fileContent = null;
  let uploading = false;

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
      return;
    }
    try {
      uploading = false;
      const item = {
        bid: startingBid, 
        content: fileContent, 
      };
      const response = await backend.newAuction(item);
    } catch (error) {
      uploading = false;
      console.error("Error in creating a new auction:", error);
    }
  }
  let data;

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
      <!-- <label for="files" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl">Select Txt File</label>
      <textarea id="files" type="file" style="visibility:hidden;"></textarea> -->
      <input id="files" type="file" on:change={handleFileChange}>

    </div>
    <p>{fileData}</p>
    <button type="submit" class="pt-3 pr-10 pb-3 pl-10 border border-solid border-white rounded-3xl">Submit</button>

  </form>
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