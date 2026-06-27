# P7: 对象/数组 V 全原生化

## Context

当前 PHP 对象系统存在三层间接调用（PhpVal → C.zval → PhpObject → dispatch），所有属性都是 `rt.PhpVal`，带 `prop_`/`method_` 前缀。数组虽然已实现纯 V 的 PhpArray，但元素仍是 PhpVal。

**目标**：混合模式 — 对象/数组内部走 V 原生类型，边界处允许 PhpVal 包装。脚本仍需 libphp 链接（调用 PHP 内置函数时），但内部路径全 V 原生化。

**参数类型推断**：分析构造参数和函数参数的用途，如果只用于原生类型属性/操作，参数也用 V 原生类型。

## 预期效果

### 对象 — 11_oop.php
```php
class User {
    public $name;
    function __construct($name) { $this->name = $name; }
    function getName() { return $this->name; }
}
$user = new User("Alice");
echo $user->getName();
$user->name = "Bob";
echo $user->getName();
```

```v
struct Class_User {
    rt.PhpObjectBase
pub mut:
    name string          // 推断为 V string，无 prop_ 前缀
}

fn (mut this Class_User) __construct(name string) {    // 参数推断为 string，无 method_ 前缀
    this.name = name                                    // 直接赋值，无需解包
}

fn (mut this Class_User) getname() string {             // 返回值推断为 string
    return this.name                                    // 直接返回，无需装箱
}

fn new_user(name string) &Class_User {                  // 工厂也用 V string
    mut obj := &Class_User{}
    obj.__construct(name)
    return obj
}

fn main() {
    mut var_user := new_user('Alice')                    // V 字面量，无 rt.new_string
    print(var_user.getname())                            // 返回 string，直接 print
    var_user.name = 'Bob'                                // 直接 V string 赋值
    print(var_user.getname())
}
```

### 继承 — 16_oop_inheritance.php
```v
struct Class_Animal {
    rt.PhpObjectBase
pub mut:
    name string
}

struct Class_Dog {
    Class_Animal             // V struct embedding = 继承
pub mut:
    breed string
}

fn new_dog(name string, breed string) &Class_Dog { ... }
```

### 数组 — 08_arrays.php
```php
$arr = [10, 20];
$arr[] = 30;
$arr['key'] = "hello";
echo $arr[0];
```
```v
mut var_arr := [i64(10), 20]          // 纯 int 数组用 V 原生 []i64
var_arr << 30                          // V 原生追加
// $arr['key'] = "hello" → 混合键，退化为 PhpArray
```

## 实施步骤

### Phase 0: 数据结构扩展（低风险）

**Task 1: 扩展 ClassInfo + 辅助方法**
- `transpiler.v`: ClassInfo 添加 `prop_types map[string]VarType`
- `transpiler.v`: 添加 `get_class_prop_type(class_name, prop_name) VarType`（含继承链查找）
- `transpiler.v`: 添加 `prop_v_name(prop_name) string`（去掉 `prop_` 前缀，V 关键字冲突时保留）
- `transpiler.v`: 添加 `is_v_keyword(name) bool`
- `transpiler.v`: 添加 `method_v_name(method_name) string`（去掉 `method_` 前缀）
- `type_info.v`: 添加 `is_object() bool`

**Task 2: 注册 $this 类型**
- `emit_class.v` `visit_class_method` (L195): `t.inferred_types['this'] = VarType{ tag: .t_object, class_name: class_name }`

### Phase 1: 属性 + 参数类型推断（核心）

**Task 3: 属性类型推断 pass**
- `type_analyzer.v`: 新增 `infer_class_prop_types()` pass
  - 扫描所有类方法体中的 `$this->prop = expr` 赋值
  - 用 `infer_expr_types()` 获取右侧表达式的类型
  - 所有赋值类型一致且为标量 → 推导为 V 原生类型
- `emit_class.v` `visit_class`: 收集 props 后调用推断 pass

**Task 4: 参数类型推断 pass**
- `type_analyzer.v`: 新增 `infer_method_param_types()` pass
  - 对每个方法，分析参数的使用方式
  - 如果参数仅用于赋值给原生类型属性（`$this->name = $name`）→ 参数推断为 string
  - 如果参数仅用于原生类型运算（`$a + $b`）→ 参数推断为 int/float
  - 无法推断 → 保持 `rt.PhpVal`
- 在 ClassInfo 中新增 `param_types map[string]map[string]VarType`（方法名 → 参数名 → 类型）

**Task 5: 方法返回值类型推断**
- `type_analyzer.v`: 分析方法 return 语句
  - `return $this->name`（name 是 string）→ 返回值推断为 string
  - `return $a + $b`（都是 int）→ 返回值推断为 int
  - 多种返回类型或无法推断 → 保持 `rt.PhpVal`
- 在 ClassInfo 中新增 `return_types map[string]VarType`（方法名 → 返回类型）

### Phase 2: Struct + 方法生成（中风险）

**Task 6: Struct 字段 V 原生类型**
- `emit_class.v` (L139-147): struct 字段生成
  - 可推断属性 → `name string` / `count i64` / `price f64` / `active bool`
  - 不可推断 → `prop_xxx rt.PhpVal`（保留前缀）
- `generate_struct_init` (L267-271): 零值初始化
  - string → `''`，int → `i64(0)`，float → `f64(0.0)`，bool → `false`
  - PhpVal → `rt.new_null()`

**Task 7: 方法签名 + 工厂函数 V 原生类型**
- `emit_class.v` `visit_class_method` (L189-239):
  - 参数签名：`fn (mut this Class_User) __construct(name string)` — 推断为 string 的参数
  - 返回值：`fn (mut this Class_User) getname() string` — 推断为 string 的返回值
  - 无法推断的参数保持 `rt.PhpVal`
  - 无法推断的返回值保持 `rt.PhpVal`
- `generate_dispatchers` (L300):
  - `new_xxx(name string) &Class_User` — 工厂用 V 原生类型
  - `create_xxx(arg_0 rt.PhpVal) rt.PhpVal` — 保留 PhpVal 版本（回退）

**Task 8: 方法体内直连**
- 属性赋值 `$this->name = $param`：
  - 原生属性 + 原生参数 → `this.name = name`（直接赋值）
  - 原生属性 + PhpVal 参数 → `this.name = var_param.to_string()`（解包）
- 属性读取 `return $this->name`：
  - 原生属性 + 原生返回值 → `return this.name`（直接返回）
  - 原生属性 + PhpVal 返回值 → `return rt.new_string(this.name)`（装箱）
- 去掉 `method_` 前缀：`fn getname()` 而非 `fn method_getname()`
- 去掉 `var_this` 代理：`$this->name` 直接用 `this.name`

### Phase 3: 外部操作直连

**Task 9: new 表达式 + 对象变量**
- `emit_expr.v` `node_expr_new` (L676): 返回 `new_xxx('Alice')` — 参数用 V 字面量
  - 如果 new 结果赋给对象类型变量 → `mut var_user := new_xxx('Alice')`
  - 如果 new 结果用于 PhpVal 上下文 → `create_xxx(rt.new_string('Alice'))`
- `emit_expr.v` `node_expr_assign`: 对象类型变量用 `&Class_Xxx` 声明

**Task 10: 外部方法调用 + 属性访问**
- `emit_expr.v` `node_expr_method_call` (L691):
  - 已知类型 → `var_user.getname()`（直接调用，无前缀）
  - 未知 → 回退 `call_method()`
- `emit_expr.v` `node_expr_property_fetch` (L721):
  - 已知类型 + 原生属性 → `var_user.name`（直接字段）
  - 已知类型 + PhpVal 属性 → `var_user.prop_xxx`
  - 未知 → 回退 `get_property()`
