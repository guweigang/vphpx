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

The bundled `vphp` executable includes its matching VPHP SDK (V bindings,
C bridge and PHP stub renderer). Copy it onto `PATH`; extension developers do
not need to clone `vphpx` or install the `vphp` library separately. It extracts
its SDK into a private temporary build directory and removes it after each run,
so builds need no network access and different CLI versions do not share SDK state.

```sh
vphp new hello_ext
cd hello_ext
vphp build
php -n -d extension=build/hello_ext.so tests/smoke.php
vphp stub
```

`new` creates `extension.v`, `v.mod`, a PHP smoke test, `.gitignore` and a
README. The directory basename must be a C identifier (for example,
`hello_ext`); existing destinations, including empty directories, are refused.

To build the distributable executable from this checkout (requires Python 3
to assemble the SDK payload):

```sh
sh cmd/vphp/scripts/package.sh build/vphp
```

CI tests these binaries on macOS arm64, Linux arm64 and Linux amd64 and uploads
them as workflow artifacts. A local build targets the current OS and architecture.
Use `vphp -v` / `vphp --version` (or `vphp version`) to print the CLI version,
and `vphp -h` / `vphp --help` (or `vphp help`) for usage. Each subcommand also
accepts `-h` and `--help`. These options work without an extension project or
installed build tools. The source launcher itself still requires V to run.

CLI metadata lives in `cmd/vphp/v.mod`, separately from the SDK's `vphp/v.mod`.
The CLI embeds its manifest at compilation using `@VMOD_FILE`; packaging copies
that same manifest so source and bundled executables report the same version.

The bundled binary can prepare the development environment in one invocation:

```sh
vphp setup            # install prerequisites, compile and load a sample extension
vphp setup --dry-run  # show the plan without installing or compiling
vphp setup --yes      # skip installer confirmations where supported
vphp doctor           # check tools and PHP headers without an extension build
```

