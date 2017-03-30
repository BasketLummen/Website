<%
seizoen = "1415"

toon = trim(request("toon"))
dim ploeg(26)
ploeg(0) = "http://vblweb.wisseq.eu/Home/ClubDetail?guid=BVBL1176#sectionC" '"kalweekclub.asp?s="&seizoen
ploeg(1) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%201" '"kalploeg.asp?s="&seizoen&"&ploeg=14383011"
ploeg(2) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%202"
ploeg(3) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176HSE%20%203"
ploeg(4) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%201"
ploeg(5) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%202"
ploeg(6) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%203"
ploeg(7) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176DSE%20%204"
ploeg(8) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1081J16%20%201"
ploeg(9) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176M16%20%201"
ploeg(10) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G14%20%201"
ploeg(11) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G14%20%202"
ploeg(12) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%201"
ploeg(13) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%202"
ploeg(14) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G12%20%203"
ploeg(15) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G10%20%202"
ploeg(16) = "http://vblweb.wisseq.eu/Home/TeamDetail?teamguid=BVBL1176G10%20%203"
ploeg(18) = "spelers.asp?ploeg=34"
ploeg(19) = "spelers.asp?ploeg=35"
ploeg(20) = "spelers.asp?ploeg=37"

%>


<html>
<head>
<title>Basket Lummen - Competitie</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<frameset cols="*,130" border="0">
	<frame src="<%=ploeg(toon)%>" name="competitieframe">
	<frame src="competitieploegen.asp?toon=<%=toon%>&s=<%=seizoen%>" noresize>
</frameset>
<noframes></noframes>


<body>
</body>
</html>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-5769703-2");
pageTracker._trackPageview();
</script>
