<%toon=2%>
<!--#include file="ccorner/connect.asp"-->
<html>
<head>
<title>Basket Lummen - Live verslag</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="opmaak.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="ccorner/jquery-1.4.2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$(function() { 
		setInterval(controleer, 5000); 
	});	 

	function controleer() {
		
		$.ajax({
			  url: "livecontrole.asp",
			  global: false,
			  type: "POST",
			  data: ({wedstrijdnr: $("#wedstrijdnr").val(), id : $("#livetabel tr:first").attr("id")}),
			  dataType: "html",
			  async: false,
			  success: function(data){
					 $('#livediv').html(data); 
			  }
		});
	}

}); 

</script>
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
-->
</style>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; height:436px; z-index:1; left: 120px; top: 70px;">
<p class="NieuwsTitels"><font size="3"><%
sqlstring = "SELECT * FROM tbllivewedstrijden WHERE live = 1"
rs.open sqlString

if rs.eof then
	rs.close
	sqlstring = "SELECT * FROM tbllivewedstrijden WHERE year(datum)="&year(date())&" and month(datum)="&month(date())&" and day(datum)="&day(date())
	rs.open sqlString
	if rs.eof then
		rs.close
		sqlString = "SELECT id, wedstrijd FROM tbllivecomment ORDER BY id DESC LIMIT 1" 
		rs.open sqlString
		if not rs.eof then
			wedstrijdnr = rs("wedstrijd")
			rs.close
			sqlstring = "SELECT * FROM tbllivewedstrijden WHERE wedstrijdnr = "&wedstrijdnr
			rs.open sqlString%>
			Laatste wedstrijd: 
		<%end if
	else
		wedstrijdnr = rs("wedstrijdnr")%>
		Live verslag van 
	<%end if
else
	wedstrijdnr = rs("wedstrijdnr")%>
	Live verslag van 
<%end if
if not rs.eof then%>
	<%=rs("thuisploeg")%>&nbsp;-&nbsp;<%=rs("uitploeg")%></font></p>
    <%
    rs.close
    sqlstring = "SELECT * FROM tbllivecomment WHERE wedstrijd = " & wedstrijdnr & " ORDER BY id DESC"
    rs.open sqlString
    %>
    <input type="hidden" id="wedstrijdnr" value="<%=wedstrijdnr%>" />
    <div id="livediv">
    <table id="livetabel">
    <%while not rs.eof%>
        <tr id="<%=rs("id")%>" bgcolor="#FFFFFF"><td><%=rs("commentaar")%></td></tr>
        <%rs.movenext
    wend
end if
rs.close
con.close%>
</table>
</div>
</div>
</body>
</html>
