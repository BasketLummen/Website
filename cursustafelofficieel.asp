<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Tafelofficieel</title>
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
	email = trim(request("email"))
	sqlstring = "INSERT INTO tbltafelcursus(naam,email) values('"&naam&"','"&email&"')"
	con.execute sqlstring
	%>	
	<p>Uw inschrijving is genoteerd</p>
<%else%>
<p align="center" class="NieuwsTitels">Inschrijven cursus tafelofficieel</p>
<p>Woensdag 7 september om 19.30 u. is er een tafelcursus voor  alle ge&iuml;nteresseerden van Basket Lummen. Dit zal doorgaan in de vergaderzaal boven in de sporthal.  Gelieve in te schrijven via onderstaand formulieer zodat we weten voor hoeveel personen er aanwezig zullen zijn.</p>
<form name="myform" id="myform" method="post" action="cursustafelofficieel.asp">
  <table border="0" align="center" class="tgstrechts">
    <tr>
      <td nowrap="nowrap" >Naam :</td>
      <td nowrap="nowrap" >
        <input type="text" name="naam" size="50" tabindex="1">
      </td>
    </tr>
    <tr>
      <td nowrap="nowrap" valign="top">E-mail :</td>
      <td nowrap="nowrap" >
        <input type="text" name="email" size="50" tabindex="2">
      </td>
    </tr>
  </table>
  <br>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="3" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
<div id="overzicht"></div>
</div>
</body>
</html>
