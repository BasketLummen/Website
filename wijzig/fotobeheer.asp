<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
reeks = trim(request("reeks"))
datum = trim(request("datum"))
naam = trim(request("naam"))
bestandsnaam = trim(request("bestandsnaam"))
aantal = trim(request("aantal"))
keuze = trim(request("keuze"))
toevoegen = trim(request("toevoegen"))
if isnull(toevoegen) or toevoegen = "" then toevoegen = 0

if toevoegen = 1 then
	sqlString = "SELECT max(reeks) AS mrks FROM tblFotos"
	rs.open sqlString
	if isnull(rs("mrks")) or rs("mrks") = "" then
		mnr = 1
	else
		mnr = rs("mrks") + 1
	end if
	rs.close
	sqlString = "INSERT INTO tblFotos VALUES (" &_
				" " & mnr & ", '" & naam & "', '" & datum & "', '" & bestandsnaam & "', " & aantal & ")"
	con.execute sqlString%>
	<p>Foto's <%=titel%> toegevoegd.</p>
<%elseif keuze = "wijzigen" then
	sqlString = "UPDATE tblFotos SET " &_
				"reeksnaam = '" & naam & "'" &_ 
				", datum = '" & datum & "'" &_ 
				", naam = '" & bestandsnaam & "'" &_ 
				", aantal = " & aantal &_
				" WHERE reeks = " & reeks
	con.execute sqlString%>
	<p class="algklassement">Foto's <%=naam%> gewijzigd.</p>
<%elseif keuze = "verwijderen" then
	sqlString = "DELETE FROM tblFotos WHERE reeks = " & reeks
	con.execute sqlString
	'sqlString = "DELETE FROM tblFotostekst WHERE reeks = " & reeks
	'con.execute sqlString%>
	<p class="algklassement">Foto's <%=naam%> verwijderd.</p>	
<%end if
con.close%>
</body>
</html>