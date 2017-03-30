<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4"
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
<title>Basket Lummen - Ledenlijst</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css" media="screen">
<link href="print.css" rel="stylesheet" type"text/css" media="print">
<style type="text/css">
<!--
td {
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
-->
</style>
</head>

<body>
<%print = trim(request("print"))
if print="" or isnull(print) then%>

<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
end if
ord=trim(request("ord"))
if ord="" or isnull(ord) then ord = 0

dim order(11)
order(0) = ""
order(1) = "id, "
order(2) = "vblnr, "
order(3) = "geboortedatum, "
order(4) = "geslacht, "
order(5) = "aansluitingsdatum, "
order(6) = "status, "
order(7) = "ploegvorig, "
order(8) = "ploeg1, "
order(9) = "tblleden.niveau, "
order(10) = "functie1, "

%>
<p class="NieuwsTitels"><font size="3">Bestuur</font></p>
<%

sqlString = "SELECT id, vblnr, naam, voornaam, adres, tblleden.postnr, gemeente, geboortedatum, " &_
			"geslacht, aansluitingsdatum, status, telnr, gsm, email, oudersgsm, " &_
			"oudersemail, tblniveaus.niveau, tblfct1.functie AS fct1, tblfct2.functie AS fct2, " &_
			"tblpl0.ploegnaam AS pl0, tblpl1.ploegnaam AS pl1, tblpl2.ploegnaam AS pl2 " &_ 
			"FROM (tblleden, tblgemeenten, tblniveaus) " &_ 
			"LEFT JOIN tblfuncties AS tblfct1 ON functie1 = tblfct1.functieid " &_
			"LEFT JOIN tblfuncties AS tblfct2 ON functie2 = tblfct2.functieid " &_
			"LEFT JOIN tblploegen AS tblpl0 ON ploegvorig = tblpl0.ploegid " &_
			"LEFT JOIN tblploegen AS tblpl1 ON ploeg1 = tblpl1.ploegid " &_
			"LEFT JOIN tblploegen AS tblpl2 ON ploeg2 = tblpl2.ploegid " &_
			"WHERE tblleden.postnr = tblgemeenten.postnr AND tblleden.niveau = tblniveaus.niveauid "&_
			"AND status = 'A' AND (functie1 = 3 OR functie2 = 3) " &_
			"ORDER BY " & order(ord) & "naam, voornaam"
rs.open sqlString
%>
<table>
	<tr>
		<th nowrap><a href="ledenlijst.asp?ord=1">id</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=2">vblnr</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=0">naam</a></th>
		<th nowrap>voornaam</th>
		<th nowrap>adres</th>
		<th nowrap><a href="ledenlijst.asp?ord=3">geboortedatum</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=4">geslacht</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=5">aansluitingsdatum</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=6">status</a></th>
		<th nowrap>tel/gsm</th>
		<th nowrap>e-mail</th>
		<th nowrap>ouders gsm</th>
		<th nowrap>ouders e-mail</th>
		<th nowrap><a href="ledenlijst.asp?ord=7">vorige ploeg</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=8">ploeg(en)</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=9">niveau</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=10">functie(s)</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=0">naam</a></th>
		<th nowrap>voornaam</th>
	</tr>
<%while not rs.eof
		%><tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#FFFFFF'" onclick="document.location='lidwijzigen.asp?id=<%=rs("id")%>'" style="cursor:hand;cursor:pointer;" bgcolor="#FFFFFF">
		<td nowrap valign="top"><%=rs("id")%><br>&nbsp;</td>
		<td nowrap valign="top"><%=rs("vblnr")%></td>
		<td nowrap valign="top" style="font-size:12px;"><b><%=rs("naam")%></b></td>
		<td nowrap valign="top" style="font-size:12px;"><b><%=rs("voornaam")%></b></td>
		<td nowrap valign="top"><%=rs("adres")%><br>
		<%=rs("postnr")%>&nbsp;<%=rs("gemeente")%></td>
		<td nowrap valign="top"><%=rs("geboortedatum")%></td>
		<td nowrap valign="top"><%=rs("geslacht")%></td>
		<td nowrap valign="top"><%=rs("aansluitingsdatum")%></td>
		<td nowrap valign="top"><%=rs("status")%></td>
		<td nowrap valign="top"><%=rs("telnr")%><br><%=rs("gsm")%></td>
		<td nowrap valign="top">
		<%if rs("email") <> "" then%>
			<a href="mailto:<%=rs("email")%>" class="email"><%=rs("email")%></a>
		<%end if%>
		</td>
		<td nowrap valign="top"><%=rs("oudersgsm")%></td>
		<td nowrap valign="top">
		<%if rs("oudersemail") <> "" then%>
			<a href="mailto:<%=rs("oudersemail")%>" class="email"><%=rs("oudersemail")%></a>
		<%end if%>
		</td>
		<td nowrap valign="top"><%=rs("pl0")%></td>
		<td nowrap valign="top"><%=rs("pl1")%><br><%=rs("pl2")%></td>
		<td nowrap valign="top"><%=rs("niveau")%></td>
		<td nowrap valign="top"><%=rs("fct1")%><br><%=rs("fct2")%></td>
		<td nowrap valign="top" style="font-size:12px;"><b><%=rs("naam")%></b></td>
		<td nowrap valign="top" style="font-size:12px;"><b><%=rs("voornaam")%></b></td>
	</tr>
	<%rs.movenext
wend
rs.close%>

</table>
<%if print="" or isnull(print) then%>
</div>
<%end if%>
</body>
</html>
