<%
response.ContentType="text/xml"
response.Write("<?xml version='1.0' encoding='ISO-8859-1'?>")%>
<!--#include file="connect.asp" -->
<nieuwsberichten>
<%


sqlstring = "SELECT * FROM tblnieuws WHERE categorie = 1 ORDER BY datum DESC, id DESC LIMIT 0, 3"
rs.open sqlstring
while not rs.eof%>
	<bericht>
    	<datum><%=rs("datum")%></datum>
    	<onderwerp><%=rs("onderwerp")%></onderwerp>
    	<nieuws><%=replace(rs("nieuws"),"<br>","\n")%></nieuws>
	</bericht>
	<%rs.movenext
wend
rs.close
con.close%>
</nieuwsberichten>