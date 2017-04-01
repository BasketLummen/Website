<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authorizedUsers2="22,205"
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
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition", "attachment; filename=scouting_spelers.xls" 

function contr_nul(waarde)
		if waarde <> "" and not isnull(waarde) then
			if waarde > 0 then
				contr_nul = waarde
			else
				contr_nul = "&nbsp;"
			end if
		else
			contr_nul = "&nbsp;"
		end if
end function
function contr_nul0(waarde)
	if waarde <> "" and not isnull(waarde) then
		contr_nul0 = waarde
	else
		contr_nul0 = 0
	end if
end function



'SCOUTING PER SPELER
ploegid = trim(request("ploeg"))
if ploegid = "" or isnull(ploegid) then ploegid =  1

dim totaal(16,2)

dim omschr(16)
omschr(0) = "eenpscore"
omschr(1) = "eenppoging"
omschr(2) = "tweepscore"
omschr(3) = "tweeppoging"
omschr(4) = "driepscore"
omschr(5) = "drieppoging"
omschr(6) = "steals"
omschr(7) = "assists"
omschr(8) = "offreb"
omschr(9) = "defreb"
omschr(10) = "blocks"
omschr(11) = "turnovers"
omschr(12) = "fouten"
omschr(13) = "provoked"
omschr(14) = "tijd"
omschr(15) = "rating"
sqlstring = "SELECT id, naam, voornaam FROM tblleden "&_
				"WHERE scoutingnr IS NOT NULL ORDER BY scoutingnr"
	'if ploegid = 1 then
	'	sqlstring = sqlstring & "AND (scoutingnr > 100 and scoutingnr < 200) OR id = 157 "
	'elseif ploegid = 2 then
	'	sqlstring = sqlstring & "AND (scoutingnr > 200 and scoutingnr < 300) OR id = 126 OR id = 4 OR id = 164 OR id = 174 " 
	'end if	
	'sqlstring = sqlstring & "ORDER BY right(scoutingnr,2)"

