import { appInsights } from "/js/ai.module.js"

class PurchaseOrderPdf extends HTMLElement {

    constructor(){
        super();

       
    }

    async connectedCallback() {      

        appInsights.trackEvent({
            name: "PurchaseOrderPdfRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderPdf }