<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Berichten</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<link href="jquery/jquery.alerts.css" rel="stylesheet" type="text/css">
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
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
<!--#include file="connect.asp"-->
<script type="text/javascript" src="jquery-1.4.2.js"></script> 
<script type="text/javascript" src="jquery/jquery.alerts.js"></script> 
<script type="text/javascript">
$(document).ready(function() {
	jQuery.ajaxSettings.traditional = true;
	$(".imgPlus").live("click",function() {
		nr = $(this).attr("id").split("_");
		if(nr[1]<3)
			tijd = "";
		else if(nr[2]==1)
			tijd = "11-14 uur";
		else
			tijd = "17-20 uur";
		jPrompt(tijd, '',$("#taak_"+nr[1]).html(), function(r) {
			 if( r ) {
					$.ajax({
						  url: "mossselfeesthulptoevoegen.asp",
						  global: false,
						  data: ({id: nr[1], tijd:nr[2], naam: r}),
						  type: "POST",
						  dataType: "html",
						  async: false,
						  success: function(data){
								$("#txt_"+nr[1]+"_"+nr[2]).html(data);
						  }
					});      
			 };

		});
	});
	$(".imgMin").live("click",function() {
		nr = $(this).attr("id").split("_");
		jConfirm(nr[3]+' verwijderen?', $("#taak_"+nr[1]).html(), function(r) {
			if(r) {
					$.ajax({
						  url: "mossselfeesthulpverwijderen.asp",
						  global: false,
						  data: ({id: nr[1], tijd: nr[2],naam: nr[3]}),
						  type: "POST",
						  dataType: "html",
						  async: false,
						  success: function(data){
								$("#txt_"+nr[1]+"_"+nr[2]).html(data);
						  }
					});      
			}
		});

	
	});
});     
</script>
<style type="text/css">
<!--
.crij {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
td {
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
select {
	background-color: #FFFFFF;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<h3>Werklijst mosselfeest</h3>
<p>Het aantal X-en geeft weer hoeveel personen er voor die taak nodig zijn.</p>
<p>Klik op <img src="plus.gif" /> om een naam toe te voegen. <b>Gele achtergrond betekent dat we hier nog vrijwilligers zoeken.</b><br />
<p>Klik op <img src="min.gif" /> om een naam toe te verwijderen.</p>
<table >
<tr>
<td>Taak</td>
<td>Aant</td>
<td>11-14 uur</td>
<td>17-20 uur</td>
</tr>
<%
set rsTaken = server.createobject("adodb.recordset")
rsTaken.activeconnection = con

sqlstring = "SELECT * FROM  tblmosselfeesttaken ORDER BY id"
rsTaken.open sqlstring

while not rsTaken.eof%>
	<tr bgcolor="#FFFFFF">
    <td style="font-size:12px;" valign="top" id="taak_<%=rsTaken("id")%>"><%=rsTaken("taak")%></td>
    <td style="font-size:12px;" valign="top">
    <%for i=1 to rsTaken("aantal")%>
    	X<br />
    <%next%>
    </td>
    <%for i = 1 to 2%>
        <td style="font-size:12px;" valign="top" id="txt_<%=rsTaken("id")%>_<%=i%>">
        <%sqlstring = "SELECT naam FROM tblmosselfeesttaakverdeling WHERE taaknr = " & rsTaken("id") & " AND shift = " & i
		rs.open sqlstring
		tel = 0
		while not rs.eof
			tel = tel + 1
			response.Write(rs("naam"))
			if Session("BL_soort") < 4 then
				response.Write("&nbsp;<img src='min.gif' id='img_"&rsTaken("id")&"_"&i&"_"&rs("naam")&"' class='imgMin' />")
			end if
			response.Write("<br>")
        	rs.movenext
		wend
		rs.close
		if tel < rsTaken("aantal") then
			for x = (tel+1) to rsTaken("aantal")%>
			<div style='background-color: #FF0; width:100%'><img src="plus.gif" id="img_<%=rsTaken("id")%>_<%=i%>" class="imgPlus" /></div>
        	<%next
		else%>
        	<img src="plus.gif" id="img_<%=rsTaken("id")%>_<%=i%>" class="imgPlus" />
        <%end if%>
        
        </td>
    <%if rsTaken("id") < 3 then exit for
	next%>
	</tr>
	<%rsTaken.movenext
wend
rsTaken.close%>
</table>

</div>
<%con.Close%>
</BODY>
</HTML>  