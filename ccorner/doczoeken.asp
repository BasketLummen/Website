<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4"
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

%><!--#include file="connect.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Coach Corner</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, input, select {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #FFFFFF;
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
<!--#include file="cmenu.asp"-->
<!--#include file="menudocumenten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 175px; top: 40px; width: 800px;">
<p class="NieuwsTitels"><font size="3">Document zoeken</font></p>

<%
docnaam = trim(request.form("docnaam"))
sqlString = "SELECT docid, docsoort, docnaam, doctype, docsize, datum, naam, voornaam " &_
		"FROM tbldocumenten, tblleden WHERE id = auteur AND docnaam LIKE '%" & docnaam & "%' " 
if Session("BL_soort") > 3 then
		sqlString = sqlString & "AND docsoort < 1000 "
end if		
sqlString = sqlString & "ORDER BY docnaam DESC"
rs.open sqlString%>
	
	<table width="100%">
		<tr>
			<th>&nbsp;</th>
			<th>Document</th>
			<th>Grootte</th>
			<th>Datum</th>
			<th>Geüpload door</th>
		</tr>
	<%
	while not rs.eof%>
		<tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#FFFFFF'" style="cursor:hand;cursor:pointer;" bgcolor="#FFFFFF">
			<td  onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<img src="../img/<%=replace(replace(rs("doctype"),"application/",""),"image/","")%>.gif" />
			</td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<b><%=rs("docnaam")%></b></td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<%=rs("docsize")%></td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<%=rs("datum")%></td>
			<td onclick="window.open('download.asp?id=<%=rs("docid")%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">
			<%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
			<%if session("BL_soort") < 3 then%>
			<td align="center" onmouseover="style.backgroundColor='#FF0000';" onmouseout="style.backgroundColor=''" onClick="if(confirm('Bent u zeker dat u <%=rs("docnaam")%> wilt verwijderen?',false))document.location='docverwijderen.asp?id=<%=rs("docid")%>';">
			<img src="../img/delete.gif" alt="Verwijderen" border="0"></td>
			<%end if%>
		</tr>
		<%rs.movenext
	wend
	rs.close
	con.close
	%>
	</table>
<p><form name="zoek" action="doczoeken.asp" method="post">
<img src="../img/zoek.gif" /> <input type="text" name="docnaam" />  <input type="submit" value="zoeken" class="submitbutton" />
</form>

</p>


</div>

</body>
</html>
