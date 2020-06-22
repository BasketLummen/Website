// import { SubmitButton } from "./shell/components/clubmanagement.shell.component.submit-button.js"

// (function() {
	// customElements.define('submit-button', SubmitButton);
 // })();
 import { FormsFeature } from "./clubmanagement.shell.feature.forms.js";
 
 if (!window.apps) {
    window.apps = {};
}

class AppShell{
    
    constructor(){
        this.name = "Shell"

        this.features = [];
       // this.topics = new Topics();
    }

    registerFeatures(){
        // if (typeof(MenusFeature) === "function") this.features.push(new MenusFeature());
        // if (typeof(ActionsFeature) === "function") this.features.push(new ActionsFeature());
        if (typeof(FormsFeature) === "function") this.features.push(new FormsFeature());       
        
        return this.features;
    }

    initialize(){    
        for(var feature of this.features){
            feature.initialize();
        }
    }

}

window.apps.shell = new AppShell();

export { AppShell }