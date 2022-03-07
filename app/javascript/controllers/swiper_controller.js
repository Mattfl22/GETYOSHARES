import { Controller } from "stimulus"
import Swiper from 'swiper';

export default class extends Controller {
  static targets = [ "" ]

  connect() {
    const swiper = new Swiper(this.element, {
      loop: true,
    });
  }
}
