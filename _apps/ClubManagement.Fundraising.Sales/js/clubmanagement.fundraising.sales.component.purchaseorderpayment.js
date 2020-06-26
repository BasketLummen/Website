import { club } from "/js/club.config.js"
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js"
import { appInsights } from "/js/ai.module.js"
import { guid } from "/js/clubmanagement.guid.js"

import { StripeClient } from "./clubmanagement.payments.stripe.js"

class PurchaseOrderPayment extends HTMLElement {

    constructor(){
        super();
        
        this.template = document.getElementById("clubmgmt-purchase-order-payment-template");
        this.paymentMethodTemplate = document.getElementById("clubmgmt-purchase-order-payment-method-template");

        this.paymentsBaseUri = salesConfig.paymentsService + "/api/payments";       
        
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


        var loader = new StripeClient();
        await loader.ensureScriptIsLoaded();

        // todo, move this into stripe class?
        this.stripe = Stripe(salesConfig.stripeKey);

        const content = this.template.content.cloneNode(true);
        const form = content.querySelector("#orderPayment");
        const selector = content.querySelector("#paymentMethodSelector");
                
        const sale = await this.loadSale();
        
        if (sale.allowedPaymentMethodTypes.length === 0) {
            sale.allowedPaymentMethodTypes.push({
                id: "cash", name: "Cash"
            });    
        }

        selector.setAttribute("allowedPaymentMethods", JSON.stringify(sale.allowedPaymentMethodTypes.map(m => m.id)));

        this.append(content);

        form.addEventListener('submit', async (event) => {
            event.preventDefault();
            
            const paymentId = guid();
            var amount = {
                value: this.total,
                currency: this.getCurrencyCode(this.currency)
            };
            var beneficiary = {
                id: club.organizationId,
                name: club.name
            };
            var metadata = {
                paymentType: "purchase-order",
                orderId: this.orderId,
                saleId: this.saleId
            }
            var settings = {
                return_url: `${window.location.href}?s=confirm&o=${this.orderId}`
            }

            var result = await selector.startPayment(
                paymentId,
                amount,
                beneficiary,
                metadata,
                settings
            );

            // bancontact for sean
        /*    const name = form.querySelector("#name").value;
            
            const preparePayment = {
                paymentId: paymentId,
                amount: {
                    value: this.total,
                    currency: this.getCurrencyCode(this.currency)
                },
                payedBy: {
                    id: null,
                    name: name
                },
                beneficiary: {
                    id: club.organizationId,
                    name: club.name
                },
                paymentMethod: "bancontact",
                metadata: {
                    paymentType: "purchase-order",
                    orderId: this.orderId,
                    saleId: this.saleId
                }
            };
            const url = `${this.paymentsBaseUri}/beneficiaries/${club.organizationId}/${paymentId}/prepare`;

            const response = await fetch(url, {
                method: 'POST',
                mode: 'cors',
                cache: 'no-cache',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(preparePayment),
            });

            const paymentIntent = await response.json();

            // Redirects away from the client
            const {error} = await this.stripe.confirmBancontactPayment(paymentIntent.secret, {
                    payment_method: {
                        billing_details: {
                            name: name
                        }
                    },
                    return_url: `${window.location.href}?s=confirm&o=${this.orderId}`
                }
            );*/

            if (result.error) {
                this.dispatchEvent(new CustomEvent('error', {
                    detail: {
                        error: "Purchase order payment failed",
                        orderId: this.orderId
                    }
                }));
            }
            
            this.dispatchEvent(new Event('confirm'));
        });

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
        const paymentMethodContainer = rowElement.querySelector(".payment-method-container");
        
        const radioButton = rowElement.querySelector("input[type='radio']");
        radioButton.setAttribute("value", paymentMethodId);
        radioButton.addEventListener('change', event => {
            const cssClassToUse = "temporary-payment-method-form";
            this.clearPreviouslySelectedPaymentMethod(cssClassToUse);
            
            // add html elements using template
            const templateId = `clubmgmt-purchase-order-payment-method-${paymentMethodId}-form-template`;
            const templateBody = document.getElementById(templateId);
            
            // cash option has no template
            if (templateBody) {
                const content = templateBody.content.cloneNode(true);

                // add CSS class to remove the form elements when the selection is changing
                for (let node of content.children) {
                    node.classList.add(cssClassToUse);
                }

                paymentMethodContainer.append(content);
            }
        });
                
        const title = rowElement.querySelector("span");
        title.innerText = paymentMethodName;
    }


    clearPreviouslySelectedPaymentMethod() {
        const elements = this.querySelectorAll(`.temporary`);
        for (let element of elements) {
            element.remove();
        }
    }

    getCurrencyCode(currencySymbol) {
        if (currencySymbol === "€") {
            return "eur"
        }

        return currencySymbol;
    }
}

export { PurchaseOrderPayment }