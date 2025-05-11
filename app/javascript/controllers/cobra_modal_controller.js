import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cobra-modal"]

  hideModal() {
    this.element.parentElement.removeAttribute("src");
    this.element.parentElement.innerHTML = "";
  }

  submitEnd(e) {
    if (e.detail.success)
      this.hideModal()
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape")
      this.hideModal()
  }
  
  closeBackground(e) {
    if (this.element.dataset.allow_close_background && e.target.id == "cobra-modal-background")
      this.hideModal();
  }
}
