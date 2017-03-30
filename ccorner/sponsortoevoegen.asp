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
<title>Basket Lummen - Sponsors</title>

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
<!--#include file="menusponsors.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
naam = trim(request("naam"))
if naam <> "" and not isnull("naam") then
	sqlstring = "SELECT max(id) as nr FROM tblsponsors"
	rs.open sqlString
	id = rs("nr") + 1
	rs.close
	naam = replace(naam,"'","´")
	adres = replace(trim(request("adres")),"'","´")
	sqlstring = "INSERT INTO tblsponsors VALUES("&id&", '"&naam&"', '"&adres&"', "
	postnr = trim(request("postnr"))
	if isnull(postnr) or postnr = "" then 
		sqlstring = sqlString & "NULL, "
	else
		sqlstring = sqlString & postnr & ", "
	end if
	btw = trim(request("btw"))
	telnr = trim(request("telnr"))
	email = trim(request("email"))
	contact = trim(request("contact"))
	verantwoordelijke = trim(request("verantwoordelijke"))
	sqlstring = sqlString & "'" & btw & "', '" & telnr & "', '" & email & "', '" & contact & "', '" & verantwoordelijke & "', "
	bedrag = trim(request("bedrag"))
	if isnull(bedrag) or bedrag = "" then 
		sqlstring = sqlString & "0, "
	else
		sqlstring = sqlString & bedrag & ", "
	end if
	contactdatum = trim(request("contactdatum"))
	if isnull(contactdatum) or contactdatum = "" then 
		contactdtm = "null"
	else
		contactdtm = "'"&year(contactdatum)&"-"&month(contactdatum)&"-"&day(contactdatum)&"'"
	end if 
	opmerkingen = trim(request("opmerkingen"))
	sqlstring = sqlString & contactdtm &", " & trim(request("status")) & ", '" & trim(request("opmerkingen")) & "')"
	con.execute sqlString
	for i = 0 to 2
		sez = trim(request("seizoen"&i))
		opm = trim(request("opm"&i))
		sqlstring = "insert into tblsponsorjaren values("&id&","&sez&",'"&opm&"')"
		con.execute sqlstring
	next	%>
	<p>Sponsor toegevoegd.</p>
	<a href="sponsorlijst.asp">Terug naar de Sponsorlijst</a><br />
<%else

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con




%>
	<p class="NieuwsTitels"><font size="3">Sponsor toevoegen</font></p>

	<p>
	<form method="post" action="sponsortoevoegen.asp" id="form1">
	<table>
	<tr>
	<td colspan="2">Status</td>
	<td colspan="2"><select name="status">
	  <option value="1" selected>Actieve sponsor</option>
	  <option value="2">Actief in natura</option>
	  <option value="3">Niet gecontacteerd</option>
	  <option value="4">Geen interesse</option>
	  <option value="5">Geen optie</option>
	  </select>
	  </td>
	</tr>
	<tr>
	<td>Naam</td>
	<td colspan="2"><input type="text" name="naam" size="50">
	  </td>
	</tr>
	<tr>
	<tr>
	<td>Adres</td>
	<td colspan="2"><input type="text" name="adres" size="50"></td>
	</tr>
	<tr>
	<td>Gemeente</td>
	<td colspan="2">
	<select name="postnr">
		<%sqlString = "SELECT postnr, gemeente FROM tblgemeenten ORDER BY postnr"
		rs1.open sqlString
		while not rs1.eof%>
			<option value="<%=rs1("postnr")%>"<%
				if cint(rs1("postnr")) = 3560 then
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
	<td>BTW-nr</td>
	<td colspan="2"><input type="text" name="btw" size="50"></td>
	</tr>
	<tr>
	<td>Telnr</td>
	<td><input type="text" name="telnr" size="15"></td>
	</tr>
	<tr>
	<td>Contactpersoon (firma)</td>
	<td colspan="2"><input type="text" name="contact" size="50"></td>
	</tr>
	<tr>
	<td>Verantwoordelijke (club)</td>
	<td colspan="2"><input type="text" name="verantwoordelijke" size="30"></td>
	</tr>
	<tr>
	<td>Bedrag</td>
	<td colspan="2"><input type="text" name="bedrag" size="60"></td>
	</tr>
	<tr>
	<td colspan="2">Contactdatum (dd/mm/jjjj)</td>
	<td colspan="2"><input type="text" name="contactdatum" size="60" value="<%=rs("contactdatum")%>"></td>
	</tr>
	<tr>
	<td valign="top" rowspan="5">Opmerkingen</td>
	<td valign="top">Algemeen</td>
	<td colspan="2">
    <textarea name="opmerkingen" cols="60" rows="4"></textarea></td>
	</tr>
    <%
    startjaar = year(date())+2
	
	for i = 0 to 2
		seizoen = (startjaar - i - 1) & "-" & (startjaar - i)
		sqlstring = "select seizoenid from tblseizoenen where seizoen ='"&seizoen&"'"
		rs1.open sqlstring
		seizoenid = rs1("seizoenid")
		rs1.close	
		%>
	<tr>
    	<td valign="top"><%=seizoen%></td>
        <td colspan="2">
        <input type="hidden" name="seizoen<%=i%>" value="<%=seizoenid%>" />
        <textarea name="opm<%=i%>" cols="60" rows="4"></textarea></td>
    </tr>
	<%next%>

	
	</table>
	<p><input type="submit" value="toevoegen" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''"></p>
	</form>

rs.close
end if

con.close%>
</div>
</body>
</html>
