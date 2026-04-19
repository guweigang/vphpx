import { LitElement, html } from "lit";
import { Editor, commandsCtx, defaultValueCtx, editorViewCtx, rootCtx } from "@milkdown/kit/core";
import {
  commonmark,
  createCodeBlockCommand,
  toggleEmphasisCommand,
  toggleLinkCommand,
  toggleStrongCommand,
  turnIntoTextCommand,
  wrapInBlockquoteCommand,
  wrapInBulletListCommand,
  wrapInHeadingCommand,
  wrapInOrderedListCommand
} from "@milkdown/kit/preset/commonmark";
import {
  addColAfterCommand,
  addRowAfterCommand,
  deleteSelectedCellsCommand,
  gfm,
  insertTableCommand,
  selectColCommand,
  selectRowCommand
} from "@milkdown/kit/preset/gfm";
import { linkTooltipPlugin } from "@milkdown/kit/component/link-tooltip";
import { listener, listenerCtx } from "@milkdown/kit/plugin/listener";
import { SlashProvider, slashFactory } from "@milkdown/kit/plugin/slash";
import { replaceAll } from "@milkdown/kit/utils";
import { TextSelection } from "@milkdown/kit/prose/state";
import "@milkdown/kit/prose/view/style/prosemirror.css";
import { basicSetup } from "codemirror";
import { EditorState as CodeMirrorState } from "@codemirror/state";
import { EditorView as CodeMirrorView } from "@codemirror/view";
import { markdown as codeMirrorMarkdown } from "@codemirror/lang-markdown";

