<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<?
$to = $_GET["adres"];
$subject = "Coach Corner";
$message = "U hebt een nieuw bericht, <a href=http://www.basketlummen.be/ccorner>klik hier</a>";
$headers  = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
$headers .= 'From: Basket Lummen <secretariaat@basketlummen.be>';


mail ($to, $subject, $message, $headers);

?>

</body>
</html>