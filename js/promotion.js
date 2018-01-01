if (!String.prototype.format) {
    String.prototype.format = function() {
      var args = arguments;
      return this.replace(/{(\d+)}/g, function(match, number) { 
        return typeof args[number] != 'undefined'
          ? args[number]
          : match
        ;
      });
    };
  }

$(document).ready(function(){
    var promotionholder = $("[data-promotionid]");
    var promotionid = promotionholder.attr("data-promotionid");
    var title = promotionholder.attr("data-title");
    var buttontext = promotionholder.attr("data-buttontext");
    var service = "community-service.azurewebsites.net";
  //  var service = "localhost:22465"; // uncomment for local testing
    var uri= "http://" + service + "/api/promotions/" + promotionid;
    var posturi= "http://" + service + "/api/promotions/" + promotionid + "/subscriptions";
    var items = [];

    $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', 
        crossDomain: true, 
        success: function(promotion){    
            
             // set up form
            
            var table = $('<table>');

            promotionholder.append($('<form>').addClass('responsive-form')
                           .append($('<fieldset>')
                           .append($('<legend>').text(title))
                           .append(table)));

            var today = new Date();
            var fromDate = Date.parse(promotion.availableFrom);
            var fromDatePassed = fromDate < today;
            var toDatePassed = Date.parse(promotion.availableTo) <= today;

            if(!fromDatePassed){
                table.append($('<tr>')
                     .append($('<td>').append($('<label>').text('Registratie gaat pas open op ' + fromDate.toLocaleString()))));;
            }

            if(toDatePassed){
                table.append($('<tr>')
                     .append($('<td>').append($('<label>').text('Registratie is afgelopen'))));;
            }

            if(fromDatePassed && !toDatePassed)
            {

                table.append($('<tr>')
                    .append($('<td>').append($('<label>').text('Voornaam').attr('for', 'firstname')))
                    .append($('<td>').append($('<input>').attr({ type: 'text', id: 'firstname', name: 'firstname', placeholder: 'Vul je voornaam in...' }))));

                table.append($('<tr>')
                    .append($('<td>').append($('<label>').text('Naam').attr('for', 'name')))
                    .append($('<td>').append($('<input>').attr({ type: 'text', id: 'name', name: 'name', placeholder: 'Vul je naam in...' }))));
                
                // set up form validation rules
                var rules = {
                    name: {
                        required: true
                    },
                    firstname: {
                        required: true
                    }
                };

                // set up form validation messages
                var messages = {
                    name: {
                        required: "Naam is verplicht"
                    },
                    firstname: {
                        required: "Voornaam is verplicht"
                    }
                };

                // extend with promotion items
                for (var key in promotion.items) {
                    if (promotion.items.hasOwnProperty(key)){
                        var item = promotion.items[key];
                        items[item.id] = item;

                        
                        if(item.minimumQuantity != null && item.maximumQuantity != null)
                        {
                            var min = item.minimumQuantity != null ? item.minimumQuantity : 0;
                            var max = item.maximumQuantity != null ? item.maximumQuantity : 2147483647; 
                            rules[item.id] = {
                                range: [min, max]
                            };
                            messages[item.id] = {
                                range : "Vul een getal in tussen " + min + " en " + max
                            }
                        }
                        else{
                            rules[item.id] = {
                                number: true
                            };
                            messages[item.id] = {
                                number: "Vul een getal in"
                            };
        
                        }

                        var inputTextVisible = item.maximumQuantity == null || item.maximumQuantity > 1;
                        table.append($('<tr>')
                            .append($('<td>').append($('<label>').text(item.name + " €" + item.price).attr('for', item.id)))
                            .append($('<td>').append($('<input>').attr({ type: 'text', id: item.id, name: item.id, placeholder: '0' }).addClass("promotionitem").toggle(inputTextVisible))
                                            .append($('<input>').attr({ type: 'checkbox', "data-targetid": item.id, "data-minvalue": item.minimumQuantity, "data-maxvalue": item.maximumQuantity }).addClass("promotionitemtoggle").toggle(!inputTextVisible) )));
                    }
                }

                // extend with total and submit button

                table.append($('<tr>')
                    .append($('<td>').append($('<label>').text('Te betalen')))
                    .append($('<td>').append($('<label>').text('€ 0').attr('id', 'price'))));

                table.append($('<tr>')
                    .append($('<td>').append($('<label>').attr('for', 'submit')))
                    .append($('<td>').append($('<button>').text(buttontext).attr({ type: 'submit', id: 'submit' }))));

                // compute price on promotion item changes
                var computeTotal = function(){
                    var sum = 0;
                    for (var key in items) {
                        if (items.hasOwnProperty(key)){
                            var item = items[key];
                            var quantity = $("#" + item.id).val();
                            if(quantity == null || quantity.length == 0) quantity = 0;
                            sum += quantity * item.price;
                        }
                    }
                    return sum;
                };

                $(".promotionitem").change(function(){
                var sum = computeTotal();
                promotionholder.find('#price').text("€ " + sum);
                });
                $(".promotionitemtoggle").change(function(){
                    var targetid = $(this).attr('data-targetid');
                    var minvalue = $(this).attr('data-minvalue');
                    var maxvalue = $(this).attr('data-maxvalue');
                    $("#" + targetid).val($(this).is(':checked') ? maxvalue : minvalue).trigger("change");
                });

                // set up form validation and submit logic
                var form = promotionholder.find('.responsive-form');
                form.validate({
                    onkeyup: true,
                    rules: rules,
                    messages: messages,
                    submitHandler: function (f) {
                        
                        // gather the data
                        var sum = computeTotal();

                        var name = promotionholder.find('#name').val();
                        var firstname = promotionholder.find('#firstname').val();
                        var itemsToSubmit = [];
                        for (var key in items) {
                            if (items.hasOwnProperty(key)){
                                var item = items[key];
                                var quantity = $("#" + item.id).val();
                                if(quantity == null || quantity.length == 0) quantity = 0;
                                itemsToSubmit.push({
                                    id: guid(), 
                                    promotionItem: item,
                                    quantity: quantity
                                });
                            }
                        }
                        var subscription = {
                            id: guid(), 
                            promotionId: promotionid,
                            subscriberName: firstname + " " + name,
                            items: itemsToSubmit
                        };

                        var report = function(message){
                        // var table = promotionholder.find('table');
                            table.empty();
                            table.append($('<tr>').append($('<td>').append($('<label>').text(message))).append($('<td>')));
                        };

                        // send it to the service
                        $.ajax({
                            type: 'POST',
                            url: posturi,
                            contentType: 'application/json', 
                            crossDomain: true,
                            data : JSON.stringify(subscription),                        
                            success: function(){ 
                                report(promotion.successMessage.format(sum));
                            },
                            error: function(xhr, ajaxOptions, thrownError){ 
                                report("Er is een fout opgetreden bij het registreren. " + xhr.status);
                            }
                        });
            
                        return false;
                        
                    }
                });
            }
        }
      });
});