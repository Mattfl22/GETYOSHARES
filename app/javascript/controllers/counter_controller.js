import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "quantity", "plus", "minus" ]

  connect() {
    this.quantity = 0
  }

  increment() {
    var max = quantity.max;
    if (this.quantity++ < max) {
      this.quantityTarget.value = this.quantity;
    } else {
      this.quantity = max;
    }
  }

  decrement () {
    var min = 0;
    if (this.quantity-- > 0) {
      this.quantityTarget.value = this.quantity;
    } else {
      this.quantity = min;
    }
  }
}
