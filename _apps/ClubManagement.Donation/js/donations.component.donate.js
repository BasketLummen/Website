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

            // CC registration
            var elements = this.stripe.elements();
            this.card = elements.create("card");
            this.card.mount("#card-element");
        });

        cardForm.addEventListener('submit', async (event) => {
            event.preventDefault();
            
            // Prepare donation
            const donationId = guid();
            const prepareDonation = {
                donationId: donationId,
                amount: donation.value,
                currency: "eur"
            };
            const url = `${this.baseUri}/${donationId}/PrepareDonation`;

            const response = await fetch(url, {
                method: 'POST',
                mode: 'cors',
                cache: 'no-cache',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(prepareDonation),
              });

              var paymentIntent = await response.json();

              var cardHolder = cardForm.querySelector('#card-holder').value;

              var result = await this.stripe.confirmCardPayment(paymentIntent.secret, {
                payment_method: {
                  card: this.card,
                  billing_details: {
                    name: cardHolder
                  }
                }
              });

            // Confirm donation information
            // TODO:
            // testing Stripe CC: 4000002500003155
        });

        var cancel = amountForm.querySelector('#cancel');
        cancel.addEventListener('click', async (event) => {
            event.preventDefault();

            donation.value = 0;
        });
    }
}

export { Donate }