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

sqlstring = "SELECT datum FROM tblwedstrijden"&seizoen&" WHERE wedstrijd_id = " & intMatchnr
rs.open sqlstring
ouddatum = rs("datum")
if isnull(ouduur) or ouduur = "" then
	ouduur = "NULL"
else
	ouduur = "'" & ouduur & "'"
end if
rs.close

intDatum = trim(request("frmDatum"))
intUur = trim(request("frmUur"))
thuisploeg = trim(request("thuisploeg"))
uitploeg = trim(request("uitploeg"))
voordeel = trim(request("voordeel"))
locatie = trim(request("locatie"))
sqlString = "UPDATE tblWedstrijden"&seizoen&" SET datum = "

if isnull(intDatum) or intDatum = "" then
	sqlString = sqlString & "NULL"
else
	sqlString = sqlString & "'" & year(intDatum) & "-"&month(intDatum)&"-"&day(intDatum)&" "&intUur&":00'"
end if

sqlString = sqlString & ", thuisploeg = "

if isnull(thuisploeg) or thuisploeg = "" then
	sqlString = sqlString & "NULL"
else
	sqlString = sqlString & thuisploeg
end if

sqlString = sqlString & ", uitploeg = "

if isnull(uitploeg) or uitploeg = "" then
	sqlString = sqlString & "NULL"
else
	sqlString = sqlString & uitploeg
end if

sqlString = sqlString & ", voordeel = "

if isnull(voordeel) or voordeel = "" then
	sqlString = sqlString & "NULL"
else
	sqlString = sqlString & voordeel
end if

sqlString = sqlString & ", locatie = "

if isnull(locatie) or locatie = "" then
	sqlString = sqlString & "NULL"
else
	sqlString = sqlString & "'" & locatie & "'"
end if

sqlString = sqlString & " WHERE wedstrijd_id = " & intMatchnr

con.execute sqlString


%>

Wedstrijd opgeslaan.
</div>
</body>
</html>
