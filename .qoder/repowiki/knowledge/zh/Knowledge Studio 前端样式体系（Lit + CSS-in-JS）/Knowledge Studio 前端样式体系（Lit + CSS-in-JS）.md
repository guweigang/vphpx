---
kind: frontend_style
name: Knowledge Studio 前端样式体系（Lit + CSS-in-JS）
category: frontend_style
scope:
    - '**'
source_files:
    - knowledge-studio/frontend/main.ts
    - knowledge-studio/frontend/components/assistant-intake.ts
    - knowledge-studio/frontend/components/document-editor-intake.ts
    - knowledge-studio/vite.config.mjs
    - knowledge-studio/app/Support/FrontendAsset.php
---

本仓库的前端 UI 仅存在于 `knowledge-studio/frontend/` 目录，采用轻量级 Web Components 方案，核心风格由 **Lit** 的 CSS-in-JS 与内联 `<style>` 块驱动，无独立 `.css` 文件、无 Tailwind/PostCSS/Sass 等构建管线。

1. 系统/工具链
- 组件框架：`lit`（`LitElement`），通过 `static properties` 声明属性、`render()` 返回模板。
- 样式策略：每个组件用 `static styles = css\`...\`` 或组件内部 `<style>` 标签定义样式，利用 Shadow DOM 隔离；复杂编辑器组件直接引入第三方库样式（如 `@milkdown/kit/prose/view/style/prosemirror.css`）。
- 构建：Vite（`vite.config.mjs`），入口 `frontend/main.ts`，输出单 JS 包 `public/assets/knowledge-studio.js` 与单 CSS 包 `public/assets/knowledge-studio.css`，关闭 CSS 代码分割以维持单一样式入口。
- 资源注入：PHP 侧 `App\Support\FrontendAsset::url()` 基于 `filemtime` 自动追加 `?v=` 缓存版本号，控制器统一传入 `frontend_style_url` / `frontend_module_url` 给视图。

2. 关键文件
- `knowledge-studio/frontend/main.ts` — 模块入口，注册所有自定义元素。
- `knowledge-studio/frontend/components/*.ts` — Lit 组件实现，含 `assistant-intake.ts`、`document-editor-intake.ts`、`entry-editor-intake.ts`、`subscribe-intake.ts`。
- `knowledge-studio/vite.config.mjs` — Vite 构建配置，固定产物名并聚合样式。
- `knowledge-studio/app/Support/FrontendAsset.php` — PHP 侧静态资源 URL 生成器。
- 控制器中多处使用 `FrontendAsset::url('knowledge-studio.css')` 注入样式与脚本。

3. 架构与约定
- 组件命名：自定义元素前缀 `ks-`（如 `ks-assistant-intake`），类名遵循 `KsXxxIntake`。
- 样式作用域：优先使用 Lit 的 `static styles` 配合 `:host` 与 BEM 风格类名（`ks-lit-summary`、`ks-md-*`），避免全局污染。
- 主题色与字体：组件内硬编码暖色系调色板（`#201a17`、`#efe3d2`、`#6b6257` 等）与字体栈（Inter、IBM Plex Sans、Helvetica Neue），未抽象为设计令牌。
- 第三方集成：文档编辑器同时依赖 Milkdown（ProseMirror 内核）与 CodeMirror，样式通过直接 import CSS 文件接入。

4. 开发者应遵循的规则
- 新增 UI 逻辑应在 `knowledge-studio/frontend/components/` 下创建新 Lit 组件，并在 `main.ts` 中 import 注册。
- 样式一律写在组件内部（`static styles` 或 `<style>`），不要新建独立 `.css` 文件；若需复用颜色/字号，建议在组件常量中集中管理。
- 通过 `static properties` 暴露可配置项，保持组件自包含。
- 修改前端后需重新运行 Vite 构建，确保 `public/assets/knowledge-studio.{js,css}` 更新；PHP 会自动根据文件时间戳加版本参数。