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
<title>Match zoeken</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
sqlString = "SELECT matchnr, datum, thuisploeg, uitploeg, winnaar FROM tblpronowedstrijden " &_ 
			"WHERE datum >= '" & year(date()) & "-" & month(date()) & "-" & day(date()) & "' "&_ 
			"ORDER BY matchnr"
rs.open sqlString
if not rs.eof then
	response.Redirect("pronovoorspelling.asp?matchnr="&rs("matchnr"))
end if
%>

</body>
</html>
