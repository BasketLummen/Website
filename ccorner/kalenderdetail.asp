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
<title>Basket Lummen - Kalender</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, input {
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
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 650px;">

<%
id = trim(request("id"))
Set rs = Server.CreateObject("ADODB.Recordset")
rs.activeconnection = con


sqlString = "SELECT tblkalender.kalid, datum, onderwerp, plaats, opmerkingen " &_
			"FROM tblkalender INNER JOIN tblkalenderusers ON tblkalender.kalid = tblkalenderusers.kalid " &_
			"WHERE tblkalenderUsers.userid=" & session("BL_lidid") &_
			" AND tblkalender.kalid = " & id
rs.Open sqlString%>

<%if not rs.EOF then%>
	<p class="NieuwsTitels"><font size="3"><%=rs("onderwerp")%></font></p>
<table>
	<tr>
		<td><%=weekdayname(weekday(rs("datum")),true)%>&nbsp;
		<%=day(rs("datum"))%>/<%=month(rs("datum"))%>, 
		<%=FormatDateTime(rs("datum"),vbshorttime)%></td>
	</tr>
	<tr>
		<td><p><i>Locatie: <%=rs("plaats")%></i></p>
		<p><%=rs("opmerkingen")%></p>
		<%
		sqlString = "SELECT naam, voornaam, kalid " &_
					"FROM tblkalenderusers INNER JOIN tblLeden ON tblkalenderusers.userid = tblLeden.id " &_
					"WHERE tblkalenderusers.kalid=" & rs("kalid")
		rs.close
		rs.Open sqlString
		%>
		<p><i>Uitgenodigd:
		<%while not rs.eof%>
		   <%=rs("voornaam")%>&nbsp;<%=rs("naam")%>,
			<%rs.movenext
		wend%></i></p>
		</td>
	</tr></table>
	<%
end if


rs.Close

%>
</div>
<!--#include file="kalender.asp"-->
<%con.Close%>
</BODY>
</HTML>  