<script>
  import "../index.scss";
  import { Accordion } from "bits-ui";
  import { slide } from "svelte/transition";
  import { writable } from 'svelte/store';
  import down from '../assets/down.svg';
  import up from '../assets/up.svg'

  let change = writable(false);
  export let file;
  $: parsedFile = file ? file : [];
  // let file = [1,2,3]
  console.log(file);
</script>

  <Accordion.Root class="w-full sm:max-w-[70%] mx-auto" multiple>
      <Accordion.Item class="group border-b border-dark-10 px-1.5">
        <Accordion.Header>
          <Accordion.Trigger
            on:click={() => change.update(n => !n)} 
            class="flex w-full flex-1 items-center justify-between py-5 text-[15px] font-medium transition-all [&[data-state=open]>span>svg]:rotate-180 "
          >
            March 2024
            <span
              class="inline-flex size-8 items-center justify-center rounded-[7px] bg-transparent transition-all hover:bg-dark-10 lg"
            >
                <img src={$change ? up : down} alt="toggle" />
            </span>
          </Accordion.Trigger>
        </Accordion.Header>
        {#if parsedFile.length === 0}
          <Accordion.Content class="pb-[25px] text-sm tracking-[-0.01em]">
            There is no history.
          </Accordion.Content>
        {:else}
          {#each parsedFile[0] as content}
            <Accordion.Content transition={slide} transitionConfig={{ duration: 200 }} class="pb-[25px] text-sm tracking-[-0.01em]">
              <p>{content}</p>
            </Accordion.Content>
          {/each}
        {/if}
      </Accordion.Item>
  </Accordion.Root>
