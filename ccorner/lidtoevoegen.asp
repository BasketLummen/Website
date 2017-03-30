<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
MM_authFailedURL="login.asp"
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - lid toevoegen</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td, select, input {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
select{
	background-color: #FFFFFF;
}

.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
<script type="text/javascript" src="jquery-1.4.2.js"></script> 
<script type="text/javascript" src="jquery.AddIncSearch.js"></script> 
<script type="text/javascript">
$(document).ready(function() {
	$("select").AddIncSearch();
	$("#ploeg1").change(function() { 
		wijz_ploeg($(this).val());
	})
	$("#functie1").change(function() { 
		wijz_functie();
	})
	$("#functie2").change(function() { 
		wijz_functie();
	})
});
function wijz_ploeg(keuze)
{
	if(keuze==38)
	{
		$("#ploeg2").val(0);
		$("#ploeg2").attr("disabled", "disabled");
		$("#niveau").val(6);
		$("#niveau").attr("disabled", "disabled");
	}
	else
	{
		$("#ploeg2").removeAttr("disabled");
		$("#niveau").removeAttr("disabled");
		if(keuze<10)
			$("#niveau").val(1);
		else if(keuze<12)
			$("#niveau").val(2);
		else if(keuze<22)
			$("#niveau").val(3);
		else if(keuze<28)
			$("#niveau").val(4);
		else
			$("#niveau").val(5);
	}
}
function wijz_functie(keuze)
{
	if($("#functie1").val()!=1 && $("#functie2").val() !=1)
	{
		$("#ploeg1").val(38);
		$("#ploeg1").attr("disabled", "disabled");
		$("#ploeg2").val(0);
		$("#ploeg2").attr("disabled", "disabled");
		$("#niveau").val(6);
		$("#niveau").attr("disabled", "disabled");
	}
	else
	{
		$("#ploeg1").removeAttr("disabled");
		$("#ploeg2").removeAttr("disabled");
		$("#niveau").removeAttr("disabled");
		wijz_ploeg($("#ploeg1").val())
	}
}
</script>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
naam = trim(request("naam"))
if naam <> "" and not isnull("naam") then
	sqlstring = "SELECT * FROM tblleden"
	rs.open sqlString, con, 2, 2
	
	rs.addnew
	vblnr = trim(request("vblnr"))
	if isnull(vblnr) or vblnr = "" then 
		rs("vblnr") = NULL
	else
		rs("vblnr") = vblnr
	end if
	rs("naam") = naam
	rs("voornaam") = trim(request("voornaam"))
	rs("adres") = trim(request("adres"))
	postnr = trim(request("postnr"))
	if isnull(postnr) or postnr = "" then 
		rs("postnr") = NULL
	else
		rs("postnr") = postnr
	end if
	geboortedatum = trim(request("geboortedatum"))
	if isnull(geboortedatum) or geboortedatum = "" then 
		rs("geboortedatum") = NULL
	else
		rs("geboortedatum") = year(geboortedatum) & "-" & month(geboortedatum) & "-" & day(geboortedatum) 
	end if
	rs("geslacht") = trim(request("geslacht"))
	aansluitingsdatum = trim(request("aansluitingsdatum"))
	if isnull(aansluitingsdatum) or aansluitingsdatum = "" then 
		rs("aansluitingsdatum") = NULL
	else
		rs("aansluitingsdatum") = year(aansluitingsdatum) & "-" & month(aansluitingsdatum) & "-" & day(aansluitingsdatum) 
	end if
	rs("status") = trim(request("status"))
	rs("telnr") = trim(request("telnr"))
	rs("gsm") = trim(request("gsm"))
	rs("email") = trim(request("email"))
	rs("rijksregister") = trim(request("rijksregister"))
	rs("oudersgsm") = trim(request("oudersgsm"))
	rs("oudersemail") = trim(request("oudersemail"))
	rs("magsm") = trim(request("magsm"))
	rs("maemail") = trim(request("maemail"))
	ploegvorig = trim(request("ploegvorig"))
	if isnull(ploegvorig) or ploegvorig = "" then 
		rs("ploegvorig") = NULL
	else
		rs("ploegvorig") = ploegvorig
	end if
	ploeg1 = trim(request("ploeg1"))
	if isnull(ploeg1) or ploeg1 = "" then 
		rs("ploeg1") = 38
	else
		rs("ploeg1") = ploeg1
	end if
	ploeg2 = trim(request("ploeg2"))
	if isnull(ploeg2) or ploeg2 = "" then 
		rs("ploeg2") = NULL
	else
		rs("ploeg2") = ploeg2
	end if
	ploegvolg1 = trim(request("ploegvolg1"))
	if isnull(ploegvolg1) or ploegvolg1 = "" then 
		rs("ploegvolg1") = NULL
	else
		rs("ploegvolg1") = ploegvolg1
	end if
	ploegvolg2 = trim(request("ploegvolg2"))
	if isnull(ploegvolg2) or ploegvolg2 = "" then 
		rs("ploegvolg2") = NULL
	else
		rs("ploegvolg2") = ploegvolg2
	end if
	niveau = trim(request("niveau"))
	if isnull(niveau) or niveau = "" then 
		rs("niveau") = 6
	else
		rs("niveau") = niveau
	end if
	rs("functie1") = trim(request("functie1"))
	functie2 = trim(request("functie2"))
	if functie2 = 0 then 
		rs("functie2") = NULL
	else
		rs("functie2") = functie2
	end if
	rs("laatste") = session("BL_lidid")
	rs.update
	rs.close%>
	
	<p>Lid toegevoegd.</p>
<%end if%>
<p class="NieuwsTitels"><font size="3">Lid toevoegen</font></p>
<p>
<form method="post" action="lidtoevoegen.asp" id="form1">
<table>
<tr>
<td>Status</td>
<td colspan="2"><label for="A"><input type="radio" name="status" value="A" id="A" checked>Actief</label>
<label for="P"><input type="radio" name="status" value="P" id="P">Passief</label></td>
</tr>
<tr>
<td>VBL-nummer</td>
<td colspan="2"><input type="text" name="vblnr" size="20"></td>
</tr>
<tr>
<td>Naam</td>
<td colspan="2"><input type="text" name="naam" size="50">
  </td>
</tr>
<tr>
<td>Voornaam</td>
<td colspan="2"><input type="text" name="voornaam" size="50">
  </td>
</tr>
<tr>
<td>Adres</td>
<td colspan="2"><input type="text" name="adres" size="50"></td>
</tr>
<tr>
<td>Gemeente</td>
<td colspan="2">
<select name="postnr">
	<%sqlString = "SELECT postnr, gemeente FROM tblgemeenten ORDER BY postnr"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("postnr")%>"<%
			if rs("postnr") = 3560 then
				%> selected<%
			end if
		%>><%=rs("postnr")%>&nbsp;<%=rs("gemeente")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</td>
</tr>
<tr>
<td>Geslacht</td>
<td colspan="2"><label for="M"><input type="radio" name="geslacht" value="M" id="M" checked>Man</label>
<label for="V"><input type="radio" name="geslacht" value="V" id="V">Vrouw</label></td>
</tr>
<tr>
<td>Geboortedatum</td>
<td><input type="text" name="geboortedatum" size="15"></td>
<td>Aansluitingsdatum <input type="text" name="aansluitingsdatum" size="15"></td>
</tr>
<tr>
<td>Telnr</td>
<td><input type="text" name="telnr" size="15"></td>
<td>Gsm <input type="text" name="gsm" size="15"></td>
</tr>
<tr>
<td>E-mail</td>
<td colspan="2"><input type="text" name="email" size="50"></td>
</tr>
<tr>
<td>Rijksregister</td>
<td colspan="2"><input type="text" name="rijksregister" size="50"></td>
</tr>
<tr>
<td>Vader gsm</td>
<td colspan="2"><input type="text" name="oudersgsm" size="15"></td>
</tr>
<tr>
<td>Vader e-mail</td>
<td colspan="2"><input type="text" name="oudersemail" size="50"></td>
</tr>
<tr>
<td>Moeder gsm</td>
<td colspan="2"><input type="text" name="magsm" size="15"></td>
</tr>
<tr>
<td>Moeder e-mail</td>
<td colspan="2"><input type="text" name="maemail" size="50"></td>
</tr>
<tr>
<td>Functie 1</td>
<td>
<select name="functie1" id="functie1">
	<%sqlString = "SELECT functieid, functie FROM tblfuncties"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("functieid")%>"><%=rs("functie")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>

</td>
<td>Functie 2 <select name="functie2" id="functie2">
	<option value="0"></option>
	<%sqlString = "SELECT functieid, functie FROM tblfuncties"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("functieid")%>"><%=rs("functie")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</td>
</tr>
<tr>
<td>Ploeg vorig seizoen</td>
<td colspan="2">
<select name="ploegvorig">
	<option value=""></option>
	<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("ploegid")%>"><%=rs("ploegnaam")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</td>
</tr>
<tr>
<td>Ploeg 1</td>
<td>
<select name="ploeg1" id="ploeg1">
	<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("ploegid")%>"><%=rs("ploegnaam")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>

</td>
<td colspan="2">Ploeg 2 
<select name="ploeg2" id="ploeg2">
	<option value=""></option>
	<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("ploegid")%>"><%=rs("ploegnaam")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</td>
</tr>
<tr>
<td>Ploeg(en) volg.seiz.</td>
	<td colspan="3">
	<select name="ploegvolg1" id="ploegvolg1">
	<option value=""></option>
	<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("ploegid")%>"><%=rs("ploegnaam")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
<select name="ploegvolg2" id="ploegvolg2">
	<option value=""></option>
	<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("ploegid")%>"><%=rs("ploegnaam")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>
</td>
</tr><tr>
<td>Niveau</td>
<td colspan="2">
<select name="niveau" id="niveau">
	<%sqlString = "SELECT niveauid, niveau FROM tblniveaus"
	rs.open sqlString
	while not rs.eof%>
		<option value="<%=rs("niveauid")%>"><%=rs("niveau")%></option>
		<%rs.movenext
	wend
	rs.close%>
</select>

</td>
</tr>

</table>
<p><input type="submit" value="toevoegen"></p>
</form></div>
</body>
</html>
