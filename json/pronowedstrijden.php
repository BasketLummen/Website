<?php
// Set return content type
header('Content-type: application/json');

// url to open

$url = 'http://limburg.basketbalvlaanderen.org/json/pronowedstrijden.asp?sd='.$_GET["sd"];


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