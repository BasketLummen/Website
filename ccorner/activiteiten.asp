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
<title>Basket Lummen - Activiteiten</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	
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
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">

<p class="NieuwsTitels"><font size="3">Activiteiten</font></p>
<%
id = trim(request("id"))
if id = "" or isnull(id) then id = 0
soort = trim(request("soort"))
if soort <> "" and not isnull(soort) then
	begindatum = trim(request("begindatum"))
	beginuur = trim(request("beginuur"))
	einddatum = trim(request("einddatum"))
	einduur = trim(request("einduur"))
	naam = trim(request("naam"))
	omschrijving = trim(request("omschrijving"))
	locatie = trim(request("locatie"))
	link = trim(request("link"))
	if isnull(beginuur) or beginuur = "" then beginuur = "00:00"
	if isnull(einduur) or einduur = "" then einduur = "00:00"
	begindatum = cdate(begindatum)
	sqlstring = "INSERT INTO tblactiviteiten(soort,begindatum,einddatum,titel,omschrijving,locatie,link,auteur) " &_
		"VALUES(" & soort & ",'"&year(begindatum)&"-"&month(begindatum)&"-"&day(begindatum)&" "&beginuur&":00', "
	if isnull(einddatum) or einddatum = "" then
		sqlstring  = sqlstring & " NULL,"
	else
		sqlstring  = sqlstring & "'"&year(einddatum)&"-"&month(einddatum)&"-"&day(einddatum)&" "&einduur&":00', "
	end if
	sqlstring = sqlstring & "'"&naam&"','"&omschrijving&"','"&locatie&"','"&link&"',"&session("BL_lidid") & ")"
	con.execute sqlstring
end if



sqlString = "SELECT * FROM tblActiviteiten ORDER BY soort, begindatum"
rs.open sqlString%>
<table width="700">
<%while not rs.eof
	if soort <> rs("soort") then
		soort = rs("soort")%>
		<tr><td colspan="4" bgcolor="#FFFFFF"><p class="NieuwsTitels"><font size="3">&nbsp;<br />
		<%if rs("soort") = 1 then%>
			Sportief
		<%elseif rs("soort") = 2 then%>
			Extra sportief
		<%else%>
			Extern Lummen
		<%end if%></font></p>
		</td></tr>
		<tr>
			<th nowrap>datum</th>
			<th nowrap>naam</th>
			<th nowrap>locatie</th>
		</tr>

	<%end if
	if cint(id) = rs("id") then
		kleur = "FFFFCC"
	else
		kleur = "FFFFFF"
	end if%>
			<tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#<%=kleur%>'" bgcolor="#<%=kleur%>" style="cursor:hand;cursor:pointer;">
				<td nowrap="nowrap" valign="top" onclick="document.location='<%
				if session("BL_soort") < 1 then
					response.Write("actwijzigen")
				else
					response.Write("activiteiten")
				end if
				%>.asp?id=<%=rs("id")%>'">
				<%if isnull(rs("einddatum")) or rs("einddatum") = "" then%>
					<%=day(rs("begindatum"))%>&nbsp;<%=monthname(month(rs("begindatum")),true)%>
				<%else
					if day(rs("begindatum")) = day(rs("einddatum")) then%>
						<%=day(rs("begindatum"))%>&nbsp;<%=monthname(month(rs("begindatum")),true)%>
					<%elseif month(rs("begindatum")) = month(rs("einddatum")) then%>
						<%=day(rs("begindatum"))%>-<%=day(rs("einddatum"))%>&nbsp;<%=monthname(month(rs("begindatum")),true)%>
					<%else%>
						<%=monthname(month(rs("begindatum")),true)%>-<%=day(rs("einddatum"))%>&nbsp;<%=monthname(month(rs("einddatum")),true)%>
					<%end if
				end if%>
				</td>
				<td nowrap="nowrap" valign="top" onclick="document.location='<%
				if session("BL_soort") < 1 then
					response.Write("actwijzigen")
				else
					response.Write("activiteiten")
				end if
				%>.asp?id=<%=rs("id")%>'"><%=rs("titel")%></td>
				<td nowrap="nowrap" valign="top" onclick="document.location='<%
				if session("BL_soort") < 1 then
					response.Write("actwijzigen")
				else
					response.Write("activiteiten")
				end if
				%>.asp?id=<%=rs("id")%>'"><%=rs("locatie")%></td>
				<%if session("BL_soort") < 3 then%>
				<td valign="top" align="center" onmouseover="style.backgroundColor='#FF0000';" onmouseout="style.backgroundColor=''" onClick="if(confirm('Bent u zeker dat u <%=rs("titel")%> wilt verwijderen?',false))document.location='actverwijderen.asp?id=<%=rs("id")%>';">
					<img src="../img/delete.gif" alt="Verwijderen" border="0"></td>
				<%end if%>
				</tr>
				<%if cint(id) = rs("id") then%>
					<tr><td></td><td colspan="3" bgcolor="#FFFFCC">
					<%if FormatDateTime(rs("begindatum"),4) <> "00:00" then%>
					  Begin: <%=FormatDateTime(rs("begindatum"),4)%>
						<%if rs("einddatum") <> "" and not isnull(rs("einddatum")) then
							if FormatDateTime(rs("begindatum"),4) <> FormatDateTime(rs("einddatum"),4) then%>
								- Einde: <%=FormatDateTime(rs("einddatum"),4)%>
							<%end if
						end if%><br />
					<%end if%>
					<%=rs("omschrijving")%>
					<%if rs("link") <> "" and not isnull(rs("link")) then%>
						<br /><img src="../img/driehoek_rood.gif" />&nbsp;<a href="<%=rs("link")%>" target="_blank" class="NieuwsLinks">Meer info</a>
					<%end if%></td></tr>
				<%end if%>
			
			<%rs.movenext
		wend
		rs.close%>
	</table>
<%

if session("BL_soort") < 4 then%>
	<p class="NieuwsTitels"><font size="3">Activiteit toevoegen</font></p>
	<form method="post" action="activiteiten.asp">
	<table bgcolor="#FFFFFF">
	
	<tr><td>Soort</td>
	<td><select name="soort">
			<option value="1">Sportief</option>
			<option value="2">Extra-sportief</option>
			<option value="3">Extern Lummen</option>
		</select>
	</td></tr>
	<tr><td>Begindatum</td><td><input type="text" name="begindatum" size="12" /> <font size="1">(dd/mm/jjjj)</font> - 
	Uur <input type="text" name="beginuur" size="7" /> <font size="1">(uu:mm)</font></td></tr>
	<tr><td>Einddatum (ev.)</td><td><input type="text" name="einddatum" size="12" /> <font size="1">(dd/mm/jjjj)</font> -  
	Uur <input type="text" name="einduur" size="7" /> <font size="1">(uu:mm)</font></td></tr>
	<tr><td>Naam</td><td><input type="text" name="naam" size="60" /></td></tr>
	<tr><td valign="top">Omschrijving</td><td><textarea name="omschrijving" cols="50" rows="4"></textarea></td></tr>
	<tr><td>Locatie</td><td><input type="text" name="locatie" size="60" /></td></tr>
	<tr><td>Externe link</td><td><input type="text" name="link" size="60" /></td></tr>
	</table>
	<p><input type="submit" value="toevoegen" style="cursor:hand;cursor:pointer;" /></p>
	</form>
<%end if%>


</div></body>
</html>
<%
con.close%>