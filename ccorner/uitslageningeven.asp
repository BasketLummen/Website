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
.crij {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">

<%
seizoen = trim(request("s"))
if s="" or isnull(seizoen) then seizoen = "1415"

begin=trim(request("week"))
if begin="" or not isDate(begin) then begin=date()
dag = WeekDay(begin)
if dag < 4 then
	begin = DateAdd("d", -(dag + 3), begin)
else
	begin = DateAdd("d", -(dag - 4), begin)
end if
eind = DateAdd("d", 6, begin)



sqlString = "Select wedstrijd_id, reeksnr, datum, thuisresult, uitresult, " &_
			"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl, reeksnaam " &_ 
			"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1, tblReeksen"&seizoen&" " &_
			"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_
			"AND datum between ('" & year(begin) & "-" & month(begin) & "-" & day(begin) & "') " &_
			"AND ('" & year(eind) & "-" & month(eind) & "-" & day(eind) & "') " &_
			"AND reeksnr = reeks_id " &_
			"ORDER BY reeksnr, datum, wedstrijd_id"

rs.open sqlString

if rs.eof then
	%>Geen wedstrijden deze week.<%
else
	%>
	<p align="center"><font size="4">Uitslagen ingeven <%=date()%></font></p>
	<form name="uitslagen" method="post" action="uitslagenopslaan.asp">
		<input type="hidden" name="frmDatum" value="<%=begin%>">
	<table border=0 class="kalender" align="center">
	<%while not rs.eof
		if rs("reeksnr") <> reeks then
			dtm = ""
			reeks = rs("reeksnr")%>
			<tr><td colspan="6"><br><b><u><%=rs("reeksnaam")%></u></b><br></td></tr>
		<%end if%>
			<tr>
			<td width="60" align="center"><%=rs("wedstrijd_id")%></td>
			<td widht="50"><%=day(rs("datum"))%>/<%=month(rs("datum"))%></td>
			<td width="50" align="center">
			<%if not isnull(rs("datum")) then%>	
				<%=FormatDateTime(rs("datum"),4)%>
			<%end if%>
			</td>
			<td nowrap="nowrap"><%=rs("thuispl")%></td>
			<td nowrap="nowrap"><%=rs("uitpl")%></td>
			<td><input type="text" name="<%=rs("wedstrijd_id")%>t" size="5" value="<%=rs("thuisresult")%>"></td>
			<td width="30" align="center">-</td>
			<td><input type="text" name="<%=rs("wedstrijd_id")%>u" size="5" value="<%=rs("uitresult")%>"></td>
		</tr>
		<%rs.movenext
	wend%>
	</table><p align="center">
	<input type="submit" value="Opslaan">&nbsp;<input type="reset" value="reset"></p></form>
<%end if
rs.close
con.close

%>
</div>
</body>
</html>
