# VSlim\View

`VSlim\View` 是 VSlim 内置的运行时模板引擎。当前实现已经不是简单的字符串替换器，而是基于：

- 模板 token 流
- 模板 AST
- 表达式 AST
- 条件 AST
- 带位置的 debug 诊断
- 模板与 AST 缓存

当前实现分布在这些文件中：

- [`src/view.v`](/Users/guweigang/Source/vphpx/vslim/src/view.v)
- [`src/view_ast.v`](/Users/guweigang/Source/vphpx/vslim/src/view_ast.v)
- [`src/view_cache_parse.v`](/Users/guweigang/Source/vphpx/vslim/src/view_cache_parse.v)
- [`src/view_render.v`](/Users/guweigang/Source/vphpx/vslim/src/view_render.v)
- [`src/view_condition.v`](/Users/guweigang/Source/vphpx/vslim/src/view_condition.v)
- [`src/view_expr.v`](/Users/guweigang/Source/vphpx/vslim/src/view_expr.v)
- [`src/view_runtime.v`](/Users/guweigang/Source/vphpx/vslim/src/view_runtime.v)
- [`src/view_data_reduce.v`](/Users/guweigang/Source/vphpx/vslim/src/view_data_reduce.v)

主要回归测试：

- [`tests/test_vslim_mvc_view_controller.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_mvc_view_controller.phpt)
- [`tests/test_vslim_view_layout_include.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_view_layout_include.phpt)
- [`tests/test_vslim_view_control_flow.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_view_control_flow.phpt)
- [`tests/test_vslim_view_helpers.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_view_helpers.phpt)
- [`tests/test_vslim_view_include_params.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_view_include_params.phpt)
- [`tests/test_vslim_view_debug_tokens.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_view_debug_tokens.phpt)

## 语法分层

当前 View 可以按三层理解：

1. 指令
2. 表达式
3. 变量路径

### 指令

当前支持的指令：

- `include`
- `if`
- `for`
- `slot`
- `fill`
- `call`
- `call_raw`
- `asset`
- `raw`

代表写法：

```html
{{include:card.html|title=page_title,note="hello"}}
{{if:|status == "published"}}<p>Published</p>{{/if}}
{{for:tags}}<li>{{item}}</li>{{/for}}
{{slot:content}}
{{fill:sidebar}}Menu{{/fill}}
{{call:wrap|name, "!"}}
{{call_raw:html_badge|name}}
{{asset:app.js}}
{{raw:payload}}
```

### 表达式

当前支持的表达式形式：

- 变量：`{{ title }}`
- 路径：`{{ user.name }}`
- 索引：`{{ tags[0] }}`
- 函数调用：`{{ trim(title) }}`
- pipe 链：`{{ title | trim | upper }}`
- helper 调用：`{{ wrap(name, "!") }}`
- helper pipe：`{{ name | wrap("!") }}`
- 对象方法：`{{ user.display_name() }}`
- 方法结果继续 pipe：`{{ user.greet("Hi", "?") | upper }}`

### 变量路径

当前支持的路径能力：

- 标量 key：`title`
- dot-path：`user.name`
- list index：`tags[0]`
- 嵌套路径：`user.profile.skills[1]`
- 循环上下文：`item`、`index`、`item.name`

## 创建与配置

### 通过 `App`

```php
$app = new VSlim\App();
$app->set_view_base_path(__DIR__ . '/views');
$app->set_assets_prefix('/assets');

$view = $app->make_view();
```

### 直接创建

```php
$view = new VSlim\View(__DIR__ . '/views', '/assets');
```

### 基本 API

- `set_base_path()`
- `base_path()`
- `set_assets_prefix()`
- `assets_prefix()`
- `set_cache_enabled()`
- `cache_enabled()`
- `clear_cache()`
- `asset($path)`
- `render($template, $data): string`
- `render_with_layout($template, $layout, $data): string`
- `render_response($template, $data): VSlim\Vhttpd\Response`
- `render_response_with_layout($template, $layout, $data): VSlim\Vhttpd\Response`

通过 `App` 也可以直接调用：

- `view()`
- `view_with_layout()`
- `set_view_cache()`
- `view_cache_enabled()`
- `clear_view_cache()`
- `helper()`

### 模板缓存

模板缓存默认读取环境变量 `VSLIM_VIEW_CACHE`。

- 开发环境建议关闭
- 生产环境建议开启

```php
$app->set_view_cache(true);

$view = $app->make_view();
$view->set_cache_enabled(false);
```

## 最简单模板

```html
<h1>{{ title | trim }}</h1>
<p>{{ name | trim }}</p>
<p>{{ default(trace, "n/a") }}</p>
<script src="{{ asset("app.js") }}"></script>
```

## 转义规则

- `{{ expr }}` 默认 HTML escape
- `{{call:...}}` 默认 HTML escape
- `{{call_raw:...}}` 不 escape
- `{{raw:key}}` 不 escape

```html
<div>{{ payload }}</div>
<div>{{raw:payload}}</div>
<div>{{call:wrap|name}}</div>
<div>{{call_raw:html_badge|name}}</div>
```

