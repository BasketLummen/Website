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
<title>Basket Lummen - Berichten</title>
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

<p class="NieuwsTitels"><font size="3">Bericht plaatsen</font></p>

<%
		
Set rs1 = Server.CreateObject("ADODB.Recordset")
rs1.activeconnection = con

sqlString = "SELECT tblusers.lidid, naam, voornaam, email, functie1, functie2 " &_
			"FROM tblusers, tblleden WHERE status = 'A' AND tblusers.lidid = tblleden.id AND blocked = 0 " &_
			"AND tblusers.lidid <> " & session("BL_lidid") &_
			" ORDER BY naam, voornaam"
rs.Open sqlString

bericht = trim(request("bericht"))
if not isnull(bericht) and bericht <> "" then

	'if isempty(conf) then
	'		const cdosendusingport = 2
	'		set conf = createobject("cdo.configuration")
	'
	'		with conf.fields
	'			.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
	'			.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
	'			.Update
	'		end with
	'end if

	sqlString = "SELECT max(berichtid) AS nr FROM tblBerichten"
	rs1.Open sqlString
	nr = rs1("nr") + 1
	while not rs.EOF
		usr = trim(request("usr"&rs("lidid")))
		if not isnull(rs("email")) and rs("email") <> "" then
			if usr = "ok" then
				sqlString = "INSERT INTO tblberichtenusers VALUES(" & nr & ", " & rs("lidid") & ")"
				con.Execute sqlString
				toevoegen = true
				%><iframe src="sendmail.php?adres=<%=rs("email")%>" style="display:none;"></iframe><%
				'Set myMail=CreateObject("CDO.Message")
				'myMail.configuration = conf
				'myMail.Subject="Coach Corner"
				'myMail.From="Basket Lummen (johnny.peeters@basketlummen.be)"
				'myMail.To=rs("email")
				'myMail.HTMLBody = "Er is een nieuw bericht voor u: <a href=http://www.basketlummen.be/ccorner>http://www.basketlummen.be/ccorner</a>" 
				'myMail.Send
				set myMail=nothing
			end if
		end if
		rs.MoveNext
	wend
	if toevoegen then
		bericht = Replace(bericht, chr(13) & chr(10), "<br>")
		bericht = Replace(bericht, "'", "´")
		datum = year(date())&"-"&month(date())&"-"&day(date())&" "&time()
		sqlString = "INSERT INTO tblBerichten VALUES(" & nr & ", '" & datum & "', '" & bericht & "', " &session("BL_lidid") & ")"
		con.Execute sqlString%>
		<p>Bericht is toegevoegd.</p>	
	<%else%>
		<p>U moet minstens &eacute;&eacute;n naam selecteren. <a href="#" onClick="history.back()">Terug</a></p>
	<%end if
else%>
	<form method="post" action="berichtplaatsen.asp" name="form1" ID="form1">
	<table>
	<tr><td>Bericht</td></tr>
	<tr>
	<td><textarea cols="75" rows="5" name="bericht"></textarea></td>
	</tr>

	<tr><td>Versturen naar</td></tr>
	<tr><td><input type="button" value="Iedereen" onClick="controleer('A');">
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
		<input type="checkbox" name="usr<%=rs("lidid")%>" value="ok" id="usr<%=rs("lidid")%>">
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
<!--#include file="kalender.asp"--></BODY>

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