const entrySlashPlugin = slashFactory("KS_ENTRY");

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
  #slashProvider: SlashProvider | null = null;
  #slashMenuItems: HTMLDivElement[] = [];
  #slashActiveIndex = 0;
  #sourceEditor: CodeMirrorView | null = null;
  #sourceSyncing = false;
  #tableSupport = false;
  #tableHoverCell: HTMLTableCellElement | null = null;
  #tableRowButton: HTMLButtonElement | null = null;
  #tableColButton: HTMLButtonElement | null = null;
  #tableControlsHover = false;
  #tableHideTimer: number | null = null;
  #editorNotice = "";
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
    this.#destroySourceEditor();
    this.#destroyTableEdgeControls();
    super.disconnectedCallback();
  }

  protected firstUpdated(): void {
    this.#bindFields();
    this.#ensureSourceEditor();
    void this.#ensureEditor();
  }

  protected updated(): void {
    this.#editorRoot = this.querySelector<HTMLDivElement>("[data-milkdown-root]");
    this.#ensureSourceEditor();
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

        .ks-form .ks-entry-tab:hover,
        .ks-entry-tab:hover {
          color: #3a2d22;
          border-color: rgba(69, 53, 35, 0.22);
          background: rgba(255, 252, 247, 0.96);
          -webkit-text-fill-color: currentColor;
        }

        .ks-form .ks-entry-tab.active:hover,
        .ks-entry-tab.active:hover {
          color: #fff8ef;
          background: #201a17;
          border-color: #201a17;
          -webkit-text-fill-color: currentColor;
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
          position: relative;
          padding: 1.1rem 1.2rem 1.35rem;
        }

        .ks-entry-table-edge {
          position: absolute;
          z-index: 12;
          display: none;
          align-items: center;
          justify-content: center;
          min-width: 28px;
          height: 28px;
          border: 1px solid rgba(69, 53, 35, 0.16);
          border-radius: 999px;
          background: rgba(255, 252, 247, 0.98);
          color: #2f241c;
          font: 700 0.78rem/1 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
          box-shadow: 0 10px 20px rgba(52, 43, 32, 0.12);
          cursor: pointer;
        }

        .ks-entry-source-wrap {
          padding: 1rem 1.2rem 1.35rem;
        }

        .ks-entry-source-editor {
          height: 500px;
          border: 1px solid rgba(69, 53, 35, 0.14);
          border-radius: 22px;
          background: rgba(255, 255, 255, 0.96);
          box-shadow: inset 0 1px 2px rgba(28, 25, 22, 0.04);
          overflow: hidden;
        }

        .ks-entry-source-editor .cm-editor {
          height: 100%;
          background: transparent;
          color: #241c16;
        }

        .ks-entry-source-editor .cm-scroller {
          overflow: auto;
          font: 500 15px/1.75 "SFMono-Regular", "Menlo", "Consolas", monospace;
        }

        .ks-entry-source-editor .cm-content,
        .ks-entry-source-editor .cm-gutterElement {
          font: inherit;
        }

        .ks-entry-source-editor .cm-content {
          padding: 1.1rem 1.15rem 2rem;
          caret-color: #241c16;
        }

        .ks-entry-source-editor .cm-lineNumbers {
          color: #b6a894;
          background: rgba(247, 239, 227, 0.72);
          border-right: 1px solid rgba(69, 53, 35, 0.08);
        }

        .ks-entry-source-editor .cm-activeLine,
        .ks-entry-source-editor .cm-activeLineGutter {
          background: rgba(15, 118, 110, 0.06);
        }

        .ks-entry-source-editor .cm-cursor {
          border-left-color: #241c16;
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

        .ks-entry-root .ProseMirror blockquote {
          margin: 1rem 0;
          padding: 0.35rem 0 0.35rem 1rem;
          background: rgba(247, 239, 227, 0.46);
          border-left: 3px solid rgba(111, 88, 64, 0.28);
          border-radius: 0 14px 14px 0;
          color: #6c5b49;
        }

        .ks-entry-root .ProseMirror blockquote > :first-child {
          margin-top: 0;
        }

        .ks-entry-root .ProseMirror blockquote > :last-child {
          margin-bottom: 0;
        }

        .ks-entry-root .ProseMirror table {
          width: 100%;
          border-collapse: collapse;
          margin: 1rem 0 1.2rem;
          table-layout: fixed;
        }

        .ks-entry-root .ProseMirror th,
        .ks-entry-root .ProseMirror td {
          border: 1px solid rgba(69, 53, 35, 0.16);
          padding: 0.72rem 0.8rem;
          vertical-align: top;
        }

        .ks-entry-root .ProseMirror th {
          background: rgba(247, 239, 227, 0.88);
          font-weight: 700;
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
            ${this.#editorNotice !== "" ? html`<span class="ks-entry-badge soft">${this.#editorNotice}</span>` : ""}
          </div>
          <p class="ks-entry-hint">条目正文现在是全宽主编辑面，可在 Markdown 源码与所见即所得之间切换。</p>
        </div>
        <div class="ks-entry-toolbar">
          <button class="ks-entry-tool primary" type="button" @click=${() => this.#applyStarterDraft()}>生成条目草稿</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#applyHeading(2)}>H2 标题</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#applyHeading(3)}>H3 标题</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#toggleStrong()}>加粗</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#toggleEmphasis()}>斜体</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#toggleBulletList()}>列表</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#toggleOrderedList()}>编号</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#toggleBlockquote()}>引用</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#insertTable()}>表格</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#deleteTableRow()}>删行</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#deleteTableCol()}>删列</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#toggleHeaderRow()}>表头行</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#toggleCodeBlock()}>代码块</button>
          <button class="ks-entry-tool" type="button" @click=${() => this.#insertLink()}>链接</button>
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
              <div class="ks-entry-source-editor" data-source-root></div>
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
        try {
          this.#editor = await this.#buildEditor(bodyField.value || "", "gfm").create();
          this.#tableSupport = true;
          this.#editorNotice = "GFM table enabled";
        } catch (error) {
          console.warn("milkdown_entry_gfm_boot_failed_fallback", error);
          this.#editor = await this.#buildEditor(bodyField.value || "", "commonmark").create();
          this.#tableSupport = false;
          this.#editorNotice = `GFM fallback: ${error instanceof Error ? error.message : String(error)}`;
        }
        this.#lastMarkdown = bodyField.value || "";
        this.#ensureTableEdgeControls();
        this.requestUpdate();
      } catch (error) {
        console.error("milkdown_entry_boot_failed", error);
        this.#editorNotice = `Editor boot failed: ${error instanceof Error ? error.message : String(error)}`;
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
    this.#slashProvider = null;
    this.#tableHoverCell = null;
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
    this.#syncSourceEditor(nextValue);
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
    this.#syncSourceEditor(markdown);
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
    if (this.#mode === "source" && this.#sourceEditor) {
      const view = this.#sourceEditor;
      const { from, to } = view.state.selection.main;
      const selected = view.state.sliceDoc(from, to);
      const needsPadding = selected === "" && from > 0;
      const insert = `${needsPadding ? "\n\n" : ""}${snippet}`;
      view.dispatch({
        changes: { from, to, insert },
        selection: { anchor: from + insert.length }
      });
      view.focus();
      return;
    }
    const current = this.#body ?? "";
    const prefix = current.trim() === "" ? "" : "\n\n";
    this.#writeBody(`${current}${prefix}${snippet}`, true);
    void this.#syncExternalBodyIntoEditor();
  }

  #wrapSelection(prefix: string, suffix: string): void {
    if (this.#mode === "source" && this.#sourceEditor) {
      const view = this.#sourceEditor;
      const { from, to } = view.state.selection.main;
      const selected = view.state.sliceDoc(from, to) || "内容";
      const insert = `${prefix}${selected}${suffix}`;
      const cursor = from + insert.length;
      view.dispatch({
        changes: { from, to, insert },
        selection: { anchor: cursor }
      });
      view.focus();
      return;
    }

    const current = this.#body ?? "";
    const next = `${current}${current.trim() === "" ? "" : "\n\n"}${prefix}内容${suffix}`;
    this.#writeBody(next, true);
    void this.#syncExternalBodyIntoEditor();
  }

  #applyHeading(level: 2 | 3): void {
    if (this.#mode === "source") {
      this.#wrapSelection("#".repeat(level) + " ", "");
      return;
    }
    this.#runCommand(wrapInHeadingCommand.key, level);
  }

  #toggleStrong(): void {
    if (this.#mode === "source") {
      this.#wrapSelection("**", "**");
      return;
    }
    this.#runCommand(toggleStrongCommand.key);
  }

  #toggleEmphasis(): void {
    if (this.#mode === "source") {
      this.#wrapSelection("*", "*");
      return;
    }
    this.#runCommand(toggleEmphasisCommand.key);
  }

  #toggleBulletList(): void {
    if (this.#mode === "source") {
      this.#insertSnippet("- 要点一\n- 要点二\n- 要点三");
      return;
    }
    this.#runCommand(wrapInBulletListCommand.key);
  }

  #toggleOrderedList(): void {
    if (this.#mode === "source") {
      this.#insertSnippet("1. 第一步\n2. 第二步\n3. 第三步");
      return;
    }
    this.#runCommand(wrapInOrderedListCommand.key);
  }

  #toggleBlockquote(): void {
    if (this.#mode === "source") {
      this.#insertSnippet("> 这里整理面对用户时的标准回答口径");
      return;
    }
    this.#runCommand(wrapInBlockquoteCommand.key);
  }

  #toggleCodeBlock(): void {
    if (this.#mode === "source") {
      this.#insertSnippet("```md\n在这里补充代码块或结构化片段\n```");
      return;
    }
    this.#runCommand(createCodeBlockCommand.key, "md");
  }

  #insertTable(): void {
    if (this.#mode === "source") {
      this.#insertTableSnippet();
      return;
    }
    if (this.#tableSupport) {
      this.#runCommand(insertTableCommand.key, { row: 3, col: 3 });
      return;
    }
    this.#insertTableSnippet();
  }

  #deleteTableRow(): void {
    this.#withActiveTableContext((ctx, _view, table) => {
      ctx.get(commandsCtx).call(selectRowCommand.key as never, { index: table.rowIndex } as never);
      ctx.get(commandsCtx).call(deleteSelectedCellsCommand.key as never);
      this.#editorNotice = "已删除当前行";
      this.#hideTableEdgeControls();
    }, "请先把光标放到表格行内");
  }

  #deleteTableCol(): void {
    this.#withActiveTableContext((ctx, _view, table) => {
      ctx.get(commandsCtx).call(selectColCommand.key as never, { index: table.colIndex } as never);
      ctx.get(commandsCtx).call(deleteSelectedCellsCommand.key as never);
      this.#editorNotice = "已删除当前列";
      this.#hideTableEdgeControls();
    }, "请先把光标放到表格列内");
  }

  #toggleHeaderRow(): void {
    this.#withActiveTableContext((_ctx, view, table) => {
      const { state } = view;
      const tableNode = state.doc.nodeAt(table.tablePos);
      if (!tableNode || tableNode.childCount === 0) {
        this.#editorNotice = "当前表格没有可切换的首行";
        return;
      }
      const firstRow = tableNode.firstChild;
      const headerRowType = state.schema.nodes.table_header_row;
      const rowType = state.schema.nodes.table_row;
      const headerCellType = state.schema.nodes.table_header;
      const cellType = state.schema.nodes.table_cell;
      if (!firstRow || !headerRowType || !rowType || !headerCellType || !cellType) {
        this.#editorNotice = "当前表格 schema 不支持表头切换";
        return;
      }
      const turningOn = firstRow.type !== headerRowType;
      const nextRowType = turningOn ? headerRowType : rowType;
      const nextCellType = turningOn ? headerCellType : cellType;
      const nextCells: Array<unknown> = [];
      firstRow.forEach((cell) => {
        nextCells.push(nextCellType.create(cell.attrs, cell.content, cell.marks));
      });
      const nextRow = nextRowType.create(firstRow.attrs, nextCells, firstRow.marks);
      const firstRowPos = table.tablePos + 1;
      let tr = state.tr.replaceWith(firstRowPos, firstRowPos + firstRow.nodeSize, nextRow);
      const focusPos = Math.min(firstRowPos + 2, tr.doc.content.size);
      tr = tr.setSelection(TextSelection.near(tr.doc.resolve(focusPos))).scrollIntoView();
      view.dispatch(tr);
      this.#editorNotice = turningOn ? "已启用表头行" : "已切回普通首行";
    }, "请先把光标放到表格里");
  }

  #insertLink(): void {
    const href = window.prompt("输入链接 URL", "https://");
    if (!href || href.trim() === "") {
      return;
    }
    if (this.#mode === "source") {
      this.#wrapSelection("[", `](${href.trim()})`);
      return;
    }
    this.#runCommand(toggleLinkCommand.key, { href: href.trim() });
  }

  #runCommand(commandKey: string | symbol, payload?: unknown): void {
    if (!this.#editor) {
      return;
    }
    this.#editor.action((ctx) => {
      ctx.get(commandsCtx).call(commandKey as never, payload as never);
      ctx.get(editorViewCtx).focus();
      return true;
    });
  }

  #withActiveTableContext(
    action: (ctx: any, view: any, table: { tablePos: number; rowIndex: number; colIndex: number; cellPos: number }) => void,
    missingNotice: string
  ): void {
    if (this.#mode === "source") {
      this.#editorNotice = "请在所见即所得表格中操作";
      this.requestUpdate();
      return;
    }
    if (!this.#editor || !this.#tableSupport) {
      this.#editorNotice = "当前编辑器还没有启用表格命令";
      this.requestUpdate();
      return;
    }
    this.#editor.action((ctx) => {
      const view = ctx.get(editorViewCtx);
      const table = this.#resolveActiveTableCell(view);
      if (!table) {
        this.#editorNotice = missingNotice;
        this.requestUpdate();
        return true;
      }
      const selection = TextSelection.near(view.state.doc.resolve(Math.min(table.cellPos + 1, view.state.doc.content.size)));
      view.dispatch(view.state.tr.setSelection(selection));
      action(ctx, view, table);
      view.focus();
      this.requestUpdate();
      return true;
    });
  }

  #resolveActiveTableCell(view: any): { tablePos: number; rowIndex: number; colIndex: number; cellPos: number } | null {
    const hoveredCell = this.#tableHoverCell;
    let $pos = view.state.selection.$from;
    if (hoveredCell) {
      try {
        const hoveredPos = view.posAtDOM(hoveredCell, 0);
        $pos = view.state.doc.resolve(Math.min(hoveredPos + 1, view.state.doc.content.size));
      } catch {
        $pos = view.state.selection.$from;
      }
    }

    let tableDepth = -1;
    let rowDepth = -1;
    let cellDepth = -1;
    for (let depth = $pos.depth; depth > 0; depth -= 1) {
      const name = $pos.node(depth).type.name;
      if (tableDepth === -1 && name === "table") {
        tableDepth = depth;
      }
      if (rowDepth === -1 && (name === "table_row" || name === "table_header_row")) {
        rowDepth = depth;
      }
      if (cellDepth === -1 && (name === "table_cell" || name === "table_header")) {
        cellDepth = depth;
      }
    }
    if (tableDepth === -1 || rowDepth === -1 || cellDepth === -1) {
      return null;
    }

    const tableNode = $pos.node(tableDepth);
    const rowNode = $pos.node(rowDepth);
    const tableStart = $pos.start(tableDepth);
    const rowStart = $pos.start(rowDepth);
    const rowOffset = $pos.before(rowDepth) - tableStart;
    const cellOffset = $pos.before(cellDepth) - rowStart;
    let rowIndex = 0;
    let colIndex = 0;

    tableNode.forEach((_node, offset, index) => {
      if (offset === rowOffset) {
        rowIndex = index;
      }
    });
    rowNode.forEach((_node, offset, index) => {
      if (offset === cellOffset) {
        colIndex = index;
      }
    });

    return {
      tablePos: $pos.before(tableDepth),
      rowIndex,
      colIndex,
      cellPos: $pos.before(cellDepth)
    };
  }

  #runSlashCommand(commandKey: string | symbol, payload?: unknown): void {
    if (!this.#editor) {
      return;
    }
    this.#editor.action((ctx) => {
      const view = ctx.get(editorViewCtx);
      const { state } = view;
      const { from, empty } = state.selection;
      if (empty && from > 1) {
        const previous = state.doc.textBetween(from - 1, from, undefined, "\ufffc");
        if (previous === "/") {
          view.dispatch(state.tr.delete(from - 1, from));
        }
      }
      ctx.get(commandsCtx).call(commandKey as never, payload as never);
      view.focus();
      return true;
    });
    this.#slashProvider?.hide();
  }

  #runSlashAction(action: () => void): void {
    if (this.#editor) {
      this.#editor.action((ctx) => {
        const view = ctx.get(editorViewCtx);
        const { state } = view;
        const { from, empty } = state.selection;
        if (empty && from > 1) {
          const previous = state.doc.textBetween(from - 1, from, undefined, "\ufffc");
          if (previous === "/") {
            view.dispatch(state.tr.delete(from - 1, from));
          }
        }
        view.focus();
        return true;
      });
    }
    action();
    this.#slashProvider?.hide();
  }

  #resetParagraph(): void {
    if (this.#mode === "source") {
      return;
    }
    this.#runCommand(turnIntoTextCommand.key);
  }

  #buildEditor(initialValue: string, preset: "commonmark" | "gfm"): Editor {
    return Editor.make()
      .config((ctx) => {
        ctx.set(rootCtx, this.#editorRoot as HTMLDivElement);
        ctx.set(defaultValueCtx, initialValue);
        ctx.set(entrySlashPlugin.key, {
          view: () => {
            const content = this.#createSlashMenu();
            const provider = new SlashProvider({
              content,
              debounce: 0,
              offset: 12,
              root: this
            });
            provider.onShow = () => {
              content.style.display = "block";
              this.#activateSlashItem(0);
              window.addEventListener("keydown", this.#handleSlashKeydown, true);
            };
            provider.onHide = () => {
              content.style.display = "none";
              window.removeEventListener("keydown", this.#handleSlashKeydown, true);
            };
            this.#slashProvider = provider;
            return {
              update: (updatedView, prevState) => provider.update(updatedView, prevState),
              destroy: () => {
                provider.destroy();
                window.removeEventListener("keydown", this.#handleSlashKeydown, true);
                content.remove();
                if (this.#slashProvider === provider) {
                  this.#slashProvider = null;
                }
              }
            };
          }
        });
      })
      .use(commonmark)
      .use(preset === "gfm" ? gfm : [])
      .use(linkTooltipPlugin)
      .use(entrySlashPlugin)
      .use(listener)
      .config((ctx) => {
        ctx.get(listenerCtx).markdownUpdated((_ctx, markdown) => {
          this.#lastMarkdown = markdown;
          this.#writeBody(markdown, true);
        });
      });
  }

  #insertTableSnippet(): void {
    this.#insertSnippet("| 列 1 | 列 2 | 列 3 |\n| --- | --- | --- |\n| 内容 | 内容 | 内容 |\n| 内容 | 内容 | 内容 |");
  }

  #ensureTableEdgeControls(): void {
    if (!this.#editorRoot || this.#tableRowButton || this.#tableColButton) {
      return;
    }
    const rowButton = document.createElement("button");
    rowButton.type = "button";
    rowButton.className = "ks-entry-table-edge";
    rowButton.textContent = "+行";
    rowButton.addEventListener("mousedown", (event) => event.preventDefault());
    rowButton.addEventListener("click", () => this.#runTableEdgeCommand(addRowAfterCommand.key));
    rowButton.addEventListener("mouseenter", this.#handleTableControlEnter);
    rowButton.addEventListener("mouseleave", this.#handleTableControlLeave);

    const colButton = document.createElement("button");
    colButton.type = "button";
    colButton.className = "ks-entry-table-edge";
    colButton.textContent = "+列";
    colButton.addEventListener("mousedown", (event) => event.preventDefault());
    colButton.addEventListener("click", () => this.#runTableEdgeCommand(addColAfterCommand.key));
    colButton.addEventListener("mouseenter", this.#handleTableControlEnter);
    colButton.addEventListener("mouseleave", this.#handleTableControlLeave);

    this.#editorRoot.append(rowButton, colButton);
    this.#tableRowButton = rowButton;
    this.#tableColButton = colButton;
    this.#editorRoot.addEventListener("mousemove", this.#handleTableHover);
    this.#editorRoot.addEventListener("mouseleave", this.#hideTableEdgeControls);
  }

  #destroyTableEdgeControls(): void {
    if (this.#editorRoot) {
      this.#editorRoot.removeEventListener("mousemove", this.#handleTableHover);
      this.#editorRoot.removeEventListener("mouseleave", this.#hideTableEdgeControls);
    }
    this.#tableRowButton?.remove();
    this.#tableColButton?.remove();
    this.#tableRowButton = null;
    this.#tableColButton = null;
    if (this.#tableHideTimer !== null) {
      window.clearTimeout(this.#tableHideTimer);
      this.#tableHideTimer = null;
    }
  }

  #runTableEdgeCommand(commandKey: string | symbol): void {
    if (!this.#editor || !this.#tableHoverCell) {
      return;
    }
    this.#editor.action((ctx) => {
      const view = ctx.get(editorViewCtx);
      const pos = view.posAtDOM(this.#tableHoverCell as HTMLElement, 0);
      const selection = TextSelection.near(view.state.doc.resolve(pos + 1));
      view.dispatch(view.state.tr.setSelection(selection));
      ctx.get(commandsCtx).call(commandKey as never);
      view.focus();
      return true;
    });
  }

  #handleTableHover = (event: MouseEvent): void => {
    if (!this.#editorRoot || !this.#tableRowButton || !this.#tableColButton || !this.#tableSupport) {
      return;
    }
    this.#cancelTableHide();
    const target = event.target;
    if (!(target instanceof Element)) {
      this.#scheduleTableHide();
      return;
    }
    if (target === this.#tableRowButton || target === this.#tableColButton) {
      return;
    }
    const cell = target.closest("td, th");
    if (!(cell instanceof HTMLTableCellElement) || !this.#editorRoot.contains(cell)) {
      if (!this.#tableControlsHover) {
        this.#scheduleTableHide();
      }
      return;
    }
    this.#tableHoverCell = cell;
    const rootRect = this.#editorRoot.getBoundingClientRect();
    const cellRect = cell.getBoundingClientRect();
    this.#tableColButton.style.display = "inline-flex";
    this.#tableColButton.style.left = `${cellRect.right - rootRect.left - 16}px`;
    this.#tableColButton.style.top = `${cellRect.top - rootRect.top + cellRect.height / 2 - 14}px`;
    this.#tableRowButton.style.display = "inline-flex";
    this.#tableRowButton.style.left = `${cellRect.left - rootRect.left + cellRect.width / 2 - 14}px`;
    this.#tableRowButton.style.top = `${cellRect.bottom - rootRect.top - 14}px`;
  };

  #handleTableControlEnter = (): void => {
    this.#tableControlsHover = true;
    this.#cancelTableHide();
  };

  #handleTableControlLeave = (): void => {
    this.#tableControlsHover = false;
    this.#scheduleTableHide();
  };

  #cancelTableHide(): void {
    if (this.#tableHideTimer !== null) {
      window.clearTimeout(this.#tableHideTimer);
      this.#tableHideTimer = null;
    }
  }

  #scheduleTableHide(): void {
    this.#cancelTableHide();
    this.#tableHideTimer = window.setTimeout(() => {
      if (!this.#tableControlsHover) {
        this.#hideTableEdgeControls();
      }
    }, 120);
  }

  #hideTableEdgeControls = (): void => {
    this.#cancelTableHide();
    if (this.#tableRowButton) {
      this.#tableRowButton.style.display = "none";
    }
    if (this.#tableColButton) {
      this.#tableColButton.style.display = "none";
    }
    this.#tableHoverCell = null;
  };

  #createSlashMenu(): HTMLDivElement {
    const menu = document.createElement("div");
    menu.className = "ks-entry-slash";
    menu.dataset.show = "false";
    Object.assign(menu.style, {
      position: "absolute",
      zIndex: "30",
      display: "none",
      pointerEvents: "auto"
    });

    const grid = document.createElement("div");
    Object.assign(grid.style, {
      display: "grid",
      gap: "0.4rem",
      minWidth: "220px",
      padding: "0.5rem",
      border: "1px solid rgba(69, 53, 35, 0.14)",
      borderRadius: "18px",
      background: "rgba(255, 252, 247, 0.98)",
      boxShadow: "0 18px 40px rgba(52, 43, 32, 0.12)"
    });
    menu.appendChild(grid);
    this.#slashMenuItems = [];
    this.#slashActiveIndex = 0;

    const items: Array<{ label: string; hint: string; onClick: () => void }> = [
      { label: "H2 标题", hint: "/h2", onClick: () => this.#runSlashCommand(wrapInHeadingCommand.key, 2) },
      { label: "H3 标题", hint: "/h3", onClick: () => this.#runSlashCommand(wrapInHeadingCommand.key, 3) },
      { label: "无序列表", hint: "/ul", onClick: () => this.#runSlashCommand(wrapInBulletListCommand.key) },
      { label: "有序列表", hint: "/ol", onClick: () => this.#runSlashCommand(wrapInOrderedListCommand.key) },
      { label: "引用块", hint: "/quote", onClick: () => this.#runSlashCommand(wrapInBlockquoteCommand.key) },
      { label: "插入表格", hint: "/table", onClick: () => this.#runSlashAction(() => this.#insertTable()) },
      { label: "代码块", hint: "/code", onClick: () => this.#runSlashCommand(createCodeBlockCommand.key, "md") },
      { label: "正文段落", hint: "/text", onClick: () => this.#resetParagraph() }
    ];

    items.forEach((item, index) => {
      const button = document.createElement("div");
      button.setAttribute("role", "button");
      button.tabIndex = 0;

      const label = document.createElement("span");
      label.textContent = item.label;
      Object.assign(label.style, {
        color: "#2f241c",
        font: '700 0.88rem/1.2 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif'
      });

      const hint = document.createElement("span");
      hint.textContent = item.hint;
      Object.assign(hint.style, {
        color: "#8a735d",
        font: '600 0.76rem/1 "IBM Plex Sans", "Helvetica Neue", Helvetica, Arial, sans-serif'
      });

      Object.assign(button.style, {
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        gap: "0.75rem",
        width: "100%",
        border: "1px solid rgba(69, 53, 35, 0.1)",
        borderRadius: "12px",
        padding: "0.65rem 0.8rem",
        background: "rgba(255, 255, 255, 0.92)",
        cursor: "pointer",
        userSelect: "none"
      });
      button.addEventListener("mousedown", (event) => {
        event.preventDefault();
        item.onClick();
      });
      button.addEventListener("keydown", (event) => {
        if (event.key === "Enter" || event.key === " ") {
          event.preventDefault();
          item.onClick();
        }
      });
      button.addEventListener("mouseenter", () => this.#activateSlashItem(index));
      button.append(label, hint);
      grid.appendChild(button);
      this.#slashMenuItems.push(button);
    });

    return menu;
  }

  #activateSlashItem(index: number): void {
    if (this.#slashMenuItems.length === 0) {
      return;
    }
    this.#slashActiveIndex = (index + this.#slashMenuItems.length) % this.#slashMenuItems.length;
    this.#slashMenuItems.forEach((button, itemIndex) => {
      const active = itemIndex === this.#slashActiveIndex;
      button.style.background = active ? "#f6ecdd" : "rgba(255, 255, 255, 0.92)";
      button.style.borderColor = active ? "rgba(69, 53, 35, 0.18)" : "rgba(69, 53, 35, 0.1)";
    });
  }

  #handleSlashKeydown = (event: KeyboardEvent): void => {
    if (!this.#slashProvider || this.#slashMenuItems.length === 0) {
      return;
    }
    if (event.key === "ArrowDown") {
      event.preventDefault();
      this.#activateSlashItem(this.#slashActiveIndex + 1);
      return;
    }
    if (event.key === "ArrowUp") {
      event.preventDefault();
      this.#activateSlashItem(this.#slashActiveIndex - 1);
      return;
    }
    if (event.key === "Enter") {
      event.preventDefault();
      this.#slashMenuItems[this.#slashActiveIndex]?.dispatchEvent(new MouseEvent("mousedown", { bubbles: true }));
      return;
    }
    if (event.key === "Escape") {
      event.preventDefault();
      this.#slashProvider.hide();
    }
  };

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

  #ensureSourceEditor(): void {
    if (this.#sourceEditor || !this.isConnected) {
      return;
    }
    const root = this.querySelector<HTMLDivElement>("[data-source-root]");
    if (!root) {
      return;
    }
    this.#sourceEditor = new CodeMirrorView({
      parent: root,
      state: CodeMirrorState.create({
        doc: this.#body,
        extensions: [
          basicSetup,
          codeMirrorMarkdown(),
          CodeMirrorView.lineWrapping,
          CodeMirrorView.updateListener.of((update) => {
            if (!update.docChanged || this.#sourceSyncing) {
              return;
            }
            this.#writeBody(update.state.doc.toString(), true);
          }),
          CodeMirrorView.theme({
            "&": { height: "100%" },
            ".cm-focused": { outline: "none" }
          })
        ]
      })
    });
  }

  #syncSourceEditor(value: string): void {
    if (!this.#sourceEditor) {
      return;
    }
    const current = this.#sourceEditor.state.doc.toString();
    if (current === value) {
      return;
    }
    this.#sourceSyncing = true;
    this.#sourceEditor.dispatch({
      changes: { from: 0, to: current.length, insert: value }
    });
    this.#sourceSyncing = false;
  }

  #destroySourceEditor(): void {
    if (!this.#sourceEditor) {
      return;
    }
    this.#sourceEditor.destroy();
    this.#sourceEditor = null;
  }

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
