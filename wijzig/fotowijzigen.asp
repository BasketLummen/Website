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
reeks = trim(request("reeks"))

sqlString = "SELECT reeksnaam, datum, naam, aantal FROM tblFotos WHERE reeks = " & reeks
rs.open sqlString
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body>
<form method="post" action="fotobeheer.asp" name="fotos">
<table bgcolor="#FFFF00" align="center"><tr><td>
  <table cellspacing="0" cellpadding="5" class="algklassement">
	  <tr bgcolor="#000099" class="algklassementT"> 
		<td colspan="2" align="center" class="algklassementT">Foto's Wijzigen/Verwijderen</td>
	  </tr>
	  <tr bgcolor="#FFFFFF"> 
		<td>Naam:</td>
		<td> 
		  <input name="naam" type="text" id="naam" value="<%=rs("reeksnaam")%>"></td>
	  </tr>
	  <tr bgcolor="#FFFFFF"> 
		<td>Datum:</td>
		<td><input name="datum" type="text" id="datum" value="<%=rs("datum")%>"></td>
	  </tr>
	  <tr bgcolor="#CCCCCC"> 
		<td>Bestandsnaam:</td>
		<td><input name="bestandsnaam" type="text" id="bestandsnaam" value="<%=rs("naam")%>"></td>
	  </tr>
	  <tr bgcolor="#FFFFFF"> 
		<td>Aantal:</td>
		<td> 
		  <input name="aantal" type="text" id="aantal" value="<%=rs("aantal")%>"></td>
	  </tr>
	  <tr bgcolor="#CCCCCC"> 
		<td colspan="2">
			<label for="wijzigen"><input type="radio" name="keuze" value="wijzigen" id="wijzigen" checked>Wijzigen</label>
			<label for="verwijderen"><input type="radio" name="keuze" value="verwijderen" id="verwijderen">Verwijderen</label>
		</td>
	  </tr>
	 <tr> 
		<td align="center" bgcolor="#000099" colspan="5">
		<input type="hidden" name="reeks" value="<%=reeks%>">
		<input type="submit" value="wijzigen/verwijderen"></td>
	  </tr>
	</table>
</td>
    </tr>
  </table>

</form>
<script language="javascript">
  document.fotos.naam.focus();
</script>
<p align="center"><a href="../nu/menu.asp" class="algklassement">Terug naar het menu</a></p>

</body>
</html>
