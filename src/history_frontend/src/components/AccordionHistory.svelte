<script>
    import "../index.scss";
    import { Accordion } from "bits-ui";
    import { slide } from "svelte/transition";
    import { writable } from 'svelte/store';
    import down from '../assets/down.svg';
    import up from '../assets/up.svg'

    let change = writable(false);
    export let item = [];
    export let i;
  </script>

   
  <Accordion.Root class="w-full sm:max-w-[70%] mx-auto" multiple>
      <Accordion.Item value="${i}" class="group border-b border-dark-10 px-1.5">
        <Accordion.Header>
          <Accordion.Trigger
            on:click={() => change.update(n => !n)} 
            class="flex w-full flex-1 items-center justify-between py-5 text-[15px] font-medium transition-all [&[data-state=open]>span>svg]:rotate-180 "
          >
            {item.title}
            <span
              class="inline-flex size-8 items-center justify-center rounded-[7px] bg-transparent transition-all hover:bg-dark-10 lg"
            >
                <img src={$change ? up : down} alt="toggle" />
            </span>
          </Accordion.Trigger>
        </Accordion.Header>
        {#if item.text_content.length === 0}
            <Accordion.Content class="pb-[25px] text-sm tracking-[-0.01em]">
                <p>There is not any history</p>
            </Accordion.Content>
        {:else}
        {#each item.text_content as content, i}
            <Accordion.Content transition={slide} transitionConfig={{ duration: 200 }} class="pb-[25px] text-sm tracking-[-0.01em]">
                <h2 class="text-lg font-bold">{content.title_content}</h2>
                <p>{@html content.content}</p>
                <br/>
            </Accordion.Content>
        {/each}
        {/if}
      </Accordion.Item>
  </Accordion.Root>