`setup` prints its plan and streams installer output. On macOS it downloads the
[official Homebrew installer](https://github.com/Homebrew/install) over HTTPS to
a temporary file and runs it when Homebrew or Apple's compiler tools are missing.
That installer attempts to install Command Line Tools through `softwareupdate`
and can fall back to Apple's installation window. Follow its administrator or
Apple prompts; the same `setup` invocation continues afterward. `--yes` does not
bypass operating-system authentication or license requirements. Homebrew setup
must run as a regular macOS user, not as root. The official installer's current
macOS/CPU support requirements still apply.

On Linux, setup reads `ID` and `ID_LIKE` from `/etc/os-release` without executing
that file, and selects the distribution's native package manager:

| Distribution family | Package manager | PHP packages |
| --- | --- | --- |
| Debian, Ubuntu and derivatives | apt-get | php-cli, php-dev |
| Fedora, RHEL, Rocky, AlmaLinux, Amazon Linux | dnf / yum | php-cli, php-devel |
| Arch, Manjaro and derivatives | pacman | php (includes development headers) |
| openSUSE, SLES | zypper | php8-cli, php8-devel |
| Alpine | apk | matching php8x and php8x-dev from configured repositories |

The configured repositories must supply a supported PHP (8.2+). Setup does not
add third-party repositories, switch an existing PHP installation to another
major version, or perform a whole-system upgrade. On Arch, refresh/upgrade the
system through its normal maintenance workflow first if package databases or
mirrors are stale. Alpine selects an available PHP 8.2–8.6 family, preserving an
existing CLI/SDK family, and automatically uses its versioned executable names.
System package operations use root, sudo, or doas as appropriate.

When V is missing on Linux, setup bootstraps it from the
[official source repository](https://docs.vlang.io/installing-v-from-source.html)
under `${XDG_DATA_HOME:-$HOME/.local/share}/vphp/toolchains/v`. The builder looks
for `VPHP_V`, `v` on PATH, known Homebrew prefixes, and that managed toolchain.
PHP and php-config likewise recognize Homebrew prefixes and versioned Alpine
names, so no shell restart is needed. `HOMEBREW_PREFIX` can identify a custom
Homebrew prefix. Setup does not edit shell configuration. A failed V build can
resume in a directory created and marked by vphp; other existing directories
are not overwritten.

`doctor` compiles a tiny C probe against the selected PHP headers and checks
PHP version, thread safety (ZTS) and debug mode against the selected PHP CLI.
It exits nonzero for missing or incompatible dependencies. It does not compile
an extension, unpack the SDK, or launch Apple's installer. Explicit `VPHP_*`
tool overrides are respected; broken overrides and incompatible PHP headers
require correction before installation proceeds.

After installation, `setup` runs `doctor`, then creates an isolated sample
extension, compiles it with the embedded SDK, loads the resulting library in PHP,
and checks its result. Only a successful build/load reports `Setup complete`.
An already-provisioned machine skips installation but still performs this check.
Temporary probe projects and downloaded installers are removed afterward.

For Linux distribution portability, prefer the static musl CLI artifact for the
matching CPU architecture. `scripts/package-musl.sh` builds it inside Alpine
(`VPHP_CLI_STATIC=1` in the packaging script); the regular Ubuntu-built dynamic
artifact may require newer glibc and will not start on bare Alpine. Static CLI
linking does not change the target PHP extension's own ABI requirements.

Installation references: [Homebrew installation](https://docs.brew.sh/Installation),
[Apple command-line tools](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools),
[Fedora PHP development package](https://packages.fedoraproject.org/pkgs/php/php-devel/),
[Arch PHP file list](https://archlinux.org/packages/extra/x86_64/php/files/),
[Alpine PHP development files](https://pkgs.alpinelinux.org/contents?name=php84-dev),
and [PHP SDK selection](https://www.php.net/manual/en/install.pecl.php-config.php).
For a machine without V, use the bundled binary; the source launcher itself
requires V before it can run any command.

For source development, put this checkout's `bin` directory on `PATH` instead.
The source launcher uses the `v` on `PATH` on every run.
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
development headers, plus a compatible local V installation. The executable
bundles the VPHP SDK, not V or the platform's C/PHP toolchain.
Set `VPHP_V` to select the V compiler (defaults to `v` on `PATH`),
`VPHP_PHP_CONFIG` to select the PHP SDK,
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

An exported enum uses the integer values computed by V by default, including
values from constant expressions and implicit case numbering. These PHP
backing values must be unique and within the PHP integer range. Add
`@[vphp.PhpEnumCaseValue(value: '...')]` to every case for a string-backed
PHP enum. PHP backing strings must be unique. V methods receive the original V
case, so their behavior follows the V enum even when PHP uses string values.
Add `@[vphp.PhpUnitEnum]` to export an enum without PHP backing values. Its
cases implement `UnitEnum`, and each case can still be returned from V or used
as a PHP parameter default. Use `@[vphp.PhpEnumCaseName(name: 'Ready')]`
to export a V case under a different PHP name. To preserve an older spelling,
declare a constant alias in a `PhpConstantTable` and set its PHP name with
`PhpClassConstantName`.

Mark a composable V struct with `@[vphp.PhpTrait]` and embed it in an
exported class. Its PHP properties, constants, and exported methods are
composed into the class, whose own members take precedence. Declare trait
constants with `PhpClassConstants`, including enum case references. Reflection
and the generated stub show the consuming class as the declaring class.
Existing `@[php_trait]` declarations are also supported.

Use `PhpInterfaceDefaults[T]` to declare PHP defaults for the exported
interface `T`. Each `PhpInterfaceDefault` specifies a method, parameter, and PHP
default expression, such as an enum case. The interface exposes the default
in Reflection and in the stub. Concrete implementations declare their own
defaults. An interface method can also end in a `@[params]` struct. Its fields
become optional PHP parameters with the same names and defaults as an
implementation that uses the same struct. `PhpInterfaceDefaults[T]` can
override a field for that interface. Computed fields appear as dynamic
default descriptors in Reflection and are evaluated by the implementation
when omitted.

Embed another exported V interface to extend its PHP interface. V import
aliases are resolved to the declaring module. Use `PhpExtendsInterfaces`
to name PHP-side parents, such as interfaces supplied by PHP itself.
An exported interface can also refer to another exported V interface in
its method parameter or return types. The PHP signature uses the referenced
interface's PHP name, including for nullable and variadic parameters.
For concrete functions and methods, use `vphp.PhpInterface[T]`, where `T`
is the exported V interface. The bridge infers the PHP type and keeps the
original PHP object, including when it comes from a userland class.
`to_object()` gives a borrowed `PhpObject` for calling PHP methods.
Generated PHP closures infer the same types for fixed parameters,
`@[params]` fields, variadic elements, and return values.
For a built-in or userland PHP interface, declare a V marker interface with
`@[vphp.PhpExternalInterface(name: 'Vendor\\Contract')]` and use that marker
as `T`. The extension and stub reference the PHP name without declaring
the interface. The bridge checks the original object against the loaded PHP
interface. While that interface is still unloaded, it also accepts objects
whose extension class has an automatic binding to the interface.
For interfaces used in multiple signatures, declare a V type alias such as
`pub type Request = vphp.PhpInterface[PsrRequestContract]`. VPHP follows the
alias to the underlying PHP interface for both the extension and the stub.
`to_value()` gives a borrowed `PhpValue` for callers that use generic PHP
value APIs.

Add `@[vphp.PhpInterfaceStaticMethods(names: 'create,fromValue')]` to export
the named interface signatures as PHP static methods. PHP checks that
implementations are static, including when the requirement is inherited.
Alternatively, declare `PhpInterfaceMethods[T]` with `PhpInterfaceMethod`
entries keyed by V method name. An entry may set the PHP method name,
mark the method static, and rename parameters or flattened `@[params]`
fields through `PhpInterfaceParameter`. Interface defaults can still use
the original V parameter names. Set `php_return_type` or a parameter's
`php_type` field to declare the PHP type explicitly, including unions,
intersections, and DNF types. PHP checks the declared types against each
implementation.
Both method and parameter declarations accept `attributes: []PhpAttributeSpec`.
The compiler parses their PHP attribute arguments using the same rules as
`PhpCallableAttribute` and `PhpParameterAttribute`.
Leave the method name, parameter names, and types out of the table when
the inferred PHP signature already matches the contract.
Set `since: .php85` or `since: .php86` on a method to introduce the contract
in that PHP version. The method table, defaults, attributes and stub use the
same version condition.

Use `@[vphp.PhpExportTrait(name: 'My\\Project\\Defaults')]` to register
a native PHP trait. PHP classes can declare `use \My\Project\Defaults;`.
Pass `name: ''` to use the V struct name. Put constants on the trait with
`PhpClassConstants`, including references such as `Mode.active`. Use
`PhpDeclaredProperty` or its default-value variant for PHP-managed instance
state. Declare PHP-managed static state with `PhpDeclaredStaticProperty`
or `PhpDeclaredStaticPropertyWithDefault`. Static storage follows PHP's
inheritance and trait composition rules in the consuming class and is
isolated by the worker's logical request scope. Use `PhpExportMethod` for
instance and static methods. The V struct is an
empty receiver for these methods. Instance methods that access PHP state
can take a `vphp.Context` parameter. The generated stub declares the trait
and its members. Load PHP declarations that use a native VPHP trait at
request time when using OPcache preloading.

Use `PhpUserlandSubclass` on a native trait to export a class whose parent
is supplied by the application or by Composer.

```v
@[vphp.PhpExportTrait(name: 'Bridge\\CounterMethods')]
@[vphp.PhpUserlandSubclass(name: 'Bridge\\Counter', parent: 'Vendor\\Counter')]
struct CounterMethods {}
```

`vphp build` emits a PHP declaration file next to the extension, for example
`build/my_extension.so.classes.php`. Include that file in Composer's
`autoload.files`, or require it after loading your autoloader. The extension
must be loaded when the file runs. The generated class extends the resolved
parent and uses the native trait. Zend checks method signatures and retains
the parent's constructor when the trait declares no constructor. Store
per-object state in PHP properties, which V methods can access through
`vphp.Context` just as with other native traits. `vphp stub` includes the class
declaration.

Export a trait constructor with `PhpExportMethod(name: '__construct')` on
an instance method returning no value. A `vphp.Context` parameter gives it
access to the consuming PHP object. The remaining parameters are exposed
to PHP, including names and defaults.

Combine `PhpAbstractMethod` with `PhpMethodVisibility(.private)` on a
native trait method to require a method with a compatible signature in
the consuming PHP class. The consuming class may implement it as private.

Use `PhpMethodSince` on an exported trait method to make it available from a
given PHP version. An `as` rule follows the availability of its source method.
An `insteadof` rule takes effect when its selected method is available. Earlier
builds can use another implementation, and nested traits follow the same
selection in the extension and the stub.

A `PhpTraitRules[T]` constant associates composition rules with the exported
V trait type `T`. VPHP discovers the declaration by its type argument, so the
constant can have any name. Use empty initializers of the exported trait types.

```v
@[vphp.PhpExportTrait(name: 'My\\Project\\Combined')]
struct Combined {}

const combined_rules = vphp.PhpTraitRules[Combined]{
	uses: [Base{}, Fallback{}, Audit{}]
	precedences: [
		vphp.PhpTraitPrecedence{
			source: Base{}
			method: 'format'
			instead_of: [Fallback{}, Audit{}]
		},
	]
	adaptations: [
		vphp.PhpTraitAdaptation{
			source: Fallback{}
			method: 'format'
			alias: 'formatFallback'
			visibility: .protected
		},
	]
}
```

Each precedence rule names an exported PHP method on a directly used trait.
Every excluded trait must also be directly used. An adaptation with an alias
can still expose an excluded implementation under a separate name. Reflection
reports the composition and the generated stub declares it with PHP `use` and
`insteadof`. The composing trait can also resolve a conflict by declaring its
own method. Shared declarations from a common trait are composed once. Property
type comparison ignores member order in unions and intersections and accepts
equivalent nullable spellings. An explicit `mixed` declaration retains its
type for composition with other PHP traits. Abstract requirements with the same name
compare their exported PHP parameter and return types using the same rules.
Reference passing and returns, parameter optionality, and variadics must match.

Each field accepts an array literal or a reference to a constant array in the
same V module as the rules. For a standalone `uses` array of mixed V types,
convert the first value to `vphp.PhpNativeTraitSource` so V infers a common
element type. `PhpUsesTraits`, `PhpTraitPrecedences`, and `PhpTraitAdaptations`
also accept `source:` with the name of a constant array in the trait's module.
Declare each field once across the two forms, with one `PhpTraitRules` constant
per trait.

For method adaptations, use the `adaptations` field or
`@[vphp.PhpTraitAdaptations(source: 'audit_adaptations')]`.
Use an empty initializer of a directly used V trait as the source and its
exported PHP method name as `method`. An omitted alias keeps the original name
and an omitted visibility inherits the source visibility.

```v
const audit_adaptations = [
	vphp.PhpTraitAdaptation{source: Base{}, method: 'format', is_final: true},
	vphp.PhpTraitAdaptation{
		source: Base{}
		method: 'format'
		alias: 'formatBase'
		visibility: .protected
		is_final: true
	},
]
```

Use `is_final` with concrete methods. PHP 8.3 and newer enforce final on inherited
public and protected methods. The class that uses the trait can still supply its
own implementation. PHP 8.2 keeps aliases and visibility and omits final. PHP
Reflection reports named aliases through `getTraitAliases()` and the resulting
modifiers through `ReflectionMethod`. PHP warns when a stub declares an ordinary
method as both private and final. A subclass can declare its own method with
that name.

Existing `PhpTraitAliases` declarations also support alias and visibility rules
such as `Base::format as private` and `Base::format as protected formatBase`.
Use fully qualified PHP trait names in that string syntax.

For final and visibility together, the CLI emits the visibility in the `as`
rule and final on the method declaration, since PHP accepts one modifier per
`as` rule.

Pass arguments to a typed VPHP attribute in its call, such as
`@[vphp.PhpProperty(name: 'inputData')]`. Use a narrow `// vfmt off` block if
your V formatter expands a field or enum-case attribute into separate entries.

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

Use `@[vphp.PhpSensitiveParameter(v_name: 'api_key')]` to emit PHP's native
`#[\SensitiveParameter]` on PHP 8.2 and newer. PHP wraps the argument in a
`SensitiveParameterValue` in argument-bearing stack traces. Runtime calls
receive the original value. Use the V parameter or flattened `@[params]` field
name even if the exported PHP name differs. `vphp check` reports unknown names
and hidden `Context` arguments.
On PHP 8.2, VPHP also masks the named arguments accepted by a sensitive
variadic parameter when the call enters the extension bridge. Later PHP
versions handle those arguments directly in Zend.

On an `@[params]` struct, mark a field with `@[vphp.PhpSensitiveField]` to
retain that metadata in every exported function, method, and struct closure
that flattens the field into a PHP parameter.

Use `@[vphp.PhpCallableAttribute(name: 'My\\Project\\Audit', args: 'level: 2')]`
to attach a PHP attribute to the exported function or method itself.

Use `@[vphp.PhpCallableAttribute(name: 'Deprecated', args: 'message: "Use currentValue()", since: "2.0"')]`
on an exported function or method. PHP 8.4 and newer expose `#[\Deprecated]`
in Reflection and stubs and emit `E_DEPRECATED` when the extension callable is
called. PHP 8.2 and 8.3 export the callable without that metadata.

On PHP 8.4 and newer, `PhpClassConstantAttribute('Deprecated', ...)` marks
class, interface, trait, and enum constants as deprecated. PHP reports the
deprecation when the constant is accessed. Use
`PhpEnumCaseAttribute('Deprecated', ...)` for the case itself. Deprecating an
enum constant alias leaves the original case and its other names unaffected.

Use `@[vphp.PhpClassAttribute(name: 'Deprecated', args: 'message: "Use CurrentTrait"')]`
on a `PhpExportTrait`. PHP 8.5 and newer expose the attribute in Reflection and
stubs and report deprecation when a PHP class or trait directly uses the
exported trait. PHP 8.2–8.4 retain the trait and omit its deprecation metadata.

Use `@[vphp.PhpCallableAttribute(name: 'NoDiscard', args: 'message: "Use the result"')]`
on a callable that returns a value. PHP 8.5 and later warn when its result is
discarded. Earlier PHP versions expose the callable without the attribute.

Use `@[vphp.PhpCallableAttribute(name: 'Override', args: '')]` on an exported
method to require a matching inherited or implemented method. On PHP 8.3 and
later, the extension checks the match and Reflection and stubs expose
`#[\Override]`. If the match depends on a PHP interface loaded after extension
startup, the check can run at first call. PHP 8.2 omits the attribute.

Use `@[vphp.PhpPropertyAttribute(name: 'Override', args: '')]` on an exported
field to require a matching parent or interface property. PHP 8.5 and later
expose `#[\Override]` in Reflection and stubs. A private parent property does
not qualify. For a PHP interface loaded after extension startup, VPHP checks
the declaration when resolving the interface for the class.

Bind property contracts to the exported V interface with a
`PhpInterfaceProperties[T]` constant. Each entry specifies the PHP name,
type, and access as `.get`, `.set`, or `.get_set`.

```v
@[vphp.PhpExportInterface(name: 'Record')]
pub interface Record {}

const record_properties = vphp.PhpInterfaceProperties[Record]{
	properties: [
		vphp.PhpInterfaceProperty{name: 'id', php_type: 'int', access: .get},
		vphp.PhpInterfaceProperty{name: 'title', php_type: 'string', access: .get_set},
	]
}
```

PHP 8.4 and later expose these contracts. VPHP-exported and PHP classes can
implement them with public backing properties or matching hooks. PHP 8.2
and 8.3 retain the interface without its property contracts.
Set `since: .php85` or `since: .php86` on an individual entry to require that
property only in newer builds. The property and its hooks are compiled and
reflected together.

On a class exported with `PhpAbstractClass`, a `PhpAbstractProperties[T]`
constant declares the property's abstract accessors. Use
`vphp.PhpAbstractProperty{name: 'score', php_type: 'int', access: .get}`
inside its `properties` array. Use `.set` to require an abstract setter or
`.get_set` to require both. Bind the other accessor to a V method with
`PhpPropertyGet` or `PhpPropertySet` to supply a concrete implementation.
When an inherited hook accesses the parent's V fields, embed the parent V
struct in the V subclass so the receiver shares that state.
PHP 8.4 exposes the declaration, and PHP 8.5 allows implementing hooks to
use `#[\Override]`. PHP 8.2 and 8.3 omit these property declarations.
Abstract property entries accept the same `since` setting. Apply the
corresponding version gate to an implementing property with an override hook
when the prototype is introduced in a newer PHP version.

In `PhpInterfaceProperties[T]` and `PhpAbstractProperties[T]`, use
`.get_ref` for `&get;` or `.get_ref_set` for `&get; set;`. A compatible
public, writable backed property can fulfill either contract directly.
In V, declare it with `PhpDeclaredPropertyWithDefault`. The implementation
reflects as an ordinary property with no hooks. If you declare an explicit
getter, use a `PhpPropertyGet` method that returns `vphp.PhpReference`.
A public readonly or `protected(set)` backed property can implement `&get;`,
but an accompanying public `set;` requires public write access. Readonly
properties reject reference binding. With `protected(set)`, only scopes
that can write the property can bind a reference to it. A public
`private(set)` property also satisfies `&get;`. Only its declaring class
can write it or bind a reference, and subclasses cannot redeclare it.

On PHP 8.4 and later, use `@[vphp.PhpPropertyGet(property: 'score')]` and
`@[vphp.PhpPropertySet(property: 'score')]` on V instance methods to supply
native hooks for a writable PHP-only property declared on the same class.
The getter takes no arguments and returns the property's value. The setter
takes one required value and returns void. The declarations are virtual by
default. A literal default or an inherited backing slot makes the property
backed. PHP 8.2 and 8.3 omit the hooked declaration.

Use `PhpMethodSince` to give an individual hook a later minimum version.
The property and any hooks that are already available retain their behavior
until the new hook is compiled in.

Add `@[vphp.PhpCallableAttribute('Override', '')]` to an individual hook to
require the matching read or write operation on a parent or a PHP interface.
The extension and stubs expose the hook attribute on PHP 8.5 and later.

Add `@[vphp.PhpFinalMethod]` to the V method that supplies a hook to make
that accessor final on PHP 8.4 and later. Subclasses inherit the final
accessor and can override the other one.

A `PhpPropertyGet` method whose V return type is `vphp.PhpReference` or
`!vphp.PhpReference` exports a native `&get` on PHP 8.4 and later.
For a backed property, return `vphp.PhpReference.hook_backing()` from the
getter to borrow its Zend reference. A backed property with `&get` uses
ordinary Zend writes. PHP 8.2 and 8.3 omit the hooked declaration.

A virtual property can combine `&get` and `set`. Declare a separate writable
PHP-only property for storage and call `vphp.PhpReference.hook_storage('storage')`
in both hooks. The getter returns that reference, and the setter calls
`set_value` on it. Assigning through a bound PHP reference updates the
storage directly. Ordinary property assignment calls the setter.

Use `@[vphp.PhpExtends(name: 'Exception')]` to declare a class parent.
For a native PHP parent, VPHP initializes exported V-backed scalar and `PhpValue` fields
when PHP allocates the object. A PHP subclass redeclaration uses its own
default. Immutable fields remain readonly properties on the native subclass.
When a V struct embeds its exported PHP parent in this hierarchy, methods on
the child read and update the parent's fields on the same PHP object.
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

Put `@[vphp.PhpDeclaredProperty(name: 'requestRef', php_type: 'mixed')]`
on an exported struct to declare a public writable PHP property without
a V field. An explicit `mixed` type appears in Reflection and follows PHP
inheritance rules. With no default, the property is uninitialized. Use an
empty `php_type` or the legacy class-level `@[php_prop]` declaration for
an untyped property.

Use `@[vphp.PhpDeclaredPropertyWithDefault(name: 'retries', php_type: 'int', default_value: '3')]`
to declare a property with a literal default.
Use quoted strings for string defaults, such as `default_value: "'ready'"`.
Array defaults use brackets and can contain nested arrays with integer or
quoted string keys, for example `default_value: '["tags" => ["ready"]]'`.
The extension and the PHP stub expose the declared default.

Use `@[vphp.PhpDeclaredPropertyVisibility(name: 'retries', visibility: .protected)]`
to set the PHP read visibility of a declared property. The same enum accepts
`.public` and `.private`. With a separate `set_visibility`, writes may be more
restricted than reads.

Use `@[vphp.PhpFinalDeclaredProperty(name: 'retries')]` alongside a PHP-only
property declaration to disallow redeclaration in subclasses. The property is
included in the extension and stub on PHP 8.4 and later.

PHP-only declarations accept nullable types such as `?string`, `?array`,
and `?DateTimeImmutable`. The property starts uninitialized unless the
declaration supplies a default, which can be the literal `null`.

PHP-only properties also accept unions such as `int|string` and
`DateTimeImmutable|DateTime|null`. A supplied default must match a member of
the union. Zend checks assignments against the declared type.

Use `Countable&IteratorAggregate` for an intersection or
`(Countable&Iterator)|int|null` for a DNF property type. Both forms work
on PHP 8.2 and later.

Use `@[vphp.PhpDeclaredPropertyWithSetVisibility(name: 'score', php_type: 'int', set_visibility: .protected)]`
to declare an uninitialized public property with restricted writes. Set
`set_visibility` to `.private` to restrict writes to the declaring class.
These properties are registered and included in stubs on PHP 8.4 and later.
Use `PhpDeclaredPropertyWithSetVisibilityAndDefault` to provide a literal
`default_value` along with `name`, `php_type` and `set_visibility`.
Use `PhpDeclaredStaticPropertyWithSetVisibility` or
`PhpDeclaredStaticPropertyWithSetVisibilityAndDefault` for the corresponding
static property. These static declarations are included on PHP 8.5 and later.
For `PhpDeclaredReadonlyProperty`, use `visibility: .public`,
`visibility: .protected`, or `visibility: .private`.

To declare several PHP-managed properties on the same class or trait, use a
`PhpDeclaredProperties[Target]` constant with a `properties` array.

```v
const options_properties = vphp.PhpDeclaredProperties[Options]{
	properties: [vphp.PhpDeclaredPropertySpec{
		name:          'label'
		php_type:      'string'
		default_value: "'ready'"
		since:         .php86
	}]
}
```

Each entry can set `visibility`, `set_visibility`, `is_static`, `is_readonly`,
and `is_final`. Omit `default_value` for an uninitialized typed property.
Omit `since` to target PHP 8.2. A property's PHP syntax can raise its minimum.
For example, a static asymmetric setter needs PHP 8.5 and a hook needs PHP
8.4. If a subclass declaration is absent in the target version, normal
inheritance applies. The generated stub reflects the registered properties.

Declare a `PhpConstantTable[Target, Values]` constant to export the fields of
`Values` on the PHP class, trait, interface, or enum exported by `Target`.
The V target type determines the binding, so the table can have any name.

```v
struct Limits {
	max_items int
}

const options_table = vphp.PhpConstantTable[Options, Limits]{
	values: Limits{max_items: 42}
}
```

The `values` field accepts a struct initializer or a reference to a constant
struct in the table's module. A class table in the target's module also supplies
the generated V `Target.consts()` accessor.

`@[vphp.PhpClassConstants(source: 'my_constants')]` remains available for a
named constant struct. Use
`@[vphp.PhpClassConstantVisibility(visibility: .protected); vphp.PhpFinalClassConstant]`
on a field to restrict access and prevent redeclaration in subclasses. The
visibility also accepts `.public` and `.private`. Visibility and finality
are exposed on PHP 8.2 and later. Reflection includes the inferred constant
type on PHP 8.3 and later. Annotate those fields with
`@[vphp.PhpClassConstantAttribute(name: 'My\\Project\\Audit', args: 'level: 2')]`
to attach a PHP attribute. Use `PhpEnumCaseAttribute` with the same fields
on a case in an exported V enum. Reflection and the generated stub expose
the metadata on the corresponding constant or case.

Add `@[vphp.PhpClassConstantSince(version: .php86)]` to a constant-table field
to register it only on PHP 8.6 and later. This also applies to ordinary
constants on interfaces, traits and enums, including aliases of enum cases.
When composing native traits, declarations of the same constant must agree
on value, type, visibility and finality on the PHP versions where they coexist.

On a PHP interface, the named form is
`@[vphp.PhpInterfaceConstants(source: 'my_constants')]`. Its fields use the same types,
PHP attributes and `PhpFinalClassConstant` marker as class constants.
Interface constants are public. PHP 8.2 exposes the values, and PHP 8.3
and later expose the inferred types as well.

On a PHP enum, both `PhpConstantTable` and the named
`@[vphp.PhpEnumConstants(source: 'my_constants')]` form export ordinary
constants alongside its cases. The fields use the
same visibility, `final`, PHP attributes and versioned types as class
constants. Use `PhpEnumCaseAttribute` for metadata on the cases themselves.

Both forms accept enum case references. Use an
exported V enum as the field type and initialize it with `Mode.active`
or `.active`. The constant resolves to the original PHP case object.
PHP 8.3 and later reflect the referenced enum as the constant type.

Declare a `PhpStaticTable[Target, State]` constant in the module that exports
`Target` as a PHP class. Its name is arbitrary. `values` accepts a struct
initializer or a same-module constant struct.

```v
struct CounterState {
pub mut:
	count int = 10
}

const counter_statics = vphp.PhpStaticTable[Counter, CounterState]{
	values: CounterState{count: 12}
}
```

The table exports mutable `int`, `i64`, `f64`, `string`, and `bool` fields.
A scalar literal in `values` takes precedence over a field's literal default.
The table initializes mutable V state exposed by `Target.statics()`. Generated
method wrappers read the PHP static properties before calling V and write back
afterward. The accessor is valid for the current request. Each PHP request has
its own V state, including on ZTS builds.
An inherited method synchronizes with the properties of the PHP class it was
called on. Inherited properties share their PHP storage. A redeclared property
has its own storage, and the generated method uses a separate V view of that
table. Other fields in the same table still follow PHP inheritance.

When an exported V method calls PHP through VPHP, the bridge publishes pending
V writes first. It reloads PHP values when the callback returns or throws.
PHP callbacks can read the pending writes, change static properties, and call
back into an exported method. Changes made before an inner exception are
published when that method exits.

The vhttpd worker opens a fresh scope for each dispatch. Other PHP worker loops
can call `vphp_<extension>_with_static_request($callback)` around each logical
request. The callback starts with fresh V state and the declared PHP defaults.
The scope also resets ordinary static properties declared by VPHP.
This includes defaults for fields redeclared by PHP subclasses. An inherited
field uses the same storage throughout the dispatch.
The scope restores the surrounding values and PHP reference bindings when
the callback returns or throws, including when scopes are nested.
Wrap deferred response iteration in the same callback when it uses statics.

`@[vphp.PhpClassStatics(source: 'my_statics')]` and the class-level
`@[php_const]` and `@[php_static]` forms remain available.

Put `@[vphp.PhpExportConstant]` on a V scalar constant to export it as a
PHP global constant. For example, `const max_retries = 3` is exported as
`MAX_RETRIES` with value `3` and type `int`. The global `@[php_const]`
spelling is also supported.

Use `@[vphp.PhpExportConstant(name: 'Acme\\Config\\MAX_RETRIES')]` to choose the
full PHP name. The constant name retains its case.

Add `@[vphp.PhpGlobalConstantSince(version: .php86)]` to register the constant
only when building against PHP 8.6 or later. The constant and its attributes
are absent from Reflection and generated stubs on earlier PHP versions.

Put `@[vphp.PhpGlobalConstantAttribute(name: 'Deprecated', args: 'message: "Use MAX_RETRIES"')]`
on an exported scalar constant to attach metadata on PHP 8.5 and later.
PHP 8.2, 8.3, and 8.4 expose the constant without the attribute or its behavior.

Mark the extension's Zend module globals struct with `@[vphp.PhpGlobals]`.
Use `vphp.get_globals[T]()` to read the active storage and
`vphp.with_globals[T](...)` to mutate it. Each extension declares at most
one globals struct. The existing `@[php_globals]` spelling is also supported.

Use `@[vphp.PhpExportTask(name: 'Analyze')]` on a struct implementing
`vphp.ITask` to register its PHP task name. Pass `name: ''` to use the V
struct name. Existing `@[php_task]` declarations are also supported.
The task handle caches the native result after joining its thread. A wait
inside a managed PHP Fiber yields to its peers while the native task runs.
Dropping the handle lets the native work finish and reclaims the thread
without waiting on the PHP request thread.
When linking a Linux extension manually, use `-Wl,-z,nodelete` so its code
and data remain mapped while V's workers or GC threads can still use them.

For a native job with a result type outside `TaskResult`, use
`spawn_php_native_task[Job, Result](job, execute)`. The request thread can
call `wait()` repeatedly and must call `release()` once the PHP owner and its
waiters are done. Keep Zend handles out of the job and its result. Convert
the result into PHP values on the request thread.

For PHP callables, extensions can create a `vphp.PhpScheduledTask` with
Zend-owned state and drive a group with `vphp.run_php_tasks`. Each callable
runs in a PHP Fiber on the current request thread. Pass the callable and its
argument array to `initialize(callback, params)`. PHP binds integer keys as
positional arguments and string keys as named arguments. A task can call
`wait_until_complete()` on a peer before reading its result. Calling it from
a managed Fiber joins a new task to the current group. Use `wait_for_php_tasks()`
to join a batch before waiting on any of its tasks. Pass `owner:` when
the task's state is stored on a PHP object so the group can keep it alive.
Use `PhpScheduledTask.cancel(reason)` to settle a queued task or deliver a
Throwable at the suspended Fiber's next turn. `vphp.sleep_php_task(ms)`
parks the current task on a monotonic timer. The scheduler retains the
original result or exception in Zend-traced state. Stream waits use PHP's
polling API on PHP 8.6 and later and system polling on PHP 8.2–8.5.

Use `@[vphp.PhpExportFunction(name: 'my_function')]` on a function and
`@[vphp.PhpExportMethod(name: 'withUri')]` on a method of an exported class.
Pass `name: ''` to use the V declaration name. Existing `@[php_function]`
and `@[php_method]` declarations are also supported.

Add `@[vphp.PhpMethodSince(version: .php84)]` to an exported class or trait method
that requires a newer PHP minor. The condition also applies to abstract
instance and static methods. Add
`@[vphp.PhpFunctionSince(version: .php86)]` to an exported function, including
functions in a PHP namespace. The generated C handlers and registration
tables use the target headers' `PHP_VERSION_ID`. Reflection and stub
generation see the exports available in that build.

Add `@[vphp.PhpTypeSince(version: .php86)]` to a class, interface, native trait,
or enum to compile its PHP export only on PHP 8.6 and later. Exported
subclasses, interface implementations, and trait compositions inherit the
minimum version of their required types. A constant alias of a gated enum
case follows the enum's version. An exported function's parameter and return
types automatically impose the minimum version of any exported type they name.
`PhpFunctionSince` can raise this minimum. Use `PhpMethodSince` on a factory
method that needs a higher minimum than its declaring class.
The compiler checks a gated class's native parent on PHP versions that
include the class.

When a version-gated constructor is unavailable, a V-owned class gets its
generated zero-argument constructor to initialize its V fields. A class
extending a Zend-owned class inherits the parent constructor on those versions.

Use `@[vphp.PhpExportFunction(name: 'Acme\\Greeting\\hello')]` to export
`Acme\Greeting\hello()`. Different namespaces can export the same short name.

Pair `@[vphp.PhpAbstractClass]` with a class export and
`@[vphp.PhpAbstractMethod]` with an instance or static method export.
The method's V signature supplies the PHP abstract method signature.
Existing `@[php_abstract]` declarations are also supported.
Use `@[vphp.PhpReadonlyClass]` to explicitly export a PHP readonly class, including an
empty class or one with PHP-only properties. Exported V fields must be
immutable. PHP-only declarations become readonly and start uninitialized by
default. Static properties are invalid in readonly classes.

To add a literal default to a PHP-only readonly property, use
`PhpDeclaredPropertySpec` with `default_value` and `since: .php86`. A readonly
class gated by `PhpTypeSince(version: .php86)` can also declare the default on
its properties. PHP 8.6 and later initialize the property from the declaration
and expose the readonly default in Reflection and stubs.

`@[vphp.PhpClassAttribute('AllowDynamicProperties', '')]` enables PHP dynamic
properties on an exported class and its subclasses. Reflection and the stub
retain the attribute on the class that declares it. Readonly classes cannot
use it.

Use `@[vphp.PhpFinalMethod]` alongside a method export to prevent PHP
subclasses from overriding it. Instance methods, static methods, and explicit
constructors can be final.

Use `@[vphp.PhpMethodVisibility(visibility: .private)]` alongside a method
export to set its PHP visibility explicitly. The same schema accepts
`.public` and `.protected`. Without it, V `pub` methods export as PHP
`public` and other methods export as `protected`.

Use `@[vphp.PhpBorrowedReturn]` when an exported method returns an existing
V object with borrowed ownership. This uses the same bridge behavior as
`@[php_borrowed_return]`, which remains supported.

An argument whose V type names an exported class uses the class's PHP name
in Reflection and in the stub, including classes imported from another module.
A nullable V reference exports as a nullable PHP class type. An omitted
nullable argument or explicit `null` maps to `none`. A PHP instance of the
right class with no bound V object raises `TypeError`, including in
variadic arguments and flattened `@[params]` fields.

Override inferred PHP types with `@[vphp.PhpArgType(v_name: 'value', php_type: 'int|string')]`
or use `PhpArgTypes(types: 'request=ServerRequestInterface,handler=RequestHandlerInterface')`
to declare several overrides on one callable. Use `PhpArgName` to rename
one parameter or `PhpArgNames(names: 'old_name=newName,other_name=otherName')`
to rename several. `PhpArgDefault(v_name: 'offset', default_value: 'SEEK_SET')`
sets a PHP default expression and makes the parameter optional.
`PhpArgDefaults(defaults: 'first=null,second=[]')` declares several defaults
on one callable.
For a direct V option parameter, use
`@[vphp.PhpArgOptional(v_name: 'expiration', optional: false)]` to require
the argument in PHP while accepting explicit `null`. An explicit PHP default
still makes the argument optional.
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

For exported functions and methods, variadic PHP value wrappers such as
`...vphp.PhpValue`, `...vphp.PhpArray` and `...vphp.PhpObject` read each
PHP argument with its wrapper's conversion. `PhpArgType` can narrow the
reflected type of the variadic elements. A value that cannot be represented
by the V wrapper raises `TypeError` before the V body runs.

Use `...vphp.PhpArg` in an exported function or method to accept PHP named
variadic arguments. Each item exposes its `value` and an optional
`variadic_name()`. Positional items come first, followed by named items in
call order. `PhpArgType` applies to both groups. Exports using other V
variadic element types accept positional tail arguments.

Returned V closures can use the same tail type, including after fixed
parameters. PHP Reflection reports the closure tail as `mixed ...$args`
using its declared V parameter name.

Use `callback.invoke_forwarded(args)` to send an exported `...vphp.PhpArg`
tail to a PHP callback. Use `callback.invoke_args(array)` for a PHP argument
array. Both use PHP's call rules for numeric and string keys, optional
parameters and exceptions. An argument array may contain references.
`PhpCallable.call_reference_args(array)` and `PhpClosure.call_reference_args(array)`
preserve a by-reference return. `PhpCallable.invoke_by_value(...)` and
`PhpCallable.invoke_args_by_value(array)` return an owned value with the
top-level return reference resolved. Object results keep their PHP identity.
Use `move_to_request_scope_by_value()` to consume an existing handle and
store the value in the active request scope.
Typed `with_result` and `with_*_result` callbacks receive the value held by a PHP reference for
the duration of the callback, even if PHP rebinds the reference during that
call. Request `PhpReference` or `PhpValue` when the callback needs the original
reference.

Use `vphp.PhpArrayAccess` for exports that take or return a PHP `ArrayAccess`
object. `has` calls `offsetExists`, `get` reads a value, and `get_reference`
keeps the reference when `offsetGet` returns one. `append` passes a `null`
offset to `offsetSet`.
Use `vphp.PhpCountable` for the `Countable` interface. Its `count()` method
uses PHP's native `count()` and honors userland overrides and exceptions.
Use `vphp.PhpIteratorAggregate` for exports typed as PHP's `IteratorAggregate`.
`get_iterator()` calls the original object's `getIterator()` and returns its
`Traversable` as a request-owned `PhpIterator`.
Use `vphp.PhpStringable` for PHP's `Stringable` interface, which a class implements
implicitly when it declares `__toString`. `stringify()`
performs PHP's string conversion and preserves conversion exceptions.
Use `vphp.PhpJsonSerializable` for PHP's `JsonSerializable` interface. `serialize()`
calls `jsonSerialize()`, while `encode()` passes the whole object to PHP's JSON
encoder with `JSON_THROW_ON_ERROR`.

The same argument-array convention is available through
`PhpFunction.invoke_args`, `PhpObject.call_method_args`,
`PhpClass.call_static_args` and `PhpClass.construct_args`.
An unresolved function or method used with the argument-array APIs raises
`TypeError` with Zend's callable diagnostic. An exception thrown during
autoloading or invocation propagates as the original PHP exception.

When V needs to handle a PHP exception, use `PhpException.take_current()`.
It clears the pending exception and returns a request-owned `PhpThrowable`
for the original object, allowing another PHP call. Call `throw()` on the
handle to rethrow that object, and `release()` when the handle is no longer
needed. With no pending `Throwable`, `take_current()` returns `none`.
PHP control-flow signals such as `exit()` remain pending in Zend. Use
`append_previous()` to record a secondary failure on the original Throwable.
Use `vphp.PhpThrowable` in export signatures to infer PHP's `Throwable`
interface. `?vphp.PhpThrowable` also accepts PHP `null` and has a null
default for an optional fixed parameter.
`vphp.PhpEnumCase` infers PHP's `UnitEnum`. It accepts both unit and backed
cases and retains the original PHP case object. Use `case_.to_v[MyEnum]()`
to convert a case to its matching V enum. The conversion checks the PHP enum
class and uses its exported case name, including renamed cases.
`vphp.PhpIterator` accepts `Traversable` objects, and `vphp.PhpIterable`
also accepts arrays. Argument decoding preserves lazy objects. On both
wrappers, `to_array()` preserves PHP array keys, with later values replacing
earlier values for an equivalent key. `to_list()` keeps every value in
iteration order and assigns sequential integer keys. `to_entries()` returns
ordered `[key, value]` pairs, preserving each original key and its type.
All three discard the partial array and leave the original exception pending
if iteration throws. Use `each_value_by_value_while()` to visit values lazily.
Each callback borrows a snapshot of the current value that stays valid during
PHP reentry. Returning `false` stops before advancing the iterable.
`count()` follows `iterator_count()` for Traversable inputs. It consumes the
iterator without fetching keys or values and preserves exceptions.

Return `vphp.PhpReference` or `!vphp.PhpReference` from an exported function or
method to return the PHP reference itself. PHP callers can bind an alias
with `=&`, and Reflection reports that the callable returns by reference.
The default return type is `mixed`. Use `PhpReturnType` to constrain the
referenced value at return time.
`PhpReference.this_property('score')` borrows a reference to a declared PHP
instance property from the current method. The method's declaring scope
controls access. This API supports writable Zend storage without hooks.
Use `to_request_owned()` before keeping the reference across a call that
could replace the property.
`PhpReference.static_property('score')` borrows a declared static property
on the called class, like PHP's `static::$score`. The method's declaring
scope controls visibility. V-backed static tables use their own synchronization
API, so the direct reference helper accepts Zend-only storage.
An exported interface or abstract method returning `vphp.PhpReference`
requires implementations to return by reference. Trait composition preserves
reference returns on both the original method and its aliases.

Exported struct-parameter and variadic closures also support returning
`vphp.PhpReference` or `!vphp.PhpReference`. The reference flag and the
`mixed` return type belong to the closure itself and are available through
`new ReflectionFunction($closure)`.

A `PhpReference` field in a closure's `@[params]` struct becomes a PHP
reference parameter. A field of type `?PhpReference = none` is optional.
Use `fn (...vphp.PhpReference)` for a variadic closure that accepts positional
PHP variables by reference. A callback can update those variables with
`set()` or return a reference to one of them.

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
Functions, methods, and struct closures can use a public params struct from
another V module. The module and type identify the declaration.

Generated params struct bindings read arguments by PHP parameter name first and
fall back to position. This allows PHP callers to skip optional parameters with
named arguments:

```php
create_response(reasonPhrase: 'Accepted');
```

A field initialized with a V case of an exported enum exposes the same case as
its PHP default. Reflection and generated stubs use the exported PHP enum and
case names, including renamed cases. Struct closures use the same case
metadata and accept explicit `null` for nullable fields.

Fields typed as `&T` or `?&T` for exported V classes use the PHP class in the
closure signature. The bridge reads the existing V instance from the supplied
PHP object, including instances of PHP subclasses. A PHP object without a V
binding raises `TypeError`. A nullable field with a `none` initializer accepts
both omission and an explicit `null`.

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

For exported V classes, `&T`, `?&T` and `!&T` bind the successful value to its PHP
class and reuse an existing PHP wrapper for the same V object. Exported
functions and methods can declare `@[vphp.PhpBorrowedReturn]` when they retain
ownership of the object.
An already pending PHP exception is preserved when an exported function or
method returns a V error.
Methods on classes that extend a native PHP class write changes to V-backed
scalar and `PhpValue` fields back to PHP before returning a value, `null`, or
an exception. `PhpValue` fields preserve PHP object identity and use PHP's
copy-on-write rules for arrays.
Writeback compares the final V value with the value loaded at method entry.
Unchanged fields retain PHP-side updates made during the call.

Generated struct-parameter and variadic closures can also return these object
types. The factory's PHP signature returns `Closure`. Reflection on the
closure itself reports the concrete class and nullability. Place
`@[vphp.PhpBorrowedReturn]` on the factory if the callback borrows the object
it returns. Variadic object callbacks accept positional arguments.

Variadic closures also accept bound object parameters declared as `...&T`
or `...?&T`. Reflection reports the concrete PHP class and whether each
argument can be `null`. Every supplied argument is checked before the V
callback runs, and a binding error identifies the argument position.

Reflection on generated closures also shows built-in return types such as
`int`, `?int`, `array`, and `void`. A successful V result has the reflected
type of its value. Returning a V error raises a PHP exception and preserves
any PHP exception that is already pending.

Factories can also return fixed-parameter callbacks, for example
`fn (count int, label ?string) string`. PHP callers can use those parameter
names, and a trailing optional V parameter defaults to `null`. Unnamed
parameters use `arg1`, `arg2`, and so on, with underscores added to avoid
collisions with declared names. Zero-argument callbacks use the same bridge.

A callback can combine fixed parameters with a variadic tail, for example
`fn (base int, offsets ...int) int`. PHP callers can name the fixed
parameters and can pass tail values positionally. The tail keeps its
declared name and element type in Reflection.

Scalar parameters use the PHP caller's strictness rules, including weak
scalar coercion. Each argument is checked when the bridge reads it, so
computed defaults run in field order.

On PHP 8.6, a named `?` placeholder can follow omitted V computed defaults.
For example, `format('prefix', enabled: ?)` leaves the intervening fields to V
on each invocation. PHP itself validates defaults copied into a partial
closure's `...` signature against its declared parameter types. If you want a
variadic forwarding closure that preserves omitted V defaults, use
`fn (...$args) => format('prefix', ...$args)`.

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
payload unless the exported class opts in with
`@[vphp.PhpObjectCopy(cloneable: true, serializable: true)]`.
Each option also works independently.

- `cloneable: true` requires a V method
  `fn (source &T) clone_into(mut target T)`. The bridge passes a fresh V
  instance to the method. Copy the object's state and clone or retain owned
  fields according to their lifetime rules. The bridge binds that instance
  and runs `init_php_state()` when declared, before Zend copies PHP properties
  and runs any PHP `__clone()` hook.
  A cloneable exported V descendant must embed its cloneable VPHP parent
  first and explicitly opt in. Copy the embedded payload by calling the
  parent's `clone_into()` from the descendant's implementation. Lifecycle
  hooks on the embedded parent are inherited unless the descendant overrides
  them.
- `serializable: true` requires public instance methods exported as
  `__serialize(): array` and `__unserialize(array $data): void`. The restore
  method is responsible for validating the data and restoring V state.
  Include any PHP-only properties that should survive the round trip.
  Both hooks must be available on every supported PHP version.
  An exported V descendant must embed its serializable VPHP parent first
  and declare its own public serialization hooks. Delegate to the parent's V
  hooks as needed and include the descendant's state in the same round trip.

Classes extending native PHP classes use the native parent's handlers.

On PHP 8.5 and later, `PhpObject.clone_with(properties)` creates a distinct
PHP object through Zend's `clone()` function with property updates. It uses
the object's clone handler and PHP's property access and type rules. Export a
PHP entry point for it with `PhpMethodSince(version: .php85)` or
`PhpFunctionSince(version: .php85)` to hide it on older versions.

`@[vphp.PhpZendPropertyCopy]` opts a root class with PHP-only instance state
into Zend's standard cloning and serialization. Exported descendants inherit
this policy along paths with no V fields or V cleanup methods.

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
