import { appInsights } from "/js/ai.module.js"

class PurchaseOrderPayment extends HTMLElement {

    constructor(){
        super();       
    }

    static get observedAttributes() {
        return ['order-total'];
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

    get currency() {
		return this.getAttribute('order-currency');
  	}

    set currency(val) {
        if (val) {
            this.setAttribute('order-currency', val);
        } else {
            this.removeAttribute('order-currency');
        }
    }
    
    get total() {
		return this.getAttribute('order-total');
  	}

 	 set total(val) {
		if (val) {
			this.setAttribute('order-total', val);
		} else {
			this.removeAttribute('order-total');
		}
  	} 

    async connectedCallback() {      

        var title = document.createElement("div");
        title.innerText = "TODO: Set up payment for order " + this.orderId + " amount: " + this.currency + this.total;
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