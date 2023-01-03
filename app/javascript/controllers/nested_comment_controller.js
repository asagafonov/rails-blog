import { Controller } from '@hotwired/stimulus';
import i18n from '../packs/application';

export default class extends Controller {
  static targets = ['form', 'input', 'button'];
  static values = { visible: Boolean }

  show() {
    const formElement = this.formTarget;
    const button = this.buttonTarget;

    this.visibleValue = !this.visibleValue;
    formElement.style.display = this.visibleValue ? 'block' : 'none';
    button.textContent = this.visibleValue ? i18n.t('comments.cancel') : i18n.t('comments.respond');
    if (this.visibleValue) {
      this.inputTarget.focus();
    }
  }
}