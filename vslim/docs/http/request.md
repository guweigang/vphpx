# VSlim\Request

`VSlim\Request` 是 VSlim 的轻量请求对象。它不是完整 PSR-7 实现，但足够覆盖 VSlim 自己的 runtime 路由与 worker 集成。

真理之源：

- [`src/request.v`](/Users/guweigang/Source/vphpx/vslim/src/request.v)
- [`tests/test_vslim_request_input.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_request_input.phpt)
- [`tests/test_vslim_request_body_format.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_request_body_format.phpt)
- [`tests/test_vslim_request_trace_ids.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_request_trace_ids.phpt)

## 基本字段

公开字段包括：

- `method`
- `raw_path`
- `path`
- `body`
- `query_string`
- `scheme`
- `host`
- `port`
- `protocol_version`
- `remote_addr`

最常见的构造方式：

```php
$req = new VSlim\Request('POST', '/users/7?trace_id=demo', 'name=neo');
```

默认值：

- `scheme = http`
- `protocol_version = 1.1`
- 其它环境字段默认为空

## setter

可链式设置：

- `set_query()`
- `set_method()`
- `set_target()`
- `set_body()`
- `set_scheme()`
- `set_host()`
- `set_port()`
- `set_protocol_version()`
- `set_remote_addr()`
- `set_headers()`
- `set_cookies()`
- `set_attributes()`
- `set_server()`
- `set_uploaded_files()`
- `set_params()`

示例：

```php
$req = new VSlim\Request('POST', '/submit?from=query', '{"ok":"yes"}');
$req->set_headers(['content-type' => 'application/json']);
$req->set_cookies(['sid' => 'cookie-1']);
$req->set_attributes(['trace_id' => 'attr-trace']);
```

## query helpers

- `query($key)`
- `query_params()`
- `query_all()`
- `has_query($key)`

```php
echo $req->query('trace_id');
```

如果没有显式 `set_query()`，VSlim 会从 `raw_path` 自动解析 query string。

## input helpers

`input()` 读取“query + parsed body”的合并结果，并且 body 会覆盖 query 同名字段。

支持：

- `input($key)`
- `input_or($key, $default)`
- `has_input($key)`
- `all_inputs()`
- `parsed_body()`

示例：

```php
$req = new VSlim\Request('POST', '/submit?from=query', 'from=body&n=1');
$req->set_headers(['content-type' => 'application/x-www-form-urlencoded']);

echo $req->input('from'); // body
echo $req->has_input('n') ? 'yes' : 'no';
```

## body 解析

### body 格式识别

`body_format()` 当前可能返回：

- `json`
- `form`
- `multipart`
- `none`

### JSON / 表单 / multipart

可用方法：

- `is_json_body()`
- `is_form_body()`
- `is_multipart_body()`
- `json_body()`
- `form_body()`
- `multipart_body()`

识别逻辑：

- 看 `content-type`
- 如果没有 `content-type`，会做兼容性猜测
  - body 以 `{` / `[` 开头时，按 JSON
  - body 包含 `=` 时，按表单

## 解析错误

如果是 JSON body，可以用 `parse_error()` 检查错误：

```php
$req = new VSlim\Request('POST', '/x', '{bad');
$req->set_headers(['content-type' => 'application/json']);
echo $req->parse_error();
```

`App` 在 dispatch 时也会自动利用这个能力，对非法 JSON 返回 `400`。

## headers / cookies / params / attributes / server

### header

- `header($name)`
- `headers()`
- `headers_all()`
- `has_header($name)`
- `content_type()`

header 名会被规范化成小写。

### cookie

- `cookie($name)`
- `cookies()`
- `cookies_all()`
- `has_cookie($name)`

### route params

- `param($name)`
- `route_params()`
- `params_all()`
- `has_param($name)`

### attributes

- `attribute($name)`
- `attributes()`
- `attributes_all()`
- `has_attribute($name)`

### server params

- `server_value($name)`
- `server_params()`
- `server_all()`
- `has_server($name)`

## 上传文件

支持：

- `uploaded_file_count()`
- `uploaded_files()`
- `uploaded_files_all()`
- `has_uploaded_files()`

当前 `uploaded_files()` 返回的是文件名字符串列表，不是复杂上传对象。

## trace id / request id

### `request_id()`

优先级：

1. `x-request-id`
2. attribute `request_id`
3. query `request_id`

### `trace_id()`

优先级：

1. `x-vhttpd-trace-id`
2. `x-trace-id`
3. query `trace_id`
4. attribute `trace_id`
5. 回退到 `request_id()`

这也是 worker / tracing 集成的重要入口。

## `is_secure()`

```php
$req->set_scheme('https');
var_dump($req->is_secure()); // true
```

## 常见注意事项

- `input()` 不是只读 body，它是“query + body”的合并视图
- header 名大小写不敏感，内部统一转小写
- `set_target()` 会自动更新 `path` 和 `query_string`
- `Request` 不是不可变对象；可以直接改字段或 setter

