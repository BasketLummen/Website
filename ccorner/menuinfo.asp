<div id="Layer2" style="position:absolute; z-index:0; left: 0px; top: 35px; width: 130px">
<table width="100%" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
<tr><td class="ccornerTitels"><img src="../img/driehoek_rood.gif" /> Clubinfo</td></tr>
<%sqlstring = "SELECT infoid, infonaam FROM tblClubinfo ORDER BY infoid"
rs.open sqlString
while not rs.eof%>
  <tr>
  	<td bgcolor="#000099"><a href="clubinfo.asp?id=<%=rs("infoid")%>" class="menuLinks2"><%=rs("infonaam")%></a></td>
  </tr>
  <%rs.movenext
wend
rs.close%>
</table></div>