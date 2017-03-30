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

sqlString = "SELECT nummer, naam, voornaam, tblTopschPloegen.ploeg " &_
			"FROM tblTopschSpelers INNER JOIN tblTopschPloegen ON tblTopschSpelers.ploeg = tblTopschPloegen.ploegid "
if Session("MM_UserAuthorization") = 3 then sqlString = sqlString & "WHERE reeks = 'D' "
sqlString = sqlString & "ORDER BY reeks, tblTopschPloegen.ploeg, naam, voornaam"
rs.open sqlString%>
<html>
<head>
<title>Topschutters speler wijzigen</title>
</head>

<body>
<form>
<p align="center"><select onChange="location.href=this.value">
<option>Andere speler</option>
<%
while not rs.eof%>
	<option value="topschspelerwijzigen.asp?nr=<%=rs("nummer")%>">
	<%if ploeg <> rs("ploeg") then
		ploeg = rs("ploeg")
		%>------------<%=rs("ploeg")%>&nbsp;------------</option><%
	else
		%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs("voornaam")%>&nbsp;<%=rs("naam")%></option>
		<%rs.movenext
	end if
wend
rs.close%>
</select></p></form>
<%
nr = trim(request("nr"))
if nr <> "" then
	voornaam = trim(request("voornaam"))
	naam = trim(request("naam"))
	ploeg = trim(request("ploeg"))
	if naam <> "" and ploeg <> "" then
		keuze = trim(request("keuze"))
		if keuze = "wijzigen" then
			sqlString = "UPDATE tblTopschSpelers SET voornaam = '" & voornaam & "', naam = '" & naam & "', ploeg = " & ploeg & " WHERE nummer = " & nr
			con.execute(sqlString)%>
			<p align="center">Speler gewijzigd.</p>
		<%else
			sqlString = "DELETE FROM tblTopschSpelers WHERE nummer = " & nr
			con.execute(sqlString)
			sqlString = "DELETE FROM tblTopschPunten WHERE spelerid = " & nr
			con.execute(sqlString)%>
			<p align="center">Speler verwijderd.</p>
		<%end if
	else
		sqlString = "SELECT naam, voornaam, ploeg FROM tblTopschSpelers WHERE nummer = " & nr
		rs.open sqlString%>
		<form method="post" action="topschspelerwijzigen.asp">
			<input type="hidden" name="nr" value="<%=nr%>">
			<table align="center">
				<tr><td>Voornaam</td><td><input type="text" name="voornaam" value="<%=rs("voornaam")%>"></td></tr>		
				<tr><td>Naam</td><td><input type="text" name="naam" value="<%=rs("naam")%>"></td></tr>	
				<tr><td>Ploeg</td><td>
				<select name="ploeg">
					<option></option>
					<%
					set rsPloeg = server.CreateObject("ADODB.Recordset")
					rsPloeg.ActiveConnection= Con
					sqlString = "SELECT ploegid, ploeg FROM tblTopschPloegen "
					if Session("MM_UserAuthorization") = 3 then sqlString = sqlString & "WHERE reeks = 'D' "
					sqlString = sqlString &  "ORDER BY reeks, ploeg"
					rsPloeg.open sqlString
					while not rsPloeg.eof%>
						<option value="<%=rsPloeg("ploegid")%>"<%
						if rsPloeg("ploegid") = rs("ploeg") then
							%> selected<%
						end if
						%>><%=rsPloeg("ploeg")%></option>
						<%rsPloeg.movenext
					wend%>
				</select>
				</td></tr>
				<tr>
				<td colspan="2" align="center">
				<label for="1"><input type="radio" name="keuze" value="wijzigen" checked id=1>Wijzigen</label>
				<label for="2"><input type="radio" name="keuze" value="verwijderen" id=2>Verwijderen</label>
				</td>
				</tr>
			</table>
			<p align="center"><input type="submit" value="Opslaan"></p>
		</form>
	<%end if%>
<%end if%>
<p align="center"><a href="menu.asp">Terug naar menu</a></p>
</body>
</html>
