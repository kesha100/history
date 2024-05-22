<script lang="ts">
    import "../index.scss";
    import { Accordion } from "bits-ui";
    import { slide } from "svelte/transition";
    import { writable } from 'svelte/store';
    import down from '../assets/down.svg';
    import up from '../assets/up.svg'
   
    const items = [
      {
        title: "What is the History DAO and why are we making it?",
        text_content: [
          {
            title_content: "",
            content: "History is made all around us by all people throughout the world and in real time.  Having been written by a select few individuals over the ages, we’ve inherited a historical legacy that is truly wonderful, but at the same time narrow in its breadth.  With the advent of the internet we’ve entered a new age where the average person has the ability to digitally express their perspectives as they see them, and this has truly revolutionized humanity with the modern internet that we have today.  However one glaring problem still remained, and remains throughout the internet, and that is the same problem that plagued us when the Library of Alexandria was burned down, or the pyramid of Giza was defaced.  These, and many other historical events all share a very familiar narrative to one that we see often in the modern world.  That problem is censorship. The fact that the databases where all of the current internet is hosted can simply be destroyed one day, or the files deleted, or rewritten tells us that even a book is a better store of historical data than the current internet."
          },
          {
            title_content: "",
            content: "That is until along came the Internet Computer (IC) and made it possible to host information cryptographically on the blockchain permanently.  Having over 1400 nodes presently to secure all information on the network, it would take nothing short of nuclear armageddon for the IC database to be taken down, tampered, or hacked.  This technological breakthrough and our passion for history is why we decided to create History DAO, a Decentralized Autonomous Organization where we can collectively write history, every day, and permanently store it on a guaranteed tamperproof data cloud of the IC.  The purpose of this project will be to create as broad of a team of passionate historians as possible and attempt to collectively create a means to write history that’s available to all, and will be available for 100s of years to come.  Hopefully, we can make the DAO system go far above and beyond the current peer review process that we have in academia today, and utilize some of the revolutionary technology that we have today on the IC to change our approach to how we record history itself."
          },
          {
            title_content: "",
            content: "It’s worth noting that this project is not about making money, nor will it ever be.  It is about preserving the history that we have today in as truthful a manner as possible, so that the future of humanity has real information from which it can draw real conclusions, and hopefully avoid some of the issues that we face today due to gross censorship.  For this reason, all academic DAO participants will be able to take a picture of their PhD., M.S., or B.S., upload it to the DAO, and receive History DAO tokens, which would give such individuals the ability to submit proposals, vote on other proposals, and guide the direction that the DAO takes.  To this end, 20% of the total DAO tokens will be allotted to historians and be airdropped to their NNS wallets free of charge.  10% will be allotted to the dev team, and 70% will go to anyone who invests into the DAO when we launch on the IC launchpad."
          },
          {
            title_content: "",
            content: "The finances of the DAO will be simple and solely for the purpose of paying for hosting the on-chain data of History DAO.  To host data on the IC the DAO would need to buy ICP and spend it to pay for this on chain data.  It’s an automated process that wouldn’t be really expensive at all, considering that for now all data will be text-only.  This can be upgraded to include video, NFT, and other file types down the line if the DAO raises enough money from its daily auctions.  The daily auctions are the backbone of the DAO, and will be used to pay for hosting data on chain, with any left over money from the auctions being distributed to DAO holders weekly.  Each day will be auctioned via the History DAO website, with the person who bid the most being able to upload whatever text files they wish.  It’s important to note that there will be no censorship of any content, nor will there be moderation of text content.  Yes some information may be not to everyone's liking, some information may even be offensive to some, but in the pursuit of establishing a record of real history, anyone should be able to upload their own message in the manner that they deem fit."
          },
          {
            title_content: "",
            content: "For now this concept of the History DAO and how it will work is just how we (devs) see it, and how we think it should run.  However, a DAO is all about giving control over to the organization and making it autonomous, so it is very likely that others will come along and help shape History DAO and make it what it needs to be for the sake of history.  For this reason, please join our official telegram (link) for now as we develop the site further, and let's exchange ideas, get to know one another, and develop the DAO together."
          },
        ]
      },
      {
        title: "FAQ",
        text_content: [
          {
            title_content: "What is a DAO? ",
            content: "DAO stands for Decentralized Autonomous Organization, in which the voice of each member is represented by the DAO tokens that they hold.  This is similar in structure to a corporation that has no board of directors or CEO, and instead each shareholder can submit proposals that the other shareholders can review and vote on directly.  In short its a cryptographically bound community of people who believe in the mission of the DAO and independently yet collaboratively work together to develop the DAO.   DAO’s are a product of the emergence of blockchain technology such as the Internet Computer Protocol (ICP) and have already been utilized to build decentralized science, finance, and art organizations."
          },
          {
            title_content: "What is ICP?",
            content: `ICP is a cutting edge blockchain technology that is leaps and bounds ahead of competitors.  For instance a Ethereum smart contract can be 24 KB in size, whereas an ICP canister can be 400 GB  More information can be found on <a style="color: yellow;" href='https://nns.ic0.app/'>https://nns.ic0.app/</a>`,
          },
          {
            title_content: "How do I purchase History DAO tokens?",
            content: "The first thing that one needs to purchase History DAO tokens (or other ICP ecosystem tokens) is ICP itself.  The easiest means of purchasing it is off of any crypto exchange such as Coinbase or Binance. Once you have some ICP you will need to transfer it off of the exchange to a wallet that you own such as Plug, Bitfinity, Stoic.  Once that is done simply go to a decentralized exchange such as ICPswap or Sonic.  Connect your wallet.  Select exchange ICP History DAO tokens, and confirm.  Congratulations, you’re a HIstory DAO token holder! "
          },
          {
            title_content: "How do I earn more History DAO tokens and participate in the DAO?",
            content: "You need to send the History DAO tokens to the NNS and stake them.  Staked History DAO tokens will generate more History DAO tokens, which can be disbursed, staked, or simply held."
          },
          {
            title_content: "How do I participate in History DAO’s decision making process?",
            content: "Once you have staked your History DAO tokens, you will be able to vote on proposals that other DAO holders submit.  In order to incentivize participation, those who vote will receive a higher % annual yield from their staked History DAO  tokens."
          },
          {
            title_content: "How does History DAO pay for long term hosting of data on chain?",
            content: "Despite being cheaper than Amazon Web Services in terms of data hosting, IC data storage still has a cost.  To guarantee that all data uploaded to the IC by those who win daily auctions and for that data to stay on chain forever we have a 2-fold income structure for History DAO. First the money from the auctions itself.  As we start from a small community of historians and more and more interesting history is uploaded to the IC by History DAO, we will grow, hopefully slowly getting better auction results as time goes on.  Secondly we will stake all of the ICP that is collected when the DAO launches into 8 year non-dissolving neurons and utilize those rewards to make sure that the cycles needed for data hosting are topped off, and the remainder will get disbursed to all History DAO holders. "
          },
          {
            title_content: "How often will History DAO holders receive ICP? ",
            content: "Once a month.  All of the ICP gathered by the DAO from the daily auctions will be pooled together with the ICP generated by the NNS and will be evenly distributed to all History DAO token holders."
          },
          {
            title_content: "How do I participate in the auction to upload my historical information for a given day?",
            content: "The first thing you would need to do is connect your Plug, Bitfinity, or Stoic wallet to the site, and then submit your bid.  Bidding will end at 13:00 UTC, and the historical text uploaded by the top bid will be previewed in the following days front page of the DAO for all to see. "
          },
          {
            title_content: "How do I view previously uploaded history?",
            content: "In the “History tab” simply select the tab that you wish to upload."
          },
          {
            title_content: "What do I need to do to earn rewards from the auctions and vested ICP?",
            content: `Nothing at all. By simply keeping your History DAO tokens within the Network Nervous System, you will receive your monthly share of the ICP that History DAO earns. Visit <a style="color: yellow;" href='https://nns.ic0.app/'>https://nns.ic0.app/</a> for more information.`
          },
          {
            title_content: "How do I connect with other History DAO holders?",
            content: "Telegram (icon/hyperlink) X (icon/hyperlink), Openchat (icon/hyperlink) "
          },
          {
            title_content: "Why should I connect with other History DAO holders?",
            content: "It cannot be stressed enough how important everyone's individual voice is.  By collectively thinking, debating, and guiding progress of the DAO we can ensure that we develop History DAO into something that will truly last for many ages and hopefully one day be a vast repository of knowledge that grows daily.  "
          },
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

    let change = writable(false);
  </script>

{#each items as item, i}
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
            <!-- <img src={$change ? up : down} alt="toggle" /> -->
          </span>
          </Accordion.Trigger>
        </Accordion.Header>
        {#each item.text_content as content, i}
        <Accordion.Content
          transition={slide}
          transitionConfig={{ duration: 200 }}
          class="pb-[25px] text-sm tracking-[-0.01em]"
        >
        
          <h2 class="text-lg font-bold" >{content.title_content}</h2>
          <p class="">
            {@html content.content} 
          </p>
          <br/>
        </Accordion.Content>
        {/each}
      </Accordion.Item>
  </Accordion.Root>
  {/each}