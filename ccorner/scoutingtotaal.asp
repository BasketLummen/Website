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
<title>Basket Lummen - Scouting</title>
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
	if csng(waarde) > 0 then
		contr_nul = round(waarde,1)
	else
		contr_nul = "&nbsp;"
	end if
end function
function contr_nul0(waarde)
	if csng(waarde) > 0 then
		contr_nul0 = round(waarde,1)
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
<%
'SCOUTING PER WEDSTRIJD
ploegid = trim(request("ploeg"))
if ploegid = "" or isnull(ploegid) then ploegid =  1
sorteer = trim(request("ord"))
if sorteer = "" or isnull(sorteer) then sorteer = 0

dim ord(12)
ord(0) = "scoutingnr"
ord(1) = "punten DESC"
ord(2) = "ressteals DESC"
ord(3) = "resassists DESC"
ord(4) = "resoffreb DESC"
ord(5) = "resdefreb DESC"
ord(6) = "resblocks DESC"
ord(7) = "resturnovers DESC"
ord(8) = "resfouten DESC"
ord(9) = "resprovoked DESC"
ord(10) = "restijd DESC"
ord(11) = "resrating DESC"

dim lijst(4)
lijst(0) = "Totaal"
lijst(1) = "Gemiddelde"
lijst(2) = "Thuis"
lijst(3) = "Uit"

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
	<table>
    <!--tr>
    <td colspan="2">
    <a href="scoutingtotaal.asp?ploeg=1" class="mail"><font size="3"<%if ploegid=1 then response.Write(" color='#FF0000'")%>>A-ploeg</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="scoutingtotaal.asp?ploeg=2" class="mail"><font size="3"<%if ploegid=2 then response.Write(" color='#FF0000'")%>>B-ploeg</font></a><br><br>
    </td>
    </tr-->
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
	'	sqlstring = sqlstring & "AND (scoutingnr > 100 and scoutingnr < 200) OR id = 157 or id = 127 or id = 68 "
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
		rs.close%>
	</select>
	</form></td>
	<%end if%><td align="right" width="300">
<a href="scoutingtotaalexcel.asp?ploeg=<%=ploegid%>"><img src="../img/msexcel.gif" border="0" alt="Download deze pagina in excel" /></a>

