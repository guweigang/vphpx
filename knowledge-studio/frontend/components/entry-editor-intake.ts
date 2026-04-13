import { LitElement, html } from "lit";
import { Editor, defaultValueCtx, rootCtx } from "@milkdown/kit/core";
import { commonmark } from "@milkdown/kit/preset/commonmark";
import { listener, listenerCtx } from "@milkdown/kit/plugin/listener";
import { replaceAll } from "@milkdown/kit/utils";
import "@milkdown/kit/prose/view/style/prosemirror.css";

class KsEntryEditorIntake extends LitElement {
  static properties = {
    titleInput: { attribute: "title-input" },
    bodyInput: { attribute: "body-input" },
    kindInput: { attribute: "kind-input" },
    emptyLabel: { attribute: "empty-label" },
    activeLabel: { attribute: "active-label" },
    helperPrefix: { attribute: "helper-prefix" }
  };

  titleInput = 'input[name="title"]';
  bodyInput = 'textarea[name="body"]';
  kindInput = 'select[name="kind"]';
  emptyLabel = "";
  activeLabel = "";
  helperPrefix = "";
  #title = "";
  #body = "";
  #kind = "faq";
  #mode: "source" | "wysiwyg" = "wysiwyg";
  #editor: Editor | null = null;
  #editorBoot: Promise<void> | null = null;
  #editorRoot: HTMLDivElement | null = null;
  #boundListener?: EventListener;
  #lastMarkdown = "";
  #initialTitle = "";
  #initialBody = "";
  #initialKind = "";
  #bootstrappedDraft = false;

  createRenderRoot(): this {
    return this;
  }

