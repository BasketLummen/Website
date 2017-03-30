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


club = trim(request("club"))
if club <> "" and not isnull(club) then
		club = replace(club,"'","´")
		link = trim(request("link"))
		reeks = trim(request("reeks"))
		provincie = trim(request("provincie"))
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
		sqlString = "SELECT max(linkid) AS nr FROM tblLinks"
		rs.open sqlString
		nr = rs("nr") + 1
		rs.close
		sqlString = "INSERT INTO tblLinks VALUES(" &_
					nr & ", '" & club & "', '" & link & "', " & soort & ", '" & reeksnaam(reeks) & "', " & provincie & ")"
		con.Execute sqlString%>
	<p><a href="linkswijzigen.asp"><%=club%> is opgeslaan</a></p>
<%end if%>
<form action="linkstoevoegen.asp" method="post">
<table>
<tr align="center">
<td>Club</td>
<td>URL</td>
<td>Reeks</td>
<td>Provincie</td>
</tr>
	<tr>
		<td><input type="text" name="club"></td>
		<td><input type="text" name="link" size="50"></td>
		<td>
		<select name="reeks">
			<option value="14"></option>
			<%for i = 0 to 14%>
			<option value="<%=i%>"><%=reeksnaam(i)%></option>
			<%next%>
		</select></td><td>
		<select name="provincie">
			<option value="0">geen</option>
			<option value="11">Vlaams-Brabant</option>
			<option value="12">Antwerpen</option>
			<option value="13">Limburg</option>
			<option value="14">Luik</option>
			<option value="15">Namen</option>
			<option value="16">Luxemburg</option>
			<option value="17">Henegouwen</option>
			<option value="18">West-Vlaanderen</option>
			<option value="19">Oost-Vlaanderen</option>
			<option value="20">Waals-Brabant</option>
		</select>
		</td>
	</tr>
<tr><td colspan="3" align="center"><input type="submit" value="opslaan" ID=Submit1></td></tr>
</form>
</table>
<p><a href="linkswijzigen.asp">Terug naar linkoverzicht</a></p>
<p><a href="menu.asp">Terug naar menu</a></p>
</BODY>
</HTML>
