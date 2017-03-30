<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect2.asp" --><%
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
sqlString =  "SELECT * FROM tblNieuws WHERE id = " & strNr

rs.open sqlString

%>
<html>
<head>
<title>Nieuwsgegevens</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<%if rs.eof then
  %>nieuwsnummer niet gevonden<%
else%>
  <form method="post" action="nieuwsbeheer.asp">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Nieuws wijzigen</td>
	</tr>
    <tr>
	  <td>Nr:</td>
      <td><input name="frmNr" type="text" id="frmNr" value="<%=strNr%>"></td>
      <td>Datum:</td>
      <td colspan="2"><input name="frmDatum" type="text" id="frmDatum" value="<%=rs("datum")%>"></td>
    </tr>
    <tr>
      <td valign="top">Onderwerp</td>
      <td colspan="4"><input name="onderwerp" type="text" id="onderwerp" tabindex="3" size="40" value="<%=rs("onderwerp")%>"></td>
    </tr>
    <tr>
      <td valign="top">Nieuws:</td>
	  <%strNieuws = Replace(rs("nieuws"),"<br>", chr(13) & chr(10))%>
      <td colspan="4"><textarea name="frmNieuws" cols="100" id="frmNieuws" rows="10" tabindex="1"><%=strNieuws%></textarea></td>
    </tr>
	<tr> 
      <td>&nbsp;</td>
      <td width="35%" align="center">Link</td>
      <td width="46%" align="center" colspan="2">URL</td>
      <td width="11%" align="center">NV - PO</td>
    </tr>
	<%
	rs.close
	sqlString = "SELECT * FROM tblNieuwsLinks WHERE idl = " & strNr
	rs.open sqlString
    tel=1
	while not rs.eof
		if kleur = "#CCCCCC" then
			kleur = "#FFFFFF"
		else
			kleur = "#CCCCCC"
		end if
		%>
    	<tr bgcolor="<%=kleur%>"> 
      		<td><%=tel%>:</td>
      		<td><input name="frmLink<%=tel%>" type="text" value="<%=rs("linktekst")%>" size="40" tabindex="<%=tel*3%>"></td>
      		<td colspan="2"><input name="frmURL<%=tel%>" type="text" value="<%=rs("linkurl")%>" size="70" tabindex="<%=(tel*3)+1%>"></td>
      		<td align="center"> <input type="checkbox" name="frmNVenster<%=tel%>" value="checkbox" tabindex="<%=(tel*3)+1%>" 
			<%if rs("venster") = 2 then%>
				checked
			<%end if%>	
			> -  <input type="checkbox" name="frmPopup<%=tel%>" value="checkbox" 
			<%if rs("venster") = 1 then%>
				checked
			<%end if%>	
			></td>
    	</tr>
		<%
		tel =  tel + 1
		rs.movenext	
	wend
	for tel = tel to 5%><tr> 
      		<td><%=tel%>:</td>
      		<td><input name="frmLink<%=tel%>" type="text" size="40" tabindex="<%=tel*3%>"></td>
      		<td colspan="2"><input name="frmURL<%=tel%>" type="text" value="http://www.basketlummen.be/" size="70" tabindex="<%=(tel*3)+1%>"></td>
      		<td align="center"> <input type="checkbox" name="frmNVenster<%=tel%>" value="checkbox" tabindex="<%=(tel*3)+1%>"> - <input type="checkbox" name="frmPopup<%=tel%>" value="checkbox"></td>
    	</tr><%
	next
	%>
	<tr>
	  <td></td>
      <td align="center">	
		<input type="radio" name="wijzigen" value="1" id="1" checked><label for="1">Wijzigen</label>
		<input type="radio" name="wijzigen" value="2" id="2"><label for="2">Verwijderen</label>
	  </td>
	  <td align="right" colspan="2">
		<input type="submit" value="wijzigen" tabindex="2">
	  </td>
	  <td></td>
 	</tr>
</table>
</form>
<%end if
rs.close
set rs = nothing
%>
<p align="center"><a href="menu.asp" class="nieuwslinks">Terug naar het menu</a></p>
</body>
</html>
