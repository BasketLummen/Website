<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3"
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
<title>Basket Lummen - Berichten</title>
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
<h3>Extra activiteiten</h3>
<p>Klik op <img src="confirm.jpg" border="0" width="15" /> om een helper te bevestigen (vergeet hem/haar geen e-mail te sturen).</p>
<p>Klik op <img src="delete.jpg" border="0" width="15" /> om een helper te verwijderen.</p>
<p>Bevestigde helpers zijn in het groen aangeduid, niet bevestigde in het wit en verwijderde in het rood.</p>

  <table border="1" cellspacing="0">
  <tr bgcolor="#FFFFFF"><td>Datum</td><td>Activiteit</td><td>Plaats</td><td>Uren</td><td align="center">Aantal<br>nodig</td></tr>
  <%
  set rs2 = server.createobject("adodb.recordset")
  rs2.activeconnection = con
  sqlstring = "SELECT * FROM tblethiasactiviteiten ORDER BY datum, id"
  rs.open sqlstring
  while not rs.eof
  	%>
  	<tr bgcolor="#FFFF00">
  		<td><%=day(rs("datum"))%>/<%=month(rs("datum"))%></td><td><%=rs("naam")%></td><td><%=rs("plaats")%></td><td><%=rs("uren")%></td><td align="center"><%=rs("aantal")%></td>
    </tr><tr><td></td><td colspan="4"><table border="1" cellspacing="0" width="100%">
  	<%  	sqlstring = "select * from tblethiasdeelnemers where id = "&rs("id")
  	rs2.open sqlstring
	i=1
	while not rs2.eof%>
		<tr bgcolor="#<%if rs2("akkoord") = 1 then
			%>00CC00<%elseif rs2("akkoord") = 0 then
			%>FFFFFF<%elseif rs2("akkoord") = 3 then
			%>FF0000<%end if%>">
        <td><%if rs2("akkoord") < 3 then response.Write(i)%></td>
		<td><%=rs2("naam")%></td>
		<td><%=rs2("rijksregister")%></td>
        <td><%=rs2("gsmnr")%></td>
        <td><%=rs2("email")%></td>
        <td width="15"><%if rs2("akkoord")<>1 then%>
        	<a href="act_bevestig.asp?id=<%=rs2("a_id")%>&antw=1"><img src="confirm.jpg" border="0" width="15" /></a>
        <%end if%>
        </td>
        <td width="15">
        <%if rs2("akkoord")<3 then%>
        <a href="act_bevestig.asp?id=<%=rs2("a_id")%>&antw=3"><img src="delete.jpg" border="0" width="15" /></a>
        <%end if%></td>	
		</tr>
		<%if rs2("akkoord") < 3 then
			i=i+1
		end if
		rs2.movenext
	wend
	rs2.close
	%></table></td></tr><%
	rs.movenext
  wend
  %>
  
  
  </table>


</div>

<%con.Close%>
</BODY>
</HTML>  