rs1.open sqlstring
while not rs1.eof

	for i = 0 to 15
		for j = 0 to 1 '0 = thuis, 1 = uit
			totaal(i,j)=0
		next
	next
	
	strspeler = rs1("voornaam") & " " & rs1("naam")%>
	<p><font size="3"><b><%=strspeler%></b></font></p>
	<%
	sqlstring = "SELECT wedstrijdid, datum, thuisploeg, uitploeg, eenpscore, eenppoging, tweepscore, tweeppoging, driepscore, " &_
				"drieppoging, steals, assists, offreb, defreb, blocks, turnovers, fouten, provoked, "&_
				"tijd, rating, (eenpscore + tweepscore*2 + driepscore*3) AS punten " &_
				"FROM tblscoutingwedstr LEFT JOIN (SELECT * FROM tblscouting WHERE speler = "&rs1("id")&") AS qryscouting "&_
				"ON (tblscoutingwedstr.wedstrijdid = qryscouting.wedstrijd) " &_
				"WHERE ploeg = "&ploegid&" " &_
				"ORDER BY datum"			
		
	rs.open sqlstring%>
	<table border="1">
	<tr>
		<th width="40" align="center">Datum</th>
		<th width="140" align="center">Ploeg</th>
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
	<%
	aantal_thuis = 0
	aantal_uit = 0
	while not rs.eof
		if left(rs("thuisploeg"),13)="Basket Lummen" then
			kleur = ""
			plaats = 0
			if rs("tijd") > 0 then
				aantal_thuis = aantal_thuis + 1
				for i = 0 to 15	
					totaal(i,0) = totaal(i,0) + contr_nul0(rs(omschr(i)))
				next
			end if
		else
			kleur = "#66FFFF"
			plaats = 1
			if rs("tijd") > 0 then
				aantal_uit = aantal_uit + 1
				for i = 0 to 15	
					totaal(i,1) = totaal(i,1) + contr_nul0(rs(omschr(i)))
				next
			end if
		end if
		%>
		<tr>
		   <td align="center"><%=day(rs("datum"))%>/<%=month(rs("datum"))%>/<%=year(rs("datum"))%></td>
			<td>
				<%if rs("tijd") > 0 then%>
					<b><%
					if left(rs("thuisploeg"),13)="Basket Lummen" then%>
						<%=rs("uitploeg")%>
					<%else%>
						<%=rs("thuisploeg")%>
					<%end if%></b>
				<%else%>
					<font color="#CCCCCC">
					<b><%if left(rs("thuisploeg"),13)="Basket Lummen" then%>
						<%=rs("uitploeg")%>
					<%else%>
						<%=rs("thuisploeg")%>
					<%end if%></b>
					</font>
				<%end if%>
			</td>
			<td width="30" align="center">
				<%if rs("tijd") > 0 then%>
					<%=contr_nul0(rs("punten"))%>
				<%else%>
					&nbsp;
				<%end if
				som = 0%>	
			</td>
			<td width="30" align="center">
				<%if rs("eenppoging") > 0 then%>
					<%=contr_nul0(rs("eenpscore"))%>
				<%else%>
					&nbsp;
				<%end if%>
			</td>
			<td width="30" align="center"><%=contr_nul(rs("eenppoging"))%></td>
			<td width="30" align="center">
			<%if rs("eenppoging") > 0 then%>
				<%=round((rs("eenpscore")/rs("eenppoging"))*100,0)%>
			<%else%>
				&nbsp;
			<%end if%>
			</td>
			<td width="30" align="center">
				<%if rs("tweeppoging") > 0 then%>
					<%=contr_nul0(rs("tweepscore"))%>
				<%else%>
					&nbsp;
				<%end if%>
			</td>
			<td width="30" align="center"><%=contr_nul(rs("tweeppoging"))%></td>
			<td width="30" align="center">
			<%if rs("tweeppoging") > 0 then%>
				<%=round((rs("tweepscore")/rs("tweeppoging"))*100,0)%>
			<%else%>
				&nbsp;
			<%end if%>
			</td>
			<td width="30" align="center">
				<%if rs("drieppoging") > 0 then%>
					<%=contr_nul0(rs("driepscore"))%>
				<%else%>
					&nbsp;
				<%end if%>
			</td>
			<td width="30" align="center"><%=contr_nul(rs("drieppoging"))%></td>
			<td width="30" align="center">
			<%if rs("drieppoging") > 0 then%>
				<%=round((rs("driepscore")/rs("drieppoging"))*100,0)%>
			<%else%>
				&nbsp;
			<%end if%>
			</td>
			<td width="30" align="center"><%=contr_nul(rs("steals"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("assists"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("offreb"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("defreb"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("blocks"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("turnovers"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("fouten"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("provoked"))%></td>
			<td width="30" align="center"><%=contr_nul(rs("tijd"))%></td>
			<td width="30" align="center">
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
	<tr><td colspan="22">&nbsp;</td></tr>
	<tr bgcolor="#CCCCCC">
		<td colspan="2">Totaal</td>
		<td width="30" align="center"><%=totaal(0,0)+totaal(0,1)+(totaal(2,0)+totaal(2,1))*2+(totaal(4,0)+totaal(4,1))*3%></td>
		<%for i = 0 to 2%>
			<td width="30" align="center"><%=totaal(i*2,0)+totaal(i*2,1)%></td>
			<td width="30" align="center"><%=totaal(i*2+1,0)+totaal(i*2+1,1)%></td>
			<td width="30" align="center">
			<%if totaal(i*2+1,0)+totaal(i*2+1,1) > 0 then%>
				<%=round(((totaal(i*2,0)+totaal(i*2,1))/(totaal(i*2+1,0)+totaal(i*2+1,1)))*100,0)%>
			<%else%>
				&nbsp;
			<%end if%>
			</td>
		<%next%>
		<%for i = 6 to 15%>
			<td width="30" align="center"><%=totaal(i,0)+totaal(i,1)%></td>
		<%next%>
	</tr>
	<%aantal = aantal_thuis + aantal_uit%>
	<%if aantal > 0 then%>
		<tr bgcolor="#CCCCCC">
			
			<td colspan="2">Gemiddelde (<%=aantal%>)</td>
			<td width="30" align="center"><%=round((totaal(0,0)+totaal(0,1)+(totaal(2,0)+totaal(2,1))*2+(totaal(4,0)+totaal(4,1))*3)/aantal,1)%>
			</td>
			<%for i = 0 to 2%>
				<td width="30" align="center"><%=round((totaal(i*2,0)+totaal(i*2,1))/aantal,1)%></td>
				<td width="30" align="center"><%=round((totaal(i*2+1,0)+totaal(i*2+1,1))/aantal,1)%></td>
				<td width="30" align="center">&nbsp;</td>
			<%next%>
			<%for i = 6 to 15%>
				<td width="30" align="center"><%=round((totaal(i,0)+totaal(i,1))/aantal,1)%></td>
			<%next%>
		</tr>
		<tr bgcolor="#CCCCCC">
			<td colspan="2">Thuis (<%=aantal_thuis%>)</td>
			<%if aantal_thuis = 0 then
				for i = 0 to 19%>
					<td>&nbsp;</td>
				<%next
			else%>
				<td width="30" align="center"><%=round((totaal(0,0)+totaal(2,0)*2+totaal(4,0)*3)/aantal_thuis,1)%></td>
				<%for i = 0 to 2%>
					<td width="30" align="center"><%=round(totaal(i*2,0)/aantal_thuis,1)%></td>
					<td width="30" align="center"><%=round(totaal(i*2+1,0)/aantal_thuis,1)%></td>
					<td width="30" align="center">
					<%if totaal(i*2+1,0) > 0 then%>
						<%=round((totaal(i*2,0)/totaal(i*2+1,0))*100,0)%>
					<%else%>
						&nbsp;
					<%end if%>
					</td>
				<%next%>
				<%for i = 6 to 15%>
					<td width="30" align="center"><%=round(totaal(i,0)/aantal_thuis,1)%></td>
				<%next
			end if%>
		</tr>
		<tr bgcolor="#CCCCCC">
			<td colspan="2">Uit (<%=aantal_uit%>)</td>
			<%if aantal_uit = 0 then
				for i = 0 to 19%>
					<td>&nbsp;</td>
				<%next
			else%>
				<td width="30" align="center"><%=round((totaal(0,1)+totaal(2,1)*2+totaal(4,1)*3)/aantal_uit,1)%></td>
				<%for i = 0 to 2%>
					<td width="30" align="center"><%=round(totaal(i*2,1)/aantal_uit,1)%></td>
					<td width="30" align="center"><%=round(totaal(i*2+1,1)/aantal_uit,1)%></td>
					<td width="30" align="center">
					<%if totaal(i*2+1,1) > 0 then%>
						<%=round((totaal(i*2,1)/totaal(i*2+1,1))*100,0)%>
					<%else%>
						&nbsp;
					<%end if%>
					</td>
				<%next%>
				<%for i = 6 to 15%>
					<td width="30" align="center"><%=round(totaal(i,1)/aantal_uit,1)%></td>
				<%next
			end if%>
		</tr>
	<%end if%>
	<tr>
		<th width="40" align="center">Datum</th>
		<th width="140" align="center">Ploeg</th>
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
	
	<%rs1.movenext
	wend
con.close%>
