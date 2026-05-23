# vphpx

![vphp brand](vphp/assets/vphp_brand.png)

English | [中文](#中文)

`vphpx` is a V-powered stack for building PHP extensions, Zend interop layers, and PHP-facing application infrastructure.

It is not just another extension scaffold. The project is trying to answer a larger question:

- can V become a practical implementation language for PHP-native infrastructure
- can Zend lifecycle, glue generation, value ownership, and object bridging be pushed behind a stable boundary
- can that boundary support not just exported functions, but also reusable framework-style layers

In one sentence:

- `vphpx` = use V to bridge into Zend, then keep building upward from there

## What Is In This Repo

`vphpx` is organized into three layers:

1. `vphp`
   The V <-> Zend/PHP interop layer, export model, ownership model, and glue generation pipeline.
2. `vphptest`
   A real extension playground used to verify and regress-test the interop/compiler/runtime behavior.
3. `vslim`
   A higher-level application/framework layer proving the bridge can support routes, container, CLI, views, and PSR-style HTTP types.

This means the repo is not a single library. It is a full path from:

- raw `ZVal` / ownership / export
- to regression and bridge validation
- to a PHP-facing application layer

## Why This Exists

If you only want a friendlier way to write PHP extensions, there are already mature options such as PHP-CPP or ext-php-rs.

`vphpx` is different because it is not only about replacing C syntax. It is about testing whether V can support:

- native PHP-facing APIs and objects
- lifecycle-aware value ownership
- generated glue for functions, classes, traits, interfaces, and enums
- a broader PHP-facing application surface on top of the extension layer

## One-Minute Example

Here is the smallest useful mental model: define `ExtensionConfig`, export a function, build, then call it from PHP.

### 1. Write the V extension entry

```v
module main

import vphp

const ext_config = vphp.ExtensionConfig{
    name: 'hello_vphp'
    version: '0.1.0'
    description: 'Hello extension built with vphp'
}

@[php_function]
fn hello_from_v(name string) string {
    return 'Hello, ${name} from VPHP'
}
```

### 2. Build the extension

The repo already contains a real extension playground in [`vphptest/`](vphptest), and its build flow is:

```bash
make -C vphptest build
```

That flow runs the `vphp` compiler and links the generated extension.

### 3. Load it in PHP

```bash
php -d extension=./hello_vphp.so -r 'echo hello_from_v("PHP"), PHP_EOL;'
```

In practice, your own extension follows the same shape:

- define `ext_config`
- annotate exported functions/classes
- run the build flow
- load the generated `.so` from PHP

If you want a larger real example, start with:

- [vphptest/config.v](vphptest/config.v)
- [vphptest/functions.v](vphptest/functions.v)
- [vphptest/Makefile](vphptest/Makefile)

## Repo Structure

### `vphp/`

The core layer. It is responsible for:

- exporting V functions, classes, traits, interfaces, and enums to PHP
- calling PHP functions, classes, objects, properties, constants, and callables from V
- managing `ZVal` and ownership/lifetime boundaries
- generating extension glue and bridge code

Current core value models include:

- `ZVal` for raw Zend-level access
- `RequestBorrowedZBox`
- `RequestOwnedZBox`
- `PersistentOwnedZBox`

And the retained storage strategy for long-lived returns:

- plain data -> `dyn_data`
- objects -> `retained_object`
- callables -> `retained_callable`
- fallback -> `fallback_zval`

Start here if you want to understand the lowest layer first.

Key docs:

- [vphp/README.md](vphp/README.md)
- [vphp/docs/OVERVIEW.md](vphp/docs/OVERVIEW.md)
- [vphp/docs/ownership.md](vphp/docs/ownership.md)

### `vphptest/`

The regression and validation layer.

Its job is to turn `vphp` interop into a real extension playground with PHPT coverage and bridge examples.

Use it when you want to verify:

- raw `ZVal` behavior
- exported functions, classes, interfaces, and constants
- closure / callable / object bridging
- compiler-generated glue correctness

### `vslim/`

The application/framework layer.

Its purpose is to prove that `vphp` can support more than isolated exported functions. It provides a PHP-facing layer with:

- app and routing
- container
- middleware
- CLI app model
- PSR-style HTTP types
- view/MVC-oriented building blocks

Read it if you want to see what the bridge looks like when it grows into application infrastructure.

Key doc:

- [vslim/README.md](vslim/README.md)

## Minimum Build Layout

After the repository split, `vphpx` no longer vendors `vhttpd`. The minimum layout for the full VSlim build and runtime integration tests is:

```text
<workspace>/
  vphpx/
  vhttpd/
```

`vslim/Makefile` resolves `VHTTPD_ROOT` to `../vhttpd` from the `vphpx` repository by default. If your checkout uses a different layout, pass it explicitly:

```bash
make -C vslim runtime-check VHTTPD_ROOT=/path/to/vhttpd
```

The core `vphp` and `vphptest` build/test flows do not need `vhttpd`; only VSlim runtime/worker integration paths do.

## Who This Is For

This repo is a good fit if you want to:

- build PHP extensions in V instead of writing Zend C directly
- study V <-> PHP interop and lifecycle boundaries
- build framework/runtime-style layers at the extension boundary
- expose native PHP-facing objects, CLI tools, containers, and HTTP types from V

It is less of a fit if you only want:

- a very thin wrapper around existing C/C++ code
- or a Rust-first extension workflow

## Suggested Reading Order

If this is your first time here:

1. Read this README for the overall map
2. Read [vphp/README.md](vphp/README.md)
3. Read [vphp/docs/ownership.md](vphp/docs/ownership.md)
4. Browse [vphptest/tests](vphptest/tests)
5. Read [vslim/README.md](vslim/README.md)

That gives you the full path:

- how the low-level bridge works
- how it is verified
- how it grows into a higher-level PHP-facing layer

## Current Status

The main direction is now fairly clear:

- `ZVal` stays as the raw low-level Zend surface
- `*ZBox` is the primary ownership/lifetime model
- `vphptest` is the regression layer
- `vslim` is the application-layer proof

So `vphpx` is no longer just a loose experiment. It already has:

- a core bridge layer
- a regression/validation layer
- an application/framework layer

---

## 中文

`vphpx` 是一套用 V 构建 PHP 扩展、Zend 互操作层和 PHP 应用基础设施的工程栈。

它想解决的不是“再做一个 PHP 扩展脚手架”，而是几个更大的问题：

- 能不能让 V 成为 PHP 原生基础设施的一种实现语言
- 能不能把 Zend 生命周期、glue 生成、值所有权、对象桥接这些脏活压到一层稳定边界里
- 能不能在这层边界之上，不只是导出函数，还能继续长出真正可用的上层应用能力

一句话概括：

- `vphpx` = 用 V 连接 Zend，并在这个连接之上继续往上长

## 仓库里有什么

`vphpx` 现在主要分成三层：

1. `vphp`
   V 和 Zend/PHP 之间的 interop 层、导出模型、ownership 模型和 glue 生成管线。
2. `vphptest`
   一个真实扩展试验场，用来验证和回归 interop/compiler/runtime 行为。
3. `vslim`
   更高层的应用/框架层，用来证明这套桥接不仅能导出函数，还能支撑路由、容器、CLI、视图和 PSR 风格 HTTP 类型。

也就是说，这不是一个单点库，而是一条完整路径：

- 从底层 `ZVal` / ownership / export
- 到中间层回归与 bridge 验证
- 再到上层 PHP-facing application layer

## 为什么要做这个

如果你只是想找一种“比 Zend C 好写一点”的扩展方案，PHP-CPP 或 ext-php-rs 都已经很成熟。

`vphpx` 的差异不只是把实现语言换成 V，而是它想验证 V 能不能承担下面这些事情：

- 原生 PHP-facing API 和对象
- 带生命周期边界的值所有权管理
- function / class / trait / interface / enum 的 glue 生成
- 在扩展层之上继续长出更完整的 PHP-facing application surface

## 一分钟上手

最小心智模型其实很简单：配 `ExtensionConfig`，导出一个函数，编译，然后在 PHP 里加载它。

### 1. 先写扩展入口

```v
module main

import vphp

const ext_config = vphp.ExtensionConfig{
    name: 'hello_vphp'
    version: '0.1.0'
    description: 'Hello extension built with vphp'
}

@[php_function]
fn hello_from_v(name string) string {
    return 'Hello, ${name} from VPHP'
}
```

### 2. 编译扩展

仓库里已经有一个真实扩展样板 [`vphptest/`](vphptest)，它的构建流程就是：

```bash
make -C vphptest build
```

这一步会先跑 `vphp` compiler，再把生成物链接成扩展。

### 3. 在 PHP 里加载

```bash
php -d extension=./hello_vphp.so -r 'echo hello_from_v("PHP"), PHP_EOL;'
```

你自己的扩展本质上也是同一个套路：

- 定义 `ext_config`
- 给函数/类打导出注解
- 跑构建流程
- 在 PHP 里加载生成出来的 `.so`

如果你想看更完整的真实示例，直接从这里开始：

- [vphptest/config.v](vphptest/config.v)
- [vphptest/functions.v](vphptest/functions.v)
- [vphptest/Makefile](vphptest/Makefile)

## 仓库结构

### `vphp/`

这是核心层，负责：

- 把 V 函数、类、trait、interface、enum 导出到 PHP
- 从 V 调 PHP 函数、类、对象、属性、常量、callable
- 管理 `ZVal` 和 ownership/lifetime 边界
- 生成扩展 glue 和桥接代码

当前主模型包括：

- `ZVal`：底层 raw Zend 访问
- `RequestBorrowedZBox`
- `RequestOwnedZBox`
- `PersistentOwnedZBox`

以及长期持有返回值时的 retained 策略：

- 普通数据 -> `dyn_data`
- 对象 -> `retained_object`
- callable -> `retained_callable`
- 兜底 -> `fallback_zval`

如果你想先理解最底层的设计，从这里开始。

入口文档：

- [vphp/README.md](vphp/README.md)
- [vphp/docs/OVERVIEW.md](vphp/docs/OVERVIEW.md)
- [vphp/docs/ownership.md](vphp/docs/ownership.md)

### `vphptest/`

这是回归和验证层。

它的职责是把 `vphp` 的 interop 能力做成一个真实扩展试验场，并用 PHPT 和桥接样例把行为锁住。

适合拿来看这些：

- raw `ZVal` 行为
- 导出函数、类、接口、常量
- closure / callable / object bridge
- compiler 生成 glue 是否仍然正确

### `vslim/`

这是应用/框架层。

它的目标是证明 `vphp` 不只是能导出零散函数，而是真的能支撑更高层的 PHP-facing 能力，比如：

- app 和路由
- 容器
- middleware
- CLI app model
- PSR 风格 HTTP 类型
- view / MVC 相关 building blocks

如果你关心“这套桥接长成上层应用能力之后是什么样子”，就看这里。

入口文档：

- [vslim/README.md](vslim/README.md)

## 最小可构建布局

拆分仓库之后，`vphpx` 不再内置 `vhttpd`。如果要完整构建 VSlim 并运行 runtime / worker 集成测试，最小目录关系是：

```text
<workspace>/
  vphpx/
  vhttpd/
```

`vslim/Makefile` 默认会把 `VHTTPD_ROOT` 解析到 `vphpx` 同级的 `vhttpd`。如果你的 checkout 不是这个布局，可以显式指定：

```bash
make -C vslim runtime-check VHTTPD_ROOT=/path/to/vhttpd
```

只跑 `vphp` / `vphptest` 的核心构建和测试不需要 `vhttpd`；依赖它的是 VSlim runtime / worker 集成链路。

## 适合谁

这个仓库更适合这几类人：

- 想用 V 写 PHP 扩展，而不是直接下场写 Zend C
- 想研究 V <-> PHP 的 interop 和生命周期边界
- 想在扩展边界上做 framework/runtime 风格能力
- 想从 V 暴露 PHP-facing 对象、CLI、容器和 HTTP 类型

如果你只想要：

- 很薄地包一层已有 C/C++ 代码
- 或者更偏 Rust-first 的扩展工作流

那这个方向可能不是最短路径。

## 推荐阅读顺序

第一次进这个仓库，建议按这个顺序看：

1. 先看这份 README，建立整体地图
2. 看 [vphp/README.md](vphp/README.md)
3. 看 [vphp/docs/ownership.md](vphp/docs/ownership.md)
4. 看 [vphptest/tests](vphptest/tests)
5. 再看 [vslim/README.md](vslim/README.md)

这样你会顺着整条链看清楚：

- 底层怎么桥
- 中间怎么验证
- 上层怎么长成 PHP-facing application layer

## 当前状态

现在主线已经比较明确：

- `ZVal` 保持为底层 raw Zend 能力
- `*ZBox` 是主 ownership/lifetime 模型
- `vphptest` 负责回归验证
- `vslim` 负责应用层证明

所以 `vphpx` 现在已经不只是零散实验，而是形成了：

- 核心桥接层
- 回归验证层
- 应用/框架层
