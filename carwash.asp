<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Basket Lummen - Carwash</title>
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
<p align="center"><span class="NieuwsTitels style3">Carwash Basket Lummen</span></p>
<p align="center"><font size="3"><strong>zaterdag 15 september<br>
  11.00 u. tot 15.00 u.</strong></font></p>

<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	uur = trim(request("uur"))
	
	sqlstring = "INSERT INTO tblcarwash(naam,uur) VALUES('"&naam&"','"&uur&"')"
	con.execute sqlstring%>
    
   <p>Bedankt voor uw inschrijving</p>
<%else
%>
<p align="center"><img src="img/carwash.jpg" width="300" height="225"></p>
<p>Ons nieuw opgericht jeugdcomité heeft onze damesploegen gemobiliseerd om een grootse Car Wash te organiseren ter ondersteuning van onze jeugdwerking. Dus indien je auto vuil is, kan je op zaterdag 15/09 tussen 11:00 en 15:00 terecht op de terreinen van de Sint Ferdinand School – Sint-Ferdinandstraat 1 Lummen.</p>
<p>Prijs:<br>
Auto: 7 euro<br>
Bestelwagen (en dergelijke): 10 euro</p>
<p>Er kan op voorhand in geschreven worden via onderstaand formulier: </p>

<p>Moest je echter in laatste instantie beslissen om zonder inschrijving alsnog je auto aan flinke poetsbeurt te onderwerpen, kan dit uiteraard ook.
</p>
<form name="carwash" method="post" action="carwash.asp">
  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Naam :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="naam" size="50" tabindex="1" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Tijdstip :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="uur" size="10" tabindex="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
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
