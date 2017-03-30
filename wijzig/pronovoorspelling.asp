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
<html>
<head>
<title>Basket Lummen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
matchnr = trim(request("matchnr"))


sqlString = "SELECT matchnr, datum, thuisploeg, uitploeg, winnaar FROM tblpronoWedstrijden ORDER BY datum, matchnr"
rs.open sqlString%>
<p align="center">
<form name="jump">
<select size="10" id="menu" name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<%while not rs.eof%>
		<option value="pronovoorspelling.asp?matchnr=<%=rs("matchnr")%>"
		<%if rs("matchnr") = int(matchnr) then%>
			selected
		<%end if%>
		><%=rs("datum")%>&nbsp;<%=rs("thuisploeg")%> - <%=rs("uitploeg")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</form>
</p>





<%

set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con


sqlString = "SELECT datum, thuisploeg, uitploeg, winnaar FROM tblpronoWedstrijden WHERE matchnr = " & matchnr
rs.open sqlString

if not rs.eof then%>
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;" width="400">
	<tr bgcolor="#DDDDDD" align="center"><td colspan="3" class="NieuwsTitels"><%=rs("datum")%></td></tr>
	<tr bgcolor="#DDDDDD"> 
		<td class="NieuwsTitels"><a href="pronovoorspelling.asp?matchnr=<%=(matchnr-1)%>"><img src="../img/driehoek_rood2.gif" width="5" height="9" border="0"></a> <%=rs("thuisploeg")%></td>
		<td class="NieuwsTitels">-</td><td class="NieuwsTitels" align="right"><%=rs("uitploeg")%><%rs.close%> <a href="pronovoorspelling.asp?matchnr=<%=(matchnr+1)%>"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0"></a></td>
	</tr>	<%
	sqlString = "SELECT naam, voornaam, prono FROM tblpronostiek INNER JOIN tblpronoDeelnemers ON tblpronostiek.Spelernr = tblpronoDeelnemers.Spelernr " &_
				"WHERE matchnr = " & matchnr & " AND prono = 1 " &_ 
				"ORDER BY naam, voornaam" 
	rs.open sqlString
	sqlString = "SELECT naam, voornaam, prono FROM tblpronostiek INNER JOIN tblpronoDeelnemers ON tblpronostiek.Spelernr = tblpronoDeelnemers.Spelernr " &_
				"WHERE matchnr = " & matchnr & " AND prono = 2 " &_ 
				"ORDER BY naam, voornaam" 
	rs1.open sqlString
	sw = 0
	sw1 = 0
	while sw = 0 or sw1 = 0%>
		<tr><td>
		<%if not rs.eof then%>
			<%=rs("voornaam")%>&nbsp;<%=rs("naam")%>				
			<%rs.movenext
		else
			sw = 1
		end if%>
		</td><td></td><td align="right">
		<%if not rs1.eof then%>
			<%=rs1("voornaam")%>&nbsp;<%=rs1("naam")%>				
			<%rs1.movenext
		else
			sw1 = 1
		end if%>
		</td></tr>
	<%wend
	rs.close
	rs1.close%>	
</table>
<%end if%></p>
<p align="center"><a href="menu.asp" class="NieuwsTitels"><font size="3">Terug naar menu</font></a></p>
<script language="javascript">
  document.jump.menu.focus();
</script>
</body>
</html>
