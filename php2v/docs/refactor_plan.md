# php2v 转译器审计报告 & 改进计划

## 审计总评

> [!NOTE]
> **结论：工程完成度高，但生成的 V 代码确实低于预期。** 
> 
> 转译器架构（AST → Emitter → RT）清晰，31 个 fixture 覆盖面广（从 echo 到 OOP 继承、闭包、异常、命名空间），端到端测试链路完整。
> 但生成的 V 代码存在系统性的「过度动态化」问题——**把所有 PHP 语义都包装进 `rt.PhpVal`（即 `C.zval`），丧失了 V 的类型安全和性能优势**。

---

## 一、发现的核心问题（按严重程度排序）

### 🔴 P0：全场景统一装箱 — 丧失 V 类型系统

**现状**：所有值无论类型一律装箱为 `rt.PhpVal`（底层 `&C.zval`），每次赋值都要 `new_zval()` 堆分配 + 手工设置 `type_info`。

**影响**：
- `$a = 10 + 20;` 生成 `rt.add(rt.new_int(10), rt.new_int(20))`，这里产生了 **3 次堆分配** + **1 次 C FFI 调用**，而 V 原生只需 `a := 10 + 20`
- 从 PHP 的 VM 解释器变成了「V 版解释器」，性能可能更差（多了 FFI 开销）
- V 编译器完全无法优化，因为所有变量都是 `rt.PhpVal`

**理想输出对比**：

| PHP 源码 | 当前生成 | 理想生成 |
|---------|---------|---------|
| `$a = 10` | `mut var_a := rt.new_int(10)` | `mut var_a := 10` |
| `$a + $b` | `rt.add(var_a, var_b)` | `var_a + var_b` |
| `echo "Hello"` | `rt.echo_val(rt.new_string('Hello'))` | `print('Hello')` |
| `strlen($s)` | `rt.call_function('strlen', [var_s])` | `var_s.len` |

---

### 🔴 P1：无类型推断 — 一切都是 PhpVal

**现状**：转译器完全没有类型推断能力。即使 PHP 代码中类型显而易见（如 `$a = 10; $b = $a + 5;`），生成代码仍然全部走弱类型路径。

**缺失的推断场景**：

| 场景 | 可推断类型 | 现状 |
|------|-----------|------|
| `$a = 42` | `i64` | PhpVal |
| `$s = "hello"` | `string` | PhpVal |
| `$b = true` | `bool` | PhpVal |
| `$arr = [1, 2, 3]` | `[]i64` 或至少 `[]PhpVal` | 通过 `create_array()` 走 Zend hash |
| `function add($a, $b) { return $a + $b; }` | 参数/返回值可标注 | 全部 PhpVal |

---

### 🟠 P2：每个生成文件都包含 4 个空壳路由函数（16 行样板）

**现状**：无论 PHP 文件多简单，生成代码都包含：

```v
fn call_method(obj rt.PhpVal, method_name string, args []rt.PhpVal) rt.PhpVal {
    return rt.new_null()
}

fn get_property(obj rt.PhpVal, prop_name string) rt.PhpVal {
    return rt.new_null()
}

fn set_property(obj rt.PhpVal, prop_name string, val rt.PhpVal) {}

fn call_closure(cb rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
    return rt.new_null()
}
```

**影响**：`echo "Hello World\n";` 这一行 PHP 生成了 **25 行** V 代码，其中 **16 行是无用样板**。对于简单脚本，信噪比极低。

---

### 🟠 P3：字符串拼接链式嵌套 — 生成代码不可读

**现状**（`"Hello $name, next year you will be {$age} years old."`）：

```v
mut var_msg := rt.concat(rt.concat(rt.concat(rt.concat(
    rt.new_string('Hello '), var_name),
    rt.new_string(', next year you will be ')),
    var_age),
    rt.new_string(' years old.'))
```

**理想**：利用 V 的字符串插值

```v
mut var_msg := 'Hello ${var_name.to_string()}, next year you will be ${var_age.to_string()} years old.'
```

