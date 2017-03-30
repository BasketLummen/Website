<%
toon = trim(request("toon"))


dim zichtbaar(26)
for i= 0 to 25
	zichtbaar(i) = "hidden"
next
zichtbaar(toon) = "visible"
dim menu(26)
menu(0) = 80
menu(1) = 100
menu(2) = 120
menu(3) = 140
menu(4) = 160
menu(5) = 180
menu(6) = 200
menu(7) = 220
menu(8) = 240
menu(9) = 260
menu(10) = 280
menu(11) = 300
menu(12) = 320
menu(13) = 340
menu(14) = 360
menu(15) = 380
menu(16) = 400
menu(18) = 420
menu(19) = 440
menu(20) = 460

dim menu2(26)
menu2(0) = 0
menu2(1) = 80 'Heren A
menu2(2) = 80 'Heren B
menu2(3) = 80 'Heren C
menu2(4) = 100 'Dames A 
menu2(5) = 100 'Dames B 
menu2(6) = 100 'Dames C 
menu2(7) = 100 'Dames D
menu2(8) = 60 'Land. Jongens U16
menu2(9) = 60 'Land. Meisjes U16
menu2(10) = 60 'Land. Gemengd U14
menu2(11) = 60 'Prov. Gemengd U14 B
menu2(12) = 60 'U12A
menu2(13) = 60 'U12B
menu2(14) = 80 'U10A / U12C
menu2(15) = 40 'U10B
menu2(16) = 40 'U10C
menu2(18) = 21 'U8 A
menu2(19) = 21 'U8 B
menu2(20) = 21 'U6

for i = (toon+1) to 25
	menu(i) = menu(i) + menu2(toon)
next
%>
<div style="position:absolute; width:110px; height:100px; z-index:0; top: 0;"><span class="nieuws"><b>Klik telkens op "programma" voor de kalender</b></span></div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:1; top: <%=menu(0)%>;">

<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=0" class="menuLinks1">Deze Week</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:2; top: <%=menu(1)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=1" class="menuLinks1">Heren A</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:3; top: <%=menu(1)+20%>; visibility: <%=zichtbaar(1)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=1" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%201" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%201" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../eindklas.asp?ploeg=HA" class="menuLinks2" target="competitieframe">Archief</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:4; top: <%=menu(2)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=2" class="menuLinks1">Heren B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:5; top: <%=menu(2)+20%>; visibility: <%=zichtbaar(2)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="6" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=2" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%202" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%202" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../eindklas.asp?ploeg=HB" class="menuLinks2" target="competitieframe">Archief</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:6; top: <%=menu(3)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=3" class="menuLinks1">Heren C</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:7; top: <%=menu(3)+20%>; visibility: <%=zichtbaar(3)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=4" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%203" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%203" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../eindklas.asp?ploeg=HC" class="menuLinks2" target="competitieframe">Archief</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:8; top: <%=menu(4)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=4" class="menuLinks1">Dames A</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:9; top: <%=menu(4)+20%>; visibility: <%=zichtbaar(4)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; ">
  <tr>
    <td rowspan="5" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=6" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%201" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%201" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../tafelverdeling.asp?s=<%=seizoen%>&ploeg=14383111" class="menuLinks2" target="competitieframe">Tafelverdeling</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../eindklas.asp?ploeg=DA" class="menuLinks2" target="competitieframe">Archief</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:10; top: <%=menu(5)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=5" class="menuLinks1">Dames B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:11; top: <%=menu(5)+20%>; visibility: <%=zichtbaar(5)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="5" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=7" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%202" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%202" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../tafelverdeling.asp?s=<%=seizoen%>&ploeg=14383112" class="menuLinks2" target="competitieframe">Tafelverdeling</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../eindklas.asp?ploeg=DB" class="menuLinks2" target="competitieframe">Archief</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:12; top: <%=menu(6)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=6" class="menuLinks1">Dames C</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:13; top: <%=menu(6)+20%>; visibility: <%=zichtbaar(6)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="5" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=8" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%203" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%203" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../tafelverdeling.asp?s=<%=seizoen%>&ploeg=14383113" class="menuLinks2" target="competitieframe">Tafelverdeling</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../eindklas.asp?ploeg=DC" class="menuLinks2" target="competitieframe">Archief</a><br><br></td>
  </tr>
