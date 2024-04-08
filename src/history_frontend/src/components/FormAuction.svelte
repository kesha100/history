<script lang="ts">
  import { Button } from "bits-ui";
</script>

<main class="p-4 mt-9 border-t border-solid border-white border-b border-solid border-white">
  <h1>Create story</h1>
  <form class="flex align-baseline">

    <div class=" lg:flex flex-space-between items-center gap-10 sm:column">
      <div>
        <label for="bill" class="block mb-2 text-m font-medium text-gray-900 dark:text-white">your bill</label>
        <input id="bill" type="number" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl w-full"/>
      </div>
      <div>
        <p>Current top bill: 300</p>
      </div>
    </div>

    <div>
      <label for="files" class="bg-blue-500 bg-opacity-50 p-4 rounded-2xl">Select Txt File</label>
      <input id="files" type="file" style="visibility:hidden;" accept=".txt">
    </div>
    <button class="pt-3 pr-10 pb-3 pl-10 border border-solid border-white rounded-3xl">Submit</button>

  </form>
</main>

<style>
  form{
    display: flex;
    flex-direction: column;
    gap: 30px;
    margin: auto;
    max-width: 600px;
  }
</style>