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

<html>
<head>
<title>Wijzigen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<form method="post" action="lidbeheer.asp">
<table bgcolor="#FFFF00" align="center"><tr><td>
<table cellspacing="0" cellpadding="5" class="algklassement" width="100%">
<tr bgcolor="#000099">
	<td class="algklassementT" align="center" colspan="2">Lid toevoegen</td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>Voornaam :</td>
	<td><input type="text" name="frmVoornaam"></td>
</tr>
<tr bgcolor="#CCCCCC">
	<td>Naam:</td>
	<td><input type="text" name="frmNaam"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>Geb.Datum:</td>
	<td><input type="text" name="frmGebDatum"></td>
</tr>
<tr bgcolor="#CCCCCC">
	<td>Ploeg:</td>
	<td><input type="text" name="frmPloeg"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>Nr. 1:</td>
	<td><input type="text" name="frmPlnr1"></td>
</tr>
<tr bgcolor="#CCCCCC">
	<td>Nr. 2:</td>
	<td><input type="text" name="frmPlnr2"></td>
</tr>

<input type="hidden" name="toevoegen" value="1">
<tr>
	<td bgcolor="#000099" colspan="2" align="center"><input type="submit" value="toevoegen"></td>
</tr>
</table></td></tr></table>

</form>
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>

</body>
</html>
