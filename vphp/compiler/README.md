# VPHP Compiler Docs

This directory contains the VPHP compiler implementation and its design documents.

Project overview:

- [../docs/OVERVIEW.md](../docs/OVERVIEW.md)

## Start Here

If you are new to the compiler, read these in order:

1. [docs/architecture.md](docs/architecture.md)
2. [docs/repr.md](docs/repr.md)
3. [docs/class_shadows.md](docs/class_shadows.md)
4. [docs/builder.md](docs/builder.md)
5. [docs/emission_pipeline.md](docs/emission_pipeline.md)

## Standalone Extension CLI

Put this checkout's `bin` directory on `PATH` to use `vphp` from an
extension project. The launcher uses the `v` on `PATH` on every run.
The project declares its name and version in `vphp.ExtensionConfig` and
marks exports with the usual VPHP attributes.

```sh
vphp check /path/to/extension
vphp build /path/to/extension
vphp stub /path/to/extension --output /path/to/extension/extension.stub.php
```

The project directory defaults to the current directory. The entry V files
live at its root, with local V modules in subdirectories. The tool stages
sources and writes the shared library or stub to `build/` by default.
`check` compiles and links in that staging directory without publishing an
artifact. Generated bridge files stay in staging.

The builder targets macOS and Linux with a local C compiler and PHP
development headers. Set `VPHP_PHP_CONFIG` to select the PHP SDK,
`VPHP_PHP` to select the matching PHP executable for stub generation,
`VPHP_CC` to select the C compiler, or `VPHP_V_GC` to choose a V GC mode.
`stub` reflects the built extension and syntax-checks the PHP output before
publishing it.

## Implementation Layout

Builds use the V executable selected by the caller. The binding generator reads
declarations through the installed V compiler's flat AST API. After upgrading V,
run `make -C vphptest test` to check code generation, extension loading, and PHP
interop with that installation.

```text
vphp/compiler/
  entry.v               # compile pipeline entry
  export.v              # export assembly and file emission
  c_emitter.v           # C wrapper emission
  v_glue.v              # V bridge emission
  php_types/            # shared PHP-facing type/spec mapping
  repr/                 # compiler representations
  syntax/               # V flat AST -> binding syntax
  parser/               # binding syntax -> repr
  linker/               # post-parse linking
  builder/              # repr -> export fragments
```

## Quick Map

### Core pipeline

- [entry.v](entry.v)
- [export.v](export.v)
- [c_emitter.v](c_emitter.v)
- [v_glue.v](v_glue.v)

### Submodules

- `repr`
  - internal compiler representations

- `parser`
  - V AST parsing into reprs

- `linker`
  - post-parse reconciliation such as class shadow linking

- `builder`
  - reusable export/code fragment builders

## Recommended Reading By Task

### I want to understand the whole compiler

Read:

1. [docs/architecture.md](docs/architecture.md)
2. [docs/emission_pipeline.md](docs/emission_pipeline.md)

### I want to add a new parsed feature

Read:

1. [docs/repr.md](docs/repr.md)
2. `parser/`
3. [docs/architecture.md](docs/architecture.md)

### I want to change class static/class const shadow behavior

Read:

1. [docs/class_shadows.md](docs/class_shadows.md)
2. [v_glue.v](v_glue.v)
3. [c_emitter.v](c_emitter.v)

### I want to change export/code generation

Read:

1. [docs/builder.md](docs/builder.md)
2. [docs/emission_pipeline.md](docs/emission_pipeline.md)

Important:

- `docs/emission_pipeline.md` now documents return-shape classification for
  `@[php_method]`, including container returns like `map[string]string` and
  `[]string`

## Ownership-facing Defaults

For new exported APIs, prefer ownership-aware wrapper types in signatures:

- `RequestBorrowedZBox`
- `RequestOwnedZBox`
- `PersistentOwnedZBox`

Treat these as the compiler-facing default vocabulary.

In practice:

- parameter signatures should prefer `RequestBorrowedZBox`
- temporary owned results inside glue should prefer `RequestOwnedZBox`
- long-lived stored values should prefer `PersistentOwnedZBox`

## Exporting Types, Functions, and Methods

