#!/bin/sh
set -eu

repo=$(CDPATH='' cd "$(dirname "$0")/../../.." && pwd -P)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/vphp-smoke.XXXXXX")
trap 'rm -rf "$tmp"' 0

project="$tmp/External Extension"
mkdir -p "$project/extra"
project=$(CDPATH='' cd "$project" && pwd -P)
cat > "$project/entry.v" <<'EOF'
module main

import extra
import vphp

const ext_config = vphp.ExtensionConfig{name: 'standalone_probe'}

@[vphp.PhpGlobals]
pub struct StandaloneGlobals {
pub mut:
	calls     int
	last_user string
}

@[vphp.PhpExportFunction(name: '')]
fn standalone_globals() string {
	vphp.with_globals[StandaloneGlobals](fn (mut globals StandaloneGlobals) {
		globals.calls++
		globals.last_user = 'smoke'
	})
	globals := vphp.get_globals[StandaloneGlobals]()
	return '${globals.calls}:${globals.last_user}'
}

@[vphp.PhpExportTask(name: 'smoke\\task\'run\$end')]
struct StandaloneNamedTask {
	value int
}

fn (task StandaloneNamedTask) run() vphp.TaskResult {
	return task.value + 1
}

@[php_task: 'LegacyStandaloneTask']
struct StandaloneLegacyTask {
	value int
}

fn (task StandaloneLegacyTask) run() vphp.TaskResult {
	return task.value + 2
}

@[vphp.PhpExportFunction(name: '')]
fn standalone_task_list(ctx vphp.Context) {
	vphp.task_list(ctx)
}

@[vphp.PhpExportFunction(name: '')]
fn standalone_task_spawn(ctx vphp.Context) {
	vphp.task_spawn(ctx)
}

@[vphp.PhpExportFunction(name: '')]
fn standalone_task_wait(ctx vphp.Context) {
	vphp.task_wait(ctx)
}

@[vphp.PhpExportConstant]
const standalone_text = 'first "quote" \\ path\nlast\x00tail'

@[vphp.PhpExportConstant]
const standalone_count = 7

@[vphp.PhpExportConstant]
const standalone_ratio = 2.0

@[vphp.PhpExportConstant]
const standalone_enabled = false

@[php_const]
const standalone_legacy = 'legacy'

@[vphp.PhpExportFunction(name: 'standalone_greeting')]
fn greeting_for_php(name string) string {
	return extra.greet(name)
}

@[vphp.PhpExportFunction(name: 'standaloneTagged')]
@[vphp.PhpCallableAttribute(name: 'VPHP\\Fixture\\SmokeCallable', args: '[1, "two"], "urn:vp:fixture", "foo=>1", "foo=1", level: 2, enabled: true, 标签: "a:b", colon: "a:b", foo: 1, arrow: "x=>y", Mode: "upper", mode: "lower", options: ["x", "4" => [true, "a=>b,c" => ["東京", null]], "next", "04" => [], "route:key" => ["x:y"], "x=y" => ["a=b"], "key" => 1, "key" => 2,],')]
@[vphp.PhpParameterAttribute('value', 'VPHP\\Fixture\\SmokeParameter', 'slot: "function", list: [2 => ["inner" => 5], "some" => ["雪", []]]')]
fn standalone_tagged(value string) string {
	return value
}

struct StandaloneProbeConstants {
	api_level int @[vphp.PhpClassConstantAttribute(name: 'VPHP\\Fixture\\SmokeConstant', args: 'slot: "api", level: 2')]
	fallback  string
}

const standalone_probe_constants = StandaloneProbeConstants{api_level: 7, fallback: 'old'}

