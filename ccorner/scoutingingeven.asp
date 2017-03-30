<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%>
<html>
<head>
<title>Basket Lummen - Scouting</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="../opmaak.css" rel="stylesheet" type="text/css" />
	<style>
	select, td.scout {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size: 10px;
		border-bottom: #AAAAAA solid 1px;
		border-right: #AAAAAA solid 1px;
		background-color: #FFFFFF;
	}
	th {
		font-family: Verdana, Arial, Helvetica, sans-serif;
		font-size: 10px;
		background-color: #CCCCCC;
	}
	input {
		text-align: center;
	}
	</style>
	</head>
	<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<p class="NieuwsTitels"><font size="3">Scouting toevoegen/wijzigen</font></p>
	<%
	'SCOUTING PER WEDSTRIJD
	ploegid = trim(request("ploeg"))
	if ploegid = "" or isnull(ploegid) then ploegid =  1
	
	matchid = trim(request("matchid"))
	if matchid = "" or isnull(matchid) then
		sqlstring = "SELECT wedstrijdid, ploeg, datum " &_
					"FROM tblscoutingwedstr " &_
					"WHERE ploeg = " & ploegid & " AND datum <= '"&year(date())&"-"&month(date())&"-"&day(date())&"' " &_
					"ORDER BY datum DESC LIMIT 0, 1"
		rs.open sqlstring
		if not rs.eof then
			matchid = rs("wedstrijdid")
		end if
		rs.close
	end if%>
