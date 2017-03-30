<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
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
<!--#include file="connect.asp" -->
<%
Response.ContentType = "application/vnd.ms-excel"
Response.Charset = String.Empty
Response.AddHeader "Content-Disposition", "attachment; filename=basketlummen_scouting.xls" 

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
	

	
	'SCOUTING PER WEDSTRIJD
	ploegid =  1
	sorteer = trim(request("ord"))
	if sorteer = "" or isnull(sorteer) then sorteer = 0
	
	dim ord(12)
	ord(0) = "scoutingnr"
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
					"FROM tblscouting INNER JOIN tblwedstrijden ON tblscouting.wedstrijd = tblwedstrijden.wedstrijdid " &_
					"WHERE ploeg = " & ploegid & " " &_
					"ORDER BY datum DESC LIMIT 0,1"
		rs.open sqlstring
		if not rs.eof then
			matchid = rs("wedstrijdid")
		end if
		rs.close
	end if
	
	sqlstring = "SELECT DISTINCT wedstrijdid, datum, thuisploeg, uitploeg, thuisresult, uitresult " &_
				"FROM tblwedstrijden INNER JOIN tblscouting ON tblwedstrijden.wedstrijdid = tblscouting.wedstrijd " &_
				"WHERE ploeg = "&ploegid&" AND wedstrijdid = " & int(matchid)
	rs.open sqlstring
	strwedstrijd = day(rs("datum"))&" "&monthname(month(rs("datum")))&", "& rs("thuisploeg")&" - "&rs("uitploeg")&" "&rs("thuisresult")&"-"&rs("uitresult")
	%>
	<p><font size="3"><b><%=strwedstrijd%></b></font></p>
	<%

	rs.close

	
		sqlstring = "SELECT id, voornaam, naam, eenpscore, eenppoging, tweepscore, tweeppoging, driepscore, drieppoging, " &_
					"steals, assists, offreb, defreb, blocks, turnovers, fouten, provoked, "&_
					"tijd, rating, scoutingnr, (eenpscore + tweepscore*2 + driepscore*3) AS punten " &_
					"FROM tblleden LEFT JOIN (SELECT * FROM tblscouting WHERE wedstrijd = "&matchid&") " &_
					"AS qryscouting ON tblleden.id = qryscouting.speler WHERE scoutingnr Is Not Null " &_
					"ORDER BY " & ord(sorteer) & ", naam, voornaam"
		rs.open sqlstring%>
		<table border=1>
		<tr>
			<th width="130" align="center">Naam</th>
			<th width="50" align="center">PTN</th>
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
			<th width="30" align="center">RA</th>
		</tr>
		<%while not rs.eof%>
			<tr>
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
			<th width="130" align="center">Naam</th>
			<th width="50" align="center">PTN</th>
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
			<th width="30" align="center">RA</th>
		</tr>
		</table>

	<%

con.close%>
