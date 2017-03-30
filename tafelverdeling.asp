<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect2.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Tafelverdeling</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style>
td {
	font-size: 10px;
}
</style>
</head>

<body>
<%
seizoen = "1415"
ploeg = trim(request("ploeg"))

sqlString = "SELECT plnaam2 from tblPloegenkal"&seizoen&" WHERE ploeg_id = " & ploeg
rs.open sqlString
naam=rs("plnaam2")
rs.close

sqlString = "Select wedstrijd_id, datum, opm, tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl, " &_ 
			"thuisploeg, uitploeg, klok, feuille, 24sec, delege " &_
			"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1 " &_
			"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_
			"AND (thuisploeg = " & ploeg & " OR uitploeg = " & ploeg & ") ORDER BY -datum DESC"

rs.open sqlString


if rs.eof then
	%><p>Geen wedstrijden.</p><%
else
	%>
    <h1 align="center">Tafelverdeling <%=naam%></h1>
	<table cellspacing=0 border="1" align="center">
		<tr> 
            <th colspan="2">datum</th>
            <th width="50">uur</th>
            <th colspan="2">Wedstrijd</th>
            <th>Klok</th>
            <th>Feuille</th>
            <th>24 seconden</th>
            <th>Delegé</th>
          </tr>
    
	<%while not rs.eof%>
	   <tr>
		<td width="20" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=WeekDayName(WeekDay(rs("datum")),true)%>
			<%else%>
				&nbsp;
			<%end if%>
		 </td>
		<td width="40" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=day(rs("datum"))%>/<%=month(rs("datum"))%>
			<%else%>
				&nbsp;
			<%end if%>
		 </td>
		<td width="50" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=FormatDateTime(rs("datum"),4)%>
			<%else%>
				&nbsp;
			<%end if%>
		</td>
		<td nowrap><%=rs("thuispl")%></td><td nowrap><%=rs("uitpl")%>
			<%if not isnull(rs("opm")) then%>
				<span class="beker">(<%=rs("opm")%>)</span>
			<%end if%>
		</td>
        <%if rs("thuisploeg") = int(ploeg) then%>
            <td><%=rs("klok")%></td>
            <td align="center">n.v.t.</td>
            <td><%=rs("24sec")%></td>
        <%else%>
            <td align="center">n.v.t.</td>
            <td><%=rs("feuille")%></td>
            <td align="center">n.v.t.</td>
        <%end if%>
        <td><%=rs("delege")%></td>
	  </tr>
      <%rs.movenext
	wend%>
    </table>
<%end if
rs.close
con.Close%>
</div>
</BODY>
</HTML>  