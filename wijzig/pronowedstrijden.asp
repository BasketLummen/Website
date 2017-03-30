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
sqlString = "SELECT matchnr, speeldag, datum, thuisploeg, uitploeg, winnaar FROM tblpronowedstrijden ORDER BY datum, matchnr"
rs.open sqlString%>
<form method="post" action="pronowedstrijdenopslaan.asp">
<table cellspacing=0 cellpadding=0 align=center>
<%while not rs.eof
	if dtm <> rs("datum") then%>
		<tr height=20><td colspan=7></td></tr>
		<%dtm = rs("datum")
	end if%>
	<tr>
		<td><%=rs("matchnr")%></td>
		<td><input type="text" name="speeldag<%=rs("matchnr")%>" value="<%=rs("speeldag")%>" size=3></td>	
		<td><input type="text" name="datum<%=rs("matchnr")%>" value="<%=rs("datum")%>" size=20></td>	
		<td><input type="text" name="thuisploeg<%=rs("matchnr")%>" value="<%=rs("thuisploeg")%>"></td>
		<td><input type="text" name="uitploeg<%=rs("matchnr")%>" value="<%=rs("uitploeg")%>"></td>
		<td><input type="text" name="winnaar<%=rs("matchnr")%>" value="<%=rs("winnaar")%>" size=3></td>
		<td><input type="checkbox" value="ja" name="gewijzigd<%=rs("matchnr")%>"></td>
	</tr>
	<%rs.movenext
wend
rs.close
con.close%>
<tr><td colspan="7" align="center"><input type="submit" value="opslaan"></td>
</tr>
</table>
</form>
</body>
</html>
