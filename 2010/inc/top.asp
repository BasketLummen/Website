<!--#include file="connect.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Basket Lummen | <%=titel%></title>
<link type="text/css" href="inc/jquery-ui-custom.css" rel="stylesheet" />
<link type="text/css" href="inc/opmaak.css" rel="stylesheet" />
<script type="text/javascript" src="inc/jquery.js"></script>
<script type="text/javascript" src="inc/jquery-ui.js"></script>
<script type="text/javascript" src="inc/functies.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#sortable").sortable();
	$("#sortable").disableSelection();
	$("#accordion1").accordion({'autoHeight': false});
	$("#accordion2").accordion({'autoHeight': false});
	$("#accordion3").accordion({'autoHeight': false});
	$("#accordion4").accordion({'autoHeight': false});
});
</script>
	<style type="text/css">
	#sortable { list-style-type: none; margin: 0; padding: 0; }
	#sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 100px; height: 90px; font-size: 10px; text-align: center; }
	</style>

</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td>&nbsp;</td>
<td width="975" bgcolor="#FFFFFF" valign="top">
    <table width="100%" cellspacing="0" cellpadding="0">
    <tr><td colspan="20">
        <table width="100%">
        <tr>
          <td><a href="index.asp"><img src="img/basketlummenlogo_tekst.jpg" border="0"/></a></td>
          <td></td>
          <td align="right" valign="top"><%=titel%></td>
        </tr>
        </table>
    </td></tr>
    <tr>
    <td width="15" class="menubalk_links">&nbsp;</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'" onclick="document.location='clubinfo.asp'">Clubinfo</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Nieuws</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Ploegen</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Pronostiek</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Fotoalbum</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Activiteiten</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Verjaardagen</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Gastenboek</td>
    <td class="menubalk">|</td>
    <td width="10%" class="menubalk" onmouseover="this.className='menubalk_over'" onmouseout="this.className='menubalk'">Links</td>
    <td width="15" class="menubalk_rechts">&nbsp;</td>
    </tr>