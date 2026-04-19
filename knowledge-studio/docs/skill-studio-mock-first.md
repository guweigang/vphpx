# Skill Studio (Mock-First) Draft

## 1. Product Direction

如果 `Knowledge Studio` 要继续向前走，一个更清晰的升级方向不是“做更大的知识库”，而是：

`把知识沉淀能力升级为 Skill 设计、调试和测试能力`

但当前阶段不建议直接进入真实工具执行平台。

更适合的首版定义是：

`Skill Studio 是一个用于设计、调试、测试 AI Skill 的工作台。`

当前版本只支持：

- 真实模型运行
- 模拟工具调用
- 运行 trace
- 测试样本保存与重跑

当前版本明确不支持：

- live tool 调用
- 真实外部系统写操作
- 生产自动执行
- 通用 agent orchestration

## 2. Why Mock-First

如果一开始就做 live tool，产品会立刻卷入：

- 第三方系统集成
- 权限与密钥管理
- 真实副作用控制
- 限流、重试、超时
- 安全和审计
- 更高的运行成本

这些问题都真实存在，但它们属于“执行平台”问题，不是当前最该优先验证的“Skill 是否可设计、可调试、可测试”问题。

因此当前阶段建议坚持一个边界：

`All tools are simulated.`

这样可以先验证三件最重要的事：

- 用户会不会创建和维护一个 skill
- 用户会不会反复调试 skill
- 用户会不会保存样本并做回归验证

## 3. Positioning

### 3.1 One-Line Definition

可选的一句话定位：

- `Skill Studio：把团队经验打磨成可测试、可复用的 AI Skills`
- `Skill Studio：在模拟环境中设计和验证 AI Skill`
- `Skill Studio：先把 Skill 调通，再决定是否接入真实系统`

### 3.2 Homepage Subheadline

- `用真实模型 + 模拟工具，低成本验证 Skill 的逻辑、知识使用和输出质量。`
- `不直接调用真实外部系统，避免副作用、集成复杂度和高额调试成本。`

### 3.3 Core Value

- 先验证 skill，不先接系统
- 低成本模拟真实依赖
- 把 prompt、knowledge、tool usage 变成可重跑、可测试的资产

## 4. Product Boundary

这个方向下，产品不再是“执行型 agent 平台”，而是：

`AI Skill 的设计、调试、测试工作台`

因此首版要始终强化下面的用户心智：

- 这里是在设计 skill
- 这里是在模拟执行
- 这里不是生产自动化控制台

文案建议使用：

- `Run Simulation`
- `Mock Tool Response`
- `Save as Test`

避免使用：

- `Execute`
- `Live Tool`
- `Production Run`

## 5. Core Objects

首版建议只围绕 4 个核心对象设计：

- `Skill`
- `Mock Tool`
- `Test Case`
- `Run`

### 5.1 Skill

`Skill` 负责定义一个可调试的 AI 能力单元。

最小字段：

- 名称
- 描述
- 输入结构
- 系统指令
- 依赖知识源
- 允许使用的工具
- 输出结构
- 模型参数

示例：

```yaml
skill:
  id: "skill_refund_reply"
  name: "Refund Reply"
  description: "Generate a refund response based on policy and order context."

  input_schema:
    type: "object"
    properties:
      user_message:
        type: "string"
      order_id:
        type: "string"
    required: ["user_message", "order_id"]

  system_prompt: |
    You are a support specialist.
    Follow company refund policy strictly.
    Use tools when needed.
    Return output in the required JSON format.

  knowledge_sources:
    - "refund_policy_v1"
    - "support_tone_guide"

  allowed_tools:
    - "get_order"
    - "get_refund_policy"

  output_schema:
    type: "object"
    properties:
      decision:
        type: "string"
        enum: ["approve", "deny", "escalate"]
      reply:
        type: "string"
      reason:
        type: "string"
    required: ["decision", "reply", "reason"]

  metadata:
    model: "gpt-4.1-mini"
    temperature: 0.2
    version: 1
```

### 5.2 Mock Tool

`Mock Tool` 负责模拟 skill 依赖的外部系统，不做真实调用。

首版建议只支持两种模式：

- `static`
- `fixture_match`

示例：

```yaml
mock_tools:
  - name: "get_order"
    description: "Fetch order details by order_id."

    input_schema:
      type: "object"
      properties:
        order_id:
          type: "string"
      required: ["order_id"]

    mode: "fixture_match"

    fixtures:
      - when:
          order_id: "ORD-1001"
        response:
          order_id: "ORD-1001"
          status: "delivered"
          delivered_days_ago: 3
          amount: 99
          category: "digital"

  - name: "get_refund_policy"
    description: "Return refund policy summary."

    input_schema:
      type: "object"
      properties: {}

    mode: "static"

    static_response:
      digital: "Digital products are non-refundable after access."
      physical: "Physical products can be refunded within 30 days."
```

