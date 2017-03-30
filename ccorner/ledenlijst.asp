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
<script type="text/javascript" src="jquery-1.4.2.js"></script> 
<script type="text/javascript" src="jquery.floatheader.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#ledentabel").floatHeader();  
});     
</script>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
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

ord=trim(request("ord"))
if ord="" or isnull(ord) then ord = 0
functie=trim(request("functie"))
if functie="" or isnull(functie) then functie = 0

dim order(12)
order(0) = ""
order(1) = "id, "
order(2) = "vblnr, "
order(3) = "geboortedatum, "
order(4) = "geslacht, "
order(5) = "aansluitingsdatum, "
order(6) = "status, "
order(7) = "ploegvorig, "
order(8) = "ploeg1, "
order(9) = "ploegvolg1, "
order(10) = "tblleden.niveau, "
order(11) = "functie1, "

sqlString = "SELECT functieid, functie FROM tblFuncties ORDER BY functieid"
rs.open sqlString%>

<table width="800px" border="0" cellpadding="0" cellspacing="0">
<tr bgcolor="#FFFFFF"><td width="50%">
<p class="NieuwsTitels"><font size="3">Ledenlijst</font></p>
<table border="0" cellspacing="0"><tr><td bgcolor="#FFFFFF">
<form name="jump">
	<p>Functie <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<option value="ledenlijst.asp?functie=0"<%
	if functie = 0 then
		%> selected="selected"<%
	end if
	%>>Alle leden</option>
	<%while not rs.eof%>
		<option value="ledenlijst.asp?functie=<%=rs("functieid")%>"<%
		if int(functie) = rs("functieid") then
			%> selected="selected"<%
		end if
		%>><%=rs("functie")%></option>
		<%rs.movenext
	wend
	rs.close%>

	</select></p>
</form>
	</td>
	<td bgcolor="#FFFFFF">
	<%if session("BL_soort") < 4 then
		sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true ORDER BY ploegid"
		rs.open sqlString
	elseif session("BL_soort") > 3 then
		sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
					"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
					"ORDER BY ploegid"
		rs.open sqlString
	end if
	if not rs.eof then%>
	<form name="jump1">
		<p>Ploeg <select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO"><option></option>
		<%while not rs.eof%>
			<option value="ploegen.asp?ploegid=<%=rs("ploegid")%>"><%=rs("ploegnaam")%></option>
			<%rs.movenext
		wend
		%>
		</select></p>
	</form>
	<%end if
	rs.close%>
	</td>
	</tr></table>


</td>
<td width="50%" align="right">
<a href="ledenlijstexcel.asp?functie=<%=functie%>&ord=<%=ord%>"><img src="../img/msexcel.gif" border="0" alt="Download deze lijst in excel" /></a>
</td>
</tr>
</table>
<%

sqlString = "SELECT id, vblnr, naam, voornaam, adres, tblleden.postnr, gemeente, geboortedatum, " &_
			"geslacht, aansluitingsdatum, status, telnr, gsm, email, oudersgsm, " &_
			"oudersemail, magsm, maemail, tblniveaus.niveau, tblfct1.functie AS fct1, tblfct2.functie AS fct2, " &_
			"tblpl0.ploegnaam AS pl0, tblpl1.ploegnaam AS pl1, tblpl2.ploegnaam AS pl2, " &_
			"tblpl3.ploegnaam AS pl3, tblpl4.ploegnaam AS pl4 " &_ 
			"FROM (tblleden, tblgemeenten, tblniveaus) " &_ 
			"LEFT JOIN tblfuncties AS tblfct1 ON functie1 = tblfct1.functieid " &_
			"LEFT JOIN tblfuncties AS tblfct2 ON functie2 = tblfct2.functieid " &_
			"LEFT JOIN tblploegen AS tblpl0 ON ploegvorig = tblpl0.ploegid " &_
			"LEFT JOIN tblploegen AS tblpl1 ON ploeg1 = tblpl1.ploegid " &_
			"LEFT JOIN tblploegen AS tblpl2 ON ploeg2 = tblpl2.ploegid " &_
			"LEFT JOIN tblploegen AS tblpl3 ON ploegvolg1 = tblpl3.ploegid " &_
			"LEFT JOIN tblploegen AS tblpl4 ON ploegvolg2 = tblpl4.ploegid " &_
			"WHERE tblleden.postnr = tblgemeenten.postnr AND tblleden.niveau = tblniveaus.niveauid "&_
			"AND status = 'A' "
	if functie > 0 then			
		sqlString = sqlString & "AND (functie1 = "&functie&" OR functie2 = "&functie&") "
	end if
		sqlString = sqlString & "ORDER BY " & order(ord) & "naam, voornaam"
