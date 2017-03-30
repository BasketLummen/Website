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
on error resume next
sqlstring = "SELECT * FROM tbleetdag ORDER BY id"
rs.open sqlstring
vide=0
stoofvlees=0
halvehaan=0
hamburgers=0
koudeschotel=0
%>
 <table border="1" cellspacing="0">
 	<tr>
    <th>Nr</th>
    <th>Naam</th>
    <th width="50">Vide</th>
    <th width="50">Balletjes</th>
    <th width="50"  nowrap>Halve haan</th>
    <th width="50">Hamburgers</th>
    <th width="50" nowrap>Koude schotel</th>
    <th width="50" nowrap>Veggie</th>
    <th width="50">Totaal</th>
    </tr>
    <%while not rs.eof
vide=vide+cint(rs("vide"))
stoofvlees=stoofvlees+cint(rs("stoofvlees"))
halvehaan=halvehaan+cint(rs("halvehaan"))
hamburgers=hamburgers+cint(rs("hamburgers"))
koudeschotel=koudeschotel+cint(rs("koudeschotel"))
%>
    	<tr>
        <td align="center"><%=rs("id")%></td>
        <td><%=rs("naam")%></td>
        <td align="center"><%=rs("vide")%></td>
        <td align="center"><%=rs("stoofvlees")%></td>
        <td align="center"><%=rs("halvehaan")%></td>
        <td align="center"><%=rs("hamburgers")%></td>
        <td align="center"><%=rs("koudeschotel")%></td>
        <td align="center"><%=rs("veggie")%></td>
          <td align="center"><b>&euro; <%=(cint(rs("vide"))+cint(rs("stoofvlees"))+cint(rs("halvehaan"))+cint(rs("veggie")))*12+cint(rs("hamburgers"))*6+cint(rs("koudeschotel"))*15%></b></td>
  	</tr>
    	<%
		rs.movenext
	wend
rs.close%>
</table>
</body>
</html>