### 5.3 Test Case

`Test Case` 负责保存一个可重跑的验证样本。

示例：

```yaml
test_case:
  id: "tc_refund_digital_denied"
  skill_id: "skill_refund_reply"
  name: "Digital order should be denied"

  input:
    user_message: "I want a refund for my purchase."
    order_id: "ORD-1001"

  expected:
    checks:
      - type: "field_equals"
        field: "decision"
        value: "deny"
      - type: "field_contains"
        field: "reason"
        value: "digital"
      - type: "field_non_empty"
        field: "reply"

  labels:
    - "refund"
    - "digital"

  created_from_run_id: "run_001"
```

首版建议只支持 5 种断言：

- `field_equals`
- `field_contains`
- `field_non_empty`
- `valid_json`
- `schema_valid`

### 5.4 Run

`Run` 是最关键的执行事实对象。

它同时服务：

- 单次调试
- trace 展示
- 测试重跑
- 结果对比

示例：

```yaml
run:
  id: "run_001"
  skill_id: "skill_refund_reply"
  test_case_id: "tc_refund_digital_denied"

  input:
    user_message: "I want a refund for my purchase."
    order_id: "ORD-1001"

  resolved_knowledge:
    - source: "refund_policy_v1"
      snippet: "Digital products are non-refundable after access."

  tool_calls:
    - tool: "get_order"
      args:
        order_id: "ORD-1001"
      mocked: true
      response:
        order_id: "ORD-1001"
        status: "delivered"
        delivered_days_ago: 3
        amount: 99
        category: "digital"

  final_prompt: "..."

  output:
    decision: "deny"
    reply: "..."
    reason: "Digital product already accessed."

  metrics:
    latency_ms: 1820
    prompt_tokens: 920
    completion_tokens: 180

  assertions:
    passed: true
    results:
      - check: "field_equals decision=deny"
        passed: true
```

## 6. MVP Scope

首版只做 5 个模块就够了：

1. `Skill Definition`
2. `Run Playground`
3. `Trace Viewer`
4. `Test Cases`
5. `Batch Re-run`

这些模块刚好能验证：

- skill 是否可编辑
- skill 是否可运行
- 过程是否可观测
- 结果是否可保存为测试
- 修改后是否可回归验证

当前阶段明确不做：

- workflow builder
- marketplace
- live tool / sandbox tool
- 多 agent 编排
- 复杂自动评分器
- 重型权限系统

## 7. Minimal SQL Schema

建议首版使用下面 7 张表。

### 7.1 skills

```sql
CREATE TABLE skills (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  system_prompt TEXT NOT NULL,
  input_schema_json TEXT NOT NULL,
  output_schema_json TEXT NOT NULL,
  model TEXT NOT NULL,
  temperature REAL NOT NULL DEFAULT 0.2,
  version INTEGER NOT NULL DEFAULT 1,
  status TEXT NOT NULL DEFAULT 'draft',
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
```

### 7.2 skill_knowledge_sources

```sql
CREATE TABLE skill_knowledge_sources (
  id TEXT PRIMARY KEY,
  skill_id TEXT NOT NULL,
  source_key TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (skill_id) REFERENCES skills(id)
);
```

### 7.3 mock_tools

```sql
CREATE TABLE mock_tools (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  input_schema_json TEXT NOT NULL,
  mode TEXT NOT NULL,
  static_response_json TEXT,
  error_simulation_json TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
```

### 7.4 skill_tools

```sql
CREATE TABLE skill_tools (
  id TEXT PRIMARY KEY,
  skill_id TEXT NOT NULL,
  tool_id TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (skill_id) REFERENCES skills(id),
  FOREIGN KEY (tool_id) REFERENCES mock_tools(id)
);
```

### 7.5 mock_tool_fixtures

```sql
CREATE TABLE mock_tool_fixtures (
  id TEXT PRIMARY KEY,
  tool_id TEXT NOT NULL,
  match_json TEXT NOT NULL,
  response_json TEXT NOT NULL,
  priority INTEGER NOT NULL DEFAULT 100,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (tool_id) REFERENCES mock_tools(id)
);
```

### 7.6 test_cases

```sql
CREATE TABLE test_cases (
  id TEXT PRIMARY KEY,
  skill_id TEXT NOT NULL,
  name TEXT NOT NULL,
  input_json TEXT NOT NULL,
  expected_checks_json TEXT NOT NULL,
  labels_json TEXT,
  created_from_run_id TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (skill_id) REFERENCES skills(id)
);
```

### 7.7 runs

```sql
CREATE TABLE runs (
  id TEXT PRIMARY KEY,
  skill_id TEXT NOT NULL,
  test_case_id TEXT,
  trigger_mode TEXT NOT NULL,
  input_json TEXT NOT NULL,
  resolved_knowledge_json TEXT,
  tool_calls_json TEXT,
  final_prompt TEXT,
  output_json TEXT,
  assertions_json TEXT,
  status TEXT NOT NULL,
  error_message TEXT,
  latency_ms INTEGER,
  prompt_tokens INTEGER,
  completion_tokens INTEGER,
  cost_estimate TEXT,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (skill_id) REFERENCES skills(id),
  FOREIGN KEY (test_case_id) REFERENCES test_cases(id)
);
```

