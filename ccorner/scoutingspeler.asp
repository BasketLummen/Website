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


%>
</head>
<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<p class="NieuwsTitels"><font size="3">Scouting per speler</font></p>
<%
'SCOUTING PER SPELER
ploegid = trim(request("ploeg"))
if ploegid = "" or isnull(ploegid) then ploegid =  1
sorteer = trim(request("ord"))
if sorteer = "" or isnull(sorteer) then sorteer = 0

dim ord(12)
ord(0) = "datum"
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

dim totaal(16,2)
for i = 0 to 15
	for j = 0 to 1 '0 = thuis, 1 = uit
		totaal(i,j)=0
	next
next

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
		<option value="scoutingmatch.asp?ploeg=<%=ploegid%>">Overzicht</option>
		<%while not rs.eof%>
			<option value="scoutingmatch.asp?matchid=<%=rs("wedstrijdid")%>&ploeg=<%=ploegid%>">
			<%if rs("wedstrijdid") = cint(matchid) then
				strwedstrijd = day(rs("datum"))&" "&monthname(month(rs("datum")))&", "&_
				rs("thuisploeg")&" - "&rs("uitploeg")&" "&rs("thuisresult")&"-"&rs("uitresult")
			end if%>
			<%=rs("thuisploeg")%> - <%=rs("uitploeg")%> (<%=day(rs("datum"))%>/<%=month(rs("datum"))%>)</option>
			<%rs.movenext
		wend
		rs.close%>
	</select>
	</form></td>
	
	<%spelerid = trim(request("spelerid"))
	sqlstring = "SELECT id, naam, voornaam FROM tblleden "&_
				"WHERE scoutingnr IS NOT NULL "
	if ploegid = 1 then
		sqlstring = sqlstring & "AND (scoutingnr > 100 and scoutingnr < 200) OR id = 157 "
	elseif ploegid = 2 then
		sqlstring = sqlstring & "AND (scoutingnr > 200 and scoutingnr < 300) OR id = 126 OR id = 4 OR id = 164 OR id = 174 " 
	end if	
	sqlstring = sqlstring & "ORDER BY right(scoutingnr,2)"
	rs.open sqlstring
	if not rs.eof then
		if spelerid = "" or isnull(spelerid) then
			spelerid = rs("id")
		end if%>
		<td>
		<form name="jump1">
		<select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO">
			<option>Toon scouting per speler</option>
			<option value="scoutingtotaal.asp?ploeg=<%=ploegid%>">Overzicht</option>
			<%while not rs.eof%>
				<option value="scoutingspeler.asp?spelerid=<%=rs("id")%>&ploeg=<%=ploegid%>">
				<%if rs("id") = cint(spelerid) then
					strspeler= rs("voornaam") & " " & rs("naam")
				end if%>
				<%=rs("voornaam") & " " & rs("naam")%></option>
				<%rs.movenext
			wend
			rs.close%>
		</select>
		</form></td><td align="right" width="300">
<a href="scoutingspelerexcel.asp?ploeg=<%=ploegid%>"><img src="../img/msexcel.gif" border="0" alt="Download alle spelers in excel" /></a>