## 支持的全部写法

### 1. 变量与路径

```html
{{ title }}
{{ user.name }}
{{ tags[0] }}
{{ user.profile.skills[1] }}
```

### 2. 表达式函数与 pipe

```html
{{ trim(title_spaced) }}
{{ first(tags) }}
{{ last(tags) }}
{{ tags | join(", ") }}
{{ default(missing_title, "Anonymous") }}
{{ scores | reduce("sum") }}
{{ scores | reduce("acc+item", 10) }}
{{ title | trim | upper }}
{{ asset("app.js") }}
{{ "css/site.css" | asset }}
```

### 3. 对象方法与 helper

```html
{{ user.display_name() }}
{{ user.greet("Hi", "?") }}
{{ user.greet("Hi", "?") | upper }}
{{ wrap(name, "!") }}
{{ name | wrap("?") }}
```

### 4. `if` 指令

主语法：

```html
{{if:|status == "published"}}<p>Published</p>{{/if}}
{{if:|status != "draft"}}<p>Visible</p>{{/if}}
{{if:|profile.age >= 18}}<p>Adult</p>{{/if}}
{{if:|(status == "published" && profile.age >= 18) || is_ready}}<p>Complex</p>{{/if}}
{{if:|!empty(nickname)}}<p>{{ title }}</p>{{/if}}
{{if:|user.display_name() == "NEO"}}<p>Method</p>{{/if}}
```

也支持这些 sugar 写法：

```html
{{if:show_title}}<h1>{{ title }}</h1>{{/if}}
{{if:show_desc}}<p>{{ desc }}</p>{{else}}<p>NO-DESC</p>{{/if}}
{{if:eq|title, "Hello"}}<p>EQ</p>{{/if}}
{{if:ne|title, "World"}}<p>NE</p>{{/if}}
{{if:contains|title, "ell"}}<p>Contains Text</p>{{/if}}
{{if:contains|tags, "php"}}<p>Contains List</p>{{/if}}
{{if:in|title, list(allowed_titles)}}<p>In</p>{{/if}}
{{if:not_in|title, "World,Other"}}<p>Not In</p>{{/if}}
{{if:empty|missing_title}}<p>Empty</p>{{/if}}
{{if:not_empty|title}}<p>Not Empty</p>{{/if}}
```

`if:|expr` 当前支持：

- 比较：`== != > < >= <=`
- 逻辑：`&& || !`
- 括号
- 函数调用
- 对象方法调用
- 变量路径与索引
- `empty(...)`
- `contains(...)`
- `in(...)`
- `int(...)` / `float(...)` / `bool(...)` / `string(...)` / `list(...)` / `map(...)`

### 5. `for` 指令

```html
<ul>
{{for:tags}}<li data-i="{{index}}">{{item}}</li>{{/for}}
</ul>
```

循环体内可用：

- `{{item}}`
- `{{index}}`
- `{{item.name}}`
- 其他外层上下文变量仍然可见

### 6. `include`

```html
{{include:partial.html}}
{{include:partial.html|title=page_title,note="hello"}}
{{include:partial.html|title=page_title,note="hello",items=list(tags)}}
{{include:partial.html|user_copy=map(user)}}
{{include:partial.html|profile=map(user.profile)}}
{{include:partial.html|age=int(profile.age),ready=bool(is_ready)}}
```

规则：

- 第一个 `|` 表示进入参数区
- 参数区推荐用逗号分隔
- `key=value` 把局部变量传给 partial
- `value` 可以是普通表达式
- `list(tags)` 会作为局部列表传入
- `map(user)` 会把 `user.*` 子树重建到局部前缀下
- `map(user.profile)` 支持更细的子树别名

### 7. `slot` / `fill` / layout

主模板：

```html
{{fill:sidebar}}Menu{{/fill}}
<h1>{{ title | trim }}</h1>
{{fill:footer}}Copyright{{/fill}}
```

layout：

```html
<html>
  <body>
    <nav>{{slot:nav|Menu}}</nav>
    <aside>{{slot:sidebar}}</aside>
    <main>{{slot:content}}</main>
    <footer>{{slot:footer}}</footer>
  </body>
</html>
```

规则：

- 普通正文会流入默认 `content` slot
- `{{fill:name}}...{{/fill}}` 会写入 `{{slot:name}}`
- 同一个 slot 可以多次 `fill`，按顺序追加
- `{{slot:name|fallback}}` 可提供默认内容
- 未填充且无 fallback 的 slot 渲染为空字符串

### 8. helper 指令

```html
{{call:wrap|name, "!"}}
{{call:wrap|name, "?"}}
{{call:user_card|map(user)}}
{{call:sum|1,2.5,true}}
{{call:sum|int(age),float(ratio),bool(is_ready),string(age)}}
{{call:csv|list(tags)}}
{{call_raw:html_badge|name}}
```

规则：