rs.open sqlString
%>
<table id="ledentabel">
<thead>
	<tr>
		<th nowrap><a href="ledenlijst.asp?ord=1&functie=<%=functie%>">id</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=2&functie=<%=functie%>">vblnr</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=0&functie=<%=functie%>">naam</a></th>
		<th nowrap>voornaam</th>
		<%if session("BL_soort") < 4 then%>
			<th nowrap>adres</th>
		<%end if%>
		<th nowrap><a href="ledenlijst.asp?ord=3&functie=<%=functie%>">geboortedatum</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=4&functie=<%=functie%>">geslacht</a></th>
		<%if session("BL_soort") < 4 then%>
			<th nowrap><a href="ledenlijst.asp?ord=5&functie=<%=functie%>">aansluitingsdatum</a></th>
			<th nowrap><a href="ledenlijst.asp?ord=6&functie=<%=functie%>">status</a></th>
        <%end if%>
        <th nowrap>tel/gsm</th>
        <th nowrap>e-mail</th>
		<%if session("BL_soort") < 4 then%>
        	<th nowrap>ouders gsm</th>
        <%end if
		if session("BL_soort") < 5 then%>
			<th nowrap>ouders e-mail</th>
		<%end if
		if session("BL_soort") < 4 then%>
			<th nowrap><a href="ledenlijst.asp?ord=7&functie=<%=functie%>">vorige ploeg</a></th>
		<%end if%>
		<th nowrap><a href="ledenlijst.asp?ord=8&functie=<%=functie%>">ploeg(en)</a></th>
		<%if session("BL_soort") < 3 then%>
			<th nowrap><a href="ledenlijst.asp?ord=9&functie=<%=functie%>">volg.ploeg(en)</a></th>
		<%end if%>
		<th nowrap><a href="ledenlijst.asp?ord=10&functie=<%=functie%>">niveau</a></th>
		<th nowrap><a href="ledenlijst.asp?ord=11&functie=<%=functie%>">functie(s)</a></th>
		<%if session("BL_soort") < 4 then%>
			<th nowrap><a href="ledenlijst.asp?ord=0&functie=<%=functie%>">naam</a></th>
			<th nowrap>voornaam</th>
		<%end if%>
	</tr>
</thead>
<tbody>
<%while not rs.eof
	if session("BL_soort") < 4 then
		%><tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#FFFFFF'" onclick="document.location='lidwijzigen.asp?id=<%=rs("id")%>'" style="cursor:hand;cursor:pointer;" bgcolor="#FFFFFF">
	<%else%>
		<tr onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor='#FFFFFF'" bgcolor="#FFFFFF">
	<%end if%>
		<td nowrap valign="top"><%=rs("id")%><br>&nbsp;</td>
		<td nowrap valign="top"><%=rs("vblnr")%></td>
		<td nowrap valign="top" style="font-size:12px;"><b><%=rs("naam")%></b></td>
		<td nowrap valign="top" style="font-size:12px;"><b><%=rs("voornaam")%></b></td>
		<%if session("BL_soort") < 4 or functie > 1 then%>
			<td nowrap valign="top"><%=rs("adres")%><br>
			<%=rs("postnr")%>&nbsp;<%=rs("gemeente")%></td>
		<%end if%>
		<td nowrap valign="top"><%=rs("geboortedatum")%></td>
		<td nowrap valign="top"><%=rs("geslacht")%></td>
		<%if session("BL_soort") < 4 or functie > 1 then%>
			<td nowrap valign="top"><%=rs("aansluitingsdatum")%></td>
			<td nowrap valign="top"><%=rs("status")%></td>
		<%end if%>
		<td nowrap valign="top"><%=rs("telnr")%><br><%=rs("gsm")%></td>
		<td nowrap valign="top">
			<%if rs("email") <> "" then%>
				<a href="mailto:<%=rs("email")%>" class="email"><%=rs("email")%></a>
			<%end if%>
		</td>
		<%
		if session("BL_soort") < 4 then%>
			<td nowrap valign="top">
			<%if rs("oudersgsm") <> "" then%>
				Vader: <%=rs("oudersgsm")%>
			<%end if%><br />
			<%if rs("magsm") <> "" then%>
				Moeder: <%=rs("magsm")%>
			<%end if%>
            </td>
		<%end if
		if session("BL_soort") < 5 then%>
			<td nowrap valign="top">
			<%if rs("oudersemail") <> "" then%>
				Vader: <a href="mailto:<%=rs("oudersemail")%>" class="email"><%=rs("oudersemail")%></a>
			<%end if%><br />
			<%if rs("maemail") <> "" then%>
				Moeder: <a href="mailto:<%=rs("maemail")%>" class="email"><%=rs("maemail")%></a>
			<%end if%>
			</td>
		<%end if
		if session("BL_soort") < 4 then%>
			<td nowrap valign="top"><%=rs("pl0")%></td>
		<%end if%>	
		<td nowrap valign="top"><%=rs("pl1")%><br><%=rs("pl2")%></td>
		<%if session("BL_soort") < 3 then%>
			<td nowrap valign="top"><%=rs("pl3")%><br><%=rs("pl4")%></td>
		<%end if%>
		<td nowrap valign="top"><%=rs("niveau")%></td>
		<td nowrap valign="top"><%=rs("fct1")%><br><%=rs("fct2")%></td>
		<%if session("BL_soort") < 4 or functie > 1 then%>
			<td nowrap valign="top" style="font-size:12px;"><b><%=rs("naam")%></b></td>
			<td nowrap valign="top" style="font-size:12px;"><b><%=rs("voornaam")%></b></td>
		<%end if%>
	</tr>
	<%rs.movenext
wend
rs.close%>
</tbody>
</table>
</div></body>
</html>
