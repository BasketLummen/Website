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
<title>Basket Lummen - Aanwezigheden</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
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
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
id = trim(request("id"))
sqlString = "SELECT month(datum) AS maand, ploeg FROM tblTrainingen WHERE id = " & id
rs.open sqlstring
ploeg = rs("ploeg")
maand = rs("maand")
rs.close

if session("BL_soort") < 3 then
	sqlString = "DELETE FROM tbltrainingen WHERE id = " & id
	con.execute sqlstring
	sqlString = "DELETE FROM tblaanwezigheden WHERE training = " & id
	con.execute sqlstring
elseif session("BL_soort") > 2 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"AND tblPloegen.ploegid = " & ploeg & " " &_
				"ORDER BY ploegid"
	rs.open sqlString
	
	if not rs.eof then
		sqlString = "DELETE FROM tbltrainingen WHERE id = " & id
		con.execute sqlstring
		sqlString = "DELETE FROM tblaanwezigheden WHERE training = " & id
		con.execute sqlstring
	end if
	rs.close
end if
con.close
response.Redirect("aanwezigheden.asp?id="&ploeg&"&maand="&maand)

%>
</div>
</body>
</html>
