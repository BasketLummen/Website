<!--#include file="connect2.asp" -->
[<%
sqlstring = "SELECT min(postnr) AS postnummer,gemeente FROM tblsporthallen, tblGemeenten WHERE sporthalpostnr = postnr GROUP BY gemeente ORDER BY gemeente"
rs.open sqlstring
while not rs.eof
	%>{"id":"<%=rs("postnummer")%>","text":"<%=rs("gemeente")%>"}<%	
	rs.movenext
	if not rs.eof then response.write(",")
wend
%>]
