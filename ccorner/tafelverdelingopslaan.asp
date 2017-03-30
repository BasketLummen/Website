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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Tafelverdeling</title>
</head>

<body>

<%
seizoen = "1415"
ploeg = trim(request("ploeg"))

sqlString = "Select wedstrijd_id FROM tblWedstrijden"&seizoen&" WHERE thuisploeg = " & ploeg
rs.open sqlString

while not rs.eof
	klok = trim(request("klok_"&rs("wedstrijd_id")))
	sec = trim(request("24sec_"&rs("wedstrijd_id")))
	delege = trim(request("delege_"&rs("wedstrijd_id")))
	sqlstring = "UPDATE tblwedstrijden"&seizoen&" SET klok = '"&klok&"', 24sec = '"&sec&"',delege='"&delege&"' WHERE wedstrijd_id = "&rs("wedstrijd_id")
	con.execute sqlstring
	rs.movenext
wend
rs.close

sqlString = "Select wedstrijd_id FROM tblWedstrijden"&seizoen&" WHERE uitploeg = " & ploeg
rs.open sqlString

while not rs.eof
	feuille = trim(request("feuille_"&rs("wedstrijd_id")))
	delege = trim(request("delege_"&rs("wedstrijd_id")))
	sqlstring = "UPDATE tblwedstrijden"&seizoen&" SET feuille = '"&feuille&"',delege='"&delege&"' WHERE wedstrijd_id = "&rs("wedstrijd_id")
	con.execute sqlstring
	rs.movenext
wend
rs.close
con.Close

response.Redirect("tafelverdeling.asp?ploeg="&ploeg)%>
</BODY>
</HTML>  