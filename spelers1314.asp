<!--#include file="ccorner/connect.asp"-->
<html>
<head>
<title>Basket Lummen - Ploegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style>
body {
	background-image: url(img/logogrijsgroot.gif);
	background-position: 490px 10px;
	background-repeat: no-repeat;
}
</style>
</head>

<body onLoad="document.body.style.overflowX='hidden';">

<%
ploeg=trim(request("ploeg"))

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

	sqlString = "SELECT ploegid, ploegnaam, actief FROM tblploegen WHERE actief = 1 ORDER BY ploegid"
	rs1.open sqlString%>
		<div align="center">
			<form>
			<select onchange=location=this.options[this.selectedIndex].value; class="nieuws">
				<%while not rs1.eof%>
					<option value="spelers1314.asp?ploeg=<%=rs1("ploegid")%>"<%
					if int(ploeg) = rs1("ploegid") then%>
						 selected="selected"
						<%end if
					%>><%=rs1("ploegnaam")%></option>
					<%rs1.movenext
				wend
				rs1.close%>
			</select>
			</form>
		</div>


<table border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
<%
sqlString = "SELECT ploegnaam, tblcoach.naam AS coachnaam, tblcoach.voornaam AS coachvoornaam, tblcoach.email AS coachemail, " &_
			"tblcoach.foto AS coachfoto, tblassistent.naam AS assistentnaam, tblassistent.voornaam AS assistentvoornaam, " &_
			"tblassistent.email AS assistentemail, tblassistent.foto AS assistentfoto, ploegfoto, " &_
			"tblva1.naam AS va1naam, tblva1.voornaam AS va1voornaam, " &_
			"tblva2.naam AS va2naam, tblva2.voornaam AS va2voornaam, " &_
			"tblva3.naam AS va3naam, tblva3.voornaam AS va3voornaam " &_
			"FROM ((((tblPloegen LEFT JOIN tblLeden AS tblcoach ON tblPloegen.coachvolg = tblcoach.id) " &_
			"LEFT JOIN tblLeden AS tblassistent ON tblPloegen.assvolg = tblassistent.id) " &_
			"LEFT JOIN tblLeden AS tblva1 ON tblPloegen.verantw1 = tblva1.id) " &_
			"LEFT JOIN tblLeden AS tblva2 ON tblPloegen.verantw2 = tblva2.id) " &_
			"LEFT JOIN tblLeden AS tblva3 ON tblPloegen.verantw3 = tblva3.id " &_
			"WHERE ploegid = " & ploeg

rs.open sqlString
%>
	<tr bgcolor="#DDDDDD"> 
	  <td nowrap align="center" class="NieuwsTitels" colspan="2"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=rs("ploegnaam")%>
	  </td>
	</tr>
    <%if not isnull(rs("ploegfoto")) and rs("ploegfoto") <> "" then%>
    			<tr bgcolor="#DDDDDD"> 
	  <td nowrap align="center" class="NieuwsTitels" colspan="2">	  
					<img src="ccorner/toonfoto.asp?id=<%=rs("ploegfoto")%>" align="left">
			
  </td>
	</tr>
    
      	<%
			  end if%>
		  <tr bgcolor="#DDDDDD">
		  <td nowrap class="NieuwsTitels" width="300" style="border-top: 1px solid #000099;" valign="top"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Coach: <%=rs("coachvoornaam")%>&nbsp;<%=rs("coachnaam")%><br>
		  <a href="mailto:<%=rs("coachemail")%>" class="NieuwsLinks"><%=rs("coachemail")%></a><br><br>
			  <%if isnull(rs("coachfoto")) or rs("coachfoto") = "" then%>
					<img src="img/geenfoto.jpg" align="left">
			  <%else%>
					<img src="ccorner/toonfoto.asp?id=<%=rs("coachfoto")%>" align="left">
			  	<%
			  end if%>
		  </td>
		  <td nowrap class="NieuwsTitels" width="300" style="border-top: 1px solid #000099;" valign="top">
		  <%if not isnull(rs("assistentnaam")) and rs("assistentnaam") <> "" then%>
				<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Assistent: <%=rs("assistentvoornaam")%>&nbsp;<%=rs("assistentnaam")%><br>
			  	<a href="mailto:<%=rs("assistentemail")%>" class="NieuwsLinks"><%=rs("assistentemail")%></a><br><br>
			  <%if isnull(rs("assistentfoto")) or rs("assistentfoto") = "" then%>
					<img src="img/geenfoto.jpg" align="left">
			  <%else%>
					<img src="ccorner/toonfoto.asp?id=<%=rs("assistentfoto")%>" align="left">
			  <%end if%>
		  <%end if%>
		  &nbsp;</td>
		  </tr>
		  <tr bgcolor="#DDDDDD">
		  <td nowrap class="NieuwsTitels" style="border-top: 1px solid #000099;" colspan="2"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Spelers:</td></tr>

<tr>
<%
rs.close

pl = "ploeg1 = " & ploeg & " OR ploeg2 = " & ploeg

if int(ploeg) = 2 then
	pl = pl & " OR id = 155"
end if

sqlString =  "SELECT id, voornaam, naam, geboortedatum, foto, status FROM tblLeden " &_ 
		     "WHERE (" & pl & ") AND status = 'A' ORDER BY naam, voornaam"

rs.open sqlString



sw=-1
while not rs.eof
	sw=sw+1
	if sw = 2 then
		sw = 0%>
	  </tr><tr>
	 <%end if%>
	  <td width="320" nowrap style="border-top: 1px solid #000099;">
	  <%if isnull(rs("foto")) or rs("foto") = "" then%>
			<img src="img/geenfoto.jpg" align="left">
	  <%else%>
			<img src="ccorner/toonfoto.asp?id=<%=rs("foto")%>" align="left">
	  <%end if%>
	  <%=rs("voornaam")%><br><%=rs("naam")%><br><%=rs("geboortedatum")%>
	  </td>
	<%rs.MoveNext
wend 
rs.close


con.close

%>
 </tr></table>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-5769703-2");
pageTracker._trackPageview();
</script>
</body>
</html>
