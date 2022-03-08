import { Controller } from "stimulus";
import { annotate } from 'rough-notation';

export default class extends Controller {
  static targets = [ "" ]

  connect() {
    const spans = document.querySelectorAll(".banner-highlight-primary");

    spans.forEach(span => {
      const annotation = annotate(span, { type: 'highlight', color: '#6768AB', animationDuration: 2000 });
      annotation.show();

    });
    }
}
