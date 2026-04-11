# Knowledge Studio

`Knowledge Studio` 是一个面向团队运营的多租户 AI 知识品牌平台 sample，目标是用一个足够真实、可继续实现的产品原型，集中展示 `VSlim` 在以下方向上的能力：

- 多租户 workspace 隔离
- 多位知识工作者协作维护知识
- 对外统一品牌形象与公开助手
- 订阅用户访问与付费能力预留
- 流式问答、实时任务状态、工具调用
- `HTTP + View + Session/Auth + Validation + Database + CLI + Stream + WebSocket/LiveView`

它不是“聊天框 demo”，而是一个可以继续演进成 SaaS 原型的工作台产品。

## 项目定位

- 产品类型：多租户 AI 知识品牌平台
- 主要用户：租户管理员、知识编辑者、外部订阅用户、平台管理员
- 核心价值：团队协作维护知识，对外统一品牌服务，订阅用户按套餐消费 AI 知识服务

## 文档入口

- 产品文档：[docs/product.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/product.md)
- 架构草案：[docs/architecture.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/architecture.md)
- 开发计划：[docs/plan.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/plan.md)

## 当前状态

项目已经落下第一阶段 foundation skeleton，当前可用能力包括：

- `VSlim` HTTP / CLI 入口
- demo 登录与 session
- workspace 级别上下文解析
- tenant console 骨架页
- 品牌化公开页与 assistant 壳页
- 初版 migration / seeder 占位

当前 demo 账号：

- `owner@acme.test`
- `editor@acme.test`
- `owner@nova.test`

统一密码：

- `demo123`

## 本地启动

最短路径：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
make serve EXT=../vslim/vslim.so
```

然后打开：

- `http://127.0.0.1:8094/`
- `http://127.0.0.1:8094/login`
- `http://127.0.0.1:8094/brand/acme-research`

## `.env` 配置

项目现在会自动读取根目录下的 `.env`。

文件：

- [`.env.example`](/Users/guweigang/Source/vphpx/knowledge-studio/.env.example)
- [`.env`](/Users/guweigang/Source/vphpx/knowledge-studio/.env)

常见用法：

1. 先把数据库信息填进 [`.env`](/Users/guweigang/Source/vphpx/knowledge-studio/.env)
2. 初期保持 `STUDIO_DATA_SOURCE=demo`
3. 等你准备好数据库后，执行 migration 和 seed
4. 然后把 `STUDIO_DATA_SOURCE` 改成 `db`

示例：

```dotenv
STUDIO_DATA_SOURCE=db
VSLIM_DB_HOST=127.0.0.1
VSLIM_DB_PORT=3306
VSLIM_DB_USER=root
VSLIM_DB_PASSWORD=secret
VSLIM_DB_NAME=knowledge_studio
```

CLI 自检：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
make cli EXT=../vslim/vslim.so
php -d extension=../vslim/vslim.so bin/vslim workspace:catalog
```

数据库初始化预留路径：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
php -d extension=../vslim/vslim.so bin/vslim db:migrate
php -d extension=../vslim/vslim.so bin/vslim studio:seed-demo
```

切到数据库读路径：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
make serve EXT=../vslim/vslim.so
```

默认 `.env` 仍然是 `demo` 数据源，所以即使本地还没接数据库，sample 也能直接跑起来。

## 当前范围

第一阶段先做能跑通业务闭环的 MVP：

- workspace 多租户
- 知识工作者后台
- 品牌化公开助手页
- 流式问答
- 文档与 FAQ 管理
- 基础发布机制
- 订阅访问门槛
- 审计日志与后台任务

暂不在第一阶段实现：

- 复杂计费结算
- 多模型编排
- 高级工作流审批
- 全量插件市场
- 复杂富文本协同编辑

## 目录约定

- `docs/`
  产品与实施文档
- `app/`
  预留给后续 `VSlim` app 实现
- `config/`
  预留给后续运行配置
- `database/`
  预留给 migration / seed
- `resources/`
  预留给 views / assets

当前仓库先落文档和计划，后续按计划逐步填充实现。
