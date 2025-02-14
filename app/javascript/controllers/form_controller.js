import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("FormController is connected");
  }

  resetComponent() {
    console.log("resetComponent called"); // Debugging
    setTimeout(() => {
      this.element.reset();
    }, 75);
  }
}