设计原则：

- 定义、模拟、测试、运行分开
- 复杂内容优先存 JSON
- `Run` 作为调试和测试之间的桥梁

## 8. Minimal API Design

### 8.1 Skills

创建：

```http
POST /api/skills
```

列表：

```http
GET /api/skills
```

详情：

```http
GET /api/skills/:skillId
```

更新：

```http
PATCH /api/skills/:skillId
```

### 8.2 Mock Tools

创建：

```http
POST /api/mock-tools
```

列表：

```http
GET /api/mock-tools
```

详情：

```http
GET /api/mock-tools/:toolId
```

更新：

```http
PATCH /api/mock-tools/:toolId
```

新增 fixture：

```http
POST /api/mock-tools/:toolId/fixtures
```

查询 fixtures：

```http
GET /api/mock-tools/:toolId/fixtures
```

删除 fixture：

```http
DELETE /api/mock-tools/:toolId/fixtures/:fixtureId
```

### 8.3 Runs

运行一次 simulation：

```http
POST /api/skills/:skillId/runs
```

查询单次 run：

```http
GET /api/runs/:runId
```

查询某个 skill 的 runs：

```http
GET /api/skills/:skillId/runs
```

建议支持的筛选：

- `status`
- `created_at`
- `source`

### 8.4 Test Cases

从一次 run 保存成测试：

```http
POST /api/runs/:runId/save-as-test
```

直接创建：

```http
POST /api/skills/:skillId/test-cases
```

列表：

```http
GET /api/skills/:skillId/test-cases
```

详情：

```http
GET /api/test-cases/:testCaseId
```

更新：

```http
PATCH /api/test-cases/:testCaseId
```

删除：

```http
DELETE /api/test-cases/:testCaseId
```

### 8.5 Batch Eval

批量重跑：

```http
POST /api/skills/:skillId/evals
```

查询状态：

```http
GET /api/evals/:evalId
```

设计原则：

- 所有运行都是 `simulation`
- `eval` 只是聚合一组 `run`
- 不额外设计另一套复杂执行模型

## 9. Runtime Flow

一次 `POST /api/skills/:skillId/runs` 背后建议执行：

1. 读取 skill 定义
2. 校验输入 schema
3. 解析知识源
4. 注册允许使用的 mock tools
5. 调模型执行
6. 拦截工具调用并返回 mock response
7. 校验输出 schema
8. 运行断言
9. 保存 run trace
10. 返回结果

这条链已经足够支撑首版。

当前阶段不建议引入：

- 通用 runtime DSL
- 事件总线
- 插件式 agent framework
- 复杂工具协议层

## 10. UI Information Architecture

首版建议只有 3 个主页面。

### 10.1 Skills

用于管理 skill 列表。

展示：

- 名称
- 描述
- 版本
- 最近更新时间
- 最近运行状态
- `New Skill`

### 10.2 Skill Detail

这是核心工作台页面。

建议包含 3 个区域：

- `Editor`
- `Run`
- `Trace`

`Editor`：

- 名称
- 描述
- 输入 schema
- 系统指令
- 知识源
- 允许工具
- 输出 schema
- 模型参数

`Run`：

- 输入表单
- `Run Simulation`
- 输出结果
- token / latency / cost
- `Save as Test Case`

`Trace`：

- 使用了哪些 knowledge
- 调用了哪些 mock tools
- 每个 tool 的入参与返回
- 最终 prompt
- 错误信息

### 10.3 Tests

用于集中看测试样本和回归结果。

展示：

- 测试样本列表
- 标签筛选
- `Run All`
- 最近结果
- 通过 / 失败统计

测试详情页重点展示：

- 输入
- 断言
- 输出
- 哪条断言失败

### 10.4 Optional Top-Level Nav

建议只保留：

- `Skills`
- `Tests`
- `Mock Tools`

## 11. Recommended Build Order

建议按下面顺序做：

1. skill 定义存储
2. 单次 simulation run
3. run trace 存储与展示
4. 从 run 保存 test case
5. 批量重跑 tests
6. 最后再做版本比较

这个顺序的优点是每一步都能单独产生产品价值。

## 12. Decision Summary

如果当前目标是验证 `Skill Studio` 方向，而不是立即做执行平台，那么最合理的边界是：

- 模型可以真实运行
- 工具一律 mock
- 首版聚焦设计、调试、测试
- 不做 live tool
- 不做生产自动执行

这个边界不是妥协，而是收敛。

它会让产品更轻、更清楚，也更容易做出第一版真正可用的工作台。
