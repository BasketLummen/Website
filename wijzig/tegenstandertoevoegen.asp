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
<html>
<head>
<title>Tegenstander toevoegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opening.css" rel="stylesheet" type="text/css">
</head>

<body class="hotnews">
<p align="center" class="tgsttitel">toevoegen</p>
<form method="post" action="tegenstanderwijzigen.asp" name="tgst">
<table aling="center" border="0" class="hotnews">
  <tr valign="top"> 
	<td nowrap bgcolor="#000099" class="tgstlinks" width="120">Stamnummer</td>
	<td nowrap  bgcolor="#E0E0E0"><input ntype="text" name="stamnr" size="10"></td>
  </tr>
  <tr valign="top"> 
	<td nowrap bgcolor="#000099" class="tgstlinks" width="120">Volledige naam</td>
	<td nowrap  bgcolor="#E0E0E0"><input ntype="text" name="naam" size="50"></td>
  </tr>
  <tr valign="top"> 
	<td nowrap bgcolor="#000099" class="tgstlinks" width="120">Korte naam</td>
	<td nowrap  bgcolor="#E0E0E0"><input type="text" name="kortenaam"></td>
  </tr>
  <tr valign="top"> 
	<td nowrap bgcolor="#000099" class="tgstlinks" width="120">Sporthal 1</td>
	<td  bgcolor="#E0E0E0">
	<select name="sporthal1">
		<option></option>
		<%sqlString = "SELECT sporthalnr, sporthalnaam, sporthaladres, tblGemeenten.postnr, gemeente FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.postnr ORDER BY tblGemeenten.postnr, sporthalnaam"
		rs.open sqlString
		while not rs.eof%>		
			<option value="<%=rs("sporthalnr")%>"><%=rs("postnr")%>&nbsp;<%=rs("gemeente")%>, <%=rs("sporthalnaam")%>, <%=rs("sporthaladres")%></option>
			<%rs.movenext
		wend
		rs.close%>
	</select>
	</td>
  </tr>
  <tr valign="top"> 
	<td nowrap bgcolor="#000099" class="tgstlinks" width="120">Sporthal 2</td>
	<td  bgcolor="#E0E0E0">
	<select name="sporthal2">
		<option></option>
		<%sqlString = "SELECT sporthalnr, sporthalnaam, sporthaladres, tblGemeenten.postnr, gemeente FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.postnr ORDER BY tblGemeenten.postnr, sporthalnaam"
		rs.open sqlString
		while not rs.eof%>		
			<option value="<%=rs("sporthalnr")%>"><%=rs("postnr")%>&nbsp;<%=rs("gemeente")%>, <%=rs("sporthalnaam")%>, <%=rs("sporthaladres")%></option>
			<%rs.movenext
		wend
		rs.close
		con.close%>
	</select>
	</td>
  </tr>
  <tr valign="top"> 
	<td nowrap bgcolor="#000099" class="tgstlinks" width="120">Kleuren</td>
	<td nowrap  bgcolor="#E0E0E0">
		shirt <input name="shirt" type="text" size="10"> - 
		short <input type="text" name="short" size="10">
	</td>
  </tr>
  <tr valign="top"> 
	<td nowrap bgcolor="#000099" class="tgstlinks" height="24" width="120">Website</td>
	<td nowrap  bgcolor="#E0E0E0" height="24">
	<input name="website" type="text" size="70"></td>
  </tr>
  </table>
<input type="hidden" name="toevoegen" value="1">
<p align="center"><input type="submit" value="opslaan"></p>	
</form>
<p align="center"><a href="menu.asp" class="algklassement">Terug naar het menu</a></p>
<script language="javascript">
  document.tgst.stamnr.focus();
</script></body>
</html>