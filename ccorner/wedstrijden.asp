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
ploegid = trim(request("ploegid"))
if ploegid = "" or isnull(ploegid) then ploegid = 1

sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true ORDER BY ploegid"
rs.open sqlString
if not rs.eof then%>
<form name="jump1">
	<p>Ploeg <select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO"><option></option>
	<%while not rs.eof%>
		<option value="wedstrijden.asp?ploegid=<%=rs("ploegid")%>"<%
			if int(ploegid) = rs("ploegid") then
				%> selected="selected"<%
			end if
			%>><%=rs("ploegnaam")%></option>
		<%rs.movenext
	wend
	%>
	</select></p>
</form>
<%end if
rs.close%>





<%
sqlstring = "SELECT tblWedstrijden.wedstrijdid, tblPloegen.ploegnaam, tblWedstrploegen.ploegnaam AS thuisploeg, " &_ 
"tblWedstrploegen_1.ploegnaam AS uitploeg, tblWedstrijden.soort, tblWedstrijdplanning.datum, " &_ 
"tblWedstrijdplanning.basketbond, tblWedstrijdplanning.huidig, tblSporthalreservaties.terrein," &_ 
"tblSporthalreservaties.sportdienst, qryArbiters.arb1_naam, qryArbiters.arb1_voornaam," &_ 
"qryArbiters.arb2_naam, qryArbiters.arb2_voornaam " &_ 
"FROM ((tblPloegen INNER JOIN (((tblWedstrijdplanning INNER JOIN tblWedstrijden ON tblWedstrijdplanning.wedstrijd = " &_ 
"tblWedstrijden.wedstrijdid) INNER JOIN tblWedstrploegen ON tblWedstrijden.thuisploeg = tblWedstrploegen.ploegid) "  &_ 
"INNER JOIN tblWedstrploegen AS tblWedstrploegen_1 ON tblWedstrijden.uitploeg = tblWedstrploegen_1.ploegid) " &_ 
"ON tblPloegen.ploegid = tblWedstrijden.ploeg) LEFT JOIN tblSporthalreservaties ON tblWedstrijdplanning.planningid =  " &_ 
"tblSporthalreservaties.planningid) LEFT JOIN (SELECT tblArbiters.planningid, tblleden.naam AS arb1_naam, tblleden.voornaam AS arb1_voornaam, " &_ 
"tblleden_1.naam AS arb2_naam, tblleden_1.voornaam AS arb2_voornaam FROM (tblArbiters INNER JOIN tblleden ON tblArbiters.arbiter1 = tblleden.id) " &_ 
"INNER JOIN tblleden AS tblleden_1 ON tblArbiters.arbiter2 = tblleden_1.id) AS qryArbiters ON " &_ 
"tblWedstrijdplanning.planningid = qryArbiters.planningid " &_
"WHERE (((tblWedstrijdplanning.huidig)=1)) AND tblPloegen.ploegid = " & ploegid & " ORDER BY tblWedstrijdplanning.datum, wedstrijdid"


rs.open sqlstring
%><table>
<tr>
<th width="60">wedstrijdnr</th>
<th width="40">soort</th>
<th colspan="2" width="100" align="center">datum</th>
<th width="150">thuisploeg</th>
<th width="150">uitploeg</th>
<th width="30">terrein</th>
<th width="120">arbiter 1</th>
<th width="120">arbiter 2</th>
</tr>

<%while not rs.eof%>
	<tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#FFFFFF'" onclick="document.location='wedstrijdwijzigen.asp?id=<%=rs("wedstrijdid")%>'" style="cursor:hand;cursor:pointer;" bgcolor="#FFFFFF">
		<td align="center"><%=rs("wedstrijdid")%></td>
		<td align="center"><%select case rs("soort")
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
		end select%></td>
		<%if rs("datum") <> "" and not isnull(rs("datum")) then%>
			<td align="center"><%=weekdayname(weekday(rs("datum")),true)%>&nbsp;<%=day(rs("datum"))%>/<%=month(rs("datum"))%></td>
			<td align="center"><%=formatdatetime(rs("datum"),4)%></td>
		<%else%>
			<td align="center">- -</td><td align="center">- -</td>
		<%end if%>
		<td><%=rs("thuisploeg")%></td>
		<td><%=rs("uitploeg")%></td>
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
		<td><%=rs("arb1_voornaam")%>&nbsp;<%=rs("arb1_naam")%></td>
		<td><%=rs("arb2_voornaam")%>&nbsp;<%=rs("arb2_naam")%></td>
	</tr>
	<%rs.movenext
wend
%></table><%
rs.close
con.close%>
</div>
</body>
</html>
