var service = "camp-service.azurewebsites.net";
var scheme = "https://";
//var scheme = "http://";
//var service = "localhost:22465"; // uncomment for local testing
var campholder;
var optional;
var required;
var campid;
var title;
var buttontext;
var nexttext;
var uri;
var posturi;
var camp;
var levels;
var items = [];
var eligiblePlayers = [];

function renderForm(){
    var isIE = detectIE();
    
    campholder.empty();

    var table = $('<table>');

    campholder.append($('<form>').addClass('responsive-form')
                    .append($('<fieldset>')
                    .append($('<legend>').text(title))
                    .append(table)));

    var today = new Date();
    var fromDate = Date.parse(camp.registrationOpensAt);
    var fromDatePassed = fromDate < today;
    var toDatePassed = Date.parse(camp.registrationClosesAt) <= today;

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
       
        if(camp.registrationLimitedTo != null){

            table.append($('<tr>').attr("id", "search-parent")
            .append($('<td>').append($('<label>').text('Naam').attr('for', 'registration-search')))
            .append($('<td>').append($('<input>').attr({ type: 'text', id: 'registration-search', name: 'registration-search', placeholder: 'Vul de naam van de speler in...' }))
            .append($('<input>').attr({ type: 'hidden', id: 'registration-name', name: 'registration-name' }))
            .append($('<input>').attr({ type: 'hidden', id: 'registration-level', name: 'registration-level' }))));

            var search = table.find('#registration-search');

            var options = {
                shouldSort: true,
                threshold: 0.3,
                location: 0,
                distance: 100,
                maxPatternLength: 32,
                minMatchCharLength: 3,
                keys: [
                    "name"
                    ]
                };
            var fuse = new Fuse(eligiblePlayers, options);
            search.autocomplete({
                delay: 0,
                appendTo: "#search-parent",
                position: { my: 'left top', at: 'left bottom' },
                source: function(req, callback) {
                 
                  var options = [];
                  $.each(fuse.search(req.term), function(index, obj) {
                    options.push({value: obj.id, label: obj.name, level: obj.level});
                  });
                  
                  callback(options);
                },
                select: function(event, ui) {
                    event.preventDefault();
                    $("#registration-search").val(ui.item.label);
                    $("#registration-name").val(ui.item.label);
                    $("#registration-level").val(ui.item.level);
                    $(".showaftersearch").show();
                },
                focus: function(event, ui) {
                    event.preventDefault();
                    $("#registration-search").val(ui.item.label);
                    $("#registration-name").val(ui.item.label);
                    $("#registration-level").val(ui.item.level);
                },
                response: function(event,ui) {
                    if (ui.content.length == 1)
                    {
                      ui.item = ui.content[0];
                      $(this).data('ui-autocomplete')._trigger('select', 'autocompleteselect', ui);
                      $(this).autocomplete('close');
                    }
              }
            });
        }
        else{
            table.append($('<tr>')
                .append($('<td>').append($('<label>').text('Naam').attr('for', 'registration-name')))
                .append($('<td>').append($('<input>').attr({ type: 'text', id: 'registration-name', name: 'registration-name', placeholder: 'Vul de naam van de speler in...' }))));

            table.append($('<tr>')
                .append($('<td>').append($('<label>').text('Niveau').attr('for', 'registration-level')))
                .append($('<td>').append($('<input>').attr({ type: 'text', id: 'registration-level', name: 'registration-level', placeholder: 'Vul het niveau van de speler in...' }))));
        }


        if(camp.pricingModel.model == "PerPart")
        {
            camp.parts.forEach(function(cd, i){
            
                var start = new Date(cd.start);
                var end = new Date(cd.end);
    
                table.append($('<tr>')
                    .append($('<td>').append($('<label>').text(start.toLocaleDateString() + " (" + camp.pricingModel.unit + camp.pricingModel.value + ")").attr('for', 'camppart-' + i)))
                    .append($('<td>').append($('<input>').attr({ id: 'camppart-' + i, name: 'camppart-' + i, type: 'checkbox' }).addClass("camppart"))));
            });
        }       

        table.append($('<tr>')
                .append($('<td>').append($('<label>').text("Contact informatie")))
                .append($('<td>')));

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

        if(required.includes("comment") || optional.includes("comment")){
            table.append($('<tr>')
                .append($('<td>').append($('<label>').text('Opmerking').attr('for', 'comment')))
                .append($('<td>').append($('<textarea>').attr({ id: 'comment', name: 'comment', rows: '4', placeholder: '' }))));
        }

        
        if(camp.pricingModel.model == "Entry" || camp.pricingModel.model == "PerPart"){
            var price = camp.pricingModel.model == "Entry" ? camp.pricingModel.value : 0;
            
            table.append($('<tr class="total-row">')
                .append($('<td>').append($('<label>').text('Te betalen')))
                .append($('<td>').append($('<label>').text('€ ' + price).attr('id', 'price'))));
        }

        var computeTotal = function(){
            var sum = 0;
            camp.parts.forEach(function(cd, i){
                if($("#camppart-" + i).is(':checked')){
                    sum += camp.pricingModel.value;
                }
            });
            return sum;
        };

        $(".camppart").change(function(){
            var sum = computeTotal();
            campholder.find('#price').text("€ " + sum);
        });
      
        // set up form validation rules
        var rules = {
            "registration-name":{
                required: true
            }, 
            "registration-level":{
                required: true
            },
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
            },
            comment: {
                required: false
            }
        };
        required.forEach(function(r){
            rules[r].required = true;
        });

        // set up form validation messages
        var messages = {
            "registration-name":{
                required: "Naam is verplicht"
            },
            "registration-level":{
                required: "Niveau is verplicht"
            },
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
            },
            comment: {
                required: "Opmerking is verplicht"
            }
        };

      
        // table.append($('<tr>')
        //     .append($('<td>').append($('<label>').text('Stuur me een bevestiging').attr('for', 'sendConfirmation')))
        //     .append($('<td>').append($('<input>').attr({ type: 'checkbox', id: 'sendConfirmation', name: 'sendConfirmation', checked: 'checked' })).append(" (vereist email)")));        

        //<img class="spinner" src="/img/loading-primary.gif" /><span>Sign In</span>
        var btn = $('<button>')
                    .attr({ type: 'submit', id: 'submit' })
                    .append($('<img>').addClass("spinner").attr("src", "/img/loader-button.gif"))
                    .append($("<span>").text(buttontext));

        table.append($('<tr>')
            .append($('<td>').append($('<label>').attr('for', 'submit')))
            .append($('<td>').append(btn)));

        if(camp.registrationLimitedTo != null){
            btn.addClass("showaftersearch");
        }
            

        // set up form validation and submit logic
        var form = campholder.find('.responsive-form');
        form.validate({
            onkeyup: true,
            rules: rules,
            messages: messages,
            submitHandler: function (f) {
                
                $("#submit .spinner").show();
                $("#submit").attr('disabled', true);
        
                // gather the data
                var campParts = [];

                var registrationName = campholder.find('#registration-name').val();
                var registrationLevel = campholder.find('#registration-level').val();
                var lastname = campholder.find('#name').val();
                var firstname = campholder.find('#firstname').val();
                var optionalInput = campholder.find('#email');
                var email = optionalInput != null ? optionalInput.val() : null;                
                var optionalInput = campholder.find('#telephone');
                var telephone = optionalInput != null ? optionalInput.val() : null;
                var optionalInput = campholder.find('#address');
                var address = optionalInput != null ?  optionalInput.val() : null;
                var optionalInput = campholder.find('#comment');
                var comment = optionalInput != null ? optionalInput.val() : null;
                //var sendConfirmation = campholder.find('#sendConfirmation').is(':checked');          

                camp.parts.forEach(function(cd, i){
                    if($("#camppart-" + i).is(':checked')){
                        campParts.push(cd);
                    }
                });
                          
                var registration = {
                    campid: campid,
                    registration: {
                        id: guid(),
                        name: registrationName,
                        level:registrationLevel,
                        comment: comment,
                        contact : {
                            name: firstname + " " +  lastname,
                            email: email,
                            address: address,
                            telephone: telephone
                        },
                        parts: campParts
                    }
                };

                var report = function(message, confirmation){
                    var div = $("<div>").append($('<label>').text(message))
                                        .append("<br/>").append("<br/>")
                                        .append($("<button>").attr('id', 'next-registration').attr('type', 'button').text(nexttext));
                                       
                    table.empty();
                    table.append($('<tr>').append($('<td>').append(div)).append($('<td>')));

                    $("#next-registration").click(function(){
                        renderForm();
                    });

                  
                };

                // send it to the service
               
                $.ajax({
                    type: 'POST',
                    url: posturi,
                    contentType: 'application/json', 
                    crossDomain: true,
                    data : JSON.stringify(registration),                        
                    success: function(data){ 
                      report("Registratie verstuurd", data.message);
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

var loadEligiblePlayers = function(callback){
    var tasks = [];
    camp.registrationLimitedTo.forEach(function(limit){
        var deferred = $.Deferred();
        tasks.push(deferred.promise());
        clubmgmt.loadTeam(limit.groupId, function(t){

            t.participations.forEach(function(p){
                if(p.roleId == limit.roleId){
                    eligiblePlayers.push({
                        name: p.contactName,
                        level: t.groupName 
                    })
                };                
            });
            
            deferred.resolve();
        });
    });
    $.when.apply($, tasks).then(callback);
}

$(document).ready(function(){   
    campholder = $("[data-campid]");
    campid = campholder.attr("data-campid");
    title = campholder.attr("data-title");
    buttontext = campholder.attr("data-buttontext");
    nexttext = campholder.attr("data-nexttext");
    toSplit = campholder.attr("data-required");
    required = toSplit != null ? toSplit.split(" "): [];
    toSplit = campholder.attr("data-optional");
    optional = toSplit != null ? toSplit.split(" "): [];
    toSplit = campholder.attr("data-allowed-levels");
    levels = toSplit != null ? toSplit.split(" "): [];
    uri= scheme + service + "/api/camps/" + orgId + "/" + campid;
    posturi=  scheme + service + "/api/camps/" + orgId + "/" +campid + "/register";

    $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', 
        crossDomain: true, 
        success: function(c){    
            
            camp = c;

            if(camp.registrationLimitedTo != null){
                loadEligiblePlayers(renderForm);
            }
            else{
                // set up form
                renderForm();
            }
           

        }
      });
});