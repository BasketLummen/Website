<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Sinterklaasfeest</title>
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

<p align="center"><span class="NieuwsTitels style3">Sinterklaasfeest</span></p>

<p>Op zondag 27 november organiseert BASKET LUMMEN een groots SINTERKLAASFEEST voor alle supermicroben, microben, benjamins en balspeeltuiners. Uiteraard zijn jullie broertjes en/of zusjes en jullie ouders ook welkom!<br>
We maken er die dag een echt feest van vol muziek, leuke spelletjes, knutselwerkjes,… en als hoogtepunt natuurlijk een bezoekje van de Sint en zijn zwarte pieten! De sint zal voor elke deelnemer een cadeautje meebrengen.
Er zullen die namiddag ook pannenkoeken en drank te verkrijgen zijn aan zeer democratische prijzen. </p>

<p>WAAR?		Grote tent langs de kerk van Thiewinkel Lummen.<br>
WANNEER?		Zondag 27/11 van 13u – 16u<br>
INSCHRIJVING?	Deelname is gratis maar inschrijven is verplicht voor  22 november via onderstaand formulier</p>
</p>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	naam = Replace(naam, "'", "´")
	ploeg = trim(request("ploeg"))
	bz1 = trim(request("bz1"))
	bz1 = Replace(bz1, "'", "´")
	bz2 = trim(request("bz2"))
	bz2 = Replace(bz2, "'", "´")
	bz3 = trim(request("bz3"))
	bz3 = Replace(bz3, "'", "´")
	bz4 = trim(request("bz4"))
	bz4 = Replace(bz4, "'", "´")

  sqlstring = "INSERT INTO tblsinterklaas(naam,ploeg,bz1,bz2,bz3,bz4) VALUES('"&naam&"','"&ploeg&"','"&bz1&"','" & bz2&"','" & bz3&"','" & bz4&"')"
	con.execute sqlstring	%>
    <p><b>Uw inschrijving is genoteerd.</b></p>
<%else
%>


<form method="post" action="sinterklaas.asp">
<table>
	<tr>
      <td nowrap>Naam</td>
      <td nowrap><input type="text" name="naam" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
	<tr>
      <td nowrap>Ploeg</td>
      <td nowrap><select name="ploeg">
      <option value="Benjamins">Benjamins</option>
       <option value="Microben">Microben</option>
        <option value="Supermicroben">Supermicroben</option>
         <option value="Balspeeltuin">Balspeeltuin</option></select>
     </td>
    </tr>
	<tr>
      <td nowrap valign="top">Broertjes/zusjes</td>
      <td nowrap><input type="text" name="bz1" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"><br>
      <input type="text" name="bz2" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"><br>
      <input type="text" name="bz3" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"><br>
      <input type="text" name="bz4" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"><br>
		</td>
    </tr>
 </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden"style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
</div>
</body>
</html>
