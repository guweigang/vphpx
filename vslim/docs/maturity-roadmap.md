# VSlim Maturity Roadmap

这页不是功能清单，而是成熟度清单。

它回答的是：

- `VSlim` 现在离“简单成熟的扩展级框架”还有哪些差距？
- 这些差距里，哪些最值得优先补？

## 当前判断

如果按“轻量、可长期写业务、扩展级、和 `vhttpd` 原生协同”这个目标来评估：

- 轻量级：已经成立
- 框架主体：已经成立
- 成熟度：正在最后一轮产品化收口

更直白一点：

- 现在已经不是 demo
- 也不只是底层技术预研
- 但还没到“所有边角都磨平”的程度

## 已经成型的部分

- HTTP / CLI 双入口
- route / middleware / controller / module / provider
- PSR-first request / response 主通道
- stream / websocket / MCP 原生形态
- `vhttpd` worker / envelope / adapter 集成
- config 系统
- database manager / query / model
- migration / seed
- `direct` / `vhttpd_upstream` 两条数据库路径
- validate
- session / auth / guest / ability middleware
- testing harness
- template generators
- `config:check` / `app:doctor`

## 还值得继续补的 5 件事

### 1. 发布与安装体验

这是现在最值得继续磨的一层。

重点包括：

- direct mysql 模式下的原生运行库发现
- bundle 解压后的最短运行说明
- Windows / macOS / Linux 的运行时差异说明
- `direct` 和 `vhttpd_upstream` 的推荐策略进一步稳定

### 2. Auth 再补半层

现在 auth 已经够用，但还不算“非常成熟”。

最值得继续补的是：

- guard 配置体验
- remember/login flow
- policy 组织方式
- auth template 示例再丰富一层

### 3. Schema / Migration 体验

现在 migration / seed 已经成立，但还偏第一版。

可以继续补：

- 更顺手的 schema helper
- migration 生成样板再丰富一层
- 更清晰的 migration lifecycle 文档

### 4. 异常与错误输出统一

这条已经做了不少，但还有继续统一的空间。

继续方向包括：

- 更多数据库/运行时异常前缀归一化
- auth / validate / database / config error 的统一输出约定
- JSON / HTML / CLI 三种场景的差异再讲清楚

### 5. 文档与模板继续收口

现在文档已经比前面清楚很多，但还可以继续压缩心智负担。

最值钱的是：

- 保持 README / OVERVIEW / capabilities / operations / template README 一致
- 给新用户一条更短、更明确的“从复制模板到上线”的路径

## 推荐优先级

如果后面继续做，我建议按这个顺序：

1. 发布与安装体验
2. Auth 再补半层
3. Schema / Migration 体验
4. 异常与错误输出统一
5. 文档与模板继续收口

## 对当前状态的一句话结论

`VSlim` 现在已经有了“框架主体”，后面主要做的是“成熟化”，不是“从零开始补大功能”。
