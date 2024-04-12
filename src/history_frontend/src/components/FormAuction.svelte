<!-- <script >
//   import { backend } from '$lib/canisters';
//   import { BackendActor } from '../agent';

//   let fileId = "your-file-id-here";

//   let chunkNum = 0;
//   let myBigChunkInt = BigInt(chunkNum);
//   let chunkData;
//   let fileSize = 0;
//   let fileSizeBig = BigInt(fileSize);
//   let uploadStatus= '';

//   function handleFileChange(event) {
//     const file = event.target.files[0];    
//     if (file) {
//       chunkData = file;
//       fileSize = file.size;
//     }
//   }
//   async function readFileAsArrayBuffer(file){
//   return new Promise((resolve, reject) => {
//     const reader = new FileReader();
//     reader.onload = () => {
//       const arrayBuffer = reader.result;
//       const typedArray = new Uint8Array(arrayBuffer);
//       resolve(typedArray);
//     };
//     reader.onerror = () => reject("Failed to read file.");
//     reader.readAsArrayBuffer(file);
//   });
// }

//   const encodeArrayBuffer = (file) =>
//   Array.from(new Uint8Array(file));

//   async function putFileChunks() {
//     // console.log(chunkData);
    
//     if (!chunkData) {
//       uploadStatus = 'No data to upload';
//       return;
//     }

//     let buffer;
//     try {
//       buffer = await readFileAsArrayBuffer(chunkData);
//     } catch (error) {
//       console.error('Error reading file:', error);
//       uploadStatus = 'Failed to read file';
//       return;
//     }

//     if (!buffer) {
//       uploadStatus = 'Buffer is empty or could not be read';
//       return;
//     }
//     try {
//       const ba = await BackendActor.getBackendActor();
//       console.log(buffer);
      
//       await ba.putFileChunks(fileId, myBigChunkInt, fileSizeBig, buffer).catch(console.error);
//       uploadStatus = 'Upload successful!';
//     } catch (error) {
//       console.error('Error uploading file chunks:', error);
//       uploadStatus = 'Upload failed!';
//     }
//   }
import { BackendActor }  from '../agent';

const MAX_CHUNK_SIZE = 1024 * 500;

let file;

const getFileExtension = (type) => {
  switch(type) {
    case 'image/jpeg':
      return { 'jpeg' : null };
    case 'image/gif':
      return { 'gif' : null };
    case 'image/jpg':
      return { 'jpg' : null };
    case 'image/png':
      return { 'png' : null };          
    case 'image/svg':
      return { 'svg' : null };          
    case 'video/avi':
      return { 'avi' : null };                            
    case 'video/aac':
      return { 'aac' : null };
    case 'video/mp4':
      return { 'mp4' : null };        
    case 'audio/wav':
      return { 'wav' : null };                         
    case 'audio/mp3':
      return { 'mp3' : null };
    default :
    return null;
  }
};
const b64toBlob = (b64Data, contentType='', sliceSize=512) => {
      
  const byteCharacters = atob(b64Data);
  const byteArrays = [];

  for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) {
    const slice = byteCharacters.slice(offset, offset + sliceSize);

    const byteNumbers = new Array(slice.length);
    for (let i = 0; i < slice.length; i++) {
      byteNumbers[i] = slice.charCodeAt(i);
    }

    const byteArray = new Uint8Array(byteNumbers);
    byteArrays.push(byteArray);
  }
  const blob = new Blob(byteArrays, { type: contentType } );
  return blob;
}

