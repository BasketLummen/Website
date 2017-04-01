<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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
'con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=root; pwd=root; 'database=basketlummen; option=3; port=3306;"
con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=basketlummen; pwd=ba7863; database=basketlummen; option=3; port=3306;"

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition", "attachment; filename=scouting_wedstrijden.xls" 


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
	ploegid = trim(request("ploeg"))
	if ploegid = "" or isnull(ploegid) then ploegid =  1
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
	


	
	sqlstring = "SELECT DISTINCT wedstrijdid, datum, thuisploeg, uitploeg, thuisresult, uitresult " &_
				"FROM tblscoutingwedstr INNER JOIN tblscouting ON tblscoutingwedstr.wedstrijdid = tblscouting.wedstrijd " &_
				"WHERE ploeg = "&ploegid& " ORDER BY datum"
	rs.open sqlstring
	while not rs.eof
		strwedstrijd = day(rs("datum"))&" "&monthname(month(rs("datum")))&", "& rs("thuisploeg")&" - "&rs("uitploeg")&" "&rs("thuisresult")&"-"&rs("uitresult")	%>
		<p><font size="3"><b><%=strwedstrijd%></b></font></p>
		<%

	
		sqlstring = "SELECT id, voornaam, naam, eenpscore, eenppoging, tweepscore, tweeppoging, driepscore, drieppoging, " &_
					"steals, assists, offreb, defreb, blocks, turnovers, fouten, provoked, "&_
					"tijd, rating, scoutingnr, (eenpscore + tweepscore*2 + driepscore*3) AS punten " &_
					"FROM tblleden LEFT JOIN (SELECT * FROM tblscouting WHERE wedstrijd = "&rs("wedstrijdid")&") " &_
					"AS qryscouting ON tblleden.id = qryscouting.speler WHERE scoutingnr Is Not Null ORDER BY scoutingnr"
		'if ploegid = 1 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 100 and scoutingnr < 200) OR id = 157 OR id = 127 "
		'elseif ploegid = 2 then
		'	sqlstring = sqlstring & "AND (scoutingnr > 200 and scoutingnr < 300) OR id = 126 OR id = 4 or id = 164 OR id = 174 " 
		'end if	
		'sqlstring = sqlstring & "ORDER BY right(scoutingnr,2), naam, voornaam"
		rs1.open sqlstring%>
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
			<th width="30" align="center">+/-</th>
		</tr>
		<%while not rs1.eof%>
			<tr>
				<td style="border-left: #AAAAAA solid 1px;" class="scout">
					<%if rs1("tijd") > 0 then%>
						<b><%=rs1("voornaam")%>&nbsp;<%=rs1("naam")%></b>
					<%else%>
						<font color="#CCCCCC"><%=rs1("voornaam")%>&nbsp;<%=rs1("naam")%></font>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if rs1("tijd") > 0 then%>
						<%=contr_nul0(rs1("punten"))%>
					<%else%>
						<%=contr_nul(rs1("punten"))%>
					<%end if
					som = 0%>	
				</td>
				<td width="30" align="center" class="scout">
					<%if rs1("eenppoging") > 0 then%>
						<%=contr_nul0(rs1("eenpscore"))%>
					<%else%>
						<%=contr_nul(rs1("eenpscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("eenppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs1("eenppoging") > 0 then%>
					<%=round((rs1("eenpscore")/rs1("eenppoging"))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if rs1("tweeppoging") > 0 then%>
						<%=contr_nul0(rs1("tweepscore"))%>
					<%else%>
						<%=contr_nul(rs1("tweepscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("tweeppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs1("tweeppoging") > 0 then%>
					<%=round((rs1("tweepscore")/rs1("tweeppoging"))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout">
					<%if rs1("drieppoging") > 0 then%>
						<%=contr_nul0(rs1("driepscore"))%>
					<%else%>
						<%=contr_nul(rs1("driepscore"))%>
					<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("drieppoging"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs1("drieppoging") > 0 then%>
					<%=round((rs1("driepscore")/rs1("drieppoging"))*100,0)%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("steals"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("assists"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("offreb"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("defreb"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("blocks"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("turnovers"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("fouten"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("provoked"))%></td>
				<td width="30" align="center" class="scout"><%=contr_nul(rs1("tijd"))%></td>
				<td width="30" align="center" class="scout">
				<%if rs1("tijd") > 0 and rs1("rating") <> "" then%>
					<%=rs1("rating")%>
				<%else%>
					&nbsp;
				<%end if%>
				</td>
			</tr>
			<%rs1.movenext
		wend
		rs1.close
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
			<th width="30" align="center">+/-</th>
		</tr>
		</table>

	<%rs.movenext
	wend

	rs.close
con.close%>
