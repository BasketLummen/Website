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
</style></head>
<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 800px;">
<p class="NieuwsTitels"><font size="3">Wedstrijdkalender</font></p>
<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con
set rsArb = server.createobject("adodb.recordset")
rsArb.activeconnection = con

planningid=trim(request("id"))

terrein = trim(request("terrein"))

if terrein <> "" and not isnull(terrein) then
	scheids1 = trim(request("scheids1"))
	scheids2 = trim(request("scheids2"))
	mailscheids1 = trim(request("mailscheids1"))
	mailscheids2 = trim(request("mailscheids2"))
	bevestigd = trim(request("bevestigd"))

	sqlstring = "SELECT wedstrijd FROM tblWedstrijdplanning WHERE planningid = " & planningid
	rs.open sqlstring
	wedstrijdid = rs("wedstrijd")
	rs.close

	'opslaan van de wijziging
	sqlstring = "UPDATE tblwedstrijdplanning SET "
	if bevestigd = "on" then 'wedstrijdwijziging bevestigd
		sqlstring = sqlstring & " huidig = 1 "
		sqlstring2 = "UPDATE tblWedstrijdplanning SET huidig = 0 WHERE wedstrijd = " & wedstrijdid
		con.execute sqlstring2
	else
		sqlstring = sqlstring & " huidig = 0"
	end if	
	sqlstring = sqlstring & " WHERE planningid = " & planningid
	con.execute sqlstring
	
	'terrein reserveren
	sqlstring = "DELETE FROM tblSporthalreservaties WHERE planningid = " & planningid
	con.execute sqlstring
	if terrein > 0 then
		sqlstring = "INSERT INTO tblSporthalreservaties(planningid, reservatiedatum, terrein, sportdienst) VALUES (" &_
					planningid & ", '"&year(date())&"-"&month(date())&"-"&day(date())&"'," & terrein & ",0)"
		response.Write(sqlstring)				
		con.execute sqlstring
	end if

	
	'arbiters
	sqlstring = "DELETE FROM tblArbiters WHERE planningid = " & planningid
	con.execute sqlstring
	if scheids1 > 0 then
		sqlstring = "INSERT INTO tblArbiters VALUES("&planningid&","&scheids1&","
		if scheids2 > 0 then
			sqlstring = sqlstring & scheids2 & ")"
		else
			sqlstring = sqlstring & "null)"
		end if
		con.execute sqlstring
	end if
	response.Redirect("wedstrijdwijzigen.asp?id="&wedstrijdid)
end if


sqlstring = "SELECT tblWedstrijdplanning.planningid, tblWedstrijdplanning.wedstrijd, tblWedstrijdplanning.planningdatum, " &_
"tblWedstrijdplanning.datum, tblWedstrijdplanning.basketbond, tblWedstrijdplanning.huidig, " &_
"tblSporthalreservaties.reservatiedatum, arbiter1, arbiter2, tblSporthalreservaties.terrein, tblSporthalreservaties.sportdienst " &_
"FROM (tblWedstrijdplanning LEFT JOIN tblSporthalreservaties ON tblWedstrijdplanning.planningid = " &_
"tblSporthalreservaties.planningid) LEFT JOIN tblarbiters ON tblWedstrijdplanning.planningid = tblarbiters.planningid " &_
"WHERE (((tblWedstrijdplanning.planningid)="&planningid&")) ORDER BY tblWedstrijdplanning.planningid"
rs.open sqlstring

sqlstring = "SELECT wedstrijdid, tblPloegen.ploegnaam AS ploeglummen, tblPloegen.ploegid, tblWedstrploegen.ploegnaam AS thuisploeg, " &_
			"tblWedstrploegen_1.ploegnaam AS uitploeg, tblWedstrijden.soort " &_
			"FROM ((tblWedstrijden INNER JOIN tblPloegen ON tblWedstrijden.ploeg = tblPloegen.ploegid) " &_
			"INNER JOIN tblWedstrploegen AS tblWedstrploegen_1 ON tblWedstrijden.uitploeg = " &_
			"tblWedstrploegen_1.ploegid) INNER JOIN tblWedstrploegen ON tblWedstrijden.thuisploeg = " &_
			"tblWedstrploegen.ploegid WHERE wedstrijdid = " & rs("wedstrijd")
