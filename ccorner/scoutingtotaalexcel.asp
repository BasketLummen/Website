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

Session.LCID = 2067

Response.Buffer = True


set con = server.createobject("ADODB.Connection")
con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=basketlummen; pwd=ba7863; database=basketlummen; option=3; port=3306;"

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition", "attachment; filename=scouting_totaal.xls" 

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


'SCOUTING PER WEDSTRIJD
ploegid = trim(request("ploeg"))
if ploegid = "" or isnull(ploegid) then ploegid =  1

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
				"FROM tblscouting, tblleden where (speler = id)  " & toonwedstrijden &_
				"GROUP BY id, voornaam, naam, speler, scoutingnr " &_
				"ORDER BY scoutingnr"
	'gemiddelde per wedstrijd
	sqlstr(1) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, "&_
				"avg(tijd) AS restijd, avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten  "&_
				"FROM tblscouting, tblleden where (speler = id)  " & toonwedstrijden &_
				"GROUP BY id, voornaam, naam, speler, scoutingnr " &_
				"ORDER BY scoutingnr"
	'thuiswedstrijden
	sqlstr(2) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, avg(tijd) AS restijd, "&_
				"avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten, thuisploeg  "&_
				"FROM tblscouting, tblleden, tblscoutingwedstr where (speler = id) AND wedstrijdid = wedstrijd  " & toonwedstrijden &_
				"AND thuisploeg Like 'Basket Lummen%' GROUP BY id, voornaam, naam, speler, scoutingnr, thuisploeg " &_
				"ORDER BY scoutingnr"
	'uitwedstrijden
	sqlstr(3) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, avg(tijd) AS restijd, "&_
				"avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten, uitploeg  "&_
				"FROM tblscouting, tblleden, tblscoutingwedstr where (speler = id) AND wedstrijdid = wedstrijd  " & toonwedstrijden &_
				"AND uitploeg Like 'Basket Lummen%' GROUP BY id, voornaam, naam, speler, scoutingnr, uitploeg " &_
				"ORDER BY scoutingnr"
	
	for i = 0 to 3 %>
		<p><font size="3"><b><%=lijst(i)%></b></font></p>
		<%rs.open sqlstr(i)%>
		<table border="1">
		<tr>
			<th width="130" align="center">Naam</th>
			<th width="30" align="center">#</th>
			<th width="30" align="center">TOT</th>
			<th width="60" align="center" colspan="2">1p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">2p</th>
			<th width="30" align="center">%</th>
			<th width="60" align="center" colspan="2">3p</th>
			<th width="30" align="center">%</th>
			<th width="30" align="center">ST</th>
			<th width="30" align="center">AS</th>
			<th width="30" align="center">OR</th>
			<th width="30" align="center">DR</th>
			<th width="30" align="center">BL</th>
			<th width="30" align="center">TO</th>
			<th width="30" align="center">FO</th>
			<th width="30" align="center">PR</th>
			<th width="30" align="center">TI</th>
			<th width="30" align="center">+/-</th>
		</tr>
		<%while not rs.eof%>
			<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand" onClick="document.location='scoutingspeler.asp?spelerid=<%=rs("id")%>'">
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
con.close%>
