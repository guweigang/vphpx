---
kind: logging_system
name: 调试日志系统 — 基于环境变量开关的框架级 debug 输出
category: logging_system
scope:
    - '**'
source_files:
    - vphp/hooks.v
---

本仓库未引入第三方日志框架，也未建立统一的日志级别与结构化字段体系。运行时仅实现了一个极简的“框架级调试日志”子系统，由 `vphp/hooks.v` 中的 `framework_debug_log` 提供，并通过两个环境变量控制：
- `VSLIM_CLI_DEBUG`：非空即启用；
- `VSLIM_CLI_DEBUG_FILE`：指定文件路径时写入该文件，否则回退到标准错误输出（`eprintln`）。

调用约定为在关键生命周期钩子（如 `vphp_framework_shutdown`、`vphp_framework_request_startup/shutdown`）以及核心路径（`dyn_value_zval.new_zval`、`zval.call_owned_request`）中插入 `framework_debug_log(...)` 调用，输出形如 `[vphp-framework-debug] ...` 的前缀行，便于在 PHP-FPM/CLI 环境中快速定位问题。

除上述调试日志外，编译器侧（`compiler/entry.v`、`compiler/export.v`、`compiler/parser/class_parser.v`）直接使用 V 标准库的 `println` / `eprintln` 打印构建进度与提示，这些属于编译期诊断输出，不属于运行时日志范畴。

当前不存在以下能力：多级别日志（info/warn/error）、结构化字段（JSON/键值对）、可插拔 sink（文件/网络/集中式收集器）、按模块或组件划分日志通道、性能开销可控的开关机制等。