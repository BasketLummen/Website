import { appInsights } from "/js/ai.module.js"

class PurchaseOrderPayment extends HTMLElement {

    constructor(){
        super();

       
    }

    async connectedCallback() {      

        var title = document.createElement("div");
        title.innerText = "TODO: Allow payment";
        this.append(title);

        var confirm = document.createElement("button");        
        confirm.innerText = "Pay";
        confirm.addEventListener("click", (event) => this.dispatchEvent(new Event('confirm')));

        this.append(confirm);

        appInsights.trackEvent({
            name: "PurchaseOrderPaymentRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderPayment }