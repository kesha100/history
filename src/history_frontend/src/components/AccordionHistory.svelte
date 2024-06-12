<script>
  import "../index.scss";
  import { Accordion } from "bits-ui";
  import { slide } from "svelte/transition";
  import { writable } from 'svelte/store';
  import down from '../assets/down.svg';
  import up from '../assets/up.svg';
  import { Dialog, Separator, Label } from "bits-ui";
  import { fade } from "svelte/transition";

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

<!-- <div>
  {#if item.length === 0}
    <span>
      There is no history.
    </span>
  {:else}
    <Dialog.Root>
      <Dialog.Trigger
        class="items-center backdrop-blur inset-0 w-[300px] h-[250px] flex-column justify-center rounded-[10px] bg-[white] px-[21px] text-[black] text-[15px] font-semibold text-background shadow-mini transition-colors hover:bg-dark/95 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-foreground focus-visible:ring-offset-2 focus-visible:ring-offset-background active:scale-98"
        style="overflow: filter: blur(8px); hidden; text-overflow: ellipsis;" 
        >
        <div style="height: 9em; text-align: justify; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 6; -webkit-box-orient: vertical;">
          {item?.file}
        </div>
        <br/>
        <div>Date: {formattedDate}</div>
      </Dialog.Trigger>
      <Dialog.Portal>
        <Dialog.Overlay
          transition={fade}
          transitionConfig={{ duration: 150 }}
          class="fixed inset-0 z-50 bg-black/80"
        />
        <Dialog.Content
          class="fixed left-[50%] top-[50%] z-50 w-full overflow-y-auto h-[500px] max-w-[94%] translate-x-[-50%] translate-y-[-50%] rounded-card-lg border rounded-[10px] bg-[white] p-5 shadow-popover outline-none sm:max-w-[490px] md:w-full"
        >
          <Dialog.Description class="text-m">
            <pre class="whitespace-pre-wrap">{item?.file}</pre>
          </Dialog.Description>
        </Dialog.Content>
      </Dialog.Portal>
    </Dialog.Root>
  {/if}
</div> -->
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
        {@html item?.file}
      </Accordion.Content>
    {/if}
  </Accordion.Item>
</Accordion.Root>
