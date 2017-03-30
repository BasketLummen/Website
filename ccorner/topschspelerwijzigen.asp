<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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
  if Session("PR_Username1") <> "Vanstiphout" and Session("PR_Username2") <> "Mike" then
	  Response.Redirect("index.asp")
  else
  	Session("BL_soort") = 0
  end if
End If

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Topschutters ingeven</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	
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
<%if Session("BL_username") <> "" then%>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%end if%>

<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">

<p class="NieuwsTitels"><font size="3">Topschutters</font></p>
<p>
	<table width="600" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr align="center">
  	<td bgcolor="#000099" width="125"><a href="topschingeven.asp" class="menuLinks2">Punten ingeven</a></td>
  	<td bgcolor="#000099" width="125"><a href="topschspelertoevoegen.asp" class="menuLinks2">Speler toevoegen</a></td>
  	<td bgcolor="#000099" width="125"><a href="topschspelerwijzigen.asp" class="menuLinks2">Speler wijzigen</a></td>
  </tr>
  </table></p><%

sqlString = "SELECT nummer, naam, voornaam, tblTopschPloegen.ploeg " &_
			"FROM tblTopschSpelers INNER JOIN tblTopschPloegen ON tblTopschSpelers.ploeg = tblTopschPloegen.ploegid "
if Session("BL_lidid")=185 then sqlString = sqlString & "WHERE reeks = 'D' "
sqlString = sqlString & "ORDER BY reeks, tblTopschPloegen.ploeg, naam, voornaam"
rs.open sqlString%>
<form>
<p align="center"><select onChange="location.href=this.value">
<option>Andere speler</option>
<%
while not rs.eof%>
	<option value="topschspelerwijzigen.asp?nr=<%=rs("nummer")%>">
	<%if ploeg <> rs("ploeg") then
		ploeg = rs("ploeg")
		%>------------<%=rs("ploeg")%>&nbsp;------------</option><%
	else
		%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs("voornaam")%>&nbsp;<%=rs("naam")%></option>
		<%rs.movenext
	end if
wend
rs.close%>
</select></p></form>
<%
nr = trim(request("nr"))
if nr <> "" then
	voornaam = trim(request("voornaam"))
	naam = trim(request("naam"))
	ploeg = trim(request("ploeg"))
	if naam <> "" and ploeg <> "" then
		keuze = trim(request("keuze"))
		if keuze = "wijzigen" then
			sqlString = "UPDATE tblTopschSpelers SET voornaam = '" & voornaam & "', naam = '" & naam & "', ploeg = " & ploeg & " WHERE nummer = " & nr
			con.execute(sqlString)%>
			<p align="center">Speler gewijzigd.</p>
		<%else
			sqlString = "DELETE FROM tblTopschSpelers WHERE nummer = " & nr
			con.execute(sqlString)
			sqlString = "DELETE FROM tblTopschPunten WHERE spelerid = " & nr
			con.execute(sqlString)%>
			<p align="center">Speler verwijderd.</p>
		<%end if
	else
		sqlString = "SELECT naam, voornaam, ploeg FROM tblTopschSpelers WHERE nummer = " & nr
		rs.open sqlString%>
		<form method="post" action="topschspelerwijzigen.asp">
			<input type="hidden" name="nr" value="<%=nr%>">
			<table align="center">
				<tr bgcolor="#FFFFFF"><td>Voornaam</td><td><input type="text" name="voornaam" value="<%=rs("voornaam")%>"></td></tr>		
				<tr bgcolor="#FFFFFF"><td>Naam</td><td><input type="text" name="naam" value="<%=rs("naam")%>"></td></tr>	
				<tr bgcolor="#FFFFFF"><td>Ploeg</td><td>
				<select name="ploeg">
					<option></option>
					<%
					set rsPloeg = server.CreateObject("ADODB.Recordset")
					rsPloeg.ActiveConnection= Con
					sqlString = "SELECT ploegid, ploeg FROM tblTopschPloegen "
					if Session("BL_lidid")=185 then sqlString = sqlString & "WHERE reeks = 'D' "
					sqlString = sqlString &  "ORDER BY reeks, ploeg"
					rsPloeg.open sqlString
					while not rsPloeg.eof%>
						<option value="<%=rsPloeg("ploegid")%>"<%
						if rsPloeg("ploegid") = rs("ploeg") then
							%> selected<%
						end if
						%>><%=rsPloeg("ploeg")%></option>
						<%rsPloeg.movenext
					wend%>
				</select>
				</td></tr>
				<tr bgcolor="#FFFFFF">
				<td colspan="2" align="center">
				<label for="1"><input type="radio" name="keuze" value="wijzigen" checked id=1>Wijzigen</label>
				<label for="2"><input type="radio" name="keuze" value="verwijderen" id=2>Verwijderen</label>
				</td>
				</tr>
			</table>
			<p align="center"><input type="submit" value="Opslaan"></p>
		</form>
	<%end if%>
<%end if%>
<p align="center"><a href="../wijzig/menu.asp">Terug naar menu</a></p>
</div></body>
</html>
