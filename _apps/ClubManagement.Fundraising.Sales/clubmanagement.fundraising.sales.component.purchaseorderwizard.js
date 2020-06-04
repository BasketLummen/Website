import { appInsights } from "/js/ai.module.js"

class PurchaseOrderWizard extends HTMLElement {

    constructor(){
        super();

       
    }

    async connectedCallback() {      

        appInsights.trackEvent({
            name: "PurchaseOrderWizardRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderWizard }