<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"--><%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authorizedUsers2="26"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1)  Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If
%>
<html>
<head>
<title>Basket Lummen - Nieuws Wijzigen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jquery-1.3.2.min.js"></script> 
<script type="text/javascript" src="jquery.editableText.js"></script> 
<script type="text/javascript">
$(document).ready(function() {
$('h1.editableText, p.editableText').editableText({
	newlinesEnabled: true
});

$.editableText.defaults.newlinesEnabled = true;

$('div.editableText').editableText();

$('.editableText').change(function(){
	var newValue = $(this).html();
});
});     
</script>

<style type="text/css">
<!--
table {
	background-color: #CCCCCC;
}
.editableText {
	min-height: 20px;
}
.editableText:hover {
	outline: 1px dashed grey;
}
.editableToolbar:hover + * {
	outline: 1px dashed grey;
}
.editableToolbar {
}
.editableToolbar a{
    display: block;
    width: 17px;
    height: 15px;
    float: right;
    margin: 2px;
}
.editableToolbar .edit {	
	background: url("icons.png");
}
.editableToolbar .save {
    background: url("icons.png") -16px 0;
}
.editableToolbar .cancel {
    background: url("icons.png") 25px 0;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">
<%

strDatum = Request("frmDatum")

sqlString =  "SELECT * FROM tblNieuws ORDER BY datum DESC, id DESC LIMIT 0,30"

rs.open sqlString

%>
	
<table align="center">

  	<%
	while not rs.EOF
		tel = tel + 1%>		
		<tr bgcolor="#FFFFFF" onMouseOver="style.backgroundColor='#FFFF66';" onMouseOut="style.backgroundColor='#FFFFFF'">
			<td valign="top"><%=day(rs("datum"))%>/<%=month(rs("datum"))%>/<%=year(rs("datum"))%></td>
			<td valign="top"><%=rs("onderwerp")%></td>
			<td><p class="editableText"><%=rs("nieuws")%></p></td>
            <td valign="top"><a href="nieuwsgegevens.asp?wijzigen=1&nr=<%=rs("id")%>">wijzig</a></td>
            <%if Session("BL_soort") < 3 then%>
                <td valign="top"><a href="#" onClick="if(confirm('Bent u zeker dat u dit nieuwsbericht wilt verwijderen?',false))document.location='nieuwsbeheer.asp?wijzigen=2&nr=<%=rs("id")%>'">verwijderen</a></td>
            <%end if%>
		</tr>
		<%rs.movenext
	wend
%>
	
</table>

</form>
	
<%

rs.close
con.close
%></div>

</body>
</html>
