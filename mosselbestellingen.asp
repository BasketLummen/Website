<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Eetdag</title>
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
sqlstring = "SELECT * FROM tblmosselfeest WHERE naam <> 'Barnypok' AND naam <> 'JimmiXzS' ORDER BY id"
rs.open sqlstring
%>
 <table border="1" cellspacing="0">
 	<tr>
    <th>Nr</th>
    <th>Naam</th>
    <th width="50">Mosselen</th>
    <th width="50">Vide</th>
    <th width="50">Stoofvlees</th>
    <th width="50">Halve haan</th>
    <th width="50">Vegetarisch</th>    
   <th width="50">Hamburgers</th>

    <th width="50">Totaal</th>
    </tr>
    <%while not rs.eof%>
    	<tr>
        <td align="center"><%=rs("id")%></td>
        <td><%=rs("naam")%></td>
        <td align="center"><%=rs("mosselen")%></td>
        <td align="center"><%=rs("vide")%></td>
        <td align="center"><%=rs("stoofvlees")%></td>
        <td align="center"><%=rs("halvehaan")%></td>
        <td align="center"><%=rs("vegetarisch")%></td>
        <td align="center"><%=rs("hamburgers")%></td>
        <td align="center"><%=(cint(0&rs("mosselen"))*18)+((cint(0&rs("vide"))+cint(0&rs("stoofvlees"))+cint(0&rs("halvehaan"))+cint(0&rs("vegetarisch")))*12)+(cint(rs("hamburgers"))*6)%></td>
    	</tr>
    	<%
		rs.movenext
	wend
rs.close%>
</table>
</body>
</html>