</table>
</div><div id="menu" style="position:absolute; width:110px; height:100px; z-index:14; top: <%=menu(7)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=7" class="menuLinks1">Dames D</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:15; top: <%=menu(7)+20%>; visibility: <%=zichtbaar(7)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="6" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=9" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%204" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%204" class="menuLinks2" target="competitieframe">Klassement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../tafelverdeling.asp?s=<%=seizoen%>&ploeg=14383113" class="menuLinks2" target="competitieframe">Tafelverdeling</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="../eindklas.asp?ploeg=DD" class="menuLinks2" target="competitieframe">Archief</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:16; top: <%=menu(8)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=8" class="menuLinks1">L.Jongens U16</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:17; top: <%=menu(8)+20%>; visibility: <%=zichtbaar(8)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="5" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=17" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1081J16%20%201" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1081J16%20%201" class="menuLinks2" target="competitieframe">Klassement</a><br /><br /></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:18; top: <%=menu(9)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=9" class="menuLinks1">L.Meisjes U16</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:19; top: <%=menu(9)+20%>; visibility: <%=zichtbaar(9)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=20" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176M16%20%201" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176M16%20%201" class="menuLinks2" target="competitieframe">Klassement</a><br /><br /></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:20; top: <%=menu(10)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=10" class="menuLinks1">L.Gemengd U14</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:21; top: <%=menu(10)+20%>; visibility: <%=zichtbaar(10)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=22" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G14%20%201" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G14%20%201" class="menuLinks2" target="competitieframe">Klassement</a><br /><br /></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:22; top: <%=menu(11)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=11" class="menuLinks1">P.Gem.&nbsp;U14 B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:23; top: <%=menu(11)+20%>; visibility: <%=zichtbaar(11)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=23" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G14%20%202" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G14%20%202" class="menuLinks2" target="competitieframe">Klassement</a><br /><br /></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:24; top: <%=menu(12)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-top: 2px solid #FF0000;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=12" class="menuLinks1">U12 A</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:25; top: <%=menu(12)+20%>; visibility: <%=zichtbaar(12)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=28" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%201" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%201" class="menuLinks2" target="competitieframe">Klassement</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:26; top: <%=menu(13)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; ">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=13" class="menuLinks1">U12 B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:27; top: <%=menu(13)+20%>; visibility: <%=zichtbaar(13)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=29" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%202" class="menuLinks2" target="competitieframe">Kalender</a></td>
  </tr>
   <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%202" class="menuLinks2" target="competitieframe">Klassement</a><br /><br /></td>
  </tr>
</table>
</div>  <div id="menu" style="position:absolute; width:110px; height:100px; z-index:28; top: <%=menu(14)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=14" class="menuLinks1">U12 C</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:29; top: <%=menu(14)+20%>; visibility: <%=zichtbaar(14)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=31" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G10%20%201" class="menuLinks2" target="competitieframe">Kalender 1</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%203" class="menuLinks2" target="competitieframe">Kalender 2</a></td>
  </tr>
   <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%203" class="menuLinks2" target="competitieframe">Klassement</a><br /><br /></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:30; top: <%=menu(15)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; ">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=15" class="menuLinks1">U10 B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:31; top: <%=menu(15)+20%>; visibility: <%=zichtbaar(15)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=32" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G10%20%202" class="menuLinks2" target="competitieframe">Kalender</a><br/><br/></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:32; top: <%=menu(16)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=16" class="menuLinks1">U10 C</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:33; top: <%=menu(16)+20%>; visibility: <%=zichtbaar(16)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=33" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G10%20%203" class="menuLinks2" target="competitieframe">Kalender</a><br/><br/></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:36; top: <%=menu(18)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=18" class="menuLinks1">U8 A</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:37; top: <%=menu(18)+20%>; visibility: <%=zichtbaar(18)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=34" class="menuLinks2" target="competitieframe">Spelers</a><br/><br/></td>
  </tr>

</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:40; top: <%=menu(19)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=19" class="menuLinks1">U8 B</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:41; top: <%=menu(19)+20%>; visibility: <%=zichtbaar(19)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=35" class="menuLinks2" target="competitieframe">Spelers</a><br/><br/></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:42; top: <%=menu(20)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;border-bottom: 2px solid #000066;">
  <tr>
  	<td><a href="../competitie1.asp?s=<%=seizoen%>&toon=20" class="menuLinks1">U6</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:100px; z-index:43; top: <%=menu(20)+20%>; visibility: <%=zichtbaar(20)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; ">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="../spelers.asp?ploeg=37" class="menuLinks2" target="competitieframe">Spelers</a></td>
  </tr>
</table>
</div>
</table>


</div>
</div>
