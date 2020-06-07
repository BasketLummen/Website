import { appInsights } from "/js/ai.module.js"
import { queryString } from "/js/clubmanagement.querystring.js"

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
          this.showStep("clubmgmt-purchase-order-confirmation", orderId);
        }
        else{
          this.showStep( "clubmgmt-purchase-order-form"); 
        }       

        appInsights.trackEvent({
            name: "PurchaseOrderWizardRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }

    showStep(name, orderId, currency, total, error){
        
        this.innerHTML = '';
        
        var step = document.createElement(name);
        if(orderId) step.setAttribute("order-id", orderId);
        if(total) step.setAttribute("order-total", total);
        if(currency) step.setAttribute("order-currency", currency);
        if(error) step.setAttribute("data-error", error);
        step.setAttribute('sale-id', this.saleId);

        step.addEventListener("pay", (event) => {
            this.showStep("clubmgmt-purchase-order-payment", step.orderId, step.currency, step.total);
        } );
        step.addEventListener("confirm", (event) => {
            this.showStep("clubmgmt-purchase-order-confirmation", step.orderId);
        }); 
        step.addEventListener("error", (event) => {
          this.showStep("clubmgmt-purchase-order-error-report", step.orderId, null, null, event.detail.error);
      }); 
        step.addEventListener("new", (event) => {
            this.showStep("clubmgmt-purchase-order-form");
        });

        this.append(step);       
    }
}

export { PurchaseOrderWizard }