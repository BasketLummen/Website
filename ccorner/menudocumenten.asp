<div id="Layer2" style="position:absolute; z-index:0; left: 0px; top: 35px; width: 165px">
<table width="100%" cellspacing="0" cellpadding="3" class="menuTitels">
<%
if Session("BL_soort") = 1 or Session("BL_soort") = 2 then
	sqlString = "SELECT * FROM tbldocsoorten WHERE id < 1100 ORDER BY id"
elseif Session("BL_soort") = 3 then
	sqlString = "SELECT * FROM tbldocsoorten WHERE id < 1000 ORDER BY id"
elseif Session("BL_soort") = 4 or Session("BL_soort") = 5 then 
	sqlString = "SELECT * FROM tbldocsoorten WHERE id < 1000 and id <> 606 ORDER BY id"
end if
rs.open sqlString
while not rs.eof%>
  <tr>
  	<%if rs("id") = 100 or rs("id") = 200 or rs("id") = 300 or rs("id") = 400 or rs("id") = 500 or rs("id") = 600 or rs("id") = 1000 then%>
  	<td class="ccornerTitels"><img src="../img/driehoek_rood.gif" /> <%=rs("docsoort")%></td>
	<%else%>
  	<td bgcolor="#000099"><a href="coachcorner.asp?soort=<%=rs("id")%>" class="menuLinks2"><%=rs("docsoort")%></a></td>
	<%end if%>
  </tr>
  	<%rs.movenext
wend
rs.close%>
</table></div>