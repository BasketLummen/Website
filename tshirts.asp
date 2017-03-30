<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>T-shirts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	naam = Replace(naam, "'", "´")
	sqlstring = "INSERT INTO tbltshirts(naam) values('"&naam&"')"
	con.execute sqlstring
	%>	
	<p>Uw bestelling is genoteerd</p>
<%else%>
<p align="center" class="NieuwsTitels"><font size="3">T-Shirts</font></p>
<p>Ook dit jaar zal Lummen zich opnieuw laten zien op de bekerfinales van Limburg met exclusieve gele Basket Lummen t-shirts!</p>
<p>Ze zijn te koop aan 10 euro.</p>
<p>Bestellen kan door hieronder uw naam in te vullen en op verzenden te klikken.</p>
<form name="myform" id="myform" method="post" action="tshirts.asp">
  <table border="0" align="center" class="tgstrechts">
    <tr>
      <td nowrap="nowrap" >Naam :</td>
      <td nowrap="nowrap" >
        <input type="text" name="naam" size="50" tabindex="1">
      </td>
    </tr>
  </table>
  <br>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="18" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
<div id="overzicht"></div>
</div>
</body>
</html>
