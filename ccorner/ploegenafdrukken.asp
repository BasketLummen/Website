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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Ledenlijst</title>
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
<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con



ord=trim(request("ord"))
if ord="" or isnull(ord) then ord = 0
ploegid=trim(request("ploegid"))
if ploegid="" or isnull(ploegid) then ploegid = 0

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
if session("BL_soort") < 4 then
	sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true ORDER BY ploegid"
	rs.open sqlString
elseif session("BL_soort") > 3 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"ORDER BY ploegid"
	rs.open sqlString
end if
if rs.eof then%>
	<p>Enkel beschikbaar voor coaches.</p>
<%else
sqlString = "SELECT ploegnaam FROM tblploegen WHERE ploegid = " & ploegid
toon = true
if session("BL_soort") > 3 then 
	sqlString = "SELECT ploegid FROM tblploegedit WHERE ploegid = " & ploegid & " AND lidid = " & session("BL_lidid")
	rs1.open sqlString
	if rs1.eof then
		toon = false
	end if
	rs1.close
end if
if toon = true then
	rs.close
	sqlString = "SELECT ploegnaam FROM tblPloegen WHERE ploegid = " & ploegid
	rs.open sqlString%>
	<p class="NieuwsTitels"><font size="3"><%=rs("ploegnaam")%></font></p>
	<%rs.close
	
	sqlString = "SELECT id, vblnr, naam, voornaam, adres, tblleden.postnr, gemeente, " &_
				"geboortedatum, geslacht, aansluitingsdatum, status, telnr, gsm, email, " &_
				"oudersgsm, oudersemail, magsm, maemail, status, tblniveaus.niveau, tblfct1.functie AS fct1, " &_
				"tblfct2.functie AS fct2, tblpl0.ploegnaam AS pl0, tblpl1.ploegnaam AS pl1, " &_
				"tblpl2.ploegnaam AS pl2 " &_ 
				"FROM (tblleden, tblgemeenten, tblniveaus) " &_ 
				"LEFT JOIN tblfuncties AS tblfct1 ON functie1 = tblfct1.functieid " &_
				"LEFT JOIN tblfuncties AS tblfct2 ON functie2 = tblfct2.functieid " &_
				"LEFT JOIN tblploegen AS tblpl0 ON ploegvorig = tblpl0.ploegid " &_
				"LEFT JOIN tblploegen AS tblpl1 ON ploeg1 = tblpl1.ploegid " &_
				"LEFT JOIN tblploegen AS tblpl2 ON ploeg2 = tblpl2.ploegid " &_
				"WHERE status = 'A' AND tblleden.postnr = tblgemeenten.postnr AND tblleden.niveau = "&_
				"tblniveaus.niveauid AND (ploeg1 = " & ploegid & " OR ploeg2 = " & ploegid & ") " &_
				"ORDER BY " & order(ord) & "naam, voornaam"
	rs.open sqlString
	%>
	<table>
		<tr>
			<th nowrap>naam</th>
			<th nowrap>adres</th>
			<th nowrap>geboortedatum</th>
			<th nowrap>tel/gsm/e-mail</th>
			<th nowrap>vader gsm/e-mail</th>
			<th nowrap>moeder gsm/e-mail</th>
		</tr>
	<%while not rs.eof
			%><tr bgcolor="#FFFFFF">
			<td nowrap valign="top"><%=rs("naam")%>&nbsp;<%=rs("voornaam")%></td>
			<td nowrap valign="top"><%=rs("adres")%><br>
				<%=rs("postnr")%>&nbsp;<%=rs("gemeente")%></td>
			<td nowrap valign="top"><%=rs("geboortedatum")%></td>
			<td nowrap valign="top"><%=rs("telnr")%><br><%=rs("gsm")%><br><%=rs("email")%></td>
			<td nowrap valign="top"><%=rs("oudersgsm")%><br><%=rs("oudersemail")%></td>
			<td nowrap valign="top"><%=rs("magsm")%><br><%=rs("maemail")%></td>
		</tr>
		<%rs.movenext
	wend
	rs.close
end if
end if%>

</table>
<p align="center">
<script language="JavaScript"><!-- Begin
if (window.print) {
document.write('<form>'
+ '<input type=button name=print value="Afdrukken" '
+ 'onClick="javascript:window.print()"></form>');
}
// End -->
</script>

</p>

</body>
</html>
