import { appInsights } from "/js/ai.module.js"

class PurchaseOrderConfirmation extends HTMLElement {

    constructor(){
        super();

       
    }

    async connectedCallback() {      

        appInsights.trackEvent({
            name: "PurchaseOrderConfirmationRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderConfirmation }