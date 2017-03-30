<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
MM_authFailedURL="../login.asp"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (false Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
%>
<html>
<head>
<title>Tegenstanders</title>
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<p align="center">
<form name="jump">
<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<option>Kies een tegenstander</option>
	<%sqlString = "SELECT stamnr, naam, kortenaam FROM tblClubs ORDER BY stamnr"
	rs.open sqlString
	while not rs.eof%>
		<option value="tegenstanderwijzigen.asp?stamnr=<%=rs("stamnr")%>"><%=rs("stamnr")%>&nbsp;<%=rs("naam")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</form>
</p>
<%
stamnr = trim(request("stamnr"))

'gegevens club
naam = trim(request("naam"))
kortenaam = trim(request("kortenaam"))
sporthal1 = trim(request("sporthal1"))
sporthal2 = trim(request("sporthal2"))
shirt = trim(request("shirt"))
short = trim(request("short"))
website = trim(request("website"))
coach = trim(request("coach"))
soort = trim(request("soort"))

sqlString = "UPDATE tblClubs SET " &_ 
	"naam = '" & naam & "', " &_ 
	"kortenaam = '" & kortenaam & "', " &_ 
	"sporthalnr = " & sporthal1 & ", " &_ 
	"soort = " & soort & ", " &_
	"shirtkleur = '" & shirt & "', " &_
	"shortkleur = '" & short & "', " &_ 
	"website = '" & website & "', " &_ 
	"coach = '" & coach & "', sh2 = "
if isnull(sporthal2) or sporthal2 = "" then
	sqlString = sqlString & "null"
else
	sqlString = sqlString & sporthal2
end if

sqlString = sqlString & " WHERE stamnr = " & stamnr

con.execute sqlString



'palmares
sqlString = "DELETE FROM tblPalmares WHERE stamnr = " & stamnr
con.execute sqlString
sqlString = "SELECT seizoennr, seizoen FROM tblSeizoenen WHERE seizoennr > 21 ORDER BY seizoennr "
rs.open sqlString
while not rs.eof
	plaats = trim(request("plaats" & rs("seizoennr")))
	reeks = trim(request("reeks" & rs("seizoennr")))
	opmerking = trim(request("opmerkingp" & rs("seizoennr")))
	if not isnull(reeks) and reeks <> "" then
		sqlString = "INSERT INTO tblPalmares VALUES (" & rs("seizoennr") & ", " & stamnr &", "
		if isnull(plaats) or plaats = "" then
			sqlString = sqlString & "NULL, "
		else
			sqlString = sqlString & plaats & ", "
		end if
		sqlString = sqlString & "'" & reeks & "', '" & opmerking & "')"
		con.execute sqlString
	end if
	rs.movenext
wend
rs.close


'confrontaties
sqlString = "SELECT matchnr FROM tblConfrontaties WHERE stamnr = " & stamnr
rs.open sqlString			
while not rs.eof
	datum = trim(request("datum" & rs("matchnr")))
	thuis_uit = trim(request("thuis_uit" & rs("matchnr")))
	uitsl_thuis = trim(request("uitsl_thuis" & rs("matchnr")))
	uitsl_uit = trim(request("uitsl_uit" & rs("matchnr")))		
	opmerking = trim(request("opmerkingc" & rs("matchnr")))
	if isnull(datum) or datum="" then
		sqlString = "DELETE FROM tblConfrontaties WHERE matchnr = " = rs("matchnr")
	else
		sqlString = "UPDATE tblConfrontaties SET " &_ 
			"datum = '" & datum & "', " &_ 
			"thuis_uit = '" & thuis_uit & "', " &_ 
			"opmerking = '" & opmerking & "', "
		if isnull(uitsl_thuis) or uitsl_thuis="" then
			sqlString = sqlString & "uitsl_thuis = NULL, uitsl_uit = NULL "
		else
			sqlString = sqlString & "uitsl_thuis = " & uitsl_thuis & ", uitsl_uit = " & uitsl_uit & " "
		end if
		sqlString = sqlString & "WHERE matchnr = " & rs("matchnr")
	end if
	con.execute sqlString
	rs.movenext
wend
rs.close
for i=1 to 2
	datum = trim(request("datumn" & i))
	thuis_uit = trim(request("thuis_uitn" & i))
	uitsl_thuis = trim(request("uitsl_thuisn" & i))
	uitsl_uit = trim(request("uitsl_uitn" & i))		
	opmerking = trim(request("opmerkingcn" & i))
	sqlString = "SELECT max(matchnr) AS mnr FROM tblConfrontaties"
	rs.open sqlString
	if rs("mnr") = "" or isnull(rs("mnr")) then
		mnr = 1
	else
		mnr = rs("mnr") + 1
	end if
	rs.close
	if not isnull(datum) and datum <> "" then
		sqlString = "INSERT INTO tblConfrontaties VALUES( " & mnr & ", '" & datum & "', " & stamnr & ", '" & thuis_uit & "', "
		if isnull(uitsl_thuis) or uitsl_thuis="" then
			sqlString = sqlString & "NULL, NULL, "
		else
			sqlString = sqlString & uitsl_thuis & ",  " & uitsl_uit & ", "
		end if
		sqlString = sqlString & "'" & opmerking & "')"
		con.execute sqlString
	end if
next


'spelers
sqlString = "DELETE FROM tblSpelers WHERE stamnr = " & stamnr
con.execute sqlString

for i = 1 to 15
	spelernr = trim(request("spelernr" & i))
	voornaam = trim(request("voornaam" & i))
	snaam = trim(request("naam" & i))
	gebjaar = trim(request("gebjaar" & i))
	lengte = trim(request("lengte" & i))
	if not isnull(spelernr) and spelernr <> "" then
		sqlString = "INSERT INTO tblSpelers VALUES(" & stamnr & ", " & spelernr & ", '" & voornaam & "', '" & snaam & "', "
		if isnull(gebjaar) or gebjaar= "" then
			sqlString = sqlString & "NULL, "
		else
			sqlString = sqlString & gebjaar & ", "
		end if
		sqlString = sqlString & "'" & lengte & "')"
		con.execute sqlString
	end if
next
con.close
%>
<p class="hotnews" align="center"><%=naam%> is opgeslaan.</p>
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>
</body>
</html>
