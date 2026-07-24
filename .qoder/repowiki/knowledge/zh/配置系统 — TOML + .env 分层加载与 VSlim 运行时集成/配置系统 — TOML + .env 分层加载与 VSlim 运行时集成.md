---
kind: configuration_system
name: 配置系统 — TOML + .env 分层加载与 VSlim 运行时集成
category: configuration_system
scope:
    - '**'
source_files:
    - knowledge-studio/config/app.toml
    - knowledge-studio/config/database.toml
    - knowledge-studio/vhttpd.toml
    - knowledge-studio/bootstrap/app.php
    - knowledge-studio/app/Support/StudioDatabase.php
    - knowledge-studio/composer.json
---

本仓库在 VPHP 核心库（`vphp/`）中未实现应用级配置系统；配置能力集中在上层示例应用 `knowledge-studio/`，采用 **TOML 配置文件 + `.env` 环境变量** 的分层加载方案，由 VSlim 运行时提供的 `VSlim\EnvLoader` 和 `VSlim\Database\Config` 等组件驱动。

## 1. 使用的框架与工具
- **TOML 解析**：应用通过 `config/*.toml` 声明式配置，键值支持 `${env.VAR:-default}` 语法，表示从环境变量注入或回退默认值。
- **环境变量加载器**：`bootstrap/app.php` 首行调用 `\VSlim\EnvLoader::bootstrap(dirname(__DIR__))`，负责读取根目录下的 `.env` 文件并注入到进程环境。
- **数据库配置对象**：`app/Support/StudioDatabase.php` 使用 `VSlim\Database\Config` 构造数据库连接配置，再交给 `Manager` 管理。
- **HTTP 服务器配置**：`vhttpd.toml` 描述 vhttpd 工作进程、站点、资产、管理员面板等运行期参数。

## 2. 关键文件与包
- `knowledge-studio/config/app.toml` — 应用名、trace、UI、存储后端等
- `knowledge-studio/config/database.toml` — 传输方式、MySQL 连接池、上游 socket
- `knowledge-studio/vhttpd.toml` — vhttpd 进程模型、worker 池、PHP 扩展路径
- `knowledge-studio/bootstrap/app.php` — 启动时加载 `.env`、注册配置路径
- `knowledge-studio/app/Support/StudioDatabase.php` — 基于 `VSlim\Database\Config` 构建 DB 连接
- `knowledge-studio/.env.example` / `.env` — 环境变量模板与实际值
- `knowledge-studio/composer.json` — 依赖 `vphp/runtime`（dev-main），通过 path repository 指向 `../../vhttpd/php/package`

## 3. 架构与约定
- **分层优先级**：`.env` → `*.toml` 中的 `${env.*}` 占位符 → TOML 字面量默认值。
- **按域拆分 TOML**：`app`、`database`、`http`、`logging`、`session`、`stream`、`cache` 各自独立文件，便于组合与覆盖。
- **运行时与部署分离**：`vhttpd.toml` 仅描述进程/worker/站点拓扑，不混入业务配置；业务配置留在 `config/`。
- **类型化占位符**：`${env.int.VAR:-0}`、`${env.bool.VAR:-false}` 等前缀用于强制类型转换。
- **引导入口统一**：所有 PHP 入口先执行 `EnvLoader::bootstrap()`，确保后续代码可安全读取环境变量。

## 4. 开发者应遵循的规则
- 新增配置项优先放入对应 `config/*.toml`，并通过 `${env.XXX:-默认值}` 引用环境变量，避免硬编码。
- 敏感信息（密码、token）只写入 `.env`，不要提交到版本库；提供 `.env.example` 作为模板。
- 若需新增配置域，新建 `config/<domain>.toml`，并在需要处通过 `VSlim\Database\Config` 或自定义 Config 类读取。
- 不要在 VPHP 核心库（`vphp/`）中引入应用级配置逻辑；该层仅暴露底层 Zend 绑定与导出管道。
- 修改 `vhttpd.toml` 后需重启 vhttpd 进程以生效，因其由 C 侧 HTTP 服务器直接解析。

## 5. 置信度说明
本仓库的“配置系统”并非 VPHP 核心库的一部分，而是上层 `knowledge-studio` 应用基于 VSlim 运行时实现的实践。由于未在 `vphp/` 中发现通用配置框架代码，且示例应用已完整展示 TOML + .env 模式，故对“应用层配置系统”这一范畴给出高置信度总结。