- `{{call:...}}` 对结果做 escape
- `{{call_raw:...}}` 不 escape
- 参数区是表达式参数区
- 支持普通表达式、字面量、类型函数、`list(...)`、`map(...)`
- 已注册 helper 也能直接用表达式形式：`{{ wrap(name, "!") }}`、`{{ name | wrap("!") }}`

### 9. `asset` 与 `raw`

```html
<script src="{{asset:app.js}}"></script>
<script src="{{ asset("app.js") }}"></script>
<div>{{raw:payload}}</div>
```

### 10. 类型函数

当前支持这些类型/结构函数：

- `int(...)`
- `float(...)`
- `bool(...)`
- `string(...)`
- `list(...)`
- `map(...)`

示例：

```html
{{ int(age) }}
{{ string(age) }}
{{if:|int(age) > 18}}Adult{{/if}}
{{if:in|title, list(allowed_titles)}}Allowed{{/if}}
{{call:demo|int(age),float(ratio),bool(is_ready),string(name)}}
{{include:card.html|items=list(tags),user_copy=map(user)}}
```

说明：

- `list(...)` 常用于 `if:in`、helper 调用、include 传参
- `map(...)` 常用于 helper 调用与 include 子树重建
- 当前不支持 `object(...)` 原始对象直传

## 最复杂的 `for` / `if` 嵌套示例

下面这个例子同时覆盖：

- `if` 套 `if`
- `if` 套 `for`
- `for` 套 `if`
- `for` 套 `for`
- 条件表达式
- `item` / `index` / 外层上下文混用

```html
<section id="dashboard-groups">
{{if:|outer_flag && user.display_name() == "NEO"}}
  {{if:inner_flag}}
    <header>{{ title | trim | upper }}</header>
  {{/if}}

  {{if:show_matrix}}
    <div class="matrix">
      {{for:matrix}}
        <b data-i="{{index}}">{{item}}</b>
      {{/for}}
    </div>
  {{/if}}

  <div class="rows">
    {{for:rows}}
      {{if:|item.visible && item.name != "smith"}}
        <article data-row="{{index}}">
          <h3>{{ item.name | upper }}</h3>

          {{if:|in(item.role, list(allowed_roles))}}
            <p class="role-ok">{{ item.role }}</p>
          {{else}}
            <p class="role-bad">blocked</p>
          {{/if}}
        </article>
      {{/if}}
    {{/for}}
  </div>

  <div class="groups">
    {{for:group_labels}}
      <section class="group">
        <h4>{{item}}</h4>
        <ul>
          {{for:group_members}}
            {{if:not_empty|item}}
              <li>{{ item | trim }}</li>
            {{/if}}
          {{/for}}
        </ul>
      </section>
    {{/for}}
  </div>
{{/if}}
</section>
```

如果对应数据是：

```php
[
    'outer_flag' => true,
    'inner_flag' => true,
    'title' => 'Team Board',
    'show_matrix' => true,
    'matrix' => ['A', 'B'],
    'allowed_roles' => ['captain', 'pilot'],
    'rows' => [
        ['name' => 'neo', 'visible' => true, 'role' => 'captain'],
        ['name' => 'smith', 'visible' => true, 'role' => 'agent'],
        ['name' => 'trinity', 'visible' => true, 'role' => 'pilot'],
    ],
    'group_labels' => ['Core'],
    'group_members' => ['neo', 'trinity'],
    'user' => $user,
]
```

这类模板在当前 View 里是正式支持的，相关回归可以参考：

- [`tests/test_vslim_view_control_flow.phpt`](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_view_control_flow.phpt)

## Debug

设置环境变量 `VSLIM_VIEW_DEBUG=1` 后，开发态会尽量把常见错误渲染成可见占位符。

当前会显示 debug 占位符的场景包括：

- helper 不存在或不可调用
- 表达式里的对象方法不存在
- pipe helper 不存在
- `include` 指向的模板不存在
- 顶层模板不存在
- layout 模板不存在
- `reduce(...)` 求值失败

占位符会尽量带上：

- `template`
- `token`
- `line`
- `col`

例如：

```text
[vslim.helper.missing template=/abs/path/debug.html token=missing_helper line=2 col=21]
[vslim.method.missing template=/abs/path/debug.html token=user.missing_method() line=3 col=21]
[vslim.helper.missing template=/abs/path/debug.html token=missing_pipe line=4 col=28]
[vslim.include.missing template=/abs/path/debug.html token=missing_partial.html line=5 col=1]
[vslim.layout.missing template=/abs/path/missing_layout.html token=missing_layout.html]
[vslim.template.missing template=/abs/path/missing_template.html token=missing_template.html]
```

## 推荐做法

- 用 `App->set_view_base_path()` 统一配置模板目录
- 开发环境关闭缓存，生产环境开启缓存
- 默认使用 `{{ expr }}`，只在明确需要时用 `{{raw:key}}` 或 `{{call_raw:...}}`
- 复杂业务逻辑优先在 PHP 层准备好数据，模板只做轻量结构和展示
- 条件主语法优先用 `{{if:|expr}}`，sugar 写法只在更短更清楚时使用
