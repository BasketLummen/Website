<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
MM_authFailedURL="../login.asp"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (false Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
%>
<%
stamnr = trim(request("stamnr"))
toevoegen = trim(request("toevoegen"))
if not isnull(toevoegen) and toevoegen <> "" then
	naam = trim(request("naam"))
	kortenaam = trim(request("kortenaam"))
	sporthal1 = trim(request("sporthal1"))
	sporthal2 = trim(request("sporthal2"))
	shirt = trim(request("shirt"))
	short = trim(request("short"))
	website = trim(request("website"))
	sqlString = "INSERT INTO tblClubs VALUES(" & stamnr & ", '" & naam & "', '" & kortenaam & "', " &_ 
				"'" & website & "', " & sporthal1 & ", null, '" & shirt & "', '" & short & "', '" & coach & "', 4)"
	con.execute sqlString
end if
set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con
%>
<html>
<head>
<title>Tegenstander wijzigen</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<p align="center">
<form name="jump">
<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<option>Kies een tegenstander</option>
	<%sqlString = "SELECT stamnr, naam, kortenaam FROM tblClubs ORDER BY stamnr"
	rs.open sqlString
	while not rs.eof%>
		<option value="tegenstanderwijzigen.asp?stamnr=<%=rs("stamnr")%>"><%=rs("stamnr")%>&nbsp;<%=rs("naam")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</form>
</p>
<%if not isnull(stamnr) and stamnr <> "" then%>
<form method="post" action="tegenstanderbeheer.asp" name="tgst">
	<input type="hidden" name="stamnr" value="<%=stamnr%>">
	<%sqlString = "SELECT stamnr, naam, kortenaam, sporthalnr, sh2, website, shirtkleur, shortkleur, soort " &_ 
				"FROM tblClubs WHERE stamnr = " & stamnr
	rs.open sqlString
	
	if rs.eof then%>
		<p>Club niet gevonden</p>
	<%else%>
		<table border="0" align="center" cellpadding="5" cellspacing="0" style="border: 2px solid #DDDDDD;">
		  <tr> 
			<td width="120" valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Stamnummer</td>
			<td style="border-top: 2px solid #DDDDDD;"><%=rs("stamnr")%></td>
		  </tr>
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Volledige naam</td>
			<td style="border-top: 2px solid #DDDDDD;"><input ntype="text" name="naam" value="<%=rs("naam")%>" size="50"></td>
		  </tr>
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Korte naam</td>
			<td style="border-top: 2px solid #DDDDDD;"><input type="text" name="kortenaam" value="<%=rs("kortenaam")%>"></td>
		  </tr>
		  <tr> 
			<td width="120" valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Sporthal 1</td>
			<td style="border-top: 2px solid #DDDDDD;">
			<select name="sporthal1">
				<%sqlString = "SELECT sporthalnr, sporthalnaam, sporthaladres, tblGemeenten.postnr, gemeente FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.postnr ORDER BY tblGemeenten.postnr, sporthalnaam"
				rs1.open sqlString
				while not rs1.eof%>		
					<option value="<%=rs1("sporthalnr")%>"<%
					if rs1("sporthalnr") = rs("sporthalnr") then
						%>selected<%
					end if
					%>><%=rs1("postnr")%>&nbsp;<%=rs1("gemeente")%>, <%=rs1("sporthalnaam")%>, <%=rs1("sporthaladres")%></option>
					<%rs1.movenext
				wend
				rs1.close%>
			</select>
			</td>
		  </tr>
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Sporthal 2</td>
			<td style="border-top: 2px solid #DDDDDD;">
			<select name="sporthal2">
				<option value=""></option>		
				<%sqlString = "SELECT sporthalnr, sporthalnaam, sporthaladres, tblGemeenten.postnr, gemeente FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.postnr ORDER BY tblGemeenten.postnr, sporthalnaam"
				rs1.open sqlString
				while not rs1.eof%>
					<option value="<%=rs1("sporthalnr")%>"<%
					if rs1("sporthalnr") = rs("sh2") then
						%>selected<%
					end if
					%>><%=rs1("postnr")%>&nbsp;<%=rs1("gemeente")%>, <%=rs1("sporthalnaam")%>, <%=rs1("sporthaladres")%></option>
					<%rs1.movenext
				wend
				rs1.close%>
			</select>
			</td>
		  </tr>
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Kleuren</td>
			<td style="border-top: 2px solid #DDDDDD;">
				shirt <input name="shirt" type="text" value="<%=rs("shirtkleur")%>" size="10"> - 
				short <input type="text" name="short" value="<%=rs("shortkleur")%>" size="10">
			</td>
		  </tr>
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Website</td>
			<td style="border-top: 2px solid #DDDDDD;">
			<input name="website" type="text" value="<%=rs("website")%>" size="70"></td>
		  </tr>
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Soort</td>
			<td style="border-top: 2px solid #DDDDDD;">
			<select name="soort">
				<option value="1"<%
					if rs("soort") = 1 then
						%>selected<%
					end if
					%>>1 - competitie</option>
				<option value="2"<%
					if rs("soort") = 2 then
						%>selected<%
					end if
					%>>2 - beker</option>			
				<option value="3"<%
					if rs("soort") = 3 then
						%>selected<%
					end if
					%>>3 - oefenmatch</option>
				<option value="4"<%
					if rs("soort") = 4 then
						%>selected<%
					end if
					%>>4 - geen confrontatie</option>
				<option value="5"<%
					if rs("soort") = 5 then
						%>selected<%
					end if
					%>>5 - gestopt</option>
			</select>
			</td>
		  </tr>
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Palmares</td>
			<td style="border-top: 2px solid #DDDDDD;">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td>Seizoen</td>
					<td>Plaats</td>
					<td>Reeks</td>
					<td>Opmerking</td>					
				</tr>
			<%rs.close
			sqlString = "SELECT seizoennr, seizoen FROM tblSeizoenen WHERE seizoennr > 21 ORDER BY seizoennr "
			rs.open sqlString
			while not rs.eof%>
				<tr>
				<td><%=rs("seizoen")%></td>			
				<%sqlString = "SELECT plaats, reeks, opmerking FROM tblPalmares " &_ 
							  "WHERE stamnr = " & stamnr & " AND seizoennr = " & rs("seizoennr")
				rs1.open sqlString
				if rs1.eof then%>
					<td><input name="plaats<%=rs("seizoennr")%>" type="text" size="3">e in</td>
					<td><input name="reeks<%=rs("seizoennr")%>" type="text"></td>
					<td><input name="opmerkingp<%=rs("seizoennr")%>" type="text"></td></tr>
				<%else%>
					<td><input name="plaats<%=rs("seizoennr")%>" type="text" value="<%=rs1("plaats")%>" size="3">e in</td>
					<td><input name="reeks<%=rs("seizoennr")%>" type="text" value="<%=rs1("reeks")%>"></td>
					<td><input name="opmerkingp<%=rs("seizoennr")%>" type="text" value="<%=rs1("opmerking")%>"></td></tr>
				<%end if
				rs1.close
				rs.movenext
			wend
			rs.close%>
			</table>
			</td>
		  </tr>	 
		  <tr> 
			<td valign="top" nowrap bgcolor="#DDDDDD" class="NieuwsTitels" style="border-top: 2px solid #DDDDDD;">&nbsp;<img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> Confrontaties</td>
			<td style="border-top: 2px solid #DDDDDD;">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td>datum</td>
					<td align="center">T</td>
					<td align="center">U</td>
					<td align="center" colspan="2">Uitslag</td>
					<td>Opmerking</td>
				</tr>
			<%sqlString = "SELECT matchnr, datum, thuis_uit, uitsl_thuis, uitsl_uit, opmerking FROM tblConfrontaties WHERE stamnr = " & stamnr & " ORDER BY datum"
			rs.open sqlString			
			while not rs.eof%>
				<tr>
					<td><input type="text" name="datum<%=rs("matchnr")%>" value="<%=rs("datum")%>" size="10"></td>
					<td><input type="radio" name="thuis_uit<%=rs("matchnr")%>" value="t" <%
					if rs("thuis_uit") = "t" then
						%>checked<%
					end if
					%>></td>
					<td><input type="radio" name="thuis_uit<%=rs("matchnr")%>" value="u" <%
					if rs("thuis_uit") = "u" then
						%>checked<%
					end if
					%>></td>
					<td><input type="text" name="uitsl_thuis<%=rs("matchnr")%>" value="<%=rs("uitsl_thuis")%>" size="2"></td>
					<td><input type="text" name="uitsl_uit<%=rs("matchnr")%>" value="<%=rs("uitsl_uit")%>" size="2"></td>					
					<td><input type="text" name="opmerkingc<%=rs("matchnr")%>" value="<%=rs("opmerking")%>" size="10"></td>
				</tr>
				<%rs.movenext
			wend
			rs.close
			for i = 1 to 2%>
			<tr>
				<td><input type="text" name="datumn<%=i%>" size="10"></td>
				<td><input type="radio" name="thuis_uitn<%=i%>" value="t"></td>
				<td><input type="radio" name="thuis_uitn<%=i%>" value="u"></td>
				<td><input type="text" name="uitsl_thuisn<%=i%>" size="2"></td>
				<td><input type="text" name="uitsl_uitn<%=i%>" size="2"></td>					
				<td><input type="text" name="opmerkingcn<%=i%>" size="10"></td>
			</tr>
			<%next%>
			</table>
			</td>
		</tr>	
  </table>
		<p></p>
		<%
		sqlString = "SELECT spelernr, voornaam, naam, gebjaar, lengte " &_ 
					"FROM tblSpelers " &_ 
					"WHERE stamnr = " & stamnr & " ORDER BY spelernr, naam, voornaam"
		rs.open sqlString%>
		<table align="center" border="0">
		  <tr bgcolor="#DDDDDD" class="NieuwsTitels" > 
					<td width="30" align="center" nowrap>nr</td>
					<td height="20" align="left" nowrap>voornaam</td>
					<td height="20" align="left" nowrap>naam</td>
					<td width="70" height="20" align="center" nowrap>geb.jaar</td>
					<td width="70" align="center" nowrap>lengte</td>
		  </tr>
		<%i=1
		while not rs.eof%>
				<tr> 
				  <td width="30" height="20" align="center" nowrap><input type="text" name="spelernr<%=i%>" value="<%=rs("spelernr")%>" size="2"></td>
				  <td height="20" nowrap><input type="text" name="voornaam<%=i%>" value="<%=rs("voornaam")%>"></td>
				  <td height="20" nowrap><input type="text" name="naam<%=i%>" value="<%=rs("naam")%>"></td>
				  <td width="70" height="20" align="center" nowrap><input type="text" name="gebjaar<%=i%>" value="<%=rs("gebjaar")%>" size="5"></td>
				  <td width="70" align="center" nowrap><input type="text" name="lengte<%=i%>" value="<%=rs("lengte")%>" size="5"></td>
				</tr>
			<%rs.movenext
			i = i + 1
		wend
		for i = i to 15%>
				<tr> 
				  <td width="30" height="20" align="center" nowrap><input type="text" name="spelernr<%=i%>" size="2"></td>
				  <td height="20" nowrap><input type="text" name="voornaam<%=i%>"></td>
				  <td height="20" nowrap><input type="text" name="naam<%=i%>"></td>
				  <td width="70" height="20" align="center" nowrap><input type="text" name="gebjaar<%=i%>" size="5"></td>
				  <td width="70" align="center" nowrap><input type="text" name="lengte<%=i%>" size="5"></td>
				</tr>			
		<%next
		rs.close
		sqlString = "SELECT coach FROM tblClubs WHERE stamnr = " & stamnr
		rs.open sqlString%>
		<tr><td height="20" colspan="5" nowrap>Coach: 
		<%if rs.eof then%>
			<input type="text" name="coach">
		<%else%>
			<input type="text" name="coach" value="<%=rs("coach")%>">
		<%end if
		rs.close%>
		</td></tr>
		</table>
	<p align="center"><input type="submit" value="opslaan"></p>	
	<script language="javascript">
	  document.tgst.naam.focus();
	</script>
	<%end if%>
</form>
<%end if
con.close%>
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>
</body>
</html>