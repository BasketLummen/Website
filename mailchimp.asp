<%toon=0%>
<html>
<head>
<title>Basket Lummen - Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="SHORTCUT ICON" href="http://www.basketlummen.be/favicon.ico" />
<SCRIPT type="text/javascript" src="inc\jquery-1.4.2.js"></SCRIPT>
<SCRIPT type="text/javascript" src="inc\jquery-blink.js"></SCRIPT>
<SCRIPT type="text/javascript">
$(document).ready(function()
{
	$('.blink').blink(); // default is 500ms blink interval.
        //$('.blink').blink({delay:100}); // causes a 100ms blink interval.
});


</script>
<link href="opmaak.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style14 {font-size: 18px}
.style17 {font-size: 24px}
-->
</style>

</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:861px; z-index:1; left: 120px; top: 70px;">


 <%
 Dim email
Dim apikey
Dim listId
Dim resp

email = "jjpeetersjj@telenet.be" ' Trim(Request.Form("email"))
listId = "654aac94cd"
apikey = "947c03f2596cdd9c69b9b8b1a3291006-us2"

Dim xmlhttp
Set xmlhttp = Server.Createobject("MSXML2.ServerXMLHTTP")
xmlhttp.Open "GET","http://api.mailchimp.com/1.2/?method=listsubscribe&output=xml&apikey=" & apikey & "&id=" & list_id & "&email=" & Server.URLEncode(email) & "&merge_vars=",false
xmlhttp.send
resp = xmlhttp.responsetext
Set xmlhttp = Nothing
'response.Redirect("hotnews.asp")

 %>
 
 
</div>
</div>


</body>


</html>
