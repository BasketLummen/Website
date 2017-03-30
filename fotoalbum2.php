<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Naamloos document</title>
</head>

<body>
<h2>Peanutstornooi Basket Lummen (11 november 2010)</h2>
<table>
<?
$xml = simplexml_load_file("http://feed911.photobucket.com/albums/ac313/shooter76lummen/Peanutstornooi%20Lummen%202010/feed.rss");

$aantal_fotos = 100;
$fotos_per_pagina = 12;
$aantal_links = 2;
$aantal_paginas = ceil($aantal_fotos/$fotos_per_pagina);

if(isset($_GET["p"])) {
    $pagina = $_GET["p"];
}
else {
    $pagina = 1;
}
if (!is_numeric($pagina) || $pagina < 1 || $pagina > $aantal_paginas) {
    $pagina = 1;
}
$deze_pagina = $pagina;
$start = $pagina * $fotos_per_pagina - ($fotos_per_pagina);


for($i=$start;$i<($start+$fotos_per_pagina);$i++) {
	if($i>=$aantal_fotos) {break;}
	$data = $xml->channel->item[$i];
	$media = $data->children('media', true);
	$content = $media->content->children('media', true);
	$attr = $content->thumbnail->attributes();
	if($i%4==0) {echo "\n<tr>";}
	echo("<td valign='top' align='center'><a href='".$data->enclosure["url"]."'><img src='".$attr['url']."' border='0' /></a></td>");
	if(($i+1)%4==0) {echo "</tr>\n";}
}
?>
</table>
<?
	if ($deze_pagina - $aantal_links < 1) {
		$pagina = $aantal_links +1;
	}
	elseif($deze_pagina + $aantal_links > $aantal_paginas) {
		$pagina = $aantal_paginas - $aantal_links;
	}

	if ($deze_pagina != 1) {
		echo("<a href='fotoalbum2.php?p='>Eerste</a> ");
	}
	if ($deze_pagina - 1 > 0) {
		echo("<a href='fotoalbum2.php?p=" . ($deze_pagina - 1) . "'>Vorige</a> ");
	}
	for($i = $pagina - $aantal_links; $i < $pagina + $aantal_links + 1; $i++) {
		if ($i == $deze_pagina) {
			echo($i . " ");
		}
		elseif($i > 0 && $i < $aantal_paginas +1) {
			echo("<a href='fotoalbum2.php?p=" . $i . "'>" . $i . "</a> ");
		}
	}
	if ($deze_pagina < $aantal_paginas) {
		echo("<a href='fotoalbum2.php?p=" . ($deze_pagina + 1) . "'>Volgende</a> ");
	}
	if ($deze_pagina != $aantal_paginas) {
		echo("<a href='fotoalbum2.php?p=" . $aantal_paginas . "'>Laatste</a> ");
	}
?>

</body>
</html>
