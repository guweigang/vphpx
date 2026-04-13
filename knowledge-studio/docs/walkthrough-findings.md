# Walkthrough Findings

## Round 1

日期：2026-04-13

范围：

- `/console`
- `/console/knowledge/documents`
- `/console/knowledge/faqs`
- `/console/releases`
- `/brand/{tenant}`
- `/brand/{tenant}/assistant`
- `/brand/{tenant}/documents/{id}`
- `/brand/{tenant}/entries/{id}`

结论：

当前产品主链路已经能被讲清楚，但还没有完全收成“可稳定演示的 SaaS 原型”。

最关键的问题不在页面数量，而在两个地方：

1. 发布关口的语义还没有真正成立
2. 几个关键页面虽然在展示信息，但没有把用户自然送进下一步

---

## P0

### P0-1 发布页当前在打包“已发布内容”，不是“待发布内容”

影响：

- `tenant owner` 无法真正通过发布页决定“这一版要把哪些新内容带到公开面”
- 发布中心失去上线关口意义，变成对已在线内容的再次打包

证据：

- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php) 的 `releaseSnapshot()` 中，`document_candidates` 来自 `publishedDocuments`
- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php) 的 `releaseSnapshot()` 中，`entry_candidates` 来自 `publishedEntries`
- [console_releases.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_releases.html) 的候选区直接消费了这两组 candidates

为什么这是 P0：

我们当前已经把产品定位明确成“内容供给 -> 发布 -> 公开页承接 -> 助手验证”，如果发布页不能承接“待上线内容”，那整条主链路的中间环节就是假的。

建议：

- 发布候选应优先展示 `draft / ready_for_release` 内容，而不是已经发布的内容
- 发布页应明确区分：
  - 本次新增载荷
  - 已在线载荷
  - 本次未纳入的草稿

### P0-2 编辑页仍然允许直接发布，和“发布中心是上线关口”的产品定义冲突

影响：

- owner 和 editor 可以绕过发布中心直接把内容上线
- 发布记录、公开预览、版本说明会失去唯一可信来源

证据：

- [ConsoleController.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Http/Controllers/ConsoleController.php) 暴露了 `publishDocument()` 和 `publishEntry()`
- [console_document_editor.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_document_editor.html) 顶部有直接“发布到助手”动作
- [console_entry_editor.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_entry_editor.html) 顶部也有直接发布动作

为什么这是 P0：

这不是交互偏好问题，而是产品边界问题。如果发布入口不唯一，后面做版本治理、差异说明、公开验证都会继续乱。

建议：

- 把编辑页直接发布改成“加入待发布清单”或“标记为待发布”
- 真正的公开上线动作只保留在 `/console/releases`

---

## P1

### P1-1 控制台首页“内容供给”区展示了最近内容，但没有把人送进编辑页

影响：

- owner/editor 在首页看见最近内容后，还要自己再去列表页找一次
- 首页更像摘要墙，不像工作台

证据：

- [console.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console.html) 中 `recent_documents` 和 `recent_entries` 只是纯文本列表，没有编辑链接
- 同页的 `priority_queue` 和 `knowledge_gaps` 已经有 CTA，说明首页本来就是可以承担分发动作的

建议：

- 最近文档和最近条目都补 `编辑` 或 `继续完善` 链接
- 如果内容是 draft，按钮文案应更明确，例如“继续完善草稿”

### P1-2 助手页的“引用来源”不能直接点进详情页，价值验证链路被截断

影响：

- 访问者在看到回答后，不能顺着引用直接验证来源
- “可引用、可追溯”的产品承诺没有落在最关键一步

证据：

- [assistant.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/assistant.html) 的 `citations` 卡片只展示标题、摘要和分数，没有详情链接
- 同页下方的 `documents` / `entries` 列表虽然有详情链接，但这已经不是用户自然关注的第一位置

建议：

- 在引用卡片标题上直接加详情链接
- 区分文档引用和条目引用的落点
- 在引用卡片中补一个清晰动作，例如“查看来源”

### P1-3 发布历史缺少“查看这版公开结果”的动作，owner 无法按版本回查

影响：

- 发布历史现在更像静态表格
- owner 不能从历史版本直接回到品牌页/助手页做验收

证据：

- [console_releases.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_releases.html) 的历史表只有版本、状态、说明、数量、时间
- 当前没有“查看公开页”“查看助手页”“查看载荷详情”之类动作

建议：

- 历史表补版本级 CTA
- 至少支持：
  - 查看品牌页
  - 查看助手页
  - 查看该次载荷概要

---

## P2

### P2-1 公开详情页还是“证明页”，但回流动作偏弱

影响：

- 用户进入来源详情后，只能返回上一层
- 页面没有继续引导回助手页提问或回品牌页继续了解方案

证据：

- [public_detail.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/public_detail.html) 当前只有 `back_url`

建议：

- 文档详情页补“去助手继续验证”
- 条目详情页补“回品牌页/回助手页”

### P2-2 发布页的候选区默认全选，降低了“本次发布选择”的存在感

影响：

- owner 更像在确认系统默认决定，而不是主动选择本次载荷
- 一旦内容量变多，这个交互会很快失控

证据：

- [ConsoleWorkspaceService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/ConsoleWorkspaceService.php) 中 candidates 统一写死了 `checked_attr = 'checked'`

建议：

- 默认只勾选“本轮刚更新”或“待发布”内容
- 已在线内容如果出现，应默认不勾选

---

## 已处理的本轮问题

### R1 编辑器工作区恢复为全宽

已修复：

- [console_documents.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_documents.html)
- [console_faqs.html](/Users/guweigang/Source/vphpx/knowledge-studio/resources/views/console_faqs.html)

说明：

带 `Milkdown` 的编辑表单此前被放回双栏网格，导致正文编辑器只占半屏；当前已恢复为全宽编辑工作区。

---

## 建议的收敛顺序

1. 先修 P0，统一“发布”语义
2. 再修 P1，把首页和助手页的关键跳转补齐
3. 最后修 P2，把公开详情和版本回查做完整

## 下一轮走查重点

- 发布语义统一后，再走一遍 `Tenant Owner`
- 补完引用直达详情后，再走一遍 `Visitor / Subscriber`
- 走查时要特别确认：页面是否还需要大量口头解释才能成立
