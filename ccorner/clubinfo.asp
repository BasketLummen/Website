<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4"
MM_authFailedURL="index.asp"
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Clubinfo</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">

</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuinfo.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 140px; top: 40px; width: 685px;">
<%
id = trim(request("id"))
if id = "" or isnull(id) then id = 1

sqlString = "SELECT infonaam, infotekst FROM tblclubinfo WHERE infoid = " & id
rs.open sqlString%>
<p class="NieuwsTitels"><font size="3"><%=rs("infonaam")%></font></p>
<p class="NieuwsTekst"><%=replace(rs("infotekst"),"src=img","src=../img")%></p>
<%rs.close%>
</div></body>
</html>
