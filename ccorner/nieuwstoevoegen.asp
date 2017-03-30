<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"--><%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authorizedUsers2="26,693"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1)  Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If
%>
<html>
<head>
<title>Basket Lummen - Nieuws Toevoegen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

<form method="post" action="nieuwsbeheer.asp" name="nieuws">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Nieuws toevoegen</td>
	</tr>
    <tr>
      <td>Datum:</td>
      <td colspan="2"><input name="frmDatum" type="text" id="frmDatum" value="<%=date()%>"></td>
    </tr>

    <tr>
      <td valign="top">Onderwerp</td>
      <td colspan="4"><input name="onderwerp" type="text" id="onderwerp" tabindex="2" size="40"></td>
    </tr>
    <tr> 
      <td valign="top">Nieuws:</td>
      <td colspan="4"><textarea name="frmNieuws" cols="100" rows="10" id="frmNieuws" tabindex="3"></textarea></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td width="35%" align="center">Link (onderaan het bericht)</td>
      <td width="46%" align="center" colspan="2">URL</td>
      <td width="11%" align="center">NV - PO </td>
    </tr>
    <tr> 
      <td align="right">1:</td>
      <td><input name="frmLink1" type="text" size="40" tabindex="4"></td>
      <td colspan="2"><input name="frmURL1" type="text" value="http://www.basketlummen.be/" size="70" tabindex="5"></td>
      <td align="center" nowrap> <input type="checkbox" name="frmNVenster1" value="checkbox"> - <input type="checkbox" name="frmPopup1" value="checkbox"></td>
    </tr>
    <tr> 
      <td align="right"> 2:</td>
      <td><input name="frmLink2" type="text" size="40" tabindex="6"></td>
      <td colspan="2"><input name="frmURL2" type="text" value="http://www.basketlummen.be/" size="70" tabindex="7"></td>
      <td align="center" nowrap> <input type="checkbox" name="frmNVenster2" value="checkbox"> - <input type="checkbox" name="frmPopup2" value="checkbox"></td>
    </tr>
    <tr> 
      <td align="right"> 3:</td>
      <td><input name="frmLink3" type="text" size="40" tabindex="9"></td>
      <td colspan="2"><input name="frmURL3" type="text" value="http://www.basketlummen.be/" size="70" tabindex="10"></td>
      <td align="center" nowrap> <input type="checkbox" name="frmNVenster3" value="checkbox" tabindex="11"> - <input type="checkbox" name="frmPopup3" value="checkbox"></td>
    </tr>
    <tr> 
      <td align="right"> 4:</td>
      <td> <input name="frmLink4" type="text" size="40" tabindex="12"> </td>
      <td colspan="2"><input name="frmURL4" type="text" value="http://www.basketlummen.be/" size="70" tabindex="13"></td>
      <td align="center" nowrap> <input type="checkbox" name="frmNVenster4" value="checkbox" tabindex="14"> - <input type="checkbox" name="frmPopup4" value="checkbox"></td>
    </tr>
    <tr> 
      <td align="right"> 5:</td>
      <td><input name="frmLink5" type="text" size="40" tabindex="15"></td>
      <td colspan="2"><input name="frmURL5" type="text" value="http://www.basketlummen.be/" size="70" tabindex="16"></td>
      <td align="center" nowrap> <input type="checkbox" name="frmNVenster5" value="checkbox" tabindex="17"> - <input type="checkbox" name="frmPopup5" value="checkbox"></td>
    </tr>
	<tr>
      <td align="center"colspan="5"><input type="submit" value="toevoegen" tabindex="2"></td>
 	</tr>
  </table>
<input type="hidden" name="toevoegen" value="1">

</form>
<script language="javascript">
  document.nieuws.onderwerp.focus();
</script>
</div>

</body>
</html>
