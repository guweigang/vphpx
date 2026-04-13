import { LitElement, html } from "lit";
import { Editor, defaultValueCtx, rootCtx } from "@milkdown/kit/core";
import { commonmark } from "@milkdown/kit/preset/commonmark";
import { listener, listenerCtx } from "@milkdown/kit/plugin/listener";
import { replaceAll } from "@milkdown/kit/utils";
import "@milkdown/kit/prose/view/style/prosemirror.css";

class KsDocumentEditorIntake extends LitElement {
  static properties = {
    titleSelector: { attribute: "title-selector" },
    summarySelector: { attribute: "summary-selector" },
    bodySelector: { attribute: "body-selector" },
    emptyLabel: { attribute: "empty-label" },
    activeLabel: { attribute: "active-label" },
    helperPrefix: { attribute: "helper-prefix" }
  };

  titleSelector = 'input[name="title"]';
  summarySelector = 'textarea[name="summary"]';
  bodySelector = 'textarea[name="body"]';
  emptyLabel = "";
  activeLabel = "";
  helperPrefix = "";
  #title = "";
  #summary = "";
  #body = "";
  #mode: "source" | "wysiwyg" = "wysiwyg";
  #editor: Editor | null = null;
  #editorBoot: Promise<void> | null = null;
  #editorRoot: HTMLDivElement | null = null;
  #boundListener?: EventListener;
  #lastMarkdown = "";
  #bootstrappedDraft = false;
  #initialTitle = "";
  #initialSummary = "";
  #initialBody = "";

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
    const active = this.#title.trim() !== "" || this.#summary.trim() !== "" || this.#body.trim() !== "";
    const label = active ? this.activeLabel : this.emptyLabel;
    const isDirty = this.#isDirty();
    const draftStatus = isDirty ? "未保存变更" : "已与页面初始版本对齐";

