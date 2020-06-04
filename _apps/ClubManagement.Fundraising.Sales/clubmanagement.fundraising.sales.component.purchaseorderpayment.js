import { appInsights } from "/js/ai.module.js"

class PurchaseOrderPayment extends HTMLElement {

    constructor(){
        super();

       
    }

    async connectedCallback() {      

        appInsights.trackEvent({
            name: "PurchaseOrderPaymentRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderPayment }