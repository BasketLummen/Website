<!--#include file="connect2.asp"-->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,3"
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
sd = trim(request("sd"))

sqlString = "SELECT tblTopschSpelers.nummer, naam, voornaam, tblTopschPloegen.ploeg, reeks, speeldag, punten " &_
			"FROM tblTopschPloegen INNER JOIN (tblTopschSpelers INNER JOIN tblTopschPunten ON tblTopschSpelers.nummer = tblTopschPunten.spelerid) ON tblTopschPloegen.ploegid = tblTopschSpelers.ploeg " &_
			"WHERE speeldag = " & sd & " "
if Session("MM_UserAuthorization") = 3 then 
	sqlString = sqlString & "AND reeks = 'D' "
else
	sqlString = sqlString & "AND reeks <> 'D' "
end if
			sqlString = sqlString & "ORDER BY reeks, tblTopschPloegen.ploeg, naam, voornaam"
rs.open sqlString%>
<html>
<head>
<title>Topschutters opslaan.</title>
</head>

<body>
<%while not rs.eof
	punten = trim(request(rs("nummer")))
	if punten = "" then
		punten = 0
	end if
	sqlString = "UPDATE tblTopschPunten SET punten = " & punten & " WHERE spelerid = " & rs("nummer") & " AND speeldag = " & sd
	con.execute(sqlString) 
	rs.movenext
wend
%>
Punten opgeslagen voor speeldag <%=sd%>.
<p align="center"><a href="menu.asp">Terug naar menu</a></p>


</body>
</html>