Use `@[vphp.PhpExportClass(name: 'My\\Project\\Widget')]` on a struct,
`@[vphp.PhpExportInterface(name: 'My\\Project\\Contract')]` on an interface,
and `@[vphp.PhpExportEnum(name: 'My\\Project\\Kind')]` on an enum.
Pass `name: ''` to use the V declaration name. Existing `@[php_class]`,
`@[php_interface]`, and `@[php_enum]` declarations are also supported.

Mark a composable V struct with `@[vphp.PhpTrait]` and embed it in an
exported class. Its PHP properties and exported methods are composed into
the class, whose own members take precedence. Existing `@[php_trait]`
declarations are also supported.

Use `@[vphp.PhpClassAttribute(name: 'My\\Project\\Handler', args: '"http"')]`
to attach a PHP attribute to an exported class. Use `PhpInterfaceAttribute`
and `PhpEnumAttribute` with the same fields on exported interfaces and enums.
The `args` string accepts positional and named scalar arguments. Numeric
arguments must match a complete numeric literal, so `42ms` remains a string
and `1e3` becomes a float. Quote numeric-looking text to preserve its spelling.
Separate arguments with commas. Quote text containing whitespace, brackets,
colons, quote characters, or equals signs.
Quoted arguments accept escaped quotes and backslashes, and `\uXXXX` or
`\UXXXXXXXX` for Unicode. The outer V string is decoded first, so use
`args: 'text: "\\u96EA"'` to pass the Unicode escape to the attribute parser.
Unknown escapes inside an argument retain their backslashes.
Arrays use PHP bracket syntax, such as `[1, "group" => [2, 3]]`.
They can be positional or named arguments and can contain nested arrays.
Use integer or string keys, or omit the key to append an element.
An empty string denotes no arguments. Existing `@[php_attr]` declarations are
also supported.

Use `@[vphp.PhpParameterAttribute(v_name: 'value', name: 'My\\Project\\Input', args: '')]`
on a function or method to attach a PHP attribute to the named V parameter.
The attribute follows that parameter's PHP name in Reflection and stubs.
Existing `@[php_param_attr]` mappings also support multiple attributes or
parameters in one declaration.

Use `@[vphp.PhpCallableAttribute(name: 'My\\Project\\Audit', args: 'level: 2')]`
to attach a PHP attribute to the exported function or method itself.

Use `@[vphp.PhpExtends(name: 'Exception')]` to declare a class parent.
`@[vphp.PhpImplements(names: 'My\\Project\\Contract')]` declares class interfaces,
and `@[vphp.PhpExtendsInterfaces(names: 'My\\Project\\BaseContract')]` declares
interface parents. The `names` fields accept a comma-separated list. Existing
`@[php_extends]` and `@[php_implements]` declarations are also supported.

Put `@[vphp.PhpProperty(name: 'captionText')]` on a struct field to
set its PHP property name. The field keeps its V type, visibility, and
mutability. Existing property name mappings remain supported.
`@[vphp.PhpIgnoreField]` keeps a field out of the PHP properties.
`@[vphp.PhpStaticProperty]` declares a static PHP property and can be used
with `PhpProperty` to set its name. Existing field-level `@[php_ignore]`
and `@[php_static]` declarations are also supported.

Use `@[vphp.PhpPropertyAttribute(name: 'My\\Project\\Audit', args: 'level: 2')]`
on a V field to attach a PHP attribute to its exported property. It can be
combined with `PhpProperty` and `PhpStaticProperty`. PHP Reflection and the
generated stub expose the attribute on the resulting property.

Put `@[vphp.PhpDeclaredProperty(name: 'requestRef', v_type: 'mixed')]`
on an exported struct to declare a public writable PHP property without
a V field. This uses the same property types and defaults as the existing
class-level `@[php_prop]` declaration.

Use `@[vphp.PhpClassConstants(source: 'my_constants')]` to export fields from
a V constant struct as PHP class constants. Annotate those fields with
`@[vphp.PhpClassConstantAttribute(name: 'My\\Project\\Audit', args: 'level: 2')]`
to attach a PHP attribute. Use `PhpEnumCaseAttribute` with the same fields
on a case in an exported V enum. Reflection and the generated stub expose
the metadata on the corresponding constant or case.

