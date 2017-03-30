<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"-->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3"
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

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Basket Lummen Enquete</title>
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
input {
	text-align: center;
}
textarea {
	border: 1px solid #000099;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
	color: #000099;
}
-->
</style>

</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">
<%
lijst = trim(request("lijst"))
vraag = trim(request("vraag"))
if vraag = "" or isnull(vraag) then vraag = 0
if lijst = "" or isnull(lijst) then lijst = 1
Set rsVragen = Server.CreateObject("ADODB.Recordset")
rsVragen.activeconnection = con
Set rsAntw = Server.CreateObject("ADODB.Recordset")
rsAntw.activeconnection = con
sqlString = "SELECT vraagid, vraag, groep FROM tblVragen  WHERE vraagid > "&(lijst*100)&" AND vraagid < "&(lijst+1)*100&" ORDER BY vraagid"
rsVragen.open sqlString


sqlString = "SELECT lijstid, omschrijving FROM tblVragenlijsten ORDER BY lijstid"
rs.open sqlstring%>
<form name="jump">
	<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
<%while not rs.eof%>
	<option value="enqueteantwoorden.asp?lijst=<%=rs("lijstid")%>"
	<%if cint(lijst) = rs("lijstid") then
		%> selected="selected"<%
	end if
	%>><%=rs("omschrijving")%></option>
	<%rs.movenext
wend
rs.close%>
</select></form>				
<p>0 = niet van toepassing / geen mening<br>
1 = zwak tot zeer zwak / neen, zeker niet<br>
2 = voldoende / neutraal<br>
3 = goed tot zeer goed / ja, heel zeker
</p>
							
<table>
<%
dim antwoorden(4)
if lijst < 8 then
while not rsVragen.eof
	if (rsVragen("vraagid")-(lijst*100)) = 1 or (rsVragen("vraagid")-(lijst*100)) = 11 or (rsVragen("vraagid")-(lijst*100)) = 22 then%>
		<tr bgcolor="#DDDDDD">
			<th colspan="2">&nbsp;</th>
			<th>0</th>
			<th>1</th>
			<th>2</th>
			<th>3</th>
		</tr>
	<%end if%>
	<tr bgcolor="#FFFFFF">
	<%if rsVragen("groep") > 0 then%>
		<td colspan="8" width="600"><%=rsVragen("vraag")%></td>
		<%for j = 0 to rsVragen("groep")
			rsVragen.movenext%>
			</tr><tr bgcolor="#FFFFFF"><td width="25" style="border: none" rowspan="2">&nbsp;</td>
			<td width="455" id="tr_<%=rsVragen("vraagid")%>" rowspan="2" style="cursor:pointer;cursor:hand;" onMouseOver="style.backgroundColor='#FFFF00';" onMouseOut="style.backgroundColor=''" onClick="document.location='enqueteantwoorden.asp?lijst=<%=lijst%>&vraag=<%=rsVragen("vraagid")%>'"><%=rsVragen("vraag")%></td>
			<%for i = 0 to 3%>
				<td align="center">			<%sqlstring = "SELECT count(antwoord) AS aant FROM tblantwoorden WHERE vraagnr = "&rsVragen("vraagid")&" AND antwoord = "&i
			rsAntw.open sqlstring
			if rsAntw("aant") <> "" then
				response.Write(rsAntw("aant"))
				antwoorden(i) = cint(rsAntw("aant"))
			else
				response.Write("0")
				antwoorden(i) = 0
			end if
			rsAntw.close%>
