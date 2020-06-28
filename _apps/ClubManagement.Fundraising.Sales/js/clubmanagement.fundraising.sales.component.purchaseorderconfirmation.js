import { appInsights } from "/js/ai.module.js"

class PurchaseOrderConfirmation extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("clubmgmt-purchase-order-confirmation-template");
    }

    static get observedAttributes() {
        return ['data-context'];
    }

    get contextData() {
        return this.getAttribute('data-context');
    }

    set contextData(val) {
        if (val) {
            this.setAttribute('data-context', val);
        } else {
            this.removeAttribute('data-context');
        }
    }

    async connectedCallback() {

        this.context = JSON.parse(this.contextData);
      

        var content = this.template.content.cloneNode(true);

        var pdflinks = content.querySelectorAll(".pdf-link");
        pdflinks.forEach(link => {
            var href = link.getAttribute("href");
            href += "?o=" +  this.context.orderId;
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