rs1.open sqlstring
%>
<h3><%=rs1("ploeglummen")%></h3>
<%ploegid = rs1("ploegid")
wedstrijdid = rs1("wedstrijdid")%>
<p><%=rs1("wedstrijdid")%>&nbsp;<%=rs1("thuisploeg")%>&nbsp;-&nbsp;<%=rs1("uitploeg")%>&nbsp;
(<%select case rs1("soort")
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
rs1.close
%>
<form method="post" action="wedstrijdwijzigenextra.asp?id=<%=planningid%>">
	<h3>Wijziging</h3>
	<table>
		<tr bgcolor="#FFFFFF">
			<td>Datum</td>
			<td><b>
            <%if not rs("datum") = "" and not isnull(rs("datum")) then%>
				<%=formatdatetime(rs("datum"),1)%>
            <%end if%>
            </b></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Uur</td>
			<td><b>
			<%if not rs("datum") = "" and not isnull(rs("datum")) then%>
				<%=formatdatetime(rs("datum"),4)%>
            <%end if%>
            </b></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Terrein</td>
			<td>
			<select name="terrein">
				<option value="0"></option>
				<option value="1" <%if rs("terrein") = 1 then response.write("selected")%>>1</option>
				<option value="2" <%if rs("terrein") = 2 then response.write("selected")%>>3</option>
				<option value="3" <%if rs("terrein") = 3 then response.write("selected")%>>1+2</option>
				<option value="4" <%if rs("terrein") = 4 then response.write("selected")%>>2+3</option>
				<option value="5" <%if rs("terrein") = 5 then response.write("selected")%>>1+2+3</option>
			</select>
			</td>
		</tr>
		<%
		sqlstring = "SELECT id, voornaam, naam FROM tblleden WHERE status = 'A' ORDER BY naam, voornaam"
		rsArb.open sqlstring
		%>
		<tr bgcolor="#FFFFFF">
			<td>Scheids 1</td>
			<td>
			<select name="scheids1">
				<option value="0"></option>
				<%while not rsArb.eof%>
					<option value="<%=rsArb("id")%>" <%
					if rs("arbiter1") = rsArb("id") then response.Write("selected")%>
					><%=rsArb("voornaam")%>&nbsp;<%=rsArb("naam")%></option>
					<%rsArb.movenext
				wend
				rsArb.movefirst%>
			</select> @ <input type="checkbox" name="mailscheids1" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Scheids 2</td>
			<td>
			<select name="scheids2">
				<option value="0"></option>
				<%while not rsArb.eof%>
					<option value="<%=rsArb("id")%>" <%
					if rs("arbiter2") = rsArb("id") then response.Write("selected")%>
					><%=rsArb("voornaam")%>&nbsp;<%=rsArb("naam")%></option>
					<%rsArb.movenext
				wend
				rsArb.close%>
			</select> @ <input type="checkbox" name="mailscheids2" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>Bevestigd</td>
			<td><input type="checkbox" name="bevestigd"  <%
			if rs("huidig") = 1 then
				%> checked<%
			end if
			%> /></td>
		</tr>
	</table>
	<p><input type="submit" value="opslaan" /></p>
</form>
<%con.close%>
<p><a href="wedstrijdwijzigen.asp?id=<%=wedstrijdid%>" class="NieuwsLinks">Terug naar overzicht wedstrijd</a></p>

<p><a href="wedstrijden.asp?ploegid=<%=ploegid%>" class="NieuwsLinks">Terug naar overzicht ploeg</a></p>
</div>
</body>
</html>
