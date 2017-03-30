<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - lid wijzigen</title>
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
		//$("#ploeg2").val(0);
		//$("#ploeg2").attr("disabled", "disabled");
		//$("#niveau").val(6);
		//$("#niveau").attr("disabled", "disabled");
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
		//$("#ploeg1").val(38);
		//$("#ploeg1").attr("disabled", "disabled");
		//$("#ploeg2").val(0);
		//$("#ploeg2").attr("disabled", "disabled");
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
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, select, input {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
select {
	background-color: #FFFFFF;
	}
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
id = trim(request("id"))
naam = trim(request("naam"))
if naam <> "" and not isnull("naam") then
	naam = replace(naam,"'","´")
	sqlstring = "UPDATE tblleden SET "
	vblnr = trim(request("vblnr"))
	if isnull(vblnr) or vblnr = "" then 
		sqlstring = sqlString & "vblnr = NULL, "
	else
		sqlstring = sqlString & "vblnr = " & vblnr & ", "
	end if
	sqlstring = sqlString & "naam = '" & naam & "', " &_
							"voornaam = '" & replace(trim(request("voornaam")),"'","´") & "', " &_
							"adres = '" & replace(trim(request("adres")),"'","´") & "', "
	postnr = trim(request("postnr"))
	if isnull(postnr) or postnr = "" then 
		sqlstring = sqlString & "postnr = NULL, "
	else
		sqlstring = sqlString & "postnr = " & postnr & ", "
	end if
	geboortedatum = trim(request("geboortedatum"))
	if isnull(geboortedatum) or geboortedatum = "" then 
		sqlstring = sqlString & "geboortedatum = NULL, "
	else
		sqlstring = sqlString & "geboortedatum = '" & year(geboortedatum) & "-" & month(geboortedatum) & "-" & day(geboortedatum) & "', "
	end if
	sqlstring = sqlString & "geslacht = '" & trim(request("geslacht")) & "', "
	aansluitingsdatum = trim(request("aansluitingsdatum"))
	if isnull(aansluitingsdatum) or aansluitingsdatum = "" then 
		sqlstring = sqlString & "aansluitingsdatum = NULL, "
	else
		sqlstring = sqlString & "aansluitingsdatum = '" & year(aansluitingsdatum) & "-" & month(aansluitingsdatum) & "-" & day(aansluitingsdatum) & "', "
	end if
	sqlstring = sqlString & "status = '" & trim(request("status")) & "', " &_
							"telnr = '" & trim(request("telnr")) & "', " &_
							"gsm = '" & trim(request("gsm")) & "', " &_
							"email = '" & trim(request("email")) & "', " &_
							"rijksregister = '" & trim(request("rijksregister")) & "', " &_
							"oudersgsm = '" & trim(request("oudersgsm")) & "', " &_
							"oudersemail = '" & trim(request("oudersemail")) & "', " &_
							"magsm = '" & trim(request("magsm")) & "', " &_
							"maemail = '" & trim(request("maemail")) & "', "
	ploegvorig = trim(request("ploegvorig"))
	if isnull(ploegvorig) or ploegvorig = "" then 
		sqlstring = sqlString & "ploegvorig = NULL, "
	else
		sqlstring = sqlString & "ploegvorig = " & ploegvorig & ", "
	end if
	ploeg1 = trim(request("ploeg1"))
	if isnull(ploeg1) or ploeg1 = "" then 
		sqlstring = sqlString & "ploeg1 = 38, "
	else
		sqlstring = sqlString & "ploeg1 = " & ploeg1 & ", "
	end if
	ploeg2 = trim(request("ploeg2"))
	if isnull(ploeg2) or ploeg2 = "" then 
		sqlstring = sqlString & "ploeg2 = NULL, "
	else
		sqlstring = sqlString & "ploeg2 = " & ploeg2 & ", "
	end if
	ploegvolg1 = trim(request("ploegvolg1"))
	if isnull(ploegvolg1) or ploegvolg1 = "" then 
		sqlstring = sqlString & "ploegvolg1 = NULL, "
	else
		sqlstring = sqlString & "ploegvolg1 = " & ploegvolg1 & ", "
	end if
	ploegvolg2 = trim(request("ploegvolg2"))
	if isnull(ploegvolg2) or ploegvolg2 = "" then 
		sqlstring = sqlString & "ploegvolg2 = NULL, "
	else
		sqlstring = sqlString & "ploegvolg2 = " & ploegvolg2 & ", "
	end if
	niveau = trim(request("niveau"))
	if isnull(niveau) or niveau = "" then 
		sqlstring = sqlString & "niveau = 6, "
	else
		sqlstring = sqlString & "niveau = " & niveau & ", "
	end if
	sqlString = sqlString & "functie1 = " & trim(request("functie1")) & ", "
	functie2 = trim(request("functie2"))
	if functie2 = 0 then 
		sqlstring = sqlString & "functie2 = NULL, "
	else
		sqlstring = sqlString & "functie2 = " & functie2 & ", "
	end if
	if trim(request("status")) = "P" then
		ontslag = trim(request("ontslag"))
		if ontslag = "" or isnull(ontslag) then
			ontslag = year(date())
		end if
		sqlstring  = sqlString & "ontslag = " & ontslag & ", "
	else
		sqlstring  = sqlString & "ontslag = null, "
	end if	
	sqlString = sqlString & " laatste = " & session("BL_lidid") & " WHERE id = " & id 
	con.execute sqlString
	
	
	sqlString = "SELECT tblpl1.ploegid AS plid1, tblpl1.ploegnaam AS pl1, tblpl2.ploegid AS plid2, tblpl2.ploegnaam AS pl2 " &_ 
				"FROM tblleden " &_ 
				"LEFT JOIN tblploegen AS tblpl1 ON ploeg1 = tblpl1.ploegid " &_
				"LEFT JOIN tblploegen AS tblpl2 ON ploeg2 = tblpl2.ploegid " &_
				"WHERE id = " & id
	rs.open sqlstring%>
	<p>Lid gewijzigd.</p>
	<a href="ledenlijst.asp">Terug naar de ledenlijst</a><br />
	<%if rs("pl1") <> "" and not isnull(rs("pl1")) then%>
		<a href="ploegen.asp?ploegid=<%=rs("plid1")%>">Terug naar de lijst <%=rs("pl1")%></a><br />
	<%end if%>
	<%if rs("pl2") <> "" and not isnull(rs("pl2")) then%>
		<a href="ploegen.asp?ploegid=<%=rs("plid2")%>">Terug naar de lijst <%=rs("pl2")%></a><br />
	<%end if
	rs.close%>
<%else

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con


sqlString = "SELECT * FROM tblLeden WHERE id = " & id
rs.open sqlSTring



toon = true
if session("BL_soort") > 2 then 
	sqlString = "SELECT ploegid FROM tblploegedit WHERE lidid = " & session("BL_lidid") &_
				" AND (ploegid = " & rs("ploeg1")
	if not isnull(rs("ploeg2")) AND rs("ploeg2") <> "" then
		sqlString = sqlString & " OR ploegid = " & rs("ploeg2")
	end if
	sqlString = sqlString & ")"
	rs1.open sqlString
	if rs1.eof then
		toon = false
	end if
	rs1.close
end if
if toon = true or session("BL_soort") = 3 then
	if toon = true then%>
	<p>
	<table width="600" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr align="center">
  	<td bgcolor="#000099" width="125" ><a href="lidwijzigen.asp?id=<%=id%>" class="menuLinks2">Contactgegegens</a></td>
  	<td bgcolor="#000099" width="125"><a href="dossier.asp?soort=1&id=<%=id%>" class="menuLinks2">Sportief dossier</a></td>
  	<td bgcolor="#000099" width="125"><a href="dossier.asp?soort=2&id=<%=id%>" class="menuLinks2">Medisch dossier</a></td>
  	<td bgcolor="#000099" width="125"><a href="aanwperspeler.asp?id=<%=id%>" class="menuLinks2">Aanwezigheden</a></td>
  </tr>
  </table>
  <%end if%>
	</p>
	<p class="NieuwsTitels"><font size="3">Contactgegevens <%=rs("voornaam")%>&nbsp;<%=rs("naam")%></font></p>

	<p>
	<table><tr><td>
	<form method="post" action="lidwijzigen.asp?id=<%=id%>" id="form1">
	<table>
	<tr>
	<td>Status</td>
	<td colspan="2"><label for="A"><input type="radio" name="status" value="A" id="A"<%
		if rs("status") = "A" then%>
			checked<%
		end if%>>Actief</label>
	<label for="P"><input type="radio" name="status" value="P" id="P"<%
		if rs("status") = "P" then%>
			checked<%
		end if%>>Passief</label>
        <%if rs("status") = "P" then%>
        	&nbsp;&nbsp;Ontslag <input type="text" name="ontslag" id="ontslag" value="<%=rs("ontslag")%>" />
        <%end if%>        
        </td>
	
	</tr>
	<tr>
	<td>VBL-nummer</td>
	<td colspan="2"><input type="text" name="vblnr" size="20" value="<%=rs("vblnr")%>"></td>
	</tr>
	<tr>
	<td>Naam</td>
	<td colspan="2"><input type="text" name="naam" size="50" value="<%=rs("naam")%>">
	  </td>
	</tr>
	<tr>
	<td>Voornaam</td>
	<td colspan="2"><input type="text" name="voornaam" size="50" value="<%=rs("voornaam")%>">
	  </td>
	</tr>
	<tr>
	<td>Adres</td>
	<td colspan="2"><input type="text" name="adres" size="50" value="<%=rs("adres")%>"></td>
	</tr>
	<tr>
	<td>Gemeente</td>
	<td colspan="2">
	<select name="postnr">
		<%sqlString = "SELECT postnr, gemeente FROM tblgemeenten ORDER BY postnr"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("postnr")%>"<%
				if rs1("postnr") = rs("postnr") then
					%> selected<%
				end if
			%>><%=rs1("postnr")%>&nbsp;<%=rs1("gemeente")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	</td>
	</tr>
	<tr>
	<td>Geslacht</td>
	<td colspan="2"><label for="M"><input type="radio" name="geslacht" value="M" id="M"<%
		if rs("geslacht") = "M" then%>
			checked<%
		end if%>>Man</label>
	<label for="V"><input type="radio" name="geslacht" value="V" id="V"<%
		if rs("geslacht") = "V" then%>
			checked<%
		end if%>>Vrouw</label></td>
	</tr>
	<tr>
	<td>Geboortedatum</td>
	<td><input type="text" name="geboortedatum" size="15" value="<%=rs("geboortedatum")%>"></td>
	<td>Aansluitingsdatum <input type="text" name="aansluitingsdatum" size="15" value="<%=rs("aansluitingsdatum")%>"></td>
	</tr>
	<tr>
	<td>Telnr</td>
	<td><input type="text" name="telnr" size="15" value="<%=rs("telnr")%>"></td>
	<td>Gsm <input type="text" name="gsm" size="15" value="<%=rs("gsm")%>"></td>
	</tr>
	<tr>
	<td>E-mail</td>
	<td colspan="2"><input type="text" name="email" size="50" value="<%=rs("email")%>"></td>
	</tr>
	<tr>
	<td>Rijksregister</td>
	<td colspan="2"><input type="text" name="rijksregister" size="50" value="<%=rs("rijksregister")%>"></td>
	</tr>
	<tr>
	<td>Vader gsm</td>
	<td colspan="2"><input type="text" name="oudersgsm" size="30" value="<%=rs("oudersgsm")%>"></td>
	</tr>
	<tr>
	<td>Vader e-mail</td>
	<td colspan="2"><input type="text" name="oudersemail" size="60" value="<%=rs("oudersemail")%>"></td>
	</tr>
	<tr>
	<td>Moeder gsm</td>
	<td colspan="2"><input type="text" name="magsm" size="30" value="<%=rs("magsm")%>"></td>
	</tr>
	<tr>
	<td>Moeder e-mail</td>
	<td colspan="2"><input type="text" name="maemail" size="60" value="<%=rs("maemail")%>"></td>
	</tr>
	<tr>
	<td>Functie 1</td>
	<td>
	<select name="functie1" id="functie1">
		<%sqlString = "SELECT functieid, functie FROM tblfuncties"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("functieid")%>"<%
				if rs1("functieid") = rs("functie1") then
					%> selected<%
				end if
			%>><%=rs1("functie")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	
	</td>
	<td>Functie 2 <select name="functie2" id="functie2">
		<option value="0"></option>
		<%sqlString = "SELECT functieid, functie FROM tblfuncties"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("functieid")%>"<%
				if rs1("functieid") = rs("functie2") then
					%> selected<%
				end if
			%>><%=rs1("functie")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	</td>
	</tr>
	<tr>
	<td>Ploeg vorig seizoen</td>
	<td colspan="2">
	<select name="ploegvorig">
		<option value=""></option>
		<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("ploegid")%>"<%
				if rs1("ploegid") = rs("ploegvorig") then
					%> selected<%
				end if
			%>><%=rs1("ploegnaam")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	</td>
	</tr>
	<tr>
	<td>Ploeg 1</td>
	<td>
	<select name="ploeg1" id="ploeg1">
		<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("ploegid")%>"<%
				if rs1("ploegid") = rs("ploeg1") then
					%> selected<%
				end if
			%>><%=rs1("ploegnaam")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	
	</td>
	<td colspan="2">Ploeg 2 
	<select name="ploeg2" id="ploeg2">
		<option value=""></option>
		<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("ploegid")%>"<%
				if rs1("ploegid") = rs("ploeg2") then
					%> selected<%
				end if
			%>><%=rs1("ploegnaam")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	</td>
	</tr>
	<tr>
	<td>Ploeg(en) volg.seiz.</td>
	<td colspan="3">
	<select name="ploegvolg1" id="ploegvolg1">
		<option value=""></option>
		<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("ploegid")%>"<%
				if rs1("ploegid") = rs("ploegvolg1") then
					%> selected<%
				end if
			%>><%=rs1("ploegnaam")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	
	<select name="ploegvolg2" id="ploegvolg2">
		<option value=""></option>
		<%sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen ORDER BY ploegid"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("ploegid")%>"<%
				if rs1("ploegid") = rs("ploegvolg2") then
					%> selected<%
				end if
			%>><%=rs1("ploegnaam")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	</td>
	</tr>
	<tr>
	<td>Niveau</td>
	<td colspan="2">
	<select name="niveau" id="niveau">
		<%sqlString = "SELECT niveauid, niveau FROM tblniveaus"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("niveauid")%>"<%
				if rs1("niveauid") = rs("niveau") then
					%> selected<%
				end if
			%>><%=rs1("niveau")%></option>
			<%rs1.movenext
		wend
		rs1.close%>
	</select>
	
	</td>
	</tr>
	
	</table>
	<p><input type="submit" value="wijzigen" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''"></p>
	</form></td>
	<td rowspan="16" valign="top">
	<%if rs("foto") <> "" and not isnull(rs("foto")) then%>
		<img src="toonfoto.asp?id=<%=rs("foto")%>" /><%
	end if
	if session("BL_soort") = 1 or Session("BL_lidid")= 188 then
	%><form name="form2" id="form2" enctype="multipart/form-data" method="post" action="fotowijzigen.asp?id=<%=id%>" ><font size="1">Foto: 200px x 250px</font><br />
	<input type="file" name="file"  style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" /><br />
	<input type="submit" value="foto opslaan" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''">
	</form>
	<%end if%>
	</td>
	</tr></table>
	<%if session("BL_soort") < 3 then
		if rs("laatste") <> "" and not isnull(rs("laatste")) then
			sqlstring = "SELECT naam, voornaam FROM tblleden WHERE id = " & rs("laatste")
			rs1.open sqlstring
			%><p>Laatste wijziging door <%=rs1("voornaam")%>&nbsp;<%=rs1("naam")%></p>
			<%rs1.close
		end if
	end if

end if
rs.close
end if

con.close%>
</div>
</body>
</html>
