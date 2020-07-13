import { LightningElement, api } from "lwc";

export default class CustomDatatablePicklist extends LightningElement {
  @api context = "";
  @api disabled = false;
  @api value = false;

  handleChange(event) {
    this.value = event.detail.checked;
    this.dispatchEvent(
      new CustomEvent("comboboxchange", {
        bubbles: true,
        composed: true,
        detail: {
          context: this.context,
          value: this.value
        }
      })
    );
  }
}
