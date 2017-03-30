<!--#include file="ccorner/connect.asp" -->
<html>
<head>
<title>T-shirts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>


<%
sqlstring = "SELECT * FROM tbltshirts ORDER BY id"
rs.open sqlstring
%>
 <table border="1" cellspacing="0">
 	<tr>
 	<th>Nr</th>
    <th>Naam</th>
    </tr>
    <%while not rs.eof%>
    	<tr>
	        <td ><%=rs("id")%></td>
	        <td ><%=rs("naam")%></td>
    	</tr>
    	<%
		rs.movenext
	wend
rs.close%>
</table>
</body>
</html>