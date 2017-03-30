<%
toon = 1'trim(request("toon"))
dim zichtbaar(24)
for i= 0 to 23
	zichtbaar(i) = "hidden"
next
zichtbaar(toon) = "visible"
dim menu(24)
menu(0) = 0
menu(1) = 20
menu(2) = 40
menu(3) = 60
menu(4) = 80
menu(5) = 100
menu(6) = 120
menu(7) = 140
menu(8) = 160
menu(9) = 180
menu(10) = 200
menu(11) = 220
menu(12) = 240
menu(13) = 260
menu(14) = 280
menu(15) = 300
menu(16) = 320
menu(17) = 340
menu(18) = 360
menu(19) = 380
menu(20) = 400
menu(21) = 420
menu(22) = 440
menu(23) = 460

dim menu2(24)
menu2(0) = 0
menu2(1) = 71 'Heren A
menu2(2) = 71 'Heren B
menu2(3) = 71 'Heren C
menu2(4) = 55 'Heren D
menu2(5) = 71 'Dames A
menu2(6) = 71 'Dames B
menu2(7) = 71 'Dames C
menu2(8) = 55 'Dames D
menu2(9) = 55 'Land. Juniors H
menu2(10) = 55 'Land. Kadetten H
menu2(11) = 55 'Land. Miniemen H
menu2(12) = 55 'Land. Pupillen H
menu2(13) = 55 'Land. Miniemen D
menu2(14) = 55 'Land. Pupillen D
menu2(15) = 55 'Prov. Kadetten H
menu2(16) = 55 'Prov. Miniemen H
menu2(17) = 55 'Prov. Pupillen H
menu2(18) = 71 'Prov. Kadetten D
menu2(19) = 71 'Prov. Pupillen D
menu2(20) = 55 'Benjamins A
menu2(21) = 55 'Benjamins B
menu2(22) = 35 'Microben
menu2(23) = 20 'Supermicroben


for i = (toon+1) to 23
	menu(i) = menu(i) + menu2(toon)
next
%>
<html>
<head>
<title>Basket Lummen - Competitie</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<base target="ploegframe">
</head>

<body onLoad="document.body.style.overflowX='hidden';">
<div id="Layer2" style="position:absolute; width:110px; z-index:0; background-color:#FFFF00; left: 0; top: 0;">
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:1; top: <%=menu(0)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=0" class="menuLinks1">Deze Week</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:2; top: <%=menu(1)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="competitie1.asp?toon=1" class="menuLinks1">Heren A</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:3; top: <%=menu(1)+20%>; visibility: <%=zichtbaar(1)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=1" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383011&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30101&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="eindklas.asp?ploeg=HA" class="menuLinks2" target="competitieframe">Archief</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:4; top: <%=menu(2)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=2" class="menuLinks1">Heren B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:5; top: <%=menu(2)+20%>; visibility: <%=zichtbaar(2)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="6" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=2" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383012&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30102&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="eindklas.asp?ploeg=HB" class="menuLinks2" target="competitieframe">Archief</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:6; top: <%=menu(3)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=3" class="menuLinks1">Heren C</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:7; top: <%=menu(3)+20%>; visibility: <%=zichtbaar(3)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=4" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383013&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30105&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="eindklas.asp?ploeg=HC" class="menuLinks2" target="competitieframe">Archief</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:8; top: <%=menu(4)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=4" class="menuLinks1">Heren D</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:9; top: <%=menu(4)+20%>; visibility: <%=zichtbaar(4)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="3" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=5" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383014&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30106&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:10; top: <%=menu(5)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="competitie1.asp?toon=5" class="menuLinks1">Dames A</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:11; top: <%=menu(5)+20%>; visibility: <%=zichtbaar(5)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=6" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383111&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=1111&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="eindklas.asp?ploeg=DA" class="menuLinks2" target="competitieframe">Archief</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:12; top: <%=menu(6)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=6" class="menuLinks1">Dames B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:13; top: <%=menu(6)+20%>; visibility: <%=zichtbaar(6)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=7" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383112&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=1112&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="eindklas.asp?ploeg=DB" class="menuLinks2" target="competitieframe">Archief</a></td>
  </tr>
