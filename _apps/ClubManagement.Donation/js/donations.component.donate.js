class Donate extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("donation-template");
        this.baseUri = "https://clubmgmt-donation-service-test.azurewebsites.net/api/donations";
        this.stripe = Stripe("pk_test_8U57DC7IOjILi4nOIQM3lmVg");
    }

    async connectedCallback() {
        this.innerHTML = this.template.innerHTML;

        var amountForm = this.querySelector('#amount-form');
        var cardForm = this.querySelector('#card-form');

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

        var donationCommand = {
            amount: donation.value
        };

        amountForm.addEventListener('submit', async (event) => {
            event.preventDefault();

            // Request CSA

            // CC registration
            var elements = this.stripe.elements();
            var card = elements.create("card");
            card.mount("#card-element");

            // Submit donation information to the CM
            // const donationId = guid();
            // const requestStrongCustomerAuthentication = { donationId: donationId };
            // const url = `${this.baseUri}/${donationId}/requestStrongCustomerAuthentication`;

            // const response = await fetch(url, {
            //     method: 'POST',
            //     mode: 'cors',
            //     cache: 'no-cache',
            //     headers: { 'Content-Type': 'application/json' },
            //     body: JSON.stringify(requestStrongCustomerAuthentication),
            //   });

            //   var scaResponse = await response.json();
        });

        var cancel = amountForm.querySelector('#cancel');
        cancel.addEventListener('click', async (event) => {
            event.preventDefault();

            donation.value = 0;
        });
    }
}

export { Donate }