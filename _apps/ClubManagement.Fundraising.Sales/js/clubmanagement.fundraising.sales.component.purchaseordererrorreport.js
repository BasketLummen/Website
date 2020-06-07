import { appInsights } from "/js/ai.module.js"

class PurchaseOrderErrorReport extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("clubmgmt-purchase-order-error-report-template");
    }

    static get observedAttributes() {
        return ['order-id', 'data-error'];
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
    
    get error() {
		return this.getAttribute('data-error');
  	}

    set error(val) {
        if (val) {
            this.setAttribute('data-error', val);
        } else {
            this.removeAttribute('data-error');
        }
    }

    async connectedCallback() {      

        var content = this.template.content.cloneNode(true);

        var messages = content.querySelectorAll(".error-message");
        messages.forEach(message => {
            message.innerText = this.error;
        });

        this.append(content);

        appInsights.trackEvent({
            name: "PurchaseOrderErrorReportRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderErrorReport }