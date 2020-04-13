class Donate extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById('donation-template');
    }

    async connectedCallback() {
        this.innerHTML = this.template.innerHTML;

        var form = this.querySelector('.responsive-form');

        var donate5 = this.querySelector("#donate5");
        var donate10 = this.querySelector("#donate10");
        var donate20 = this.querySelector("#donate20");
        var donateOther = this.querySelector("#donateOther");

        form.addEventListener('submit', async (event) => {
            event.preventDefault();
        });

        form.addEventListener('cancel', async (event) => {
            event.preventDefault();
        });
    }
}

export { Donate }