Use `@[vphp.PhpClassStatics(source: 'my_statics')]` to bind a V constant struct
with mutable fields to PHP static properties. Existing class-level
`@[php_const]` and `@[php_static]` declarations are also supported.

Put `@[vphp.PhpExportConstant]` on a V scalar constant to export it as a
PHP global constant. For example, `const max_retries = 3` is exported as
`MAX_RETRIES` with value `3` and type `int`. The global `@[php_const]`
spelling is also supported.

Mark the extension's Zend module globals struct with `@[vphp.PhpGlobals]`.
Use `vphp.get_globals[T]()` to read the active storage and
`vphp.with_globals[T](...)` to mutate it. Each extension declares at most
one globals struct. The existing `@[php_globals]` spelling is also supported.

Use `@[vphp.PhpExportTask(name: 'Analyze')]` on a struct implementing
`vphp.ITask` to register its PHP task name. Pass `name: ''` to use the V
struct name. Existing `@[php_task]` declarations are also supported.

Use `@[vphp.PhpExportFunction(name: 'my_function')]` on a function and
`@[vphp.PhpExportMethod(name: 'withUri')]` on a method of an exported class.
Pass `name: ''` to use the V declaration name. Existing `@[php_function]`
and `@[php_method]` declarations are also supported.

Pair `@[vphp.PhpAbstractClass]` with a class export and
`@[vphp.PhpAbstractMethod]` with an instance or static method export.
The method's V signature supplies the PHP abstract method signature.
Existing `@[php_abstract]` declarations are also supported.

Use `@[vphp.PhpBorrowedReturn]` when an exported method returns an existing
V object with borrowed ownership. This uses the same bridge behavior as
`@[php_borrowed_return]`, which remains supported.

Override inferred PHP types with `@[vphp.PhpArgType(v_name: 'value', php_type: 'int|string')]`
or use `PhpArgTypes(types: 'request=ServerRequestInterface,handler=RequestHandlerInterface')`
to declare several overrides on one callable. Use `PhpArgName` to rename
one parameter or `PhpArgNames(names: 'old_name=newName,other_name=otherName')`
to rename several. `PhpArgDefault(v_name: 'offset', default_value: 'SEEK_SET')`
sets a PHP default expression and makes the parameter optional.
`PhpArgDefaults(defaults: 'first=null,second=[]')` declares several defaults
on one callable.
Use `@[vphp.PhpReturnType(php_type: 'int|string')]` to override a return type.
Existing `@[php_arg_type]` mappings are also supported.

## Exported Function Parameter Forms

Exported V functions and methods should use one of five parameter forms. Pick
the narrowest form that matches the API surface you want PHP users to see.

### 1. `vphp.Context`

Use `Context` when the implementation needs the full PHP call frame:

```v
@[php_function]
fn handle(ctx vphp.Context) {
	args := ctx.args_with_meta([
		vphp.PhpArgMeta{
			index: 0
			name:  'payload'
		},
	])
	value := args.at(0).value
	ctx.return().string(value.type_name())
}
```

`Context` is hidden from PHP arginfo. It is the escape hatch for dynamic
argument handling, manual return writes, or direct access to request state.

Use `ctx.args()` when raw argument values are enough. Use
`ctx.args_with_meta(...)` when a manual `Context` function wants to attach
declaration metadata such as names or attributes.

Do not combine `Context` with `PhpArgs`; `PhpArgs` is derived from `Context`.

### 2. V Native Values

Use plain V types when the function wants business values:

```v
@[php_function]
fn add(foo int, bar string, active bool, ratio f64) string {
	return '${foo}:${bar}:${active}:${ratio}'
}
```

The generated glue reads PHP arguments, converts them to V values, and calls the
function with those decoded values.

### 3. PHP Semantic Wrappers

Use semantic wrappers when the implementation wants PHP value semantics without
working at raw `ZVal` level:

```v
@[php_function]
fn inspect(value vphp.PhpValue, obj vphp.PhpObject, arr vphp.PhpArray, cb vphp.PhpCallable) string {
	return '${value.type_name()}:${obj.class_name()}:${arr.count()}:${cb.is_valid()}'
}
```

Supported wrapper parameters include:

