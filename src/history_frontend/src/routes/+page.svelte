<script lang="ts">
  import AccordionMain from "../components/AccordionMain.svelte";
  import "../index.scss";
</script>

<main>
  <h1>About the DAO</h1>
    <div class="mt-[30px]">
        <div class="roadmap-phase" data-phase="1">
          <div class="roadmap-phase-inside1">
            <h2 class="text-2xl font-bold mb-2">Phase 1</h2>
            <p class="text-gray-300 text-right" id="class">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.</p>
            <p class="text-blue-400 mt-2">October 2023</p>
          </div>
          <p class="self-center w-[50%] text-center" id="text">1</p>
        </div>
        <div class="roadmap-phase2" data-phase="2">
          <p class="self-center w-[50%] text-center" id="text">2</p>
          <div class="roadmap-phase-inside">
            <h2 class="text-2xl font-bold mb-2">Phase 2</h2>
            <p class="text-gray-300">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.</p>
            <p class="text-blue-400 mt-2">October 2024</p>
          </div>
        </div>
        <div class="roadmap-phase" data-phase="3">
          <div class="roadmap-phase-inside1">
            <h2 class="text-2xl font-bold mb-2">Phase 3</h2>
            <p class="text-gray-300">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.</p>
            <p class="text-blue-400 mt-2">October 2025</p>
          </div>
          <p class="self-center w-[50%] text-center" id="text">3</p>
        </div>
        <div class="roadmap-phase2" data-phase="4">
          <p class="self-center w-[50%] text-center" id="text">4</p>
          <div class="roadmap-phase-inside">
            <h2 class="text-2xl font-bold mb-2">Phase 4</h2>
            <p class="text-gray-300">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.</p>
            <p class="text-blue-400 mt-2">October 2026</p>
          </div>
        </div>
    </div>

    <AccordionMain/>
</main>

<style>
  h1{
    font-weight: bold;
    font-size: 40px;
  }
  main{
    color: aliceblue;
  }
  .roadmap-phase{
    width: 100%;
    display: flex;
  }
  .roadmap-phase-inside1{
    width: 50%;
    border: 1px solid rgb(33, 100, 181);
    border-radius: 100px 0px 0px 100px;
    padding: 30px;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
  }
  .roadmap-phase2{
    width: 100%;
    display: flex;
    justify-content: flex-end;
  }
  .roadmap-phase-inside{
    width: 50%;
    display: flex;
    flex-direction: column;
    border: 1px solid rgb(33, 100, 181);
    border-radius: 0px 100px 100px 0px;
    padding: 30px;
  }
  #text{
    font-size: 30px;
  }
</style>