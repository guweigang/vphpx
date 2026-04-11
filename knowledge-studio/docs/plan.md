# Delivery Plan

## 1. Working Assumptions

- 项目目录单独放在 `vphpx/knowledge-studio`
- 第一阶段以 `VSlim` sample 为目标，不以商业化上线为目标
- 优先完成真实产品闭环，再逐步替换 mock 能力
- 订阅能力先做状态和门槛，不接真实支付

## 2. Milestones

### Milestone 0: Foundation

目标：把项目跑起来，并把多租户边界定稳。

交付：

- `VSlim` app skeleton 初始化
- 基础配置与 bootstrap
- `users / workspaces / workspace_members` migration
- 登录、session、workspace resolver
- console 基础布局

完成标准：

- 用户可以登录
- 用户可进入自己所属 workspace
- 基础权限判断成立

### Milestone 1: Knowledge Console MVP

目标：让租户团队能维护知识。

交付：

- 文档列表、上传、详情页
- FAQ / knowledge entry CRUD
- jobs 表与任务列表
- 审计日志基础记录
- 品牌设置页

完成标准：

- 编辑者可维护知识资产
- 后台能看到导入任务和操作日志
- workspace 间数据隔离正确

### Milestone 2: Publish and Public Assistant

目标：跑通“后台维护 -> 对外服务”闭环。

交付：

- `knowledge_releases`
- 发布动作
- 公开品牌页
- 公开助手页
- 订阅门槛与 subscriber account

完成标准：

- 公开助手读取已发布版本
- 外部用户可登录并访问助手
- 非订阅用户受限

### Milestone 3: Streaming and Conversation Persistence

目标：把核心问答体验做出来。

交付：

- 流式回答接口
- `chat_sessions / chat_messages`
- 来源引用面板
- 历史会话页

完成标准：

- 用户提问后可看到流式回答
- 回答可保存并回放
- 每次回答可关联知识来源

### Milestone 4: Realtime Ops and Polish

目标：把工作台打磨成可演示旗舰 sample。

交付：

- 索引任务实时更新
- console 指标卡片
- 工具调用日志
- 检索调试页
- demo seed 与 CLI 命令
- 集成测试第一批

完成标准：

- demo 路径 3 到 5 分钟可完整演示
- 核心权限与主流程有测试覆盖

## 3. Suggested Weekly Breakdown

### Week 1

- 初始化项目骨架
- 建立认证与 workspace 模型
- 跑通 console layout

### Week 2

- 完成知识资产管理
- 完成 jobs 与审计
- 完成品牌设置

### Week 3

- 完成发布与 public assistant
- 完成 subscriber 访问门槛

### Week 4

- 完成流式回答
- 完成会话持久化
- 完成来源展示

### Week 5

- 完成实时任务状态
- 完成工具日志与调试页
- 完成种子数据与测试

## 4. Workstreams

### 4.1 App Skeleton

- bootstrap 约定
- console/public 路由拆分
- service provider 装配

### 4.2 Identity and Tenanting

- auth/session
- workspace membership
- role gate
- tenant resolver

### 4.3 Knowledge Domain

- documents
- entries
- releases
- ingest jobs

### 4.4 Assistant Domain

- sessions/messages
- answer streaming
- citations
- tool call surface

### 4.5 Subscriber Domain

- subscriber login
- plan gate
- usage limit

### 4.6 Ops

- audit logs
- analytics seed
- CLI
- tests

## 5. First Implementation Backlog

建议最先开工的任务顺序：

1. 初始化 `knowledge-studio` 为 `VSlim` app skeleton
2. 建 `users / workspaces / workspace_members`
3. 跑通登录和 workspace console
4. 建 `knowledge_documents / knowledge_entries / jobs / audit_logs`
5. 做知识管理页
6. 建 `knowledge_releases / assistant_profiles`
7. 做公开品牌页和公开助手页
8. 建 `subscriber_accounts / subscriptions`
9. 接流式回答
10. 补 CLI、实时更新和测试

## 6. Testing Plan

第一批必须覆盖：

- 登录与 workspace 隔离
- 角色权限
- 文档/FAQ CRUD
- 发布流程
- 公开助手订阅门槛
- 流式回答接口

## 7. Risks and Mitigations

### Risk: Product Scope Expands Too Quickly

应对：

- 严格按 milestone 推进
- 非核心能力全部后置

### Risk: AI Stack Becomes the Critical Path

应对：

- 前期允许 mock answer / mock retrieval
- 先把平台结构跑通，再替换真实模型

### Risk: Multi-Tenant Permissions Become Messy

应对：

- 早期统一 `workspace_id` 规则
- 所有 console 查询先经 workspace scope
- 先用简单角色，不早拆细粒度 ACL

## 8. Definition of Done for MVP

以下条件满足时，MVP 视为完成：

- 租户拥有者可邀请编辑者协作维护知识
- 可发布一个对外统一品牌助手
- 外部用户可在订阅门槛下发起问答
- 回答支持流式输出并展示来源
- 会话、任务、审计日志可回看
- 多租户与角色边界可通过测试验证