- 属性赋值：已知类型 + 原生属性 → `var_user.name = 'Bob'`

**Task 11: PhpVal 边界包裹**

对象/原生类型变量出现在 PhpVal 上下文时自动包装：

| 场景 | 包裹方式 |
|------|---------|
| 传给未知函数 `func($user)` | `rt.wrap_object('User', parents, var_user)` |
| 传给已知原生参数 `strlen($s)` | `$s` 直接用（strlen 映射为 `s.len`） |
| 数组元素 `$arr[] = $user` | `rt.wrap_object(...)` |
| echo 原生值 | 已有直通优化 |
| return 到外部 | 按方法返回类型决定 |

### Phase 4: Dispatcher 适配

**Task 12: dispatch_* 边界处理**
- `emit_class.v`: dispatcher 中处理原生属性的装箱/拆箱
  - `dispatch_get_prop`: `get: 'name' → return rt.new_string(this.name)`
  - `dispatch_set_prop`: `set: 'name' → this.name = val.to_string()`
  - `dispatch_method`: 调用去前缀的方法名 `this.getname(args)`

**Task 13: instanceof 编译期解析**
- 已知类型 → `rt.new_bool(true/false)`

### Phase 5: 数组 V 原生类型（可选增强）

**Task 14: 同质数组推断**
- `type_analyzer.v`: 推断数组元素类型
  - `[1, 2, 3]` → 全 int → V `[]i64`
  - `['a', 'b']` → 全 string → V `[]string`
  - `[10, 'key' => 'val']` → 混合 → 保持 PhpArray
- `emit_expr.v` `node_expr_array`:
  - 同质 int → `[i64(10), 20, 30]`
  - 同质 string → `['a', 'b', 'c']`
  - 混合 → `rt.create_array([...])`

### Phase 6: 测试更新

**Task 15: 更新 expected_snippets**

| Fixture | 关键变更 |
|---------|---------|
| 08_arrays | 纯 int 数组用 V `[]i64` |
| 11_oop | `name string`、`new_user('Alice')`、`var_user.getname()` |
| 16_oop | `breed string`、`new_dog(name string, breed string)` |
| 19_exceptions | Exception 属性原生类型 |
| 30_oop | `instance_of` → `rt.new_bool(true)` |
| 31_oop | IIFE → 直连 |

## 关键文件清单

| 文件 | 改动 |
|------|------|
| `php2v/src/emitter/transpiler.v` | ClassInfo 扩展 + 辅助方法 |
| `php2v/src/emitter/type_info.v` | is_object() |
| `php2v/src/emitter/type_analyzer.v` | 属性推断 + 参数推断 + 返回值推断 |
| `php2v/src/emitter/emit_class.v` | struct/方法/工厂/dispatcher 全面改造 |
| `php2v/src/emitter/emit_expr.v` | new/assign/method/prop 直连 |
| `php2v/src/emitter/emit_stmt.v` | echo/return 适配 |
| `php2v/src/rt/value.v` | wrap_object() |
| `php2v/tests/php2v_test.v` | 更新 OOP/数组 fixture 预期 |

## 验证

```bash
v -path ".:@vlib" php2v/src/ -o php2v/php2v
for f in php2v/tests/fixtures/*.php; do ./php2v/php2v compile "$f" -o "${f%.php}.v"; done
v -path ".:@vlib" test php2v/tests/
```

## 风险

1. 参数类型推断保守策略：无法确定时保持 PhpVal，不会破坏功能
2. V 关键字冲突：prop_v_name/method_v_name 统一处理
3. 返回值类型变化：方法返回 string 时，调用者需要适配（已知调用方可直接 print，未知调用方需包装）
4. dispatch_* 保留：PhpVal 回退路径仍需完整 dispatcher
5. 数组同质推断：仅处理纯标量数组，混合键/混合类型退化为 PhpArray
