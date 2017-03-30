<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Naamloos document</title>
</head>

<body>
<?
$xml = simplexml_load_file("http://feed911.photobucket.com/albums/ac313/shooter76lummen/Peanutstornooi%20Lummen%202010/feed.rss");

foreach($xml->channel->item as $data) {
	$media = $data->children('media', true);
	$content = $media->content->children('media', true);
	$attr = $content->thumbnail->attributes();
	echo("<img src=\"".$attr['url']."\" /><br>");
}






?>



</body>
</html>