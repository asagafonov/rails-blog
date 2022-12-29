import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['form', 'input', 'button'];
  static values = { visible: Boolean }

  show() {
    const formElement = this.formTarget;
    const button = this.buttonTarget;

    this.visibleValue = !this.visibleValue;
    formElement.style.display = this.visibleValue ? 'block' : 'none';
    button.textContent = this.visibleValue ? 'Отмена' : 'Ответить';
    if (this.visibleValue) {
      this.inputTarget.focus();
    }
  }
}