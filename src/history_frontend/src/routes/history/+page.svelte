<script>
  import AccordionHistory from "../../components/AccordionHistory.svelte";
  import { onMount } from 'svelte';
  import { backend } from "$lib/canisters";
  import { writable } from 'svelte/store';
  
  let files = [];
  let isLoading = writable(true);

  onMount(async () => {
    const overviewList = await backend.getOverviewList();
    let newFiles = [];

    for (const item of overviewList) {
      const file = await backend.decodeBlobToText(item?.item?.content);
      let filedata = {
        file: file, // 'file' is the key, and `file` (variable) is the value
        createdAt: item?.createdAt 
      }
      newFiles.push(filedata);
    }

    files = newFiles;
    isLoading.set(false);
  });

  </script>
  <main>
    <h1>Past History</h1>
    {#if $isLoading}
    <p>Loading...</p>
    {:else}
      
      {#each files as item, i}
        <AccordionHistory item={item} i={i}/>
      {/each}
    {/if}
  </main>

<style>
  main{
    color: aliceblue;
  }
</style>