  connectedCallback(): void {
    super.connectedCallback();
    window.addEventListener("vphp:live:patched", this.#handleRuntimeRefresh);
    window.addEventListener("vphp:live:props", this.#handleRuntimeRefresh);
  }

  disconnectedCallback(): void {
    window.removeEventListener("vphp:live:patched", this.#handleRuntimeRefresh);
    window.removeEventListener("vphp:live:props", this.#handleRuntimeRefresh);
    this.#unbindFields();
    void this.#destroyEditor();
    super.disconnectedCallback();
  }

  protected firstUpdated(): void {
    this.#bindFields();
    void this.#ensureEditor();
  }

  protected updated(): void {
    this.#editorRoot = this.querySelector<HTMLDivElement>("[data-milkdown-root]");
    void this.#ensureEditor();
  }

  protected render() {
    const title = this.#title.trim() || this.emptyLabel;
    const status = this.#title.trim() !== "" || this.#body.trim() !== "" ? this.activeLabel : this.emptyLabel;
    const draftStatus = this.#isDirty() ? "未保存变更" : "已与页面初始版本对齐";

    return html`
      <style>
        .ks-entry-shell {
          margin: 1rem 0 1.25rem;
          border: 1px solid rgba(69, 53, 35, 0.12);
          border-radius: 28px;
          background: linear-gradient(180deg, rgba(255, 252, 247, 0.96), rgba(250, 243, 233, 0.88));
          box-shadow: 0 18px 40px rgba(52, 43, 32, 0.08);
          overflow: hidden;
        }

        .ks-entry-meta {
          display: flex;
          flex-wrap: wrap;
          gap: 0.75rem;
          align-items: center;
          justify-content: space-between;
          padding: 1rem 1.2rem;
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(255, 255, 255, 0.66);
        }

        .ks-entry-badges {
          display: flex;
          flex-wrap: wrap;
          gap: 0.55rem;
        }

        .ks-entry-badge {
          display: inline-flex;
          align-items: center;
          border-radius: 999px;
          padding: 0.45rem 0.8rem;
          background: #201a17;
          color: #fff9f1;
          font-size: 0.78rem;
          font-weight: 700;
        }

        .ks-entry-badge.soft {
          background: #efe3d2;
          color: #6b5643;
        }

        .ks-entry-hint {
          margin: 0;
          color: #6b6257;
          font: 500 0.9rem/1.6 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-entry-toolbar {
          display: flex;
          flex-wrap: wrap;
          gap: 0.65rem;
          padding: 0.85rem 1.2rem;
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(247, 239, 227, 0.7);
        }

        .ks-form .ks-entry-tool,
        .ks-entry-tool {
          display: inline-flex;
          align-items: center;
          justify-content: center;
          min-height: 0;
          width: auto;
          border: none;
          border-radius: 999px;
          padding: 0.55rem 0.9rem;
          background: #efe3d2;
          color: #5f4c3a;
          font: 700 0.82rem/1 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
          cursor: pointer;
          box-shadow: none;
          white-space: nowrap;
          -webkit-text-fill-color: currentColor;
        }

        .ks-form .ks-entry-tool.primary,
        .ks-entry-tool.primary {
          background: #201a17;
          color: #fff9f1;
        }

        .ks-entry-stage {
          border-top: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(255, 252, 247, 0.68);
        }

        .ks-entry-stage-head {
          display: flex;
          align-items: center;
          justify-content: space-between;
          gap: 1rem;
          padding: 1rem 1.2rem 0.85rem;
          background: rgba(247, 239, 227, 0.84);
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
        }

        .ks-entry-stage-title {
          margin: 0;
          color: #1f1711;
          font: 700 1.02rem/1.2 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-entry-stage-copy {
          margin: 0.35rem 0 0;
          color: #7a6653;
          font: 500 0.84rem/1.5 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-entry-stage-badge {
          display: inline-flex;
          align-items: center;
          border-radius: 999px;
          padding: 0.42rem 0.78rem;
          background: #1f1711;
          color: #fff8ef;
          font: 700 0.76rem/1 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-entry-tabs {
          display: flex;
          gap: 0.7rem;
          padding: 0.85rem 1.2rem;
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(255, 252, 247, 0.74);
        }

        .ks-form .ks-entry-tab,
        .ks-entry-tab {
          display: inline-flex;
          align-items: center;
          justify-content: center;
          min-height: 0;
          border: 1px solid rgba(69, 53, 35, 0.14);
          border-radius: 999px;
          padding: 0.62rem 1rem;
          background: rgba(255, 255, 255, 0.82);
          color: #6b5643;
          font: 700 0.84rem/1 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
          box-shadow: none;
          cursor: pointer;
          -webkit-text-fill-color: currentColor;
        }

        .ks-form .ks-entry-tab.active,
        .ks-entry-tab.active {
          background: #201a17;
          color: #fff8ef;
          border-color: #201a17;
        }

        .ks-entry-panel {
          display: none;
        }

        .ks-entry-panel.active {
          display: block;
        }

        .ks-entry-root,
        .ks-entry-source-wrap {
          min-height: 560px;
          background:
            linear-gradient(180deg, rgba(255, 255, 255, 0.98), rgba(250, 244, 235, 0.98)),
            repeating-linear-gradient(
              0deg,
              rgba(165, 139, 112, 0.08),
              rgba(165, 139, 112, 0.08) 1px,
              transparent 1px,
              transparent 32px
            );
        }

        .ks-entry-root {
          padding: 1.1rem 1.2rem 1.35rem;
        }

        .ks-entry-source-wrap {
          padding: 1rem 1.2rem 1.35rem;
        }

        .ks-entry-source {
          width: 100%;
          min-height: 520px;
          resize: vertical;
          border: 1px solid rgba(69, 53, 35, 0.14);
          border-radius: 22px;
          background: rgba(255, 255, 255, 0.94);
          padding: 1.1rem 1.15rem;
          color: #241c16;
          font: 500 15px/1.75 "SFMono-Regular", "Menlo", "Consolas", monospace;
          outline: none;
        }

        .ks-entry-root .milkdown {
          color: #241c16;
          font: 400 1rem/1.75 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-entry-root .ProseMirror {
          min-height: 480px;
          padding: 1.25rem 1.25rem 2rem;
          border: none;
          outline: none;
          white-space: pre-wrap;
        }

        .ks-entry-root .ProseMirror::before {
          content: "在这里维护 FAQ 或主题条目的所见即所得正文，排版结果会同步回 Markdown 源码。";
          display: block;
          margin-bottom: 0.85rem;
          color: #9a826b;
          font: 600 0.82rem/1.4 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }
      </style>
      <section class="ks-entry-shell" data-vphp-preserve="milkdown-entry-editor">
        <div class="ks-entry-meta">
          <div class="ks-entry-badges">
            <span class="ks-entry-badge">${status}</span>
            <span class="ks-entry-badge soft">${draftStatus}</span>
            <span class="ks-entry-badge soft">${this.helperPrefix} ${title}</span>
            <span class="ks-entry-badge soft">${this.#kind || "faq"}</span>
            <span class="ks-entry-badge soft">body ${this.#body.trim().length}</span>
          </div>
          <p class="ks-entry-hint">条目正文现在是全宽主编辑面，可在 Markdown 源码与所见即所得之间切换。</p>
        </div>
        <div class="ks-entry-toolbar">
          <button class="ks-entry-tool primary" type="button" @click=${() => this.#applyStarterDraft()}>生成条目草稿</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#wrapSelection("## ", "")}>H2 标题</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#wrapSelection("**", "**")}>加粗</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#insertSnippet("- 要点一\\n- 要点二\\n- 要点三")}>列表</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#insertSnippet("> 这里整理面对用户时的标准回答口径")}>引用</button>
        </div>
        <div class="ks-entry-stage">
          <div class="ks-entry-stage-head">
            <div>
              <h3 class="ks-entry-stage-title">条目正文编辑器</h3>
              <p class="ks-entry-stage-copy">源码模式直接维护 Markdown，所见即所得模式用 Milkdown 做可视化编辑，两边共用同一份条目正文。</p>
            </div>
            <span class="ks-entry-stage-badge">${this.#mode === "source" ? "Markdown Source" : "Milkdown WYSIWYG"}</span>
          </div>
          <div class="ks-entry-tabs">
            <button class=${this.#mode === "source" ? "ks-entry-tab active" : "ks-entry-tab"} type="button" @click=${() => this.#setMode("source")}>Markdown 源码</button>
            <button class=${this.#mode === "wysiwyg" ? "ks-entry-tab active" : "ks-entry-tab"} type="button" @click=${() => this.#setMode("wysiwyg")}>所见即所得</button>
          </div>
          <div class=${this.#mode === "source" ? "ks-entry-panel active" : "ks-entry-panel"}>
            <div class="ks-entry-source-wrap">
              <textarea class="ks-entry-source" .value=${this.#body} @input=${this.#handleSourceInput} spellcheck="false"></textarea>
            </div>
          </div>
          <div class=${this.#mode === "wysiwyg" ? "ks-entry-panel active" : "ks-entry-panel"}>
            <div class="ks-entry-root" data-milkdown-root></div>
          </div>
        </div>
      </section>
    `;
  }

  async #ensureEditor(): Promise<void> {
    if (this.#editor || this.#editorBoot || !this.isConnected) {
      return;
    }
    const bodyField = this.#field<HTMLTextAreaElement>(this.bodyInput);
    if (!bodyField) {
      return;
    }
    if (!this.#editorRoot) {
      this.#editorRoot = this.querySelector<HTMLDivElement>("[data-milkdown-root]");
    }
    if (!this.#editorRoot) {
      return;
    }

    this.#syncFields();
    this.#ensureStarterDraft();
    this.#captureInitialState();
    this.#hideBodyField(bodyField);

    this.#editorBoot = (async () => {
      try {
        const editor = Editor.make()
          .config((ctx) => {
            ctx.set(rootCtx, this.#editorRoot as HTMLDivElement);
            ctx.set(defaultValueCtx, bodyField.value || "");
          })
          .use(commonmark)
          .use(listener)
          .config((ctx) => {
            ctx.get(listenerCtx).markdownUpdated((_ctx, markdown) => {
              this.#lastMarkdown = markdown;
              this.#writeBody(markdown, true);
            });
          });
        this.#editor = await editor.create();
        this.#lastMarkdown = bodyField.value || "";
        this.requestUpdate();
      } catch (error) {
        console.error("milkdown_entry_boot_failed", error);
        this.#showBodyField(bodyField);
      } finally {
        this.#editorBoot = null;
      }
    })();
    await this.#editorBoot;
  }

  async #destroyEditor(): Promise<void> {
    if (!this.#editor) {
      return;
    }
    const editor = this.#editor;
    this.#editor = null;
    await editor.destroy();
  }

  #bindFields(): void {
    this.#unbindFields();
    const form = this.closest("form");
    if (!form) {
      return;
    }
    this.#syncFields();
    this.#boundListener = () => {
      this.#syncFields();
      this.requestUpdate();
      void this.#syncExternalBodyIntoEditor();
    };
    form.addEventListener("input", this.#boundListener);
    form.addEventListener("change", this.#boundListener);
  }

  #unbindFields(): void {
    const form = this.closest("form");
    if (!form || !this.#boundListener) {
      return;
    }
    form.removeEventListener("input", this.#boundListener);
    form.removeEventListener("change", this.#boundListener);
    this.#boundListener = undefined;
  }

  #syncFields(): void {
    this.#title = this.#field<HTMLInputElement>(this.titleInput)?.value ?? "";
    this.#body = this.#field<HTMLTextAreaElement>(this.bodyInput)?.value ?? "";
    this.#kind = this.#field<HTMLSelectElement>(this.kindInput)?.value ?? "faq";
  }

  #captureInitialState(): void {
    if (this.#initialTitle !== "" || this.#initialBody !== "" || this.#initialKind !== "") {
      return;
    }
    this.#initialTitle = this.#title;
    this.#initialBody = this.#body;
    this.#initialKind = this.#kind;
  }

