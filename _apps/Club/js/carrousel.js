setInterval(function(){
  var width = $("#partners ul li:first-child img").outerWidth();
  $("#partners ul li:first-child").animate({
      opacity: 0, // animate slideUp
      marginLeft: '-' + width + 'px'
      }, 'slow', 'swing', function() {
      var el = $(this).detach();
      $("#partners ul").append(el);
      el.css({ 'opacity' : 1, 'margin-left' : 0 });
      });		
}, 5000);

var center = function(){
	$("img.focus-center").each(function(i, img) {
		var offset = ($(window).width() - $(img).width()) / 2;
		/*if(offset < -($(window).width() / 4) || $(img).css('margin-left') != "0px"){*/
			$(img).animate({
				marginLeft: offset + 'px'
			}, 'slow', 'swing', function() {});
		/*}*/
	});
}

$('#myCarousel').bind('slide.bs.carousel', function (e) {
	center();
});
$('#myCarousel').bind('slid.bs.carousel', function (e) {
	center();
});
$(window).resize(function(){
	center();
});
center();