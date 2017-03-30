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
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
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
elseif session("BL_soort") > 2 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"ORDER BY ploegid"
	rs.open sqlString
end if
if rs.eof then%>
	<p>Enkel beschikbaar voor coaches.</p>
<%else
	if ploegid = 0 then
		response.Redirect("ploegen.asp?ploegid="&rs("ploegid"))
	end if
	%>
	<table width="800px" border="0" cellpadding="0" cellspacing="0">
	<tr bgcolor="#FFFFFF"><td width="50%">
	
	<p class="NieuwsTitels"><font size="3">Ledenlijst per ploeg</font></p>
	<table border="0" cellspacing="0"><tr><td bgcolor="#FFFFFF">
		<form name="jump">
			<p>Ploeg <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
			<%while not rs.eof%>
				<option value="ploegen.asp?ploegid=<%=rs("ploegid")%>"<%
				if int(ploegid) = rs("ploegid") then
					%> selected="selected"<%
				end if
				%>><%=rs("ploegnaam")%></option>
				<%rs.movenext
			wend
			rs.close%>
			</select></p>
		</form>
		</td>
		<td bgcolor="#FFFFFF">
		<form name="jump1">
		<%sqlString = "SELECT functieid, functie FROM tblFuncties ORDER BY functieid"
		rs.open sqlString%>
		<p>Functie <select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO">
		<option></option>
		<option value="ledenlijst.asp?functie=0">Alle leden</option>
		<%while not rs.eof%>
			<option value="ledenlijst.asp?functie=<%=rs("functieid")%>"><%=rs("functie")%></option>
			<%rs.movenext
		wend
		rs.close%>
	
		</select></p>
		</form>
	
		</td>
		</tr></table>
		</td>
	<td width="50%" align="right">
	<%if session("BL_soort") < 3 then%>
        <a href="ploegenexcel.asp?ploegid=<%=ploegid%>&ord=<%=ord%>"><img src="../img/msexcel.gif" border="0" alt="Download deze lijst in excel" /
        ></a>
	<%end if%>
	<a href="#" onClick="window.open('ploegenafdrukken.asp?ploegid=<%=ploegid%>&ord=<%=ord%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes');return(false)"><img src="../img/printer.gif" border="0" alt="Afdrukbare versie van deze pagina" /
	></a>
	
	</td>
	</tr>
	</table>
	<%
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
		
		sqlString = "SELECT id, vblnr, naam, voornaam, adres, tblleden.postnr, gemeente, " &_
					"geboortedatum, geslacht, aansluitingsdatum, status, telnr, gsm, email, " &_
					"oudersgsm, oudersemail, magsm, maemail, tblniveaus.niveau, tblfct1.functie AS fct1, " &_
					"tblfct2.functie AS fct2, tblpl0.ploegnaam AS pl0, tblpl1.ploegnaam AS pl1, " &_
					"tblpl2.ploegnaam AS pl2, status " &_ 
					"FROM (tblleden, tblgemeenten, tblniveaus) " &_ 
					"LEFT JOIN tblfuncties AS tblfct1 ON functie1 = tblfct1.functieid " &_
					"LEFT JOIN tblfuncties AS tblfct2 ON functie2 = tblfct2.functieid " &_
					"LEFT JOIN tblploegen AS tblpl0 ON ploegvorig = tblpl0.ploegid " &_
					"LEFT JOIN tblploegen AS tblpl1 ON ploeg1 = tblpl1.ploegid " &_
					"LEFT JOIN tblploegen AS tblpl2 ON ploeg2 = tblpl2.ploegid " &_
					"WHERE tblleden.postnr = tblgemeenten.postnr AND tblleden.niveau = "&_
					"tblniveaus.niveauid AND (ploeg1 = " & ploegid & " OR ploeg2 = " & ploegid & ") AND status = 'A' " &_
					"AND (functie1 = 1 OR functie2 = 1) " &_
					"ORDER BY " & order(ord) & "naam, voornaam"
		rs.open sqlString
		%>
		<table>
			<tr>
				<th nowrap><a href="ploegen.asp?ord=1&ploegid=<%=ploegid%>">id</a></th>
				<th nowrap><a href="ploegen.asp?ord=2&ploegid=<%=ploegid%>">vblnr</a></th>
				<th nowrap><a href="ploegen.asp?ord=0&ploegid=<%=ploegid%>">naam</a></th>
				<th nowrap>voornaam</th>
				<th nowrap>adres</th>
				<th nowrap><a href="ploegen.asp?ord=3&ploegid=<%=ploegid%>">geboortedatum</a></th>
				<th nowrap><a href="ploegen.asp?ord=4&ploegid=<%=ploegid%>">geslacht</a></th>
				<th nowrap><a href="ploegen.asp?ord=5&ploegid=<%=ploegid%>">aansluitingsdatum</a></th>
				<th nowrap><a href="ploegen.asp?ord=6&ploegid=<%=ploegid%>">status</a></th>
				<th nowrap>tel/gsm</th>
				<th nowrap>e-mail</th>
				<th nowrap>ouders gsm</th>
				<th nowrap>ouders e-mail</th>
				<th nowrap><a href="ploegen.asp?ord=7&ploegid=<%=ploegid%>">vorige ploeg</a></th>
				<th nowrap><a href="ploegen.asp?ord=8&ploegid=<%=ploegid%>">ploeg(en)</a></th>
				<th nowrap><a href="ploegen.asp?ord=9&ploegid=<%=ploegid%>">niveau</a></th>
				<th nowrap><a href="ploegen.asp?ord=10&ploegid=<%=ploegid%>">functie(s)</a></th>
				<th nowrap><a href="ploegen.asp?ord=0&ploegid=<%=ploegid%>">naam</a></th>
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
				<td nowrap valign="top">
					<%if rs("oudersgsm") <> "" then%>
						Vader: <%=rs("oudersgsm")%>
					<%end if%><br />
					<%if rs("magsm") <> "" then%>
						Moeder: <%=rs("magsm")%>
					<%end if%>
				</td>
				<td nowrap valign="top">
					<%if rs("oudersemail") <> "" then%>
						Vader: <a href="mailto:<%=rs("oudersemail")%>" class="email"><%=rs("oudersemail")%></a>
					<%end if%><br />
					<%if rs("maemail") <> "" then%>
						Moeder: <a href="mailto:<%=rs("maemail")%>" class="email"><%=rs("maemail")%></a>
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
		<p><b>Ploegverantwoordelijken:</b></p>
        <form name="form1" action="ploegverantw.asp?ploegid=<%=ploegid%>" method="post">
        <%sqlstring ="SELECT id, naam, voornaam FROM tblleden WHERE status ='A' ORDER BY naam, voornaam"
		rs.open sqlstring
		for i = 1 to 3%>
            <select name="verantw<%=i%>">
            <%sqlstring = "SELECT verantw"&i&" AS va FROM tblploegen WHERE ploegid = "&ploegid
			rs1.open sqlstring
			%>
            <option value="0"></option>
            <%while not rs.eof%>
            		<option value="<%=rs("id")%>"<%if rs("id") = rs1("va") then response.Write(" selected")%>><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></option>
				<%rs.movenext
			wend%>
            </select><br />
			<%rs1.close
			rs.movefirst
        next
		rs.close%>
        <input type="submit" value="opslaan" />
        </form>
	<%end if
	if session("BL_soort") = 1 then
	%><form name="form2" id="form2" enctype="multipart/form-data" method="post" action="fotowijzigen2.asp?id=<%=ploegid%>" ><p>Foto wijzigen <font size="1">Foto: 600px x 400px</font></p>
	<input type="file" name="file" size="50" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" /><br />
	<input type="submit" value="foto opslaan" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''">
	</form>
	<%end if
end if%>


</div>
</body>
</html>
