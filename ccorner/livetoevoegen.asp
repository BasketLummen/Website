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

bericht = request("bericht")
bericht = Replace(bericht, chr(13) & chr(10), "<br>")
bericht = Replace(bericht, "'", "´")

sqlString = "INSERT INTO tbllivecomment(wedstrijd,commentaar) VALUES("&Session("wedstrijdnr")&",'"&bericht&"')"
con.execute sqlstring
sqlString = "SELECT id FROM tbllivecomment WHERE id = LAST_INSERT_ID()" 
rs.open sqlString
%>
<tr bgcolor="#FFFFFF"><td><%=bericht%></td><td valign="top"><input type="button" id="<%=rs("id")%>" value="verwijderen" class="clsVerwijderen" /></td></tr>
<%rs.close
con.close%>