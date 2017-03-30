<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp" --><%
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
strPlnr = request("plnr")
sqlString = "SELECT * FROM tblPloegen WHERE plnr = " & strPlnr
rs.open sqlString
%>
<html>
<head>
<title>Ploegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<form method="post" action="ploegbeheer.asp">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Ploeggegevens</td>
	</tr>
  <tr>
    <td>Ploegnr</td>
	<td><input type="text" value="<%=rs("plnr")%>" name="frmPlnr"></td>
  </tr>
  <tr>
    <td>Ploegnaam</td>
	<td><input type="text" value="<%=rs("plnaam")%>" name="frmPlnaam"></td>
  </tr>
  <tr>
    <td>Coach</td>
    <td><input type="text" value="<%=rs("plcoach")%>" name="frmPlcoach"></td>
  </tr>
  <tr>
	<td>E-mail Coach</td>
	<td><input type="text" value="<%=rs("plcmail")%>" name="frmPlcmail" size="50"></td>
  </tr>
  <tr>
    <td>Ass.Coach</td>
    <td><input type="text" value="<%=rs("plassc")%>" name="frmPlassc"></td>
  </tr>
  <tr>
	<td>E-mail Ass.Coach</td>
	<td><input name="frmPlasscmail" type="text" value="<%=rs("plasscmail")%>" size="50"></td>
  </tr>
  <tr>
	<td>Foto</td>
	<td><input name="foto" type="text" value="<%=rs("foto")%>" size="50"></td>
  </tr>
  <tr>
	<td>Peter</td>
	<td><input name="peter" type="text" value="<%=rs("peter")%>" size="50"></td>
  </tr>
  <tr>
	<td>Meter</td>
	<td><input name="meter" type="text" value="<%=rs("meter")%>" size="50"></td>
  </tr>
  <tr>
	<td>Foto coach</td>
	<td><input name="fotocoach" type="text" value="<%=rs("fotocoach")%>" size="50"></td>
  </tr>
  <tr>
	<td>Foto assistent</td>
	<td><input name="fotoass" type="text" value="<%=rs("fotoass")%>" size="50"></td>
  </tr>
  <tr>
	<td colspan="2" align="center"><input type="radio" name="wijzigen" value="1" id="1" checked><label for="1">Wijzigen</label>
	<input type="radio" name="wijzigen" value="2" id="2"><label for="2">Verwijderen</label></td>
  </tr>
  <tr>
    <td align="center" colspan="2"><input type="submit" value="wijzigen"></td>
  </tr>
</table>
</form>
<p align="center"><a href="menu.asp" class="nieuwslinks">Terug naar het menu</a></p>
</body>
</html>