</td>
	</tr></table>
	<%
	'if ploegid = 1 then
	'	toonwedstrijden = "AND ((wedstrijd > 31101000 AND wedstrijd < 31101999) or wedstrijd = 390117) "
	'elseif ploegid = 2 then
	'	toonwedstrijden = "AND ((wedstrijd > 31202000 AND wedstrijd < 31202999) or wedstrijd = 390141) "
	'end if
	dim sqlstr(4)
	'totaal alle wedstrijden
	sqlstr(0) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, Sum(eenpscore) AS reseenpscore, " &_
				"Sum(eenppoging) AS reseenppoging, Sum(tweepscore) AS restweepscore, Sum(tweeppoging) AS restweeppoging, "&_
				"Sum(driepscore) AS resdriepscore, Sum(drieppoging) AS resdrieppoging, Sum(steals) AS ressteals, "&_
				"sum(assists) AS resassists, Sum(offreb) AS resoffreb, Sum(defreb) AS resdefreb, Sum(blocks) AS resblocks, "&_
				"Sum(turnovers) AS resturnovers, Sum(fouten) AS resfouten, Sum(provoked) AS resprovoked, "&_
				"Sum(tijd) AS restijd, Sum(rating) AS resrating, (Sum(eenpscore) + Sum(tweepscore)*2 + Sum(driepscore)*3) AS punten  "&_
				"FROM tblscouting, tblleden where (speler = id) " & toonwedstrijden &_
				"GROUP BY id, voornaam, naam, speler, scoutingnr " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	'gemiddelde per wedstrijd
	sqlstr(1) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, "&_
				"avg(tijd) AS restijd, avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten  "&_
				"FROM tblscouting, tblleden where (speler = id) " & toonwedstrijden &_
				"GROUP BY id, voornaam, naam, speler, scoutingnr " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	'thuiswedstrijden
	sqlstr(2) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, avg(tijd) AS restijd, "&_
				"avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten, thuisploeg  "&_
				"FROM tblscouting, tblleden, tblscoutingwedstr where (speler = id) AND wedstrijdid = wedstrijd " & toonwedstrijden &_
				"AND thuisploeg Like 'Basket Lummen%' GROUP BY id, voornaam, naam, speler, scoutingnr, thuisploeg " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	'uitwedstrijden
	sqlstr(3) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, avg(tijd) AS restijd, "&_
				"avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten, uitploeg  "&_
				"FROM tblscouting, tblleden, tblscoutingwedstr where (speler = id) AND wedstrijdid = wedstrijd " & toonwedstrijden &_
				"AND uitploeg Like 'Basket Lummen%' GROUP BY id, voornaam, naam, speler, scoutingnr, uitploeg " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	
	for i = 0 to 3 %>
		<p class="NieuwsTitels"><font size="3"><%=lijst(i)%></font></p>
		<%rs.open sqlstr(i)%>
		<table cellspacing="0">
		<tr>
			<th width="130" align="center"><a href="scoutingtotaal.asp?ord=0&ploeg=<%=ploegid%>">Naam</a></th>
			<th width="30" align="center">#</th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=1&ploeg=<%=ploegid%>">TOT</a></th>
			<th width="60" align="center" colspan="2">1p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">2p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">3p</th>
			<th width="30" align="center">%</th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=2&ploeg=<%=ploegid%>">ST</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=3&ploeg=<%=ploegid%>">AS</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=4&ploeg=<%=ploegid%>">OR</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=5&ploeg=<%=ploegid%>">DR</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=6&ploeg=<%=ploegid%>">BL</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=7&ploeg=<%=ploegid%>">TO</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=8&ploeg=<%=ploegid%>">FO</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=9&ploeg=<%=ploegid%>">PR</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=10&ploeg=<%=ploegid%>">TI</a></th>
			<th width="30" align="center"><a href="scoutingtotaal.asp?ord=11&ploeg=<%=ploegid%>">+/-</a></th>
		</tr>
		<%while not rs.eof%>
			<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand" onClick="document.location='scoutingspeler.asp?spelerid=<%=rs("id")%>&ploeg=<%=ploegid%>'">
				<td style="border-left: #AAAAAA solid 1px;" class="scout">
					<b><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></b>
				</td>
				<td width="30" align="center" class="scout"><%=rs("aantal")%></td>
				<td width="30" align="center" class="scout">
					<%if csng(rs("restijd")) > 0 then%>
						<%=contr_nul0(rs("punten"))%>
					<%else%>
						<%=contr_nul(rs("punten"))%>
					<%end if
					som = 0%>	
				</td>
				<td width="30" align="center" class="scout">
					<%if csng(rs("reseenppoging")) > 0 then%>
						<%=contr_nul0(rs("reseenpscore"))%>
					<%else%>
						<%=contr_nul(rs("reseenpscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("reseenppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if csng(rs("reseenppoging")) > 0 then%>
					<%=round((csng(rs("reseenpscore"))/csng(rs("reseenppoging")))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if csng(rs("restweeppoging")) > 0 then%>
						<%=contr_nul0(rs("restweepscore"))%>
					<%else%>
						<%=contr_nul(rs("restweepscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("restweeppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if csng(rs("restweeppoging")) > 0 then%>
					<%=round((csng(rs("restweepscore"))/csng(rs("restweeppoging")))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if csng(rs("resdrieppoging")) > 0 then%>
						<%=contr_nul0(rs("resdriepscore"))%>
					<%else%>
						<%=contr_nul(rs("resdriepscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resdrieppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if csng(rs("resdrieppoging")) > 0 then%>
					<%=round((csng(rs("resdriepscore"))/csng(rs("resdrieppoging")))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("ressteals"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resassists"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resoffreb"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resdefreb"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resblocks"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resturnovers"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resfouten"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("resprovoked"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs("restijd"))%></td>
				<td width="30" align="center" class="scout">
				<%if csng(rs("restijd")) > 0 and rs("resrating") <> "" then%>
					<%=round(csng(rs("resrating")),1)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
			</tr>
			<%rs.movenext
		wend
		rs.close
		%>
		</table>
	<%next
end if%>
</div>
</body>
</html>
<%
con.close%>
