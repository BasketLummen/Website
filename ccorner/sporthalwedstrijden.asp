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

<BODY>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 700px;">
<p class="NieuwsTitels"><font size="3">Sporthalbezetting voor wedstrijden</font></p>
<%

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

dtm = request.QueryString("dtm")
if dtm = "" or isnull(dtm) then dtm = date()
dtm = cdate(dtm)

if dtm < #31/07/2006# then
	mnd = 7
else	
	mnd = month(dtm)
end if

%>
<table cellpadding="0" cellspacing="0"><tr><td>
<form name="jump">
	Maand <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
		<%dat = #31/07/2006#
		while dat < #31/05/2007#%>
		<option value="sporthalwedstrijden.asp?dtm=<%=dat%>"<%
		if month(dat) = mnd then
			%> selected="selected"<%
		end if
		%>><%=monthname(month(dat))%></option>
		<%dat = DateAdd("m",1,dat)
	wend
%>

	</select></p>
</form></td><td width="50">&nbsp;</td>
<td>
<form name="zoek" method="post" action="sporthalwedstrwijzig.asp">
Wedstrijdnr. <input type="text" name="id" /> <input type="submit" value="zoeken" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" />
</form>
</td>
</tr></table>
<%


sqlstring = "SELECT datum, sh1, sh2, sh3 FROM tblsporthaluren " &_ 
			"WHERE month(datum) = " & mnd & " " &_
			"AND (sh1 = 'M' or sh2 = 'm' or sh3 = 'm') " &_
			"ORDER BY datum"
rs.Open sqlString
%>

<table width="500">
<tr>
<td width="50%"><%if dtm > #31/07/2006# then%>
	<a href="sporthalwedstrijden.asp?dtm=<%=dateadd("m",-1,dtm)%>" class="NieuwsLinks"><img src="../img/driehoek_rood2.gif" border="0" /> vorige</a>
	<%end if%>
</td>
<td width="50%" align="right"><%if dtm < #31/05/2007# then%>
	<a href="sporthalwedstrijden.asp?dtm=<%=dateadd("m",1,dtm)%>" class="NieuwsLinks">volgende <img src="../img/driehoek_rood.gif" border="0" /></a>
	<%end if%></td>
