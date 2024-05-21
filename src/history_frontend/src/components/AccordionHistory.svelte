<script>
  import "../index.scss";
  import { Accordion } from "bits-ui";
  import { slide } from "svelte/transition";
  import { writable } from 'svelte/store';
  import down from '../assets/down.svg';
  import up from '../assets/up.svg';

  let change = writable(false);
  export let item;
  export let i;

  let createdAtMs = Number(item?.createdAt / 1000000n);

  let date = new Date(createdAtMs);
  let formattedDate = date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

</script>

<Accordion.Root class="w-full sm:max-w-[70%] mx-auto" multiple>
    <Accordion.Item value="${i}" class="group border-b border-dark-10 px-1.5">
      <Accordion.Header>
        <Accordion.Trigger
          on:click={() => change.update(n => !n)} 
          class="flex w-full flex-1 items-center justify-between py-5 text-[15px] font-medium transition-all [&[data-state=open]>span>svg]:rotate-180 "
        >
          {formattedDate}
          <span
            class="inline-flex size-8 items-center justify-center rounded-[7px] bg-transparent transition-all hover:bg-dark-10 lg"
          >
            <img src={$change ? up : down} alt="toggle" />
          </span>
        </Accordion.Trigger>
      </Accordion.Header>
      {#if item.length === 0}
        <Accordion.Content class="pb-[25px] text-sm tracking-[-0.01em]">
          There is no history.
        </Accordion.Content>
      {:else}
      
        <Accordion.Content transition={slide} transitionConfig={{ duration: 200 }} class="pb-[25px] text-m tracking-[-0.01em]">
          <pre class="whitespace-pre-wrap">{item?.file}</pre>
        </Accordion.Content>
      {/if}
    </Accordion.Item>
</Accordion.Root>
