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

var service = "tournament-service.azurewebsites.net";
//  var service = "localhost:22465"; // uncomment for local testing
var tournamentholder;
var allowedmodes = ["club"];
var mode;
var optional;
var required;
var tournamentid;
var title;
var buttontext;
var nexttext;
var uri;
var posturi;
var tournament;
var levels;
var items = [];
var selectedOptionMemory = [];

function renderForm(){
    var isIE = detectIE();
    
    selectedOptionMemory = [];
    tournamentholder.empty();

    var table = $('<table>');

    tournamentholder.append($('<form>').addClass('responsive-form')
                    .append($('<fieldset>')
                    .append($('<legend>').text(title))
                    .append(table)));

    var today = new Date();
    var fromDate = Date.parse(tournament.registrationOpensAt);
    var fromDatePassed = fromDate < today;
    var toDatePassed = Date.parse(tournament.registrationClosesAt) <= today;

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
        if(allowedmodes.length > 1){
            var options = $("<select>").attr({ id: 'selected-mode', name: 'selected-mode' });

            allowedmodes.forEach(function(allowedMode){
                var option = $("<option>");
                option.val(allowedMode);
                option.text(translate(allowedMode));
                options.append(option);
            });

            table.append($('<tr>')
                 .append($('<td>').append($('<label>').text('Ik kom').attr('for', 'selected-mode')))
                 .append($('<td>').append(options)));

            options.change(function(){
                mode = options.val();
                $(".mode-toggle").hide();
                $(".mode-" + mode).show();
            });
        }

        table.append($('<tr>').addClass("mode-toggle").addClass("mode-club").css("display", "none")
            .append($('<td>').append($('<label>').text('Club').attr('for', 'club')))
            .append($('<td>').append($('<input>').attr({ type: 'text', id: 'club', name: 'club', placeholder: 'Vul de naam van je club in...' }))));

        table.append($('<tr>').addClass("mode-toggle").addClass("mode-club").css("display", "none")
            .append($('<td>').append($('<label>').text("Aantal ploegjes")))
            .append($('<td>')));

        levels.forEach(function(level){
            table.append($('<tr>').addClass("mode-toggle").addClass("mode-club").css("display", "none")
                .append($('<td>').append($('<label>').text(level).attr('for', level)))
                .append($('<td>').append($('<input>').attr({ type: 'number', id: level, name: level }).val(0))));
        });

        table.append($('<tr>').addClass("mode-toggle").addClass("mode-team").css("display", "none")
             .append($('<td>').append($('<label>').text('Team').attr('for', 'team')))
             .append($('<td>').append($('<input>').attr({ type: 'text', id: 'team', name: 'team', placeholder: 'Vul de naam van je team in...' }))));

        table.append($('<tr>').addClass("mode-toggle").addClass("mode-team").css("display", "none")
             .append($('<td>').append($('<label>').text('Niveau').attr('for', 'level-team')))
             .append($('<td>').append($('<input>').attr({ type: 'text', id: 'level-team', name: 'level-team', placeholder: 'Wat is het niveau / leeftijd van je team?'  }))));

        table.append($('<tr>').addClass("mode-toggle").addClass("mode-individual").css("display", "none")
             .append($('<td>').append($('<label>').text('Niveau').attr('for', 'level-individual')))
             .append($('<td>').append($('<input>').attr({ type: 'text', id: 'level-individual', name: 'level-individual', placeholder: 'Op welk niveau speel je?' }))));

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

        table.append($('<tr>')
            .append($('<td>').append($('<label>').attr('for', 'submit')))
            .append($('<td>').append($('<button>').text(buttontext).attr({ type: 'submit', id: 'submit' }))));

       $(".mode-" + mode).show();

        // set up form validation and submit logic
        var form = tournamentholder.find('.responsive-form');
        form.validate({
            onkeyup: true,
            rules: rules,
            messages: messages,
            submitHandler: function (f) {
                
                // gather the data

                var name = tournamentholder.find('#' + mode).val(); //only available for team & club
                var lastname = tournamentholder.find('#name').val();
                var firstname = tournamentholder.find('#firstname').val();
                var optionalInput = tournamentholder.find('#email');
                var email = optionalInput != null ? optionalInput.val() : null;                
                var optionalInput = tournamentholder.find('#telephone');
                var telephone = optionalInput != null ? optionalInput.val() : null;
                var optionalInput = tournamentholder.find('#address');
                var address = optionalInput != null ?  optionalInput.val() : null;
                var optionalInput = tournamentholder.find('#comment');
                var comment = optionalInput != null ? optionalInput.val() : null;
                //var sendConfirmation = tournamentholder.find('#sendConfirmation').is(':checked');
                var teams= [];
               
                if(mode=="club"){
                    var i = 0;
                    levels.forEach(function(level){
                        var count = tournamentholder.find('#' +level).val();
                        for(var j= 0; j< count; j++){
                            i++;
                            teams.push({
                                name: name + " " + i,
                                level: level
                            });
                        }
                    });
                }
                else if(mode=="team"){
                    var level =  tournamentholder.find('#level-team').val();
                    teams.push({
                        name: name,
                        level: level
                    });
                }     
                else if(mode=="individual"){
                    name = firstname + " " +  lastname;
                    var level =  tournamentholder.find('#level-individual').val();
                    if(level.length > 0)
                    {
                        var temp = "Niveau: " + level;
                        if(comment != null){
                            temp += "- " + comment;
                        }
                        comment = temp;
                    }                   
                }              
                          
                var registration = {
                    tournamentid: tournamentid,
                    registration: {
                        id: guid(),
                        name: name,
                        comment: comment,
                        contact : {
                            name: firstname + " " +  lastname,
                            email: email,
                            address: address,
                            telephone: telephone
                        },
                        teams: teams
                    }
                };

                var report = function(message, confirmation){
                // var table = tournamentholder.find('table');                  
                  
                
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

function detectIE() {
    var ua = window.navigator.userAgent;
   
    var msie = ua.indexOf('MSIE ');
    if (msie > 0) {
      // IE 10 or older => return version number
      return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
    }
  
    var trident = ua.indexOf('Trident/');
    if (trident > 0) {
      // IE 11 => return version number
      var rv = ua.indexOf('rv:');
      return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
    }
  
    var edge = ua.indexOf('Edge/');
    if (edge > 0) {
      // Edge (IE 12+) => return version number
      return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
    }
  
    // other browser
    return false;
  }

$(document).ready(function(){
   
    tournamentholder = $("[data-tournamentid]");
    tournamentid = tournamentholder.attr("data-tournamentid");
    var toSplit = tournamentholder.attr("data-allowed-modes");
    allowedmodes = toSplit != null ? toSplit.split(" "): [];
    mode = allowedmodes[0];
    title = tournamentholder.attr("data-title");
    buttontext = tournamentholder.attr("data-buttontext");
    nexttext = tournamentholder.attr("data-nexttext");
    toSplit = tournamentholder.attr("data-required");
    required = toSplit != null ? toSplit.split(" "): [];
    toSplit = tournamentholder.attr("data-optional");
    optional = toSplit != null ? toSplit.split(" "): [];
    toSplit = tournamentholder.attr("data-allowed-levels");
    levels = toSplit != null ? toSplit.split(" "): [];
    uri= "https://" + service + "/api/tournaments/" + orgId + "/" + tournamentid;
    posturi= "https://" + service + "/api/tournaments/" + orgId + "/" +tournamentid + "/register";

    $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', 
        crossDomain: true, 
        success: function(t){    
            
            tournament = t;
             // set up form
            renderForm();

        }
      });
});

function translate(mode){
    if(mode == "club"){
        return "Met meerdere ploegjes van onze club";
    }
    else if(mode == "team"){
        return "Met een ploeg";
    }
    else if(mode == "individual"){
        return "Individueel";
    }
}