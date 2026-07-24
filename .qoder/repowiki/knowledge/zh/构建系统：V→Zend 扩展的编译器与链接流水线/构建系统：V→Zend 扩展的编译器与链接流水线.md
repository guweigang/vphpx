---
kind: build_system
name: 构建系统：V→Zend 扩展的编译器与链接流水线
category: build_system
scope:
    - '**'
source_files:
    - vphp/v.mod
    - vslim/build.v
    - vslim/Makefile
    - vphptest/Makefile
    - vslim/templates/app/Makefile
    - vslim/scripts/package_release.php
    - vslim/config.w32
---

## 1. 体系概览

本项目采用“V 代码 + VPHP 导出编译器 + GCC 链接”的两阶段构建模型，将 V 编写的逻辑编译为 PHP 扩展（`.so`），并通过 vhttpd/php-worker 或 PHP CLI/SAPI 加载运行。核心流程：

- `vphp/`：底层 Zend 绑定、值模型与生命周期抽象，提供 C 桥接头文件 `v_bridge.c/h`。
- `compiler/`：VPHP 导出编译器（parser → repr → builder → emitter），负责把 V 函数/类/接口/枚举等生成 C/V 胶水代码。
- `vslim/`：基于 vphp 的高层框架应用，其 `build.v` 是主构建入口，串联编译器与最终链接。
- `vphptest/`：测试扩展，复用同一套 Makefile + build.v 流水线，用于验证 vphp 能力。

## 2. 关键构建文件与角色

- `vphp/v.mod`：vphp 模块清单，声明模块名与版本，供 V 工具链识别。
- `vslim/build.v`：**主构建脚本**，调用 `vphp.compiler` 执行导出编译，转译 V 源到 C，修补 Windows 兼容问题，再调用 gcc 完成最终链接。
- `vslim/Makefile`：顶层 Makefile，封装 `build` / `ext` / `dist` / `test` / `serve` / `runtime-check` 等目标，自动探测 php-config、pkg-config、BREW_PATH、V_ROOT 等环境。
- `vphptest/Makefile`：测试扩展的轻量 Makefile，同样通过 `run build.v` 触发编译器，再用 gcc 链接出 `vphptest.so`。
- `vslim/templates/app/Makefile`：模板项目 Makefile，暴露 `serve` / `vhttpd` / `smoke-vhttpd` / `cli` 等目标，统一本地开发体验。
- `vslim/scripts/package_release.php`：打包发布脚本，根据 `--version` / `--platform` / `--package-type` 生成二进制或源码包。
- `vslim/config.w32`：Windows 下的 PHP 扩展配置入口（与 configure 风格一致）。
- `vslim/composer.json`：依赖管理（仅对 PHP 侧示例/测试有用）。

## 3. 架构与约定

### 3.1 两阶段构建

1. **导出编译阶段**  
   `vslim/build.v` 调用 `vphp.compiler.new(target_files).compile().generate_all()`，由 VPHP 编译器扫描 V 源码中的 `@php_*` 注解与 `ExtensionConfig`，生成 C 注册/胶水代码。

2. **转译 + 链接阶段**  
   - 通过 `run_v_transpile(...)` 启动 `v -shared -o <ext>_generated.c src/...`，将业务 V 代码转为 C。
   - 内置 Windows 补丁器修正常量后缀与固定数组初始化，确保 MSVC 可编译。
   - 使用 `gcc -shared -fPIC` 将 `_generated.c`、`php_bridge.c`、`../vphp/v_bridge.c` 与 PHP SDK 库链接成 `<ext>.so`。

### 3.2 环境探测与可移植性

- `php-config --includes/--ldflags/--libs` 动态获取 PHP 扩展编译参数，并过滤掉不存在的 `-L` 路径。
- `pkg-config` 优先探测 cjson、openssl、mysqlclient/mariadb/libmariadb；回退到 Homebrew 常见前缀 `/opt/homebrew`。
- GC 模式通过环境变量 `VPHP_V_GC` 控制，默认 `auto` 时检测 bdw-gc 是否存在，选择 `boehm` 或 `none`。
- `VHTTPD_ROOT` 指向同级仓库的 `vhttpd`，支持跨仓库布局；模板 Makefile 中默认相对路径 `../../../../vhttpd`。

### 3.3 产物与命名约定

- 扩展名由编译器推导，输出形如 `vslim_generated.c` + `vslim.so`。
- 测试扩展输出 `vphptest.so`。
- 所有中间 `.c` 与 `.so` 在 `make clean` 下被清理。

### 3.4 测试与矩阵

- `make test`：运行 PHPT 用例集（`tests/*.phpt`）。
- `make psr-matrix` / `make framework-matrix`：分别驱动 PSR 与框架兼容性矩阵。
- `make runtime-check`：额外包含需要 vhttpd + worker 的运行时回归用例。
- `make demo-self-test` / `make demo-verify`：示例应用自检与端到端验证。

## 4. 开发者应遵循的规则

- **新增 V 源文件**：放在 `vslim/src/` 下，无需手动修改 Makefile；`build.v` 会自动发现非测试、非构建脚本的 `.v` 文件。
- **GC 模式切换**：通过 `VPHP_V_GC=boolem|none|auto` 控制，CI 或 Docker 环境中建议显式指定。
- **Windows 构建**：若需强制走 Windows 补丁流程，设置 `VPHP_V_FORCE_WINDOWS_PATCH=1`；否则仅在检测到 Windows 时启用。
- **OpenSSL 开关**：通过 `VPHP_V_USE_OPENSSL=0|false|no|off` 禁用 OpenSSL 相关特性；默认开启。
- **VSChannel 开关**：通过 `VPHP_V_NO_VSCHANNEL=1` 禁用 VSChannel 通道（调试/隔离场景）。
- **自定义 C 编译器**：通过 `VPHP_V_CC=msvc|clang|gcc` 覆盖 V 使用的 C 编译器。
- **仅生成 C 不链接**：使用 `make emit-only`，便于 CI 中单独缓存转译产物。
- **分发制品**：使用 `make dist` / `make dist-source`，结合 `ARTIFACT_VERSION`、`ARTIFACT_PLATFORM`、`PACKAGE_FORMAT` 变量产出 zip/tar 包。
- **模板项目**：新建应用后直接 `make serve` / `make vhttpd`，无需手写 PHP 启动命令。
