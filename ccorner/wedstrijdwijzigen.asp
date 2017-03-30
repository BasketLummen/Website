<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"-->
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Kalender</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
select {
	background-color: #FFFFFF;
}
-->
</style>
</head>
<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 800px;">
<p class="NieuwsTitels"><font size="3">Wedstrijdkalender</font></p>
<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con


id=trim(request("id"))

uitstellen = trim(request("uitstellen"))
datum = trim(request("datum"))
if uitstellen = "on" or (datum <> "" and not isnull(datum)) then
	uur = trim(request("uur"))
	terrein = trim(request("terrein"))
	sportdienst = trim(request("sportdienst"))
	basketbond = trim(request("basketbond"))
	scheids1 = trim(request("scheids1"))
	scheids2 = trim(request("scheids2"))
	mailscheids1 = trim(request("mailscheids1"))
	mailscheids2 = trim(request("mailscheids2"))
	bevestigd = trim(request("bevestigd"))

	'opslaan van de wijziging
	sqlstring = "insert into tblwedstrijdplanning(wedstrijd, planningdatum, datum, basketbond, huidig, auteur) VALUES (" &_
				id & ", '"&year(date())&"-"&month(date())&"-"&day(date())&"',"
	if uitstellen = "on" then
		sqlstring = sqlstring & " null,"
	else
		sqlstring = sqlstring & "'"&year(datum)&"-"&month(datum)&"-"&day(datum)&" "&uur&":00',"
	end if
	if basketbond = "on" then 'e-mail sturen naar bond
		'ontbreekt nog code om formulier te sturen
		sqlstring = sqlstring & " 1, "
	else
		sqlstring = sqlstring & " 0, "
	end if	
	if bevestigd = "on" then 'wedstrijdwijziging bevestigd
		sqlstring = sqlstring & " 1"
		sqlstring2 = "UPDATE tblWedstrijdplanning SET huidig = 0 WHERE wedstrijd = " & id
		con.execute sqlstring2
	else
		sqlstring = sqlstring & " 0"
	end if	
	sqlstring = sqlstring & ", "& session("BL_lidid") &")"
	
	con.execute sqlstring

	if uitstellen <> "on" then
	
		sqlstring = "SELECT max(planningid) as maxid, wedstrijd FROM tblWedstrijdplanning GROUP BY wedstrijd " &_
					"HAVING wedstrijd = " & id
		rs.open sqlstring
		planningid = rs("maxid")
		rs.close
		
		'terrein reserveren
		if terrein > 0 then
			sqlstring = "INSERT INTO tblSporthalreservaties(planningid, reservatiedatum, terrein, sportdienst) VALUES (" &_
						planningid & ", '"&year(date())&"-"&month(date())&"-"&day(date())&"'," & terrein & ","
			if sportdienst = "on" then 'e-mail sturen naar sportdienst
				'ontbreekt nog code om formulier te sturen
				sqlstring = sqlstring & "1)"
			else
				sqlstring = sqlstring & "0)"
			end if
			con.execute sqlstring
		end if
		
		'arbiters
		if scheids1 > 0 then
			sqlstring = "INSERT INTO tblArbiters VALUES("&planningid&","&scheids1&","
			if scheids2 > 0 then
				sqlstring = sqlstring & scheids2 & ")"
			else
				sqlstring = sqlstring & "null)"
			end if
			con.execute sqlstring
		end if
	
	end if
	
end if

sqlstring = "SELECT wedstrijdid, tblPloegen.ploegnaam AS ploeglummen, tblPloegen.ploegid, tblWedstrploegen.ploegnaam AS thuisploeg, " &_
			"tblWedstrploegen_1.ploegnaam AS uitploeg, tblWedstrijden.soort " &_
			"FROM ((tblWedstrijden INNER JOIN tblPloegen ON tblWedstrijden.ploeg = tblPloegen.ploegid) " &_
			"INNER JOIN tblWedstrploegen AS tblWedstrploegen_1 ON tblWedstrijden.uitploeg = " &_
			"tblWedstrploegen_1.ploegid) INNER JOIN tblWedstrploegen ON tblWedstrijden.thuisploeg = " &_
			"tblWedstrploegen.ploegid WHERE wedstrijdid = " & id
rs.open sqlstring
%>
<h3><%=rs("ploeglummen")%></h3>
<%ploegid = rs("ploegid")%>
<p><%=rs("wedstrijdid")%>&nbsp;<%=rs("thuisploeg")%>&nbsp;-&nbsp;<%=rs("uitploeg")%>&nbsp;
(<%select case rs("soort")
			case 1:
				response.write("Com")
			case 2:
				response.write("BvL")
			case 3:
				response.write("BvV")
			case 4:
				response.write("BvB")
			case 5:
				response.write("Oefen")
			case 6:
				response.write("Andere")
		end select%>)
</p>
<%
rs.close

sqlstring = "SELECT tblWedstrijdplanning.planningid, tblWedstrijdplanning.wedstrijd, tblWedstrijdplanning.planningdatum, " &_
"tblWedstrijdplanning.datum, tblWedstrijdplanning.basketbond, tblWedstrijdplanning.huidig, tblWedstrijdplanning.auteur, " &_
"tblSporthalreservaties.reservatiedatum, qryArbiters.arb1_naam, qryArbiters.arb1_voornaam, qryArbiters.arb2_naam, " &_
"qryArbiters.arb2_voornaam, tblSporthalreservaties.terrein, tblSporthalreservaties.sportdienst " &_
"FROM (tblWedstrijdplanning LEFT JOIN tblSporthalreservaties ON tblWedstrijdplanning.planningid = " &_
"tblSporthalreservaties.planningid) LEFT JOIN (SELECT tblArbiters.planningid, tblleden.naam AS arb1_naam, tblleden.voornaam AS arb1_voornaam, " &_
"tblleden_1.naam AS arb2_naam, tblleden_1.voornaam AS arb2_voornaam FROM (tblArbiters LEFT JOIN tblleden ON tblArbiters.arbiter1 = tblleden.id) " &_
"LEFT JOIN tblleden AS tblleden_1 ON tblArbiters.arbiter2 = tblleden_1.id " &_
") AS qryArbiters ON tblWedstrijdplanning.planningid = qryArbiters.planningid " &_
"WHERE (((tblWedstrijdplanning.wedstrijd)="&id&")) ORDER BY tblWedstrijdplanning.planningid"
rs.open sqlstring
%>
<table>
	<tr>
		<th width="90">datum wedstrijd</th>
		<th width="40">tijd</th>
		<th width="30">terrein</th>
		<th width="90">datum gewijzigd</th>
		<th width="30">SD</th>
		<th width="30">Bond</th>
		<th width="120">Arbiter 1</th>
		<th width="120">Arbiter 2</th>
        <th width="80">gewijzigd</th>
	</tr>
<%
while not rs.eof%>
	<tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#FFFFFF'" onclick="document.location='wedstrijdwijzigenextra.asp?id=<%=rs("planningid")%>'" style="cursor:hand;cursor:pointer;<%
	if rs("huidig") = 0 then%>
		color:#999999
	<%else%>
		font-weight:bold
	<%end if%>" bgcolor="#FFFFFF">
		<%if rs("datum") <> "" and not isnull(rs("datum")) then%>
			<td align="center"><%=weekdayname(weekday(rs("datum")),true)%>&nbsp;<%=formatdatetime(rs("datum"),2)%></td>
			<td align="center"><%=formatdatetime(rs("datum"),4)%></td>
			<td align="center"><%select case rs("terrein")
				case 1:
					response.write("1")
				case 2:
					response.write("3")
				case 3:
					response.write("1+2")
				case 4:
					response.write("2+3")
				case 5:
					response.write("1+2+3")
				case else:
					response.write("&nbsp;")
			end select%></td>
		<%else%>
			<td align="center">- -</td><td>&nbsp;</td><td>&nbsp;</td>
		<%end if%>
		<td align="center"><%=rs("planningdatum")%></td>
		<td align="center">
		<%if rs("sportdienst") = true then
			%><img src="../img/checkbox.gif" /><%
		else
			%><img src="../img/greybox.gif" /><%
		end if%>
		</td>
		<td align="center">
		<%if rs("basketbond") = true then
			%><img src="../img/checkbox.gif" /><%
		else
			%><img src="../img/greybox.gif" /><%
		end if%>
		</td>
		<td><%=rs("arb1_voornaam")%>&nbsp;<%=rs("arb1_naam")%></td>
		<td><%=rs("arb2_voornaam")%>&nbsp;<%=rs("arb2_naam")%></td>
        <td>&nbsp;
        <%if rs("auteur") <> "" and not(isnull(rs("auteur"))) then
        	sqlstring = "SELECT voornaam FROM tblleden WHERE id = " & rs("auteur")
			rs1.open sqlstring
			response.write(rs1("voornaam"))
			rs1.close
        end if%>
        </td>
	</tr>
	<%rs.movenext
wend
%></table>
<%rs.close%>
<form method="post" action="wedstrijdwijzigen.asp?id=<%=id%>">
	<h3>Wijziging</h3>
	<table>
		<tr bgcolor="#FFFFFF">
			<td>Uitstellen</td>
			<td><input type="checkbox" name="Uitstellen" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Datum</td>
			<td><input type="text" name="datum" size="8" maxlength="10" /> <font size="1">(dd/mm/jjjj)</font></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Uur</td>
			<td><input type="text" name="uur" size="5" maxlength="5" /> <font size="1">(uu:mm)</font></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Terrein</td>
			<td>
			<select name="terrein">
				<option value="0"></option>
				<option value="1">1</option>
				<option value="2">3</option>
				<option value="3">1+2</option>
				<option value="4">2+3</option>
				<option value="5">1+2+3</option>
			</select>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>@ Sportdienst</td>
			<td><input type="checkbox" name="sportdienst" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>@ Basketbond</td>
			<td><input type="checkbox" name="basketbond" /></td>
		</tr>
		<%
		sqlstring = "SELECT id, voornaam, naam FROM tblleden WHERE status = 'A' ORDER BY naam, voornaam"
		rs1.open sqlstring
		%>
		<tr bgcolor="#FFFFFF">
			<td>Scheids 1</td>
			<td>
			<select name="scheids1">
				<option value="0"></option>
				<%while not rs1.eof%>
					<option value="<%=rs1("id")%>"><%=rs1("voornaam")%>&nbsp;<%=rs1("naam")%></option>
					<%rs1.movenext
				wend
				rs1.movefirst%>
			</select> @ <input type="checkbox" name="mailscheids1" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Scheids 2</td>
			<td>
			<select name="scheids2">
				<option value="0"></option>
				<%while not rs1.eof%>
					<option value="<%=rs1("id")%>"><%=rs1("voornaam")%>&nbsp;<%=rs1("naam")%></option>
					<%rs1.movenext
				wend
				rs1.close%>
			</select> @ <input type="checkbox" name="mailscheids2" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Bevestigd</td>
			<td><input type="checkbox" name="bevestigd" /></td>
		</tr>
	</table>
	<p><input type="submit" value="opslaan" /></p>
    <p><a href="wedstrijden.asp?ploegid=<%=ploegid%>" class="NieuwsLinks">Terug naar overzicht</a></p>
</form>
<%con.close%>
</div>
</body>
</html>