</td>
			<%next
			totaal = antwoorden(0)+antwoorden(1)+antwoorden(2)+antwoorden(3)%>
	</tr><tr bgcolor="#FFFFFF" align="center">
	<%for i = 0 to 3%>
		<td nowrap="nowrap"><b><%=round((antwoorden(i)*100)/totaal,2)%> %</b></td>
	<%next%>
	</tr>
	<%if rsVragen("vraagid") = cint(vraag) then
		sqlstring = "SELECT ploeg, ploegnaam, categorie, antwoord, count(antwoord) as aantal " &_ 
				"FROM tblantwoorden, tblenqueteusers LEFT JOIN tblploegen ON ploeg = ploegid " &_
				"WHERE tblantwoorden.usercode = tblenqueteusers.usercode AND vraagnr = "&rsVragen("vraagid")&" " &_
				"GROUP BY ploeg, ploegnaam, categorie, antwoord " &_
				"ORDER BY ploeg, categorie, antwoord"
		rs.open sqlstring 
		tel = 4
		%><tr><%
		while not rs.eof
			if pl_contr<>rs("ploeg") or cat_contr<>rs("categorie") then
				%>
				</tr><tr>
				<td width="15">&nbsp;</td><td bgcolor="#EEEEEE"><%=rs("ploegnaam")%>,
				<%Select Case rs("categorie")
					Case 1
						Response.Write("Speler alleen")
					Case 2
						Response.Write("Speler met ouder(s)")
					Case 3
						Response.Write("Ouder(s) alleen")
					Case 4
						Response.Write("Trainer")
					Case 5
						Response.Write("Ploegafgevaardigde")
					Case 6
						Response.Write("Bestuurslid")
				end select
				pl_contr=rs("ploeg")
				cat_contr=rs("categorie")
				tel = 0%>
				</td>
			<%end if
			for i = tel+1 to rs("antwoord")%>
				<td>&nbsp;</td>
			<%next
			tel = rs("antwoord")+1%>
			<td bgcolor="#EEEEEE" align="center"><%=rs("aantal")%></td>
			<%rs.movenext
		wend
		rs.close%>
		</tr>
	<%end if
		next
	else%>
		<td width="480" id="tr_<%=rsVragen("vraagid")%>" colspan="2" rowspan="2" style="cursor:pointer;cursor:hand;" onMouseOver="style.backgroundColor='#FFFF00';" onMouseOut="style.backgroundColor=''" onClick="document.location='enqueteantwoorden.asp?lijst=<%=lijst%>&vraag=<%=rsVragen("vraagid")%>'"><%=rsVragen("vraag")%></td>
		<%for i = 0 to 3%>
			<td align="center" width="60">
			<%sqlstring = "SELECT count(antwoord) AS aant FROM tblantwoorden WHERE vraagnr = "&rsVragen("vraagid")&" AND antwoord = "&i
			rsAntw.open sqlstring
			if rsAntw("aant") <> "" then
				response.Write(rsAntw("aant"))
				antwoorden(i) = cint(rsAntw("aant"))
			else
				response.Write("0")
				antwoorden(i) = 0
			end if
			rsAntw.close%>
			</td>
		<%next

	totaal = antwoorden(0)+antwoorden(1)+antwoorden(2)+antwoorden(3)%>
	</tr><tr bgcolor="#FFFFFF" align="center">
	<%for i = 0 to 3%>
		<td nowrap="nowrap"><b><%=round((antwoorden(i)*100)/totaal,2)%> %</b></td>
	<%next%>
	</tr>
	<%if rsVragen("vraagid") = cint(vraag) then
		sqlstring = "SELECT ploeg, ploegnaam, categorie, antwoord, count(antwoord) as aantal " &_ 
				"FROM tblantwoorden, tblenqueteusers LEFT JOIN tblploegen ON ploeg = ploegid " &_
				"WHERE tblantwoorden.usercode = tblenqueteusers.usercode AND vraagnr = "&rsVragen("vraagid")&" " &_
				"GROUP BY ploeg, ploegnaam, categorie, antwoord " &_
				"ORDER BY ploeg, categorie, antwoord"
		rs.open sqlstring 
		tel = 4
		%><tr><%
		while not rs.eof
			if pl_contr<>rs("ploeg") or cat_contr<>rs("categorie") then
				%>
				</tr><tr>
				<td width="15">&nbsp;</td><td bgcolor="#EEEEEE"><%=rs("ploegnaam")%>,
				<%Select Case rs("categorie")
					Case 1
						Response.Write("Speler alleen")
					Case 2
						Response.Write("Speler met ouder(s)")
					Case 3
						Response.Write("Ouder(s) alleen")
					Case 4
						Response.Write("Trainer")
					Case 5
						Response.Write("Ploegafgevaardigde")
					Case 6
						Response.Write("Bestuurslid")
				end select
				pl_contr=rs("ploeg")
				cat_contr=rs("categorie")
				tel = 0%>
				</td>
			<%end if
			for i = tel+1 to rs("antwoord")%>
				<td>&nbsp;</td>
			<%next
			tel = rs("antwoord")+1%>
			<td bgcolor="#EEEEEE" align="center"><%=rs("aantal")%></td>
			<%rs.movenext
		wend
		rs.close%>
		</tr>
	<%end if
	end if
	rsVragen.movenext
