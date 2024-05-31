<script>
    import logoImg from '../assets/logo.png'
    import { writable } from 'svelte/store';
    let menuOpen = writable(false);
</script>

<header class="fixed bg-[#09209d40] backdrop-blur-md p-8 w-full top-0 right-0">
    <nav>
        <div class="flex flex-wrap justify-between items-center mx-auto max-w-screen-xl">
            <img src={logoImg} alt="logo" width="200px"/>
            <div class="flex items-center lg:order-2">
                <button on:click={() => menuOpen.update(n => !n)} data-collapse-toggle="mobile-menu-2" type="button" class="inline-flex items-center p-2 ml-1 text-sm text-gray-500 rounded-lg lg:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" id="mobile-menu-2" aria-expanded="false">
                    <span class="sr-only">Open main menu</span>
                    <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
                    <svg class="hidden w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                </button>
            </div>
            <div class="hidden lg:block">
                <ul class="flex flex-col mt-4 font-medium lg:flex-row lg:space-x-8 lg:mt-0">
                    <li>
                        <a href="/" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">About the DAO</a>
                    </li>
                    <li>
                        <a href="/auction" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">Block Record Auction</a>
                    </li>
                    <li>
                        <a href="/today" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">Today's Information</a>
                    </li>
                    <li>
                        <a href="/history" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">Past Record</a>
                    </li>
                </ul>
            </div>
            <div class="{$menuOpen ? 'flex' : 'hidden'} justify-between items-center w-full lg:w-auto lg:order-1" id="mobile-menu-2">
                <ul class="flex flex-col mt-4 font-medium lg:flex-row lg:space-x-8 lg:mt-0">
                    <li>
                        <a on:click={() => menuOpen.update(n => !n)} href="/" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">About</a>
                    </li>
                    <li>
                        <a on:click={() => menuOpen.update(n => !n)} href="/auction" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">Auction</a>
                    </li>
                    <li>
                        <a on:click={() => menuOpen.update(n => !n)} href="/today" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">Today</a>
                    </li>
                    <li>
                        <a on:click={() => menuOpen.update(n => !n)} href="/history" class="block py-2 pr-4 pl-3 text-white bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" aria-current="page">History</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>