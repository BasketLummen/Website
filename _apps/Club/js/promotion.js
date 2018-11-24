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

var service = "community-service.azurewebsites.net";
//  var service = "localhost:22465"; // uncomment for local testing
var promotionholder;
var optional;
var required;
var promotionid;
var title;
var buttontext;
var nexttext;
var uri;
var posturi;
var promotion;
var items = [];
var selectedOptionMemory = [];

function renderForm(){
    var isIE = detectIE();
    
    selectedOptionMemory = [];
    promotionholder.empty();

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

        if(required.includes("email") || optional.includes("email")){
            table.append($('<tr>')
                .append($('<td>').append($('<label>').text('Email').attr('for', 'email')))
                .append($('<td>').append($('<input>').attr({ type: 'text', id: 'email', name: 'email', placeholder: 'Vul je email in...' })))); 
        }

        if(required.includes("address") || optional.includes("address")){
            table.append($('<tr>')
                .append($('<td>').append($('<label>').text('Adres').attr('for', 'address')))
                .append($('<td>').append($('<input>').attr({ type: 'text', id: 'address', name: 'address', placeholder: 'Vul je adres in...' }))));
        }
        
        if(required.includes("telephone") || optional.includes("telephone")){
            table.append($('<tr>')
                .append($('<td>').append($('<label>').text('Telefoon').attr('for', 'telephone')))
                .append($('<td>').append($('<input>').attr({ type: 'text', id: 'telephone', name: 'telephone', placeholder: 'Vul je telefoonnummer in...' }))));
        }

        // set up form validation rules
        var rules = {
            name: {
                required: true
            },
            firstname: {
                required: true
            },
            email: {
                required: false
            },
            address: {
                required: false
            },
            telephone: {
                required: false
            }
        };
        required.forEach(function(r){
            rules[r].required = true;
        });

        // set up form validation messages
        var messages = {
            name: {
                required: "Naam is verplicht"
            },
            firstname: {
                required: "Voornaam is verplicht"
            },
            email: {
                required: "Email is verplicht"
            },
            address: {
                required: "Adres is verplicht"
            },
            telephone: {
                required: "Telefoon is verplicht"
            }
        };

        var shouldShowTotal = true;
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

                shouldShowTotal &= item.price > 0;

                var inputTextVisible = item.maximumQuantity == null || item.maximumQuantity > 1;
                var checkType = promotion.choiceType == "Multiple" ? 'checkbox' : 'radio';
                var name = promotion.choiceType == "Multiple" ? item.id : "selection";
                table.append($('<tr>')
                    .append($('<td>').append($('<label>').text(item.name + (item.price > 0 ? " €" + item.price : "")).attr('for', item.id)))
                    .append($('<td>').append($('<input>').attr({ type: 'text', id: item.id, name: name, placeholder: '0' }).addClass("promotionitem").toggle(inputTextVisible))
                                    .append($('<input>').attr({ type: checkType, name: name, "data-targetid": item.id, "data-minvalue": item.minimumQuantity, "data-maxvalue": item.maximumQuantity }).addClass("promotionitemtoggle").toggle(!inputTextVisible) )));
            }
        }

        // extend with total and submit button

        if(shouldShowTotal){
            table.append($('<tr class="total-row">')
                .append($('<td>').append($('<label>').text('Te betalen')))
                .append($('<td>').append($('<label>').text('€ 0').attr('id', 'price'))));
        }

        table.append($('<tr>')
            .append($('<td>').append($('<label>').text('Stuur me een bevestiging').attr('for', 'sendConfirmation')))
            .append($('<td>').append($('<input>').attr({ type: 'checkbox', id: 'sendConfirmation', name: 'sendConfirmation', checked: 'checked' })).append(" (vereist email)")));        

        var btn = $('<button>')
            .attr({ type: 'submit', id: 'submit' })
            .append($('<img>').addClass("spinner").attr("src", "/img/loader-button.gif"))
            .append($("<span>").text(buttontext));

        table.append($('<tr>')
            .append($('<td>').append($('<label>').attr('for', 'submit')))
            .append($('<td>').append(btn)));

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
            // as not all untoggles trigger change, evaluate all on every toggle
            $(".promotionitemtoggle").each(function(i, toggle){
                var targetid = $(toggle).attr('data-targetid');
                var minvalue = $(toggle).attr('data-minvalue');
                var maxvalue = $(toggle).attr('data-maxvalue');
                $("#" + targetid).val($(toggle).is(':checked') ? maxvalue : minvalue).trigger("change");
            });                    
        });

        $(".promotionitemtoggle").change(function(){
            var targetid = $(this).attr('data-targetid');
            var item = items[targetid];
            if(item && item.type == "Variable" && item.options){
                $(".variable-row").remove();
                item.options.forEach(function(option){
                    var sel = $("<select>").attr('data-targetid', targetid).attr('data-optionid', option.name);
                    option.values.forEach(function(value){
                        sel.append($("<option>").attr("value", value.id).text(value.name));
                    });
                    var previouslySelected = selectedOptionMemory.hasOwnProperty(option.name);
                    if(previouslySelected){
                        sel.val(selectedOptionMemory[option.name]);
                    }

                    $(".total-row").before($('<tr class="variable-row">')
                    .append($('<td>').append($('<label>').text(option.name)))
                    .append($('<td>').append(sel)));
                });

                $("select[data-optionid]").change(function(){
                    var sel = $(this).attr('data-optionid');
                    var val = $(this).val();
                    selectedOptionMemory[sel] = val;
                });
            }
        });

        // set up form validation and submit logic
        var form = promotionholder.find('.responsive-form');
        form.validate({
            onkeyup: true,
            rules: rules,
            messages: messages,
            submitHandler: function (f) {
                
                $("#submit .spinner").show();
                $("#submit").attr('disabled', true);

                // gather the data
                var sum = computeTotal();

                var name = promotionholder.find('#name').val();
                var firstname = promotionholder.find('#firstname').val();
                var optionalInput = promotionholder.find('#email');
                var email = optionalInput != null ? optionalInput.val() : null;                
                var optionalInput = promotionholder.find('#telephone');
                var telephone = optionalInput != null ? optionalInput.val() : null;
                var optionalInput = promotionholder.find('#address');
                var address = optionalInput != null ?  optionalInput.val() : null;
                var sendConfirmation = promotionholder.find('#sendConfirmation').is(':checked');

                var itemsToSubmit = [];
                if(promotion.choiceType == "Multiple"){
                    for (var key in items) {
                        if (items.hasOwnProperty(key)){
                            var item = items[key];
                            var quantity = $("#" + item.id).val();
                            if(quantity == null || quantity.length == 0) quantity = 0;
                            itemsToSubmit.push({
                                id: guid(), 
                                promotionItem: item,
                                quantity: quantity,
                                selectedOptions : null
                            });
                        }
                    }
                }
                else{ // promotion.choiceType == "Single"
                    var selectedItemId = $('input[name=selection]:checked').attr('data-targetid');
                    var item = items[selectedItemId];
                    var quantity = $("#" + item.id).val();
                    if(quantity == null || quantity.length == 0) quantity = 0;
                    itemsToSubmit.push({
                        id: guid(), 
                        promotionItem: item,
                        quantity: quantity,
                        selectedOptions : null
                    });
                }

                // get select options
                itemsToSubmit.forEach(function(itemToSubmit){
                    var selectedOptions = [];
                    if(itemToSubmit.promotionItem.options !== null){
                        itemToSubmit.promotionItem.options.forEach(function(option){
                            var selected = $('select[data-targetid="' + itemToSubmit.promotionItem.id + '"][data-optionid="' + option.name + '"]').val();
                            var val = option.values.filter(function(v){ return v.id == selected })[0];
                            selectedOptions.push({
                                name: option.name,
                                selectedOptionType: val
                            });
                        });
                        itemToSubmit.selectedOptions = selectedOptions;
                    }                    
                });
                
                var subscription = {
                    id: guid(), 
                    promotionId: promotionid,
                    subscriberName: firstname + " " + name,
                    subscriberEmail: email,
                    subscriberTelephone: telephone,
                    invoiceAddress: address,
                    sendConfirmation: sendConfirmation,
                    items: itemsToSubmit
                };

                var report = function(message, confirmation){
                // var table = promotionholder.find('table');                  
                  
                
                    var div = $("<div>").append($('<label>').text(message))
                                        .append("<br/>")
                                        .append("<br/>")
                                        .append($("<button>").attr('id', 'print-order').attr('type', 'button').text(isIE === false ? "print uw bestelling" : "download uw bestelling" ))                  
                                        .append("&nbsp;")
                                        .append($("<button>").attr('id', 'next-order').attr('type', 'button').text(nexttext));
                                       
                    table.empty();
                    table.append($('<tr>').append($('<td>').append(div)).append($('<td>')));

                    $("#next-order").click(function(){
                        renderForm();
                    });

                    $("#print-order").click(function(){
                        var doc = new jsPDF()
                    
                        doc.addFileToVFS("PTSans.ttf", PTSans);
                        doc.addFont('PTSans.ttf', 'PTSans', 'normal');
                    
                        doc.setFont('PTSans'); // set font
                        
                        doc.setFontType("normal");
                        doc.setFontSize(18);
                        
                        var lines = doc.splitTextToSize(confirmation, 180);
                        doc.text(20, 20 , lines)
                       
                        if(isIE === false){
                            doc.autoPrint();

                            var iframe = document.getElementById('printoutput');
                            iframe.src = doc.output('datauristring');
                        }
                        else{
                            doc.save('bestelling.pdf');
                        }
                    });
                };

                // send it to the service
                $.ajax({
                    type: 'POST',
                    url: posturi,
                    contentType: 'application/json', 
                    crossDomain: true,
                    data : JSON.stringify(subscription),                        
                    success: function(data){ 
                      report(promotion.successMessage.format(sum), data.message);
                      $("#submit .spinner").hide();
                      $("#submit").attr('disabled', false);
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

$(document).ready(function(){
   
    promotionholder = $("[data-promotionid]");
    promotionid = promotionholder.attr("data-promotionid");
    title = promotionholder.attr("data-title");
    buttontext = promotionholder.attr("data-buttontext");
    nexttext = promotionholder.attr("data-nexttext");
    var toSplit = promotionholder.attr("data-required");
    required = toSplit != null ? toSplit.split(" "): [];
    toSplit = promotionholder.attr("data-optional");
    optional = toSplit != null ? toSplit.split(" "): [];
    uri= "https://" + service + "/api/promotions/" + promotionid;
    posturi= "https://" + service + "/api/promotions/" + promotionid + "/subscriptions";

    $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', 
        crossDomain: true, 
        success: function(p){    
            
            promotion = p;
             // set up form
            renderForm();

        }
      });
});