<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Rock Herk</title>
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
sqlstring = "SELECT * FROM tblrockherk ORDER BY id"
rs.open sqlstring
%>
 <table border="1" cellspacing="0">
 	<tr>
    <th>Naam</th>
    <th>Beoordeling</th>
    <th>2012</th>
    <th>Verbeteringen</th>
     <th>Opmerkingen</th>
   </tr>
    <%while not rs.eof%>
    	<tr>
         <td valign="top"><%=rs("naam")%></td>
       		<td valign="top"><%=rs("algemeen")%></td>
       		<td valign="top"><%=rs("volgende")%></td>
         		<td valign="top"><%=rs("verbeteringen")%></td>
     		<td valign="top"><%=rs("opmerkingen")%></td>
    	</tr>
    	<%
		rs.movenext
	wend
rs.close%>
</table>
</body>
</html>
