<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect2.asp" --><%

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
<%
dim venster(5)
dim strLink(5)
dim strURL(5)

wijzigen = Request("wijzigen")
toevoegen = Request("toevoegen")
strNr = trim(Request("frmNr"))
datum = cdate(trim(request("frmDatum")))
strdatum = year(datum) & "-" & month(datum) & "-" & day(datum)
strNieuws = trim(Request("frmNieuws"))
strNieuws = Replace(strNieuws, chr(13) & chr(10), "<br>")
strNieuws = Replace(strNieuws, "'", "´")
strOnderwerp = trim(Request("onderwerp"))
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
%>
<html>
<head>
<title>Nieuws Beheer</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body class="algklassement">
<%
if wijzigen = 2 then
  sqlString = "DELETE FROM tblNieuws WHERE id = " & strNr
  con.execute sqlString
  sqlString = "DELETE FROM tblNieuwsLinks WHERE idl = " & strNr
  con.execute sqlString
else
  if wijzigen = 1 then
	sqlString = "UPDATE tblNIEUWS " &_
				  "SET " &_
					"datum = '" & strdatum & "', " &_
					"onderwerp = '" & strOnderwerp & "', " &_
					"nieuws = '" & strNieuws & "' " &_
				  "WHERE id = " & strNr
	con.execute sqlString
    sqlString = "DELETE FROM tblNieuwsLinks WHERE idl = " & strNr
    con.execute sqlString
  elseif toevoegen = 1 then
  	sqlString = "INSERT INTO tblNIEUWS" &_
					"(datum, onderwerp, nieuws) " &_ 
				"VALUES" &_
					"('" & strDatum & "', '" & strOnderwerp & "', '" & strNieuws & "')"
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
%>
Het  nieuws van <%=strDatum%> is opgeslaan.
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>
</body>
</html>
