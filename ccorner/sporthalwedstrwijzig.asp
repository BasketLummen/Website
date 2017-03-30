<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
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

<BODY>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 700px;">
<p class="NieuwsTitels"><font size="3">Sporthalbezetting voor wedstrijden</font></p>
<p class="NieuwsTitels"><font size="2" color="#FF0000">Wedstrijd wijzigen</font></p>
<%

id = trim(request("id"))
terrein = trim(request.Form("terrein"))
if terrein <> "" and not isnull(terrein) then
	datum = trim(request.Form("datum"))
	uur =  trim(request.Form("uur"))
	if isnull(datum) or datum = "" then 
		dtm = "null"
	else 
		dtm = year(datum)&"-"&month(datum)&"-"&day(datum)
		url= "?dtm=1/"&month(datum)&"/"&year(datum)
		if isnull(uur) or uur = "" then 
			dtm = dtm & " 00:00:00"
		else
			dtm = dtm & " "&hour(uur)&":"&minute(uur)&":00"
		end if
	end if
	sqlstring = "UPDATE tblthuiswedstrijden SET terrein="&terrein&", datum='"&dtm&"', laatste = " & session("BL_lidid") & " WHERE matchnr = "&id
	con.execute sqlstring
	response.Redirect("sporthalwedstrijden.asp"&url&"#"&datum)
	
else
	sqlstring = "SELECT matchnr, datum, ploegnaam, tegenstnaam, matchsoort, terrein, naam, voornaam, tblthuiswedstrijden.laatste " &_
				  "FROM tblthuiswedstrijden " &_
				  "LEFT JOIN tblploegen ON ploeg = ploegid " &_
				  "LEFT JOIN tblthuistegenstanders ON tegenstander = stamnr " &_
				  "LEFT JOIN tblleden ON tblthuiswedstrijden.laatste = tblleden.id " &_
				  "WHERE matchnr = " & id
	rs.open sqlstring
	
	if not rs.eof then%>
		<form method="post" action="sporthalwedstrwijzig.asp?id=<%=id%>" id="form1">
		<p><%=rs("matchnr")%>&nbsp;&nbsp;<b><%=rs("ploegnaam")%> - <%=rs("tegenstnaam")%></b> (<%=rs("matchsoort")%>)</p>
		<table><tr><td>Terrein</td><td><label for="1"><input type="radio" name="terrein" value="1" id="1" <%if rs("terrein")=1 then response.Write("checked")%> /> 1</label>&nbsp;<label for="2"><input type="radio" name="terrein" value="2" id="2" <%if rs("terrein")=2 then response.Write("checked")%> /> Volledig</label></td></tr>
		 <tr><td></td><td><label for="3"><input type="radio" name="terrein" value="3" id="3" <%if rs("terrein")=3 then response.Write("checked")%> /> 3</label></td></tr>
		<tr><td>Datum</td><td><input type="text" name="datum" size="15" value="<%=FormatDateTime(rs("datum"),2)%>"> <font size="1">dd/mm/jjjj</font></td></tr>
		<tr><td>Uur</td><td><input type="text" name="uur" size="8" value="<%=FormatDateTime(rs("datum"),4)%>"> <font size="1">uu:mm</font></td></tr></table>
		<input type="submit" value="opslaan" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" />&nbsp;&nbsp;<input type="button" value="annuleren" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrijden.asp?dtm=01/<%=month(rs("datum"))%>/<%=year(rs("datum"))%>'" />
		</form>
	
		<%if rs("laatste") <> "" and not isnull(rs("laatste")) then
			%><p>Laatste wijziging door <%=rs("voornaam")%>&nbsp;<%=rs("naam")%></p>
		<%end if
	
	
	end if
	
	rs.Close
end if
con.close%>

</div>

</BODY>
</HTML>
