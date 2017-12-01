$(document).ready(function(){
    var promotionholder = $("[data-promotionid]");
    var promotionid = promotionholder.attr("data-promotionid");
    var uri= "http://community-service.azurewebsites.net/api/promotions/" + promotionid;
    //var uri = "http://localhost:22465/api/promotions/" + promotionid;
    //$.support.cors = true;
    $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', // use json only, not jsonp
        crossDomain: true, // tell browser to allow cross domain.
        success: function(promotion){ 
            //promotionholder.text(promotion.name);
        }
      });
});