    return html`
      <style>
        .ks-md-shell {
          margin: 1rem 0 1.25rem;
          border: 1px solid rgba(69, 53, 35, 0.12);
          border-radius: 28px;
          background: linear-gradient(180deg, rgba(255, 252, 247, 0.96), rgba(250, 243, 233, 0.88));
          box-shadow: 0 18px 40px rgba(52, 43, 32, 0.08);
          overflow: hidden;
        }

        .ks-md-meta {
          display: flex;
          flex-wrap: wrap;
          gap: 0.75rem;
          align-items: center;
          justify-content: space-between;
          padding: 1rem 1.2rem;
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(255, 255, 255, 0.66);
        }

        .ks-md-badges {
          display: flex;
          flex-wrap: wrap;
          gap: 0.55rem;
        }

        .ks-md-badge {
          display: inline-flex;
          align-items: center;
          border-radius: 999px;
          padding: 0.45rem 0.8rem;
          background: #201a17;
          color: #fff9f1;
          font-size: 0.78rem;
          font-weight: 700;
        }

        .ks-md-badge.soft {
          background: #efe3d2;
          color: #6b5643;
        }

        .ks-md-hint {
          margin: 0;
          color: #6b6257;
          font: 500 0.9rem/1.6 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-md-toolbar {
          display: flex;
          flex-wrap: wrap;
          gap: 0.65rem;
          padding: 0.85rem 1.2rem;
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(247, 239, 227, 0.7);
        }

        .ks-form .ks-md-toolbar .ks-md-tool,
        .ks-md-toolbar .ks-md-tool {
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

        .ks-form .ks-md-toolbar .ks-md-tool.primary,
        .ks-md-toolbar .ks-md-tool.primary {
          background: #201a17;
          color: #fff9f1;
        }

        .ks-form .ks-md-toolbar .ks-md-tool:hover,
        .ks-md-toolbar .ks-md-tool:hover {
          transform: none;
          filter: brightness(0.98);
        }

        .ks-md-stage {
          border-top: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(255, 252, 247, 0.68);
        }

        .ks-md-stage-head {
          display: flex;
          align-items: center;
          justify-content: space-between;
          gap: 1rem;
          padding: 1rem 1.2rem 0.85rem;
          background: rgba(247, 239, 227, 0.84);
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
        }

        .ks-md-stage-title {
          margin: 0;
          color: #1f1711;
          font: 700 1.02rem/1.2 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-md-stage-copy {
          margin: 0.35rem 0 0;
          color: #7a6653;
          font: 500 0.84rem/1.5 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-md-stage-badge {
          display: inline-flex;
          align-items: center;
          border-radius: 999px;
          padding: 0.42rem 0.78rem;
          background: #1f1711;
          color: #fff8ef;
          font: 700 0.76rem/1 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-md-tabs {
          display: flex;
          gap: 0.7rem;
          padding: 0.85rem 1.2rem;
          border-bottom: 1px solid rgba(69, 53, 35, 0.08);
          background: rgba(255, 252, 247, 0.74);
        }

        .ks-form .ks-md-tab,
        .ks-md-tab {
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

        .ks-form .ks-md-tab.active,
        .ks-md-tab.active {
          background: #201a17;
          color: #fff8ef;
          border-color: #201a17;
        }

        .ks-md-panel {
          display: none;
        }

        .ks-md-panel.active {
          display: block;
        }

        .ks-md-root,
        .ks-md-source-wrap {
          min-height: 640px;
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

        .ks-md-root {
          padding: 1.1rem 1.2rem 1.35rem;
        }

        .ks-md-source-wrap {
          padding: 1rem 1.2rem 1.35rem;
        }

        .ks-md-source {
          width: 100%;
          min-height: 600px;
          resize: vertical;
          border: 1px solid rgba(69, 53, 35, 0.14);
          border-radius: 22px;
          background: rgba(255, 255, 255, 0.94);
          padding: 1.1rem 1.15rem;
          color: #241c16;
          font: 500 15px/1.75 "SFMono-Regular", "Menlo", "Consolas", monospace;
          outline: none;
          box-shadow: inset 0 1px 2px rgba(28, 25, 22, 0.04);
        }

        .ks-md-root .milkdown {
          color: #241c16;
          font: 400 1rem/1.75 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .ks-md-root .ProseMirror {
          min-height: 560px;
          padding: 1.25rem 1.25rem 2rem;
          border: none;
          outline: none;
          white-space: pre-wrap;
        }

        .ks-md-root .ProseMirror::before {
          content: "在这里做所见即所得编辑，排版结果会同步回 Markdown 源码。";
          display: block;
          margin-bottom: 0.85rem;
          color: #9a826b;
          font: 600 0.82rem/1.4 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
          letter-spacing: 0.01em;
        }

        .ks-md-root .ProseMirror h1,
        .ks-md-root .ProseMirror h2,
        .ks-md-root .ProseMirror h3 {
          line-height: 1.18;
          letter-spacing: -0.03em;
          margin: 1.4rem 0 0.7rem;
        }

        .ks-md-root .ProseMirror h1:first-child {
          margin-top: 0.2rem;
        }

        .ks-md-root .ProseMirror p,
        .ks-md-root .ProseMirror li,
        .ks-md-root .ProseMirror blockquote {
          font-size: 1.02rem;
        }

        .ks-md-root .ProseMirror blockquote {
          margin: 1rem 0;
          padding: 0.35rem 0 0.35rem 1rem;
          border-left: 3px solid rgba(111, 88, 64, 0.28);
          color: #6c5b49;
        }

        .ks-md-root .ProseMirror ul,
        .ks-md-root .ProseMirror ol {
          padding-left: 1.3rem;
        }

        @media (max-width: 800px) {
          .ks-md-meta,
          .ks-md-stage-head {
            align-items: start;
          }

          .ks-md-meta,
          .ks-md-stage-head,
          .ks-md-tabs {
            flex-direction: column;
          }
        }
      </style>
      <section class="ks-md-shell" data-vphp-preserve="milkdown-editor">
        <div class="ks-md-meta">
          <div class="ks-md-badges">
            <span class="ks-md-badge">${label}</span>
            <span class="ks-md-badge soft">${draftStatus}</span>
            <span class="ks-md-badge soft">${this.helperPrefix} ${this.#title.trim() || label}</span>
            <span class="ks-md-badge soft">summary ${this.#summary.trim().length}</span>
            <span class="ks-md-badge soft">body ${this.#body.trim().length}</span>
          </div>
          <p class="ks-md-hint">正文区现在是全宽主编辑面，可在 Markdown 源码与所见即所得之间切换。</p>
        </div>
        <div class="ks-md-toolbar">
          <button class="ks-md-tool primary" type="button" @click=${() => this.#applyStarterDraft()}>生成 Markdown 草稿</button>
          <button class="ks-md-tool" type="button" @click=${() => this.#wrapSelection("## ", "")}>H2 标题</button>
          <button class="ks-md-tool" type="button" @click=${() => this.#wrapSelection("**", "**")}>加粗</button>
          <button class="ks-md-tool" type="button" @click=${() => this.#insertSnippet("- 要点一\\n- 要点二\\n- 要点三")}>列表</button>
          <button class="ks-md-tool" type="button" @click=${() => this.#insertSnippet("> 引用一句来自审批手册或客服口径的说明")}>引用</button>
        </div>
        <div class="ks-md-stage">
          <div class="ks-md-stage-head">
            <div>
              <h3 class="ks-md-stage-title">正文编辑器</h3>
              <p class="ks-md-stage-copy">源码模式直接维护 Markdown，所见即所得模式用 Milkdown 做可视化编辑，两边共用同一份正文。</p>
            </div>
            <span class="ks-md-stage-badge">${this.#mode === "source" ? "Markdown Source" : "Milkdown WYSIWYG"}</span>
          </div>
          <div class="ks-md-tabs">
            <button class=${this.#mode === "source" ? "ks-md-tab active" : "ks-md-tab"} type="button" @click=${() => this.#setMode("source")}>Markdown 源码</button>
            <button class=${this.#mode === "wysiwyg" ? "ks-md-tab active" : "ks-md-tab"} type="button" @click=${() => this.#setMode("wysiwyg")}>所见即所得</button>
          </div>
          <div class=${this.#mode === "source" ? "ks-md-panel active" : "ks-md-panel"}>
            <div class="ks-md-source-wrap">
              <textarea
                class="ks-md-source"
                .value=${this.#body}
                @input=${this.#handleSourceInput}
                spellcheck="false"
              ></textarea>
            </div>
          </div>
          <div class=${this.#mode === "wysiwyg" ? "ks-md-panel active" : "ks-md-panel"}>
            <div class="ks-md-root" data-milkdown-root></div>
          </div>
        </div>
      </section>
    `;
  }

  async #ensureEditor(): Promise<void> {
    if (this.#editor || this.#editorBoot || !this.isConnected) {
      return;
    }
    const bodyField = this.#field<HTMLTextAreaElement>(this.bodySelector);
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
        console.error("milkdown_boot_failed", error);
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
    const title = this.#field<HTMLInputElement>(this.titleSelector);
    const summary = this.#field<HTMLTextAreaElement>(this.summarySelector);
    const body = this.#field<HTMLTextAreaElement>(this.bodySelector);
    if (!title || !summary || !body) {
      return;
    }
    this.#syncFields();
    this.#boundListener = () => {
      this.#syncFields();
      this.requestUpdate();
      void this.#syncExternalBodyIntoEditor();
    };
    title.addEventListener("input", this.#boundListener);
    summary.addEventListener("input", this.#boundListener);
    body.addEventListener("input", this.#boundListener);
    body.addEventListener("change", this.#boundListener);
  }

  #unbindFields(): void {
    const title = this.#field<HTMLInputElement>(this.titleSelector);
    const summary = this.#field<HTMLTextAreaElement>(this.summarySelector);
    const body = this.#field<HTMLTextAreaElement>(this.bodySelector);
    if (!this.#boundListener) {
      return;
    }
    title?.removeEventListener("input", this.#boundListener);
    summary?.removeEventListener("input", this.#boundListener);
    body?.removeEventListener("input", this.#boundListener);
    body?.removeEventListener("change", this.#boundListener);
    this.#boundListener = undefined;
  }

  #syncFields(): void {
    this.#title = this.#field<HTMLInputElement>(this.titleSelector)?.value ?? "";
    this.#summary = this.#field<HTMLTextAreaElement>(this.summarySelector)?.value ?? "";
    this.#body = this.#field<HTMLTextAreaElement>(this.bodySelector)?.value ?? "";
  }

  #captureInitialState(): void {
    if (this.#initialTitle !== "" || this.#initialSummary !== "" || this.#initialBody !== "") {
      return;
    }
    this.#initialTitle = this.#title;
    this.#initialSummary = this.#summary;
    this.#initialBody = this.#body;
  }

  #isDirty(): boolean {
    return this.#title !== this.#initialTitle
      || this.#summary !== this.#initialSummary
      || this.#body !== this.#initialBody;
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
    const summary = this.#summary.trim();
    const bodyLooksPlaceholder = body === "" || body === title || body === summary;
    if (!bodyLooksPlaceholder) {
      return;
    }
    this.#bootstrappedDraft = true;
    this.#applyStarterDraft();
  }

  async #syncExternalBodyIntoEditor(): Promise<void> {
    const body = this.#field<HTMLTextAreaElement>(this.bodySelector);
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
    const body = this.#field<HTMLTextAreaElement>(this.bodySelector);
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
    const title = this.#title.trim() || "Untitled Document";
    const summary = this.#summary.trim();
    const nextMarkdown = [
      `# ${title}`,
      "",
      summary !== "" ? summary : "在这里写下这份知识文档的摘要，说明它服务于什么业务场景。",
      "",
      "## 背景",
      "- 适用场景：",
      "- 目标对象：",
      "- 风险提醒：",
      "",
      "## 操作要点",
      "1. ",
      "2. ",
      "3. ",
      "",
      "## 对外口径",
      "> 在这里整理面向订阅用户或公开助手的标准表达。",
      "",
      "## 后续动作",
      "- "
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
    const source = this.querySelector<HTMLTextAreaElement>(".ks-md-source");
    if (this.#mode === "source" && source) {
      const current = source.value ?? "";
      const start = source.selectionStart ?? current.length;
      const end = source.selectionEnd ?? current.length;
      const selected = current.slice(start, end) || "内容";
      const next = `${current.slice(0, start)}${prefix}${selected}${suffix}${current.slice(end)}`;
      this.#writeBody(next, true);
      requestAnimationFrame(() => {
        const updated = this.querySelector<HTMLTextAreaElement>(".ks-md-source");
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
    field.setAttribute("data-enhanced-editor", "milkdown");
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

customElements.define("ks-document-editor-intake", KsDocumentEditorIntake);