@[vphp.PhpExportEnum(name: 'VPHP\\Smoke\\Mode')]
@[vphp.PhpEnumAttribute(name: 'VPHP\\Fixture\\SmokeType', args: 'kind: "enum", enabled: true, delay: 42ms, leading: 008, radix: 0b1010, factor: 1.25e2, zero: -0.0e0, min: -9223372036854775808, max: 9223372036854775807, overflow: 9223372036854775808, invalidFloat: 3.14suffix')]
pub enum StandaloneMode {
	active = 3 @[vphp.PhpEnumCaseAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "case", enabled: true')]
	idle
}

@[php_trait]
struct StandaloneLegacyTrait {}

@[vphp.PhpExportMethod(name: 'legacyTraitValue')]
pub fn (trait StandaloneLegacyTrait) legacy_trait_value() int {
	return 8
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\Probe')]
@[vphp.PhpClassAttribute(name: 'VPHP\\Fixture\\SmokeAttribute', args: 'channel: "http", retries: 2, enabled: true, ratio: 2.0, note: "line\\nnext", double: "say \\"你好\\", café", single: \'it\\\'s, 東京\', path: "C:\\\\Projects\\\\資料\\\\", unknown: "App\\Model", escaped: "\\u96EA \\U0001F680", outer: "\u96EA \U0001F680", bytes: "a\\x00b"')]
@[php_attr: 'LegacyText("雪, C:\\Projects")']
@[vphp.PhpDeclaredProperty('phpCount', 'int')]
@[vphp.PhpClassConstants(source: 'standalone_probe_constants')]
pub struct StandaloneProbe {
	StandaloneLegacyTrait
pub mut:
	caption_text string = 'initial' @[vphp.PhpProperty(name: 'captionText'); vphp.PhpPropertyAttribute(name: 'VPHP\\Fixture\\SmokeProperty', args: 'slot: "caption", enabled: true')]
	cache_key    string = 'secret' @[vphp.PhpIgnoreField]
	shared_count int @[vphp.PhpProperty(name: 'sharedCount'); vphp.PhpStaticProperty; vphp.PhpPropertyAttribute(name: 'VPHP\\Fixture\\SmokeProperty', args: 'slot: "shared"')]
	payload      vphp.PhpValue @[vphp.PhpPropertyAttribute(name: 'VPHP\\Fixture\\SmokeProperty', args: 'slot: "payload"')]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends(name: '\\Random\\RandomException')]
pub struct StandaloneUnrenamed {}

@[vphp.PhpExportInterface(name: 'VPHP\\Smoke\\ChildContract')]
@[vphp.PhpExtendsInterfaces(names: '\\vphp\\smoke\\basecontract')]
@[vphp.PhpInterfaceAttribute('VPHP\\Fixture\\SmokeType', 'kind: "interface"')]
pub interface StandaloneChildContract {}

@[vphp.PhpExportInterface(name: 'VPHP\\Smoke\\BaseContract')]
@[vphp.PhpInterfaceAttribute(name: 'VPHP\\Fixture\\NoArgs', args: '   ')]
pub interface StandaloneBaseContract {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\AbstractProbe')]
@[vphp.PhpAbstractClass]
@[vphp.PhpExtends(name: '\\vphp\\smoke\\abstractbase')]
@[vphp.PhpImplements(names: '\\vphp\\smoke\\childcontract')]
pub struct StandaloneAbstractProbe {
	StandaloneAbstractBase
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\AbstractBase')]
@[vphp.PhpAbstractClass]
pub struct StandaloneAbstractBase {
pub mut:
	label string = 'base' @[vphp.PhpPropertyAttribute(name: 'VPHP\\Fixture\\SmokeProperty', args: 'slot: "inherited"')]
}

@[vphp.PhpExportMethod(name: 'kind')]
@[vphp.PhpAbstractMethod]
pub fn StandaloneAbstractBase.probe_kind() string {
	return 'base'
}

@[vphp.PhpExportMethod(name: 'kind')]
@[vphp.PhpAbstractMethod]
pub fn StandaloneAbstractProbe.probe_kind() string {
	return 'probe'
}

@[vphp.PhpExportMethod(name: 'calculate')]
@[vphp.PhpAbstractMethod]
pub fn (probe StandaloneAbstractProbe) calculate_value(value int) int {
	return value
}

@[vphp.PhpExportMethod(name: 'answerValue')]
pub fn (probe StandaloneProbe) answer_value() int {
	return 42
}

@[vphp.PhpExportMethod(name: 'captionFromV')]
pub fn (probe StandaloneProbe) caption_from_v() string {
	return probe.caption_text
}

@[vphp.PhpExportMethod(name: 'taggedQuery')]
@[vphp.PhpCallableAttribute('VPHP\\Fixture\\SmokeCallable', 'level: 3, enabled: false')]
@[vphp.PhpParameterAttribute(v_name: 'value', name: 'VPHP\\Fixture\\SmokeParameter', args: 'slot: "method"')]
@[php_arg_name(value: 'query')]
pub fn (probe StandaloneProbe) tagged_query(value string) string {
	return value
}

@[vphp.PhpExportMethod(name: 'cacheKeyFromV')]
pub fn (probe StandaloneProbe) cache_key_from_v() string {
	return probe.cache_key
}

@[vphp.PhpExportMethod(name: '')]
pub fn StandaloneProbe.static_value() int {
	return 7
}

@[php_function]
@[vphp.PhpArgType('value', '(Iterator&Countable)|int')]
@[vphp.PhpReturnType(php_type: '(Iterator&Countable)|int')]
fn standalone_identity(value vphp.PhpValue) vphp.PhpValue {
	return value
}
EOF
cat > "$project/extra/extra.v" <<'EOF'
/* An exported module may have a block comment before its declaration. */
module extra

import vphp as bridge

pub fn greet(name string) string {
	return 'Hello ${name}'
}

@[bridge.PhpExportFunction(name: '')]
pub fn standalone_number() int {
	return 42
}
EOF

cat > "$tmp/verify-metadata.php" <<'EOF'
<?php
if (isset($argv[1])) {
    require $argv[1];
}
$expected = [
    'STANDALONE_TEXT' => "first \"quote\" \\ path\nlast\0tail",
    'STANDALONE_COUNT' => 7,
    'STANDALONE_RATIO' => 2.0,
    'STANDALONE_ENABLED' => false,
    'STANDALONE_LEGACY' => 'legacy',
];
foreach ($expected as $name => $value) {
    if (!defined($name) || defined(strtolower($name)) || constant($name) !== $value) {
        fwrite(STDERR, "Unexpected constant: $name\n");
        exit(1);
    }
}
$attributes = (new ReflectionClass(VPHP\Smoke\Probe::class))
    ->getAttributes(VPHP\Fixture\SmokeAttribute::class);
if (count($attributes) !== 1 || $attributes[0]->getArguments() !== [
    'channel' => 'http', 'retries' => 2, 'enabled' => true, 'ratio' => 2.0, 'note' => "line\nnext",
    'double' => 'say "你好", café', 'single' => "it's, 東京", 'path' => "C:\\Projects\\資料\\",
    'unknown' => 'App\\Model', 'escaped' => '雪 🚀', 'outer' => '雪 🚀', 'bytes' => "a\0b",
]) {
    fwrite(STDERR, "Unexpected class attribute metadata\n");
    exit(1);
}
$legacy = (new ReflectionClass(VPHP\Smoke\Probe::class))->getAttributes(LegacyText::class);
if (count($legacy) !== 1 || $legacy[0]->getArguments() !== ['雪, C:\\Projects']) {
    fwrite(STDERR, "Unexpected legacy class attribute metadata\n");
    exit(1);
}
foreach ([
    [VPHP\Smoke\Mode::class, [
        'kind' => 'enum', 'enabled' => true, 'delay' => '42ms', 'leading' => 8,
        'radix' => 10, 'factor' => 125.0, 'zero' => -0.0, 'min' => PHP_INT_MIN,
        'max' => PHP_INT_MAX, 'overflow' => '9223372036854775808', 'invalidFloat' => '3.14suffix',
    ]],
    [VPHP\Smoke\ChildContract::class, ['kind' => 'interface']],
] as [$type, $args]) {
    $attributes = (new ReflectionClass($type))->getAttributes(VPHP\Fixture\SmokeType::class);
    if (count($attributes) !== 1 || $attributes[0]->getTarget() !== Attribute::TARGET_CLASS
        || $attributes[0]->getArguments() !== $args
        || (isset($args['zero']) && fdiv(1.0, $attributes[0]->getArguments()['zero']) !== -INF)) {
        fwrite(STDERR, "Unexpected type attribute metadata for $type\n");
        exit(1);
    }
}
$parentAttributes = (new ReflectionClass(VPHP\Smoke\BaseContract::class))->getAttributes();
if (count($parentAttributes) !== 1 || $parentAttributes[0]->getName() !== VPHP\Fixture\NoArgs::class
    || $parentAttributes[0]->getArguments() !== []) {
    fwrite(STDERR, "Unexpected arguments on the parent interface attribute\n");
    exit(1);
}
foreach ([
    [VPHP\Smoke\Probe::class, 'captionText', 'string', false, ['slot' => 'caption', 'enabled' => true]],
    [VPHP\Smoke\Probe::class, 'sharedCount', 'int', true, ['slot' => 'shared']],
    [VPHP\Smoke\Probe::class, 'payload', '', false, ['slot' => 'payload']],
    [VPHP\Smoke\AbstractProbe::class, 'label', 'string', false, ['slot' => 'inherited']],
] as [$class, $name, $type, $static, $args]) {
    $property = new ReflectionProperty($class, $name);
    $attributes = $property->getAttributes(VPHP\Fixture\SmokeProperty::class);
    $declaringClass = $name === 'label' ? VPHP\Smoke\AbstractBase::class : $class;
    if ((string) $property->getType() !== $type || $property->isStatic() !== $static
        || $property->getDeclaringClass()->getName() !== $declaringClass
        || count($attributes) !== 1 || $attributes[0]->getArguments() !== $args) {
        fwrite(STDERR, "Unexpected property metadata for $class::$name\n");
        exit(1);
    }
}
$constant = new ReflectionClassConstant(VPHP\Smoke\Probe::class, 'API_LEVEL');
$enum = new ReflectionEnum(VPHP\Smoke\Mode::class);
$case = $enum->getCase('active');
foreach ([
    [$constant, ['slot' => 'api', 'level' => 2]],
    [$case, ['slot' => 'case', 'enabled' => true]],
    [new ReflectionClassConstant(VPHP\Smoke\Mode::class, 'active'), ['slot' => 'case', 'enabled' => true]],
] as [$member, $args]) {
    $attributes = $member->getAttributes(VPHP\Fixture\SmokeConstant::class);
    if (count($attributes) !== 1 || $attributes[0]->getTarget() !== Attribute::TARGET_CLASS_CONSTANT
        || $attributes[0]->getArguments() !== $args) {
        fwrite(STDERR, "Unexpected constant attribute metadata for {$member->getName()}\n");
        exit(1);
    }
}
if ($constant->getValue() !== 7
    || (PHP_VERSION_ID >= 80300 && (string) $constant->getType() !== 'int')
    || !$case->isEnumCase() || $case->getBackingValue() !== 3 || $enum->getCase('idle')->getBackingValue() !== 4
    || $enum->getCase('idle')->getAttributes() !== []
    || (new ReflectionClassConstant(VPHP\Smoke\Probe::class, 'FALLBACK'))->getAttributes() !== []) {
    fwrite(STDERR, "Unexpected class constant or enum case metadata\n");
    exit(1);
}
foreach ([
    [new ReflectionFunction('standaloneTagged'), 'value', [
        [1, 'two'], 'urn:vp:fixture', 'foo=>1', 'foo=1', 'level' => 2, 'enabled' => true, '标签' => 'a:b', 'colon' => 'a:b', 'foo' => 1, 'arrow' => 'x=>y',
        'Mode' => 'upper', 'mode' => 'lower',
        'options' => ['x', 4 => [true, 'a=>b,c' => ['東京', null]], 5 => 'next', '04' => [], 'route:key' => ['x:y'], 'x=y' => ['a=b'], 'key' => 2],
    ], ['slot' => 'function', 'list' => [2 => ['inner' => 5], 'some' => ['雪', []]]]],
    [new ReflectionMethod(VPHP\Smoke\Probe::class, 'taggedQuery'), 'query',
        ['level' => 3, 'enabled' => false], ['slot' => 'method']],
] as [$callable, $name, $callableArgs, $parameterArgs]) {
    $callableAttributes = $callable->getAttributes(VPHP\Fixture\SmokeCallable::class);
    if (count($callableAttributes) !== 1 || $callableAttributes[0]->getArguments() !== $callableArgs) {
        fwrite(STDERR, "Unexpected callable metadata for {$callable->getName()}\n");
        exit(1);
    }
    if (isset($callableArgs['options'])) {
        $modified = $callableAttributes[0]->getArguments();
        $modified['options'][4]['a=>b,c'][0] = 'changed';
        $modified['options'][] = 'appended';
        if ($callableAttributes[0]->getArguments() !== $callableArgs) {
            fwrite(STDERR, "Mutating a reflected array changed attribute metadata\n");
            exit(1);
        }
    }
    $parameter = $callable->getParameters()[0];
    $attributes = $parameter->getAttributes(VPHP\Fixture\SmokeParameter::class);
    if ($parameter->getName() !== $name || count($attributes) !== 1
        || $attributes[0]->getArguments() !== $parameterArgs) {
        fwrite(STDERR, "Unexpected parameter metadata for {$callable->getName()}\n");
        exit(1);
    }
}
EOF

cd "$project"
"$repo/bin/vphp" check
test ! -e build
"$repo/bin/vphp" build
test -f "$project/build/standalone_probe.so"
"${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" "$tmp/verify-metadata.php"
if ! "${VPHP_PHP:-php}" -n -d display_startup_errors=1 -d error_reporting=-1 -d "extension=$project/build/standalone_probe.so" -r '
    $class = new ReflectionClass(VPHP\Smoke\Probe::class);
    $method = $class->getMethod("answerValue");
    $probe = new VPHP\Smoke\Probe();
    $identity = new ReflectionFunction("standalone_identity");
    $abstract = new ReflectionClass(VPHP\Smoke\AbstractProbe::class);
    $kind = $abstract->getMethod("kind");
    class SmokeConcreteProbe extends VPHP\Smoke\AbstractProbe {
        public function calculate(int $value): int { return $value + 1; }
        public static function kind(): string { return "concrete"; }
    }
    $concrete = new SmokeConcreteProbe();
    $namedTask = "smoke\\task" . chr(39) . "run\$end";
    $taskNames = standalone_task_list();
    sort($taskNames);
    if (!extension_loaded("standalone_probe")
        || standalone_globals() !== "1:smoke"
        || standalone_globals() !== "2:smoke"
        || $taskNames !== ["LegacyStandaloneTask", $namedTask]
        || standalone_task_wait(standalone_task_spawn($namedTask, 4)) !== 5
        || standalone_task_wait(standalone_task_spawn("LegacyStandaloneTask", 4)) !== 6
        || standalone_greeting(name: "PHP") !== "Hello PHP"
        || standaloneTagged(value: "PHP") !== "PHP"
        || function_exists("greeting_for_php")
        || class_exists("StandaloneProbe", false)
        || !is_subclass_of(StandaloneUnrenamed::class, Random\RandomException::class)
        || $class->getNamespaceName() !== "VPHP\\Smoke"
        || $method->getName() !== "answerValue"
        || $probe->answerValue() !== 42
        || $probe->legacyTraitValue() !== 8
        || $probe->taggedQuery(query: "PHP") !== "PHP"
        || VPHP\Smoke\Probe::API_LEVEL !== 7
        || $class->getReflectionConstant("API_LEVEL")->getValue() !== 7
        || $class->hasProperty("caption_text")
        || $class->hasProperty("cache_key")
        || $probe->cacheKeyFromV() !== "secret"
        || (string) $class->getProperty("captionText")->getType() !== "string"
        || $probe->captionText !== "initial"
        || (string) $class->getProperty("phpCount")->getType() !== "int"
        || $probe->phpCount !== 0
        || !$class->getProperty("sharedCount")->isStatic()
        || VPHP\Smoke\Probe::$sharedCount !== 0
        || VPHP\Smoke\Probe::static_value() !== 7
        || !$abstract->isAbstract()
        || $abstract->isInstantiable()
        || !is_subclass_of(VPHP\Smoke\ChildContract::class, VPHP\Smoke\BaseContract::class)
        || !$abstract->implementsInterface(VPHP\Smoke\ChildContract::class)
        || !$abstract->getMethod("calculate")->isAbstract()
        || !$kind->isAbstract()
        || !$kind->isStatic()
        || (string) $kind->getReturnType() !== "string"
        || $kind->getPrototype()->getDeclaringClass()->getName() !== VPHP\Smoke\AbstractBase::class
        || $concrete->calculate(value: 41) !== 42
        || SmokeConcreteProbe::kind() !== "concrete"
        || (string) $abstract->getProperty("label")->getType() !== "string"
        || standalone_number() !== 42
        || standalone_identity(value: 7) !== 7
        || (string) $identity->getParameters()[0]->getType() !== "(Iterator&Countable)|int"
        || (string) $identity->getReturnType() !== "(Iterator&Countable)|int") {
        exit(1);
    }
    $probe->captionText = "updated";
    $probe->phpCount = 12;
    $concrete->label = "written";
    if ($concrete->label !== "written") {
        exit(1);
    }
    VPHP\Smoke\Probe::$sharedCount = 9;
    if ($probe->captionFromV() !== "updated" || $probe->phpCount !== 12
        || $class->getStaticPropertyValue("sharedCount") !== 9) {
        exit(1);
    }
    try {
        standalone_identity(new stdClass());
    } catch (TypeError) {
        exit(0);
    }
    exit(1);
' > "$tmp/load.log" 2>&1; then
    cat "$tmp/load.log" >&2
    exit 1
fi
if [ -s "$tmp/load.log" ]; then
    cat "$tmp/load.log" >&2
    exit 1
fi
if "${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" -r '
    class SmokeIncompleteProbe extends VPHP\Smoke\AbstractProbe {
        public function calculate(int $value): int { return $value; }
    }
' > "$tmp/incomplete.log" 2>&1; then
    echo 'PHP accepted a subclass without the abstract static method' >&2
    exit 1
fi
grep -F 'AbstractProbe::kind' "$tmp/incomplete.log"
"$repo/bin/vphp" stub --output "$tmp/Standalone Stub.php"
"${VPHP_PHP:-php}" -n -l "$tmp/Standalone Stub.php"
"${VPHP_PHP:-php}" -n "$tmp/verify-metadata.php" "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'function standalone_identity((\Iterator&\Countable)|int $value): (\Iterator&\Countable)|int' "$tmp/Standalone Stub.php"
grep -F 'function standalone_greeting(string $name): string' "$tmp/Standalone Stub.php"
grep -F 'function answerValue(): int' "$tmp/Standalone Stub.php"
grep -F 'namespace VPHP\Smoke {' "$tmp/Standalone Stub.php"
grep -F 'class Probe' "$tmp/Standalone Stub.php"
grep -E 'const (int )?API_LEVEL = 7;' "$tmp/Standalone Stub.php"
grep -F 'abstract class AbstractProbe' "$tmp/Standalone Stub.php"
grep -F 'interface ChildContract extends \VPHP\Smoke\BaseContract' "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'abstract public function calculate(int $value): int;' "$tmp/Standalone Stub.php"
grep -F 'abstract public static function kind(): string;' "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'public string $captionText;' "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'public static int $sharedCount;' "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'public int $phpCount;' "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
if grep -F '$cache_key' "$tmp/Standalone Stub.php"; then
    exit 1
fi
grep -F 'class StandaloneUnrenamed extends \Random\RandomException' "$tmp/Standalone Stub.php"
test ! -e vphp_bridge.v
test ! -e extra/vphp_bridge.v
test ! -e php_bridge.c

cp "$project/entry.v" "$tmp/valid.v"
sed 's/return extra.greet(name)/return 42/' "$project/entry.v" > "$tmp/broken.v"
mv "$tmp/broken.v" "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/check.log" 2>&1; then
    echo 'check accepted an invalid V return value' >&2
    exit 1
fi
grep -F "$project/entry.v:" "$tmp/check.log"

sed 's/PhpExportFunction(name:/PhpExportFunction(unknown:/' "$tmp/valid.v" > "$tmp/broken-attribute.v"
mv "$tmp/broken-attribute.v" "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/attribute.log" 2>&1; then
    echo 'check accepted an invalid V export attribute' >&2
    exit 1
fi
grep -F 'error:' "$tmp/attribute.log" | grep -F 'PhpExportFunction'

sed 's/PhpExportFunction(name:/PhpExportClass(name:/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/target.log" 2>&1; then
    echo 'check accepted a class export attribute on a function' >&2
    exit 1
fi
grep -F 'cannot be applied to `fn`' "$tmp/target.log" | grep -F 'PhpExportClass'

assert_attribute_diagnostic() {
    sed "/SmokeCallable.*args: '\\[1, \"two\"\\]/s|args: '[^']*'|args: '$1'|" "$tmp/valid.v" > "$project/entry.v"
    if "$repo/bin/vphp" check > "$tmp/attribute-args.log" 2>&1; then
        echo "check accepted invalid PHP attribute arguments: $1" >&2
        exit 1
    fi
    grep -F 'SmokeCallable on standaloneTagged' "$tmp/attribute-args.log" | grep -F "$2"
}

assert_attribute_diagnostic '[1, [true => "bad"]]' 'array keys must be integers or strings'
assert_attribute_diagnostic '[2 => ]' 'expected a key and a value'
assert_attribute_diagnostic '[9223372036854775806 => 1, 2, 3]' 'cannot append after the maximum'
assert_attribute_diagnostic '[1, [2,, 3]]' 'expected an element before comma'
assert_attribute_diagnostic '[1] [2]' 'expected a comma after PHP attribute array'
assert_attribute_diagnostic '[1 => 2 => 3]' 'expected at most one'
assert_attribute_diagnostic '["unclosed]' 'unclosed quoted string'

assert_attribute_diagnostic 'level: 1, level: 2' 'duplicate named argument `level`'
assert_attribute_diagnostic 'first: 1, 2' 'positional argument cannot follow a named argument'
assert_attribute_diagnostic 'label:' 'missing value for named argument `label`'
assert_attribute_diagnostic '1bad: 1' 'invalid named argument `1bad`'
assert_attribute_diagnostic ',1' 'empty argument before comma in PHP attribute argument list'
assert_attribute_diagnostic '1,,2' 'empty argument before comma in PHP attribute argument list'
assert_attribute_diagnostic '1, ,' 'empty argument before comma in PHP attribute argument list'
assert_attribute_diagnostic ',' 'empty argument before comma in PHP attribute argument list'
assert_attribute_diagnostic 'label: "unclosed' 'unclosed quoted string in PHP attribute argument list'
assert_attribute_diagnostic '1 2' 'expected a comma between PHP attribute values'
assert_attribute_diagnostic 'first: true second: false' 'expected a comma between PHP attribute values'
assert_attribute_diagnostic '1"two"' 'expected a comma between PHP attribute values'
assert_attribute_diagnostic '"one" "two"' 'expected a comma after PHP attribute quoted string'
assert_attribute_diagnostic 'label: "one"suffix' 'expected a comma after PHP attribute quoted string'
assert_attribute_diagnostic '["one" false]' 'expected a comma after PHP attribute quoted string'

assert_attribute_diagnostic ': 1' 'missing name before `:` in PHP attribute argument'
assert_attribute_diagnostic 'foo-bar: 1' 'invalid named argument `foo-bar`'
assert_attribute_diagnostic '"foo": 1' 'invalid named argument `"foo"`'

assert_attribute_diagnostic 'foo::1' 'unexpected extra `:` in PHP attribute argument `foo`'
assert_attribute_diagnostic 'foo: 1:2' 'unexpected extra `:` in PHP attribute argument `foo`'
assert_attribute_diagnostic '[1:2]' 'unexpected unquoted `:` in PHP attribute array'
assert_attribute_diagnostic '[foo:bar => 1]' 'unexpected unquoted `:` in PHP attribute array'

assert_attribute_diagnostic 'foo=>1' '`=>` is only allowed between a key and value in a PHP attribute array'
assert_attribute_diagnostic 'foo: left => right' '`=>` is only allowed between a key and value in a PHP attribute array'
assert_attribute_diagnostic '[1] => 2' '`=>` is only allowed between a key and value in a PHP attribute array'

assert_attribute_diagnostic 'foo=1' 'unexpected unquoted `=` in PHP attribute value'
assert_attribute_diagnostic '[foo=1]' 'unexpected unquoted `=` in PHP attribute value'
assert_attribute_diagnostic '[foo = 1]' 'unexpected unquoted `=` in PHP attribute value'
assert_attribute_diagnostic '[foo=1 => 2]' 'unexpected unquoted `=` in PHP attribute value'
