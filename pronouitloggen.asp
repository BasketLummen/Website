<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Logout the current user.
MM_logoutRedirectPage = "pronostiek.asp"
Session.Contents.Remove("PR_Username")
Session.Contents.Remove("MM_UserAuthorization")
If (MM_logoutRedirectPage <> "") Then Response.Redirect(MM_logoutRedirectPage)
%>
<html>
<head>
<title>Basket Lummen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
</body>
</html>
