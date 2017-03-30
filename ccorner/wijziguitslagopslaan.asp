<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
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
<title>Basket Lummen - Kalender</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.crij {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">

<%
seizoen = trim(request("s"))
if s="" or isnull(seizoen) then seizoen = "1415"

intMatchnr = trim(request("frmMatchnr"))
intThuisres = trim(request("frmThuisres"))
intUitres = trim(request("frmUitres"))

sqlString = "UPDATE tblWedstrijden"&seizoen&" SET thuisresult = "

if isnull(intThuisres) or intThuisres = "" then
	sqlString = sqlString & "NULL"
else
	sqlString = sqlString & intThuisres
end if

sqlString = sqlString & ", uitresult = "

if isnull(intUitres) or intUitres = "" then
	sqlString = sqlString & "NULL"
else
	sqlString = sqlString & intUitres
end if

sqlString = sqlString & " WHERE wedstrijd_id = " & intMatchnr

con.execute sqlString
%>
Uitslag gewijzigd.
</div>
</body>
</html>
