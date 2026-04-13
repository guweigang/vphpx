# Product Walkthrough Checklist

## 1. Why This Checklist Exists

后续我们不应该再靠“页面看起来差不多了”判断产品是否成立。

`Knowledge Studio` 是一个有明确主场景的 SaaS 原型，所以走查必须围绕真实角色和真实动线展开。

这份清单用来回答三个问题：

1. 角色进入系统后，是否知道自己下一步该做什么？
2. 页面之间是否真的连成一条业务链？
3. 产品是否已经像一个可理解、可演示、可继续 SaaS 化的原型，而不是零散 demo？

## 2. How To Use It

每次做阶段性走查时，都按下面顺序执行：

1. 先走 `Tenant Owner`
2. 再走 `Knowledge Editor`
3. 最后走 `Visitor / Subscriber`

每一步都只看三件事：

- 能否理解当前页面的职责
- 能否自然进入下一步
- 当前信息是否足够支持决策或行动

如果一个环节出现“要解释很久用户才明白”，就视为页面职责还没收好。

额外再看一件事：

- 这个页面离“回到下一轮内容供给”还有多远

如果一条动线只能走出去，走不回来，就不算闭环。

## 3. Tenant Owner Walkthrough

### 3.1 Enter The Console

入口：

- `/login`
- `/console`

检查点：

- 登录后是否立刻知道这是自己的工作区，而不是泛后台
- 是否能在工作台一眼看见当前品牌、角色、发布状态
- 是否能在 10 秒内判断“今天先做什么”

通过标准：

- 工作台首页不是数据堆叠，而是明确的供给侧总览
- owner 能立刻看出应该去内容库、发布中心还是公开页验证

### 3.2 Understand Current Supply

入口：

- `/console/knowledge/documents`
- `/console/knowledge/faqs`

检查点：

- owner 能否看懂“文档”和“条目”的区别
- owner 能否快速判断当前缺的是来源材料还是标准答案
- owner 是否知道覆盖问题字段的用途

通过标准：

- 文档页明确是来源材料工作面
- FAQ / 条目页明确是标准答案工作面
- 两页不会被看成两个相似 CRUD 页面

### 3.3 Prepare A Release

入口：

- `/console/releases`

检查点：

- owner 是否知道为什么要在这里发布，而不是在内容页直接上线
- owner 是否能看明白本次发布要带出哪些文档和条目
- owner 是否能根据最近问题反馈判断本次发布理由

通过标准：

- 发布页是“上线关口”，不是普通列表页
- 发布理由、载荷选择、发布预览三者关系清楚

### 3.4 Verify Public Result

入口：

- `/brand/{tenant}`
- `/brand/{tenant}/assistant`

检查点：

- owner 是否能从发布页顺畅跳到品牌页和助手页验证
- owner 是否能看出公开页是否已经承接了本次发布
- owner 是否能看出助手页回答和引用是否可信

通过标准：

- owner 不需要回忆系统逻辑，也能验证“这次发布是否成功对外表达”
- owner 还能顺着外部问题、订阅线索或验证结果回到下一轮内容运营

## 4. Knowledge Editor Walkthrough

### 4.1 Start From A Gap

入口：

- `/console`
- `/console/knowledge/documents`
- `/console/knowledge/faqs`

检查点：

- editor 是否能从工作台的反馈区找到下一条值得补的内容
- editor 是否能区分“这次该补 FAQ”还是“该补来源文档”

通过标准：

- 工作台反馈项能自然跳到新建草稿
- editor 不需要自己猜内容该落在哪个工作面

### 4.2 Create Or Edit A Source Document

入口：

- `/console/knowledge/documents`
- `/console/knowledge/documents/{id}`

检查点：

- editor 是否理解这份文档是来源材料，而不是最终回答
- 编辑页是否强调规则、流程、证据、背景信息
- 保存后的预览是否能帮助判断文档是否足够可引用

通过标准：

- 文档编辑台围绕“来源材料质量”展开

### 4.3 Create Or Edit A Canonical Answer

入口：

- `/console/knowledge/faqs`
- `/console/knowledge/faqs/{id}`

检查点：

- editor 是否理解条目是标准答案，不是长文材料
- 编辑页是否强调结论、范围、例外、下一步动作
- 覆盖问题是否贴近真实提问方式

通过标准：

