<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Slotdag</title>
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
sqlstring = "SELECT * FROM tblslotdag ORDER BY soort, id"
rs.open sqlstring
pasta=0
soort=1
%>
 <table border="1" cellspacing="0">
 	<tr>
    <th>Groep</th>
    <th>Naam</th>
    <th width="50">Pasta</th>
    </tr>
    <%while not rs.eof
		pasta=pasta+cint(rs("pasta"))%>
        
    	<tr>
        <td>
        <%select case rs("soort")
				case 1:
					response.Write("SMic, Mic en Benj")
				case 2:
					response.Write("pupillen dames")
				case 3:
					response.Write(" pupillen en miniemen")
				case 4:
					response.Write("kadetten, juniors en seniors")
				case 5:
					response.Write("geen speler")
			end select
		%>
        </td>
        <td><%=rs("naam")%></td>
        <td align="center"><%=rs("pasta")%></td>
  	</tr>
    	<%
		rs.movenext
	wend
rs.close%>
</table>

</body>
</html>