<%sqlstring = "SELECT DISTINCT wedstrijdid, datum, thuisploeg, uitploeg, thuisresult, uitresult " &_
				"FROM tblscoutingwedstr INNER JOIN tblscouting ON tblscoutingwedstr.wedstrijdid = tblscouting.wedstrijd " &_
				"WHERE ploeg = "&ploegid&" ORDER BY datum DESC"
	rs.open sqlstring
	if rs.eof then
		%>Geen scouting voor deze ploeg.<%
	else%>
		<table>
    <tr>
    <!--td colspan="2">
    <a href="scoutingingeven.asp?ploeg=1" class="mail"><font size="3"<%if ploegid=1 then response.Write(" color='#FF0000'")%>>A-ploeg</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="scoutingingeven.asp?ploeg=2" class="mail"><font size="3"<%if ploegid=2 then response.Write(" color='#FF0000'")%>>B-ploeg</font></a><br><br>
    </td-->
    </tr>
        <tr>
		<td>
		<form name="jump">
		<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
			<option>Toon scouting per wedstrijd</option>
			<option value="scoutingtotaal.asp?ploeg=<%=ploegid%>">Overzicht</option>
			<%while not rs.eof%>
				<option value="scoutingmatch.asp?matchid=<%=rs("wedstrijdid")%>&ploeg=<%=ploegid%>">
				<%=rs("thuisploeg")%> - <%=rs("uitploeg")%> (<%=day(rs("datum"))%>/<%=month(rs("datum"))%>)</option>
				<%rs.movenext
			wend
			rs.close%>
		</select>
		</form></td>
		<%
		sqlstring = "SELECT id, naam, voornaam FROM tblleden "&_
				"WHERE scoutingnr IS NOT NULL ORDER BY scoutingnr"
		'if ploegid = 1 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 100 and scoutingnr < 200) OR id = 157 OR id = 127 or id = 68 "
		'elseif ploegid = 2 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 200 and scoutingnr < 300) OR id = 126 OR id = 4 OR id = 164 OR id = 174 " 
		'end if	
		'sqlstring = sqlstring & "ORDER BY right(scoutingnr,2)"
		rs.open sqlstring
		if not rs.eof then
		%>
		<td>
		<form name="jump1">
		<select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO">
			<option>Toon scouting per speler</option>
			<option value="scoutingtotaal.asp?ploeg=<%=ploegid%>">Overzicht</option>
			<%while not rs.eof%>
				<option value="scoutingspeler.asp?spelerid=<%=rs("id")%>&ploeg=<%=ploegid%>">
				<%=rs("voornaam") & " " & rs("naam")%></option>
				<%rs.movenext
			wend
			%>
		</select>
		</form></td>
		<%end if
		%>
		</tr></table>
	<%end if
		rs.close
		sqlstring = "SELECT wedstrijdid, datum, thuisploeg, uitploeg " &_
					"FROM tblscoutingwedstr WHERE ploeg = " & ploegid & " AND datum <= '"&year(date())&"-"&month(date())&"-"&day(date())&"' " &_
					"ORDER BY datum DESC"
		rs.open sqlstring
		
		%>
		<form name="jump2">
		<select name="menu" onChange="location=document.jump2.menu.options[document.jump2.menu.selectedIndex].value;" value="GO">
			<option>Kies wedstrijd</option>
			<%while not rs.eof%>
				<option value="scoutingingeven.asp?matchid=<%=rs("wedstrijdid")%>&ploeg=<%=ploegid%>">
				<%=rs("thuisploeg")%> - <%=rs("uitploeg")%> (<%=day(rs("datum"))%>/<%=month(rs("datum"))%>)</option>
				<%rs.movenext
			wend
			rs.close%>
		</select>
		</form>
		<form name="ingave" method="post" action="scoutingopslaan.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>">
		<%
		sqlstring = "SELECT wedstrijdid, datum, thuisploeg, uitploeg, thuisresult, uitresult " &_
					"FROM tblscoutingwedstr WHERE wedstrijdid = "&matchid
		rs.open sqlstring
		%>
		<p><%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")))%>, <%=rs("thuisploeg")%> - <%=rs("uitploeg")%>
		<input type="text" size="3" maxlength="3" name="thuisresult" value="<%=rs("thuisresult")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"> - 
		<input type="text" size="3" maxlength="3" name="uitresult" value="<%=rs("uitresult")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></p>
		
		<%rs.close
		
		
		sqlstring = "SELECT id, voornaam, naam, eenpscore, eenppoging, tweepscore, tweeppoging, driepscore, drieppoging, " &_
					"steals, assists, offreb, defreb, blocks, turnovers, fouten, provoked, "&_
					"tijd, rating, scoutingnr, (eenpscore + tweepscore*2 + driepscore*3) AS punten " &_
					"FROM tblleden LEFT JOIN (SELECT * FROM tblscouting WHERE wedstrijd = "&matchid&") " &_
					"AS qryscouting ON tblleden.id = qryscouting.speler WHERE scoutingnr Is Not Null ORDER BY scoutingnr"
		'if ploegid = 1 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 100 and scoutingnr < 200) OR id = 157 OR id = 127 or id = 68 "
		'elseif ploegid = 2 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 200 and scoutingnr < 300) OR id = 126 OR id = 4 or id = 164 OR id = 174 " 
		'end if	
		'sqlstring = sqlstring & "ORDER BY right(scoutingnr,2)"
		rs.open sqlstring%>
		<table cellspacing="0">
		<tr>
			<th width="130" align="center">Naam</th>
			<th width="30" align="center">TI</th>
			<th width="60" align="center" colspan="2">2p</th>
			<th width="60" align="center" colspan="2">3p</th>
			<th width="60" align="center" colspan="2">FT</th>
			<th width="30" align="center">OR</th>
			<th width="30" align="center">DR</th>
			<th width="30" align="center">AS</th>
			<th width="30" align="center">TO</th>
			<th width="30" align="center">ST</th>
			<th width="30" align="center">BL</th>
			<th width="30" align="center">FC</th>
			<th width="30" align="center">FD</th>
			<th width="30" align="center">+/-</th>
		</tr>
		<%while not rs.eof%>
			<tr>
				<td class="scout"><b><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></b></td>
				<td width="30" align="center" class="scout"><input type="text" name="txttijd_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("tijd")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txttweepscore_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("tweepscore")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txttweeppoging_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("tweeppoging")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtdriepscore_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("driepscore")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtdrieppoging_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("drieppoging")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txteenpscore_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("eenpscore")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txteenppoging_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("eenppoging")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtoffreb_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("offreb")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtdefreb_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("defreb")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtassists_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("assists")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtturnovers_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("turnovers")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtsteals_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("steals")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtblocks_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("blocks")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtfouten_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("fouten")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtprovoked_<%=rs("id")%>" size="1" maxlength="3" 
				value="<%=rs("provoked")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtrating_<%=rs("id")%>" size="1" maxlength="4" 
				value="<%=rs("rating")%>" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
			</tr>
			<%rs.movenext
		wend
		rs.close
		sqlstring = "SELECT id, naam, voornaam FROM tblleden "&_
		"WHERE scoutingnr IS NULL AND status = 'A' AND (functie1 = 1 OR functie2 = 1) ORDER BY naam, voornaam"
		rs.open sqlstring

		for i = 0 to 2%>
			<tr>
				<td class="scout">
				<select name="speler_x<%=i%>">
					<option></option>
					<%rs.movefirst
					while not rs.eof%>
						<option value="<%=rs("id")%>"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></option>
						<%rs.movenext
					wend%>
				</select>
				</td>
				<td width="30" align="center" class="scout"><input type="text" name="txttijd_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txttweepscore_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txttweeppoging_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtdriepscore_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtdrieppoging_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txteenpscore_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txteenppoging_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtoffreb_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtdefreb_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtassists_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtturnovers_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtsteals_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtblocks_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtfouten_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtprovoked_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
				<td width="30" align="center" class="scout"><input type="text" name="txtrating_x<%=i%>" size="1" maxlength="3" 
				onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
			</tr>
		<%next%>
		<tr>
			<th width="130">Naam</th>
			<th width="30" align="center">TI</th>
			<th width="60" align="center" colspan="2">2p</th>
			<th width="60" align="center" colspan="2">3p</th>
			<th width="60" align="center" colspan="2">1p</th>
			<th width="30" align="center">OR</th>
			<th width="30" align="center">DR</th>
			<th width="30" align="center">AS</th>
			<th width="30" align="center">TO</th>
			<th width="30" align="center">ST</th>
			<th width="30" align="center">BL</th>
			<th width="30" align="center">FC</th>
			<th width="30" align="center">FD</th>
			<th width="30" align="center">+/-</th>
		</tr>
		</table>
		<p><input type="submit" value="Opslaan" style="cursor:hand;cursor:pointer;">&nbsp;&nbsp;<input type="reset" value="Reset" style="cursor:hand;cursor:pointer;"></p>
		</form>
</td></tr></table>
</div>
</body>
</html>
<%
con.close%>
