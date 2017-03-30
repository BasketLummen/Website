<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"--><%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
MM_authorizedUsers2="802"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If
%>
<HTML>
<HEAD>
<TITLE>Basket Lummen - links</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
-->
</style>
</head>

<BODY>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">

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
<%else%>
<form action="linkswijzigen.asp" method="post">
<table>
<tr align="center">
<td></td>
<td>Club</td>
<td>URL</td>
<td>Reeks</td>
<td>Verwijderen</td>
</tr>
<%while not rs.eof%>
	<tr>
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
		<td align="center"><a href="<%=rs("link")%>" target="_blank">Test link</a></td>
        
		<td align="center"><input type="checkbox" value="verw" name="verwijder_<%=rs("linkid")%>"></td>
	</tr>
	<%rs.movenext
wend%>
<tr><td colspan="5" align="center"><input type="submit" value="opslaan" ID=Submit1></td></tr>
</form>
<%end if%>
</table>
<p><a href="linkstoevoegen.asp">Toevoegen</a></p>
<p><a href="linkswijzigen.asp">Overzicht</a></p>
</div>
</BODY>
</HTML>
