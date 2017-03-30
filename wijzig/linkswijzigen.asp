<!--#include file="connect2.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,4"
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
<HTML>
<HEAD>
<TITLE></TITLE>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<BODY>
<%
dim reeksnaam(15)
reeksnaam(0) = "1ste nationale"
reeksnaam(1) = "2de nationale"
reeksnaam(2) = "3de nationale A"
reeksnaam(3) = "3de nationale B"
reeksnaam(4) = "1ste landelijke"
reeksnaam(5) = "2de landelijke A"
reeksnaam(6) = "2de landelijke B"
reeksnaam(7) = "1ste regionale A"
reeksnaam(8) = "1ste regionale B"
reeksnaam(9) = "1ste nationale dames"
reeksnaam(10) = "1ste landelijke dames"
reeksnaam(11) = "2de landelijke dames A"
reeksnaam(12) = "2de landelijke dames B"
reeksnaam(13) = "Provinciale"
reeksnaam(14) = "Algemene"

sqlString = "SELECT * FROM tblLinks ORDER BY soort, reeks, club"
rs.open sqlString

club = trim(request("club_"&rs("linkid")))
if club <> "" and not isnull(club) then
	while not rs.eof
		club = trim(request("club_"&rs("linkid")))
		club = replace(club,"'","´")
		link = trim(request("link_"&rs("linkid")))
		reeks = trim(request("reeks_"&rs("linkid")))
		verwijder = trim(request("verwijder_"&rs("linkid")))
		if verwijder = "verw" then
			sqlString = "DELETE FROM tblLinks WHERE linkid = " & rs("linkid")
			con.Execute sqlString
		else
			select case reeks
				case 0 : soort = 1
				case 1 : soort = 2
				case 2 : soort = 3
				case 3 : soort = 3
				case 4 : soort = 4
				case 5 : soort = 4
				case 6 : soort = 4
				case 7 : soort = 5
				case 8 : soort = 5
				case 9 : soort = 6
				case 10 : soort = 6
				case 11 : soort = 6
				case 12 : soort = 6
				case 13 : soort = 7
				case 14 : soort = 8
			end select
			sqlString = "UPDATE tblLinks SET " &_
						"club = '" & club & "', " &_
						"link = '" & link & "', " &_
						"soort = " & soort & ", " &_
						"reeks = '" & reeksnaam(reeks) & "' " &_
						"WHERE linkid = " & rs("linkid")
			con.Execute sqlString
		end if
		rs.MoveNext
	wend%>
	<p><a href="linkswijzigen.asp">Terug naar linkoverzicht</a></p>
<%else%>
<form action="linkswijzigen.asp" method="post">
<table>
<tr align="center">
<td>Nummer</td>
<td>Club</td>
<td>URL</td>
<td>Reeks</td>
<td>Verwijderen</td>
</tr>
<%while not rs.eof%>
	<tr>
		<td align="center"><a href="<%=rs("link")%>" target="_blank"><%=rs("linkid")%></a></td>
		<td><input type="text" value="<%=rs("club")%>" name="club_<%=rs("linkid")%>"></td>
		<td><input type="text" value="<%=rs("link")%>" name="link_<%=rs("linkid")%>" size="50"></td>
		<td>
		<select name="reeks_<%=rs("linkid")%>">
			<%for i = 0 to 14%>
			<option value="<%=i%>"<%
			if reeksnaam(i) = rs("reeks") then
				%> selected<%
			end if%>><%=reeksnaam(i)%></option>
			<%next%>
		</select>
		</td>
		<td align="center"><input type="checkbox" value="verw" name="verwijder_<%=rs("linkid")%>"></td>
	</tr>
	<%rs.movenext
wend%>
<tr><td colspan="5" align="center"><input type="submit" value="opslaan" ID=Submit1></td></tr>
</form>
<%end if%>
</table>
<p><a href="linkstoevoegen.asp">Toevoegen</a></p>
<p><a href="menu.asp">Terug naar menu</a></p>
</BODY>
</HTML>
