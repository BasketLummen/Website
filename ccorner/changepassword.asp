<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
MM_authFailedURL="index.asp.asp"
MM_grantAccess=false
If Session("BL_lidid") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%>
<!--#include file="connect.asp"-->
<!--#include file="md5.asp" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Verander wachtwoord</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
'opslaan nieuw wachtwoord
oudpassword = trim(request.form("oudpassword"))
password1 = trim(request.form("password1"))
password2 = trim(request.form("password2"))
if oudpassword <> "" and password1 <> "" and password2 <> "" then
	if password1 = password2 then
		sqlString = "SELECT password FROM tblUsers WHERE lidid = " & Session("BL_lidid")
		rs.open sqlString
		if rs("password") = md5(oudpassword) then
		
			sqlString = "UPDATE tblUsers SET password = '" & md5(password1) & "', " &_ 
						  " wijzigen = 0 WHERE lidid = " & Session("BL_lidid")
			con.execute sqlString
			
			rs.close
			if Session("BL_username") = "" then
				Session("BL_username") = Session("BL_UN2")
				Session("BL_UN2") = ""
			end if
			response.Redirect("berichten.asp")
		else
			response.Write("<h3>Uw oude wachtwoord is fout.</h3>")
			rs.close
		end if
	else
		response.Write("<h3>Uw wachtwoord komt niet overeen, probeer opnieuw.</h3>")
	end if
end if


%>


<form name="verander" method="POST" action="changepassword.asp">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Verander uw wachtwoord</td>
	</tr>
  <tr>
	<td>Oud wachtwoord</td> 
    <td><input name="oudpassword" type="password" id="oudpassword" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
  </tr>
  <tr>
  	<td>Nieuw wachtwoord</td> 
    <td><input name="password1" type="password" id="password1" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
  </tr>
  <tr>
  	<td>Herhaal wachtwoord</td> 
    <td><input name="password2" type="password" id="password2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
  </tr>
  <tr>
      <td align="center" colspan="2"><input type="submit" name="Submit" value="Verander"></td>
  </tr>
</table></td></tr></table>
</form>
<script language="javascript">
  document.verander.oudpassword.focus();
</script>
</div>
</body>
</html>
