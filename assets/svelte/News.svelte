<script lang="ts">
    import type { Live } from "./types/live";
    import { Marquee } from "dynamic-marquee";
    import { onMount } from "svelte";

    type News = {
        id: number;
        body: string;
    };
    type Props = {
        news: News[];
        live: Live;
    };

    const { news, live }: Props = $props();
    let newItem = $state("");
    let marquee: Marquee;
    let marqueeEl: HTMLDivElement;
    let index = 0;
    let speed = $state(-150);

    // Run this code when the component is mounted to the DOM
    onMount(async () => {
        // Create a new Marquee instance
        marquee = new Marquee(marqueeEl, {
            rate: speed,
            startOnScreen: false,
        });

        // Add the first item to the Marquee, if there is one
        if (news.length > 0) marquee.appendItem(createItem(news[0].body));

        // Add an item to the Marquee whenever it is required
        marquee.onItemRequired(() => {
            if (news.length === 0) return;
            index += 1;
            if (index > news.length - 1) index = 0;
            return createItem(news[index].body);
        });
    });

    // Function to create a new Marquee item
    function createItem(text: string) {
        const item = document.createElement("span");
        item.classList.add("mx-8");
        item.classList.add("hover:text-black");
        item.textContent = text;
        return item;
    }

    function removeItem(id: number) {
        live.pushEvent("remove_news_item", { id: id });
    }

    function addItem() {
        if (newItem === "") return;
        if (news.length === 0) marquee.appendItem(createItem(newItem));
        live.pushEvent("add_news_item", { body: newItem });
        newItem = "";
    }

    $effect(() => {
        marquee && marquee.setRate(speed);
    });
</script>

<div class="flex flex-col w-full justify-center items-center h-[50vh]">
    <div>
        <div class="flex items-center">
            <input class="rounded" type="text" bind:value={newItem} />
            <button
                class="bg-black text-white rounded px-2 py-1"
                type="submit"
                onclick={() => addItem()}>Add Item</button
            >

            <div class="ml-4">
                <button
                    class="bg-black text-white rounded px-2 py-1 active:opacity-95"
                    onclick={() => (speed -= 20)}
                >
                    ← Faster</button
                >
                <button
                    class="bg-black text-white rounded px-2 py-1 active:opacity-95"
                    onclick={() => (speed += 20)}>Slower →</button
                >
            </div>
        </div>

        <div class="flex flex-col gap-1 mt-2">
            {#each news as item (item.id)}
                <div class="mb-1">
                    <button
                        class="bg-[#F00] px-2 py-1 rounded"
                        onclick={() => removeItem(item.id)}>Remove</button
                    >
                    {item.body}
                </div>
            {/each}
        </div>
    </div>
</div>

<div class="rounded-md overflow-hidden">
    <div
        class=" text-white font-bold text-4xl z-20 p-4 bg-gradient-to-b from-[#f00] via-[#f77] to-[#f00]"
    >
        BREAKING NEWS
    </div>
    <div
        bind:this={marqueeEl}
        class=" text-white font-bold text-xl py-2 bg-gradient-to-b from-[#f00] via-[#f77] to-[#f00]"
    ></div>
</div>
