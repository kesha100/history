<script>
  import AccordionHistory from "../../components/AccordionHistory.svelte";
  import { onMount } from 'svelte';
  import { backend } from "$lib/canisters";
  import { writable } from 'svelte/store';
  import searchIcon from '../../assets/searIcon.png'

  let isLoading = writable(false);
  let files = [];
  let filteredData = writable([]);
  let search = "";

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

    filteredData.set(files);
    console.log($filteredData);
  });
  
  const searchData = async () => {
    const filtered = files.filter(book => {
      let createdAtMs = Number(book.createdAt / 1000000n);
        let datee = new Date(createdAtMs);
        let formattedDate = datee.toLocaleDateString('en-US', {
          year: 'numeric',
          month: 'long',
          day: 'numeric'
        });
      let bookTitle = formattedDate.toLowerCase();
      return bookTitle.includes(search.toLowerCase());
    });
    filteredData.set(filtered);
  };

  </script>
  <main>
    <h1>Past History</h1>
    <div class="flex justify-between items-center">
      <h2>FILTER</h2>

      <div class="flex">
        <input id="bill" placeholder="Search Date (May 20, 2020)" bind:value={search} on:input={searchData} type="text" class="bg-[#C2BE2B] p-4 rounded-2xl w-[300px]"/>
        <button class="ml-5"><img src={searchIcon} alt="..."/></button>
      </div>
    </div>
    {#if $isLoading === true}
      <p>Loading...</p>
    {:else}
      
      {#if $filteredData.length > 0}
      <div class="mt-[20px] flex gap-6 flex-wrap">
        {#each $filteredData as item, i}
          <AccordionHistory item={item} i={i}/>
        {/each}
      </div>
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