---
kind: dependency_management
name: V 模块与 VPM 依赖管理
category: dependency_management
scope:
    - '**'
source_files:
    - vphp/v.mod
---

本仓库采用 V 语言原生的 `v.mod` 模块声明机制进行依赖管理，未使用 Go、Node.js 等外部包管理器。

**系统/工具**
- 通过根目录 `vphp/v.mod` 声明模块名 `vphp`、版本 `0.0.1`，作为 VPM 可发现的基本单元。
- 模块内部子目录（如 `object/`、`zend/`、`zval/`、`execute/`、`scope/`）通过 `import vphp.object`、`import vphp.zend` 等形式以“子模块”方式被引用，属于同一 VPM 模块内的组织划分，而非独立第三方依赖。
- 仓库中未发现 `go.mod`、`package.json`、`vendor/`、`GOPRIVATE`、私有注册表配置等任何跨语言或外部包管理痕迹。

**关键文件**
- `vphp/v.mod`：唯一模块清单，定义模块名与版本。
- `vphp/compiler/v_glue.v`、`vphp/compiler/v_glue_modules.v`：编译器在生成胶水代码时硬编码写入 `import vphp` / `import vphp.object`，表明运行时产物直接依赖该模块的命名空间。
- 大量 `.v` 源文件中的 `import vphp.*` 语句构成模块内依赖图。

**架构与约定**
- 所有依赖均为本地源码，不存在远程拉取；升级依赖即编辑 `v.mod` 版本号并同步更新导入路径。
- 子模块按职责分层（`zend` 底层桥接、`zval` 值类型、`object` 对象生命周期、`execute` 执行上下文），通过 `vphp.<sub>` 前缀访问，形成稳定的内部 API 边界。
- 未见 lockfile 或 vendoring 策略，依赖一致性完全由 Git 提交锁定。

**开发者应遵循的规则**
- 新增对外暴露能力应在 `vmod` 中提升版本号，并在 `compiler/*` 生成的胶水代码中保持 `import vphp.*` 命名一致。
- 模块内拆分新子目录后，需确保其顶层包含对应 `module vphp.<name>` 声明，以便被 `import vphp.<name>` 引用。
- 不引入外部包管理器；若未来需要第三方库，应评估是否以 V 原生模块形式提供并通过 `v.mod` 声明。