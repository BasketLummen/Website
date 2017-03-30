<?php
// Set return content type
header('Content-type: application/json');

// url to open
$url = 'http://www.vlaamsebasketballiga.be:8080/limburg/json/gemeenten.asp';

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