  #isDirty(): boolean {
    return this.#title !== this.#initialTitle
      || this.#body !== this.#initialBody
      || this.#kind !== this.#initialKind;
  }

  #setMode(mode: "source" | "wysiwyg"): void {
    this.#mode = mode;
    this.requestUpdate();
    if (mode === "wysiwyg") {
      void this.#syncExternalBodyIntoEditor();
    }
  }

  #ensureStarterDraft(): void {
    if (this.#bootstrappedDraft) {
      return;
    }
    const body = this.#body.trim();
    const title = this.#title.trim();
    if (body !== "" && body !== title) {
      return;
    }
    this.#bootstrappedDraft = true;
    this.#applyStarterDraft();
  }

  async #syncExternalBodyIntoEditor(): Promise<void> {
    const body = this.#field<HTMLTextAreaElement>(this.bodyInput);
    if (!body || !this.#editor) {
      return;
    }
    const nextValue = body.value ?? "";
    if (nextValue === this.#lastMarkdown) {
      return;
    }
    this.#lastMarkdown = nextValue;
    this.#editor.action(replaceAll(nextValue, true));
    this.requestUpdate();
  }

  #writeBody(markdown: string, bubble: boolean): void {
    const body = this.#field<HTMLTextAreaElement>(this.bodyInput);
    if (!body) {
      return;
    }
    if (body.value !== markdown) {
      body.value = markdown;
      if (bubble) {
        body.dispatchEvent(new Event("input", { bubbles: true }));
      }
    }
    this.#syncFields();
    this.requestUpdate();
  }

  #applyStarterDraft(): void {
    const title = this.#title.trim() || "Untitled Entry";
    const kindLabel = this.#kind === "topic" ? "主题说明" : "常见问题";
    const nextMarkdown = [
      `# ${title}`,
      "",
      `> ${kindLabel}`,
      "",
      "## 标准回答",
      "在这里先给出最短、最稳定的一段回答。",
      "",
      "## 关键要点",
      "- 适用范围：",
      "- 不适用范围：",
      "- 风险提醒：",
      "",
      "## 对外表达",
      "1. ",
      "2. ",
      "3. "
    ].join("\n");
    this.#bootstrappedDraft = true;
    this.#writeBody(nextMarkdown, true);
    void this.#syncExternalBodyIntoEditor();
  }

  #insertSnippet(snippet: string): void {
    const current = this.#body ?? "";
    const prefix = current.trim() === "" ? "" : "\n\n";
    this.#writeBody(`${current}${prefix}${snippet}`, true);
    void this.#syncExternalBodyIntoEditor();
  }

  #wrapSelection(prefix: string, suffix: string): void {
    const source = this.querySelector<HTMLTextAreaElement>(".ks-entry-source");
    if (this.#mode === "source" && source) {
      const current = source.value ?? "";
      const start = source.selectionStart ?? current.length;
      const end = source.selectionEnd ?? current.length;
      const selected = current.slice(start, end) || "内容";
      const next = `${current.slice(0, start)}${prefix}${selected}${suffix}${current.slice(end)}`;
      this.#writeBody(next, true);
      requestAnimationFrame(() => {
        const updated = this.querySelector<HTMLTextAreaElement>(".ks-entry-source");
        if (!updated) {
          return;
        }
        const cursor = start + prefix.length + selected.length + suffix.length;
        updated.focus();
        updated.setSelectionRange(cursor, cursor);
      });
      void this.#syncExternalBodyIntoEditor();
      return;
    }

    const current = this.#body ?? "";
    const next = `${current}${current.trim() === "" ? "" : "\n\n"}${prefix}内容${suffix}`;
    this.#writeBody(next, true);
    void this.#syncExternalBodyIntoEditor();
  }

  #hideBodyField(field: HTMLTextAreaElement): void {
    field.setAttribute("data-enhanced-editor", "milkdown-entry");
    field.style.display = "none";
  }

  #showBodyField(field: HTMLTextAreaElement): void {
    field.style.display = "";
    field.removeAttribute("data-enhanced-editor");
  }

  #field<T extends Element>(selector: string): T | null {
    const parent = this.parentElement;
    if (!parent) {
      return null;
    }
    const node = parent.querySelector(selector);
    return node instanceof Element ? (node as T) : null;
  }

  #handleSourceInput = (event: Event): void => {
    const target = event.currentTarget;
    if (!(target instanceof HTMLTextAreaElement)) {
      return;
    }
    this.#writeBody(target.value, true);
    void this.#syncExternalBodyIntoEditor();
  };

  #handleRuntimeRefresh = (): void => {
    this.#syncFields();
    void this.#syncExternalBodyIntoEditor();
    if (!this.#editor) {
      void this.#ensureEditor();
    }
    this.requestUpdate();
  };
}

customElements.define("ks-entry-editor-intake", KsEntryEditorIntake);
