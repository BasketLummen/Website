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
<%
strNr = Request("nr")

sqlString =  "SELECT * FROM tblLeden WHERE lidnr = " & strNr

rs.open sqlString

%>
<html>
<head>
<title>Wijzigen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
if rs.eof then
	%>
	Foutieve naam ingegeven.<br>
	<%
else%>
	<form method="post" action="lidbeheer.asp">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Lid gegevens</td>
	</tr>
	<tr>
		<td>Voornaam</td>
		<td><input type="text" value="<%=rs("voornaam")%>" name="frmVoornaam"></td>
	</tr>
	<tr>
		<td>Naam</td>
		<td><input type="text" value="<%=rs("naam")%>" name="frmNaam"></td>
	</tr>
	<tr>
		<td>Geb.Datum</td>
		<td><input type="text" value="<%=rs("gebdatum")%>" name="frmGebDatum"></td>
	</tr>
	<tr>
		<td>Ploeg</td>
		<td><input type="text" value="<%=rs("ploeg")%>" name="frmPloeg"></td>
	</tr>
	<tr>
		<td>Nr. 1</td>
		<td><input type="text" value="<%=rs("plnr1")%>" name="frmPlnr1"></td>
	</tr>
	<tr>
		<td>Nr. 2</td>
		<td><input type="text" value="<%=rs("plnr2")%>" name="frmPlnr2"></td>
	</tr>
	<tr>
		<td>Foto</td>
		<td><input type="text" value="<%=rs("foto")%>" name="frmFoto"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="radio" name="wijzigen" value="1" id="1" checked><label for="1">Wijzigen</label>
			<input type="radio" name="wijzigen" value="2" id="2"><label for="2">Verwijderen</label>
		</td>
	</tr>
	<input type="hidden" name="frmNr" value="<%=strNr%>">
	<tr>
  		<td  colspan="2" align="center"><input type="submit" value="wijzigen"></td>
	</tr>
</table>
</form>		
<%end if
rs.close
set rs=nothing%>
<p align="center"><a href="menu.asp" class="NieuwsLinks">Terug naar het menu</a></p>
</body>
</html>
