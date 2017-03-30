<!--#include file="connect.asp"-->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
MM_authFailedURL="login.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%>

<html>
<head>
<title>Basket Lummen - Ploegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<%

sqlSTring = "SELECT id, ploeg1 FROM tblleden WHERE status = 'A'"
rs.open sqlString

while not rs.eof
	sqlstring = "UPDATE tblleden SET ploegvorig = "&rs("ploeg1")&" WHERE id ="&rs("id")
	con.execute sqlstring
	rs.movenext
wend
rs.close
con.close

%>
<p>Ploegen geüpdate</p>
</html>
