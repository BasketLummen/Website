<!--#include file="connect2.asp"-->
<%toon=2%>
<html>
<head>
<title>Basket Lummen - Hot News</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript" src="inc/jquery-1.4.2.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function() {
			$('#signup').submit(function() {
				// update user interface
				$('#response').html('E-mailadres toevoegen...');
				
				// Prepare query string and send AJAX request
				$.ajax({
					url: 'inc/store-address.php',
					data: 'ajax=true&email=' + escape($('#email').val()),
					success: function(msg) {
						$('#response').html(msg);
					}
				});
			
				return false;
			});
});
</script>
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
#response {color:#f30; font-style:italic; font-size:inherit; padding:.4em;}
</style>
</head>

<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/nl_NL/sdk.js#xfbml=1&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>




<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top">
<table width="600">
<tr>
  <td><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="kledinglijn.asp" class="NieuwsLinks" target="_blank">Bestelformulier kledinglijn</a></td>
  <td width="50%" align="right"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="http://www.vlaamsebasketballiga.be/src/Frontend/Files/userfiles/files/Dorien/Formulieren/medischgetuigschrift16-17.pdf" class="NieuwsLinks" target="_blank">Medisch getuigschrift</a></td>
</tr>
<tr>
  <td><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="topschutters.asp?reeks=h" class="NieuwsLinks">Topschutters Nat/Land</a></td>
  <td width="50%" align="right"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="verzekeringsformulier.pdf" class="NieuwsLinks" target="_blank">Verzekeringsaangifte formulier</a></td>
</tr>
<tr>
  <td><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="topschutters.asp?reeks=p" class="NieuwsLinks">Topschutters provinciaal</a></td>
</tr>
<tr>
  <td><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="topschutters.asp?reeks=d" class="NieuwsLinks">Topschutters dames</a></td>
</tr>
</table>
 <form id="signup" action="hotnews.asp" method="get">
  <fieldset>
    <legend><b>Schrijf in op onze mailinglijst</b></legend>
      
      <label for="email" id="address-label">E-mailadres
      </label>
      <input type="text" name="email" id="email" width="150" size="50" />
      <input type="submit" name="submit" value="Toevoegen" class="btn" alt="Toevoegen" style="cursor:pointer;cursor:hand;" />
 
      <br>
         <span id="response">
          </span>
<script language="JavaScript" src="http://basketlummen.us2.list-manage2.com/subscriber-count?b=3&u=b9cb977a-e336-41d1-9f10-2d43b2b4d7f6&id=654aac94cd" type="text/javascript"></script>
  </fieldset>
</form> 
<p></p>
<br>

<%	

sqlString =  "SELECT id, datum, onderwerp, nieuws, linktekst, linkurl, venster " &_ 
			 "FROM tblNieuwsLinks RIGHT JOIN tblNieuws ON tblNieuwsLinks.idl = tblNieuws.id " &_ 
			 "ORDER BY datum DESC, id DESC, idl"
	
	rs.open sqlString

	tel=0%>
	<%while not rs.eof and tel < 0
		nrx = rs("id") %>
		<table width="600" cellspacing="0" cellpadding="3" bgcolor="#DDDDDD" class="NieuwsTitels">
			<tr>
				<td class="NieuwsTitels" width="475"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=rs("onderwerp")%></td>
				<td align="right" class="NieuwsTitels"><%=weekdayname(weekday(rs("datum")),true)%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month((rs("datum"))))%></td>
			</tr>
		</table>
		<table width="600" cellspacing="0" cellpadding="3">
			<tr>
				<td width="20"></td>
				<td class="NieuwsTekst"><%=rs("nieuws")%></td>
			</tr>
			<%if rs("linktekst") <> "" then%>
			<tr>
				<td></td>
				<td align="right">
				<%while rs("id") = nrx %>
					<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> 
					<%if rs("venster")=2 then
							'als de link in een nieuw venster moet openen
							%><a href="<%=rs("linkurl")%>" class="NieuwsLinks" target="_blank"><%
					elseif rs("venster")=1 then
						%><a href="#" onClick="window.open('<%=rs("linkurl")%>','','width=750,height=600,scrollbars=yes,resizable=yes');return(false)" class="NieuwsLinks"><%
					else
							%><a href="<%=rs("linkurl")%>" class="NieuwsLinks"><%
					end if%>
						<%=rs("linktekst")%></a>
					<%rs.movenext
				wend%>
				</td>
			</tr>
			<%else
				rs.movenext
			end if
			tel=tel+1 %>
		</table>
		<p></p>
	<%wend	
	rs.close
	set rs=nothing%>
	</td>
        <td width="250" valign="top">			
			
		
		
		
		
		</td>
      </tr>
    </table>
    <table width="100%"><tr><td width="50%" valign="top">
<div class="fb-like-box" data-href="https://www.facebook.com/basketlummen" data-width="800px" data-height="600px" data-colorscheme="light" data-show-faces="true" data-header="true" data-stream="true" data-show-border="true"></div></td>
<td width="50%" valign="top"> <a class="twitter-timeline" href="https://twitter.com/basketlummen" data-widget-id="648941003051790337">Tweets door @basketlummen</a> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script> </td></tr></table>

</div>
</body>
</html>
