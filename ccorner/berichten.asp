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
<title>Basket Lummen - Berichten</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.crij {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">
<%
soort = trim(request("soort"))

if soort = "verzonden" then
	sqlString = "SELECT berichtid, datum, bericht, naam, voornaam " &_
			"FROM tblberichten " &_
			"INNER JOIN tblLeden ON tblberichten.auteur = tblLeden.id " &_
			"WHERE auteur=" & session("BL_lidid") &_
			" ORDER BY datum DESC LIMIT 0, 20"
			%>
	<p class="NieuwsTitels"><font size="3">Verzonden berichten</font></p>
<%else
	sqlString = "SELECT tblberichten.berichtid, datum, bericht, naam, voornaam " &_
			"FROM tblberichten " &_
			"INNER JOIN tblBerichtenUsers ON tblberichten.berichtid = tblBerichtenUsers.berichtid " &_
			"INNER JOIN tblleden ON tblberichten.auteur = tblleden.id " &_
			"WHERE tblBerichtenUsers.userid=" & session("BL_lidid") &_
			" ORDER BY datum DESC"
			%>
	<p class="NieuwsTitels"><font size="3">Ontvangen berichten</font></p>
<%end if
rs.Open sqlString%>

<table>
<%while not rs.EOF%>
	<tr><td class="crij"><p><%=rs("bericht")%></p>
	<p class="crij"><i>geplaatst door <%=rs("voornaam")%>&nbsp;<%=rs("naam")%>, <%=rs("datum")%></i></p></td><%
	if soort = "verzonden" then%>
		<td valign="top" class="crij"><img src="../img/delete.gif" border="0" alt="bericht verwijderen" onClick="if(confirm('Bent u zeker dat u dit bericht wilt verwijderen?',false))document.location='berichtverwijderen.asp?id=<%=rs("berichtid")%>';" style="cursor:hand;cursor:pointer;"></td></tr>
		<%Set rs1 = Server.CreateObject("ADODB.Recordset")
		rs1.activeconnection = con
		gelezen = ""
		nietgelezen = ""

		sqlstring = "SELECT naam, voornaam, lastlogin, berichtid " &_
					"FROM tblBerichtenUsers " &_
					"INNER JOIN (tblLeden INNER JOIN tblUsers ON tblleden.id = tblUsers.lidid) " &_
					"ON tblBerichtenUsers.userid = tblLeden.id " &_
					"GROUP BY tblleden.naam, tblleden.voornaam, tblBerichtenUsers.berichtid " &_
				 	"HAVING tblBerichtenUsers.berichtid="&rs("berichtid") &_
					" ORDER BY naam, voornaam"
		rs1.Open sqlstring
		while not rs1.EOF
			if rs1("lastlogin") < rs("datum") then
				nietgelezen = nietgelezen & rs1("voornaam") & " " &rs1("naam") & ", "
			else
				gelezen = gelezen & rs1("voornaam") & " " &rs1("naam")& ", "
			end if
			rs1.MoveNext
		wend
		rs1.Close%>
		<tr><td colspan="2" class="crij">
		<%if nietgelezen <> "" then
			%><b>nog niet gelezen: <%=left(nietgelezen,len(nietgelezen)-2)%></b><br /><%
		end if
		if gelezen <> "" then
			%>gelezen: <%=left(gelezen,len(gelezen)-2)%><%
		end if%>
		</td>
	<%end if%>
	</tr>
	<tr><td colspan="2"><hr width="600px" /></td></tr>
	<%rs.MoveNext
wend


rs.Close

%></table></div>

<!--#include file="kalender.asp"-->
<%con.Close%>
</BODY>
</HTML>  