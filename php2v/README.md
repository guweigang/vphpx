# VPHPX - PHP to V Transpiler / AOT Compiler

VPHPX (php2v) 是一个将 PHP 源代码转译（Transpile）并预编译（AOT Compile）为高效 V 语言原生可执行程序的革命性编译器。

## 项目核心设计理念

1. **极致原生化 (Native First)**：能用 V 语言原生数据类型和基础库的绝不回退至 `libphp`。我们在转译期间自动将 PHP 数组、属性访问、函数返回值等推导为 V 语言原生标量、Map、List 或 Struct 字段直连访问，提供接近原生 C 语言的运行时性能。
2. **零运行时反射分发 (Zero Reflection overhead)**：所有的静态类常量均编译为 Struct 的只读静态关联函数；类和父类继承链上显式声明的类属性在外部和构造函数内一律直连 Struct 公开字段访问，彻底消除运行时 `dispatch_get/set_prop` 的反射查找与装箱开销。
3. **扁平轻量依赖**：彻底消除一切由于文件结构或模块寻址导致的虚拟多层级路径，无软链接，通过级联路径寻址提供最纯粹 of V Module 管理。

## 在线体验 Playground

你可以在线预览和尝试 VPHPX 的转译编译表现：
👉 **[VPHPX 在线 Playground](https://www.bullsoft.org/vphp/playground/)**

## 目录结构

```text
php2v/
├── docs/            # 设计路线图、重构计划及历史设计文档
├── src/
│   ├── ast/         # PHP AST 节点的反序列化与定义 (V module ast)
│   ├── emitter/     # 核心类型分析器与 V 源码发射生成器 (V module emitter)
│   ├── rt/          # 极简且高度优化的 VPHPX 运行时基础类库 (V module rt)
│   └── main.v       # 编译器命令行主入口
├── tests/           # 完备的 PHP 转译及 C 链接运行单元测试套件
├── build.v          # 便捷的单文件 AOT 编译构建脚本
├── README.md        # 本说明文档
└── Makefile         # 构建与测试执行 Makefile
```

## 快速上手

### 1. 编译转译器本身
在 `php2v/` 根目录下执行：
```bash
make
```
或者运行：
```bash
v -path "php2v/src:@vlib" php2v/src/ -o php2v/php2v
```

### 2. 转译并编译运行一个 PHP 文件
我们可以直接使用 `build.v` 构建脚本，它会自动将 PHP 源码转译为 `.v` 文件，自动调用 `clang` 进行 C 级别的链接与嵌入式编译，输出最终的二进制文件：
```bash
v run build.v tests/fixtures/11_oop.php
./tests/fixtures/11_oop
```

### 3. 运行集成测试套件
项目配备了完整的端到端断言，测试每一个 PHP 语言特性的转译质量及运行结果：
```bash
make test
```
