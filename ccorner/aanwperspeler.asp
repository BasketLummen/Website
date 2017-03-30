<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
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
<!--#include file="connect.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<title>Basket Lummen - Aanwezigheden</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td,p  {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
select {
	background-color: #FFFFFF;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
Set rs1 = Server.CreateObject("ADODB.Recordset")
rs1.activeconnection = con





lidid = trim(request("id"))



sqlString = "SELECT naam, voornaam, maand, tblAanwezigheden.ploegid, ploegnaam, trainingen, aanwezig, verontschuldigd, afwezig, gekwetst, opmerkingen " &_
			"FROM (tblAanwezigheden INNER JOIN tblleden ON tblAanwezigheden.lidid = tblleden.id) " &_
			"INNER JOIN tblPloegen ON tblAanwezigheden.ploegid = tblPloegen.ploegid " &_
			"WHERE tblleden.id = " & lidid
rs.open sqlString
toon = true
if session("BL_soort") > 2 then 
	sqlString = "SELECT ploegid FROM tblploegedit WHERE lidid = " & session("BL_lidid") &_
				" AND ploegid = " & rs("ploegid")
	rs1.open sqlString
	if rs1.eof then
		toon = false
	end if
	rs1.close
end if
if toon = true then
%>
	<p>
	<table width="600" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr align="center">
  	<td bgcolor="#000099" width="125" ><a href="lidwijzigen.asp?id=<%=lidid%>" class="menuLinks2">Contactgegegens</a></td>
  	<td bgcolor="#000099" width="125"><a href="dossier.asp?soort=1&id=<%=lidid%>" class="menuLinks2">Sportief dossier</a></td>
  	<td bgcolor="#000099" width="125"><a href="dossier.asp?soort=2&id=<%=lidid%>" class="menuLinks2">Medisch dossier</a></td>
  	<td bgcolor="#000099" width="125"><a href="aanwperspeler.asp?id=<%=lidid%>" class="menuLinks2">Aanwezigheden</a></td>
  </tr>
  </table></p>
<%if rs.eof then%>
<p>Er zijn  nog geen gegevens voor dit lid ingevoerd.</p>
<%else%>
<p class="NieuwsTitels"><font size="3">Aanwezigheden <%=rs("voornaam")%>&nbsp;<%=rs("naam")%></font></p>
<p><font size="1">TR = aantal trainingen | AW = aanwezig | VO = verontschuldigd | ZV = afwezig zonder verwittiging | GK = gekwetst</font></p>
<table>
<tr>
<th>maand</th>
<th>ploeg</th>
<th>TR</th>
<th>AW</th>
<th>VO</th>
<th>ZV</th>
<th>GK</th>
<th>Opmerkingen</th>
</tr>
<%while not rs.eof%>
	<tr bgcolor="#FFFFFF">
	<td>
	<%if mnd <> rs("maand") then%>
		<%=monthname(month(rs("maand")))%>
		<%mnd = rs("maand")
	else%>
		&nbsp;
	<%end if%>
	</td>
	<td><%=rs("ploegnaam")%></td>
	<td align="center" width="30"><%=rs("trainingen")%></td>
	<td align="center" width="30"><%=rs("aanwezig")%></td>
	<td align="center" width="30"><%=rs("verontschuldigd")%></td>
	<td align="center" width="30"><%=rs("afwezig")%></td>
	<td align="center" width="30"><%=rs("gekwetst")%></td>
	<td><%=rs("opmerkingen")%></td>
	</tr>
	<%rs.movenext
wend%>
</table>
<%end if
end if%>
</div>
</body>
</html>