- `vphp.PhpValue`
- `vphp.PhpNull`
- `vphp.PhpBool`
- `vphp.PhpInt`
- `vphp.PhpDouble`
- `vphp.PhpString`
- `vphp.PhpScalar`
- `vphp.PhpArray`
- `vphp.PhpObject`
- `vphp.PhpCallable`
- `vphp.PhpResource`
- `vphp.PhpReference`
- `vphp.PhpIterable`
- `vphp.PhpThrowable`
- `vphp.PhpEnumCase`

Optional wrappers are supported:

```v
@[php_function]
fn maybe(obj ?vphp.PhpObject, value ?vphp.PhpValue) string {
	// ?PhpObject is a narrowing wrapper: null/non-object becomes none.
	// ?PhpValue preserves PHP null as some(PhpValue(null)); none means missing.
	return '${obj == none}:${value == none}'
}
```

Use `vphp.PhpReference` in an exported function or method to declare a PHP
reference parameter. Call `deref()` to read the value and `set()` or
`set_value()` to update the caller's variable. The default PHP type is
`mixed`, and `php_arg_type` can specify a narrower type.

```v
@[php_function]
@[php_arg_type: 'cursor=int']
fn advance(cursor vphp.PhpReference) {
	cursor.set(vphp.ZVal.new_int(cursor.deref().to_i64() + 1))
}
```

`?vphp.PhpReference` makes the parameter optional with a default of `null`.
Omitting a trailing positional argument gives V `none`. When a named call
skips that parameter and supplies a later one, PHP can fill the slot with a
temporary reference to the default. Writes to that reference affect only the
call. A supplied variable holding `null` can still receive a new value.
Reference variadics accept positional arguments.

### 4. Lifecycle / Raw Value Escape Hatches

Use these when ownership or raw Zend interop is the point of the API:

```v
@[php_function]
fn low_level(raw vphp.ZVal, borrowed vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.of(raw)
}
```

Supported low-level forms include:

- `vphp.ZVal`
- `vphp.RequestBorrowedZBox`
- `vphp.RequestOwnedZBox`
- `vphp.PersistentOwnedZBox`

These are useful for infrastructure and compatibility code. Prefer semantic
wrappers for application-facing APIs.

### 5. PHP Argument Names

Exported V parameters use PHP-facing names in generated arginfo, stubs, and
named-argument lookup. By default, V `snake_case` parameter names are exported
as PHP `camelCase` names, matching `@[params]` struct fields:

```v
@[php_function]
fn find_user(default_value string) string {
	return default_value
}
```

PHP callers see `$defaultValue` and can call `find_user(defaultValue: 'x')`.
Use `@[php_arg_name: 'v_name=phpName']` only for explicit exceptions.

Argument metadata attributes accept both the legacy string form and V
call-style attributes:

```v
@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default(default_value: '7')]
@[php_arg_optional(default_value: true)]
@[php_arg_type(default_value: 'int')]
@[php_param_attr(default_value: 'FromQuery("default"), MustBeInt')]
@[php_function]
fn read_value(default_value int) int {
	return default_value
}
```

`php_param_attr` attaches PHP 8 attributes to function or method parameters.
The key is the V parameter name, and the value is a comma-separated list of PHP
attributes parsed with the same scalar DSL as class-level `php_attr`:

```v
@[php_param_attr(query: 'FromQuery("q"), MustBeString', page: 'FromQuery("page"), MustBeInt')]
@[php_function]
fn search(query string, page int) string {
	return query
}
```

This produces PHP parameter attributes visible through `ReflectionParameter`.
V does not currently support attributes directly on parameters, so
`php_param_attr` is the parameter-level escape hatch.

The generated glue also carries parameter attributes into `PhpArgMeta`, so
runtime helpers can inspect them from `PhpArg`:

```v
@[php_param_attr(query: 'FromQuery("q"), MustBeString')]
@[php_function]
fn search(query string) string {
	return query
}
```

Inside generated glue this becomes a `PhpArgMeta` entry similar to:

```v
vphp.PhpArgMeta{
	index: 0
	name:  'query'
	attributes: [
		vphp.PhpAttribute.named('FromQuery').for_parameter().string('q'),
		vphp.PhpAttribute.named('MustBeString').for_parameter(),
	]
}
```

For pure `Context` functions, there is no V parameter list for the compiler to
read. Extension authors must provide the metadata explicitly when they need it:

