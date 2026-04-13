# Knowledge Studio

`Knowledge Studio` 是一个面向团队运营的多租户 AI 知识品牌工作台，目标不是做一个“聊天框 sample”，而是沉淀一套能继续演进成开源项目和 SaaS 原型的完整代码基线。

它用一个足够真实的业务壳，把 `VSlim` 的核心能力串成完整故事：

- 多租户 workspace 隔离
- 多位知识工作者协作维护知识
- 对外统一品牌页与公开助手
- 订阅用户访问与付费能力预留
- `HTTP + View + Session/Auth + Validation + Database + CLI + Stream + WebSocket/LiveView`

## 为什么做这个项目

这不是“再做一个 AI 助手首页”，而是为了回答三个更有价值的问题：

- `VSlim` 能不能承载一个结构清楚、体验完整的业务产品
- 多租户知识协作、公开品牌、订阅式助手能不能放在同一个代码库里自然生长
- 这套代码能不能既当示例，也具备继续开源和 SaaS 化的工程基础

当前的答案已经开始成形：项目里已经同时具备真实数据库读写、public assistant 预览、双语页面能力、Pest 测试骨架，以及相对清晰的 service/presenter/controller/support 分层。

## 产品定位

`Knowledge Studio` 不是泛化的“AI 助手 demo”，而是一个聚焦场景的 SaaS 原型：

`面向专业团队的多租户 AI 知识运营 SaaS`

核心价值不是“再做一个聊天框”，而是把团队协作维护的知识，运营成：

- 统一品牌的公开页
- 可验证的知识助手
- 可承接订阅意向的外部服务入口

最适合的团队：

- 咨询 / 研究 / 顾问团队
- 金融运营 / 清算 / 风控支持团队
- 企业共享服务团队
- 垂直行业知识内容团队

核心闭环：

1. 团队协作维护知识
2. 发布版本
3. 对外通过品牌页和助手页提供服务
4. 根据真实提问继续补知识

## 已有能力

- 租户工作台、对外品牌页、公开助手页已经成形
- 文档、知识条目、任务具备真实数据库读写路径
- public assistant 已经能基于真实知识语料生成答案预览与 citations
- 页面默认中文，并支持 `?lang=zh-CN` / `?lang=en`
- locale 解析、语言保持链接、assistant diagnostics 已抽成可测试 userland 结构

## 演示入口

当前 demo 账号：

- `owner@acme.test`
- `editor@acme.test`
- `owner@nova.test`

统一密码：

- `demo123`

本地启动：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
make serve EXT=../vslim/vslim.so
```

常用入口：

- `http://127.0.0.1:8094/`
- `http://127.0.0.1:8094/login`
- `http://127.0.0.1:8094/console`
- `http://127.0.0.1:8094/brand/acme-research`
- `http://127.0.0.1:8094/brand/acme-research/assistant?q=发布`

## 配置与数据源

项目会自动读取根目录下的 `.env`：

- [`.env.example`](/Users/guweigang/Source/vphpx/knowledge-studio/.env.example)
- [`.env`](/Users/guweigang/Source/vphpx/knowledge-studio/.env)

常见切换方式：

1. 先把数据库配置写进 [`.env`](/Users/guweigang/Source/vphpx/knowledge-studio/.env)
2. 初期保持 `STUDIO_DATA_SOURCE=demo`
3. 数据库准备好后执行 migration / seed
4. 再切到 `STUDIO_DATA_SOURCE=db`

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

数据库初始化：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
php -d extension=../vslim/vslim.so bin/vslim db:migrate
php -d extension=../vslim/vslim.so bin/vslim studio:seed-demo
```

## 架构一览

当前代码已经按“可公开分享、可继续演进”的方向开始分层：

- `app/Services`
  负责业务计算与数据编排，例如知识检索、答案预览、workspace 数据聚合
- `app/Presenters`
  负责把 service 输出整理成页面或 API 更稳定的展示输入
- `app/Http/Controllers`
  只做请求编排，不承载复杂业务计算
- `app/Support`
  放 locale / url / 纯 helper 等基础能力，优先保持可单测
- `resources/views`
  只负责渲染，不承载复杂判断

几个关键支点：

- [AssistantAnswerService.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Services/AssistantAnswerService.php)
  负责检索、排序、答案预览和 diagnostics
- [AssistantAnswerPresenter.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Presenters/AssistantAnswerPresenter.php)
  负责 citation 和 diagnostics 的展示整形
- [LocaleCatalog.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Support/LocaleCatalog.php)
  负责 locale 规范化、文案目录和语言切换元数据
- [LocalePreferenceResolver.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Support/LocalePreferenceResolver.php)
  负责从 query / raw query / header 决定最终 locale
- [LocalizedUrlBuilder.php](/Users/guweigang/Source/vphpx/knowledge-studio/app/Support/LocalizedUrlBuilder.php)
  负责 controller 中常见页面链接的 locale 保持

## 测试边界

这个项目已经明确按两层测试边界推进：

- PHP userland：使用 `Pest`
- 扩展 / bridge / VSlim 底层：使用 `PHPT`

当前 userland 测试骨架：

- [phpunit.xml](/Users/guweigang/Source/vphpx/knowledge-studio/phpunit.xml)
- [tests/Pest.php](/Users/guweigang/Source/vphpx/knowledge-studio/tests/Pest.php)
- [tests/Feature](/Users/guweigang/Source/vphpx/knowledge-studio/tests/Feature)
- [tests/Unit](/Users/guweigang/Source/vphpx/knowledge-studio/tests/Unit)

命令入口：

```bash
cd /Users/guweigang/Source/vphpx/knowledge-studio
make test-assistant
make test-unit
make test-feature
```

注意：

- 当前仓库结构已经切到 `Pest`
- 如果本地还没有 `vendor/bin/pest`，先安装 composer dev 依赖
- 底层扩展与 bridge 问题不要混进 userland 测试，应继续用 `PHPT`

## 文档入口

- 产品文档：[docs/product.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/product.md)
- 信息架构：[docs/information-architecture.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/information-architecture.md)
- 产品走查：[docs/product-walkthrough-checklist.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/product-walkthrough-checklist.md)
- 走查发现：[docs/walkthrough-findings.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/walkthrough-findings.md)
- 架构草案：[docs/architecture.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/architecture.md)
- 开发计划：[docs/plan.md](/Users/guweigang/Source/vphpx/knowledge-studio/docs/plan.md)

## 路线图

接下来只沿一条主线继续推进：

- 把供给侧工作流做深：内容维护、发布、反馈回流
- 把公开品牌页和助手页做成可信的对外产品面
- 把订阅和套餐保留在“可承接、可演进”的轻量层
- 补齐 Pest 与 PHPT 回归，稳住这套产品原型

## 目录约定

- `docs/`
  产品与实施文档
- `app/`
  应用代码
- `config/`
  运行配置
- `database/`
  migration / seed
- `resources/`
  views / assets
- `tests/`
  Pest userland 测试
