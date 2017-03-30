<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="login.asp"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
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

sqlString = "SELECT Voornaam, Naam FROM tblUsers WHERE user_id = " & Session("MM_User_id")

rs.open sqlString
%>
<html>
<head>
<title>Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0"> 
  Welkom <%=rs("Voornaam")%>&nbsp;<%=rs("Naam")%>,<br>
<%rs.close
if Session("MM_UserAuthorization") <> "" then
	if Session("MM_UserAuthorization") = 4 then
		response.Redirect("linkswijzigen.asp")
	else
	sqlString = "SELECT * FROM tblPermissies WHERE perm_minuser >= " & Session("MM_UserAuthorization")
	rs.open sqlString
	if not rs.eof then%>
		U hebt volgende mogelijkheden:</td></tr>
		<%while not rs.eof%>
			<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" onclick="document.location.href='<%=rs("perm_file")%>.asp'"><td height="20" class="prono2" style="border-top: 1px solid #000099;"><%=rs("perm_naam")%></td></tr>
			<%rs.movenext
		wend
	else%>
		U hebt niet voldoende permissies om wijzigingen aan te brengen.</td></tr>
	<%end if
	end if
else%>
	U hebt niet voldoende permissies om wijzigingen aan te brengen.</td></tr>
<%end if%>
</table>
</body>
</html>
