<!--#include file="connect.asp"-->
<%
stamnr = trim(request("stamnr"))
if isnull(stamnr) or stamnr = "" then
	sqlString = "SELECT stamnr FROM tblConfrontaties WHERE datum >= #" & month(date()) & "/" & day(date()) & "/" & year(date()) & "# ORDER BY datum"
	rs.open sqlString
	if rs.eof then
		stamnr = 1817
	else
		stamnr = rs("stamnr")
	end if
	rs.close
end if


%>
<html>
<head>
<title>Basket Lummen - Tegenstanders</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style>
body {
	background-image: url(img/logogrijsgroot.gif);
	background-position: 490px 10px;
	background-repeat: no-repeat;
}
</style>
</head>

<body>

<%
mn = trim(request("mn"))
if mn <> "" then
	toon=2%>
	<!--#include file="inc/header.inc"-->
	<!--#include file="inc/menu.inc"-->
	<p>&nbsp;</p><p>&nbsp;</p>
<%else
	sqlString= "SELECT stamnr, naam FROM tblClubs WHERE soort < 4 ORDER BY soort, naam"
	rs.open sqlString%>
	<p align="center">
		<form>
		<select onchange=location=this.options[this.selectedIndex].value;>
			<option>Andere tegenstanders</option>
			<%while not rs.eof%>
				<option value="tegenstanders.asp?stamnr=<%=rs("stamnr")%>"><%=rs("naam")%></option>
				<%rs.movenext
			wend
			rs.close%>
		</select>
		</form>
	</p>
<%end if

sqlString = "SELECT stamnr, naam, kortenaam, website, shirtkleur, shortkleur, tblSporthallen.sporthalnr, sporthalnaam, sporthaladres, tblGemeenten.postnr, gemeente " &_ 
			"FROM (tblSporthallen INNER JOIN tblClubs ON tblSporthallen.sporthalnr = tblClubs.sporthalnr) INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.Postnr " &_ 
			"WHERE stamnr = " & stamnr
rs.open sqlString

if rs.eof then%>
	<p>Club niet gevonden</p>