wend%>
<tr bgcolor="#DDDDDD"><th colspan="2">&nbsp;</th><th>0</th><th>1</th><th>2</th><th>3</th></tr>
</table>
<%else
for i = 1 to 3%>
	<%sqlstring = "SELECT count(volgendseizoen) AS aant FROM tblenqueteusers WHERE volgendseizoen = "&i
	rsAntw.open sqlstring
	if rsAntw("aant") <> "" then
		antwoorden(i) = cint(rsAntw("aant"))
	else
		antwoorden(i) = 0
	end if
	rsAntw.close%>
	</td>
<%next%>
<p>Ik wens volgend seizoen zeker bij Basket Lummen te blijven: <b><%=antwoorden(1)%></b>
<br />Ik wens volgend seizoen zeker weg te gaan naar een andere club: <b><%=antwoorden(2)%></b>
<br />Ik weet nog niet wat ik volgend seizoen ga doen: <b><%=antwoorden(3)%></b>
</p>

<%end if%>
<hr />
<h3><b>Opmerkingen:</b></h3>
<%sqlstring = "SELECT ploeg, ploegnaam, categorie, opm"&lijst&" FROM tblenqueteusers " &_
			  "LEFT JOIN tblploegen ON ploeg = ploegid " &_
			  "WHERE opm"&lijst&" is not null AND opm"&lijst&" <> ''"
rs.open sqlstring
while not rs.eof%>
	<p>
	<b>
	<%Select Case rs("categorie")
		Case 1
			Response.Write("Speler alleen")
		Case 2
			Response.Write("Speler met ouder(s)")
		Case 3
			Response.Write("Ouder(s) alleen")
		Case 4
			Response.Write("Trainer")
		Case 5
			Response.Write("Ploegafgevaardigde")
		Case 6
			Response.Write("Bestuurslid")
	end select
	%>, <%=rs("ploegnaam")%>
	</b>
	<br /><%=rs("opm"&lijst)%></p>
	<%rs.movenext
wend 
rs.close
if lijst = 8 then%>
	<hr />
	<h3><b>Opmerkingen i.v.m. spelers die de club willen verlaten:</b></h3>
	<%sqlstring = "SELECT ploeg, ploegnaam, categorie, volgendopm FROM tblenqueteusers " &_
				  "LEFT JOIN tblploegen ON ploeg = ploegid " &_
				  "WHERE volgendopm is not null AND volgendopm <> ''"
	rs.open sqlstring
	while not rs.eof%>
		<p>
		<b>
		<%Select Case rs("categorie")
			Case 1
				Response.Write("Speler alleen")
			Case 2
				Response.Write("Speler met ouder(s)")
			Case 3
				Response.Write("Ouder(s) alleen")
			Case 4
				Response.Write("Trainer")
			Case 5
				Response.Write("Ploegafgevaardigde")
			Case 6
				Response.Write("Bestuurslid")
		end select
		%>, <%=rs("ploegnaam")%>
		</b>
		<br /><%=rs("volgendopm")%></p>
		<%rs.movenext
	wend 
	rs.close%>
<%end if
con.close
%>

</div>

</body>
</html>
