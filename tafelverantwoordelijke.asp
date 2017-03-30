<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Basket Lummen - Opleiding tafelverantwoordelijke</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {font-size: 24px}
-->
</style>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">
<p align="center"><span class="NieuwsTitels style3">Opleiding tafelverantwoordelijke</span></p>
<p align="center"><font size="3"><strong>woensdag 5 september<br>
  19.00 u.</strong></font></p>

<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	
	sqlstring = "INSERT INTO tafelverantwoordelijke(naam) VALUES('"&naam&"')"
	con.execute sqlstring%>
    
   <p>Bedankt voor uw inschrijving</p>
<%else
%>
<p>We voorzien zoals elke seizoen een korte opleiding op één avond van een tweetal uurtjes voor de tafelverantwoordelijken ivm de chrono, wedstrijdblad, 24 seconden en andere.<br>
Deze opleiding is voorzien op 5 september om 19:00 in de sporthal. 
</p>
<p>Gelieve wel op voorhand in te schrijven via onderstaand formulier: </p>

<form name="carwash" method="post" action="tafelverantwoordelijke.asp">
  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Naam :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="naam" size="50" tabindex="1" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="3" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
</div>
</body>
</html>
