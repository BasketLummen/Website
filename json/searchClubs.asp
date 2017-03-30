<!--#include file="connect2.asp" -->
[<%
sqlstring = "SELECT stamnr, club FROM tblClubs ORDER BY club"
rs.open sqlstring
while not rs.eof
	%>{"id":"<%=rs("stamnr")%>","text":"<%=rs("club")%>"}<%	
	rs.movenext
	if not rs.eof then response.write(",")
wend
%>]
