<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - lid wijzigen</title>
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
<script language="javascript">
function wijz_ploeg()
{
	keuze=form1.ploeg1.selectedIndex
	if(keuze==32)
	{
		form1.ploeg2.selectedIndex = 0;
		form1.ploeg2.disabled = true;
		form1.niveau.selectedIndex = 5;
		form1.niveau.selectedIndex = 5;
		form1.niveau.disabled = true;
	}
	else
	{
		form1.ploeg2.disabled = false;
		form1.niveau.disabled = false;
		if(keuze<7 && keuze!=3)
			form1.niveau.selectedIndex=0;
		else if(keuze<9)
			form1.niveau.selectedIndex=1;
		else if(keuze<18)
			form1.niveau.selectedIndex=2;
		else if(keuze<25)
			form1.niveau.selectedIndex=3;
		else
			form1.niveau.selectedIndex=4;
	}
}
function wijz_functie()
{
	if(form1.functie1.options[form1.functie1.selectedIndex].value!=1 && form1.functie2.options[form1.functie2.selectedIndex].value !=1)
	{
		form1.ploeg1.selectedIndex = 32;
		form1.ploeg1.disabled = true;
		form1.ploeg2.selectedIndex = 0;
		form1.ploeg2.disabled = true;
		form1.niveau.selectedIndex = 5;
		form1.niveau.selectedIndex = 5;
		form1.niveau.disabled = true;
	}
	else
	{
		form1.ploeg1.disabled = false;
		form1.ploeg2.disabled = false;
		form1.niveau.disabled = false;
		wijz_ploeg()
	}
}
</script>
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
							"oudersgsm = '" & trim(request("oudersgsm")) & "', " &_
							"oudersemail = '" & trim(request("oudersemail")) & "', "
	ploegvorig = trim(request("ploegvorig"))
	if isnull(ploegvorig) or ploegvorig = "" then 
		sqlstring = sqlString & "ploegvorig = NULL, "
	else
		sqlstring = sqlString & "ploegvorig = " & ploegvorig & ", "
	end if
	ploeg1 = trim(request("ploeg1"))
	if isnull(ploeg1) or ploeg1 = "" then 
		sqlstring = sqlString & "ploeg1 = 33, "
	else
		sqlstring = sqlString & "ploeg1 = " & ploeg1 & ", "
	end if
	ploeg2 = trim(request("ploeg2"))
	if isnull(ploeg2) or ploeg2 = "" then 
		sqlstring = sqlString & "ploeg2 = NULL, "
	else
		sqlstring = sqlString & "ploeg2 = " & ploeg2 & ", "
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
	sqlString = sqlString & " laatste = " & session("BL_lidid") & " WHERE id = " & id 
	con.execute sqlString%>
	<p>Lid gewijzigd.</p>
	<a href="ledenlijst.asp">Terug naar de lijst</a><br />
	<a href="ploegen.asp">Terug naar de lijst per ploeg</a>
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

	<%if rs("foto") <> "" and not isnull(rs("foto")) then%>
		<img src="toonfoto.asp?id=<%=rs("foto")%>" /><%
	end if
	if session("BL_soort") = 1 then
	%><form name="form2" id="form2" enctype="multipart/form-data" action="fotowijzigen.asp" ><font size="1">Foto: 200px x 250px</font><br />
	<input type="hidden" name="id" value="<%=id%>" />
	<input type="file" name="file"  style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" /><br />
	<input type="submit" value="foto opslaan" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''">
	</form>
	<%end if%>
<%end if
rs.close
end if

con.close%>
</div>
</body>
</html>
