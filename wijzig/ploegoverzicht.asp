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
sqlString = "SELECT plnr, plnaam FROM tblPloegen ORDER BY plnr"
rs.ActiveConnection = Con
rs.open sqlString
%>
<html>
<head>
<title>Ploegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<form method="post" action="ploeggegevens.asp">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Ploegoverzicht</td>
	</tr>
<%while not rs.eof%>
	  <tr><td><input type="radio" name="plnr" value="<%=rs("plnr")%>" id="<%=rs("plnr")%>">
		<label for="<%=rs("plnr")%>"><%=rs("plnaam")%></label>
	  </td></tr>
    <%rs.movenext
wend%>
<tr align="center"><td>
	<input type="submit" value="wijzigen">
</td></tr>
</table>
</form>
<p align="center"><a href="menu.asp" class="nieuwslinks">Terug naar het menu</a></p>
</body>
</html>
