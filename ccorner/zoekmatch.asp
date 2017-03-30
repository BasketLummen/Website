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
<title>Basket Lummen - Kalender</title>
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

<form merthod="post" action="wijziguitslag.asp" name="wedstrijd">
<table bgcolor="#FFFF00" align="center"><tr><td>
  <table cellspacing="0" cellpadding="5" class="algklassement" width="100%">
    <tr bgcolor="#000099">
	  <td class="algklassementT" align="center" colspan="2">Uitslag wijzigen:</td>
	</tr>
  	<tr bgcolor="#FFFFFF">
     	<td>Matchnr:</td>
		<td><input name="matchnr" type="text" id="matchnr"></td>
	</tr>
	<tr bgcolor="#000099">
	    <td colspan="2" align="center"><input name="zoek" type="submit" value="Zoek"></td>
	</tr>
	</table></td></tr></table>
  </form>
  <script language="javascript">
  document.wedstrijd.matchnr.focus();
</script>
</div>
</body>
</html>