</td>
		</tr></table>
	<%end if%>
	<p class="NieuwsTitels"><font size="2"><%=strspeler%></font></p>
	<%
	sqlstring = "SELECT wedstrijdid, datum, thuisploeg, uitploeg, eenpscore, eenppoging, tweepscore, tweeppoging, driepscore, " &_
				"drieppoging, steals, assists, offreb, defreb, blocks, turnovers, fouten, provoked, "&_
				"tijd, rating, (eenpscore + tweepscore*2 + driepscore*3) AS punten " &_
				"FROM tblscoutingwedstr LEFT JOIN (SELECT * FROM tblscouting WHERE speler = "&spelerid&") AS qryscouting "&_
				"ON (tblscoutingwedstr.wedstrijdid = qryscouting.wedstrijd) " &_
				"WHERE ploeg = "&ploegid&" " &_
				"ORDER BY " & ord(sorteer) & ", datum"			
		
	rs.open sqlstring%>
	<table cellspacing="0">
	<tr>
		<th width="40" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=0">Datum</a></th>
		<th width="100" align="center">Tegenstander</th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=1">PTN</a></th>
		<th width="60" align="center" colspan="2">1p</th>
		<th width="30" align="center">%</td>
		<th width="60" align="center" colspan="2">2p</th>
		<th width="30" align="center">%</td>
		<th width="60" align="center" colspan="2">3p</th>
		<th width="30" align="center">%</th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=2">ST</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=3">AS</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=4">OR</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=5">DR</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=6">BL</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=7">TO</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=8">FO</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=9">PR</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=10">TI</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ploeg=<%=ploegid%>&ord=11">+/-</a></th>
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
		<tr bgcolor="<%=kleur%>" onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='<%=kleur%>';" style="cursor: pointer; cursor: hand" onClick="document.location='scoutingmatch.asp?matchid=<%=rs("wedstrijdid")%>&ploeg=<%=ploegid%>'">
		   <td align="center" class="scout"><%=day(rs("datum"))%>/<%=month(rs("datum"))%></td>
			<td class="scout">
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
			<td width="30" align="center" class="scout">
				<%if rs("tijd") > 0 then%>
					<%=contr_nul0(rs("punten"))%>
				<%else%>
					&nbsp;
				<%end if
				som = 0%>	
			</td>
			<td width="30" align="center" class="scout">
				<%if rs("eenppoging") > 0 then%>
					<%=contr_nul0(rs("eenpscore"))%>
				<%else%>
					&nbsp;
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
					&nbsp;
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
					&nbsp;
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
	<tr><td colspan="25" class="scout">&nbsp;</td></tr>
	<tr bgcolor="#FFFFCC">
		<td colspan="2" class="scout">Totaal</td>
		<td width="30" align="center" class="scout"><%=totaal(0,0)+totaal(0,1)+(totaal(2,0)+totaal(2,1))*2+(totaal(4,0)+totaal(4,1))*3%></td>
		<%for i = 0 to 2%>
			<td width="30" align="center" class="scout"><%=totaal(i*2,0)+totaal(i*2,1)%></td>
			<td width="30" align="center" class="scout"><%=totaal(i*2+1,0)+totaal(i*2+1,1)%></td>
			<td width="30" align="center" class="scout">
			<%if totaal(i*2+1,0)+totaal(i*2+1,1) > 0 then%>
				<%=round(((totaal(i*2,0)+totaal(i*2,1))/(totaal(i*2+1,0)+totaal(i*2+1,1)))*100,0)%>
			<%else%>
				&nbsp;
			<%end if%>
			</td>
		<%next%>
		<%for i = 6 to 15%>
			<td width="30" align="center" class="scout"><%=totaal(i,0)+totaal(i,1)%></td>
		<%next%>
	</tr>
	<%aantal = aantal_thuis + aantal_uit%>
	<%if aantal > 0 then%>
		<tr bgcolor="#FFFFCC">
			
			<td colspan="2" class="scout">Gemiddelde (<%=aantal%>)</td>
			<td width="30" align="center" class="scout"><%=round((totaal(0,0)+totaal(0,1)+(totaal(2,0)+totaal(2,1))*2+(totaal(4,0)+totaal(4,1))*3)/aantal,1)%>
			</td>
			<%for i = 0 to 2%>
				<td width="30" align="center" class="scout"><%=round((totaal(i*2,0)+totaal(i*2,1))/aantal,1)%></td>
				<td width="30" align="center" class="scout"><%=round((totaal(i*2+1,0)+totaal(i*2+1,1))/aantal,1)%></td>
				<td width="30" align="center" class="scout">&nbsp;</td>
			<%next%>
			<%for i = 6 to 15%>
				<td width="30" align="center" class="scout"><%=round((totaal(i,0)+totaal(i,1))/aantal,1)%></td>
			<%next%>
		</tr>
		<tr bgcolor="#FFFFCC">
			<td colspan="2" class="scout">Thuis (<%=aantal_thuis%>)</td>
			<%if aantal_thuis = 0 then
				for i = 0 to 19%>
					<td>&nbsp;</td>
				<%next
			else%>
				<td width="30" align="center" class="scout"><%=round((totaal(0,0)+totaal(2,0)*2+totaal(4,0)*3)/aantal_thuis,1)%></td>
				<%for i = 0 to 2%>
					<td width="30" align="center" class="scout"><%=round(totaal(i*2,0)/aantal_thuis,1)%></td>
					<td width="30" align="center" class="scout"><%=round(totaal(i*2+1,0)/aantal_thuis,1)%></td>
					<td width="30" align="center" class="scout">
					<%if totaal(i*2+1,0) > 0 then%>
						<%=round((totaal(i*2,0)/totaal(i*2+1,0))*100,0)%>
					<%else%>
						&nbsp;
					<%end if%>
					</td>
				<%next%>
				<%for i = 6 to 15%>
					<td width="30" align="center" class="scout"><%=round(totaal(i,0)/aantal_thuis,1)%></td>
				<%next
			end if%>
		</tr>
		<tr bgcolor="#FFFFCC">
			<td colspan="2" class="scout">Uit (<%=aantal_uit%>)</td>
			<%if aantal_uit = 0 then
				for i = 0 to 19%>
					<td>&nbsp;</td>
				<%next
			else%>
				<td width="30" align="center" class="scout"><%=round((totaal(0,1)+totaal(2,1)*2+totaal(4,1)*3)/aantal_uit,1)%></td>
				<%for i = 0 to 2%>
					<td width="30" align="center" class="scout"><%=round(totaal(i*2,1)/aantal_uit,1)%></td>
					<td width="30" align="center" class="scout"><%=round(totaal(i*2+1,1)/aantal_uit,1)%></td>
					<td width="30" align="center" class="scout">
					<%if totaal(i*2+1,1) > 0 then%>
						<%=round((totaal(i*2,1)/totaal(i*2+1,1))*100,0)%>
					<%else%>
						&nbsp;
					<%end if%>
					</td>
				<%next%>
				<%for i = 6 to 15%>
					<td width="30" align="center" class="scout"><%=round(totaal(i,1)/aantal_uit,1)%></td>
				<%next
			end if%>
		</tr>
	<%end if%>
	<tr>
		<th width="40" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=0">Datum</a></th>
		<th width="140" align="center">&nbsp;</th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=1">PTN</a></th>
		<th width="60" align="center" colspan="2">1p</th>
		<th width="30" align="center">%</th>
		<th width="60" align="center" colspan="2">2p</th>
		<th width="30" align="center">%</th>
		<th width="60" align="center" colspan="2">3p</th>
		<th width="30" align="center">%</th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=2">ST</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=3">AS</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=4">OR</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=5">DR</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=6">BL</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=7">TO</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=8">FO</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=9">PR</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=10">TI</a></th>
		<th width="30" align="center"><a href="scoutingspeler.asp?spelerid=<%=spelerid%>&ord=11">RA</a></th>
	</tr>
	</table>

<%end if%>
</div>
</body>
</html>
<%
con.close%>