const handleChange = (event) => {
  const file = event.target.files[0];
  // Make new FileReader
  const reader = new FileReader();
  // Convert the file to base64 text
  reader.readAsDataURL(file);
  reader.onloadend = () => {
    if (reader.result === null) {
      throw new Error('file empty...');
    }
    let encoded = reader.result.toString().replace(/^data:(.*,)?/, '');
    if ((encoded.length % 4) > 0) {
      encoded += '='.repeat(4 - (encoded.length % 4));
    }
    const blob = b64toBlob(encoded, file.type);
    const fileInfo = {
      name: file.name,
      type: file.type,
      size: file.size,
      blob: blob,
      file: file,
      width: file.width,
      height: file.height
    };
  };
};

  const encodeArrayBuffer = (file)=>
  Array.from(new Uint8Array(file));

  const processAndUploadChunk = async (
    blob,
    byteStart,
    fileId,
    chunk,
    fileSize,
  )  => {
    const blobSlice = blob.slice(
      byteStart,
      Math.min(Number(fileSize), byteStart + MAX_CHUNK_SIZE),
      blob.type
    );
    
    const bsf = await blobSlice.arrayBuffer();
    const ba = await BackendActor.getBackendActor();
    // console.log(fileId);
    // console.log(chunk);
    // console.log(fileSize);
    // console.log(encodeArrayBuffer(bsf));
    return ba.putFileChunks(fileId, BigInt(chunk), BigInt(fileSize), encodeArrayBuffer(bsf));
  }

  const handleUpload = async (event) => {
    event.preventDefault();
    const fileExtension = getFileExtension(file);
    console.log(fileExtension);
    const errors = [];
    if (file === null || file === undefined || fileExtension === null) {
      errors.push("File not valid!");
    }
    if (file.size > 10550000) {
      errors.push("File size shouldn't be bigger than 10mb");
    }

    if (errors.length > 0) {
      setErrros(errors);
      return;
    }
    const t0 = performance.now();
    console.log('upload started...');
    setUploading(true);
    const fileInfo = {
      name: Math.random().toString(36).substring(2),
      createdAt: BigInt(Number(Date.now() * 1000)),
      size: BigInt(file.size),
      chunkCount: BigInt(Number(Math.ceil(file.size / MAX_CHUNK_SIZE))),
      // @ts-ignore
      extension: fileExtension,
    };
    const ba = await BackendActor.getBackendActor();
    // const authenticated = await authClient.isAuthenticated();
    // console.log(authenticated);
    const fileId = (await ba.putFileInfo(fileInfo))[0];
    // console.log(fileId);
    const blob = file.blob;
    const putChunkPromises = [];
    let chunk = 1;
    for (let byteStart = 0; byteStart < blob.size; byteStart += MAX_CHUNK_SIZE, chunk++ ) {
      putChunkPromises.push(
        processAndUploadChunk(blob, byteStart, fileId, chunk, file.size)
      );
    }
    await Promise.all(putChunkPromises);
    await ba.updateStatus();
    const t1 = performance.now();
    console.log("Upload took " + (t1 - t0) / 1000 + " seconds.")
  }
</script> -->

<!-- <main class="p-4 mt-9 border-t border-solid border-white border-b border-solid border-white">
  <h1>Create story</h1>
  <form class="flex align-baseline">

    <div class=" lg:flex flex-space-between items-center gap-10 sm:column">
      <div>
        <label for="bill" class="block mb-2 text-m font-medium text-gray-900 dark:text-white">your bill</label>
        <input id="bill" type="number" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl w-full"/>
      </div>
      <div>
        <p>Current top bill: 300</p>
      </div>
    </div>

    <div>
      <label for="files" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl">Select Txt File</label>
      <input id="files" type="file" style="visibility:hidden;" on:change={handleFileChange} accept=".txt"> 
      <input id="files" type="file"  on:change={handleChange}>

    </div>
    <button class="pt-3 pr-10 pb-3 pl-10 border border-solid border-white rounded-3xl" on:click={handleUpload}>Submit</button>

  </form>
</main> -->

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
      name: Math.random().toString(36).substring(2),
      createdAt: BigInt(Date.now() * 1000),
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
</script>

<input type="file" on:change="{handleChange}">
<button class="pt-3 pr-10 pb-3 pl-10 border border-solid border-white rounded-3xl" on:click="{handleUpload}" disabled={!ready || uploading}>Upload File</button>
<p>{fileData}</p>
{#if uploading}
  <p>Uploading...</p>
{/if}

<!-- <style>
  form{
    display: flex;
    flex-direction: column;
    gap: 30px;
    margin: auto;
    max-width: 600px;
  }
</style> -->