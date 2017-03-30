<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../connectblinfo.asp" -->
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
<%
naam = trim(request("naam"))
adres = trim(request("adres"))
gemeente = trim(request("gemeente"))
aantal = trim(request("aantal"))
toevoegen = trim(request("toevoegen"))
if isnull(toevoegen) or toevoegen = "" then toevoegen = 0
keuze = trim(request("keuze"))
nr = trim(request("nr"))
%>
<html>
<head>
<title>Sporthallen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<%if toevoegen = 1 then
	sqlString = "SELECT max(sporthalnr) AS mnr FROM tblSporthallen"
	rs.open sqlString
	if isnull(rs("mnr")) or rs("mnr") = "" then
		mnr = 1
	else
		mnr = rs("mnr") + 1
	end if
	rs.close
	
	sqlString = "INSERT INTO tblSporthallen VALUES(" & mnr & ", '" & naam & "', '" & adres & "', " & gemeente & ", " & afbeeldingen & ")"
	con.execute sqlString
	%><p align="center" class="hotnews">Sporthal <strong><%=naam%></strong> toegevoegd.</p><%
elseif keuze = "wijzigen" then
	sqlString = "UPDATE tblSporthallen SET " &_ 
		"sporthalnaam = '" & naam & "', " &_ 
		"sporthaladres = '" & adres & "', " &_ 
		"sporthalpostnr = " & gemeente & ", " &_
		"afbeeldingen = " & aantal & " " &_ 
		"WHERE sporthalnr = " & nr
	con.execute sqlString
	%><p align="center" class="hotnews">Sporthal <strong><%=naam%></strong> is gewijzigd.</p><%
elseif keuze = "verwijderen" then	
	sqlString = "DELETE FROM tblSporthallen WHERE sporthalnr = " & nr
	con.execute sqlString
	%><p align="center" class="hotnews">Sporthal <strong><%=naam%></strong> is verwijderd.<%
end if
con.close%>
<p align="center"><a href="sporthaltoevoegen.asp" class="algklassement">Sporthal toevoegen</a></p>
<p align="center"><a href="sporthalwijzigen.asp" class="algklassement">Sporthal wijzigen</a></p>
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>
</body>
</html>
