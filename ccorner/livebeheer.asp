<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"--><%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
MM_authorizedUsers2="293"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
	Response.Redirect("index.asp")
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Live wedstrijd</title>
<script type="text/javascript" src="jquery-1.4.2.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	//wedstrijd wordt gestart
	$(".clsLive").click(function() {
		$.ajax({
			  url: "livestarten.asp",
			  global: false,
			  type: "POST",
			  data: ({wedstrijdnr : $(this).attr("id")}),
			  dataType: "html",
			  async: false,
			  success: function(data){
				 $("#divLive").html(data);
				 $("#bericht").focus();
			  }
		});
	});
	//bericht toegevoegd
	$('#bericht').live('keyup', function(e) {
		if(e.keyCode == 13) {
			$.ajax({
				  url: "livetoevoegen.asp",
				  global: false,
				  type: "POST",
				  data: ({bericht : $("#bericht").val()}),
				  dataType: "html",
				  async: false,
				  success: function(data){
					 $('#livetabel > thead').after(data); 
				  }
			});
			$("#bericht").val("")
		};
		
    });	
	//bericht verwijderen
	$('.clsVerwijderen').live('click', function(e) {
		if(confirm('Bent u zeker dat u dit bericht wilt verwijderen?',false)) {
			id = $(this).attr("id");
			$.ajax({
				  url: "liveverwijderen.asp",
				  global: false,
				  type: "POST",
				  data: ({id : id}),
				  dataType: "html",
				  async: false,
				  success: function(data){
						 $("#tr"+id).remove(); 
				  }
			});
		}
		 $("#bericht").focus();
	});
	//Live verslag stoppen
	$('#stoppen').live('click', function(e) {
		if(confirm('Bent u zeker dat u dit live verslag wil afsluiten?',false)) {
			$.ajax({
				  url: "livestoppen.asp",
				  global: false,
				  type: "POST",
				  dataType: "html",
				  async: false,
				  success: function(data){
						location.reload();
				  }
			});
		}
	});
}); 

</script>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
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
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
sqlString = "SELECT wedstrijdnr, datum, thuisploeg, uitploeg, opm FROM tbllivewedstrijden WHERE datum >= curdate() ORDER BY datum"
rs.open sqlString
%>
<div id="divLive">
<p class="NieuwsTitels"><font size="3">Live wedstrijd</font></p>
<table>
<%while not rs.eof%>
	<tr bgcolor="#FFFFFF"><td><%=day(rs("datum"))%>/<%=month(rs("datum"))%></td>
    <td><%=FormatDateTime(rs("datum"),4)%></td>
    <td><%=rs("thuisploeg")%> - <%=rs("uitploeg")%></td>
    <td><input type="button" value="Start Live-verslag" style="cursor: hand; cursor: pointer" class="clsLive" id="<%=rs("wedstrijdnr")%>" /></td></tr>
    <%rs.movenext
wend
rs.close
con.close%>
</table>
</div>
</div>
</body>
</html>
