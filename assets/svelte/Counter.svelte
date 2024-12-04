<script lang="ts">
    // The number prop is reactive,
    // this means if the server assigns the number, it will update in the frontend
    export let number: number;
    // live contains all exported LiveView methods available to the frontend
    export let live;

    let clientNumber = 0;

    function increase() {
        // This pushes the event over the websocket
        // The last parameter is optional. It's a callback for when the event is finished.
        // You could for example set a loading state until the event is finished if it takes a longer time.
        live.pushEvent("set_number", { number: number + 1 }, () => {});

        // Note that we actually never set the number in the frontend!
        // We ONLY push the event to the server.
        // This is the E2E reactivity in action!
        // The number will automatically be updated through the LiveView websocket
    }

    function decrease() {
        live.pushEvent("set_number", { number: number - 1 }, () => {});
    }

    function increaseClient() {
        clientNumber++;
    }

    function decreaseClient() {
        clientNumber--;
    }
</script>

<section class="flex flex-col gap-4">
    <div class="bg-neutral-100 p-4">
        <h1 class="text-2xl font-bold">Counter Server Handled</h1>
        <p>The number is {number}</p>
        <button on:click={increase}>+</button>
        <button on:click={decrease}>-</button>
    </div>

    <div class="bg-neutral-100 p-4">
        <h1 class="text-2xl font-bold">Counter Client Handled</h1>
        <p>The number is {clientNumber}</p>
        <button on:click={increaseClient}>+</button>
        <button on:click={decreaseClient}>-</button>
    </div>
</section>
