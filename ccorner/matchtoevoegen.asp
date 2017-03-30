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
seizoen = trim(request("s"))
if s="" or isnull(seizoen) then seizoen = "1415"

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Berichten</title>
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

<form name="kalwijzigen" method="post" action="matchtoevoegenopslaan.asp">
<table bgcolor="#FFFF00" align="center"><tr><td>
  <table cellspacing="0" cellpadding="5" class="algklassement" width="100%">
    <tr bgcolor="#000099">
	  <td class="algklassementT" align="center" colspan="2">Wedstrijd toevoegen:</td>
	</tr>
  	<tr bgcolor="#FFFFFF">
     	<td>Wedstrijdnr</td>
		<td><input type="text" name="wedstrijdnr" size="10"></td>
	</tr>	
   	<tr bgcolor="#CCCCCC">
     	<td>Soort</td>
        <td>
        <select name="soort">
        	<option value="oefen">Oefenwedstrijd</option>
        	<option value="BvL">Beker van Limburg</option>
       		<option value="BvV">Beker van Vlaanderen</option>
       		<option value="BvV">Beker van België</option>
       </select>
        </td>
	</tr>	
  	<tr bgcolor="#FFFFFF">
     	<td>Thuisploeg</td>
        <%
		sqlstring = "SELECT ploeg_id, ploegnaam, plnaam2 FROM tblPloegenkal"&seizoen&" WHERE ploeg_id > 300 ORDER BY ploeg_id"
		rs.open sqlstring%>
		<td><select name="thuisploeg">
        <option value="1"></option>
        <option value="0">(nog niet bekend)</option>
        <%while not rs.eof%>
			<option value="<%=rs("ploeg_id")%>"><%=rs("ploeg_id")%> - <%=rs("ploegnaam")%> - <%=rs("plnaam2")%></option>
			<%rs.movenext
        wend%>
        </select></td></tr>
 	<tr bgcolor="#CCCCCC">
     	<td>Uitploeg</td>
        <td>
        <select name="uitploeg">
        <option value="1"></option>
        <option value="0">(nog niet bekend)</option>
        <%rs.movefirst
		while not rs.eof%>
			<option value="<%=rs("ploeg_id")%>"><%=rs("ploeg_id")%> - <%=rs("ploegnaam")%> - <%=rs("plnaam2")%></option>
			<%rs.movenext
        wend%>
        </select>
        </td>
	</tr>	
	<tr bgcolor="#FFFFFF">
		<td>Datum</td>
		<td><input type="text" name="datum" size="10"></td>
	</tr>
	<tr bgcolor="#CCCCCC">
		<td>Uur</td>
		<td>
			<input type="text" name="uur" size="5">
		</td>
	</tr>
	<tr bgcolor="#000099">
		<td colspan="2" align="center"><input type="submit" value="Opslaan"></td>
	</tr>
</table></td></tr></table>
</form>
</div></body>
</html>
<%con.close%>