- 条目编辑台围绕“可直接复用的标准答案”展开

### 4.4 Hand Off To Release

入口：

- `/console/releases`

检查点：

- editor 是否知道自己的内容何时进入发布
- 页面是否能帮助 editor 理解发布前还缺什么

通过标准：

- 编辑者能把“写完内容”顺畅转换成“准备上线”
- 编辑者也知道发布后应该去哪里看真实反馈

## 5. Visitor / Subscriber Walkthrough

### 5.1 Land On The Brand Page

入口：

- `/brand/{tenant}`

检查点：

- 访问者是否能在 5 到 10 秒内理解这是什么服务
- 是否知道这是团队知识服务，而不是个人博客或随机聊天页
- 是否能自然看到下一步动作

通过标准：

- 品牌页先讲价值，再讲方案，再给内容证明

### 5.2 Evaluate The Offer

入口：

- `/brand/{tenant}#plans`

检查点：

- 访问者是否能看懂方案差异
- 是否能顺势留下订阅意向
- 订阅表单是否看起来是产品承接，而不是临时 demo 表单

通过标准：

- 方案区和订阅动作属于同一转化路径

### 5.3 Validate Through The Assistant

入口：

- `/brand/{tenant}/assistant`

检查点：

- 访问者是否一进来就知道可以马上提问
- 页面主角是否是提问、答案、引用，而不是说明卡片
- 回答是否让访问者觉得“这个服务有真实知识底座”

通过标准：

- 助手页是价值验证页，不是另一个介绍页

### 5.4 Verify The Source

入口：

- `/brand/{tenant}/documents/{id}`
- `/brand/{tenant}/entries/{id}`

检查点：

- 访问者是否能顺着引用或公开内容继续看细节
- 详情页是否在强化可信度，而不是把人带进另一个复杂系统

通过标准：

- 公开详情页是内容证明页，能支撑品牌页和助手页的可信度
- 访问者完成验证后，也能自然回到助手页、品牌页或订阅动作

## 6. Cross-Page Checks

这部分每次走查都必须额外看一遍。

### 6.1 Role Clarity

检查点：

- owner、editor、visitor 三种角色看到的主要动作是否不同
- 页面是否真的在服务当前角色

### 6.2 Page Sequencing

检查点：

- 每个页面的前一步和后一步是否清楚
- 是否存在“页面本身可用，但不知道接下来去哪”的断点
- 是否存在“页面能把人送出去，但送不回下一轮内容补充”的断点

### 6.3 Product Language

检查点：

- 页面是否都在讲同一个产品故事
- 是否还残留“框架 sample”式表述
- 是否还能看出“知识供给侧 SaaS”这条主线

### 6.4 Proof Of Reality

检查点：

- 真实数据库写路径是否已经在关键流程里被体现
- 发布版本是否真的影响公开页
- 公开页内容是否看得出来自真实供给，而不是占位卡片

## 7. Severity Levels For Findings

走查发现的问题，统一按下面四档记录：

### 7.1 P0

主流程断裂。

例如：

- 无法完成内容创建
- 无法发布
- 无法进入公开页验证

### 7.2 P1

主流程可走，但角色无法快速理解页面职责。

例如：

- 不知道为什么来到这个页面
- 看不出下一步该去哪
- 页面与角色不匹配

### 7.3 P2

主流程成立，但产品感不足。

例如：

- 信息层级混乱
- 承接动作不自然
- 说明文字过多、页面太像后台工具

### 7.4 P3

细节 polish 问题。

例如：

- 按钮样式
- 间距
- 文案不够顺

## 8. Current Recommended Walkthrough Order

建议每次回归都按下面顺序：

1. `owner@acme.test`
   从登录到工作台，再到发布中心，再到公开页和助手页
2. `editor@acme.test`
   从工作台反馈进入文档或 FAQ，再到编辑页
3. 外部访问者
   从品牌页进入方案，再到助手页提问，再看公开详情页

## 9. Definition Of A Good Walkthrough

一次好的走查，不是“页面都打开了”，而是下面五件事都成立：

- 三个角色都知道自己在系统里的任务
- 页面之间前后关系清楚
- 内容供给和公开服务之间有真实连接
- 访问者能完成从理解价值到验证价值的路径
- 团队能完成从发现缺口到补内容再到发布的路径
