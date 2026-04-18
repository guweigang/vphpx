# Walkthrough Findings

## Round 2

日期：2026-04-17

范围：

- `/console`
- `/console/knowledge/documents`
- `/console/knowledge/faqs`
- `/console/releases`
- `/brand/{tenant}`
- `/brand/{tenant}/validation`
- `/brand/{tenant}/documents/{id}`
- `/brand/{tenant}/entries/{id}`

结论：

这一轮之后，`Knowledge Studio` 的主链路已经明显更像一个可稳定演示、可继续发布的 SaaS 原型。

最关键的变化有三件事：

1. `release center` 基本站稳成唯一公开上线关口
2. 公开验收链已经能从发布页一路走到品牌页、验证页、来源详情和历史版本
3. 控制台首页和公开详情页不再只是展示信息，而是开始把人送回下一步动作

这次已经按真实运行态重新走过一遍首页、品牌页、验证页、公开详情页、控制台首页和发布中心；`smoke` 也再次通过。当前剩下的问题，已经从“产品定义不成立”缩小到“少量 legacy 兼容入口还留在代码层”。

---

## 已修复

### R2-1 发布页现在承接的是待发布内容，不再重复打包已在线内容

当前状态：

- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php:280) 的 `releaseSnapshot()` 已经把 `draftDocuments` / `draftEntries` 作为候选载荷
- [console_releases.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_releases.html:1) 现在明确区分：
  - 本次待发布草稿
  - 当前公开内容
  - 历史版本

结果：

- `tenant owner` 已经可以真正通过发布页决定“这一版把哪些新内容带到公开面”
- 发布中心重新拿回了上线关口意义

### R2-2 编辑页不再承担公开上线动作

当前状态：

- [console_document_editor.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_document_editor.html:1) 和 [console_entry_editor.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_entry_editor.html:1) 已经只保留“保存草稿 / 去发布版本 / 返回列表”
- [ConsoleController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/ConsoleController.php:1854) 的 `publishDocument()` 和 [ConsoleController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/ConsoleController.php:1892) 的 `publishEntry()` 现在统一导流到 `/console/releases`
- 编辑器相关文案已经改成“保存草稿 -> 交给发布中心”

结果：

- 编辑页和发布中心的产品语义已经一致
- 旧 `/publish` 入口虽然保留兼容，但行为上已经不再像第二个上线关口

### R2-3 控制台首页最近内容已经能直接进入编辑

当前状态：

- [console.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console.html:162) 的最近文档和最近条目都补上了 `继续完善`
- [ConsoleController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/ConsoleController.php:173) 已经给最近内容挂上编辑链接

结果：

- 首页不再只是摘要墙
- owner / editor 从首页看到最近内容后，可以直接回到具体工作面继续做事

### R2-4 验证页引用已经能直达来源详情

当前状态：

- [validation.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/validation.html:95) 的 citation 卡片标题已经可以直接点进详情页
- 同卡片里还补了 `查看来源详情`
- [AssistantAnswerService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/AssistantAnswerService.php:80)、[AssistantAnswerPresenter.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Presenters/AssistantAnswerPresenter.php:15) 和 [PublicController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/PublicController.php:255) 已经把引用类型和详情链接接通

结果：

- “答案 -> 引用 -> 来源详情” 这条可信度验证链已经成立

### R2-5 公开详情页已经能回到验证链路

当前状态：

- [public_detail.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/public_detail.html:1) 除了 `返回品牌页` 之外，已经补了 `回到验证页`

结果：

- 访问者在来源详情页不会被卡死
- 详情页开始承担“证明页 + 回流页”的双重职责

### R2-6 发布历史已经能按版本回查，而且 `release` 参数已真正生效

当前状态：

- [console_releases.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_releases.html:204) 的历史记录已经带：
  - 查看品牌页
  - 查看验证页
- [KnowledgeRepository.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Repositories/KnowledgeRepository.php:330) 新增了 `findReleaseByVersion()`、`releasedDocumentsForVersion()`、`releasedEntriesForVersion()`
- [PublicWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/PublicWorkspaceService.php:55) 到 [PublicController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/PublicController.php:39) 这一条链，已经按 `?release=<version>` 真正切换公开内容
- 历史版本模式下，品牌页、验证页、来源详情页都会提示“当前正在查看历史版本”，见：
  - [brand.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/brand.html:1)
  - [validation.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/validation.html:1)
  - [public_detail.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/public_detail.html:1)

结果：

- release history 不再只是静态表格
- owner 已经可以按指定版本回查真正的公开结果

### R2-7 发布候选区已经从“默认全选”收成“本轮推荐”

当前状态：

- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php:301) 现在会按最近更新时间排序候选草稿
- 候选区只会默认勾选最近更新的一小批草稿，其余候选保持未选
- [console_releases.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_releases.html:1) 已经给默认勾选项补了 `本轮推荐`

结果：

- owner 能明显感知“系统在给建议”，而不是“系统已经替我决定了本次载荷”
- release center 的选择感已经更接近真实版本控制面

### R2-8 发布理由已经能从 gap signals 直接进入 release notes

当前状态：

- [console_releases.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_releases.html:1) 现在允许直接勾选“这次发布为什么值得发”
- [ConsoleController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/ConsoleController.php:1411) 已经把 gap signals 变成可提交的 `release_reasons[]`
- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php:714) 会把这些原因自动写到 release notes 开头

结果：

- 发布页里的“知识缺口”和“版本说明”已经形成一条更自然的叙事链
- owner 不再需要手动从另一块抄理由到 release notes

### R2-9 真实运行态里的公开验证入口已经切到 `/validation`

当前状态：

- [LocalizedUrlBuilder.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Support/LocalizedUrlBuilder.php:212) 的 `validationWithQuery()` 现在会生成 `/brand/{tenant}/validation`
- [routes/web.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/routes/web.php:152) 已经把 `/brand/:tenant/validation` 设为 canonical 入口
- [PublicController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/PublicController.php:384) 的旧 `assistant()` 现在只负责兼容跳转
- 实际运行态 walkthrough 已确认：
  - 品牌页 CTA 会进入 `/validation`
  - 控制台首页“打开验证页”会进入 `/validation`
  - 发布历史“查看验证页”会进入 `/validation`

结果：

- 公开面不再暴露旧 `assistant` 路径作为主产品入口
- 运行态页面终于和当前产品命名一致，不再出现“文案说 validation、链接却还是 assistant”的断裂

### R2-10 真实运行态 walkthrough 已验证验证链可走通

当前状态：

- 真实请求 `GET /brand/acme-research/validation?q=报销` 时，页面已经稳定展示：
  - `答案预览`
  - `引用来源`
  - `验证之后下一步做什么`
- 引用来源标题已经能直接点进：
  - [public_detail document](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/public_detail.html:1)
  - [public_detail entry](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/public_detail.html:1)
- `tests/console_db_write_smoke.php` 已再次通过，说明这轮修正没有打断写入链

结果：

- “品牌页 -> 验证页 -> 引用来源 -> 公开详情 -> 回到验证链” 这条 RC walkthrough 主链已经真正跑通
- 当前剩下的问题更多是 codebase 层的 legacy 兼容，而不是用户可见主链断裂

### R2-11 历史版本模式下的验收链接已经统一继承 `release`

当前状态：

- [PublicBrandPresenter.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Presenters/PublicBrandPresenter.php:14) 现在会优先使用当前请求里的 `release`，不再偷偷回落到 snapshot 自己的版本
- [PublicController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/PublicController.php:284) 现在会给 citation 详情链接补上当前 `release`
- [PublicController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/PublicController.php:561) 里的公开详情页回到验证页，也已经保留 `release`
- 真实运行态 walkthrough 已确认：
  - `/brand/acme-research?release=v0.1` 上的“开始知识验证”会进入 `/brand/acme-research/validation?release=v0.1`
  - `/brand/acme-research/documents/doc-acme-1?release=v0.1` 上的“回到验证页”会回到 `/brand/acme-research/validation?release=v0.1`
  - `/brand/acme-research/validation?q=报销&release=v0.1` 里的来源链接也会继续携带 `release=v0.1`

结果：

- 历史版本验收已经不再出现“页面提示你在看历史版本，但下一步链接把你悄悄带回别的版本”的断裂
- 现在品牌页、验证页、公开详情页三者之间的历史版本模式已经能稳定闭环

### R2-12 空白 release notes 已经被收成可读版本摘要

当前状态：

- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php:249) 现在会在 release notes 为空时，按版本状态和载荷数量生成可读摘要
- [PublicWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/PublicWorkspaceService.php:405) 也会在公开面为历史版本和当前版本补同类说明
- [DemoCatalog.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Support/DemoCatalog.php:240) 的 fallback release 数据也已经带上基线 notes
- 真实运行态 walkthrough 已确认：
  - `/console/releases` 里的 `v0.1` 不再是空白说明，而会显示 `Public knowledge release covering 3 docs / 3 entries.`
  - onboarding draft release 也会显示基于载荷数量的 handoff 摘要
  - `/brand/acme-research?release=v0.1` 的“当前版本说明”不再留白

结果：

- 发布中心和公开面都不再出现一排空白 release notes 的半成品观感
- 即使旧库里的历史 release 没有手工写 notes，owner 现在也能看懂“这一版大概是什么”

