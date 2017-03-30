<%toon=7%>
<!--#include file="ccorner/connect.asp"-->
<html>
<head>
<title>Basket Lummen - Gastenboek</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; z-index:1; left: 120px; top: 70px;">

  <p><img src="img/driehoek_rood.gif" width="5" height="9"> <a href="gastenboektoevoegen.asp" class="NieuwsLinks"><font size="2">Voeg een bericht toe aan het gastenboek</font></a></p>

<%
sqlString = "SELECT naam, email, datum, bericht FROM tblgastenboek WHERE verwijderd = 0 ORDER BY datum DESC"
rs.open sqlString
while not rs.eof%>


<table width='600' cellspacing='0' cellpadding='3' bgcolor='#DDDDDD' class='NieuwsTitels'>
<tr>
<td class='NieuwsTitels'><img src='img/driehoek_rood.gif' width='5' height='9' border='0'> 
	<%if rs("email") <> "" and not isnull(rs("email")) then%>
		<a href="mailto:<%=rs("email")%>" class="NieuwsLinks"><%=rs("naam")%></a>
	<%else%>
		<%=rs("naam")%>
	<%end if%>	
</td>
<td align='right' class='NieuwsTitels'><%=weekdayname(weekday(rs("datum")),true)%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")))%>&nbsp;<%=year(rs("datum"))%>&nbsp;(<%=right(rs("datum"),8)%>)</td></tr></table>
<table width='600' cellspacing='0' cellpadding='3'>
<tr><td width='20'></td><td class='NieuwsTekst'><%=rs("bericht")%></td></tr></table><p></p>
	<%rs.movenext
wend
rs.close
con.close%>

  <p align="right"><img src="img/driehoek_rood.gif" width="5" height="9"> <a href="gastenboek2.asp" class="NieuwsLinks">Oudere berichten</a></p>
</div>
</body>
</html>
