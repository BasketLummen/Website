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
        var donation = this.querySelector("#donateOther");

        donate5.addEventListener('click', async (event) =>{
            donation.value = 5;
        });
        donate10.addEventListener('click', async (event) =>{
            donation.value = 10;
        });
        donate20.addEventListener('click', async (event) =>{
            donation.value = 20;
        });

        // Interaction with Stripe
        // CC details, SCA
        // TODO

        // var donationCommand = {
        //     amount: donation.value
        // };

        // form.addEventListener('submit', async (event) => {
        //     event.preventDefault();

        //     await $.ajax({
        //         type: 'POST',
        //         url: '/TODO',
        //         contentType: 'application/json',
        //         data : JSON.stringify(donationCommand),
        //         crossDomain: true
        //     });
        // });

        var cancel = form.querySelector('#cancel');
        cancel.addEventListener('click', async (event) => {
            event.preventDefault();

            donation.value = 0;
        });
    }
}

export { Donate }