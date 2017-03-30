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
<form action="fotowijzigen.asp" method="post">
<table bgcolor="#FFFF00" align="center"><tr><td>
<table cellspacing="0" cellpadding="5" class="algklassement">
<tr bgcolor="#000099" class="algklassementT"> 
<td colspan="2" align="center" class="algklassementT">Foto's Wijzigen/verwijderen</td></tr>
<%sqlString = "SELECT reeks, reeksnaam FROM tblFotos ORDER BY reeks DESC"
rs.open sqlString
while not rs.eof
	if kleur <> "#FFFFFF" then
		kleur = "#FFFFFF"
	else
		kleur = "#CCCCCC"
	end if%>
	<tr bgcolor="<%=kleur%>">
		<td width="10"><input type="radio" name="reeks" id="<%=rs("reeks")%>" value="<%=rs("reeks")%>"></td>
		<td align="left"><label for="<%=rs("reeks")%>"><%=rs("reeksnaam")%></label></td>
	</tr>
	<%rs.movenext
wend%>
	  <tr> 
		<td align="center" bgcolor="#000099" colspan="2"><input type="submit" value="wijzigen/verwijderen"></td>
	  </tr>
</table></td></tr></table>

</form>
<p align="center"><a href="../nu/menu.asp" class="algklassement">Terug naar het menu</a></p>

</body>
</html>
