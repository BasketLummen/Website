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

%><!--#include file="connect.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Coach Corner</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, input, select {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #FFFFFF;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	
}

-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menudocumenten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 175px; top: 40px; width: 800px;">

<%
soort = trim(request("soort"))
if soort = "" then soort=0

if soort = 208 then
	sqlString = "SELECT * FROM tbldocsoorten WHERE id > 2000 AND id < 2100 ORDER BY id"
	oefsoort = trim(request("oefsoort"))
	if oefsoort = "" then oefsoort = 0%>
	<p class="NieuwsTitels"><font size="3">Oefeningen</font></p>
	<form method="post" action="coachcorner.asp?soort=<%=soort%>">
	<table>
	<tr>
		<td colspan="2"><select name="jcdoc" onchange="document.location=this.options[this.selectedIndex].value;">
		<option>Maak uw keuze</option>
		<%
		rs.open sqlString
		while not rs.eof%>
			<option value="coachcorner.asp?soort=<%=soort%>&oefsoort=<%=rs("id")%>"<%
			if int(jcdoc) = rs("id") then
				%> selected="selected"<%
			end if
			%>><%=rs("docsoort")%></option>
			<%rs.movenext
		wend
		rs.close%>
		</select>
		</td>
	</tr>
	</table>
	</form>

	<%
elseif soort > 1000 and Session("BL_soort") < 3 then%>
	<p class="NieuwsTitels"><font size="3">
	<%if soort = 1001 then
		sqlString = "SELECT * FROM tbldocsoorten WHERE id > 1100 AND id < 1200 ORDER BY id"%>
		EFI
	<%elseif soort = 1002 then
		sqlString = "SELECT * FROM tbldocsoorten WHERE id > 1200 AND id < 1300 ORDER BY id"%>
		Scouting
	<%elseif soort = 1003 then
		sqlString = "SELECT * FROM tbldocsoorten WHERE id > 1300 AND id < 1400 ORDER BY id"%>
		FGT
	<%end if%>
	</font></p>
	<%jcdoc = trim(request("jcdoc"))
	if jcdoc = "" then jcdoc = 0%>
	<form method="post" action="coachcorner.asp?soort=<%=soort%>">
	<table>
	<tr>
		<td colspan="2"><select name="jcdoc" onchange="document.location=this.options[this.selectedIndex].value;">
		<option>Maak uw keuze</option>
		<%
		rs.open sqlString
		while not rs.eof%>
			<option value="coachcorner.asp?soort=<%=soort%>&jcdoc=<%=rs("id")%>"<%
			if int(jcdoc) = rs("id") then
				%> selected="selected"<%
			end if
			%>><%=rs("docsoort")%></option>
			<%rs.movenext
		wend
		rs.close%>
		</select>
		</td>
	</tr>
	</table>
	</form>

<%end if
if (soort <> 208 and soort < 1000) or (soort > 1000 and jcdoc > 0 and  Session("BL_soort") < 3) or (soort = 208 and oefsoort > 0) then
	if soort = 0 then
		sqlString = "SELECT docid, docsoort, docnaam, doctype, docsize, datum, naam, voornaam " &_
				"FROM (tbldocumenten, tblleden) WHERE id = auteur AND docsoort < 1000 " &_
				"ORDER BY datum DESC LIMIT 0, 10"
		%><p class="NieuwsTitels"><font size="3">Laatste nieuwe documenten</font></p><%
	elseif soort <> 208 and jcdoc = 0 then
		sqlString = "SELECT docsoort FROM tbldocsoorten WHERE id = " & soort
		rs.open sqlString
		%><p class="NieuwsTitels"><font size="3"><%=rs("docsoort")%></font></p><%
		rs.close
		sqlString = "SELECT docid, docsoort, docnaam, doctype, docsize, datum, naam, voornaam " &_
				"FROM tbldocumenten, tblleden WHERE id = auteur AND docsoort = " & soort &_
				" ORDER BY datum DESC"
	elseif soort > 1000 then
		sqlString = "SELECT docid, docsoort, docnaam, doctype, docsize, datum, naam, voornaam " &_
				"FROM tbldocumenten, tblleden WHERE id = auteur AND docsoort = " & jcdoc &_
				" ORDER BY docnaam, datum DESC"
	elseif soort = 208 then
		sqlString = "SELECT docid, docsoort, docnaam, doctype, docsize, datum, naam, voornaam " &_
				"FROM tbldocumenten, tblleden WHERE id = auteur AND docsoort = " & oefsoort &_
				" ORDER BY docnaam, datum DESC"
	end if
	rs.open sqlString
	
	
	
	
	%>
	
	
	
	<table width="100%">
		<tr>
			<th>&nbsp;</th>
			<th>Document</th>
			<th>Grootte</th>
			<th>Datum</th>
			<th>Geüpload door</th>
		</tr>
	<%
	while not rs.eof%>
		<tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#FFFFFF'" style="cursor:hand;cursor:pointer;" bgcolor="#FFFFFF">
			<td  onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<img src="../img/<%=replace(replace(rs("doctype"),"application/",""),"image/","")%>.gif" />
			</td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<b><%=rs("docnaam")%></b></td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<%=rs("docsize")%></td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<%=rs("datum")%></td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
			<%if session("BL_soort") < 3 then%>
			<td align="center" onmouseover="style.backgroundColor='#FF0000';" onmouseout="style.backgroundColor=''" onClick="if(confirm('Bent u zeker dat u <%=rs("docnaam")%> wilt verwijderen?',false))document.location='docverwijderen.asp?id=<%=rs("docid")%>';">
			<img src="../img/delete.gif" alt="Verwijderen" border="0"></td>
			<%end if%>
		</tr>
		<%rs.movenext
	wend
	rs.close
	con.close
	%>
	</table>
<%end if%>
<p><img src="../img/driehoek_rood.gif" /> <a href="docuploaden.asp?soort=<%=soort%>&jcdoc=<%=jcdoc%>" class="NieuwsLinks">Document uploaden</a></p>
<p><form name="zoek" action="doczoeken.asp" method="post">
<img src="../img/zoek.gif" /> <input type="text" name="docnaam" />  <input type="submit" value="zoeken" class="submitbutton" />
</form>

</p>


</div>

</body>
</html>
