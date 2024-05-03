<script>
  import AccordionHistory from "../../components/AccordionHistory.svelte";
  import { onMount } from 'svelte';
  import { backend } from "$lib/canisters";
  import { writable } from 'svelte/store';
  let items = [
    {
      title: "March 2024",
      text_content: [
        {
          title_content: "Fears for Gazans as aid groups halt work over deadly Israeli strike",
          content: `Many Palestinians in the Gaza Strip will be wondering how they are going to feed their families after World Central Kitchen (WCK) paused its operations in response to the killing of seven of its aid workers in an Israeli air strike.
          <br/> Another US charity it works with, Anera, has also suspended work because of the escalating risks faced by its local staff and their families. 
          <br/> Together, they were serving two million meals a week across the Palestinian territory, where the UN has warned that an estimated 1.1 million people - half the population - are facing catastrophic hunger because of Israeli restrictions on aid deliveries, the ongoing hostilities and the breakdown of order.`
        },
        {
          title_content: "Fears for Gazans as aid groups halt work over deadly Israeli strike",
          content: `Many Palestinians in the Gaza Strip will be wondering how they are going to feed their families after World Central Kitchen (WCK) paused its operations in response to the killing of seven of its aid workers in an Israeli air strike.
          <br/> Another US charity it works with, Anera, has also suspended work because of the escalating risks faced by its local staff and their families. 
          <br/> Together, they were serving two million meals a week across the Palestinian territory, where the UN has warned that an estimated 1.1 million people - half the population - are facing catastrophic hunger because of Israeli restrictions on aid deliveries, the ongoing hostilities and the breakdown of order.`
        },
        {
          title_content: "Fears for Gazans as aid groups halt work over deadly Israeli strike",
          content: `Many Palestinians in the Gaza Strip will be wondering how they are going to feed their families after World Central Kitchen (WCK) paused its operations in response to the killing of seven of its aid workers in an Israeli air strike.
          <br/> Another US charity it works with, Anera, has also suspended work because of the escalating risks faced by its local staff and their families. 
          <br/> Together, they were serving two million meals a week across the Palestinian territory, where the UN has warned that an estimated 1.1 million people - half the population - are facing catastrophic hunger because of Israeli restrictions on aid deliveries, the ongoing hostilities and the breakdown of order.`
        },
        {
          title_content: "",
          content: ``
        },
      ]
    },
  {
      title: "February 2024",
      text_content: [
          {
              title_content: "Russia’s neighbours urge Nato allies to bring back military service",
              content: `Rain drips down the glasses of new recruit Toivo Saabas, tracing the contours of the green and black face paint that completes his camouflage.
              <br/> Lying on the saturated ground, and peering through the sight of his gun, the only frailty that threatens to give away his position is the plume of air he breathes out silently into the icy Estonian forest.
              <br/> Then comes the deafening call to attack.
              <br/> The 25-year-old springs to his feet. Forming a line with his brothers in arms, he bounds through the trees towards the Russian border.`
          },
      ]
    },
    {
      title: "January 2024",
      text_content: [
          
      ]
    },
    {
      title: "December 2023",
      text_content: [
          
      ]
    },
    // {
    //   title: "What is the History DAO and why are we making it?",
    //   text_content: [
    //     {
    //       title_content: "",
    //       content: "History is made all around us by all people throughout the world and in real time.  Having been written by a select few individuals over the ages, we’ve inherited a historical legacy that is truly wonderful, but at the same time narrow in its breadth.  With the advent of the internet we’ve entered a new age where the average person has the ability to digitally express their perspectives as they see them, and this has truly revolutionized humanity with the modern internet that we have today.  However one glaring problem still remained, and remains throughout the internet, and that is the same problem that plagued us when the Library of Alexandria was burned down, or the pyramid of Giza was defaced.  These, and many other historical events all share a very familiar narrative to one that we see often in the modern world.  That problem is censorship. The fact that the databases where all of the current internet is hosted can simply be destroyed one day, or the files deleted, or rewritten tells us that even a book is a better store of historical data than the current internet."
    //     }
    //   ]
    // }
  ];
  let files = writable([]);

  onMount(async () => {
    const overviewList = await backend.getOverviewList();
    let newFiles = [];

    for (const item of overviewList) {
      const file = await backend.decodeBlobToText(item?.item?.content);
      newFiles.push(file);
    }
    files.set(newFiles);
    return {
      status: 200,
      body: { overviewList }
    };
  });

</script>
<main>
  <h1>Past History</h1>
  <AccordionHistory file={$files}/>
</main>

<style>
    main{
      color: aliceblue;
    }
</style>