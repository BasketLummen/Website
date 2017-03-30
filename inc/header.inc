<%
dim titels(10)
titels(0) = "Home"
titels(1) = "Clubinfo"
titels(2) = "Hot News"
titels(3) = "Ploegen"
titels(4) = "Pronostiek"
titels(5) = "Fotoalbum"
titels(6) = "Activiteiten"
titels(7) = "Verjaardagen"
titels(8) = "Gastenboek"
titels(9) = "Links"
dim banner(10)
banner(0) = "bannerhome1"
banner(1) = "bannerclubinfo1"
banner(2) = "bannerhotnews1"
banner(3) = "bannerploegen1"
banner(4) = "bannerprono1"
banner(5) = "bannerfotoalbum1"
banner(6) = "banneractiviteiten1"
banner(7) = "bannerverjaardagen1"
banner(8) = "bannergastenboek1"
banner(9) = "bannerlinks1"
%>

<div id="Layer1" style="position:absolute; width:980; height:60px; z-index:0; left: 0; top: 0; background-image: url(img/<%=banner(toon)%>.gif); layer-background-image: url(img/<%=banner(toon)%>.gif); border: 1px none #000000;"><%'=titels(toon)%></div>
