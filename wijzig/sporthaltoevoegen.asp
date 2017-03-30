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
<html>
<head>
<title>Sporthal toevoegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<form method="post" action="sporthalbeheer.asp" name="sporthal">
<table bgcolor="#FFFF00" align="center"><tr><td>
<table cellspacing="0" cellpadding="5" class="algklassement" width="100%">
<tr bgcolor="#000099">
	<td class="algklassementT" align="center" colspan="2">Sporthal toevoegen</td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>Naam</td>
	<td><input type="text" name="naam" size="50"></td>
</tr>
<tr bgcolor="#CCCCCC">
	<td>Adres</td>
	<td><input type="text" name="adres" size="50"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>Gemeente</td>
	<td><select name="gemeente">
	<option></option>
	<%sqlString = "SELECT postnr, gemeente FROM tblGemeenten ORDER BY postnr"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("postnr")%>"><%=rs("postnr")%>&nbsp;<%=rs("gemeente")%></option>
		<%rs.movenext
	wend
	rs.close
	con.close%>
	</select>
	</td>
</tr>
<tr bgcolor="#CCCCCC">
	        <td>Aantal</td>
	<td><input name="aantal" type="text" id="aantal" size="50"></td>
</tr>
<input type="hidden" name="toevoegen" value="1">
<tr>
	<td bgcolor="#000099" colspan="2" align="center"><input type="submit" value="toevoegen"></td>
</tr>
</table></td></tr></table>

</form>
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>
<script language="javascript">
  document.sporthal.naam.focus();
</script>

</body>
</html>
