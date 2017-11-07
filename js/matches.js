var renderMatches = function(){
      repository.matchesInWeekOf(new Date(), function(match){
          var d = new Date(match.jsDTCode);
          var weekday = d.getDay();
          var matchuri= "/match/?matchid=" + match.guid;
          var pos = (d.getUTCHours() * 60 + d.getMinutes()) / 2; //.5 pixel per minute

          var el = $("#day-" + weekday + " .calendar-items").children().last();
          var offset = el.length > 0 ? el[0].offsetTop + el.height() : 0;
          var top = (pos > offset) ? pos - offset : 0;

          var day = d.toLocaleString(window.navigator.language, {day: 'numeric'});
          var month = d.toLocaleString(window.navigator.language, {month: 'long'}); 
          
          var div = $.template("#item-template", {
                      link: matchuri,
                      name: match.beginTijd + ": " + match.tTNaam + " - " + match.tUNaam,
                      pos: "margin-top: " + top + "px"
                  });

          $("#day-" + weekday + " .day-text").text(day);
          $("#day-" + weekday + " .month-text").text(month);
          $("#day-" + weekday).css("display", "flex");  
          $("#day-" + weekday + " .calendar-items").append(div);
    });
}


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatches();
});


$.topic("vbl.matches.loaded").subscribe(function () {
     renderMatches();   
});