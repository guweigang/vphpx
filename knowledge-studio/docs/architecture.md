# Architecture Draft

## 1. Why This Architecture Fits VSlim

`Knowledge Studio` 需要同时具备：

- 标准 HTTP 页面与 API
- 用户登录、session、role-based access
- 多租户数据隔离
- 文档导入与异步任务
- 流式 AI 回答
- 实时任务状态更新
- CLI 辅助运维

这正好覆盖 `VSlim` 现有已经成熟的能力面。

## 2. Suggested App Layout

建议按 `VSlim` 的 app skeleton 来组织：

- `app/Http/Controllers`
- `app/Http/Middleware`
- `app/Providers`
- `app/Modules`
- `app/Commands`
- `app/Services`
- `app/Policies`
- `app/Repositories`
- `resources/views`
- `config`
- `database/migrations`
- `database/seeds`

## 3. Runtime Boundaries

### 3.1 HTTP

用于：

- console 页面
- public 品牌页
- 登录、注册、订阅流程
- 文档管理与管理后台接口

### 3.2 Stream Response

用于：

- 对话问答 token 流式输出
- 长报表导出
- 可能的任务事件流输出

### 3.3 WebSocket / LiveView

用于：

- 索引任务进度实时更新
- 会话状态同步
- console 指标卡片局部刷新
- 发布状态提示

### 3.4 CLI

用于：

- demo 数据初始化
- 文档重建索引
- 清理历史任务
- 周期性统计汇总

## 4. Multi-Tenant Boundary

采用 `workspace` 作为租户边界。

### 4.1 Required Rules

- 所有租户内业务表必须带 `workspace_id`
- 所有 console 查询默认按当前 workspace scope
- 所有 public 访问通过 `{tenant_slug}` 解析 workspace
- 后台成员权限在 `workspace_members` 中定义
- 公开助手只读取当前 workspace 的已发布知识版本

### 4.2 Nice-to-Have Later

- 自定义域名
- 跨 workspace 用户身份映射
- workspace 级工具白名单

## 5. Suggested Modules

### 5.1 Identity Module

负责：

- 登录
- session
- workspace membership
- role resolution

### 5.2 Knowledge Module

负责：

- 文档
- FAQ/entry
- 发布版本
- 检索元数据

### 5.3 Assistant Module

负责：

- chat session
- message persistence
- answer orchestration
- source citation assembly

### 5.4 Subscription Module

负责：

- subscriber account
- subscription gate
- plan enforcement

### 5.5 Ops Module

负责：

- jobs
- audit logs
- analytics
- tool call logs

## 6. Data Shape

建议第一批核心表：

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

## 7. Request Patterns

### 7.1 Console Request

`session auth -> workspace resolver -> role gate -> controller -> view/json`

### 7.2 Public Assistant Request

`tenant resolver -> subscription gate -> question validation -> answer stream`

### 7.3 Publish Request

`session auth -> owner/editor role gate -> create release -> enqueue indexing/sync job -> update public assistant target release`

## 8. Service Layer Sketch

建议把复杂业务收敛到 service 层：

- `WorkspaceService`
- `MembershipService`
- `BrandingService`
- `KnowledgeIngestService`
- `KnowledgePublishService`
- `RetrievalService`
- `AssistantService`
- `SubscriptionService`
- `AuditLogService`
- `JobService`

## 9. VSlim Capability Mapping

### 9.1 Use Native VSlim Features Directly

- `Session\StartMiddleware`
- `Auth` / guest middleware
- `Validate\Validator`
- `Database\Manager` / query builder / migrator
- `Stream\Response`
- `WebSocket` / LiveView support
- `Cli\App`
- testing harness

### 9.2 Keep Interfaces Clean

- 控制器返回标准 response / view
- 服务层不直接依赖 transport
- stream 与普通 JSON/HTML 响应分开建入口

## 10. Deployment Story

开发态：

- 先支持 `php -S` 最小演示
- worker / websocket / liveview 场景走 `vhttpd + php-worker`

演示态：

- console、public assistant、stream、job updates 全部联通

## 11. Risks

- 范围容易膨胀成完整 SaaS
- 订阅计费容易把 MVP 拖重
- 检索和模型接入如果过早追求真实，会影响整体推进节奏

## 12. Scope Control

为了确保 sample 能落地，第一阶段坚持：

- 可用 mock 或简化检索
- 可用轻量订阅状态，不接真实支付
- 优先把多租户、协作、品牌化、流式体验做完整
