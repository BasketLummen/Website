<!--#include file="ccorner/connect.asp"-->
<%toon=6%>
<html>
<head>
<title>Basket Lummen - Verjaardagen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<%
sqlString = "SELECT naam, voornaam, geboortedatum, foto, tblfct1.functie AS fct1, tblfct2.functie AS fct2, " &_
			"tblpl0.ploegnaam AS pl0,  tblpl1.ploegnaam AS pl1, tblpl2.ploegnaam AS pl2, functie1, functie2, " &_ 
			"(YEAR(CURRENT_DATE()) - YEAR(geboortedatum)) AS leeftijd " &_ 
			"FROM (tblleden) " &_ 
			"LEFT JOIN tblfuncties AS tblfct1 ON functie1 = tblfct1.functieid " &_
			"LEFT JOIN tblfuncties AS tblfct2 ON functie2 = tblfct2.functieid " &_ 
			"LEFT JOIN tblploegen AS tblpl0 ON ploegvorig = tblpl0.ploegid " &_ 
			"LEFT JOIN tblploegen AS tblpl1 ON ploeg1 = tblpl1.ploegid " &_ 
			"LEFT JOIN tblploegen AS tblpl2 ON ploeg2 = tblpl2.ploegid " &_
			"WHERE status = 'A' AND (TO_DAYS(CONCAT(((RIGHT(geboortedatum,5) < RIGHT(CURRENT_DATE,5)) + YEAR(CURRENT_DATE)), RIGHT(geboortedatum,6))) - TO_DAYS(CURRENT_DATE) < 7) AND id <> 185 AND id <> 293 AND functie1 < 4 " &_ 
			"ORDER BY Month(geboortedatum), Day(geboortedatum), Year(geboortedatum) DESC"
rs.open sqlString
%>



<table width="450" border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td nowrap align="center" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Verjaardagen van <%=day(date())%>/<%=month(date())%> t.e.m. <%=day(date()+6)%>/<%=month(date()+6)%></td>
	</tr>
<%
if rs.eof then
	%>
	<tr bgcolor="#FFFFFF"><td>niemand</td></tr>
<%
else
  while not rs.eof
 	strVerj=Day(rs("geboortedatum"))&"/"&Month(rs("geboortedatum"))%>
    <tr><td><h1><img src="img/driehoek_blauw.gif" width="5" height="9">
	<%if Month(date()) = 12 and Month(rs("geboortedatum")) = 1 then%>
		<%=WeekdayName(Weekday(cDate(strVerj&"/"&(Year(Date())+1))))%>&nbsp;<%=Day(rs("geboortedatum"))&" "&monthname(Month(rs("geboortedatum")))%>
	<%else%>
		<%=WeekdayName(Weekday(cDate(strVerj&"/"&Year(Date()))))%>&nbsp;<%=Day(rs("geboortedatum"))&" "&monthname(Month(rs("geboortedatum")))%>
	<%end if%>
	</h1></td></tr>
   <tr><td nowrap style="border-bottom: 1px solid #000099;"><blockquote><p>
	<%if not isnull(rs("foto")) and rs("foto") <> "" then%>
		<img src="toonfoto.asp?id=<%=rs("foto")%>" align="left">
	<%end if%>
			<%=rs("voornaam")%>&nbsp;<%=rs("naam")%><br>
			<%if month(rs("geboortedatum")) = 1 and month(date()) = 12 then%>
		    <i><%=cint(rs("leeftijd"))+1%> jaar<br>
			<%else%>
		    <i><%=rs("leeftijd")%> jaar<br>
			<%end if%>
			<%'if rs("pl1") <> "" and not isnull(rs("pl1")) then response.Write(rs("pl1") & "<br />")	
			'if rs("pl2") <> "" and not isnull(rs("pl2")) then response.Write(rs("pl2") & "<br />")	
			'if rs("functie1") = 2 or rs("functie2") = 2 then response.Write("Coach <br />")
			'if rs("functie1") = 3 or rs("functie2") = 3 then response.Write("Bestuurslid <br />")
			'if rs("functie1") = 4 or rs("functie2") = 4 then response.Write("Ploegbegeleider <br />")						
			%></i></p>
	      </blockquote></td>
	  </tr>
	<%
	rs.MoveNext
  wend
end if
rs.close
%>
</table>

</div>
</body>
</html>