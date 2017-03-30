<!--#include file="ccorner/connect.asp"-->
<%
wedstrijdnr = request("wedstrijdnr")
id = request("id")
sqlstring = "SELECT * FROM tbllivecomment WHERE wedstrijd = " & wedstrijdnr & " ORDER BY id DESC"
rs.open sqlString
%>
<table id="livetabel">
<%while not rs.eof%>
	<tr id="<%=rs("id")%>" bgcolor="#FFFFFF"><td><%=rs("commentaar")%></td></tr>
	<%rs.movenext
wend
rs.close
con.close%>
</table>
