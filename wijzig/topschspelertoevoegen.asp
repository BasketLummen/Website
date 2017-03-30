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
sqlString = "SELECT ploegid, ploeg FROM tblTopschPloegen "
if Session("MM_UserAuthorization") = 3 then sqlString = sqlString & "WHERE reeks = 'D' "
sqlString = sqlString &  "ORDER BY reeks, ploeg"
rs.open sqlString%>
<html>
<head>
<title>Topschutters speler toevoegen</title>
</head>

<body>

<%
voornaam = trim(request("voornaam"))
naam = trim(request("naam"))
ploeg = trim(request("ploeg"))
if naam <> "" and ploeg <> "" then
	rs.close
	sqlString = "SELECT max(nummer) AS nr FROM tblTopschSpelers"
	rs.open sqlString
	nr = rs("nr") + 1
	sqlString = "INSERT INTO tblTopschSpelers VALUES (" & nr & ", '" & voornaam & "', '" & naam & "', " & ploeg & ")"
	con.execute sqlString 
	for i = 1 to 26
		sqlString = "INSERT INTO tblTopschPunten VALUES (" & nr & ", " & i & ", 0)"
		con.execute sqlString 
	next%>
	<p>Speler toegevoegd.</p>
<%else%>
<form method="post" action="topschspelertoevoegen.asp">
	<table align="center">
		<tr><td>Voornaam</td><td><input type="text" name="voornaam"></td></tr>		
		<tr><td>Naam</td><td><input type="text" name="naam"></td></tr>	
		<tr><td>Ploeg</td><td>
		<select name="ploeg">
			<option></option>
			<%while not rs.eof%>
				<option value="<%=rs("ploegid")%>"><%=rs("ploeg")%></option>
				<%rs.movenext
			wend%>
		</select>
		</td></tr>
	</table>
	<p align="center"><input type="submit" value="Toevoegen"></p>
</form>
<%end if%>
<p align="center"><a href="menu.asp">Terug naar menu</a></p>

</body>
</html>
