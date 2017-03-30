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
  if Session("PR_Username1") <> "Vanstiphout" and Session("PR_Username2") <> "Mike" then
	  Response.Redirect("index.asp")
  else
  	Session("BL_soort") = 0
  end if
End If

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Topschutters ingeven</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	
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
<%if Session("BL_username") <> "" then%>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%end if%>

<p class="NieuwsTitels"><font size="3">Topschutters</font></p>
<p>
	<table width="600" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr align="center">
  	<td bgcolor="#000099" width="125"><a href="topschingeven.asp" class="menuLinks2">Punten ingeven</a></td>
  	<td bgcolor="#000099" width="125"><a href="topschspelertoevoegen.asp" class="menuLinks2">Speler toevoegen</a></td>
  	<td bgcolor="#000099" width="125"><a href="topschspelerwijzigen.asp" class="menuLinks2">Speler wijzigen</a></td>
  </tr>
  </table></p>
  <p align="center">
<form>
<select onChange="location.href=this.value">
	<%for i = 1 to 28%>
		<option value="topschingeven.asp?sd=<%=i%>"<%
			if cint(i) = cint(sd) then
				%> selected<%
			end if
		%>>Speeldag <%=i%></option>
	<%next%>
</select>
</form>
</p>

<%
sd = trim(request("sd"))

sqlString = "SELECT tblTopschSpelers.nummer, naam, voornaam, tblTopschPloegen.ploeg, reeks, speeldag, punten " &_
			"FROM tblTopschPloegen INNER JOIN (tblTopschSpelers INNER JOIN tblTopschPunten ON tblTopschSpelers.nummer = tblTopschPunten.spelerid) ON tblTopschPloegen.ploegid = tblTopschSpelers.ploeg " &_
			"WHERE speeldag = " & sd & " "
if Session("BL_lidid")=185 then 
	sqlString = sqlString & "AND reeks = 'D' "
end if
			sqlString = sqlString & "ORDER BY reeks, tblTopschPloegen.ploeg, naam, voornaam"
rs.open sqlString%>
<%while not rs.eof
	punten = trim(request(rs("nummer")))
	if punten = "" or isnull(punten) then
		punten = "null"
	end if
	sqlString = "UPDATE tblTopschPunten SET punten = " & punten & " WHERE spelerid = " & rs("nummer") & " AND speeldag = " & sd
	con.execute(sqlString) 
	rs.movenext
wend
%>
Punten opgeslagen voor speeldag <%=sd%>.
<p align="center"><a href="../wijzig/menu.asp">Terug naar menu</a></p>
</div>

</body>
</html>
