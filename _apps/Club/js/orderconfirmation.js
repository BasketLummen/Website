var ordersService = "https://clubmgmt-orders-service.azurewebsites.net";

Handlebars.registerHelper('line-item-total', function(orderLine) {
   return orderLine.Quantity * orderLine.OrderedItem.Price.Value;
});

Handlebars.registerHelper('order-total', function(order) {
    var total = 0;
    
    order.OrderLines.forEach(function(orderLine){
        total += orderLine.Quantity * orderLine.OrderedItem.Price.Value;
    });
  
    return total;
  });



$(document).ready(function(){
    var isIE = detectIE();

    var tmp =  "{{{data.Buyer.Name}}}, \r\n \r\n" +
    "Hartelijk dank om je in te schrijven voor de bbq op het slotfeest. \r\n \r\n" +
    "We verwelkomen je op Zaterdag 25 mei 2019 in de cafetaria van sporthal De Vijfsprong, vanaf 18u30. \r\n \r\n" +
    "Overzicht van je bestelling: \r\n \r\n" +
    "{{#each data.OrderLines}} \r\n" +
    "    {{{this.OrderedItem.Name}}} = €{{{line-item-total this}}} \r\n" +   
    "   {{#each this.OrderedItem.SelectedOptions}} \r\n" +
    "        {{{this.Value}}} \r\n" +
    "    {{/each}} \r\n" +
    "{{/each}} \r\n \r\n" +
    "Totaal:  €{{{order-total data}}} \r\n \r\n" +
    "Gelieve het te betalen bedrag en deze bevestiging mee te nemen op de dag van de bbq. \r\n \r\n" +
    "Tot op de bbbq, \r\n" +
    "Basket Lummen \r\n";
    var template = Handlebars.compile(tmp);
    var body = template({
        data: {
            Buyer: {
                Name: "Yves Goeleven"
            },           
            OrderLines: [{
                OrderedItem: {
                    Name: "Spaghetti",
                    Price: {
                        Value: 10
                    },
                    SelectedOptions: []
                },
                Quantity: 1
            }, {
                OrderedItem: {
                    Name: "Spaghetti",
                    Price: {
                        Value: 10
                    },
                    SelectedOptions: []
                },
                Quantity: 1
            }]
        }
    });
    
    var doc = new jsPDF()

    doc.addFileToVFS("PTSans.ttf", PTSans);
    doc.addFont('PTSans.ttf', 'PTSans', 'normal');

    doc.setFont('PTSans'); // set font
    
    doc.setFontType("normal");
    doc.setFontSize(11);
    
    var lines = doc.splitTextToSize(body, 180);
    doc.text(20, 20 , lines)
    
    if(isIE === false){
       // doc.autoPrint();

        var iframe = document.getElementById('printoutput');
        //iframe.src = doc.output('datauristring');
        iframe.src = "/pdf/viewer.html?file=" + doc.output('bloburl');
    }
    else{
        doc.save('bestelling.pdf');
    }
   
});
