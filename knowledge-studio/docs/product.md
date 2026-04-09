# Product Spec

## 1. Product Summary

`Knowledge Studio` 是一个多租户 AI 知识品牌平台。

每个租户都可以：

- 邀请多位知识工作者协作维护知识资产
- 配置自己的品牌形象、公开助手与工具能力
- 以统一对外形象服务普通用户
- 通过订阅机制向外部用户提供知识问答与内容服务

平台的第一目标不是复刻某个已有产品，而是证明 `VSlim` 可以支撑：

- 严肃的多租户 SaaS 边界
- 协作型后台工作台
- 对外品牌化前台
- 流式 AI 交互与实时任务

## 2. Product Goals

### 2.1 Primary Goals

- 做出一个具有真实产品结构的 `VSlim` flagship sample
- 清楚表达“团队维护知识，对外统一服务，用户可订阅”的闭环
- 在业务层面完整覆盖多租户、权限、发布、订阅、审计、问答
- 在技术层面清楚表达 `stream + websocket/liveview + cli + db + auth`

### 2.2 Non-Goals

- 不在第一阶段追求完整商业支付系统
- 不在第一阶段追求高级向量检索平台
- 不在第一阶段做重型内容协同编辑器
- 不在第一阶段做复杂 agent orchestration

## 3. Target Users

### 3.1 Platform Admin

负责全站租户治理、套餐模板、风险控制、全局指标。

### 3.2 Tenant Owner

负责租户品牌、成员管理、公开助手、订阅计划、运营看板。

### 3.3 Knowledge Editor

负责维护文档、FAQ、专题、回答策略、知识发布。

### 3.4 Subscriber

外部普通用户，按免费或付费套餐访问公开知识助手与内容。

## 4. Core Value Proposition

### 4.1 For Tenant Teams

- 让团队而不是个人维护知识服务
- 让知识资产可以发布、运营、复用、订阅化
- 让对外服务形象统一，不暴露后台复杂性

### 4.2 For End Users

- 获得稳定、可订阅、带来源引用的知识问答服务
- 用一个统一助手访问文档、FAQ、专题和工具结果

### 4.3 For VSlim Positioning

- 展示 `VSlim` 已具备应用级架构能力
- 展示 `VSlim` 对实时、流式、工具接入类产品的天然适配

## 5. Product Shape

产品分为两套主要体验：

### 5.1 Tenant Console

给租户团队使用的后台控制台。

核心模块：

- 工作台概览
- 知识资产管理
- FAQ / 专题维护
- 发布中心
- 品牌设置
- 成员管理
- 订阅计划设置
- 会话分析
- 工具与 MCP 配置
- 审计日志

### 5.2 Public Assistant

给外部订阅用户访问的品牌化前台。

核心模块：

- 品牌首页
- 注册 / 登录 / 订阅
- AI 问答台
- 专题内容页
- 我的订阅
- 历史会话

## 6. Core User Flows

### 6.1 Tenant Onboarding

1. 平台管理员创建租户
2. 租户拥有者配置品牌名称、logo、主题色、欢迎语
3. 邀请知识编辑者加入 workspace
4. 配置第一批知识文档与 FAQ
5. 发布公开助手

### 6.2 Knowledge Publishing

1. 编辑者上传文档或维护 FAQ
2. 系统创建索引任务
3. 编辑者预览检索结果与回答效果
4. 租户发布一个知识版本
5. 公开助手切换到新版本

### 6.3 Subscriber Experience

1. 外部用户进入租户品牌首页
2. 选择免费试用或订阅计划
3. 在问答台提问
4. 回答以流式方式输出
5. 页面展示来源引用、工具调用摘要
6. 用户在历史会话中回看记录

### 6.4 Operations Feedback Loop

1. 租户查看常见问题和低质量回答
2. 补充 FAQ 或修正文档
3. 重新发布知识版本
4. 指标改善

## 7. MVP Scope

第一阶段只做能证明产品成立的闭环。

### 7.1 Must Have

- workspace 多租户隔离
- workspace 成员与基础角色
- 文档与 FAQ 管理
- 知识发布版本
- 公开品牌页
- 公开 AI 助手页
- 流式回答
- 回答来源展示
- 订阅门槛与基础访问控制
- 会话保存
- 审计日志
- 后台任务列表

### 7.2 Should Have

- 检索调试页
- 工具调用日志页
- workspace 切换
- 租户级 welcome prompt / assistant profile

### 7.3 Later

- 真正的在线支付与账单
- 更复杂的价格套餐
- 多模型路由
- 高级内容审核流
- 多人并发编辑冲突处理

## 8. Role Matrix

### 8.1 Platform Admin

- 管理租户
- 查看全站日志与指标
- 管理平台级套餐模板

### 8.2 Tenant Owner

- 管理租户成员
- 配置品牌
- 配置公开助手
- 发布知识版本
- 查看本租户分析

### 8.3 Knowledge Editor

- 维护文档与 FAQ
- 查看索引任务
- 调试检索与回答
- 不可管理计费和成员

### 8.4 Subscriber

- 访问公开助手
- 查看自己的会话历史
- 按套餐能力访问内容

## 9. Information Architecture

### 9.1 Tenant Console Routes

- `/console`
- `/console/knowledge`
- `/console/knowledge/documents`
- `/console/knowledge/faqs`
- `/console/releases`
- `/console/branding`
- `/console/members`
- `/console/tools`
- `/console/analytics`
- `/console/logs`

### 9.2 Public Routes

- `/@{tenant}`
- `/@{tenant}/pricing`
- `/@{tenant}/login`
- `/@{tenant}/subscribe`
- `/@{tenant}/assistant`
- `/@{tenant}/sessions/{id}`
- `/@{tenant}/topics/{slug}`

## 10. Domain Model

核心实体：

- `users`
- `workspaces`
- `workspace_members`
- `assistant_profiles`
- `knowledge_documents`
- `knowledge_entries`
- `knowledge_releases`
- `subscriber_accounts`
- `subscriptions`
- `chat_sessions`
- `chat_messages`
- `jobs`
- `tool_call_logs`
- `audit_logs`

模型原则：

- 所有租户内业务数据必须明确挂 `workspace_id`
- 对外访问入口必须通过租户 slug 或绑定域名解析到 workspace
- 公开助手读取的是“已发布版本”，不是编辑中的草稿

## 11. Billing Shape

第一阶段只做轻量订阅门槛，不做重型账单系统。

建议支持：

- `free`
  每日有限问答次数
- `pro`
  更高额度与历史会话
- `team`
  预留给后续租户级组织订阅

MVP 中可以先保留以下状态：

- `trialing`
- `active`
- `past_due`
- `canceled`

## 12. Success Criteria

这个 sample 成功的标志不是功能越多越好，而是能清楚证明以下几点：

- 一个租户可邀请多人协作维护知识
- 对外能形成统一品牌助手
- 用户可在订阅门槛下使用问答服务
- 问答具备流式输出与来源引用
- 知识变更可发布并影响对外助手
- 多租户与权限边界清晰

## 13. Sample Narrative

最适合演示的故事线：

1. 创建一个名为 `Acme Research` 的租户
2. 两位知识编辑者维护 FAQ 和专题文档
3. 发布公开助手 `Acme Advisor`
4. 外部用户订阅后进入品牌页提问
5. 系统流式回答，并展示来源和工具调用
6. 租户后台查看提问热词和低质量回答，继续迭代知识

这条 narrative 足够完整，也最能体现 `VSlim` 的能力边界。
