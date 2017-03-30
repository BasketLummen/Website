<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Tafelofficieel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
sqlstring = "SELECT * from tbltafelcursus"
rs.open sqlstring%>
<p class="NieuwsTitels">Inschrijven cursus tafelofficieel</p>
<table border="1" cellspacing="0">
<%id = 0
while not rs.eof
	id = id + 1%>
	<tr>
    	<td><%=id%></td>
    	<td><%=rs("naam")%></td>
        <td><%=rs("email")%></td>
    </tr>
    <%rs.movenext
wend%>
</table>
</body>
</html>
