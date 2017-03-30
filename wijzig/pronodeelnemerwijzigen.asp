<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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
<!--#include file="connect2.asp" -->
<html>
<head>
<title>Basket Lummen Pronostiek</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
dn = trim(request("dn"))
verwijderen = trim(request("verwijderen"))
if verwijderen = "ja" then
	sqlString = "DELETE FROM tblpronodeelnemers WHERE Spelernr = " & dn
	con.execute sqlString
	sqlString = "DELETE FROM tblpronostiek WHERE Spelernr = " & dn
	con.execute sqlString
else
	naam = trim(request("naam"))
	voornaam = trim(request("voornaam"))
	email = trim(request("email"))
	sqlString = "UPDATE tblpronodeelnemers SET " &_
		"naam = '" & naam & "', " &_ 
		"voornaam = '" & voornaam & "', " &_ 
		"email = '" & email & "' " &_ 
		"WHERE Spelernr = " & dn
	con.execute sqlString
end if
%>
Gegevens deelnemer aangepast.
</body>
</html>
