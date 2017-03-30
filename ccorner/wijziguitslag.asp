<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
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

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Kalender</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.crij {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">

<%
seizoen = trim(request("s"))
if s="" or isnull(seizoen) then seizoen = "1415"

intMatchnr = trim(request("matchnr"))

sqlString = "SELECT wedstrijd_id, speeldag, datum, thuisresult, uitresult, " &_
			"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl " &_ 
			"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1 " &_
			"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_ 
			"AND wedstrijd_id = " & intMatchnr

rs.open sqlString

if rs.eof then
	%>Matchnummer niet gevonden.<%
else%>
<form name="kalwijzigen" method="post" action="wijziguitslagopslaan.asp">
<input type="hidden" name="frmMatchnr" value="<%=rs("wedstrijd_id")%>">
<table bgcolor="#FFFF00" align="center"><tr><td>
  <table cellspacing="0" cellpadding="5" class="algklassement" width="100%">
    <tr bgcolor="#000099">
	  <td class="algklassementT" align="center" colspan="3">Wedstrijd wijzigen:</td>
	</tr>
  	<tr bgcolor="#FFFFFF">
     	<td>Match:</td>
		<td><%=rs("wedstrijd_id")%></td>
		<td><%=rs("thuispl")%>&nbsp;-&nbsp;<%=rs("uitpl")%></td>
	</tr>	
	<tr bgcolor="#CCCCCC">
		<td>Datum :</td>
		<td colspan="2"><%=rs("datum")%></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td>Uur :</td>
		<td colspan="2">
			<%if not isnull(rs("datum")) then%>
				 <%=FormatDateTime(rs("datum"),4)%>
			<%end if%>
		</td>
	</tr>
	<tr bgcolor="#CCCCCC">
		<td>Uitslag:</td>
		<td><input type="text" name="frmThuisres" value="<%=rs("thuisresult")%>" size="5"></td>
		<td><input type="text" name="frmUitres" value="<%=rs("uitresult")%>" size="5"></td>
	</tr>
	<tr bgcolor="#000099">
		<td colspan="3" align="center"><input type="submit" value="Opslaan"></td>
	</tr>
	</table></td></tr></table>
	</form>
<%end if
rs.close
con.close
%>
</div></body>
</html>
