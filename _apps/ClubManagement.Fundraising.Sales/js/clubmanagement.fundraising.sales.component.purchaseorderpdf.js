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
            return orderLine.quantity * orderLine.orderedItem.price.value;
         });
         
         Handlebars.registerHelper('order-total', function(confirmation) {
            var total = 0;
             
            confirmation.orderLines.forEach(function(orderLine){
                total += orderLine.quantity * orderLine.orderedItem.price.value;
            });
           
            return total;
        }); 
   
        this.innerHTML = '<iframe id="printoutput" style="width:100vw; height: 100vh; border: none"></iframe><div id="confirmation-canvas" style="display: none;"></div>';

        const templateText = this.template.innerHTML
                                    .replace("{{{{raw}}}}", "")
                                    .replace("{{{{/raw}}}}", "");

        const orderId = queryString.get("o");
       
        var confirmation = await this.loadConfirmation(orderId);
        var sale = await this.loadSale(confirmation.saleId);
        
        const template = Handlebars.compile(templateText);
        const body = template({
            data: {
                confirmation: confirmation,
                sale: sale
            }
        });

        const canvas = this.querySelector("#confirmation-canvas");
        canvas.innerHTML = body;
        canvas.style.display = "block";
        
        const pdf = await html2pdf()
            .set({ html2canvas: { scale: 4, letterRendering: true } })
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