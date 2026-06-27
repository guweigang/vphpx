# PHP AST 完整转译实现路线图 (ROADMAP)

本文档记录了 `php2v` 转译器支持完整 PHP 语法树的路线图与阶段性规划。我们将按以下四个阶段逐步推进并补全语法支持。

---

## 阶段 1：核心流程控制补全
- [x] **`Stmt_Switch` / `Stmt_Case` / `Stmt_Default`**
  - *转译设计*：将 PHP 的 `switch` 分支结构翻译为 V 语言的 `match` 语句或扁平化的 `if-else` 条件链。
  - *测试用例*：`24_switch_case.php`
- [x] **`Expr_Match`** (PHP 8.0+)
  - *转译设计*：转译为 V 语言原生的 `match` 表达式，并将其结果值赋给 `PhpVal` 变量。
  - *测试用例*：`25_match_expr.php`
- [x] **`Stmt_Do`**
  - *转译设计*：将 `do-while` 循环转译为 V 语言的 `for { ... if !cond { break } }` 结构。
  - *测试用例*：`26_do_while.php`


---

## 阶段 2：高级运算符与字面量增强
- [x] **自增自减运算符 (`Expr_PostInc`, `Expr_PostDec`, `Expr_PreInc`, `Expr_PreDec`)**
  - *转译设计*：在 V 语言侧通过 `rt` 运行时相关方法（如 `rt.post_inc(mut &i)`）模拟自增减副作用与值返回。
  - *测试用例*：`27_increment_decrement.php`
- [x] **位运算符 (与 `&`, 或 `|`, 异或 `^`, 取反 `~`, 左移 `<<`, 右移 `>>`)**
  - *转译设计*：在运行时 `rt` 中封装对应的二进制位运算函数（如 `rt.bitwise_and(a, b)`）。
  - *测试用例*：`28_bitwise_ops.php`
- [x] **错误抑制符 (`Expr_ErrorSuppress`)**
  - *转译设计*：在 V 侧转译为其内部表达式本身（即忽略 `@` 标记），运行时进行非致命错误的捕获或直接放行。
  - *测试用例*：结合已有用例进行容错验证。


---

## 阶段 3：面向对象 (OOP) 进阶支持
- [ ] **类常量定义与引用 (`Stmt_ClassConst`, `Expr_ClassConstFetch`)**
  - *转译设计*：支持在类内声明 `const`，并在转译为 V 代码时，映射到运行时的常数注册表中，支持 `self::`, `parent::` 以及 `ClassName::` 静态读取。
  - *测试用例*：`29_class_constants.php`
- [ ] **接口协议 (`Stmt_Interface`)**
  - *转译设计*：声明 V 语言的 `interface` 并为对应的 V 类结构体实现动态派发协议。
  - *测试用例*：`30_oop_interfaces.php`
- [ ] **Traits 支持 (`Stmt_Trait`, `Stmt_TraitUse`)**
  - *转译设计*：转译期代码展平 (Flattening) 策略。在转译时将 Trait 中定义的方法与属性拷贝注入到所有使用了该 Trait 的类的 AST 树节点中。
  - *测试用例*：`31_oop_traits.php`

---

## 阶段 4：生成器与高级元编程支持
- [ ] **生成器与迭代器 (`Expr_Yield`, `Expr_YieldFrom`)**
  - *转译设计*：将包含 `yield` 的函数转换为一个实现了 `Generator` 协议的自定义状态机结构体，用以保存/恢复局部上下文。
  - *测试用例*：`32_generators_yield.php`
- [ ] **静态局部变量 (`Stmt_Static`, `Expr_StaticVar`)**
  - *转译设计*：将函数内声明的 `static` 变量存储至 V 的闭包外壳或模块级全局哈希表中。
  - *测试用例*：`33_function_static_vars.php`
- [ ] **对象克隆 (`Expr_Clone`)**
  - *转译设计*：翻译为 `rt.clone_object(obj)` 执行对象的深度复制。
  - *测试用例*：`34_object_cloning.php`

---

## 已知限制

### 动态类实例化（暂不支持）

PHP 支持使用变量动态实例化类：

```php
$class = 'App\\Utils\\Foo';
$obj = new $class();  // ❌ 暂不支持
```

**原因**：V 是静态编译语言，不支持运行时反射或动态函数调用。要实现此功能需要生成类名到创建函数的映射表（match 语句），对于大型 PHP 项目（特别是使用 DI 容器的框架）映射表会非常庞大，影响编译性能和代码体积。

**当前方案**：仅支持字面量类名的实例化：

```php
new Foo()              // ✅ 支持
new \App\Utils\Foo()   // ✅ 支持
new $class             // ❌ 不支持
```

**未来可能的方案**：如果确实需要支持，可以考虑生成按需的映射表（只映射实际被动态实例化的类），或使用 V 的 sum type + 工厂函数模式。
