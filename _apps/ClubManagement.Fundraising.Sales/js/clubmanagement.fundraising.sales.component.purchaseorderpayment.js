import { club } from "/js/club.config.js"
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js"
import shell from "/js/dish.shell.js"
import { guid } from "/js/clubmanagement.guid.js"
import { StripeClient } from "./clubmanagement.payments.stripe.js"
import monitoring from "./dish.shell.monitoring.applicationinsights.app.js";

class PurchaseOrderPayment extends HTMLElement {

    constructor(){
        super();
        
        this.template = document.getElementById("clubmgmt-purchase-order-payment-template");
        this.paymentMethodTemplate = document.getElementById("clubmgmt-purchase-order-payment-method-template");

        this.paymentsBaseUri = salesConfig.paymentsService + "/api/payments";       
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
            const amount = {
                value: this.context.total,
                currency: this.getCurrencyCode(this.context.currency)
            };
            const payer = {
                id: this.context.buyer.id,
                name: this.context.buyer.name,
                email: this.context.buyer.email,
                preferedLanguage: "nl"
            };
            const beneficiary = {
                id: club.organizationId,
                name: club.name
            };
            const metadata = {
                paymentType: "purchase-order",
                orderId: this.context.orderId,
                saleId: this.context.saleId
            };
            var href = window.location.href.split('?')[0];
            const settings = {
                sendConfirmation: this.context.sendConfirmation,
                returnUrl: `${href}?s=confirm&o=${this.context.orderId}`,
                paymentToken: sale.paymentToken
            };

            const result = await selector.startPayment(
                paymentId,
                amount,
                payer,
                beneficiary,
                metadata,
                settings
            );

            if (result.error) {
                this.dispatchEvent(new CustomEvent('error', {
                    detail: {
                        error: "Purchase order payment failed",
                        orderId: this.context.orderId
                    }
                }));
            }
            
            this.dispatchEvent(new Event('confirm'));
        });

        monitoring.appInsights.trackEvent({
            name: "PurchaseOrderPaymentRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }

    async loadSale(){
        const uri = `${salesConfig.salesService}/api/sales/${club.organizationId}/${this.context.saleId}`;
        const request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            }
        });
        return await request.json();
    }
    
    getCurrencyCode(currencySymbol) {
        if (currencySymbol === "€") {
            return "eur"
        }

        return currencySymbol;
    }
}

export { PurchaseOrderPayment }