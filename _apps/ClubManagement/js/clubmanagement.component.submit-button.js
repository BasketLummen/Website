class SubmitButton extends HTMLElement {

  constructor() {
    super();

    this.spanContent = this.innerHTML;
    this.template = '<button type="submit"><div><img class="spinner" src="/img/loader-button.gif"></div><div><span></span></div></button>'
  }

  connectedCallback() {
   
    this.innerHTML = this.template;

    var span = this.querySelector("span");
    span.innerHTML = this.spanContent;

    var button = this.querySelector('button[type="submit"]');
    button.addEventListener("click",  (event) => {
      button.disabled = true;
      var txt = this.querySelector("span");
      var width = txt.offsetWidth;
      var spinner = this.querySelector(".spinner");
      spinner.parentNode.style.width = width + "px";
      spinner.style.display = "inline";      
      txt.style.display = "none";
      button.form.dispatchEvent(new Event('submit', {
        'bubbles'    : true, 
        'cancelable' : true  
      }));
    });
  }


}

export { SubmitButton }