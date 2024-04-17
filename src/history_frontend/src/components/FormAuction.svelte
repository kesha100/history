<script>
  import { onMount } from 'svelte';
  import { BackendActor } from '../agent';

  const MAX_CHUNK_SIZE = 1024 * 500; // 500kb

  let fileData = 'Drag and drop a file or select add File';
  let file = {
    name: '',
    type: '',
    size: 0,
    blob: new Blob(),
    width: 0,
    height: 0
  };
  let ready = false;
  let uploading = false;
  let value = 0;
  let errors = [];

  function getFileExtension(type) {
    // Logic remains similar, directly convert switch cases to return appropriate types
    switch(type) {
      case 'image/jpeg': return { jpeg: null };
      case 'image/gif': return { gif: null };
      case 'image/png': return { png: null };
      // Add other cases as in your original function
      default: return null;
    }
  }

  function b64toBlob(b64Data, contentType='', sliceSize=512) {
    const byteCharacters = atob(b64Data);
    const byteArrays = [];

    for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) {
      const slice = byteCharacters.slice(offset, offset + sliceSize);
      const byteNumbers = new Array(slice.length).fill(null).map((_, i) => slice.charCodeAt(i));
      const byteArray = new Uint8Array(byteNumbers);
      byteArrays.push(byteArray);
    }
    return new Blob(byteArrays, { type: contentType });
  }

  async function handleUpload() {
    if (!file.blob) {
      console.error("No file selected.");
      return;
    }
    uploading = true;
    const fileInfo = {
      name: "exampleFile.txt",
      createdAt: 1024,
      size: BigInt(file.size),
      chunkCount: BigInt(Math.ceil(file.size / MAX_CHUNK_SIZE)),
      extension: getFileExtension(file.type)
    };
    try {
      const ba = await BackendActor.getBackendActor();
      console.log(fileInfo)
      const fileId = await ba.putFileInfo(fileInfo);
      console.log(fileId);
      let chunk = 1;
      for (let byteStart = 0; byteStart < file.blob.size; byteStart += MAX_CHUNK_SIZE, chunk++) {
        const blobSlice = file.blob.slice(byteStart, Math.min(file.blob.size, byteStart + MAX_CHUNK_SIZE));
        const chunkBuffer = await blobSlice.arrayBuffer();
        await ba.putFileChunks(fileId, BigInt(chunk), BigInt(file.size), Array.from(new Uint8Array(chunkBuffer)));
      }
      uploading = false;
      fileData = 'Drag and drop a file or select add File';
    } catch (error) {
      console.error('Upload failed:', error);
      uploading = false;
    }
  }

  function handleChange(event) {
    const input = event.target;
    if (input.files && input.files[0]) {
      const fileInput = input.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(fileInput);
      reader.onloadend = () => {
        let encoded = reader.result.toString().replace(/^data:(.*,)?/, '');
        if ((encoded.length % 4) > 0) {
          encoded += '='.repeat(4 - (encoded.length % 4));
        }
        const blob = b64toBlob(encoded, fileInput.type);
        file = {
          ...file,
          name: fileInput.name,
          type: fileInput.type,
          size: fileInput.size,
          blob: blob
        };
        fileData = `${fileInput.name} | ${Math.round(fileInput.size / 1000)} kB`;
        ready = true;
      };
    }
  }

  let name = '';
  let greet = '';

  // Assuming `backend` is imported or defined somewhere in your project where it can access `greet`
  import { backend } from '$lib/canisters'; // Update the path according to your project structure

  async function getGreeting() {
    if (name.trim() === '') {
      alert("Please enter a name");
      return;
    }
    try {
      const response = await backend.greet(name);
      greet = response;
    } catch (error) {
      console.error("Error in getting greeting:", error);
    }
  }
</script>

<main class="p-4 mt-9 border-t border-solid border-white border-b border-solid border-white">
  <h1>Create story</h1>
  <form class="flex align-baseline">

    <div class=" lg:flex flex-space-between items-center gap-10 sm:column">
      <div>
        <label for="bill" class="block mb-2 text-m font-medium text-gray-900 dark:text-white">your bid</label>
        <input id="bill" type="number" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl w-full"/>
      </div>
      <div>
        <p>Current top bid: 300</p>
      </div>
    </div>

    <div>
      <label for="files" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl">Select Txt File</label>
      <input id="files" type="file" style="visibility:hidden;" accept=".txt"> 
      <input id="files" type="file"  on:change="{handleChange}">

    </div>
    <p>{fileData}</p>
    <button class="pt-3 pr-10 pb-3 pl-10 border border-solid border-white rounded-3xl" on:click={handleUpload}>Submit</button>

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