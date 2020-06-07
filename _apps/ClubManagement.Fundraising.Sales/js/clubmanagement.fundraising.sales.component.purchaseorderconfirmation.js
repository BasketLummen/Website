import { appInsights } from "/js/ai.module.js"

class PurchaseOrderConfirmation extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("clubmgmt-purchase-order-confirmation-template");
    }

    static get observedAttributes() {
        return ['order-id'];
    }
    
    
    get orderId() {
		return this.getAttribute('order-id');
  	}

    set orderId(val) {
        if (val) {
            this.setAttribute('order-id', val);
        } else {
            this.removeAttribute('order-id');
        }
    }

    async connectedCallback() {      

        var content = this.template.content.cloneNode(true);

        var pdflinks = content.querySelectorAll(".pdf-link");
        pdflinks.forEach(link => {
            var href = link.getAttribute("href");
            href += "?o=" +  this.orderId;
            link.setAttribute("href", href);
        });

        this.append(content);

        appInsights.trackEvent({
            name: "PurchaseOrderConfirmationRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderConfirmation }