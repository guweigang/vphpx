# 回归用例

保留历次为 VPHP、VSlim 和 vhttpd worker 集成补充的回归用例。临时脚本可以用来定位问题，验证过的场景和断言要落到仓库现有的测试入口。可以合并重复的准备代码，合并后仍须覆盖原有场景和断言。

- VPHP 编译器测试使用 `v -path "$PWD:@vlib" test vphp/compiler`，扩展 PHPT 使用 `make -C vphptest test`。
- VPHP CLI 的外部扩展、PHP 版本差异、Reflection 和 stub 用例由 `sh cmd/vphp/tests/smoke.sh` 运行。验证真实 worker 时，设置 `VHTTPD_ROOT` 指向本机的 vhttpd 源码目录。该入口会额外运行 HTTP、流式响应和 SSE 用例，包括客户端断开、分层捕获和重抛，以及同一 worker PID 的后续请求。
- VSlim 使用 `make -C vslim test` 运行架构边界扫描和 PHPT。验证全量 worker 集成时设置 `VSLIM_INCLUDE_RUNTIME_TESTS=1`，并准备对应的本地测试依赖。
