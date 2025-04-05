import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  hide() {
    console.log("FECHANDO")
    this.element.parentElement.removeAttribute("src");
    this.element.remove();
  }

  /*connect() {
    this.element.focus();
  }

  hide(event) {
    event.preventDefault();

    this.element.remove();
  }

  hideOnSubmit(event) {
    if (event.detail.success) {
      this.hide();
    }
  }

  disconnect() {
    this.#modalTurboFrame.src = null;
  }

  get #modalTurboFrame() {
    return document.querySelector("turbo-frame[id='cobra-modal']");
  }*/
}
