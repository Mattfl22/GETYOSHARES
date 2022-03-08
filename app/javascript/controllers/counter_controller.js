import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "quantity", "plus", "minus" ]
  
  connect() {
    this.quantity = 0
  }

  increment() {
    this.quantity++;
    this.quantityTarget.value = this.quantity;
  }

  decrement () {
    this.quantity--;
    this.quantityTarget.value = this.quantity;
  }
}
