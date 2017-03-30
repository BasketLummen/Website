<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authorizedUsers2="22,205,450"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1)  Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%>
	<html>
	<head>
	<title>Basket Lummen - scouting</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css" />
<style>
	select, td.scout {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size: 10px;
		border-bottom: #AAAAAA solid 1px;
		border-right: #AAAAAA solid 1px;
	}
	th {
		font-family: Verdana, Arial, Helvetica, sans-serif;
		font-size: 10px;
		background-color: #CCCCCC;
	}
</style>
	<%
	function contr_nul(waarde)
		waarde = cint(0&waarde)
		if waarde > 0 then
			contr_nul = waarde
		else
			contr_nul = "&nbsp;"
		end if
	end function
	function contr_nul0(waarde)
		waarde = cint(0&waarde)
		if waarde > 0 then
			contr_nul0 = waarde
		else
			contr_nul0 = 0
		end if
	end function
	
	
	%>
	</head>
	<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<p class="NieuwsTitels"><font size="3">Scouting per match</font></p>
	<%
	'SCOUTING PER WEDSTRIJD
	ploegid = trim(request("ploeg"))
	if ploegid = "" or isnull(ploegid) then ploegid =  1
	sorteer = trim(request("ord"))
	if sorteer = "" or isnull(sorteer) then sorteer = 0
	
	dim ord(12)
	ord(0) = "right(scoutingnr,2)"
	ord(1) = "(eenpscore + tweepscore*2 + driepscore*3) DESC"
	ord(2) = "steals DESC"
	ord(3) = "assists DESC"
	ord(4) = "offreb DESC"
	ord(5) = "defreb DESC"
	ord(6) = "blocks DESC"
	ord(7) = "turnovers DESC"
	ord(8) = "fouten DESC"
	ord(9) = "provoked DESC"
	ord(10) = "tijd DESC"
	ord(11) = "rating DESC"
	
	matchid = trim(request("matchid"))
	if matchid = "" or isnull(matchid) then
		sqlstring = "SELECT DISTINCT wedstrijdid, ploeg, datum " &_
					"FROM tblscouting INNER JOIN tblscoutingwedstr ON tblscouting.wedstrijd = tblscoutingwedstr.wedstrijdid " &_
					"WHERE ploeg = " & ploegid & " " &_
					"ORDER BY datum DESC LIMIT 0,1"
		rs.open sqlstring
		if not rs.eof then
			matchid = rs("wedstrijdid")
		end if
		rs.close
	end if

	sqlstring = "SELECT DISTINCT wedstrijdid, datum, thuisploeg, uitploeg, thuisresult, uitresult " &_
				"FROM tblscoutingwedstr INNER JOIN tblscouting ON tblscoutingwedstr.wedstrijdid = tblscouting.wedstrijd " &_
				"WHERE ploeg = "&ploegid&" ORDER BY datum DESC"
	rs.open sqlstring
	if rs.eof then
		%>Geen scouting voor deze ploeg.<%
	else%>
		<table><tr>
		<td>
		<form name="jump">
		<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
			<option>Toon scouting per wedstrijd</option>
			<option value="scoutingtotaal.asp?ploeg=<%=ploegid%>">Overzicht</option>
			<%while not rs.eof%>
				<option value="scoutingmatch.asp?matchid=<%=rs("wedstrijdid")%>&ploeg=<%=ploegid%>">
				<%if rs("wedstrijdid") = int(matchid) then
					strwedstrijd = day(rs("datum"))&" "&monthname(month(rs("datum")))&", "&_
					rs("thuisploeg")&" - "&rs("uitploeg")&" "&rs("thuisresult")&"-"&rs("uitresult")
				end if%>
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
		'	sqlstring = sqlstring & "AND (scoutingnr > 200 and scoutingnr < 300) OR id = 126 OR id = 4 or id = 164 OR id = 174 " 
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
			rs.close%>
		</select>
		</form></td>
		<%end if%>
		<td align="right" width="300">
<a href="scoutingmatchexcel.asp?ploeg=<%=ploegid%>"><img src="../img/msexcel.gif" border="0" alt="Download alle wedstrijden in excel" /></a>

