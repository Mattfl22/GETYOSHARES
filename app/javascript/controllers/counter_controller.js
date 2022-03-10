import { TimeScale } from "chart.js";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "quantity", "plus", "minus", "price", "subtotal" ]

  connect() {
    this.quantity = 0;
    this.subtotalTarget.innerText = (1 * this.priceTarget.innerText).toLocaleString('en-US');
  }

  increment() {
    var max = quantity.max;
    if (this.quantity++ < max) {
      this.quantityTarget.value = this.quantity;
      this.subtotalTarget.innerText = (this.quantity * this.priceTarget.innerText).toLocaleString('en-US');
    } else {
      this.quantity = max;
    }
  }

  decrement () {
    var min = 0;
    if (this.quantity-- > 0) {
      this.quantityTarget.value = this.quantity;
      this.subtotalTarget.innerText = (this.quantity * this.priceTarget.innerText).toLocaleString('en-US');
    } else {
      this.quantity = min;
    }
  }
}
