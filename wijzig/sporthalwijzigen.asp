<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp" -->
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
<%nr = trim(request("nr"))

set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con
%>
<html>
<head>
<title>Sporthal wijzigen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<p align="center">
<form name="jump">
<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<option>Kies een sporthal</option>
	<%sqlString = "SELECT sporthalnr, sporthalnaam, sporthaladres, tblGemeenten.postnr, gemeente FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.postnr ORDER BY tblGemeenten.postnr, sporthalnaam"
	rs.open sqlString
	while not rs.eof%>
		<option value="sporthalwijzigen.asp?nr=<%=rs("sporthalnr")%>"><%=rs("postnr")%>&nbsp;<%=rs("gemeente")%>, <%=rs("sporthalnaam")%>, <%=rs("sporthaladres")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</form>
</p>
<%if not isnull(nr) and nr<> "" then
	sqlString = "SELECT sporthalnaam, sporthaladres, sporthalpostnr, afbeeldingen FROM tblSporthallen WHERE sporthalnr = " & nr
	rs.open sqlString%>
	<form method="post" action="sporthalbeheer.asp" name="sporthal">
	<table bgcolor="#FFFF00" align="center"><tr><td>
	<table cellspacing="0" cellpadding="5" class="algklassement" width="100%">
	<tr bgcolor="#000099">
		<td class="algklassementT" align="center" colspan="2">Sporthal wijzigen</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td colspan="2" align="center"><label for="wijzigen"><input type="radio" name="keuze" value="wijzigen" id="wijzigen" checked>wijzigen</label>
		<label for="verwijderen"><input type="radio" name="keuze" value="verwijderen" id="verwijderen">verwijderen</label></td>
	</tr>
	<tr bgcolor="#CCCCCC">
		<td>Naam</td>
		<td><input type="text" name="naam" value="<%=rs("sporthalnaam")%>" size="50"></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td>Adres</td>
		<td><input type="text" name="adres" value="<%=rs("sporthaladres")%>" size="50"></td>
	</tr>
	<tr bgcolor="#CCCCCC">
		<td>Gemeente</td>
		<td><select name="gemeente">
			<option></option>
		<%sqlString = "SELECT postnr, gemeente FROM tblGemeenten ORDER BY postnr"
			rs1.open sqlString
			while not rs1.eof%>
				<option value="<%=rs1("postnr")%>" <%
				if rs1("postnr") = rs("sporthalpostnr") then
					%>selected<%
				end if
				%>><%=rs1("postnr")%>&nbsp;<%=rs1("gemeente")%></option>
				<%rs1.movenext
			wend
		rs1.close%>
		</select>
</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td>Plan</td>
		<td><input type="text" name="aantal" value="<%=rs("afbeeldingen")%>" size="50"></td>
	</tr>
	<input type="hidden" name="nr" value="<%=nr%>">
	<tr>
		<td bgcolor="#000099" colspan="2" align="center"><input type="submit" value="Wijzigen"></td>
	</tr>
	</table></td></tr></table>
	
	</form>
<%end if%>
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>
<script language="javascript">
  document.sporthal.naam.focus();
</script>
</body>
</html>
