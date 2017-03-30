<%toon=3%>
<!--#include file="ccorner/connect.asp"--><html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, input, select {
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
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	
}

-->
</style>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:860px; height:436px; z-index:1; left: 120px; top: 70px;">.


<p>Hieronder vind je een gedetailleerd overzicht van trainingsuren van de huidige week en de volgende week per dag. Je kan hier zien als er wijzigingen zijn in het trainingsprogramma.
<table>
  <tr align="center" bgcolor="#ffffff"><td>Baskettraining</td><td bgcolor="#FFFFCC">Vrij voor basket</td>
<td bgcolor="#DDDDDD">Niet beschikbaar</td></tr>
<tr align="center"><td bgcolor="#0099FF">Match</td><td bgcolor="#FF9900">Clinic</td>
</tr>
</table>
<%
dtm = date()

%>
<table><tr>

<%
dim hal(5)
hal(0) = "sh1"
hal(1) = "sh2"
hal(2) = "sh3"
hal(3) = "ohvm"
hal(4) = "zolder"



for x = 0 to 3
if dtm < cdate("27/07/2015") then
	dtm = cdate("27/07/2015")
elseif weekday(dtm) = 1 then
	dtm = dtm - 6
else	
	dtm = dtm - weekday(dtm) + 2
end if%>
<td width="50%">
<%
einde = false
dag=""
sqlstring = "SELECT datum, sh1, sh2, sh3, ohvm, zolder FROM tblsporthaluren " &_ 
			"WHERE datum > '" & year(dtm) & "-" & month(dtm) & "-" & day(dtm) & "' AND hour(datum) >= 15 " &_
			"ORDER BY datum"
rs.Open sqlString

%>

<table>

<%

i=0
while not einde
	if rs.eof then
		einde = true
	elseif day(rs("datum")) <> dag then
		i = i + 1
		if i = 8 then einde = true
		dag = day(rs("datum"))
		if not einde then%>
		</table>
			<p></p>
			<table width="360">
			<tr>
			<td colspan="6" class="ccornerTitels"><%=weekdayname(weekday(rs("datum")))%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")))%>&nbsp;<%=year(rs("datum"))%></td>
			</tr>
			<tr>
				<th width="50">&nbsp;</th>
				<%for j = 0 to 4%>
				<th width="60"><%=hal(j)%></th>
				<%next%>
		</tr>
		<%end if
	end if
	if not einde then%>
	<tr>
	<th><%=FormatDateTime(rs("datum"),4)%></th> 
	<%for j = 0 to 4%>
	<td nowrap="nowrap" align="center"
		<%if rs(hal(j)) = "NB" then%>
			 bgcolor="#DDDDDD">&nbsp;
		<%elseif rs(hal(j)) = "C" then%>
			 bgcolor="#FF9900">&nbsp;
		<%elseif rs(hal(j)) = "M" or rs(hal(j)) = "MATCH" then%>
			 bgcolor="#0099FF">&nbsp;
		<%elseif rs(hal(j)) = "" or isnull(rs(hal(j))) then%>
			 bgcolor="#ffffcc">&nbsp;
		<%else%>
			 bgcolor="#ffffff"><%=rs(hal(j))%>
		<%end if%>
		</td>
	<%next%>	</tr>
	<%rs.MoveNext
	end if
wend

rs.Close
%>
</table></td>
<%
	dtm = dateadd("d",dtm,7)
next%>
</tr></table>



</div>
</body>
</html>
