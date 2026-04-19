# Launch Checklist

## 1. Why This Exists

`Knowledge Studio` 现在已经不只是一个可跑 demo，而是一套准备对外发布的知识 SaaS 原型。

这份清单的目标很简单：

- 确认公开面、工作台、线索、交付链是连着的
- 确认默认 demo 租户足够像真实客户实例
- 确认发出去时，对外说法、演示路径、数据基线是一致的

## 2. Release Gates

一次可以对外演示或发布的版本，至少要满足下面四个门槛：

1. `产品叙事一致`
   首页、品牌页、验证页、登录页、README 说的是同一件事。
2. `主链路可走通`
   从内容维护到发布、从公开知识面到申请接入、从赢单到交付准备都能跑通。
3. `默认租户可信`
   `acme-research` 不能像占位站点，必须像真实知识运营团队。
4. `数据库基线稳定`
   migration、seed、smoke 都必须通过。

## 3. Product Surface Checklist

### 3.1 Homepage

- 首页标题明确是“知识运营、发布与交付平台”
- 首页能说明适合谁，不再像框架首页
- 首页 CTA 能把人分别带到公开知识面、产品入口、工作台

### 3.2 Public Knowledge Surface

- 品牌页能在 5 到 10 秒内讲清这是什么服务
- 方案区和订阅表单属于同一转化路径
- 内容证明区能看出这不是占位卡片
- `#subscribe-intake` 能承接方案卡回流

### 3.3 Validation Surface

- 验证页能立即提问，不是另一个介绍页
- 回答、引用、下一步动作是页面主线
- 带 `plan` 进入时，能顺畅回到接入申请入口

### 3.4 Product Access

- 登录页强调这是内部工作流入口
- 预置账号说明不抢主标题
- 首次登录、改密、进入工作台的动线清楚

## 4. Workspace Operations Checklist

### 4.1 Knowledge Operations

- 文档和 FAQ 的职责边界清楚
- 编辑后能进入发布链，而不是停在内容页
- 覆盖问题、来源材料、标准答案三者关系清楚

### 4.2 Release Management

- 发布页能表达“上线关口”而不是普通列表
- 最近发布、当前草稿、公开承接之间关系清楚
- owner 能从发布页跳到公开知识面和验证页验收
- 候选载荷不是机械默认全选，而是明确区分“本轮推荐”和“最终确认”
- gap signals 能自然进入 release notes，不需要 owner 手动抄写发布理由

### 4.3 CRM And Intake

- 线索页支持筛选、排序、阶段、负责人、下次跟进
- 线索详情能追加 followup
- 状态变更和阶段变更都能留下说明

### 4.4 Onboarding Handoff

- `won` 线索能推送 provisioning job
- checklist 会自动生成
- 完成 checklist 能产出真实资产：owner 邀请、starter 文档、starter FAQ、draft release

## 5. Demo Tenant Checklist

默认 `acme-research` 至少要满足：

- 品牌名、tagline、方案与知识内容属于同一个业务场景
- 文档和 FAQ 不是 lorem ipsum，而是专业团队会真的用到的内容
- 公开知识面能体现 `coverage_focus`
- 默认计划是前台真正支持的计划值

## 6. Verification Commands

发布前至少跑下面三条：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
php -d extension=../vslim/vslim.so bin/vslim db:migrate
php -d extension=../vslim/vslim.so bin/vslim studio:seed-demo
php -d extension=../vslim/vslim.so tests/console_db_write_smoke.php
```

通过标准：

- migration 不报错
- seed 不报错
- smoke 至少覆盖文档、FAQ、job、线索、交付链关键写入

## 7. Final Pre-Launch Pass

对外发之前，再做最后一轮人工检查：

1. 用 `owner@acme.test` 走一遍“登录 -> 工作台 -> 发布 -> 公开知识面 -> 验证页”
2. 用外部访客视角走一遍“首页 -> 品牌页 -> 方案 -> 验证 -> 接入申请”
3. 打开 README，确认仓库入口文案和产品入口文案一致
4. 再扫一遍是否残留明显的 demo/validation 迁移前旧命名

## 8. Done Means

满足这份清单时，我们可以把它看成：

- 一个可对外演示的 VSlim flagship app
- 一个有真实主线的知识 SaaS 原型
- 一个可以继续向商用版本推进的发布基线
