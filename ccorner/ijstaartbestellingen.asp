<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Ijstaarten</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
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
<h3>Bestellingen ijstaarten</h3>
<table>
<tr>
<th nowrap="nowrap">Volgnr</th>
<th nowrap="nowrap">Naam</th>
<th nowrap="nowrap">Via</th>
<th nowrap="nowrap">Telnr</th>
<th nowrap="nowrap" align="center">1</th>
<th nowrap="nowrap" align="center">2</th>
<th nowrap="nowrap" align="center">3</th>
<th nowrap="nowrap" align="center">4</th>
<th nowrap="nowrap" align="center">5</th>
<th nowrap="nowrap" align="center">6</th>
<th nowrap="nowrap" align="center">8</th>
<th nowrap="nowrap" align="center">9</th>
<th nowrap="nowrap" align="center">10</th>
<th nowrap="nowrap" align="center">11</th>
<th nowrap="nowrap" align="center">12</th>
<th nowrap="nowrap" align="center">13</th>
<th nowrap="nowrap" align="center">14</th>
<th nowrap="nowrap" align="center">15</th>
<th nowrap="nowrap" align="center">16</th>
<th nowrap="nowrap" align="center">17</th>
<th nowrap="nowrap" align="center">18</th>
<th nowrap="nowrap" align="center">19</th>
<th nowrap="nowrap" align="center">Bedrag</th>
<th nowrap="nowrap" align="center">Betaald</th>
</tr>

<%sqlstring = "SELECT * FROM tblIjstaarten"
rs.open sqlstring
while not rs.eof%>
    <tr bgcolor="#FFFFFF">
        <td valign="top"><%=rs("id")%></td>
        <td valign="top"><%=rs("naam")%></td>
        <td valign="top"><%=rs("via")%></td>
        <td valign="top"><%=rs("telnr")%></td>
        <td valign="top"><%=rs("ijs01")%></td>
        <td valign="top"><%=rs("ijs02")%></td>
        <td valign="top"><%=rs("ijs03")%></td>
        <td valign="top"><%=rs("ijs04")%></td>
        <td valign="top"><%=rs("ijs05")%></td>
        <td valign="top"><%=rs("ijs06")%></td>
        <td valign="top"><%=rs("ijs08")%></td>
        <td valign="top"><%=rs("ijs09")%></td>
        <td valign="top"><%=rs("ijs10")%></td>
        <td valign="top"><%=rs("ijs11")%></td>
        <td valign="top"><%=rs("ijs12")%></td>
        <td valign="top"><%=rs("ijs13")%></td>
        <td valign="top"><%=rs("ijs14")%></td>
        <td valign="top"><%=rs("ijs15")%></td>
        <td valign="top"><%=rs("ijs16")%></td>
        <td valign="top"><%=rs("ijs17")%></td>
        <td valign="top"><%=rs("ijs18")%></td>
        <td valign="top"><%=rs("ijs19")%></td>
        <td valign="top"><%=(((cint(rs("ijs02"))+cint(rs("ijs03")))*7)+((cint(rs("ijs01"))+cint(rs("ijs06"))+cint(rs("ijs16"))+cint(rs("ijs17"))+cint(rs("ijs18")))*8.5)+(cint(rs("ijs19"))*9)+((cint(rs("ijs14"))+cint(rs("ijs15")))*10.5)+(cint(rs("ijs05"))*14)+(cint(rs("ijs04"))*14.5)+((cint(rs("ijs11"))+cint(rs("ijs12")))*15)+((cint(rs("ijs09"))+cint(rs("ijs10"))+cint(rs("ijs13")))*20)+(cint(rs("ijs08"))*30))%></td>
          <td valign="top"><%
		if rs("betaald") = 1 then
			response.Write("OK")
		end if
		%></td>
	</tr>
	<%rs.movenext
wend
rs.close%>

</table>

</div>

<%con.Close%>
</BODY>
</HTML>  