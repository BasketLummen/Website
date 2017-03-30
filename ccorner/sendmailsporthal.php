<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<?
$plein = $_GET["plein"];
$datum = $_GET["datum"];
$van = $_GET["van"];
$tot = $_GET["tot"];
$soort = $_GET["soort"];
$opmerkingen = $_GET["opmerkingen"];
$to = "dominique_vanderheyden@skynet.be";
$naam = $_GET["voornaam"]." ".$_GET["naam"];
$email = $_GET["email"];

$subject = "Bezetting sporthal";
$message = "Plein: ".$plein."<br>Datum: ".$datum."<br> van ".$van." tot ".$tot."<br> soort: ".$soort."<br> opmerkingen: ".$opmerkingen;
$headers  = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
$headers .= 'From: "'.$naam.'" <'.$email.'>';


mail ($to, $subject, $message, $headers);

?>

</body>
</html>