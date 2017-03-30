<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Beker van Vlaanderen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">
<p align="center"><a href="http://www.bekervanvlaanderen.be"><img src="http://www.vlaamsebasketballiga.be/src/Frontend/Files/userfiles/images/Benjamin/Events/BVV%202017/header%20finales%20BVV%202017.jpg" border="0" width="400"></a></p>
  <p align="center" class="NieuwsTitels"><font size="4">Finale beker van Vlaanderen</font></p>
<p align="center">Inschrijving bus</p>
<p align="center">zondag 12 maart</p>
<p align="center">Vertrek: 14.00 u. carpool Lummen</p>
<p align="center">10 euro (inclusief t-shirt, exclusief inkom)</p>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	email = trim(request("email"))
	gsmnr = trim(request("gsmnr"))
	tshirt = trim(request("tshirt"))
	
	sqlstring = "INSERT INTO tblbus(naam,email,gsmnr,tshirt) VALUES('"&naam&"','"&email&"','"&gsmnr&"','" & tshirt&"')"
	con.execute sqlstring	%>
    
   <p align="center"><font color="#FF0000"><b>Uw inschrijving is genoteerd.</b></font></p> 
<%end if
%>
  
<form name="bus" method="post" action="busbeker.asp">

  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap>Naam</td>
      <td nowrap><input type="text" name="naam" size="50" tabindex="1" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
    <tr> 
      <td nowrap>E-mail</td>
      <td nowrap><input type="text" name="email" size="50" tabindex="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
    <tr> 
      <td nowrap>GSM</td>
      <td nowrap><input type="text" name="gsmnr" size="50" tabindex="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
    <tr> 
      <td nowrap>T-shirt maat</td>
      <td nowrap><select name="tshirt" tabindex="4" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
      	<option value="S">S</option>
      	<option value="M">M</option>
      	<option value="L">L</option>
      	<option value="XL">XL</option>
      	<option value="XXL">XXL</option>
      </select>
      </td>
    </tr>
          </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="5" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>

</form>
<p>De eerste 50 inschrijvingen zijn zeker van een plaats op de bus. Indien er voldoende (>20) bijkomende inschrijvingen zijn zal er een tweede bus rijden.</p>
</div>
</body>
</html>
