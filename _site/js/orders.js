function renderHeader(details){
	var tr = $("#orders-table tr:first");
	details.promotion.items.forEach(function(item) {
		var div = $.template("#available-item-template",
		{
			title: item.name
		});
		tr.append($("<th>").addClass("responsive-table-cell").append(div));
	});
	
	var div = $.template("#available-item-template",
	{
		title: "Totaal"
	});
	tr.append($("<th>").addClass("responsive-table-cell").append(div));
}

function renderRows(details){
	var table = $("#orders-table");
	details.subscriptions.forEach(function(subscription) {
		var tr = $("<tr>");
		var div = $.template("#subscriber-template",
		{
			subscriberName: subscription.subscriberName
		});
		var tr = $("<tr>");
		table.append(tr.append($("<td>").addClass("responsive-table-cell").append(div)));
		var price = 0;
		details.promotion.items.forEach(function(item){
			var items = subscription.items.filter(e => e.promotionItem.id === item.id);
			
			var subscribed = items.length > 0 ? items[0] : null;
			var quantity = 0;
			items.forEach(function(s){
				quantity += s.quantity
			});	
			
			var content = $.template("#subscribed-template",
			{
				quantity: quantity
			});
			
			price += quantity * item.price;
			
			tr.append($("<td>").attr('id', subscribed.id).addClass("responsive-table-cell").append(content));
		});
		
		var content = $.template("#subscribed-template",
		{
			quantity: "€ " + price
		});
		
		tr.append($("<td>").addClass("responsive-table-cell").append(content));
	});
}

$(document).ready(function(){
    var id = $("#orders").attr("data-id");
    var service = "community-service.azurewebsites.net";
  //  var service = "localhost:22465"; // uncomment for local testing
    var uri= "http://" + service + "/api/promotions/" + id + "/subscriptions";
    var items = [];

    $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', 
        crossDomain: true, 
        success: function(details){    
            
            renderHeader(details);
			renderRows(details);	
            
        }
      });
});