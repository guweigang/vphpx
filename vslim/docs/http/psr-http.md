# Native PSR HTTP Surface

这页只描述 `vslim` 目前已经原生提供的 `PSR-7 / PSR-17` 能力，不把 roadmap 和 bridge 混在一起。

## Current Native Types

当前已经落地的原生对象有：

- `VSlim\Psr7\Stream`
  - 实现 `Psr\Http\Message\StreamInterface`
- `VSlim\Psr7\Response`
  - 实现 `Psr\Http\Message\ResponseInterface`
- `VSlim\Psr7\Request`
  - 实现 `Psr\Http\Message\RequestInterface`
- `VSlim\Psr7\ServerRequest`
  - 实现 `Psr\Http\Message\ServerRequestInterface`
- `VSlim\Psr7\Uri`
  - 实现 `Psr\Http\Message\UriInterface`
- `VSlim\Psr7\UploadedFile`
  - 实现 `Psr\Http\Message\UploadedFileInterface`

当前已经落地的原生 factory 有：

- `VSlim\Psr17\ResponseFactory`
  - 实现 `Psr\Http\Message\ResponseFactoryInterface`
- `VSlim\Psr17\RequestFactory`
  - 实现 `Psr\Http\Message\RequestFactoryInterface`
- `VSlim\Psr17\ServerRequestFactory`
  - 实现 `Psr\Http\Message\ServerRequestFactoryInterface`
- `VSlim\Psr17\StreamFactory`
  - 实现 `Psr\Http\Message\StreamFactoryInterface`
- `VSlim\Psr17\UploadedFileFactory`
  - 实现 `Psr\Http\Message\UploadedFileFactoryInterface`
- `VSlim\Psr17\UriFactory`
  - 实现 `Psr\Http\Message\UriFactoryInterface`

## What This Means

现在 `vslim` 已经不只是“能桥接外部 PSR-7 对象”。

它已经能原生构造并返回一部分标准 HTTP message 对象：

- response
- stream
- request
- server request
- uri
- uploaded file

这对两个方向都重要：

- 给后续 `ServerRequestInterface` / `ServerRequestFactoryInterface` 打基础
- 让 `vslim` 不再完全依赖第三方 PSR-17 factory 才能进入 PSR middleware 生态

## Usage Sketch

```php
<?php

$responseFactory = new VSlim\Psr17\ResponseFactory();
$streamFactory = new VSlim\Psr17\StreamFactory();
$uriFactory = new VSlim\Psr17\UriFactory();

$uri = $uriFactory->createUri('https://api.example.com/v1/users?page=2');
$body = $streamFactory->createStream('hello');

$response = $responseFactory
    ->createResponse(200)
    ->withHeader('Content-Type', 'text/plain')
    ->withBody($body);
```

## Scope Boundary

这一步已经不是“只够演示”的覆盖了，`PSR-7 / PSR-17` 主对象和 factory 的核心 contract 已经能原生闭环。

已完成：

- `ResponseInterface`
- `StreamInterface`
- `RequestInterface`
- `ServerRequestInterface`
- `UriInterface`
- `UploadedFileInterface`
- `RequestFactoryInterface`
- `ServerRequestFactoryInterface`
- `ResponseFactoryInterface`
- `StreamFactoryInterface`
- `UploadedFileFactoryInterface`
- `UriFactoryInterface`

说明：

- `ServerRequestInterface` 现在已经可用
- `uploadedFiles` 现在可以携带原生 `UploadedFileInterface` 对象和嵌套 tree 结构
- `attributes` / `parsedBody` 已经保留 mixed 数据，不再被强制压平为字符串
- `serverParams` / `cookieParams` / `queryParams` 现在保留数组结构，不再退化成字符串 map
- `getHeaders()` 现在保留原始 header name 大小写，同时继续支持大小写不敏感读取
- `withMethod()`、`createRequest()`、`createServerRequest()`、`withRequestTarget()` 这些入口已经开始拒绝明显非法的 method / target 输入
- 仍然不建议现在就对外宣称“所有 PSR-7/17 edge case 已完全对齐”，但主链路 contract 已经明显从 bridge/adapter 阶段走到了 native implementation 阶段

## Relationship To Other Docs

- 如果你关注长期方向，看 [../psr-roadmap.md](/Users/guweigang/Source/vphpx/vslim/docs/psr-roadmap.md)
- 如果你关注现有 bridge，看 [../psr7_bridge.md](/Users/guweigang/Source/vphpx/vslim/docs/psr7_bridge.md)
- 如果你关注 worker / envelope 集成，看 [../integration/psr7.md](/Users/guweigang/Source/vphpx/vslim/docs/integration/psr7.md)
