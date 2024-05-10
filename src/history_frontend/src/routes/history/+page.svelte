<script>
  import AccordionHistory from "../../components/AccordionHistory.svelte";
  import { onMount } from 'svelte';
  import { backend } from "$lib/canisters";
  import { writable } from 'svelte/store';
  import searchIcon from '../../assets/searIcon.png'

  let files = [];
  let isLoading = writable(false);
  let search = ''

  onMount(async () => {
    try {
      const overviewList = await backend.getOverviewList();
      let newFiles = [];

      for (const item of overviewList) {
        const file = await backend.decodeBlobToText(item?.item?.content);
        let filedata = {
          file: file,
          createdAt: item?.createdAt 
        }
        newFiles.push(filedata);
      }

      files = newFiles;
      isLoading.set(true);
    } catch (error) {
      console.log(error);
      isLoading.set(false);
    }
    isLoading.set(false);
  });

  </script>
  <main>
    <h1>Past History</h1>
    <div class="flex justify-around items-center">
      <h2>FILTER</h2>

      <div class="flex">
        <input id="bill" placeholder="Search Date (May 20, 2020)" bind:value={search} type="text" class="bg-[#C2BE2B] p-4 rounded-2xl w-[300px]"/>
        <button class="ml-5"><img src={searchIcon} alt="..."/></button>
      </div>
    </div>
    {#if $isLoading === true}
    <p>Loading...</p>
    {:else}
      
      {#if files.length > 0}
        {#each files as item, i}
          <AccordionHistory item={item} i={i}/>
        {/each}
      {:else}
        <p>No past history available.</p>
      {/if}

    {/if}
  </main>

<style>
  main{
    color: aliceblue;
  }
  ::placeholder {
    color: aliceblue; /* Adjust the color as needed */
    font-style: italic; /* Adjust other styles as needed */
  }
</style>