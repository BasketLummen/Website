import { appInsights } from "/js/ai.module.js"

class PurchaseOrderForm extends HTMLElement {

    constructor(){
        super();

       
    }

    async connectedCallback() {      

        appInsights.trackEvent({
            name: "PurchaseOrderFormRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderForm }