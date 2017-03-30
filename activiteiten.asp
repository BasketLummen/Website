<%toon=6%>
<!--#include file="ccorner/connect.asp"--><html>
<html>
<head>
<title>Basket Lummen - Activiteiten</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">

</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<%sqlString = "SELECT * FROM tblActiviteiten WHERE begindatum > '"&year(date())&"-"&month(date())&"-"&day(date())&"' OR einddatum > '"&year(date())&"-"&month(date())&"-"&day(date())&"' ORDER BY soort, begindatum"
rs.open sqlString%>
<table width="700" cellspacing="0">
<%while not rs.eof
	if soort <> rs("soort") then
		soort = rs("soort")%>
		<tr><td colspan="4"><p class="NieuwsTitels"><font size="3">&nbsp;<br />
		<%if rs("soort") = 1 then%>
			Sportief
		<%elseif rs("soort") = 2 then%>
			Extra sportief
		<%else%>
			Extern Lummen
		<%end if%></font></p>
		</td></tr>
		<tr bgcolor="#DDDDDD">
			<td nowrap class="NieuwsTitels" style="border-top: 1px solid #000099;">datum</td>
			<td nowrap class="NieuwsTitels" style="border-top: 1px solid #000099;">naam</td>
			<td nowrap class="NieuwsTitels" style="border-top: 1px solid #000099;">locatie</td>
		</tr>

	<%end if
	if cint(id) = rs("id") then
		kleur = "#FFFFCC"
	else
		kleur = ""
	end if%>
			<tr>
				<td nowrap="nowrap" valign="top" style="border-top: 1px solid #000099;">
				<%if isnull(rs("einddatum")) or rs("einddatum") = "" then%>
					<%=day(rs("begindatum"))%>&nbsp;<%=monthname(month(rs("begindatum")),true)%>
				<%else
					if day(rs("begindatum")) = day(rs("einddatum")) then%>
						<%=day(rs("begindatum"))%>&nbsp;<%=monthname(month(rs("begindatum")),true)%>
					<%elseif month(rs("begindatum")) = month(rs("einddatum")) then%>
						<%=day(rs("begindatum"))%>-<%=day(rs("einddatum"))%>&nbsp;<%=monthname(month(rs("begindatum")),true)%>
					<%else%>
						<%=monthname(month(rs("begindatum")),true)%>-<%=day(rs("einddatum"))%>&nbsp;<%=monthname(month(rs("einddatum")),true)%>
					<%end if
				end if%>
				</td>
				<td nowrap="nowrap" valign="top" style="border-top: 1px solid #000099;"><%=rs("titel")%></td>
				<td nowrap="nowrap" valign="top" style="border-top: 1px solid #000099;"><%=rs("locatie")%></td>
				</tr>
				<tr><td></td><td colspan="3">
					<%if FormatDateTime(rs("begindatum"),4) <> "00:00" then%>
					  Begin: <%=FormatDateTime(rs("begindatum"),4)%>
						<%if rs("einddatum") <> "" and not isnull(rs("einddatum")) then
							if FormatDateTime(rs("begindatum"),4) <> FormatDateTime(rs("einddatum"),4) then%>
								- Einde: <%=FormatDateTime(rs("einddatum"),4)%>
							<%end if
						end if%><br />
					<%end if%>
					<%=rs("omschrijving")%>
					<%if rs("link") <> "" and not isnull(rs("link")) then%>
						<br /><img src="../img/driehoek_rood.gif" />&nbsp;<a href="<%=rs("link")%>" target="_blank" class="NieuwsLinks">Meer info</a>
					<%end if%></td></tr>
	
			
			<%rs.movenext
		wend
		rs.close%>
	</table>
<%con.close%>
</table>
</div>
</body>
</html>
