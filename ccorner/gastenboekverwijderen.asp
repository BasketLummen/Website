<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
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
<title>Basket Lummen - Gastenboek berichten verwijderen</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">

<p class="NieuwsTitels"><font size="3">Gastenboek</font></p>
<p>U kan een bericht verwijderen door op het rode kruisje naast het bericht te klikken. Berichten die in het rood zijn aangeduid zijn reeds verwijderd.<p>
<%

id = trim(request.QueryString("id"))

if id <> "" and not isnull("id") then
	sqlString = "UPDATE tblgastenboek SET verwijderd = 1, verwdoor = " & Session("BL_lidid") & " WHERE id = " & id
	con.execute sqlString
end if


sqlString = "SELECT id, naam, email, ip, datum, bericht, verwijderd FROM tblgastenboek ORDER BY datum DESC"
rs.open sqlString
while not rs.eof
	if rs("verwijderd") = true then
		kleur = "#FF0000"
	else
		kleur = "#DDDDDD"
	end if%>
<table width='600' cellspacing='0' cellpadding='3' bgcolor='<%
	if rs("verwijderd") = 0 then
		%>#DDDDDD<%
	else
		%>#FF0000<%
	end if
 	%>' class='NieuwsTitels'>
<tr>
<td class='NieuwsTitels'><img src='img/driehoek_rood.gif' width='5' height='9' border='0'> 
		<%=rs("naam")%>
	</td>
	<td align='right' class='NieuwsTitels'><%=weekdayname(weekday(rs("datum")),true)%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")))%>&nbsp;<%=year(rs("datum"))%>&nbsp;(<%=right(rs("datum"),8)%>)</td>
	<td width="20">
	<%if rs("verwijderd") = false then%>
	<img src="../img/delete.gif" border="0" alt="bericht verwijderen" onClick="if(confirm('Bent u zeker dat u dit bericht wilt verwijderen?',false))document.location='gastenboekverwijderen.asp?id=<%=rs("id")%>';" style="cursor:hand;cursor:pointer;" />
	<%end if%></td>
	</tr></table>
	<table width='600' cellspacing='0' cellpadding='3'>
<tr><td width='20'></td><td class='NieuwsTekst'>
	<font size="1">E-mail: <%=rs("email")%>, IP-adres: <%=rs("ip")%></font><br />
	<%=rs("bericht")%></td></tr></table><p></p>
	<%rs.movenext
wend
rs.close
con.close%>
</div>
</body>
</html>
