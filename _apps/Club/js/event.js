var service = "events-service.azurewebsites.net";
var scheme = "https://";
//var scheme = "http://";
//var service = "localhost:22465"; // uncomment for local testing
var eventholder;
var optional;
var required;
var eventid;
var title;
var buttontext;
var nexttext;
var uri;
var posturi;
var event;

function renderForm(){
    var isIE = detectIE();
    
    eventholder.empty();

    var table = $('<table>');

    eventholder.append($('<form>').addClass('responsive-form')
                    .append($('<fieldset>')
                    .append($('<legend>').text(title))
                    .append(table)));

    var today = new Date();
    var fromDate = Date.parse(event.registrationOpensAt);
    var fromDatePassed = fromDate < today;
    var toDatePassed = Date.parse(event.registrationClosesAt) <= today;

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

        if(required.includes("comment") || optional.includes("comment")){
            table.append($('<tr>')
                .append($('<td>').append($('<label>').text('Opmerking').attr('for', 'comment')))
                .append($('<td>').append($('<textarea>').attr({ id: 'comment', name: 'comment', rows: '4', placeholder: '' }))));
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

            // set up form validation and submit logic
        var form = eventholder.find('.responsive-form');
        form.validate({
            onkeyup: true,
            rules: rules,
            messages: messages,
            submitHandler: function (f) {
                
                $("#submit .spinner").show();
                $("#submit").attr('disabled', true);

                var lastname = eventholder.find('#name').val();
                var firstname = eventholder.find('#firstname').val();
                var optionalInput = eventholder.find('#email');
                var email = optionalInput != null ? optionalInput.val() : null;                
                var optionalInput = eventholder.find('#telephone');
                var telephone = optionalInput != null ? optionalInput.val() : null;
                var optionalInput = eventholder.find('#address');
                var address = optionalInput != null ?  optionalInput.val() : null;
                var optionalInput = eventholder.find('#comment');
                var comment = optionalInput != null ? optionalInput.val() : null;

                var registration = {
                    eventid: eventid,
                    registration: {
                        id: guid(),
                        name: firstname + " " +  lastname,
                        comment: comment,
                        contact : {
                            name: firstname + " " +  lastname,
                            email: email,
                            address: address,
                            telephone: telephone
                        }
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


$(document).ready(function(){   
    eventholder = $("[data-eventid]");
    eventid = eventholder.attr("data-eventid");
    title = eventholder.attr("data-title");
    buttontext = eventholder.attr("data-buttontext");
    nexttext = eventholder.attr("data-nexttext");
    toSplit = eventholder.attr("data-required");
    required = toSplit != null ? toSplit.split(" "): [];
    toSplit = eventholder.attr("data-optional");
    optional = toSplit != null ? toSplit.split(" "): [];
    toSplit = eventholder.attr("data-allowed-levels");
    levels = toSplit != null ? toSplit.split(" "): [];
    uri= scheme + service + "/api/events/" + orgId + "/" + eventid;
    posturi=  scheme + service + "/api/events/" + orgId + "/" +eventid + "/register";

    $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', 
        crossDomain: true, 
        success: function(c){            
            event = c;
            renderForm();
        }
      });
});