<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
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
<!--#include file="connect2.asp" -->
<html>
<head>
<title>Basket Lummen</title>
<link href="../opening.css" rel="stylesheet" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
sqlString = "SELECT matchnr FROM tblpronowedstrijden"
rs.open sqlString%>
<%while not rs.eof
	wijzig = trim(request("gewijzigd" & rs("matchnr")))
	if wijzig = "ja" then
		speeldag = trim(request("speeldag" & rs("matchnr")))
		datum = trim(request("datum" & rs("matchnr")))
		thuisploeg = trim(request("thuisploeg" & rs("matchnr")))
		uitploeg = trim(request("uitploeg" & rs("matchnr")))
		winnaar  = trim(request("winnaar" & rs("matchnr")))
		sqlString = "UPDATE tblpronowedstrijden SET " &_
			"speeldag = " & speeldag & ", " &_
			"datum = '" & year(datum)&"-"&month(datum)&"-"&day(datum)&" "&hour(datum)&":"&minute(datum)&":00', " &_
			"thuisploeg = '" & thuisploeg & "', " &_
			"uitploeg = '" & uitploeg & "', " &_ 
			"winnaar = "
		if isnull(winnaar) or winnaar = "" then
			sqlString = sqlString & " NULL "
		else
			sqlString = sqlString & winnaar & " "
		end if
			sqlString = sqlString & "WHERE matchnr = " & rs("matchnr")
		'response.write(sqlString)
		con.execute sqlString
	end if%>
	<%rs.movenext
wend
rs.close
con.close%>
<p>Wedstrijden gewijzigd.</p>
</body>
</html>
