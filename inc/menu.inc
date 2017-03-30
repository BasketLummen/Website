<%
dim zichtbaar(10)
for i= 0 to 9
	zichtbaar(i) = "hidden"
next
zichtbaar(toon) = "visible"
dim menu(10)
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

dim menu2(10)
menu2(0) = 0
menu2(1) = 165
menu2(2) = 40
menu2(3) = 60
menu2(4) = 0
menu2(5) = 0
menu2(6) = 0
menu2(7) = 40
menu2(8) = 287
menu2(9) = 287


for i = (toon+1) to 9
	menu(i) = menu(i) + menu2(toon)
next

if toon = 3 and boven=true then
	menutop = 0
else
	menutop = 60
end if
%>

<div id="Layer2" style="position:absolute; width:110px; z-index:0; background-color:#FFFF00; left: 0; top: <%=menutop%>;">
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:1; top: <%=menu(0)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td><a href="home.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Home</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:2; top: <%=menu(1)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td><a href="clubinfo.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Clubinfo</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:3; top: <%=menu(1)+20%>; visibility: <%=zichtbaar(1)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="10" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="clubinfo.asp" class="menuLinks2">Algemeen</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="organisatie.asp" class="menuLinks2">Organisatie</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="sporthallummen.asp" class="menuLinks2">Sporthal</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="visie.asp" class="menuLinks2">Visie</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="huisreglement.asp" class="menuLinks2">Intern reglement</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="sportievelijn.asp" class="menuLinks2">Sportieve lijn</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="documenten.asp" class="menuLinks2">Documenten</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="geschiedenis.asp" class="menuLinks2">Geschiedenis</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:4; top: <%=menu(2)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td><a href="hotnews.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Hot News</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:5; top: <%=menu(2)+20%>; visibility: <%=zichtbaar(2)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="2" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="hotnews.asp" class="menuLinks2">Laatste</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="hotnewsarchief.asp" class="menuLinks2">Archief</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:6; top: <%=menu(3)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td><a href="competitie.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Ploegen</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:7; top: <%=menu(3)+20%>; visibility: <%=zichtbaar(3)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="4" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="competitie.asp" class="menuLinks2">Competitie</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="trainingen.asp" class="menuLinks2">Trainingsuren</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="sporthallen.asp" class="menuLinks2">Sporthallen</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:10; top: <%=menu(4)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td><a href="fotoalbum.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Fotoalbum</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:12; top: <%=menu(5)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td><a href="activiteiten.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Activiteiten</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:13; top: <%=menu(6)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-bottom: 2px solid #000099;">
  <tr>
    <td><a href="verjaardagen.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Verjaardagen</a></td>
  </tr>
</table>
</div>
<!--div id="menu" style="position:absolute; width:110px; height:98px; z-index:14; top: <%=menu(7)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td><a href="gastenboek.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Gastenboek</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:15; top: <%=menu(7)+20%>;visibility: <%=zichtbaar(7)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="2" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="gastenboek.asp" class="menuLinks2">Lezen</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="gastenboektoevoegen.asp" class="menuLinks2">Schrijven</a><br><br></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:16; top: <%=menu(8)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels"  onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand; border-bottom: 2px solid #000099; ">
  <tr>
    <td><a href="links.asp" class="menuLinks1"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Links</a></td>
  </tr>
</table>
</div>
<div id="menu" style="position:absolute; width:110px; height:98px; z-index:17; top: <%=menu(8)+20%>;visibility: <%=zichtbaar(8)%>;">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr>
    <td rowspan="17" bgcolor="#000099" width="10"></td>
  	<td bgcolor="#000099"><a href="links.asp?reeks=1" class="menuLinks2">1ste nationale</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=2" class="menuLinks2">2de nationale</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=3" class="menuLinks2">3de nationale</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=4" class="menuLinks2">Landelijke</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=5" class="menuLinks2">Regionale</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=6" class="menuLinks2">Dames</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=8" class="menuLinks2">Algemene</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=12" class="menuLinks2">Antwerpen</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=11" class="menuLinks2">Vl-Brabant</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=13" class="menuLinks2">Limburg</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=19" class="menuLinks2">Oost-Vlaand.</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=18" class="menuLinks2">West-Vlaand.</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=20" class="menuLinks2">W-Brabant</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=17" class="menuLinks2">Henegouwen</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=14" class="menuLinks2">Luik</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=16" class="menuLinks2">Luxemburg</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="links.asp?reeks=15" class="menuLinks2">Namen</a></td>
  </tr>
</table>
</div-->
<div id="menu" style="position:absolute; width:110px; height:30px; z-index:17; top: 530;">

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-5769703-2']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
<p><font size=1>&copy; 2000-<%=year(date())%><br>
<a href="mailto:johnny.peeters@basketlummen.be" class="mailjp">Johnny Peeters</a></font></p>
</div>

</div>
