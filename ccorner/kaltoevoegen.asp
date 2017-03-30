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
<title>Basket Lummen - Kalender</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, input {
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
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 650px;">

<p class="NieuwsTitels"><font size="3">Kalender toevoegen</font></p>

<%
		
Set rs1 = Server.CreateObject("ADODB.Recordset")
rs1.activeconnection = con

sqlString = "SELECT tblusers.lidid, naam, voornaam, functie1, functie2 " &_
			"FROM tblusers, tblleden WHERE tblusers.lidid = tblleden.id " &_
			"ORDER BY naam, voornaam"
rs.Open sqlString

onderwerp = trim(request("onderwerp"))
if not isnull(onderwerp) and onderwerp <> "" then
	sqlString = "SELECT max(kalid) AS nr FROM tblkalender"
	rs1.Open sqlString
	nr = rs1("nr") + 1
	rs1.close
	while not rs.EOF
		usr = trim(request("usr"&rs("lidid")))
		if usr = "ok" then
			sqlString = "INSERT INTO tblkalenderusers VALUES(" & nr & ", " & rs("lidid") & ")"
			con.Execute sqlString
			toevoegen = true
		end if
		rs.MoveNext
	wend
	if toevoegen then
		dtm = trim(request("datum"))
		tijd = trim(request("uur"))
		plaats = trim(request("plaats"))
		opmerkingen = Replace(trim(request("opmerkingen")), chr(13) & chr(10), "<br>")
		opmerkingen = Replace(opmerkingen, "'", "´")
		datum = year(dtm)&"-"&month(dtm)&"-"&day(dtm)&" "&tijd
		sqlString = "INSERT INTO tblkalender VALUES(" & nr & ", '" & datum & "', " &_
					"'" & onderwerp & "', '" & plaats & "', '"& opmerkingen &"', " &_
					session("BL_lidid") & ")"
		con.Execute sqlString%>
		<p>Onderwerp is toegevoegd.</p>	
	<%else%>
		<p>U moet minstens &eacute;&eacute;n naam selecteren. <a href="#" onClick="history.back()">Terug</a></p>
	<%end if
else%>
	<form method="post" action="kaltoevoegen.asp" name="form1" ID="form1">
	<table>
	<tr><td>Datum <input type="text" name="datum" size="10"> <font size="1">dd/mm/jjjj</font></td>
	<td>Uur <input type="text" name="uur" size="5"> <font size="1">uu:mm</font></td>
	<td>Locatie <input type="text" name="plaats"></td></tr>
	<tr><td colspan="3">Onderwerp <input type="text" name="onderwerp" size="50"></td></tr>
	<tr><td colspan="3">Opmerkingen</td></tr>
	<tr>
	<td colspan="3"><textarea cols="75" rows="5" name="opmerkingen"></textarea></td>
	</tr>

	<tr><td colspan="3">Versturen naar</td></tr>
	<tr><td colspan="3"><input type="button" value="Iedereen" onClick="controleer('A');">
	<input type="button" value="Bestuur" onClick="controleer('B');">
	<input type="button" value="Coaches" onClick="controleer('C');">
	<input type="button" value="Wis alles" onClick="controleer('N');"></td>
	
	</tr></table>
	<table bgcolor="silver">
	<tr bgcolor="#FFFFFF">
		
	<%
	tel = 0
	while not rs.EOF
		tel = tel + 1%>
		<td><label for="usr<%=rs("lidid")%>">
		<input type="checkbox" name="usr<%=rs("lidid")%>" value="ok" id="usr<%=rs("lidid")%>"<%
		if rs("lidid") = session("BL_lidid") then
			%> checked<%
		end if%>>
		<%=rs("voornaam")%>&nbsp;<%=rs("naam")%></label></td>
		<%rs.MoveNext
		if tel = 4 then
			tel = 0
			%></tr><tr bgcolor="#FFFFFF"><%
		end if
	wend
	%>
	</tr></table>
	<p><input type="submit" value="verzenden"></p>
	</form>
<%end if%>
</div>
<!--#include file="kalender.asp"-->

</HTML>

<SCRIPT language="javascript">
function controleer(soort) {
if(soort=='A')
	{<%rs.movefirst
	while not rs.eof%>
		document.form1.usr<%=rs("lidid")%>.checked=true;
		<%rs.movenext
	wend%>}
if(soort=='B')
	{<%rs.movefirst
	while not rs.eof
		if rs("functie1") = 3 or rs("functie2") = 3 then%>
			document.form1.usr<%=rs("lidid")%>.checked=true;
		<%end if
		rs.movenext
	wend%>}
if(soort=='C')
	{<%rs.movefirst
	while not rs.eof
		if rs("functie1") = 2 or rs("functie2") = 2 then%>
			document.form1.usr<%=rs("lidid")%>.checked=true;
		<%end if
		rs.movenext
	wend%>}
if(soort=='N')
	{<%rs.movefirst
	while not rs.eof%>
		document.form1.usr<%=rs("lidid")%>.checked=false;
		<%rs.movenext
	wend%>}
}
</SCRIPT>


<%con.Close%>
