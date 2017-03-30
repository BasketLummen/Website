<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"--><%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authorizedUsers2="26,693"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1)  Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If
%>
<html>
<head>
<title>Basket Lummen - Nieuws Toevoegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
dim venster(5)
dim strLink(5)
dim strURL(5)

wijzigen = Request("wijzigen")
toevoegen = Request("toevoegen")
strNr = trim(Request("nr"))
if wijzigen = 2 then
  sqlString = "DELETE FROM tblNieuws WHERE id = " & strNr
  con.execute sqlString
  sqlString = "DELETE FROM tblNieuwsLinks WHERE idl = " & strNr
  con.execute sqlString
else
	datum = cdate(trim(request("frmDatum")))
	strdatum = year(datum) & "-" & month(datum) & "-" & day(datum)
	strNieuws = trim(Request("frmNieuws"))
	strNieuws = Replace(strNieuws, chr(13) & chr(10), "<br>")
	strNieuws = Replace(strNieuws, "'", "´")
	strOnderwerp = trim(Request("onderwerp"))
  if wijzigen = 1 then
	for i = 0 to 5
		strLink(i) = trim(Request("frmLink"& (i+1)))
		strURL(i) = trim(Request("frmURL" & (i+1)))
		venst = Request("frmNVenster" & (i+1))
		popup = Request("frmPopup" & (i+1))
		if venst = "" and popup = "" then
			venster(i) = 0
		elseif popup = "checkbox" then
			venster(i) = 1
		else
			venster(i) = 2
		end if
	next

	sqlString = "UPDATE tblNIEUWS " &_
				  "SET " &_
					"datum = '" & strdatum & "', " &_
					"onderwerp = '" & strOnderwerp & "', " &_
					"nieuws = '" & strNieuws & "', " &_
					"auteur = " & session("BL_lidid") & _
				  " WHERE id = " & strNr
	con.execute sqlString
    sqlString = "DELETE FROM tblNieuwsLinks WHERE idl = " & strNr
    con.execute sqlString
  elseif toevoegen = 1 then
	for i = 0 to 5
		strLink(i) = trim(Request("frmLink"& (i+1)))
		strURL(i) = trim(Request("frmURL" & (i+1)))
		venst = Request("frmNVenster" & (i+1))
		popup = Request("frmPopup" & (i+1))
		if venst = "" and popup = "" then
			venster(i) = 0
		elseif popup = "checkbox" then
			venster(i) = 1
		else
			venster(i) = 2
		end if
	next
  	sqlString = "INSERT INTO tblNIEUWS" &_
					"(datum, onderwerp, nieuws, auteur) " &_ 
				"VALUES" &_
					"('" & strDatum & "', '" & strOnderwerp & "', '" & strNieuws & "', " & session("BL_lidid") & ")"
	con.execute sqlString
	
	
	sqlString = "SELECT id FROM tblNIEUWS WHERE id = LAST_INSERT_ID()" 
	rs.open sqlString
	strnr = rs("id")
	rs.close
  end if
  
  for i = 0 to 4
	  if not isnull(strLink(i)) and strLink(i) <> "" then
			sqlString = "INSERT INTO tblNieuwsLinks " &_
						"VALUES" &_
							"( " & strNr & ", "&(i+1)&", '" & strLink(i) & "', '" & strURL(i) & "', " & venster(i) & ")"
			
			con.execute sqlString
	  end if
  next	
end if
con.close%>
Het  nieuws van <%=day(strDatum)%>/<%=month(strDatum)%> is opgeslaan.
</div></body>
</html>
