import shell from "/js/dish.shell.js"
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js"
import { club } from "/js/club.config.js"
import { queryString } from "/js/clubmanagement.querystring.js"
import monitoring from "./dish.shell.monitoring.applicationinsights.app.js";

class PurchaseOrderPdf extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("clubmgmt-purchase-order-pdf-template");        
    }

    async connectedCallback() {      

        if (this.innerHTML !== '') 
        return;

        Handlebars.registerHelper('line-item-total', function(orderLine) {
            return (orderLine.quantity * orderLine.orderedItem.price.value).toFixed(2);
         });
            
        this.innerHTML = '<iframe id="printoutput" style="width:100vw; height: 100vh; border: none"></iframe><div id="confirmation-canvas" style="display: none;"></div>';

        const templateText = this.template.innerHTML
                                    .replace("{{{{raw}}}}", "")
                                    .replace("{{{{/raw}}}}", "");

        const orderId = queryString.get("o");
       
        var confirmation = await this.loadConfirmation(orderId);
        var sale = await this.loadSale(confirmation.saleId);

        if(confirmation.deliveryExpectations && confirmation.deliveryExpectations.deliveryType && confirmation.deliveryExpectations.expectedDeliveryDateRange){          

            var key = "welcome_message";

            if(sale.confirmationMessage.textParts[key]){

                var start = new Date(confirmation.deliveryExpectations.expectedDeliveryDateRange.start);
                var end = new Date(confirmation.deliveryExpectations.expectedDeliveryDateRange.end);

                var instructions = this.format(sale.confirmationMessage.textParts[key], start.toLocaleTimeString("nl-BE", { hour: '2-digit', minute: '2-digit'}), end.toLocaleTimeString("nl-BE", { hour: '2-digit', minute: '2-digit'}));
                sale.confirmationMessage.textParts["welcome_message"] = instructions;
            } 

            key = "delivery_instructions_" + confirmation.deliveryExpectations.deliveryType.toLowerCase();

            if(sale.confirmationMessage.textParts[key]){

                var start = new Date(confirmation.deliveryExpectations.expectedDeliveryDateRange.start);
                var end = new Date(confirmation.deliveryExpectations.expectedDeliveryDateRange.end);

                var instructions = this.format(sale.confirmationMessage.textParts[key], start.toLocaleTimeString("nl-BE", { hour: '2-digit', minute: '2-digit'}), end.toLocaleTimeString("nl-BE", { hour: '2-digit', minute: '2-digit'}));
                sale.confirmationMessage.textParts["delivery_instructions"] = instructions;
            }            
        }
       
        var total = 0;             
        confirmation.orderLines.forEach(function(orderLine){
            total += orderLine.quantity * orderLine.orderedItem.price.value;
        });

        var batches = this.chunkArray(confirmation.orderLines, 40);
       
        const template = Handlebars.compile(templateText);
        const body = template({
            data: {
                confirmation: confirmation,
                batches: batches,
                sale: sale,
                total: this.round(total)
            }
        });

        const canvas = this.querySelector("#confirmation-canvas");
        canvas.innerHTML = body;
        canvas.style.display = "block";
        canvas.style.minHeight = (batches.length * 1222) + "px"; 
        
        const pdf = await html2pdf()
            .set({ 
                html2canvas: { scale: 4, letterRendering: true }, 
                jsPDF: {orientation: 'portrait', unit: 'in', format: 'letter', compressPDF: true},
                //pagebreak: { mode: 'css' } 
            })
            .from(canvas)
            .toPdf()
            .get('pdf');
        
        const documentUrl = pdf.output('bloburl');

        monitoring.appInsights.trackEvent({
            name: "PurchaseOrderPdfRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });

        canvas.style.display = "none";

        const iframe = document.getElementById('printoutput');
        iframe.src = `/pdf/viewer.html?file=${documentUrl}`;
    }

    format(toFormat) {
        var args = Array.prototype.slice.call(arguments, 1);
        return toFormat.replace(/{(\d+)}/g, function(match, number) { 
            return typeof args[number] != 'undefined'
            ? args[number] 
            : match
            ;
        });
    };

    round(number){
		return Math.round((number + Number.EPSILON) * 100) / 100;
	}

    chunkArray(arr, chunk_size){
        var results = [];
        
        while (arr.length) {
            results.push(arr.splice(0, chunk_size));
        }
        
        return results;
    }

    async loadConfirmation(orderId){
        var uri = `${salesConfig.bookingService}/api/orderbookings/confirmation/${orderId}`;
        var request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
              "Content-Type": "application/json"
            }        
        });
        return await request.json();
    }

    async loadSale(saleId){
        var uri = `${salesConfig.salesService}/api/sales/${club.organizationId}/${saleId}`;
        var request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
              "Content-Type": "application/json"
            }        
        });
        return await request.json();
    }
}

export { PurchaseOrderPdf }