---

### 🟠 P4：echo 不直接 print — 多余包装

**现状**：`echo "hello";` → `rt.echo_val(rt.new_string('hello'))`

**理想**：纯字符串字面量的 echo 直接生成 `print('hello')`，不需要经过 PhpVal 装箱再拆箱。

---

### 🟡 P5：PHP 内置函数全走动态 dispatch — 错失 VLib 映射

**现状**：`strlen($s)` → `rt.call_function('strlen', [var_s.dup()])`

`call_function` 内部对 `strlen` 等少数函数做了 V 原生实现（[functions.v](file:///Users/guweigang/Source/vphpx/php2v/src/rt/functions.v)），但 **这个优化放错了位置** — 应该在转译阶段（emitter）直接生成 V 原生调用，而不是在运行时做字符串 match。

**可直接映射到 VLib 的常用函数**：

| PHP 函数 | V / VLib 等价 |
|---------|-------------|
| `strlen($s)` | `s.len` |
| `strtoupper($s)` | `s.to_upper()` |
| `strtolower($s)` | `s.to_lower()` |
| `trim($s)` | `s.trim_space()` |
| `substr($s, $start, $len)` | `s.substr(start, start + len)` |
| `str_replace($s, $r, $h)` | `h.replace(s, r)` |
| `array_push($a, $v)` | `a << v` |
| `count($arr)` | `arr.len` |
| `in_array($v, $arr)` | `v in arr` |
| `explode($d, $s)` | `s.split(d)` |
| `implode($d, $arr)` | `arr.join(d)` |
| `intval($s)` | `s.int()` |
| `floatval($s)` | `s.f64()` |
| `abs($n)` | `math.abs(n)` |
| `max($a, $b)` | `math.max(a, b)` |
| `min($a, $b)` | `math.min(a, b)` |
| `array_key_exists($k, $a)` | `k in a` |
| `array_merge($a, $b)` | `a << b` |
| `is_null($v)` | `v is none` 或 `v == none` |
| `var_dump($v)` | `println(v)` |

---

### 🟡 P6：switch/match 生成了冗余的中间变量 + if-else 链

**现状**（PHP `switch ($x) { case 1: ... case 2: case 3: ... }`）：

```v
mut switch_val_1 := var_x
if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
```

**理想**：直接用 V 的 `match` 表达式

```v
match var_x.to_i64() {
    1 { ... }
    2, 3 { ... }
    else { ... }
}
```

---

### 🟡 P7：OOP dispatch 全走字符串路由 — 编译期可内联

**现状**：方法调用 `$user->getName()` → `call_method(var_user, 'getName', []rt.PhpVal{})`

对于源码中明确的类实例化 + 方法调用，完全可以在编译期解析为直接的结构体方法调用：`var_user.method_getname()`

---

### 🟡 P8：闭包生成过于重量级 — 每个闭包都是一个 struct

**现状**：每个 PHP 闭包生成一个完整的 struct + invoke 方法 + PhpObject 包装 + call_closure 路由。

```v
struct Closure_1 {
    rt.PhpObjectBase
pub mut:
    prop_x rt.PhpVal
}
fn (mut this Closure_1) invoke(args []rt.PhpVal) rt.PhpVal { ... }
```

**理想**：对于简单闭包，利用 V 的匿名函数：

```v
cb := fn [x] (y int) int { return x + y }
```

---

### 🟡 P9：`rt.new_null()` 到处分配 — 应为编译期常量

**现状**：每次需要 null 值都调用 `rt.new_null()` → `new_zval()` → `malloc` → 设置 type_info

**改进**：预分配一个全局 null 单例 `pub const php_null = PhpVal{ raw: ... }`，类似地 `php_true`、`php_false` 也可以预分配。

---

### 🟡 P10：`.dup()` 过度调用 — 变量赋值时不必要的复制

**现状**：

```v
// $a = $b;  →
var_a = var_b.dup()

// func(var_x) →
func(var_x.dup())
```

PHP 的 COW（Copy-On-Write）语义被简单粗暴地翻译成了每次赋值都深拷贝。对于不可变使用场景（只读取），这些 dup 完全多余。

---

## 二、Transpiler 自身代码质量

### 🟠 transpiler.v 单文件 2254 行 — 需要拆分

[transpiler.v](file:///Users/guweigang/Source/vphpx/php2v/src/emitter/transpiler.v) 包含了所有 visit 方法、类生成、闭包生成、dispatcher 生成、trait 处理等逻辑。按职责应拆分：

| 文件 | 职责 |
|------|------|
| `transpiler.v` | 核心结构体 + transpile() 入口 + visit_stmt/visit_expr 骨架 |
| `emit_stmt.v` | 各 visit_xxx 语句方法 |
| `emit_expr.v` | 各 visit_expr 表达式方法 |
| `emit_class.v` | OOP 相关（类、方法、dispatcher、继承） |
| `emit_closure.v` | 闭包/箭头函数生成 |
| `emit_exception.v` | try-catch-finally + goto 生成 |

### 🟡 二元运算 12 个 case 高度重复

[transpiler.v L625-L740](file:///Users/guweigang/Source/vphpx/php2v/src/emitter/transpiler.v#L625-L740) 中每个二元运算的模式完全相同（取 left/right → visit → 拼接 `rt.xxx(...)`），可以用一个 map + helper 消除重复。

### 🟡 write_indent/write_line/write_string 三重分支

每个写入方法都有 `if t.is_in_closure { ... } else if t.is_in_func { ... } else { ... }` 三重分支（[L189-L235](file:///Users/guweigang/Source/vphpx/php2v/src/emitter/transpiler.v#L189-L235)），可以用一个 `current_builder()` 方法统一。

### 🟡 `voidptr(xxx) != 0` 空指针检查散落各处

大量的 `if voidptr(n) != 0 { ... }` 模式，应封装为 `fn is_valid(p ?&AstNode) bool`。

---

## 三、改进计划

### 阶段 1：类型推断引擎（核心 — 解决 P0/P1）

#### [NEW] `php2v/src/emitter/type_info.v`
- 定义 `TypeTag` 枚举：`t_int | t_float | t_string | t_bool | t_null | t_array | t_object | t_mixed`
- 定义 `VarType` 结构：`{ tag TypeTag, class_name string }`
- 所有变量在作用域中追踪推断类型

#### [MODIFY] `php2v/src/emitter/scope.v`
- `VarScope.declared` 从 `map[string]bool` 改为 `map[string]VarType`
- 新增 `get_type(name string) TypeTag` 方法

#### [MODIFY] `php2v/src/emitter/transpiler.v`
- `visit_expr()` 返回 `ExprResult { code: string, typ: TypeTag }` 而非纯 string
- 基于 TypeTag 决定是否生成原生 V 代码：
  - `t_int + t_int` → `var_a + var_b`（而非 `rt.add(var_a, var_b)`）
  - `t_string` concat → V 字符串插值
  - `t_mixed` 仍走 rt.xxx 路径

---

### 阶段 2：标量直通优化（解决 P0 最大热点）

#### [NEW] `php2v/src/emitter/scalar_opt.v`
- 检测 "纯标量" 函数：所有参数和返回值都是单一标量类型
- 对这些函数生成原生 V 签名 `fn func_add_five(val i64) i64`
- 回退机制：一旦遇到类型不可知，fallback 到 PhpVal 路径

---

### 阶段 3：样板消除 + VLib 映射（解决 P2/P4/P5）

#### [MODIFY] `php2v/src/emitter/transpiler.v`
- 按需生成 `call_method` / `get_property` / `set_property` / `call_closure`
- 仅在代码中实际使用 OOP / closure 特性时才注入

#### [NEW] `php2v/src/emitter/builtin_map.v`
- 维护 PHP 内置函数 → V 原生代码的映射表
- 在 `visit_expr` 的 `node_expr_funccall` 分支中优先查表
- `echo "string literal"` → `print('string literal')`

---

### 阶段 4：字符串优化（解决 P3）

#### [MODIFY] `php2v/src/emitter/transpiler.v`
- 识别 `Scalar_Encapsed` / `Scalar_InterpolatedString` 节点
- 当所有插值部分类型可知时，生成 V 字符串插值 `'Hello ${name}'`
- 回退：仍然走 `rt.concat` 链

---

### 阶段 5：运行时单例优化（解决 P9/P10）

#### [MODIFY] `php2v/src/rt/value.v`
- 预分配全局单例：`pub const php_null`, `pub const php_true`, `pub const php_false`
- 减少对 `new_null()` / `new_bool()` 的堆分配

#### [MODIFY] `php2v/src/emitter/transpiler.v`
- 静态分析变量使用：只读变量（赋值后未被修改）不生成 `.dup()`

---

### 阶段 6：代码组织重构（解决 transpiler.v 膨胀问题）

#### [MODIFY] 拆分 transpiler.v
- 按上述方案拆分为 5-6 个文件
- 提取二元运算辅助函数
- 统一 `current_builder()` 消除三重分支

---

## 四、验证计划

### 自动化测试
```bash
# 1. 现有 31 个 fixture 全部回归通过
v test php2v/tests/

# 2. 新增 fixture：验证类型推断生成的原生 V 代码
# pure_int_arithmetic.php → 不含任何 rt. 调用
# mixed_type.php → 仍走 rt. 路径

# 3. 编译 + 运行对比
php tests/fixtures/XX.php > expected.txt
php2v compile tests/fixtures/XX.php -o /tmp/XX.v && v run /tmp/XX.v > actual.txt
diff expected.txt actual.txt
```

### 手动验证
- 对比优化前后的生成代码行数和可读性
- 基准性能测试：纯算术循环 PHP vs 当前 vs 优化后

---

## 五、优先级总结

| 优先级 | 问题 | 改进 | 难度 | 影响 |
|--------|------|------|------|------|
| 🔴 P0 | 全场景装箱 | 类型推断 + 标量直通 | 高 | 性能 & 可读性根本性提升 |
| 🔴 P1 | 无类型推断 | TypeTag + ExprResult | 高 | P0 前置依赖 |
| 🟠 P2 | 样板函数 | 按需生成 | 低 | 代码整洁度 |
| 🟠 P3 | 字符串嵌套 | V 插值 | 中 | 可读性 |
| 🟠 P4 | echo 包装 | 直接 print | 低 | 可读性 |
| 🟡 P5 | 内置函数 | VLib 映射表 | 中 | 性能 & 可读性 |
| 🟡 P6 | switch 不优 | V match | 中 | 惯用性 |
| 🟡 P7 | OOP 动态路由 | 编译期内联 | 高 | 性能 |
| 🟡 P8 | 闭包重量级 | V 匿名函数 | 中 | 代码量 |
| 🟡 P9 | null 堆分配 | 全局单例 | 低 | 性能 |
| 🟡 P10 | dup 过度 | 只读分析 | 中 | 性能 |

> [!IMPORTANT]
> **核心决策点**：改进方向的本质选择是——
> 
> **当前路线** = "V 只是另一个执行后端"（所有语义都封在 `rt.PhpVal` 里）
> 
> **理想路线** = "尽可能生成原生 V 代码，仅在类型不可知或需要 PHP 弱类型语义时回退到 PhpVal"
> 
> 这是一个渐进式优化，不需要推翻现有架构。核心策略是：**类型可知 → V 原生，类型不可知 → PhpVal fallback**。

> [!WARNING]
> **需要你确认的问题**：
> 1. 你是否同意「类型推断 + 标量直通」作为优先方向？
> 2. 这套改进要保持与现有 31 个 fixture 的完全兼容吗？还是可以接受生成代码变化（只要语义等价）？
> 3. 想先做哪个阶段？我建议从 **阶段 3（样板消除 + VLib 映射）** 开始——改动最小、效果最直观。
