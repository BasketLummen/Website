import { club } from "/js/club.config.js"
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js"
import { appInsights } from "/js/ai.module.js"
import { guid } from "/js/clubmanagement.guid.js"

class PurchaseOrderPayment extends HTMLElement {

    constructor(){
        super();
        
        this.template = document.getElementById("clubmgmt-purchase-order-payment-template");
        this.paymentMethodTemplate = document.getElementById("clubmgmt-purchase-order-payment-method-template");
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
        const content = this.template.content.cloneNode(true);
        const form = content.querySelector("#orderPayment");
        const table = content.querySelector("#paymentMethodOptions");
                
        const sale = await this.loadSale();
        
        if (sale.allowedPaymentMethodTypes.length === 0) {
            sale.allowedPaymentMethodTypes.push({
                id: "cash", name: "Cash"
            });    
        }

        for (let paymentMethodType of sale.allowedPaymentMethodTypes) {
            const rowContent = this.paymentMethodTemplate.content.cloneNode(true)
            this.renderPaymentMethodOption(rowContent, paymentMethodType.id, paymentMethodType.name);
            table.append(rowContent);
        }
        
        this.append(content);
        
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
        const uri = `${salesConfig.salesService}/api/sales/${club.organizationId}/${this.saleId}`;
        const request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            }
        });
        return await request.json();
    }
    
    renderPaymentMethodOption(rowElement, paymentMethodId, paymentMethodName) {
        const radioButton = rowElement.querySelector("input[type='radio']");
        radioButton.setAttribute("value", paymentMethodId);
                
        const title = rowElement.querySelector("span");
        title.innerText = paymentMethodName;
    }
}

export { PurchaseOrderPayment }