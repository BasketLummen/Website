import shell from "/js/dish.shell.js"
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
          this.showStep("clubmgmt-purchase-order-confirmation", {
            orderId: orderId,
            saleId: this.saleId
          });
        }
        else{
          this.showStep( "clubmgmt-purchase-order-form", {
            saleId: this.saleId
          }); 
        }       

        shell.appInsights.trackEvent({
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