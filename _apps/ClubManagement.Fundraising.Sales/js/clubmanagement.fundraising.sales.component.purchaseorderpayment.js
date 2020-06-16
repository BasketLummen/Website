import { club } from "/js/club.config.js"
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js"
import { appInsights } from "/js/ai.module.js"
import { guid } from "/js/clubmanagement.guid.js"

class PurchaseOrderPayment extends HTMLElement {

    constructor(){
        super();       
    }

    static get observedAttributes() {
        return ['sale-id', 'order-total', 'order-id', 'order-currency'];
    }

    get saleId() {
        return this.getAttribute('sale-id');
    }

    set saleId(val) {
        if (val) {
            this.setAttribute('sale-id', val);
        } else {
            this.removeAttribute('sale-id');
        }
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

        // const title = document.createElement("div");
        // title.innerText = `TODO: Set up payment for order ${this.orderId} amount: ${this.currency}${this.total}`;
        // this.append(title);
        //
        // const confirm = document.createElement("button");
        // confirm.innerText = "Pay";
        // confirm.addEventListener("click", (event) => {
        //    
        //    
        //     this.dispatchEvent(new Event('confirm'));
        // });
        //
        // this.append(confirm);
        
        
        appInsights.trackEvent({
            name: "PurchaseOrderPaymentRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }

    async loadSale(){
        var uri = `${salesConfig.salesService}/api/sales/${club.organizationId}/${this.saleId}`;
        var request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            }
        });
        return await request.json();
    }
}

export { PurchaseOrderPayment }