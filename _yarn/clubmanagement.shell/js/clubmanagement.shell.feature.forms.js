import { SubmitButton } from "./shell/components/clubmanagement.shell.component.submit-button.js"

class FormsFeature{
    
    constructor(){
        this.name = "Shell.Forms"

        this.isActive = true;
    }
    

    initialize(){    
        if(this.isActive){
            if (typeof(SubmitButton) === "function") customElements.define('submit-button', SubmitButton);
            // if (typeof(CancelButton) === "function") customElements.define('cancel-button', CancelButton);
            // if (typeof(DatePicker) === "function") customElements.define('date-picker', DatePicker);
        }        
    }

}

export { FormsFeature }