<%else%>
	<table align="center" cellspacing="0" border="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td nowrap align="center" class="NieuwsTitels" colspan="2"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=rs("naam")%></td>
	</tr>
	  <tr valign="top"> 
		<td nowrap width="120" style="border-top: 1px solid #000099;">Stamnummer</td>
		<td nowrap style="border-top: 1px solid #000099;"><%=rs("stamnr")%></td>
	  </tr>
	  <tr valign="top"> 
		<td nowrap width="120" style="border-top: 1px solid #000099;">Sporthal</td>
		<td style="border-top: 1px solid #000099;"><%=rs("sporthalnaam")%>, <%=rs("sporthaladres")%>, <%=rs("postnr")%>&nbsp;<%=rs("gemeente")%>
		<b><a href="#" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>','','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=750,height=600');return(false)">(plan)</a></b>
		</td>
	  </tr>
	  <tr valign="top"> 
		<td nowrap width="120" style="border-top: 1px solid #000099;">Kleuren</td>
		<td nowrap style="border-top: 1px solid #000099;">
			<table cellpadding="0" cellspacing="0"><tr><td bgcolor="<%=rs("shirtkleur")%>"><img src="img/shirt.gif"></td></tr><tr><td bgcolor="<%=rs("shortkleur")%>"><img src="img/short.gif"></td></tr></table>
		</td>
	  </tr>
	  <tr valign="top"> 
		<td nowrap height="24" width="120" style="border-top: 1px solid #000099;">Website</td>
		<td nowrap height="24" style="border-top: 1px solid #000099;"><a href="<%=rs("website")%>" target="_blank" class="tgstrechts"><b><%=rs("website")%></b></a>&nbsp;</td>
	  </tr>
	  <tr valign="top"> 
		<td nowrap width="120" style="border-top: 1px solid #000099;">Palmares</td>
		<td nowrap style="border-top: 1px solid #000099;">
		<%rs.close
		sqlString = "SELECT seizoen, plaats, reeks, opmerking FROM tblSeizoenen INNER JOIN tblPalmares ON tblSeizoenen.seizoennr = tblPalmares.seizoennr " &_ 
					"WHERE stamnr = " & stamnr & " ORDER BY tblSeizoenen.seizoennr"
		rs.open sqlString	
		while not rs.eof%>
			<%=rs("seizoen")%>:
			<%if isnull(rs("plaats")) or rs("plaats") = "" then
				%>? <%
			else
				%><%=rs("plaats")%>e <%
			end if
			%>in <%=rs("reeks")%>
			<%if not isnull(rs("opmerking")) and rs("opmerking") <> "" then%>
				(<%=rs("opmerking")%>)
			<%end if%>
			<br>
			<%rs.movenext
		wend%>
		</td>
	  </tr>	 
	  <tr valign="top"> 
		<td nowrap width="120" style="border-top: 1px solid #000099;">Confrontaties<br>
		<%rs.close
			sqlString = "SELECT datum, kortenaam, thuis_uit, uitsl_thuis, uitsl_uit, opmerking " &_ 
						"FROM tblClubs INNER JOIN tblConfrontaties ON tblClubs.stamnr = tblConfrontaties.stamnr " &_ 
						"WHERE tblConfrontaties.stamnr = " & stamnr & " ORDER BY datum"
			rs.open sqlString
			winst = 0
			verlies = 0
			strToon = ""	
			while not rs.eof
				strToon = strToon & "<tr><td width=150>" & day(rs("datum"))& "&nbsp;" & monthname(month(rs("datum"))) & "&nbsp;" & year(rs("datum")) & "</td><td>"
				if rs("thuis_uit") = "t" then
					if rs("uitsl_thuis") > rs("uitsl_uit") then
						winst = winst + 1
						strToon = strToon &  "<b>Lummen</b> - " & rs("kortenaam")
					elseif rs("uitsl_thuis") < rs("uitsl_uit") then
						verlies = verlies + 1
						strToon = strToon &  "Lummen - <b>" & rs("kortenaam") &"</b>"
					else
						strToon = strToon &  "Lummen - " & rs("kortenaam")
					end if						
				else
					if rs("uitsl_thuis") > rs("uitsl_uit") then
						verlies = verlies + 1
						strToon = strToon & "<b>" & rs("kortenaam") & "</b> - Lummen"
					elseif rs("uitsl_thuis") < rs("uitsl_uit") then
						winst = winst + 1
						strToon = strToon & rs("kortenaam") & " - <b>Lummen</b>"
					else
						strToon = strToon & rs("kortenaam") & " - Lummen"
					end if						
				end if
				if not isnull(rs("uitsl_thuis")) and rs("uitsl_thuis") <> "" then
					strToon = strToon & "&nbsp;" & rs("uitsl_thuis") & " - " & rs("uitsl_uit")
				end if
				if not isnull(rs("opmerking")) and rs("opmerking") <> "" then
					strToon = strToon & " <font size=1>("& rs("opmerking") & ")</font>"
				end if
				strToon = strToon & "</td></tr>"
				rs.movenext
			wend%>
			(<%=winst%>-<%=verlies%>)
		</td>
		<td nowrap style="border-top: 1px solid #000099;">
			<table cellpadding="0" cellspacing="0"><%=strToon%>
			</table>
		</td>
	</tr>	
	</table>
	<p></p>
	<%rs.close
	sqlString = "SELECT coach, spelernr, voornaam, tblSpelers.naam, gebjaar, lengte " &_ 
				"FROM tblClubs INNER JOIN tblSpelers ON tblClubs.stamnr = tblSpelers.stamnr " &_ 
				"WHERE tblSpelers.stamnr = " & stamnr & " ORDER BY spelernr, tblSpelers.naam, voornaam"
	rs.open sqlString
	
	if not rs.eof then%>
			<table align="center" cellspacing="0" border="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
			<tr bgcolor="#DDDDDD"> 
			  <td nowrap align="center" class="NieuwsTitels" colspan="5"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Coach: <%=rs("coach")%></td>
			</tr>
		<%while not rs.eof%>
				<tr> 
				  <td width="30" height="20" align="center" nowrap style="border-top: 1px solid #000099;">
					<%if rs("spelernr") < 99 then%>
						<%=rs("spelernr")%>
					<%end if%>&nbsp;
				  </td>
				  <td width="115" nowrap style="border-top: 1px solid #000099;"><%=rs("voornaam")%></td>
				  <td width="115" nowrap style="border-top: 1px solid #000099;"><%=rs("naam")%></td>
				  <td width="70" height="20" align="center" nowrap style="border-top: 1px solid #000099;"><%=rs("gebjaar")%>&nbsp;</td>
				  <td width="70" align="center" nowrap style="border-top: 1px solid #000099;"><%=rs("lengte")%>&nbsp;</td>
				</tr>
			<%rs.movenext
		wend%>
		</table>
	<%end if
end if%>
</body>

</html>
