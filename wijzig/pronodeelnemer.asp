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
<%dn = trim(request("dn"))%>
<html>
<head>
<title>Basket Lummen - Pronostiek</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body class="hotnews">
<p align="center">
<form name="jump">
<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<option>Kies een deelnemer</option>
	<%sqlString = "SELECT Spelernr, naam, voornaam FROM tblpronodeelnemers ORDER BY naam, voornaam"
	rs.open sqlString
	while not rs.eof%>
		<option value="pronodeelnemer.asp?dn=<%=rs("Spelernr")%>"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%> (<%=rs("Spelernr")%>)</option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</form>
</p>
<%
if not isnull(dn) and dn <> "" then
	sqlString = "SELECT naam, voornaam, email FROM tblpronodeelnemers WHERE Spelernr = " & dn
	rs.open sqlString%>
	<form name="registreren" method="POST" action="pronodeelnemerwijzigen.asp">
	 <input type="hidden" name="dn" value="<%=dn%>">
	  <table bgcolor="#FFFF00" align="center">
		<tr> 
		  <td> <table cellspacing="0" cellpadding="5" class="algklassement" width="100%">
			  <tr bgcolor="#000099"> 
				<td class="algklassementT" align="center" colspan="2">Basket Lummen 
				  - Pronostiek<br>
				  Gegevens deelnemer <%=dn%>: </td>
			  </tr>
			  <tr bgcolor="#FFFFFF"> 
				<td>Voornaam:</td>
				<td><input name="voornaam" type="text" id="naam" tabindex="1" value="<%=rs("voornaam")%>"></td>
			  </tr>
			   <tr bgcolor="#CCCCCC"> 
				<td>Naam:</td>
				<td><input name="naam" type="text" id="anaam" tabindex="2" value="<%=rs("naam")%>"></td>
			  </tr>
			  <tr bgcolor="#FFFFFF"> 
				<td>E-mailadres:</td>
				<td><input name="email" type="text" id="email" tabindex="3" value="<%=rs("email")%>"></td>
			  </tr>
			   <tr bgcolor="#CCCCCC"> 
				<td>Verwijderen:</td>
				<td><input name="verwijderen" type="checkbox" id="verwijderen" tabindex="4" value="ja"></td>
			  </tr>
			  <tr> 
				<td align="center" bgcolor="#000099" colspan="2"><input type="submit" name="Submit" value="Wijzigen" tabindex="5"> 
				</td>
			  </tr>
			</table></td>
		</tr>
	  </table>
	</form>
<%end if%>
</body>
</html>
