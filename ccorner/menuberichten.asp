<div id="Layer2" style="position:absolute; z-index:0; left: 0px; top: 35px; width: 120px">
<table width="100%" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
<tr>
  	<td class="ccornerTitels" colspan="4"><img src="../img/driehoek_rood.gif" /> Nieuws</td>
</tr>
  <tr>
  	<td bgcolor="#000099"><a href="berichten.asp" class="menuLinks2">Ontvangen berichten</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="berichten.asp?soort=verzonden" class="menuLinks2">Verzonden berichten</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="berichtplaatsen.asp" class="menuLinks2">Bericht plaatsen</a></td>
  </tr>
<tr>
  	<td class="ccornerTitels" colspan="4"><img src="../img/driehoek_rood.gif" /> Admin</td>
</tr>
  <tr>
  	<td bgcolor="#000099"><a href="changepassword.asp" class="menuLinks2">Wachtwoord wijzigen</a></td>
  </tr>
  <%if session("BL_soort") < 3 then%>
        <tr>
            <td bgcolor="#000099"><a href="gebruikers.asp" class="menuLinks2">Gebruikers</a></td>
        </tr>
  <%end if%>
          <tr>
            <td class="ccornerTitels" colspan="4"><img src="../img/driehoek_rood.gif" /> Wedstrijden</td>
        </tr>
        <tr>
            <td bgcolor="#000099"><a href="kalenderexcel.asp" class="menuLinks2">Overzicht</a></td>
        </tr>
  <%if session("BL_soort") < 3 or Session("BL_lidid")=26 or Session("BL_lidid")=693 then%>
<tr>
  	<td class="ccornerTitels" colspan="4"><img src="../img/driehoek_rood.gif" /> Hot News</td>
</tr>
  <tr>
  	<td bgcolor="#000099"><a href="nieuwstoevoegen.asp" class="menuLinks2">Nieuws toevoegen</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="nieuwswijzigen.asp" class="menuLinks2">Nieuws wijzigen</a></td>
  </tr>
	<%end if%>
<tr>
  	<td class="ccornerTitels" colspan="4"><img src="../img/driehoek_rood.gif" /> Activiteiten</td>
</tr>
  <%if session("BL_soort") < 4 then%>
  <tr>
  	<td bgcolor="#000099"><a href="activiteiten.asp" class="menuLinks2">Programma</a></td>
  </tr>
  <tr>
  	<td bgcolor="#000099"><a href="actopmerkingen.asp" class="menuLinks2">Opmerkingen</a></td>
  </tr>
	<%end if%>
       <tr>
  	<td bgcolor="#000099"><a href="eetdagschema.asp" class="menuLinks2">Eetdag</a></td>
  </tr>
        <tr>
  	<td bgcolor="#000099"><a href="peanutsinschrijvingen.asp" class="menuLinks2">Peanuts</a></td>
  </tr>
    <tr>
  	<td bgcolor="#000099"><a href="mosselfeestschema.asp" class="menuLinks2">Mosselfeest</a></td>
  </tr>
    <tr>
  	<td bgcolor="#000099"><a href="stagemin12inschr.asp" class="menuLinks2">Stage</a></td>
  </tr>
    <tr>
  	<td bgcolor="#000099"><a href="../bbqbestellingen.asp" class="menuLinks2">Barbeque</a></td>
  </tr>
    <tr>
  	<td bgcolor="#000099"><a href="hulpoverzicht.asp" class="menuLinks2">Ethias/Heizel</a></td>
  </tr>
<tr>
  	<td class="ccornerTitels" colspan="4"><img src="../img/driehoek_rood.gif" /> Wedstrijden</td>
</tr>

  <%if session("BL_soort") < 3 then%>
      <tr>
        <td bgcolor="#000099"><a href="uitslageningeven.asp" class="menuLinks2">Uitslagen ingeven</a></td>
      </tr>
       <tr>
        <td bgcolor="#000099"><a href="zoekmatch.asp" class="menuLinks2">Uitslag wijzigen</a></td>
      </tr>

      <tr>
        <td bgcolor="#000099"><a href="kalzoekmatch.asp" class="menuLinks2">Kalender wijzigen</a></td>
      </tr>

     <tr>
        <td bgcolor="#000099"><a href="ploegtoevoegen.asp" class="menuLinks2">Ploeg toevoegen</a></td>
      </tr>
      <tr>
        <td bgcolor="#000099"><a href="matchtoevoegen.asp" class="menuLinks2">Match toevoegen</a></td>
      </tr>
     

  <%end if%>
   <tr>
        <td bgcolor="#000099"><a href="tafelverdeling.asp" class="menuLinks2">Tafelverdeling</a></td>
      </tr>
   <tr>
        <td bgcolor="#000099"><a href="verslagwijzigen.asp" class="menuLinks2">Verslag toevoegen</a></td>
      </tr>
<tr>
  	<td class="ccornerTitels" colspan="4"><img src="../img/driehoek_rood.gif" /> Varia</td>
</tr>
      <tr>
        <td bgcolor="#000099"><a href="prestaties.asp" class="menuLinks2">Onkosten</a></td>
      </tr>
  <tr>
  	<td bgcolor="#000099"><a href="sporthalbezetting.asp" class="menuLinks2">Sporthalbezetting</a></td>
  </tr>
    <tr>
  	<td bgcolor="#000099"><a href="ijstaartbestellingen.asp" class="menuLinks2">Ijstaarten</a></td>
  </tr>

  <%if session("BL_soort") < 3 or Session("BL_lidid")=622 or Session("BL_lidid")=744 or Session("BL_lidid")=802 or Session("BL_lidid")=803 then%>
  <tr>
  	<td bgcolor="#000099"><a href="topschuttersoverzicht.asp" class="menuLinks2">Topschutters</a></td>
  </tr>
  <%end if%>
  <%if session("BL_soort") < 3 then%>
  <tr>
  	<td bgcolor="#000099"><a href="gastenboekverwijderen.asp" class="menuLinks2">Gastenboek</a></td>
  </tr>

  <%end if%>
 <%if session("BL_soort") < 2 or Session("BL_lidid")=802 then%>
  <tr>
  	<td bgcolor="#000099"><a href="linkswijzigen.asp" class="menuLinks2">Overzicht links</a></td>
  </tr>
  <%end if%>
</table></div>