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
lidnaam = Request("lidnaam")


sqlString = "SELECT lidnr, voornaam, naam, gebdatum, ploeg, tblPloegen.plnaam AS pln1, tblPloegen1.plnaam AS pln2 " &_
			"FROM (tblLeden LEFT JOIN tblPloegen ON tblLeden.plnr1 = tblPloegen.plnr) LEFT JOIN tblPloegen AS tblPloegen1 " &_ 
			"ON tblLeden.plnr2 = tblPloegen1.plnr " &_ 
			"WHERE naam = '" & lidnaam & "' ORDER BY gebdatum"

rs.open sqlString
%>
<html>
<head>
<title>Zoeken</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body class="algklassement">
<%
if rs.eof then
	%>
	De naam <%=lidnaam%> is niet gevonden<br>
	<%
else%>
	
<form method="post" action="lidgegevens.asp">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Lid zoeken</td>
	</tr>
  <%while not rs.EOF%>
		<tr>
			<td><input type="radio" name="nr" value="<%=rs("lidnr")%>" id="<%=rs("lidnr")%>">
			<label for="<%=rs("lidnr")%>">
			<%=rs("voornaam")%>&nbsp;
			<%=rs("naam")%>,&nbsp;
			<%=rs("gebdatum")%>,&nbsp;
			<%=rs("pln1")%>,&nbsp;
			<%=rs("pln2")%></label></td>
		</tr>
		<%rs.movenext
  wend%>
  <tr>
  	<td align="center"><input type="submit" value="wijzigen"></td>
  </tr>
  </table>
</form>
<%end if
rs.close
set rs=nothing%>
<p align="center"><a href="menu.asp" class="nieuwslinks">Terug naar het menu</a></p>
</body>
</html>
