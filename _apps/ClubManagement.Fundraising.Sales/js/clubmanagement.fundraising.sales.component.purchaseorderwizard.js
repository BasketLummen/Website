import shell from "/js/dish.shell.js";
import { queryString } from "/js/clubmanagement.querystring.js";
import monitoring from "./dish.shell.monitoring.applicationinsights.app.js";
import { StripeClient } from "./clubmanagement.payments.stripe.js";
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js";

class PurchaseOrderWizard extends HTMLElement {

    constructor(){
        super();
    }

    static get observedAttributes() {
      return ['sale-id'];
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

    async connectedCallback() {    

        const step = queryString.get("s");
        const orderId = queryString.get("o");

        if(step == "confirm" && orderId){
   
          //stripe's redirect_status in header, use it to decide outcome
          const redirect_status = queryString.get("redirect_status");
          if(redirect_status){
            if (redirect_status === 'succeeded') {
              this.showStep("clubmgmt-purchase-order-confirmation", {
                orderId: orderId,
                saleId: this.saleId
              });
            }
            else if (redirect_status === 'failed' || redirect_status === 'canceled') {
                this.showStep("clubmgmt-purchase-order-error-report", {
                  orderId: orderId,
                  saleId: this.saleId,
                  error: "De betaling werd geweigerd of geannuleerd." 
                });
            }
          }
          //stripe's redirect_status missing
          else{
            const payment_intent = queryString.get("payment_intent");
            const payment_intent_client_secret = queryString.get("payment_intent_client_secret");

             //stripe's payment_intent and payment_intent_client_secret in header, use it to decide outcome
            if(payment_intent && payment_intent_client_secret){

              var loader = new StripeClient();
              await loader.ensureScriptIsLoaded();

              var stripe = Stripe(salesConfig.stripeKey);
              const {paymentIntent, error} = await stripe.retrievePaymentIntent(payment_intent_client_secret);
              if (error) {
                this.showStep("clubmgmt-purchase-order-error-report", {
                  orderId: orderId,
                  saleId: this.saleId,
                  error: "De betaling werd geweigerd of geannuleerd." 
                });
              } else if (paymentIntent && paymentIntent.status === 'succeeded') {
                this.showStep("clubmgmt-purchase-order-confirmation", {
                  orderId: orderId,
                  saleId: this.saleId
                });
              }
              else {
                this.showStep("clubmgmt-purchase-order-error-report", {
                  orderId: orderId,
                  saleId: this.saleId,
                  error: "De betaling werd geweigerd of geannuleerd." 
                });
              }
            }

            //no headers, means redirect from the payment page directly 
            else{
              this.showStep("clubmgmt-purchase-order-confirmation", {
                orderId: orderId,
                saleId: this.saleId
              });
            }
          }
        }
        else{
          this.showStep( "clubmgmt-purchase-order-form", {
            saleId: this.saleId
          }); 
        }       

        monitoring.appInsights.trackEvent({
            name: "PurchaseOrderWizardRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }

    showStep(name, context){
        
        this.innerHTML = '';
        
        var step = document.createElement(name);
        step.setAttribute("data-context", JSON.stringify(context));

        step.addEventListener("pay", (event) => {
            this.showStep("clubmgmt-purchase-order-payment", step.context);
        } );
        step.addEventListener("confirm", (event) => {
            this.showStep("clubmgmt-purchase-order-confirmation", step.context);
        }); 
        step.addEventListener("error", (event) => {
          var context = step.context;
          context.error = event.detail.error;
          this.showStep("clubmgmt-purchase-order-error-report", context);
      }); 
        step.addEventListener("new", (event) => {
            this.showStep("clubmgmt-purchase-order-form", {
              saleId: step.context.saleId
            });
        });

        this.append(step);       
    }
}

export { PurchaseOrderWizard }