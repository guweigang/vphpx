import { LitElement, css, html } from "lit";

class KsAssistantIntake extends LitElement {
  static properties = {
    textareaSelector: { attribute: "textarea-selector" },
    maxLength: { attribute: "max-length", type: Number },
    emptyLabel: { attribute: "empty-label" },
    activeLabel: { attribute: "active-label" },
    helperPrefix: { attribute: "helper-prefix" }
  };

  static styles = css`
    :host {
      display: block;
    }

    .ks-lit-summary {
      margin-top: 14px;
      padding: 12px 14px;
      border-radius: 14px;
      border: 1px solid rgba(69, 53, 35, 0.14);
      background: rgba(255, 255, 255, 0.78);
      color: #6b6257;
      font: 500 13px/1.6 "Inter", "Helvetica Neue", Helvetica, Arial, sans-serif;
    }

    .ks-lit-summary strong {
      color: #1c1916;
      font-weight: 700;
    }
  `;

  textareaSelector = "textarea";
  maxLength = 240;
  emptyLabel = "";
  activeLabel = "";
  helperPrefix = "";
  #question = "";
  #boundInput?: EventListener;

  connectedCallback(): void {
    super.connectedCallback();
    this.#bindTextarea();
  }

  disconnectedCallback(): void {
    this.#unbindTextarea();
    super.disconnectedCallback();
  }

  protected render() {
    const currentLength = this.#question.trim().length;
    const stateLabel = currentLength > 0 ? this.activeLabel : this.emptyLabel;
    const helperText = currentLength > 0 ? this.#question.trim() : stateLabel;

    return html`
      <div class="ks-lit-summary" data-vphp-preserve>
        <strong>${stateLabel}</strong>
        <div>${this.helperPrefix} ${helperText}</div>
        <div>${currentLength}/${this.maxLength}</div>
      </div>
    `;
  }

  protected firstUpdated(): void {
    this.#bindTextarea();
  }

  private #bindTextarea(): void {
    this.#unbindTextarea();
    const textarea = this.#textarea();
    if (!textarea) {
      return;
    }
    this.#question = textarea.value ?? "";
    this.#boundInput = () => {
      this.#question = textarea.value ?? "";
      this.requestUpdate();
    };
    textarea.addEventListener("input", this.#boundInput);
    textarea.addEventListener("change", this.#boundInput);
  }

  private #unbindTextarea(): void {
    const textarea = this.#textarea();
    if (textarea && this.#boundInput) {
      textarea.removeEventListener("input", this.#boundInput);
      textarea.removeEventListener("change", this.#boundInput);
    }
    this.#boundInput = undefined;
  }

  private #textarea(): HTMLTextAreaElement | null {
    const hostParent = this.parentElement;
    if (!hostParent) {
      return null;
    }
    const field = hostParent.querySelector(this.textareaSelector);
    return field instanceof HTMLTextAreaElement ? field : null;
  }
}

customElements.define("ks-assistant-intake", KsAssistantIntake);
