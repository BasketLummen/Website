---
layout: content
title: Livestream
description: Basket Lummen
keywords: Basket, Lummen, Livestream
---

## Latest livestream

<style>
    .container iframe {
        width: 100%;
        height: auto;
        aspect-ratio: 16 / 9;
        display: block;
        border: 0;
    }
</style>

<iframe 
  id="basket-lummen-player"
  width="560" 
  height="315" 
  src="" 
  title="Basket Lummen Latest Stream" 
  frameborder="0" 
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
  allowfullscreen>
</iframe>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const channelID = "UCunXn91ZnQF7Y74M-MOv8Nw";
        const rssUrl = `https://www.youtube.com/feeds/videos.xml?channel_id=${channelID}`;
        const apiUrl = `https://api.rss2json.com/v1/api.json?rss_url=${encodeURIComponent(rssUrl)}`;

        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
            if (data.status === "ok" && data.items.length > 0) {
                // Retrieve the latest video entry from the feed
                const latestVideo = data.items[0];
                
                // Extract the Video ID from the entry's GUID (format: "yt:video:VIDEO_ID")
                const videoId = latestVideo.guid.replace("yt:video:", "");

                // Update the iframe source dynamically
                const iframe = document.getElementById("basket-lummen-player");
                if (iframe) {
                iframe.src = `https://www.youtube.com/embed/${videoId}`;
                }
            }
            })
            .catch(error => console.error("Error loading YouTube stream:", error));
        });
</script>


<div id="partners-top">
        <h2>Dank aan onze partners</h2>
</div>
<div id="partners">
    <div>
            <div class="container">
                {{>partners}}
            </div>
    </div>		
</div>	