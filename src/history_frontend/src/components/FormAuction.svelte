<script lang="ts">
  import { Button } from "bits-ui";

  let input = '';
	let disabled = false;
	let greeting = '';

	// const handleOnSubmit = async () => {
	// 	disabled = true;

	// 	try {
	// 		// Canister IDs are automatically expanded to .env config - see vite.config.ts
	// 		const canisterId = import.meta.env.VITE_BACKEND_CANISTER_ID;

	// 		// We pass the host instead of using a proxy to support NodeJS >= v17 (ViteJS issue: https://github.com/vitejs/vite/issues/4794)
	// 		const host = import.meta.env.VITE_HOST;

	// 		// Create an actor to interact with the IC for a particular canister ID
	// 		const actor = createActor(canisterId, { agentOptions: { host } });

	// 		// Call the IC
	// 		greeting = await actor.greet(input);
	// 	} catch (err: unknown) {
	// 		console.error(err);
	// 	}

	// 	disabled = false;
	// };
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