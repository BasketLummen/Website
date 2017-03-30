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

wedstrijdnr = request("wedstrijdnr")

sqlString = "UPDATE tbllivewedstrijden SET live = 0"
con.execute sqlstring
sqlString = "UPDATE tbllivewedstrijden SET live = 1 WHERE wedstrijdnr = " & wedstrijdnr
con.execute sqlstring
Session("wedstrijdnr") = wedstrijdnr

sqlstring = "SELECT * FROM tbllivewedstrijden WHERE wedstrijdnr = " & wedstrijdnr
rs.open sqlString
%>
<p class="NieuwsTitels"><font size="3"><%=rs("thuisploeg")%>&nbsp;-&nbsp;<%=rs("uitploeg")%></font></p>
<input type="button" id="stoppen" value="Live verslag stoppen" />
<%rs.close
sqlstring = "SELECT * FROM tbllivecomment WHERE wedstrijd = " & wedstrijdnr & " ORDER BY id DESC"
rs.open sqlString
%>
<table id="livetabel">
<thead>
<tr><td><textarea id="bericht" rows="5" cols="75"></textarea></td></tr>
</thead>
<tbody>
<%while not rs.eof%>
	<tr id="tr<%=rs("id")%>" bgcolor="#FFFFFF"><td><%=rs("commentaar")%></td><td valign="top"><input type="button" id="<%=rs("id")%>" value="verwijderen" class="clsVerwijderen" /></td></tr>
	<%rs.movenext
wend%>
</tbody>
</table>