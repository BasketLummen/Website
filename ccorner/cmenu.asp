<div id="Layer1" style="position:absolute; z-index:0; background-color:#FFFF00; left: 0px; top: 0px; height: 35px; width: 1000px;">
<table cellspacing="0" cellpadding="3" width="100%" height="100%">
  <tr style="cursor: pointer; cursor: hand">
    <td width="25%" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" 
	class="ccornerTitels" onclick="document.location='berichten.asp'">
	<font size="4">Nieuws</font></td>
     <td width="20%" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" 
	class="ccornerTitels" onclick="document.location='coachcorner.asp'">
	<font size="4">Coach Corner</font></td>
    <td width="20%" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" 
	class="ccornerTitels" onclick="document.location='ledenlijst.asp'">
	<font size="4">Ledendatabase</font></td>
	<%if Session("BL_soort") < 5 then%>
    <td width="20%" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" 
	class="ccornerTitels" onclick="document.location='sponsorlijst.asp'">
	<font size="4">Sponsors</font></td>
    <%end if%>
    <td width="20%" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" 
	class="ccornerTitels" onclick="document.location='index.asp'">
	<font size="4">Log off</font></td>
  </tr>
</table></div>