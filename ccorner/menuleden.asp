<div id="Layer2" style="position:absolute; z-index:0; left: 0px; top: 35px; width: 120px">
<table width="110" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
   <tr>
 	<td class="ccornerTitels"><img src="../img/driehoek_rood.gif" /> Contact</td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="ledenlijst.asp" class="menuLinks2">Ledenlijst</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="ploegen.asp" class="menuLinks2">Per ploeg</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="lidtoevoegen.asp" class="menuLinks2">Lid toevoegen</a></td>
  </tr>
  <%if session("BL_soort") < 4 then%>
  <tr>
  	<td bgcolor="#000099"><a href="vroegereleden.asp" class="menuLinks2">Ex-Leden</a></td>
  </tr>
  <%end if%>
   <tr>
 	<td class="ccornerTitels"><img src="../img/driehoek_rood.gif" /> Statistieken</td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="aanwezigheden.asp" class="menuLinks2">Aanwezigheden</a></td>
  </tr>
  <%if session("BL_soort") < 3 or Session("BL_lidid")=205 or Session("BL_lidid")=22 or Session("BL_lidid")=450 then%>
  <!--tr>
  	<td bgcolor="#000099"><a href="scoutingtotaal.asp" class="menuLinks2">Scouting</a></td>
  </tr>
  <%end if%>
  <%if session("BL_soort") < 2 then%>
  <tr>
  	<td bgcolor="#000099"><a href="scoutingingeven.asp" class="menuLinks2">Scouting update</a></td>
  </tr
  <%end if%>-->
</table></div>