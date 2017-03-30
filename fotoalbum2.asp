<!--#include file="connect.asp"-->
<%
reeks=trim(request("reeks"))
nr=trim(request("nr"))
if isnull(nr) or nr = "" then nr = 1
nr = int(nr)
set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con
%>
<%toon=5%>
<html>
<head>
<title>Basket Lummen - Fotoalbum</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="ccorner/jquery-1.4.2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var title = new Array();
	var url = new Array();
	var img = new Array();
	$.ajax({
		type: "GET",
		url: "xml/photobucket.php",
		dataType: "xml",
		success: function(xml) {
			$(xml).find('item').each(function(){
				title.push($(this).find('title').text());
				url.push($(this).find('media\\:thumbnail').attr('url'));
				img.push($(this).find('enclosure').attr('url'));
			});
			title.reverse();
			url.reverse();
			img.reverse();
			tabelhoofd = toon_menu();
			toon_fotos(0);			
		}
	});
	$(".NieuwsLinks").live("click", function() {
		toon_fotos(parseInt($(this).attr("id"))) ;
	});
	
	$(".clsFoto").live("click", function() {
		toon_groot(parseInt($(this).attr("id"))) ;
	});

	$(".clsNav").live("click", function() {
		toon_groot(parseInt($(this).attr("id"))) ;
	});
	
	function toon_fotos(deel) {
		uitvoer = tabelhoofd;
		uitvoer = uitvoer + toon_info(deel);
		for(i=(deel*12);i<((deel+1)*12);i++) {
			if(!(i%2)) {uitvoer = uitvoer + "<tr>"};
			if(i<title.length) {uitvoer = uitvoer + "<td><img src='"+url[i]+"' alt='"+title[i]+"' border='0' id='"+i+"' style='cursor:hand;cursor:pointer' class='clsFoto' /></td>";};
			if(i%2) {uitvoer = uitvoer + "</tr>"};
		};
		uitvoer = uitvoer + "</table>";
		$("#Layer3").html(uitvoer);
	}

	function toon_menu() {
		tabel = "<table width='600' border='0' align='center' cellspacing='0' cellpadding='3' style='border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;'><tr bgcolor='#DDDDDD'><td nowrap align='center' class=NieuwsTitels colspan='4'><img src='img/driehoek_rood.gif' width='5' height='9' border='0'> Peanutstornooi (11 november 2010)</td></tr><tr bgcolor='#DDDDDD'><td style='border-top: 1px solid #000099;' colspan='4' align='center'>";
 		for(i=1;i<=(title.length/12);i++) {
			tabel = tabel + "<a href='#' class='NieuwsLinks' id='"+(i-1)+"'>"+((i*12)-11)+"-"+(i*12)+"</a> | ";
		}
		tabel = tabel + "<a href='#' class='NieuwsLinks' id='"+(i-1)+"'>"+((i*12)-11)+"-"+title.length+"</a></td></tr>";
		return tabel;
	}

	function toon_info(deel) {
		tabel = "<tr bgcolor='#DDDDDD'><td style='border-top: 1px solid #000099;' colspan='4'><table width='100%'><tr><td align='left' width='33%'>"
		if(deel>0) {
			tabel = tabel + "<img src='img/vorige.gif' border='0' alt='vorige' class='NieuwsLinks' id='"+(deel-1)+"' style='cursor:hand;cursor:pointer'>"
		}
		tabel = tabel +"</td><td align='center' width='33%'>Foto\'s "+((deel*12)+1)+" t/e/m "+((deel*12)+12)+" van "+title.length+"<td align='right' width='33%'>";
		if((deel+1)*12<title.length) {
			tabel = tabel + "<img src='img/volgende.gif' border='0' alt='volgende' class='NieuwsLinks' id='"+(deel+1)+"' style='cursor:hand;cursor:pointer'>"
		}
		tabel = tabel + "</td></tr></table></td></tr>"
		return tabel;
	}
	
	function toon_groot(id) {
		uitvoer = tabelhoofd;
		uitvoer = uitvoer + "<tr bgcolor='#DDDDDD'><td align='left'>"
	 	if(id>1) {
			uitvoer = uitvoer + "<img src='img/vorige.gif' alt='vorige' class='clsNav' style='cursor:hand;cursor:pointer' id='"+(id-1)+"'>"
		}
		uitvoer = uitvoer + "</td><td align='center' class='hotnews' nowrap>Peanutstornooi (foto "+(id+1)+" van "+title.length+")</td><td align='right'>"
	 	if(id<title.length) {
			uitvoer = uitvoer + "<img src='img/volgende.gif' alt='volgende' class='clsNav' style='cursor:hand;cursor:pointer' id='"+(id+1)+"'></td></tr>"
		}
		uitvoer = uitvoer + "<tr bgcolor='#DDDDDD'><td align='center' colspan='3'><img src='"+img[id]+"' width='700'></td></tr></table>"
		$("#Layer3").html(uitvoer);
	}
}); 

</script>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<p align="center"><img src="img/ajax-loader.gif" id="loader"></p></div>
</body>
</html>
