<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"-->
<!--#include file="md5.asp" -->
<%
' *** Validate request to log in to this site.
Session("BL_lidid") = ""
Session("BL_username") = ""
Session("BL_soort") = ""


MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Request.QueryString
MM_valUsername=CStr(Request.Form("username"))
If MM_valUsername <> "" Then
  MM_fldUserAuthorization="soort"
  MM_redirectLoginSuccess="berichten.asp"
  MM_redirectLoginFailed="index.asp"
  rs.Source = "SELECT username, password, lidid, blocked, wijzigen, loginaantal "
  If MM_fldUserAuthorization <> "" Then rs.Source = rs.Source & "," & MM_fldUserAuthorization
  rs.Source = rs.Source & " FROM tblUsers WHERE username='" & md5(Replace(MM_valUsername,"'","''")) &"' AND password='" & md5(Replace(Request.Form("password"),"'","''")) & "' AND blocked = FALSE"
  rs.CursorType = 0
  rs.CursorLocation = 2
  rs.LockType = 3
  rs.Open
  If Not rs.EOF Or Not rs.BOF Then 
    ' username and password match - this is a valid user
	Session("BL_lidid") = rs("lidid")
	Session("BL_soort") = rs("soort")
	Session("BL_UN2") = MM_valUsername
	dtm = year(date())&"-"&month(date())&"-"&day(date())&" "&time()
	sqlString = "UPDATE tblUsers SET lastlogin = '"&dtm&"', loginaantal = "&(rs("loginaantal")+1)&" WHERE lidid = " & Session("BL_lidid")
	con.execute sqlString		
	if rs("wijzigen") = 1 then
		rs.Close
		Response.Redirect("changepassword.asp")
	else		
		Session("BL_username") = MM_valUsername
		if CStr(Request.QueryString("accessdenied")) <> "" And true Then
		  MM_redirectLoginSuccess = Request.QueryString("accessdenied")
		End If
		rs.Close
		Response.Redirect(MM_redirectLoginSuccess)
	end if
  End If
  rs.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
%>
<html>
<head>
<title>Basket Lummen - Inloggen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="robots" content="noindex, nofollow"> 
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {font-size: 36px}
-->
</style>
</head>

<body>
<p align="center"><img src="../img/logo2009.gif" alt="Basket Lummen"></p>
<p align="center"><span class="NieuwsTitels style1">Coach 
Corner</span></p>

<form name="inloggen" method="POST" action="<%=MM_LoginAction%>">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Log in met je gebruikersnaam en wachtwoord</td>
	</tr>
  <tr>
	<td>Gebruikersnaam</td> 
    <td><input name="username" type="text" id="username" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
  </tr>
  <tr>
  	<td>Wachtwoord</td> 
    <td><input name="password" type="password" id="password" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
  </tr>
  <tr>
      <td align="center" colspan="2"><input type="submit" name="Submit" value="Inloggen"></td>
  </tr>
</table></td></tr></table>
</form>
<script language="javascript">
  document.inloggen.username.focus();
</script>
</body>
</html>
