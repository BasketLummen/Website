<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Basket Lummen - Hoe omgaan met sportende kinderen</title>
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
<p align="center"><span class="NieuwsTitels style3">Hoe omgaan met sportende kinderen</span></p>
<p align="center"><font size="3"><strong>maandag 22 februari<br>
  maandag 7 maart<br>
  19.00 u. - 22.00 u.</strong></font></p>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	ploeg = trim(request("ploeg"))
	email = trim(request("email"))
	sqlstring = "INSERT INTO tblworkshop(naam,ploeg,email) VALUES('"&naam&"','"&ploeg&"','"&email&"')"
	con.execute sqlstring%>
    
   <p>Bedankt voor uw inschrijving</p>
<%else
%>
<p>Basket Lummen nodigt jullie uit voor een workshop van 2 avonden op <font color="#FF0000">22/2/2016</font> (in de kalen dries in Meldert) en <font color="#FF0000">7/3/2016 van 19:00-22:00 (juiste plaats wordt nog medegedeeld)</font> over het thema 'waarde-vol omgaan met sportende kinderen’. </p>
<p>
Basket Lummen is een club met waarden<br>
Basket Lummen hecht veel belang aan het waarmaken van haar visie en waarden en vindt het daarom belangrijk om naast de opleiding en de training van de kinderen ook aandacht te besteden aan de meest <font color="#FF0000">nauw</font> betrokken supporters: de ouders. </p>

<p>Waarom doen we dit?<br>
Wij stellen als club vast dat er veel vragen zijn bij ouders hoe ze hun kind best kunnen ondersteunen, stimuleren en enthousiasmeren. We stellen echter ook regelmatig in de praktijk vast dat er een kloof is tussen wat wenselijk gedrag en ondersteuning voor een gezonde en leerrijke omgeving is en wat er zich in de realiteit afspeelt.</p>

<p>Wat bieden we aan?<br>
Jan Dierens is een zeer ervaren sportpsycholoog. In 2 avondsessies van <font color="#FF0000">3u</font> gaan we het hebben over onderwerpen als communicatie, motivatie, ontwikkeling, emoties,... Allemaal <font color="#FF0000">belangrijke</font> zaken <font color="#FF0000">om bij stil te staan</font>, willen wij voor een gezonde en stimulerende context zorgen waarin onze kinderen maximaal van hun sport en ontwikkeling kunnen genieten.</p>

<p>
Voor iedereen!<br>
We mikken als club op alle ouders en bieden dit daarom gratis aan. Wij willen investeren in de kinderen, de ouders en de club. Tenslotte zijn jullie kinderen de toekomst van onze club! Wie echter toch iets wil betalen mag een vrijwillige bijdrage doen aan de jeugdwerking.</p>
<p>	Om alles ordentelijk te laten verlopen, hadden we graag dat de deelnemers zich zouden inschrijven via onderstaand formulier.
</p>

<form name="carwash" method="post" action="workshop.asp">
  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Naam</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="naam" size="50" tabindex="1" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr>
      <td nowrap>Ploeg</td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">
        <input name="ploeg" type="text" id="ploeg" tabindex="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" size="50">
      </font></td>
    </tr>
    <tr>
      <td nowrap>E-mailadres</td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">
        <input name="email" type="text" id="email" tabindex="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" size="50">
      </font></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="4" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
</div>
</body>
</html>
