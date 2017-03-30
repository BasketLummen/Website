<?php
// Set return content type
header('Content-type: application/xml');

// url to open
$url = 'http://feed911.photobucket.com/albums/ac313/shooter76lummen/Peanutstornooi%20Lummen%202010/feed.rss';

// Get url content
$handle = fopen($url, "r");

// read and return
if ($handle) {
    while (!feof($handle)) {
        $buffer = fgets($handle, 4096);
        echo $buffer;
    }
    fclose($handle);
}
?>