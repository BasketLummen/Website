import { appInsights } from "/js/ai.module.js"

class PurchaseOrderConfirmation extends HTMLElement {

    constructor(){
        super();

       
    }

    async connectedCallback() {      

        var title = document.createElement("div");
        title.innerText = "TODO: Show confirmation";
        this.append(title);

        var oneMore = document.createElement("button");
        oneMore.innerText = "One more";
        oneMore.addEventListener("click", (event) => this.dispatchEvent(new Event('new')));

        this.append(oneMore);

        appInsights.trackEvent({
            name: "PurchaseOrderConfirmationRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderConfirmation }