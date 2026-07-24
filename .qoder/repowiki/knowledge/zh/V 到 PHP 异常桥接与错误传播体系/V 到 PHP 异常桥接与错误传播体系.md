---
kind: error_handling
name: V 到 PHP 异常桥接与错误传播体系
category: error_handling
scope:
    - '**'
source_files:
    - vphp/php_exception.v
    - vphp/zend/bridge_api.v
    - vphp/v_bridge.c
    - vphp/v_bridge.h
    - vphp/lifecycle_scope.v
    - vphp/dyn_value.v
---

本仓库为 V 语言提供面向 Zend Engine 的运行时桥接，其错误处理围绕「将 V 侧错误映射为 PHP 异常」这一核心目标构建，形成从 C 层、Zend 桥接层到 V 应用层的三层架构。

## 1. 使用的系统与方法
- PHP 异常作为统一出口：所有跨边界错误最终通过 zend.throw_exception / zend.throw_exception_class / zend.throw_exception_object_ptr 抛出 PHP 异常，由 PHP 引擎捕获并沿调用栈向上冒泡。
- V error → PHP exception 映射：通过 InteropErrorClass 枚举对错误进行稳定分类（worker_runtime_error、app_contract_error、invalid_argument、type_mismatch、conversion_error、include_error、symbol_not_found），再经 PhpException.raise_from_error / throw_from_error 包装成带前缀的 PHP 异常消息。
- C 层直接暴露 throw/report API：v_bridge.c/.h 实现 vphp_throw、vphp_error、vphp_has_exception、vphp_exception_message、vphp_clear_exception 等函数，供 V 层以 C. 前缀直接调用。
- panic/recover 仅用于内部不变量校验：在生命周期作用域、标量转换等内部路径使用 panic(...) 表达「绝不应发生」的状态，不用于业务错误流。

## 2. 关键文件与包
- vphp/php_exception.v — 统一的异常/错误入口：PhpException 结构体、InteropErrorClass 枚举、throw_* / report_error 等顶层 API。
- vphp/zend/bridge_api.v — 声明 C.vphp_throw、C.vphp_error、C.vphp_has_exception 等底层 C 桥接函数。
- vphp/zend/value.v、vphp/zval/*.v — 在 zval 读写失败时通过 PhpException.report(e_warning|e_error, ...) 报告 PHP 警告/错误。
- vphp/lifecycle_scope.v、vphp/dyn_value.v、vphp/persistent_zbox_factory.v — 内部不变量检查处使用 panic(...)
- vphp/v_bridge.c、vphp/v_bridge.h — C 端实现异常抛出、错误上报、异常状态查询。

## 3. 架构与约定
V 应用层 -> PhpException.raise / throw_interop_error / report_error -> Zend 桥接层 (zend/bridge_api.v) -> C.vphp_throw / C.vphp_error / C.vphp_has_exception -> C 运行时 (v_bridge.c) -> zend_throw_exception / zend_error -> PHP 引擎
- 分层依赖规则：zend/ 是最低层，只依赖 C；php_exception.v 位于中间层，既导入 zend 又暴露给上层；上层模块不得直接调用 C.vphp_*。
- 错误分类优先于字符串拼接：新错误类型应先在 InteropErrorClass 中注册，再通过 throw_interop_error(class, msg, code) 抛出，保证客户端可按前缀过滤。
- V error 接口契约：throw_from_error 期望传入实现 IError 接口的值（具备 msg() 方法），以便保留原始错误信息并附加分类前缀。该接口定义不在当前扫描范围内，但使用点明确表明其存在。
- 异常状态可探测：通过 has_exception() / current_exception_message() / clear_exception() 可在 C 回调或守卫逻辑中检测并消费已抛出的 PHP 异常。

## 4. 开发者应遵循的规则
1. 禁止在跨边界函数中使用 panic：仅在内部不变量断言处使用 panic；对外暴露的函数应返回 ?T 或直接抛出 PHP 异常。
2. 统一使用 InteropErrorClass 分类：新增错误场景先扩展枚举，再用 throw_interop_error 或 throw_from_error 抛出，不要直接拼接任意字符串。
3. 通过 PhpException.* 或顶层 throw_* / report_error 操作异常：不要直接调用 C.vphp_throw，除非你在编写新的桥接层。
4. 在 C 回调入口处检查 has_exception()：若 PHP 侧已抛出异常，应在进入 V 代码前清理并返回，避免双重异常。
5. V error 值必须实现 IError 才能被 throw_from_error 接受：自定义错误类型需暴露 msg() string 方法。