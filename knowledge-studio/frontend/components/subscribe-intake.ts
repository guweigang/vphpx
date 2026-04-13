import { LitElement, css, html } from "lit";

class KsSubscribeIntake extends LitElement {
  static properties = {
    emailSelector: { attribute: "email-selector" },
    planSelector: { attribute: "plan-selector" },
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

  emailSelector = 'input[type="email"]';
  planSelector = 'select[name="plan"]';
  emptyLabel = "";
  activeLabel = "";
  helperPrefix = "";
  #email = "";
  #plan = "";
  #boundListener?: EventListener;

  connectedCallback(): void {
    super.connectedCallback();
    this.#bindFields();
  }

  disconnectedCallback(): void {
    this.#unbindFields();
    super.disconnectedCallback();
  }

  protected firstUpdated(): void {
    this.#bindFields();
  }

  protected render() {
    const hasEmail = this.#email.trim() !== "";
    const label = hasEmail ? this.activeLabel : this.emptyLabel;
    const plan = this.#plan || "starter";
    const email = this.#email.trim() || label;

    return html`
      <div class="ks-lit-summary" data-vphp-preserve>
        <strong>${label}</strong>
        <div>${this.helperPrefix} ${email}</div>
        <div>Plan: ${plan}</div>
      </div>
    `;
  }

  private #bindFields(): void {
    this.#unbindFields();
    const email = this.#emailField();
    const plan = this.#planField();
    if (!email || !plan) {
      return;
    }
    this.#syncFromFields();
    this.#boundListener = () => {
      this.#syncFromFields();
      this.requestUpdate();
    };
    email.addEventListener("input", this.#boundListener);
    email.addEventListener("change", this.#boundListener);
    plan.addEventListener("change", this.#boundListener);
  }

  private #unbindFields(): void {
    const email = this.#emailField();
    const plan = this.#planField();
    if (this.#boundListener && email) {
      email.removeEventListener("input", this.#boundListener);
      email.removeEventListener("change", this.#boundListener);
    }
    if (this.#boundListener && plan) {
      plan.removeEventListener("change", this.#boundListener);
    }
    this.#boundListener = undefined;
  }

  private #syncFromFields(): void {
    const email = this.#emailField();
    const plan = this.#planField();
    this.#email = email?.value ?? "";
    this.#plan = plan?.value ?? "";
  }

  private #emailField(): HTMLInputElement | null {
    const parent = this.parentElement;
    if (!parent) {
      return null;
    }
    const field = parent.querySelector(this.emailSelector);
    return field instanceof HTMLInputElement ? field : null;
  }

  private #planField(): HTMLSelectElement | null {
    const parent = this.parentElement;
    if (!parent) {
      return null;
    }
    const field = parent.querySelector(this.planSelector);
    return field instanceof HTMLSelectElement ? field : null;
  }
}

customElements.define("ks-subscribe-intake", KsSubscribeIntake);
