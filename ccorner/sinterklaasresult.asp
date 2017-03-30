<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Berichten</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<link href="jquery/jquery.alerts.css" rel="stylesheet" type="text/css">
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%></head>
<!--#include file="connect.asp"-->

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">

<%
sqlstring = "SELECT * FROM tblsinterklaas ORDER BY id"
rs.open sqlstring
%>
	<p class="NieuwsTitels"><font size="3">Inschrijvingen Sinterklaas</font></p>

 <table border="1" cellspacing="0">
 	<tr>
    <th>Naam</th>
    <th>Ploeg</th>
    <th colspan="4">Broertjes/zusjes</th>
   </tr>
    <%while not rs.eof%>
    	<tr>
         <td valign="top"><%=rs("naam")%></td>
       		<td valign="top"><%=rs("ploeg")%></td>
       		<td valign="top"><%=rs("bz1")%></td>
         		<td valign="top"><%=rs("bz2")%></td>
     		<td valign="top"><%=rs("bz3")%></td>
     		<td valign="top"><%=rs("bz4")%></td>
    	</tr>
    	<%
		rs.movenext
	wend
rs.close%>
</table>
</div>
</body>
</html>
