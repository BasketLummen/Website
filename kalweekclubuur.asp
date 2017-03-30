<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect2.asp" -->
<%
temp = 1

dim pl(30,3)
seizoen = trim(request("s"))
if isnull(seizoen) then seizoen = ""

intClub=1438

begin=trim(request("week"))
if begin="" or not isDate(begin) then begin=date()
dag = WeekDay(begin)
if dag < 4 then
	begin = DateAdd("d", -(dag + 3), begin)
else
	begin = DateAdd("d", -(dag - 4), begin)
end if
eind = DateAdd("d", 7, begin)


sqlString = "Select wedstrijd_id, reeksnr, datum, thuisresult, uitresult, thuisploeg, uitploeg, opm, " &_
			"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl, " &_ 
			"tblPloegenkal.plnaam2 AS thuispl2, tblPloegenkal1.plnaam2 AS uitpl2 " &_ 
			"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1 " &_
			"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_
				"AND datum between ('" & year(begin) & "-" & month(begin) & "-" & day(begin) & "') " &_
				"AND ('" & year(eind) & "-" & month(eind) & "-" & day(eind) & "') " &_
			"AND (thuisploeg Between (" & intClub & " *10000) And ((" & intClub & " + 1)*10000) OR " &_ 
			"uitploeg Between (" & intClub & " *10000) And ((" & intClub & " + 1)*10000)) " &_
			"ORDER BY datum, thuisploeg"
rs.open sqlString

%>
<html>
<head>
<title>
	<%=day(cdate(begin))%>
	<%if month(cdate(begin)) =  month(cdate(eind)) then
		%> tot <%=day(cdate(begin))%>&nbsp;<%=monthname(month(cdate(begin)))%><%
	else
		%>&nbsp;<%=monthname(month(cdate(begin)))%> tot <%=day(cdate(eind))
		%>&nbsp;<%=monthname(month(cdate(eind)))%><%
	end if%></title>

<link href="inc/1438.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
v = trim(request("v"))
if isnull(v) or v = "" then
	v = 0
end if

%>
<div align="center"> 
<form name="jump">
		<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
			<%dtm=cdate("02/08/2014")%>
			<option value="kalweekclubuur.asp?s=<%=seizoen%>">Kies andere datum</option>
			<%while dtm < cdate("1/05/2015")%>
    			<option value="kalweekclubuur.asp?s=<%=seizoen%>&week=<%=dtm%>"><%=day(dtm)%>&nbsp;<%=MonthName(Month(dtm),true)%>
			 	- <%=day(dtm+1)%>&nbsp;<%=MonthName(Month(dtm+1),true)%></option>
				<%dtm = dtm + 7
				wend%>
		</select>
		<select name="menu1" onchange=location=document.jump.menu1.options[document.jump.menu1.selectedIndex].value; value="GO">
				<option>Sorteren op...</option>
				<option value="kalweekclub.asp?s=<%=seizoen%>&week=<%=begin%>">Ploeg</option>
				<option value="kalweekclubuur.asp?s=<%=seizoen%>&week=<%=begin%>">Uur</option>
		</select>
</form>
</div>
<table border="0" align="center" cellspacing="0" cellpadding="3">
	<tr> 
	  <th colspan="7"> 
		 <a href="kalweekclubuur.asp?s=<%=seizoen%>&week=<%=begin-7%>"><img src="img/driehoek_rood2.gif" width="5" height="9" border="0" alt="vorige"></a>
		  Wedstrijden in weekend van <%=day(cdate(begin + 3))%>
		<%if month(cdate(begin + 3)) =  month(cdate(begin + 4)) then
			%> en <%=day(cdate(begin + 4))%>&nbsp;<%=monthname(month(cdate(begin + 3)))%><%
		else
			%>&nbsp;<%=monthname(month(cdate(begin + 3)))%> en <%=day(cdate(begin + 4))
			%>&nbsp;<%=monthname(month(cdate(begin + dag + 3)))%><%
		end if%>
		<a href="kalweekclubuur.asp?s=<%=seizoen%>&week=<%=begin+7%>"><img src="img/driehoek_rood.gif" width="5" height="9" border="0" alt="volgende"></a>
	  </th>
	</tr>    
<%	if temp = 0 or rs.eof then   'TEMP = 0 INDIEN KALENDER NOG NIET GETOOND MAG WORDEN
%>
 <td>geen wedstrijden deze week</td></tr>
<%else
	dtm=day(rs("datum"))
	while not rs.eof
		if dtm <> day(rs("datum")) then
			%><tr class="scheiding"><td colspan="7" height="1"></td></tr><%
			dtm= day(rs("datum"))
		end if
		if rs("thuisploeg") > (intClub*10000) And rs("thuisploeg") < ((intClub+ 1)*10000) then%>		
			<tr><td width="130" nowrap>
			&nbsp;<a href="kalploeg.asp?s=<%=seizoen%>&ploeg=<%=rs("thuisploeg")%>"><%=rs("thuispl2")%></a>
			</td>
		<%else%>
			<tr class="even"><td width="130">
			&nbsp;<a href="kalploeg.asp?s=<%=seizoen%>&ploeg=<%=rs("uitploeg")%>"><%=rs("uitpl2")%></a>
			</td>
		<%end if%>
	    <td align="right">
			<%if rs("opm") = "" or isnull(rs("opm")) or rs("opm") = "BvV" or rs("opm") = "BvB" or rs("opm") = "BvL" or rs("reeksnr") = 99 then%>
				<%=rs("wedstrijd_id")%>
			<%end if%>&nbsp;
		</td>
		<td width="170" nowrap><%=rs("thuispl")%></td><td width="210" nowrap><%=rs("uitpl")%>
			<%if not isnull(rs("opm")) then%>
				<span class="beker">&nbsp;(<%=rs("opm")%>)</span>
			<%end if%>
		</td>
		<td width="70" align="center" nowrap="nowrap"><%=rs("thuisresult")%>-<%=rs("uitresult")%></td>
		<td width="20" align="right"><%=WeekDayName(WeekDay(rs("datum")),true)%></td>
		<td width="50" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=FormatDateTime(rs("datum"),4)%>
			<%end if%>&nbsp;
		</td>
		</tr>
		<%rs.movenext
	wend
end if

rs.close
con.close
%>
</table>
</p>
<p>&nbsp;</p>
<div align="center">
<script language="JavaScript"><!-- Begin
if (window.print) {
document.write('<form>'
+ '<input type=button name=print value="Afdrukken" '
+ 'onClick="javascript:window.print()"></form>');
}
// End -->
</script>
</div>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-5769703-4");
pageTracker._trackPageview();
</script></body>
</html>

