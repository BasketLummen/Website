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

strDatum = Request("frmDatum")

sqlString =  "SELECT * FROM tblNieuws WHERE datum = '"& year(strDatum)&"-"&month(strDatum)&"-"&day(strDatum) &"' ORDER BY id"

rs.open sqlString
%>
<html>
<head>
<title>Nieuws Zoeken</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
if rs.eof then
	%>
	Op <%=strDatum%> was er geen nieuws.<br>
	<%
else%>
	
<form method="post" action="nieuwsgegevens.asp">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Nieuws op <%=day(strDatum)%>&nbsp;<%=monthname(month(strDatum))%></td>
	</tr>
  	<%tel = 0
	while not rs.EOF
		tel = tel + 1%>		
		<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';">
			<td valign="top" align="center" style="border-top: 1px solid #000099;" class="prono2"><input type="radio" name="nr" value="<%=rs("id")%>" id="<%=rs("id")%>"></td>
			<td style="border-top: 1px solid #000099;" class="prono2"><label for="<%=rs("id")%>"><%=rs("nieuws")%></label></td>
		</tr>
		<%rs.movenext
	wend
	if tel = 1 then
		rs.movefirst
		response.Redirect("nieuwsgegevens.asp?nr="&rs("id"))
	end if%>
	<tr>
  		<td align="center" colspan="2"><input type="submit" value="wijzigen"></td>
	</tr>
</table>

</form>
	
<%
end if
rs.close
set rs=nothing
%><p align="center"><a href="menu.asp" class="nieuwslinks">Terug naar het menu</a></p>

</body>
</html>
