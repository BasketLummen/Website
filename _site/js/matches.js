var renderMatches = function(){
      repository.matchesInWeekOf(new Date(), function(match){
        // var tr = $.template("#future-game-template", {
        //             date: match.datumString,
        //             time: match.beginTijd,
        //             home: match.tTNaam,
        //             away: match.tUNaam
        //         }, "tbody");
        // var matchuri= "/match/?matchid=" + match.guid;
        // tr.attr('onclick', 'window.document.location="' + matchuri + '";')
        // $(".future-games").append(tr);
    });
}


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatches();
});


$.topic("vbl.matches.loaded").subscribe(function () {
     renderMatches();   
});