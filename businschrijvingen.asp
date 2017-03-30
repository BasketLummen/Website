<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Beker van Vlaanderen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {font-size: 24px}
-->
</style>
</head>

<body>
<%
sqlstring = "SELECT * FROM tblbus ORDER BY id"
rs.open sqlstring
%>
 <table border="1" cellspacing="0">
 	<tr>
    <th>Nr</th>
    <th>Naam</th>
    <th width="50">E-mail</th>
    <th width="50">GSM</th>
    <th width="50">T-shirt</th>
    </tr>
    <%
	s=0
	m=0
	l=0
	xl=0
	xxl=0
	while not rs.eof%>
    	<tr>
        <td align="center"><%=rs("id")%></td>
        <td><%=rs("naam")%></td>
        <td align="center"><%=rs("email")%></td>
        <td align="center"><%=rs("gsmnr")%></td>
        <td align="center"><%=rs("tshirt")%></td>
   	</tr>
    	<%
		if rs("tshirt") = "S" then
			s=s+1
		elseif rs("tshirt") = "M" then
			m=m+1
		elseif rs("tshirt") = "L" then
			l=l+1
		elseif rs("tshirt") = "XL" then
			xl=xl+1
		elseif rs("tshirt") = "XXL" then
			xxl=xxl+1
		end if			
		rs.movenext
	wend
rs.close%>
</table>
<p>T-Shirts</p>
 <table border="1" cellspacing="0">
<tr><td>S</td><td><%=s%></td></tr>
<tr><td>M</td><td><%=m%></td></tr>
<tr><td>L</td><td><%=l%></td></tr>
<tr><td>XL</td><td><%=xl%></td></tr>
<tr><td>XXL</td><td><%=xxl%></td></tr>
</table>
</body>
</html>