```v
@[php_function]
fn dynamic(ctx vphp.Context) {
	args := ctx.args_with_meta([
		vphp.PhpArgMeta{
			index: 0
			name:  'query'
			attributes: [
				vphp.PhpAttribute.named('FromQuery').string('q'),
				vphp.PhpAttribute.named('Range').int(1).int(100),
			]
		},
	])
	query := args.at(0)
	source := query.attr('FromQuery') or { vphp.PhpAttribute.named('') }
	ctx.return().string_value(source.items[0].value)
}
```

`ctx.args_with_meta(...)` fills missing attribute targets with `.parameter`.
Generated glue writes `.for_parameter()` explicitly so the generated code is
self-describing.

### 6. `@[params]` Structs

Use a params struct when PHP arguments should map to a named/default parameter
object:

```v
@[params]
struct CreateResponseParams {
	status        int    = 200
	reason_phrase string = ''
}

@[php_function]
fn create_response(params CreateResponseParams) string {
	return '${params.status}:${params.reason_phrase}'
}
```

The compiler expands the final `@[params]` struct into PHP-visible arguments,
builds `PhpArgs` in glue, applies V defaults when arguments are omitted, and
then calls the V function with the constructed params struct.

Generated params struct bindings read arguments by PHP parameter name first and
fall back to position. This allows PHP callers to skip optional parameters with
named arguments:

```php
create_response(reasonPhrase: 'Accepted');
```

Params struct fields may use plain V scalar types or semantic PHP wrappers such
as `vphp.PhpString`, `vphp.PhpBool`, and `vphp.PhpArray`. Wrapper fields get
semantic empty defaults and still validate the PHP value when it is supplied.

Do not expose `vphp.PhpArgs` directly as a function parameter. `PhpArgs` is a
glue/runtime model and is available from `Context` via `ctx.args()` or
`ctx.args_with_meta(...)` when a function intentionally enters the low-level
`Context` mode.

## Exported Function Return Forms

Exported V functions and methods should return through one of five forms. Match
the return form to the same semantic layer used by the implementation.

### 1. `vphp.Context` Manual Return

Use `ctx.return()` when the function is already in explicit `Context` mode and
needs to write the PHP return slot manually:

```v
@[php_function]
fn dynamic(ctx vphp.Context) {
	args := ctx.args_with_meta([
		vphp.PhpArgMeta{
			index: 0
			name:  'payload'
		},
	])
	ctx.return().string_value(args.at(0).value.type_name())
}
```

`ctx.return()` returns `vphp.PhpReturn`. It supports direct methods such as
`null()`, `bool_value(...)`, `int_value(...)`, `double_value(...)`,
`string_value(...)`, `value(...)`, `dyn_value(...)`, `request_owned(...)`, and
`zval(...)`.

### 2. V Native Values

Return plain V values when the PHP API should receive decoded business data:

```v
@[php_function]
fn add(foo int, bar int) int {
	return foo + bar
}
```

Supported scalar returns include `string`, `bool`, `int`, `i64`, and `f64`.
Options and results keep their bridge semantics: `?T` maps `none` to PHP `null`,
and `!T` maps errors to PHP exceptions.

### 3. V Containers And Structs

Return V arrays, maps, or structs when the function intentionally returns a PHP
array built from V data:

```v
struct UserPayload {
	name string
	age  int
}

@[php_function]
fn user_payload() UserPayload {
	return UserPayload{ name: 'codex', age: 7 }
}
```

This is a serialization path. It is appropriate for plain V data, not for PHP
semantic wrappers.

### 4. PHP Semantic Wrappers

Return semantic wrappers when the implementation wants to preserve the original
PHP value semantics:

```v
@[php_function]
fn same_object(obj vphp.PhpObject) vphp.PhpObject {
	return obj
}

@[php_function]
fn same_array(arr vphp.PhpArray) vphp.PhpArray {
	return arr
}
```

Supported wrapper returns include the parameter wrappers listed above, plus
`vphp.PhpClass`, `vphp.PhpFunction`, `vphp.PhpClosure`, and persistent wrapper
forms such as `vphp.PhpValue`, `vphp.PhpArray` with persistent-owned storage,
`vphp.PhpObject`, and `vphp.PhpClosure` with persistent-owned storage.

