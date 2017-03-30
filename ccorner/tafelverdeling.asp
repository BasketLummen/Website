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
<title>Basket Lummen - Tafelverdeling</title>
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
seizoen = "1415"
ploeg = trim(request("ploeg"))
if isnull(ploeg) or ploeg = "" then ploeg = 14383111

sqlstring = "SELECT kalcode, ploegnaam FROM tblploegen WHERE actief = 1 ORDER BY ploegid"
rs.open sqlstring%>
<form name="jump">
    <p>Ploeg <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
    <%while not rs.eof%>
        <option value="tafelverdeling.asp?ploeg=<%=rs("kalcode")%>"<%
        if int(ploeg) = rs("kalcode") then
            %> selected="selected"<%
        end if
        %>><%=rs("ploegnaam")%></option>
        <%rs.movenext
    wend
    rs.close%>
    </select></p>
</form>
<%
sqlString = "Select wedstrijd_id, datum, opm, tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl, " &_ 
			"thuisploeg, uitploeg, klok, feuille, 24sec, delege " &_
			"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1 " &_
			"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_
			"AND (thuisploeg = " & ploeg & " OR uitploeg = " & ploeg & ") ORDER BY -datum DESC"

rs.open sqlString


if rs.eof then
	%><p>Geen wedstrijden.</p><%
else
	%>
    <form method="post" action="tafelverdelingopslaan.asp?ploeg=<%=ploeg%>">
	<table cellspacing=0 border="1" align="center">
		<tr> 
            <th colspan="2">datum</th>
            <th width="50">uur</th>
            <th colspan="2">Wedstrijd</th>
            <th>Klok</th>
            <th>Feuille</th>
            <th>24 seconden</th>
            <th>Delegé</th>
          </tr>
    
	<%while not rs.eof%>
	   <tr>
		<td width="20" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=WeekDayName(WeekDay(rs("datum")),true)%>
			<%else%>
				&nbsp;
			<%end if%>
		 </td>
		<td width="40" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=day(rs("datum"))%>/<%=month(rs("datum"))%>
			<%else%>
				&nbsp;
			<%end if%>
		 </td>
		<td width="50" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=FormatDateTime(rs("datum"),4)%>
			<%else%>
				&nbsp;
			<%end if%>
		</td>
		<td nowrap><%=rs("thuispl")%></td><td nowrap><%=rs("uitpl")%>
			<%if not isnull(rs("opm")) then%>
				<span class="beker">(<%=rs("opm")%>)</span>
			<%end if%>
		</td>
        <%if rs("thuisploeg") = int(ploeg) then%>
            <td><input type="text" name="klok_<%=rs("wedstrijd_id")%>" value="<%=rs("klok")%>" /></td>
            <td align="center">n.v.t.</td>
            <td><input type="text" name="24sec_<%=rs("wedstrijd_id")%>" value="<%=rs("24sec")%>" /></td>
        <%else%>
            <td align="center">n.v.t.</td>
            <td><input type="text" name="feuille_<%=rs("wedstrijd_id")%>" value="<%=rs("feuille")%>" /></td>
            <td align="center">n.v.t.</td>
        <%end if%>
        <td><input type="text" name="delege_<%=rs("wedstrijd_id")%>" value="<%=rs("delege")%>" /></td>
	  </tr>
      <%rs.movenext
	wend%>
    </table>
    <input type="submit" value="Opslaan" />
	</form>
<%end if
rs.close
con.Close%>
</div>
</BODY>
</HTML>  