</tr>
</table>
</td>
</tr>
<%
i=0
niettonen = 0
while not rs.eof
	if day(rs("datum")) <> dag then
		i = i + 1
		dag = day(rs("datum"))%>
			</table>
			<p></p>
			<a name="<%=formatdatetime(rs("datum"),2)%>" id="<%=formatdatetime(rs("datum"),2)%>"></a>
			<table width="500">
			<tr>
			<td colspan="3" class="ccornerTitels"><%=weekdayname(weekday(rs("datum")))%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")))%>&nbsp;<%=year(rs("datum"))%></td>
			</tr>
			<tr><th width="50">&nbsp;</th>
				<th width="225">Terrein 1</th> <th width="225">Terrein 3</th>
			</tr>
	<%end if
	
	if not rs.eof then%>
		<tr valign="top" style="cursor:hand;pointer:hand;"><th><%=FormatDateTime(rs("datum"),4)%></th> 
		<%if niettonen = 0 then
			sqlstring = "SELECT matchnr, datum, ploegnaam, tegenstnaam, matchsoort, terrein " &_
						  "FROM tblthuiswedstrijden " &_
						  "LEFT JOIN tblploegen ON ploeg = ploegid " &_
						  "LEFT JOIN tblthuistegenstanders ON tegenstander = stamnr " &_
						  "WHERE datum = '"&year(rs("datum"))&"-"&month(rs("datum"))&"-"&day(rs("datum"))&" "&hour(rs("datum"))&":"&minute(rs("datum"))&":00' ORDER BY terrein"
			rs1.open sqlstring
			if not rs1.eof then
				if rs1("terrein") = 1 then%>
					<td rowspan="4" bgcolor="#66CCFF" nowrap="nowrap" onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrwijzig.asp?id=<%=rs1("matchnr")%>'">
					<%=rs1("matchnr")%><br /><font size="3"><b><%=rs1("ploegnaam")%></b></font><br />
						- <%=rs1("tegenstnaam")%><br />(<%=rs1("matchsoort")%>)</td>
					<%rs1.movenext
					if not rs1.eof then
						if rs1("terrein") = 3 then%>
							<td rowspan="4" bgcolor="#66CCFF" nowrap="nowrap" onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrwijzig.asp?id=<%=rs1("matchnr")%>'">
							<%=rs1("matchnr")%><br /><font size="3"><b><%=rs1("ploegnaam")%></b></font><br />
							- <%=rs1("tegenstnaam")%><br />(<%=rs1("matchsoort")%>)</td>
						<%rs1.movenext
						end if
					else%>
					<td rowspan="4" onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''"
					onclick="document.location='sporthalwedstrtoev.asp?datum=<%=FormatDateTime(rs("datum"),2)%>&uur=<%=FormatDateTime(rs("datum"),4)%>&terrein=3'">&nbsp;</td>
					<%end if
				elseif rs1("terrein") = 2 then%>
					<td rowspan="4" colspan="2" bgcolor="#66CCFF" nowrap="nowrap" onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrwijzig.asp?id=<%=rs1("matchnr")%>'">
					<%=rs1("matchnr")%><br /><font size="3"><b><%=rs1("ploegnaam")%></b></font><br />
					- <%=rs1("tegenstnaam")%><br />(<%=rs1("matchsoort")%>)</td>
					<%rs1.movenext
				elseif rs1("terrein") = 3 then%>
					<td rowspan="4" onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''"
					 onclick="document.location='sporthalwedstrtoev.asp?datum=<%=FormatDateTime(rs("datum"),2)%>&uur=<%=FormatDateTime(rs("datum"),4)%>&terrein=1'">&nbsp;</td>
					<td rowspan="4" bgcolor="#66CCFF" nowrap="nowrap" onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrwijzig.asp?id=<%=rs1("matchnr")%>'">
					<%=rs1("matchnr")%><br /><font size="3"><b><%=rs1("ploegnaam")%></b></font><br /> 
					- <%=rs1("tegenstnaam")%><br />(<%=rs1("matchsoort")%>)</td>
					<%rs1.movenext
				end if
				if not rs1.eof then
					while not rs1.eof%>
						<td rowspan="4" bgcolor="#FF0000" nowrap="nowrap" onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrwijzig.asp?id=<%=rs1("matchnr")%>'">
						<%=rs1("matchnr")%><br /><font size="3"><b><%=rs1("ploegnaam")%></b></font><br />
						- <%=rs1("tegenstnaam")%><br />(<%=rs1("matchsoort")%>) <font color="#FFFFFF"><b>Terreinaanduiding foutief</b></font></td>
						<%rs1.movenext
					wend
				end if
				niettonen = 3
			else%>
				<td onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrtoev.asp?datum=<%=FormatDateTime(rs("datum"),2)%>&uur=<%=FormatDateTime(rs("datum"),4)%>&terrein=1'">&nbsp;</td>
				<td onmouseover="style.backgroundColor='#FFFF66';" onmouseout="style.backgroundColor=''" onclick="document.location='sporthalwedstrtoev.asp?datum=<%=FormatDateTime(rs("datum"),2)%>&uur=<%=FormatDateTime(rs("datum"),4)%>&terrein=3'">&nbsp;</td>
			<%end if%>
			</tr>
			<%rs1.close
		else
			niettonen = niettonen - 1
			sqlstring = "SELECT matchnr, datum, ploegnaam, tegenstnaam, matchsoort, terrein " &_
	  				    "FROM tblthuiswedstrijden " &_
						"LEFT JOIN tblploegen ON ploeg = ploegid " &_
						"LEFT JOIN tblthuistegenstanders ON tegenstander = stamnr " &_
						"WHERE datum = '"&year(rs("datum"))&"-"&month(rs("datum"))&"-"&day(rs("datum"))&" "&hour(rs("datum"))&":"&minute(rs("datum"))&":00' ORDER BY terrein"
			rs1.open sqlstring
			if not rs1.eof then
				while not rs1.eof%>
					<td rowspan="4" bgcolor="#FF0000" nowrap="nowrap"><%=rs1("matchnr")%><br /><font size="3"><b><%=rs1("ploegnaam")%></b></font><br />
					- <%=rs1("tegenstnaam")%><br />(<%=rs1("matchsoort")%>) <font color="#FFFFFF"><b>Uuraanduiding foutief</b></font></td>
					<%rs1.movenext
				wend
			end if
			rs1.close

		end if
		rs.MoveNext
	end if
wend

rs.Close

con.close%>
</table>

</div>

</BODY>
</HTML>