</td></tr></table><p class="NieuwsTitels"><font size="2"><%=strwedstrijd%></font></p>
		<%
		sqlstring = "SELECT id, voornaam, naam, eenpscore, eenppoging, tweepscore, tweeppoging, driepscore, drieppoging, " &_
					"steals, assists, offreb, defreb, blocks, turnovers, fouten, provoked, "&_
					"tijd, rating, scoutingnr, (eenpscore + tweepscore*2 + driepscore*3) AS punten " &_
					"FROM tblleden LEFT JOIN (SELECT * FROM tblscouting WHERE wedstrijd = "&matchid&") " &_
					"AS qryscouting ON tblleden.id = qryscouting.speler WHERE scoutingnr Is Not Null ORDER BY scoutingnr"
		'if ploegid = 1 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 100 and scoutingnr < 200) OR id = 157 OR id = 127 or id = 68 "
		'elseif ploegid = 2 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 200 and scoutingnr < 300) OR id = 126 OR id = 4 OR id = 164 OR id = 174 " 
		'end if	
		'sqlstring = sqlstring & "ORDER BY " & ord(sorteer) & ", naam, voornaam"
		rs.open sqlstring%>
		<table cellspacing="0">
		<tr>
			<th width="130" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=0">Naam</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=1">PTN</a></th>
			<th width="60" align="center" colspan="2">1p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">2p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">3p</th>
			<th width="30" align="center">%</th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=2">ST</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=3">AS</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=4">OR</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=5">DR</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=6">BL</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=7">TO</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=8">FO</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=9">PR</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=10">TI</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ord=11">RA</a></th>
		</tr>
		<%while not rs.eof%>
			<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand" onClick="document.location='scoutingspeler.asp?spelerid=<%=rs("id")%>&ploeg=<%=ploegid%>'">
				<td style="border-left: #AAAAAA solid 1px;" class="scout">
					<%if rs("tijd") > 0 then%>
						<b><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></b>
					<%else%>
						<font color="#CCCCCC"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></font>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if rs("tijd") > 0 then%>
						<%=contr_nul0(rs("punten"))%>
					<%else%>
						<%=contr_nul(rs("punten"))%>
					<%end if
					som = 0%>	
				</td>
				<td width="30" align="center" class="scout">
					<%if rs("eenppoging") > 0 then%>
						<%=contr_nul0(rs("eenpscore"))%>
					<%else%>
						<%=contr_nul(rs("eenpscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("eenppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs("eenppoging") > 0 then%>
					<%=round((rs("eenpscore")/rs("eenppoging"))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if rs("tweeppoging") > 0 then%>
						<%=contr_nul0(rs("tweepscore"))%>
					<%else%>
						<%=contr_nul(rs("tweepscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("tweeppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs("tweeppoging") > 0 then%>
					<%=round((rs("tweepscore")/rs("tweeppoging"))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if rs("drieppoging") > 0 then%>
						<%=contr_nul0(rs("driepscore"))%>
					<%else%>
						<%=contr_nul(rs("driepscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("drieppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs("drieppoging") > 0 then%>
					<%=round((rs("driepscore")/rs("drieppoging"))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("steals"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("assists"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("offreb"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("defreb"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("blocks"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("turnovers"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("fouten"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("provoked"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("tijd"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs("tijd") > 0 and rs("rating") <> "" then%>
					<%=rs("rating")%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
			</tr>
			<%rs.movenext
		wend
		rs.close
		%>
		<tr>
			<th width="130" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=0">Naam</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=1">PTN</a></th>
			<th width="60" align="center" colspan="2">1p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">2p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">3p</th>
			<th width="30" align="center">%</th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=2">ST</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=3">AS</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=4">OR</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=5">DR</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=6">BL</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=7">TO</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=8">FO</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=9">PR</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=10">TI</a></th>
			<th width="30" align="center"><a href="scoutingmatch.asp?matchid=<%=matchid%>&ploeg=<%=ploegid%>&ord=11">RA</a></th>
		</tr>
		</table>

	<%end if%>
</div>
</body>
</html>
<%
con.close%>
