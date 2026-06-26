# PHP → V AOT 转译器 (php2v) 实施计划

## 背景

构建一套 **Source-to-Source 转译器**，实现 `PHP 源码 → AST JSON → V 源码 → 二进制` 的 AOT 编译链路。

核心原则：**借力打力，重在转换**。依赖 Zend 内核的 C 运算函数（`add_function`、`concat_function` 等）保证 PHP 语义 100% 保真，但不需要启动完整的 PHP 运行时。

## 现有基础设施盘点

> [!NOTE]
> 经过对 `vphpx` 代码库的深度分析，以下 API 已经就绪，可直接用于转译：

| 能力 | 已有 API | 文件 |
|------|---------|------|
| 标量创建 | `ZVal.new_int()`, `ZVal.new_float()`, `ZVal.new_bool()`, `ZVal.new_string()`, `ZVal.new_null()` | [zval_factory_iter.v](file:///Users/guweigang/Source/vphpx/vphp/zval_factory_iter.v) |
| 标量读取 | `ZVal.to_int()`, `ZVal.to_f64()`, `ZVal.to_bool()`, `ZVal.to_string()`, `ZVal.get_string()` | [zval_scalar.v](file:///Users/guweigang/Source/vphpx/vphp/zval_scalar.v) |
| 标量写入 | `ZVal.set_null()`, `ZVal.set_bool()`, `ZVal.set_int()`, `ZVal.set_double()`, `ZVal.set_string()` | [zval_scalar.v](file:///Users/guweigang/Source/vphpx/vphp/zval_scalar.v) |
| 类型判断 | `ZVal.is_long()`, `ZVal.is_double()`, `ZVal.is_string()`, `ZVal.is_bool()`, `ZVal.is_null()`, `ZVal.is_array()` | [zval_type.v](file:///Users/guweigang/Source/vphpx/vphp/zval_type.v) |
| 类型转换 | `ZVal.from_v[T]()`, `new_zval_from[T]()`, `ZVal.from[T]()` | [zval_conversion.v](file:///Users/guweigang/Source/vphpx/vphp/zval_conversion.v) |
| 输出 | `PhpOutput.write()`, `PhpOutput.line()` | [php_output.v](file:///Users/guweigang/Source/vphpx/vphp/php_output.v) |
| PHP 函数调用 | `php_fn(name).call(args)`, `PhpFunction.named(name).invoke(args)` | [php_function.v](file:///Users/guweigang/Source/vphpx/vphp/php_function.v), [php_function_type.v](file:///Users/guweigang/Source/vphpx/vphp/php_function_type.v) |
| PHP 常量 | `php_const(name)`, `global_const_exists(name)` | [php_const.v](file:///Users/guweigang/Source/vphpx/vphp/php_const.v) |
| 数组操作 | `ZVal.array_init()`, `push_string()`, `push_long()`, `add_assoc_*()`, `array_get_index()`, `array_get_key()`, `foreach()` | [zval_array.v](file:///Users/guweigang/Source/vphpx/vphp/zval_array.v) |
| 方法调用 | `ZVal.method(name, args)`, `call_method_zval()` | [zval_call_interop.v](file:///Users/guweigang/Source/vphpx/vphp/zval_call_interop.v) |
| 对象创建 | `zend.new_instance_named()` | [zend/call.v](file:///Users/guweigang/Source/vphpx/vphp/zend/call.v) |
| 字符串化 | `ZVal.stringify()`, `ZVal.to_string()` | [zval_stringify.v](file:///Users/guweigang/Source/vphpx/vphp/zval_stringify.v) |
| V 侧动态值 | `DynValue` 完整的标量/列表/映射/运行时引用 | [dyn_value.v](file:///Users/guweigang/Source/vphpx/vphp/dyn_value.v) |
| V 标量聚合 | `VScalarValue` (`bool | f64 | i64 | string`) | [v_scalar_value.v](file:///Users/guweigang/Source/vphpx/vphp/v_scalar_value.v) |

---

## 已确认的架构决策

> [!NOTE]
> ### 运行模式：独立二进制，链接 Zend C 运算函数
>
> 转译后的 V 代码编译为**独立二进制**，直接链接 Zend 内核的 C 运算函数库（`add_function`、`concat_function` 等）。
> 这些函数本质上就是普通的 C 函数，只需链接 `libphp`，**不需要 `php_embed_init()` 初始化完整 PHP 运行时**。
>
> `php_embed_init()` **仅**在未来的逃生舱阶段使用（当遇到 `eval()`、动态函数调度等需要完整 PHP 执行器的场景时）。

> [!NOTE]
> ### 运行时分层
>
> ```
> 转译后的 V 代码
>   ├── 算术/比较/拼接 → Zend C 运算函数（链接 libphp，零初始化成本）
>   ├── echo/print     → 直接 write stdout（纯 V）
>   ├── 控制流         → 原生 V 的 if/for/while（纯 V）
>   └── eval/动态特性  → 仅此时才 php_embed_init()（逃生舱，v1.0+）
> ```

---

## 提议的架构

```
vphpx/
├── vphp/                    # [已有] Zend 绑定 & 底层基础设施
├── php2v/                   # [新建] 转译器核心
│   ├── ast/                 # AST JSON 反序列化 & 节点类型定义
│   │   ├── node.v           # AST 节点类型 (AstNode 统一结构)
│   │   ├── parser.v         # JSON AST 解析器 (调用 V 的 json 模块)
│   │   └── types.v          # nodeType 枚举映射
│   ├── rt/                  # 转译器运行时薄层
│   │   ├── value.v          # PhpVal: 包装 ZVal 的转译器运行时值
│   │   ├── ops.v            # 二元运算: add, sub, mul, div, mod, concat, 比较
│   │   ├── control.v        # 真值判断 is_true(), 类型转换
│   │   ├── output.v         # echo, print 包装
│   │   └── functions.v      # PHP 内置函数调用桥接
│   ├── emitter/             # V 源码生成器
│   │   ├── transpiler.v     # 核心 Visitor: AST → V 源码字符串
│   │   ├── scope.v          # 变量作用域跟踪
│   │   └── codegen.v        # 代码模板与格式化
│   ├── cli/                 # CLI 入口
│   │   └── main.v           # 命令行工具: php2v compile input.php -o output
│   └── v.mod                # 模块配置
├── php2v_scripts/           # [新建] PHP 侧脚本
│   ├── parser.php           # 调用 nikic/php-parser 生成 JSON AST
│   └── composer.json        # nikic/php-parser 依赖
└── tests/                   # [新建] 端到端测试
    ├── fixtures/            # PHP 测试输入文件
    │   ├── 01_echo.php
    │   ├── 02_variables.php
    │   ├── 03_arithmetic.php
    │   └── 04_if_else.php
    └── expected/            # 预期的 V 输出
```

---

## 分阶段实施计划

### 阶段 0：搭建 PHP AST 前端 (Day 1)

#### [NEW] php2v_scripts/composer.json
- 声明 `nikic/php-parser` 依赖

#### [NEW] php2v_scripts/parser.php
- 接收 `.php` 文件路径参数
- 使用 `nikic/php-parser` 解析为 AST
- 输出标准 JSON（`JSON_PRETTY_PRINT`）到 stdout
- 包含 `nodeType` 字段的标准格式

---

### 阶段 1：AST 节点定义与 JSON 解析 (Day 2-3)

#### [NEW] php2v/ast/types.v
- 定义 `NodeType` 枚举，覆盖第一批节点类型：
  - `Stmt_Echo`, `Stmt_Expression`, `Stmt_If`, `Stmt_ElseIf`, `Stmt_Else`
  - `Expr_Assign`, `Expr_Variable`
  - `Expr_BinaryOp_Plus`, `Expr_BinaryOp_Minus`, `Expr_BinaryOp_Mul`, `Expr_BinaryOp_Div`, `Expr_BinaryOp_Concat`
  - `Scalar_Int`, `Scalar_Float`, `Scalar_String`
  - `Expr_ConstFetch` (true, false, null)

#### [NEW] php2v/ast/node.v
- 定义通用 `AstNode` 结构体，使用 V 的 `json` 模块反序列化
- nikic/php-parser 的 JSON 结构核心字段：`nodeType`, `stmts`, `exprs`, `var`, `expr`, `left`, `right`, `value`, `name`, `parts` 等

#### [NEW] php2v/ast/parser.v
- `parse_ast_json(json_str string) ![]AstNode` — 解析顶层语句数组
- 支持递归子节点解析

---

### 阶段 2：转译器运行时薄层 (Day 3-4)

> [!TIP]
> 这层极薄，本质上是对 `vphp.ZVal` API 的"转译器友好"封装。

#### [NEW] php2v/rt/value.v
```v
// PhpVal 是转译后代码中的统一值类型
// 底层直接使用 vphp.ZVal
pub type PhpVal = vphp.ZVal

pub fn new_string(s string) PhpVal { return vphp.ZVal.new_string(s) }
pub fn new_int(n i64) PhpVal { return vphp.ZVal.new_int(n) }
pub fn new_float(f f64) PhpVal { return vphp.ZVal.new_float(f) }
pub fn new_bool(b bool) PhpVal { return vphp.ZVal.new_bool(b) }
pub fn new_null() PhpVal { return vphp.ZVal.new_null() }
```

#### [NEW] php2v/rt/ops.v

> [!WARNING]
> **关键发现：vphpx 当前没有任何算术/比较/拼接运算操作！**
> ZVal 和 DynValue 都不提供 add/sub/mul/div/mod/concat/compare 方法。
> 运行时层需要从零构建这些操作，这是 v0.1 的**核心工作量所在**。

**实现策略：直接声明并调用 Zend C API 运算函数**

Zend Engine 提供了完整的弱类型运算函数族（定义于 `zend_operators.h`），我们可以通过 C FFI 直接调用：

```v
// 声明 Zend C API
fn C.add_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.sub_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.mul_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.div_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.mod_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.concat_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.compare_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_equal_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_identical_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_smaller_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_smaller_or_equal_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.boolean_not_function(result &C.zval, op1 &C.zval) int
fn C.bitwise_not_function(result &C.zval, op1 &C.zval) int
fn C.zendi_smart_strcmp(s1 &C.zend_string, s2 &C.zend_string) int
```

然后包装为运行时函数：
- `pub fn add(a PhpVal, b PhpVal) PhpVal`
- `pub fn sub(a PhpVal, b PhpVal) PhpVal`
- `pub fn mul(a PhpVal, b PhpVal) PhpVal`
- `pub fn div(a PhpVal, b PhpVal) PhpVal`
- `pub fn mod_(a PhpVal, b PhpVal) PhpVal`
- `pub fn concat(a PhpVal, b PhpVal) PhpVal` — 字符串拼接
- `pub fn equal(a PhpVal, b PhpVal) PhpVal` — `==`
- `pub fn identical(a PhpVal, b PhpVal) PhpVal` — `===`
- `pub fn less(a PhpVal, b PhpVal) PhpVal`
- `pub fn greater(a PhpVal, b PhpVal) PhpVal`
- `pub fn negate(a PhpVal) PhpVal` — 一元负号
- `pub fn boolean_not(a PhpVal) PhpVal` — `!`

> 这种方式 **100% 保证与 PHP 行为一致**（`"1" + 2 = 3`、`"0" == false` 等），因为直接复用了 Zend Engine 自身的运算逻辑。

#### [NEW] php2v/rt/control.v
- `pub fn is_true(v PhpVal) bool` — PHP 真值判断 (`0, "", "0", [], null, false` 都是 falsy)
- `pub fn assign(mut target PhpVal, source PhpVal)` — 赋值语义

#### [NEW] php2v/rt/output.v
- `pub fn echo_val(v PhpVal)` — 纯 V 实现：将 PhpVal 转为字符串后 `print()` 到 stdout
- `pub fn print_val(v PhpVal) PhpVal` — 同 echo 但返回 `new_int(1)`
- 不依赖 `PhpOutput`（那是 Zend 输出缓冲区，独立二进制用不到）

#### [NEW] php2v/rt/functions.v
- `pub fn call_function(name string, args []PhpVal) PhpVal`
- v0.1 阶段：对常用 PHP 内置函数（`strlen`, `strtoupper`, `var_dump` 等）用纯 V 实现
- 逃生舱阶段（v1.0+）：无法纯 V 实现的函数，通过 `php_embed_init()` + Zend 调度

---

### 阶段 3：V 源码发射器 — 核心 Visitor (Day 5-7)

#### [NEW] php2v/emitter/scope.v
- `VarScope` 结构体，跟踪已声明变量 (`map[string]bool`)
- 嵌套作用域支持（函数定义等）

#### [NEW] php2v/emitter/transpiler.v
这是整个系统的核心，基于访问者模式遍历 AST 生成 V 源码：

```v
struct Transpiler {
mut:
    out           strings.Builder
    indent        int
    scope         VarScope
}

// 第一批支持的节点转译:
fn (mut t Transpiler) visit_stmt(node AstNode)          // 语句分发
fn (mut t Transpiler) visit_expr(node AstNode) string    // 表达式求值（返回 V 表达式字符串）
fn (mut t Transpiler) visit_echo(node AstNode)           // echo → rt.echo_val(...)
fn (mut t Transpiler) visit_assign(node AstNode)         // $var = expr → mut var_xxx := ...
fn (mut t Transpiler) visit_binary_op(node AstNode) string  // + - * / . → rt.add/concat(...)
fn (mut t Transpiler) visit_scalar_int(node AstNode) string  // 42 → rt.new_int(42)
fn (mut t Transpiler) visit_scalar_string(node AstNode) string // "hello" → rt.new_string('hello')
fn (mut t Transpiler) visit_variable(node AstNode) string     // $a → var_a
fn (mut t Transpiler) visit_if(node AstNode)              // if → if rt.is_true(...)
fn (mut t Transpiler) visit_const_fetch(node AstNode) string  // true/false/null
```

#### [NEW] php2v/emitter/codegen.v
- V 代码模板：生成 `import php2v.rt` 头部
- `fn wrap_as_main(body string) string` — 包装为可执行 V 程序
- `fn wrap_as_php_function(body string, name string) string` — 包装为 `@[php_function]` 导出

---

### 阶段 4：CLI 入口 (Day 7-8)

#### [NEW] php2v/cli/main.v
```
用法: php2v compile <input.php> [-o output.v] [--run]
  compile  将 PHP 文件转译为 V 源码
  --run    转译后直接调用 V 编译器运行
```

完整流程：
1. 调用 `php php2v_scripts/parser.php input.php` 获取 JSON AST
2. 解析 JSON → AstNode 树
3. 遍历 AST 生成 V 源码字符串
4. 写入输出文件或直接编译运行

---

### 阶段 5：端到端验证 (Day 8-9)

编写测试固件，验证完整链路：

| 测试文件 | 覆盖特性 |
|---------|---------|
| `01_echo.php` | `echo "Hello World";` |
| `02_variables.php` | `$a = "hello"; $b = 123; echo $a;` |
| `03_arithmetic.php` | `$a = 10 + 20; $b = $a * 3; echo $b;` |
| `04_string_concat.php` | `$name = "PHP"; echo "Hello " . $name;` |
| `05_if_else.php` | `if ($a > 10) { echo "big"; } else { echo "small"; }` |
| `06_truthy.php` | `if ("") { echo "yes"; } else { echo "no"; }` |

每个测试：
1. 通过 `php` 直接运行，获取预期输出
2. 通过 `php2v` 转译 + 编译运行，获取实际输出
3. 对比两者一致

---

## 未来扩展路线图（本次不实现）

| 阶段 | 节点类型 | 说明 |
|------|---------|------|
| v0.2 | `Stmt_Function`, `Expr_FuncCall` | 用户自定义函数 |
| v0.3 | `Stmt_While`, `Stmt_For`, `Stmt_Foreach` | 循环控制流 |
| v0.4 | `Expr_Array`, `Expr_ArrayDimFetch` | 数组构造与下标访问 |
| v0.5 | `Stmt_Class`, `Expr_New`, `Expr_MethodCall` | OOP 基础 |
| v0.6 | `Expr_Closure`, `Expr_ArrowFunction` | 闭包 |
| v1.0 | Hybrid Fallback | `eval()`, `$$var` 等动态特性 → 此时才引入 `php_embed_init()` 逃生舱 |

---

## 验证计划

### 自动化测试
```bash
# 1. 安装 PHP parser 依赖
cd php2v_scripts && composer install

# 2. 运行端到端测试
v test tests/

# 3. 手动验证单个文件
php php2v_scripts/parser.php tests/fixtures/01_echo.php | head -20  # 查看 AST
php2v compile tests/fixtures/01_echo.php -o /tmp/test_echo.v        # 转译
v run /tmp/test_echo.v                                               # 运行
```

### 手动验证
- 对比 `php tests/fixtures/01_echo.php` 与转译编译后二进制的输出
- 检查生成的 V 源码是否可读、可维护
