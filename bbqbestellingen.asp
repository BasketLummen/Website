<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>BBQ</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {font-size: 24px}
-->
</style>
</head>

<body>
<%
sqlstring = "SELECT * FROM tblbbq ORDER BY id"
rs.open sqlstring

Spiering = 0
Varkensbrochette = 0 
Rundsbrochette = 0
Chipolata = 0
Kipfilet = 0
Scampi = 0
Zalm = 0
Barbecueworst = 0
%>
 <table border="1" cellspacing="0">
 	<tr>
    <th>&nbsp;</th>
    <th>Naam</th>
    <th>Keuze 1</th>
    <th>Keuze 2</th>
    <th>Keuze 3</th>
    </tr>
    <%while not rs.eof%>
    	<tr>
         <td><%=rs("id")%></td>
       		<td><%=rs("naam")%></td>
       		<td><%=rs("keuze1")%></td>
       		<td><%=rs("keuze2")%></td>
       		<td><%=rs("keuze3")%></td>
    	</tr>
    	<%
		select case rs("keuze1")
			case "Kipfilet":
				Kipfilet = Kipfilet + 1
			case "Varkensbrochette":
				Varkensbrochette = Varkensbrochette + 1
			case "Rundsbrochette":
				Rundsbrochette = Rundsbrochette + 1
			case "Spiering":
				Spiering = Spiering + 1
			case "Chipolata":
				Chipolata = Chipolata + 1
			case "Barbecueworst":
				Barbecueworst = Barbecueworst + 1
			case "Scampi":
				Scampi = Scampi + 1
			case "Zalm":
				Zalm = Zalm + 1
		end select
		select case rs("keuze2")
			case "Kipfilet":
				Kipfilet = Kipfilet + 1
			case "Varkensbrochette":
				Varkensbrochette = Varkensbrochette + 1
			case "Rundsbrochette":
				Rundsbrochette = Rundsbrochette + 1
			case "Spiering":
				Spiering = Spiering + 1
			case "Chipolata":
				Chipolata = Chipolata + 1
			case "Barbecueworst":
				Barbecueworst = Barbecueworst + 1
			case "Scampi":
				Scampi = Scampi + 1
			case "Zalm":
				Zalm = Zalm + 1
		end select
		select case rs("keuze3")
			case "Kipfilet":
				Kipfilet = Kipfilet + 1
			case "Varkensbrochette":
				Varkensbrochette = Varkensbrochette + 1
			case "Rundsbrochette":
				Rundsbrochette = Rundsbrochette + 1
			case "Spiering":
				Spiering = Spiering + 1
			case "Chipolata":
				Chipolata = Chipolata + 1
			case "Barbecueworst":
				Barbecueworst = Barbecueworst + 1
			case "Scampi":
				Scampi = Scampi + 1
			case "Zalm":
				Zalm = Zalm + 1
		end select
		rs.movenext
	wend
rs.close%>
</table>
<p>Totaal:</p>
<table border="1">
<tr><td>Spiering</td><td><%=Spiering%></td></tr>
<tr><td>Rundsbrochette</td><td><%=Rundsbrochette%></td></tr>
<tr><td>Varkensbrochette</td><td><%=Varkensbrochette%></td></tr>
<tr><td>Kipfilet</td><td><%=Kipfilet%></td></tr>
<tr><td>Chipolata</td><td><%=Chipolata%></td></tr>
<tr><td>Scampi</td><td><%=Scampi%></td></tr>
<tr><td>Zalm</td><td><%=Zalm%></td></tr>
<tr><td>Barbecueworst</td><td><%=Barbecueworst%></td></tr>

</table>

</body>
</html>