</table>
</div><div id="menu" style="position:absolute; width:110px; height:100px; z-index:12; top: <%=menu(7)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=7" class="menuLinks1">Dames C</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:13; top: <%=menu(7)+20%>; visibility: <%=zichtbaar(7)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=8" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383113&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=31101&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099">&nbsp;</td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:14; top: <%=menu(8)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=8" class="menuLinks1">Dames D</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:15; top: <%=menu(8)+20%>; visibility: <%=zichtbaar(8)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=9" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383114&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=31103&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:16; top: <%=menu(9)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="competitie1.asp?toon=9" class="menuLinks1">L.Juniors H</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:17; top: <%=menu(9)+20%>; visibility: <%=zichtbaar(9)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=11" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383021&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=203&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:18; top: <%=menu(10)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=10" class="menuLinks1">L.Kadetten H</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:19; top: <%=menu(10)+20%>; visibility: <%=zichtbaar(10)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=15" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383031&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=303&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:18; top: <%=menu(11)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=11" class="menuLinks1">L.Miniemen H</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:19; top: <%=menu(11)+20%>; visibility: <%=zichtbaar(11)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=13" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383041&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=403&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:20; top: <%=menu(12)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=12" class="menuLinks1">L.Pupillen H</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:21; top: <%=menu(12)+20%>; visibility: <%=zichtbaar(12)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=18" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383051&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=503&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
  <div id="menu" style="position:absolute; width:110px; height:100px; z-index:22; top: <%=menu(13)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=13" class="menuLinks1">L.Miniemen D</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:23; top: <%=menu(13)+20%>; visibility: <%=zichtbaar(13)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=12" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383141&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=1403&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:24; top: <%=menu(14)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=14" class="menuLinks1">L.Pupillen D</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:25; top: <%=menu(14)+20%>; visibility: <%=zichtbaar(14)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=16" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383151&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=1501&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:26; top: <%=menu(15)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="competitie1.asp?toon=15" class="menuLinks1">P.Kadetten H</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:27; top: <%=menu(15)+20%>; visibility: <%=zichtbaar(15)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=14" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383032&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30301&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:28; top: <%=menu(16)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=16" class="menuLinks1">P.Miniemen H</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:33; top: <%=menu(16)+20%>; visibility: <%=zichtbaar(16)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=19" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383042&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30402&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:34; top: <%=menu(17)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=17" class="menuLinks1">P.Pupillen H</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:35; top: <%=menu(17)+20%>; visibility: <%=zichtbaar(17)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=20" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383052&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30502&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:36; top: <%=menu(18)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=18" class="menuLinks1">P.Kadetten D</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:37; top: <%=menu(18)+20%>; visibility: <%=zichtbaar(18)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=21" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383131&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=31301&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=31301&css=1438&l=1" class="menuLinks2" target="competitieframe">Limburgse</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:38; top: <%=menu(19)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=19" class="menuLinks1">P.Pupillen D</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:39; top: <%=menu(19)+20%>; visibility: <%=zichtbaar(19)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=22" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383152&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=31501&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=31501&css=1438&l=1" class="menuLinks2" target="competitieframe">Limburgse</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:40; top: <%=menu(20)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="competitie1.asp?toon=20" class="menuLinks1">Benjamins A</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:41; top: <%=menu(20)+20%>; visibility: <%=zichtbaar(20)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=24" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383061&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30601&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:42; top: <%=menu(21)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=21" class="menuLinks1">Benjamins B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:43; top: <%=menu(21)+20%>; visibility: <%=zichtbaar(21)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=25" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383062&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/klassement.asp?v=1&reeks=30602&css=1438" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:44; top: <%=menu(22)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="competitie1.asp?toon=22" class="menuLinks1">Microben</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:45; top: <%=menu(22)+20%>; visibility: <%=zichtbaar(22)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="2" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=27" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://limburg.basketbalvlaanderen.org/kalploeg.asp?ploeg=14383211&css=1438&v=1" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:46; top: <%=menu(23)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;  border-bottom: 2px solid #000099;">
  <tr>
  	<td><a href="competitie1.asp?toon=23" class="menuLinks1">Supermicroben</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:47; top: <%=menu(23)+20%>; visibility: <%=zichtbaar(23)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="spelers.asp?ploeg=30" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
</table>
</div>
</div>
</body>
</html>
