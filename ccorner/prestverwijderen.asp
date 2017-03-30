<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
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
<!--#include file="connect.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>KBBC Zolder - Prestaties</title>
<link href="../inc/opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td,p  {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
select {
	background-color: #FFFFFF;
}
input {
	text-align: center;
}
textarea {
	border: 1px solid #000099;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
	color: #000099;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
id = trim(request("id"))

sqlString = "SELECT coach, month(datum) AS maand FROM tblPrestaties WHERE id = " & id
rs.open sqlString
maand = rs("maand")

if session("BL_soort") < 3 then
	sqlString = "DELETE FROM tblprestaties WHERE id = " & id
	con.execute sqlstring
elseif session("BL_soort") > 2 or session("BL_lidid") = 242 then
	if rs("coach") = session("BL_lidid") then
		sqlString = "DELETE FROM tblprestaties WHERE id = " & id
		con.execute sqlstring
	end if
end if

rs.close

con.close
response.Redirect("prestaties.asp?maand="&maand)

%>
</div>
</body>
</html>