Semantic wrapper returns preserve the wrapped PHP value. They are not serialized
as V structs.

### 5. Lifecycle / Raw Value Returns

Return lifecycle boxes or raw values when ownership is part of the API:

```v
@[php_function]
fn low_level(raw vphp.ZVal) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.of(raw)
}
```

Supported low-level returns include `vphp.ZVal`, `vphp.RequestBorrowedZBox`,
`vphp.RequestOwnedZBox`, and `vphp.PersistentOwnedZBox`.

Prefer semantic wrappers for application-facing APIs. Use lifecycle/raw returns
for infrastructure code, compiler tests, and places where ownership is the
actual behavior being exposed.

## PHP Signature Attributes

The compiler supports a small set of explicit attributes for PHP-facing
signatures. Prefer these over parameter-name heuristics.

- `@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']`
  overrides the PHP arginfo type for a specific parameter.
- `@[php_arg_type: 'a=array,b=Traversable']`
  supports multiple `name=type` entries in one attribute.
- `@[php_arg_default: 'default_status=200,default_reason_phrase=""']`
  sets PHP arginfo defaults and infers that those parameters are optional.
- `@[php_arg_optional: 'default_status,default_reason_phrase']`
  marks trailing PHP-optional parameters explicitly.
- `@[php_param_attr(query: 'FromQuery("q"), MustBeString')]`
  attaches one or more PHP 8 attributes to a parameter.

Notes:

- `php_arg_optional` can also be used on its own or alongside a default.
  `php_arg_optional(name: false)` suppresses default-based optionality.
  PHP's required argument count includes all parameters through the last
  required parameter.
- `php_arg_default` supplies the value used by Reflection and by positional and
  named calls that omit an optional argument. PHP evaluates the arginfo
  expression, including constants and arrays. A supplied value takes precedence,
  including `null` for parameters that accept it.
- `php_arg_type` is most useful for interface/object/array/iterable contracts
  that V cannot express directly in PHP arginfo.
- When a V sum type contains exported classes or enums and supported scalar
  or array variants, generated function and method signatures keep the PHP
  names of the exported variants. An exported enum case matches only its own
  enum, even when multiple variants share the same backing value. Use
  `php_arg_type` and `php_return_type` for explicit PHP unions such as
  `App\\Reader|App\\Writer|int`.
- The same attributes accept PHP intersections such as `Iterator&Countable`
  and DNF types such as `(Iterator&Countable)|ArrayObject|null`. Use a V
  wrapper such as `vphp.PhpValue` for the underlying value. PHP checks the
  declared type at the call boundary and exposes it through Reflection.
- `php_param_attr` supports function and method parameters. Its attribute
  arguments support positional scalar literals, and named scalar literals are
  preserved for PHP attributes and `PhpAttributeItem.name`.
- Be conservative with scalar narrowing (`string`, `int`, `bool`) on exported
  interfaces. If compatibility matters, prefer runtime validation over
  over-constrained arginfo.

## Exported Object Copy Policy

PHP rejects cloning and serialization of classes backed by a VPHP object
payload unless the root exported class opts in with
`@[vphp.PhpObjectCopy(cloneable: true, serializable: true)]`.
Each option also works independently.

- `cloneable: true` requires a V method
  `fn (source &T) clone_into(mut target T)`. The bridge passes a fresh V
  instance to the method. Copy the object's state and clone or retain owned
  fields according to their lifetime rules. The bridge binds that instance
  before Zend copies PHP properties and runs any PHP `__clone()` hook.
- `serializable: true` requires public instance methods exported as
  `__serialize(): array` and `__unserialize(array $data): void`. The restore
  method is responsible for validating the data and restoring V state.
  Include any PHP-only properties that should survive the round trip.

Classes extending native PHP classes use the native parent's handlers.

## Guiding Idea

The compiler is organized around this progression:

```text
AST -> repr -> linker -> builder fragments -> emitted C/V bridge code
```

When making changes, try to keep responsibilities in the right layer:

- parsing in `parser`
- semantic data in `repr`
- relationship reconciliation in `linker`
- reusable export assembly in `builder`
- concrete output generation in `export`, `c_emitter`, and `v_glue`