### R2-13 当前公开版本已经和真实 published payload 对齐

当前状态：

- [KnowledgeRepository.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Repositories/KnowledgeRepository.php:320) 新增了 `latestPublishedRelease()`
- [PublicWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/PublicWorkspaceService.php:405) 现在默认会把“当前公开版本”解析到最近 `published` 的 release，而不是单纯时间上最新的一条
- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php:279) 的 `releaseSnapshot()` 也改成按真实 public payload 计算“当前公开版本”的版本号、说明和内容数量
- 真实运行态 walkthrough 已确认：
  - 品牌页默认回到 `v0.1 / published`
  - 验证页默认回到 `v0.1 / published`
  - `/console/releases` 里的“当前公开版本”不再指向 `onboarding-subscriber-acme-1` 这种 draft handoff release

结果：

- draft onboarding release 现在只留在历史表和交付链里，不会再冒充线上公开版本
- 发布中心、品牌页、验证页终于开始对“当前线上是什么”给出同一个答案

### R2-14 对外版本显示名与中文公开显示名已经统一到更产品化的标签

当前状态：

- [PublicController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/PublicController.php:24) 现在会把对外看到的版本号格式化成显示名
- [ConsoleController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/ConsoleController.php:1353) 也会把发布中心里的当前版本、版本比较和历史表统一走同一套显示名
- [ConsoleController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/ConsoleController.php:1041) 还会在中文环境下把 `ops` 页里 demo 审计目标、job 名称和 provisioning checklist 名称做显示层本地化，避免 `Acme Operations Brief 2026.Q2`、`Settlement exception triage`、`Sync public validation cache` 这类英文 seed 文本直接暴露给演示用户
- 同一控制器现在也会把控制台里自动生成的 onboarding 文档 / FAQ 标题、以及 release history / version compare 里的 onboarding scaffold notes 做显示层本地化，避免 `Starter Launch Plan for ...`、`Team FAQ for ...`、`Starter onboarding release scaffold ...` 这类模板文案直接出现在中文 walkthrough 里
- 当前显示规则已经至少覆盖：
  - `v0.1` -> `2026.Q2`
  - `onboarding-*` -> `Customer Onboarding Draft` / `客户开通草稿`
  - `next` -> `Next Release` / `下一发布版本`
- [PublicController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/PublicController.php:666) 的公开显示名也已经按 locale 切换：
  - `acme-research` 在中文环境下显示为 `Acme 运营简报`
  - `nova-advisory` 在中文环境下显示为 `Nova 知识台`
- 真实运行态 walkthrough 已确认：
  - 品牌页 badge 显示 `版本 2026.Q2 / published`
  - 历史版本 notice 显示 `当前正在查看历史版本 2026.Q2`
  - `/console/releases` 里的历史表不再直接暴露 `onboarding-subscriber-acme-1`

结果：

- 对外公开面和发布中心终于不再把内部技术版号直接摊给用户看
- 中文公开面和发布中心也不再一边使用中文产品文案、一边露出英文版本/品牌标签
- `Acme` 这套 demo 的版本表达和公开显示名已经更像准备发布的产品实例，而不是工程内部状态面板

---

## Remaining

### P1-1 旧 `/publish` 路由还在，虽然已导流，但信息架构仍有历史包袱

影响：

- 当前用户路径已经正确，但代码和路由层仍保留旧入口
- 后续继续扩张时，容易让新功能误接到旧路径上

证据：

- [routes/web.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/routes/web.php:42) 和 [routes/web.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/routes/web.php:118) 仍保留 `/publish`

当前控制：

- 路由和控制器都已经显式标成 legacy compat
- 运行时也会统一导流到 release center

建议：

- 如果准备对外发布，可以继续保留兼容
- 但后续若要收口代码面，优先考虑把它们进一步集中到单独的 legacy 区块

---

## 已处理的历史项

### R1 编辑器工作区恢复为全宽

已修复：

- [console_documents.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_documents.html:1)
- [console_faqs.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_faqs.html:1)

说明：

带 `Milkdown` 的编辑表单此前被放回双栏网格，导致正文编辑器只占半屏；当前已恢复为全宽编辑工作区。

---

## 收敛建议

1. 先决定旧 `/publish` 路由是长期保留兼容，还是只保留短期过渡。
2. 发布前再做一轮更偏运营/内容质量的 walkthrough，而不是继续追页面信息架构。

## 下一轮走查重点

- 用 `owner@acme.test` 走完整的“首页 -> 编辑 -> 发布 -> 品牌页 -> 验证页 -> 来源详情 -> 历史版本回查”
- 特别确认：
  - owner 是否还会把旧 `/publish` 当成真实入口
  - 历史版本模式的 notice 是否足够明显，不会误认成当前线上版本
