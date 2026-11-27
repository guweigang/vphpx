#!/bin/sh
set -eu

repo=$(CDPATH='' cd "$(dirname "$0")/../../.." && pwd -P)
v -path "$repo:@vlib" test "$repo/cmd/vphp"
sh "$repo/cmd/vphp/tests/scaffold.sh"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/vphp-smoke.XXXXXX")
trap 'rm -rf "$tmp"' 0
vhttpd_root=
if [ -n "${VHTTPD_ROOT:-}" ]; then
    vhttpd_root=$(CDPATH='' cd "$VHTTPD_ROOT" && pwd -P)
fi

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

@[vphp.PhpExportConstant(name: '\\VPHP\\Smoke_First\\VALUE')]
@[vphp.PhpGlobalConstantAttribute(name: 'VPHP\\Fixture\\SmokeGlobalConstant', args: 'kind: "global constant", data: ["nested" => [1, "雪"]]')]
const first_value = '雪\\path'

@[vphp.PhpExportConstant]
@[vphp.PhpGlobalConstantAttribute('Deprecated', 'message: "use STANDALONE_COUNT", since: "8.5"')]
const standalone_old_count = 7

@[vphp.PhpExportConstant(name: 'VPHP\\Smoke_First\\Value')]
const first_case_variant = false

@[vphp.PhpExportConstant(name: 'VPHP\\Smoke_First\\RATIO')]
const first_ratio = 2.0

@[vphp.PhpExportFunction(name: 'standalone_greeting')]
fn greeting_for_php(name string) string {
	return extra.greet(name)
}

@[vphp.PhpExportFunction(name: 'VPHP\\Smoke\\checkedResult')]
@[vphp.PhpCallableAttribute(name: 'NoDiscard', args: 'message: "use the function result"')]
fn checked_result() int {
	return 17
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\StringDefault')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'label', php_type: 'string', default_value: "'雪'")]
pub struct StandaloneStringDefault {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\IntDefault')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'limit', php_type: 'int', default_value: '-12')]
pub struct StandaloneIntDefault {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\FloatDefault')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'ratio', php_type: 'f64', default_value: '2')]
pub struct StandaloneFloatDefault {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\BoolDefault')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'enabled', php_type: 'bool', default_value: 'true')]
pub struct StandaloneBoolDefault {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\NullDefault')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'optionalValue', php_type: 'mixed', default_value: 'null')]
pub struct StandaloneNullDefault {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\NullableProperties')]
@[vphp.PhpDeclaredProperty(name: 'text', php_type: '?string')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'label', php_type: '?string', default_value: "'ready'")]
pub struct StandaloneNullableProperties {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\NullableObject')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'date', php_type: '?\\DateTimeImmutable', default_value: 'null')]
pub struct StandaloneNullableObject {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\UnionProperties')]
@[vphp.PhpDeclaredProperty(name: 'value', php_type: 'INT|string')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'label', php_type: 'float|string', default_value: '2')]
pub struct StandaloneUnionProperties {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\UnionObjects')]
@[vphp.PhpDeclaredProperty(name: 'textOrDate', php_type: 'string|\\DateTimeImmutable')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'date', php_type: '\\DateTimeImmutable|\\DateTime|int|null', default_value: 'null')]
pub struct StandaloneUnionObjects {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\CompoundProperties')]
@[vphp.PhpDeclaredProperty(name: 'collection', php_type: 'Countable&IteratorAggregate')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'entry', php_type: '(Countable&Iterator)|int|null', default_value: 'null')]
pub struct StandaloneCompoundProperties {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ProtectedSetter')]
@[vphp.PhpDeclaredPropertyWithSetVisibility('score', set_visibility: .protected, php_type: 'int')]
pub struct StandaloneProtectedSetter {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\PrivateSetter')]
@[vphp.PhpDeclaredPropertyWithSetVisibility('note', 'mixed', .private)]
pub struct StandalonePrivateSetter {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ReadonlyVisibility')]
@[vphp.PhpDeclaredReadonlyProperty('note', 'string', .protected)]
pub struct StandaloneReadonlyVisibility {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ReadonlyRecord')]
@[vphp.PhpReadonlyClass]
@[vphp.PhpDeclaredProperty('number', 'int')]
@[vphp.PhpDeclaredReadonlyProperty('payload', 'mixed', .public)]
pub struct StandaloneReadonlyRecord {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ReadonlyEmpty')]
@[vphp.PhpReadonlyClass]
pub struct StandaloneReadonlyEmpty {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ReadonlyValue')]
@[vphp.PhpReadonlyClass]
pub struct StandaloneReadonlyValue {
pub:
	value int = 7
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\DynamicRecord')]
@[vphp.PhpClassAttribute('AllowDynamicProperties', '')]
pub struct StandaloneDynamicRecord {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\DynamicRecordChild')]
@[vphp.PhpExtends('StandaloneDynamicRecord')]
pub struct StandaloneDynamicRecordChild {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\DynamicControl')]
pub struct StandaloneDynamicControl {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\RestrictedDefaults')]
@[vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault(default_value: '["tags" => ["雪", null]]', set_visibility: .protected, php_type: 'array', name: 'options')]
pub struct StandaloneRestrictedDefaults {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\RestrictedNullDefault')]
@[vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault('note', '?string', .private, 'null')]
pub struct StandaloneRestrictedNullDefault {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\RestrictedStatic')]
@[vphp.PhpDeclaredStaticPropertyWithSetVisibility('note', '?string', .private)]
@[vphp.PhpDeclaredStaticPropertyWithSetVisibilityAndDefault(name: 'limit', php_type: 'int', set_visibility: .protected, default_value: '3')]
pub struct StandaloneRestrictedStatic {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\FinalProperty')]
@[vphp.PhpFinalDeclaredProperty('limit')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'limit', php_type: 'int', default_value: '3')]
@[vphp.PhpDeclaredProperty('other', 'int')]
pub struct StandaloneFinalProperty {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ProtectedProperty')]
@[vphp.PhpDeclaredPropertyVisibility(name: 'count', visibility: .protected)]
@[vphp.PhpDeclaredPropertyWithDefault('count', 'int', '3')]
pub struct StandaloneProtectedProperty {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\PrivateProperty')]
@[vphp.PhpDeclaredPropertyWithDefault('secret', 'string', "'parent'")]
@[vphp.PhpDeclaredPropertyVisibility('secret', .private)]
pub struct StandalonePrivateProperty {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\RestrictedProperty')]
@[vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault('level', 'int', .private, '4')]
@[vphp.PhpDeclaredPropertyVisibility('level', .protected)]
pub struct StandaloneRestrictedProperty {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\SymmetricPrivateProperty')]
@[vphp.PhpDeclaredPropertyWithSetVisibility('note', '?string', .private)]
@[vphp.PhpDeclaredPropertyVisibility('note', .private)]
pub struct StandaloneSymmetricPrivateProperty {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\FinalMethods')]
pub struct StandaloneFinalMethods {}

@[vphp.PhpExportMethod(name: 'fixedValue')]
@[vphp.PhpFinalMethod]
pub fn (target StandaloneFinalMethods) fixed_value(value int) int {
	return value + 1
}

@[vphp.PhpExportMethod(name: 'staticValue')]
@[vphp.PhpFinalMethod]
pub fn StandaloneFinalMethods.static_value() int {
	return 7
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\OverrideBase')]
pub struct StandaloneOverrideBase {}

@[vphp.PhpExportMethod(name: 'parentValue')]
pub fn StandaloneOverrideBase.parent_value() int {
	return 1
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\OverrideChild')]
@[vphp.PhpExtends('StandaloneOverrideBase')]
pub struct StandaloneOverrideChild {}

@[vphp.PhpExportMethod(name: 'ParentValue')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn StandaloneOverrideChild.parent_value() int {
	return 2
}

@[vphp.PhpExportInterface(name: 'VPHP\\Smoke\\OverrideContract')]
pub interface StandaloneOverrideContract {
	value() int
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\OverrideImplementation')]
@[vphp.PhpImplements('StandaloneOverrideContract')]
pub struct StandaloneOverrideImplementation {}

@[vphp.PhpExportMethod(name: 'value')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target StandaloneOverrideImplementation) value() int {
	return 3
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\FinalConstructor')]
pub struct StandaloneFinalConstructor {
pub mut:
	start int
}

@[vphp.PhpExportMethod(name: '__construct')]
@[vphp.PhpFinalMethod]
pub fn (mut target StandaloneFinalConstructor) init_with_value(start int) {
	target.start = start
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ArrayDefault')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'options', php_type: 'array', default_value: '["tags" => ["雪", null], 4 => ["enabled" => true], "08" => "kept", 7, "4" => ["enabled" => false]]')]
pub struct StandaloneArrayDefault {}

struct StandaloneRestrictedConstants {
	locked  int    @[vphp.PhpClassConstantVisibility(visibility: .protected); vphp.PhpFinalClassConstant]
	secret  string @[vphp.PhpClassConstantVisibility(.private)]
	ratio   f64    @[vphp.PhpClassConstantVisibility(.public)]
	visible bool
}

const standalone_restricted_constants = StandaloneRestrictedConstants{
	locked: 7
	secret: '雪 "quoted" \\ path\x00end'
	ratio: 1.25
	visible: true
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\RestrictedConstants')]
pub struct StandaloneConstantModifiers {}

const restricted_constant_table = vphp.PhpConstantTable[StandaloneConstantModifiers, StandaloneRestrictedConstants]{
	values: standalone_restricted_constants
}

struct StandaloneInterfaceValues {
	limit int @[vphp.PhpClassConstantAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "contract"'); vphp.PhpFinalClassConstant]
	revision int
	contract_mode StandaloneEnumAliasTarget @[vphp.PhpClassConstantAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "contract mode"'); vphp.PhpFinalClassConstant]
}

const standalone_interface_values = StandaloneInterfaceValues{
	limit: 7
	revision: 1
	contract_mode: .ready
}

struct StandaloneRevisionValue {
	revision int
	default_mode StandaloneEnumConstants @[vphp.PhpClassConstantAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "class mode"')]
}

const standalone_interface_revision = StandaloneRevisionValue{revision: 2}
const standalone_class_revision = StandaloneRevisionValue{
	revision: 3
	default_mode: StandaloneEnumConstants.active
}
const standalone_child_revision = StandaloneRevisionValue{revision: 4}

@[vphp.PhpExportInterface(name: 'VPHP\\Smoke\\VersionedContract')]
@[vphp.PhpExtendsInterfaces('StandaloneConstantContract')]
@[vphp.PhpInterfaceConstants(source: 'standalone_interface_revision')]
pub interface StandaloneVersionedContract {}

@[vphp.PhpExportInterface(name: 'VPHP\\Smoke\\ConstantContract')]
pub interface StandaloneConstantContract {}

const contract_constant_table = vphp.PhpConstantTable[StandaloneConstantContract, StandaloneInterfaceValues]{
	values: standalone_interface_values
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ConstantImplementation')]
@[vphp.PhpImplements('StandaloneVersionedContract')]
@[vphp.PhpClassConstants('standalone_class_revision')]
@[vphp.PhpDeclaredPropertyWithDefault('label', 'string', "'parent'")]
pub struct StandaloneConstantImplementation {
	StandaloneCaseTrait
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ConstantImplementationChild')]
@[vphp.PhpExtends('StandaloneConstantImplementation')]
@[vphp.PhpClassConstants('standalone_child_revision')]
pub struct StandaloneConstantImplementationChild {}

struct StandaloneEnumValues {
	active int @[vphp.PhpClassConstantAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "enum constant"')]
	limit  f64 @[vphp.PhpClassConstantVisibility(.protected); vphp.PhpFinalClassConstant]
	secret string @[vphp.PhpClassConstantVisibility(.private)]
	preferred StandaloneEnumConstants @[vphp.PhpClassConstantAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "enum alias"')]
	inferred StandaloneEnumConstants @[vphp.PhpClassConstantVisibility(.protected); vphp.PhpFinalClassConstant]
	remote StandaloneEnumAliasTarget
}

const standalone_enum_values = StandaloneEnumValues{
	active: 42
	secret: '雪 "enum" \\ path\x00end'
	limit: 2.5
	preferred: StandaloneEnumConstants.active
	inferred: .active
	remote: StandaloneEnumAliasTarget.ready
}

@[vphp.PhpExportEnum(name: 'VPHP\\Smoke\\EnumConstants')]
pub enum StandaloneEnumConstants {
	active = 7 @[vphp.PhpEnumCaseAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "enum case"')]
	idle
}

const enum_constant_table = vphp.PhpConstantTable[StandaloneEnumConstants, StandaloneEnumValues]{
	values: standalone_enum_values
}

@[vphp.PhpExportEnum(name: 'VPHP\\Smoke\\EnumAliasTarget')]
pub enum StandaloneEnumAliasTarget {
	ready = 7
}

struct StandaloneTraitValues {
	trait_mode StandaloneEnumAliasTarget @[vphp.PhpClassConstantAttribute('VPHP\\Fixture\\SmokeConstant', 'slot: "trait mode"'); vphp.PhpFinalClassConstant]
	trait_idle StandaloneEnumConstants @[vphp.PhpClassConstantVisibility(.protected)]
	fallback   string
}

const standalone_trait_values = StandaloneTraitValues{
	trait_mode: StandaloneEnumAliasTarget.ready
	trait_idle: .idle
	fallback: 'trait'
}

@[vphp.PhpExportTrait(name: 'VPHP\\Smoke\\CombinedCaseTrait')]
@[vphp.PhpTraitAliases(aliases: 'VPHP\\Smoke\\CaseTrait::traitLabel as private, VPHP\\Smoke\\CaseTrait::TRAITLABEL as init')]
struct StandaloneCombinedCaseTrait {}

const combined_trait_rules = vphp.PhpTraitRules[StandaloneCombinedCaseTrait]{
	uses: combined_trait_sources
	precedences: combined_trait_precedences
	adaptations: combined_trait_adaptations
}

const combined_trait_sources = [
	vphp.PhpNativeTraitSource(StandaloneRivalCaseTrait{}),
	StandaloneCaseTrait{},
	StandaloneAlternateCaseTrait{},
	StandalonePrivateRequirement{},
]

const combined_trait_precedences = [
	vphp.PhpTraitPrecedence{
		source: StandaloneCaseTrait{}
		method: 'TRAITLABEL'
		instead_of: [StandaloneRivalCaseTrait{}, StandaloneAlternateCaseTrait{}]
	},
]

const combined_trait_adaptations = [
	vphp.PhpTraitAdaptation{source: StandaloneCaseTrait{}, method: 'traitDouble', is_final: true},
	vphp.PhpTraitAdaptation{source: StandaloneCaseTrait{}, method: 'traitDouble', alias: 'twice', is_final: true},
	vphp.PhpTraitAdaptation{source: StandaloneCaseTrait{}, method: '__construct', alias: 'reinitialize'},
	vphp.PhpTraitAdaptation{
		source: StandaloneRivalCaseTrait{}
		method: 'traitLabel'
		alias: 'rivalLabel'
		visibility: .protected
		is_final: true
	},
]

@[vphp.PhpExportTrait(name: 'VPHP\\Smoke\\RivalCaseTrait')]
struct StandaloneRivalCaseTrait {}

@[vphp.PhpExportMethod(name: 'traitLabel')]
@[vphp.PhpArgDefault(v_name: 'number', default_value: '5')]
pub fn (trait StandaloneRivalCaseTrait) rival_label(number int) string {
	return 'rival:' + number.str()
}

@[vphp.PhpExportTrait(name: 'VPHP\\Smoke\\AlternateCaseTrait')]
struct StandaloneAlternateCaseTrait {}

@[vphp.PhpExportMethod(name: 'traitLabel')]
pub fn (trait StandaloneAlternateCaseTrait) alternate_label(label string) string {
	return 'alternate:' + label
}

@[vphp.PhpExportTrait(name: 'VPHP\\Smoke\\CaseTrait')]
@[vphp.PhpClassConstants('standalone_trait_values')]
@[vphp.PhpDeclaredPropertyWithDefault('traitLevel', 'int', '2')]
struct StandaloneCaseTrait {}

@[vphp.PhpExportMethod(name: '__construct')]
@[vphp.PhpArgDefaults(defaults: 'level=3,offset=0')]
pub fn (trait StandaloneCaseTrait) init_trait(ctx vphp.Context, level int, offset int) {
	value := vphp.RequestOwnedZBox.new_int(i64(level) + i64(offset)).to_zval()
	ctx.ex.this_zend_object().set_prop('traitLevel', value)
}

@[vphp.PhpExportMethod(name: 'traitLabel')]
@[vphp.PhpArgDefault(v_name: 'label', default_value: "'default'")]
pub fn (trait StandaloneCaseTrait) trait_label(label string) string {
	return 'trait:' + label
}

@[vphp.PhpExportMethod(name: 'traitDouble')]
pub fn StandaloneCaseTrait.trait_double(value int) int {
	return value * 2
}

@[vphp.PhpExportTrait(name: 'VPHP\\Smoke\\PrivateRequirement')]
struct StandalonePrivateRequirement {}

@[vphp.PhpExportMethod(name: 'formatValue')]
@[vphp.PhpAbstractMethod]
@[vphp.PhpMethodVisibility(.private)]
fn (trait StandalonePrivateRequirement) format_value(value int) string {
	return value.str()
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\MethodVisibility')]
pub struct StandaloneMethodVisibility {}

@[vphp.PhpExportMethod(name: 'privateInstance')]
@[vphp.PhpMethodVisibility(.private)]
pub fn (target StandaloneMethodVisibility) private_instance() int {
	return 11
}

@[vphp.PhpExportMethod(name: 'privateStatic')]
@[vphp.PhpMethodVisibility(visibility: .private)]
pub fn StandaloneMethodVisibility.private_static() int {
	return 12
}

@[vphp.PhpExportMethod(name: 'restricted')]
@[vphp.PhpMethodVisibility(.protected)]
pub fn (target StandaloneMethodVisibility) restricted() int {
	return 13
}

@[vphp.PhpExportMethod(name: 'promoted')]
@[vphp.PhpMethodVisibility(.public)]
fn (target StandaloneMethodVisibility) promoted() int {
	return 14
}

@[vphp.PhpExportMethod(name: 'defaultProtected')]
fn (target StandaloneMethodVisibility) default_protected() int {
	return 15
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\PrivateConstructor')]
pub struct StandalonePrivateConstructor {}

@[vphp.PhpExportMethod(name: '__construct')]
@[vphp.PhpFinalMethod]
@[vphp.PhpMethodVisibility(.private)]
pub fn (mut target StandalonePrivateConstructor) initialize() {
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\UnionArrayDefault')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'options', php_type: 'int|array|null', default_value: '[[]]')]
pub struct StandaloneUnionArrayDefault {}

@[vphp.PhpExportFunction(name: '\\VPHP\\Smoke_First\\hello')]
@[vphp.PhpArgDefault(v_name: 'punctuation', default_value: "'!'")]
@[vphp.PhpCallableAttribute(name: 'VPHP\\Fixture\\SmokeCallable', args: 'slot: "hello"')]
fn hello(name string, punctuation string) string {
	return 'First ${name}${punctuation}'
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
	StandaloneCaseTrait
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
@[vphp.PhpCallableAttribute(name: 'NoDiscard', args: 'message: "use the method result"')]
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

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\StaticCounter')]
struct StandaloneStaticCounter {}

struct StandaloneStaticState {
pub mut:
	count int = 10
	label string = 'initial'
	enabled bool = true
	ratio f64 = 2.5
}

const standalone_static_table = vphp.PhpStaticTable[StandaloneStaticCounter, StandaloneStaticState]{
	values: StandaloneStaticState{count: 12, label: '雪\x00initial'}
}

@[vphp.PhpExportMethod(name: 'advance')]
pub fn StandaloneStaticCounter.advance(by int) int {
	mut state := StandaloneStaticCounter.statics()
	state.count += by
	state.label += '\x00V'
	state.enabled = !state.enabled
	return state.count
}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\IntegerCounter')]
struct StandaloneIntegerCounter {}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\ZendStaticCounter')]
struct StandaloneZendStaticCounter {
pub mut:
	count int @[vphp.PhpStaticProperty]
	payload vphp.ZVal @[vphp.PhpStaticProperty]
}

@[vphp.PhpExportMethod(name: 'counterReference')]
pub fn StandaloneZendStaticCounter.counter_reference() !vphp.PhpReference {
	return vphp.PhpReference.static_property('count')
}

@[vphp.PhpExportTrait(name: 'VPHP\\Smoke\\ZendStaticTrait')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('count', 'int', '73')]
struct StandaloneZendStaticTrait {}

@[vphp.PhpExportMethod(name: 'traitCountReference')]
pub fn StandaloneZendStaticTrait.trait_count_reference() !vphp.PhpReference {
	return vphp.PhpReference.static_property('count')
}

struct StandaloneIntegerState {
mut:
	count int = 5
	label string = 'default'
}

const standalone_integer_table = vphp.PhpStaticTable[StandaloneIntegerCounter, StandaloneIntegerState]{
	values: StandaloneIntegerState{}
}

@[vphp.PhpExportMethod(name: 'increment')]
pub fn StandaloneIntegerCounter.increment() int {
	mut state := StandaloneIntegerCounter.statics()
	state.count++
	return state.count
}

@[vphp.PhpExportFunction(name: 'standalone_initial_integer_state')]
fn standalone_initial_integer_state() int {
	return StandaloneIntegerCounter.statics().count
}

const standalone_legacy_integer_state = StandaloneIntegerState{}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\LegacyIntegerCounter')]
@[vphp.PhpClassStatics(source: 'standalone_legacy_integer_state')]
struct StandaloneLegacyIntegerCounter {}

@[vphp.PhpExportFunction(name: '')]
fn standalone_legacy_integer_shadow() int {
	return StandaloneLegacyIntegerCounter.statics().count
}

fn exercise_outer_static_sync(mut state StandaloneIntegerState, callback vphp.PhpCallable) int {
	state.count += 10
	callback.invoke()
	return state.count
}

fn exercise_inner_static_sync(mut state StandaloneIntegerState, fail bool) !int {
	state.count += 2
	if fail {
		return error('reentrant inner failure')
	}
	return state.count
}

@[vphp.PhpExportMethod(name: 'outerSync')]
pub fn StandaloneIntegerCounter.outer_sync(callback vphp.PhpCallable) int {
	mut state := StandaloneIntegerCounter.statics()
	return exercise_outer_static_sync(mut state, callback)
}

@[vphp.PhpExportMethod(name: 'innerSync')]
pub fn StandaloneIntegerCounter.inner_sync(fail bool) !int {
	mut state := StandaloneIntegerCounter.statics()
	return exercise_inner_static_sync(mut state, fail)
}

@[vphp.PhpExportMethod(name: 'outerSync')]
pub fn StandaloneLegacyIntegerCounter.outer_sync(callback vphp.PhpCallable) int {
	mut state := StandaloneLegacyIntegerCounter.statics()
	return exercise_outer_static_sync(mut state, callback)
}

@[vphp.PhpExportMethod(name: 'innerSync')]
pub fn StandaloneLegacyIntegerCounter.inner_sync(fail bool) !int {
	mut state := StandaloneLegacyIntegerCounter.statics()
	return exercise_inner_static_sync(mut state, fail)
}

fn exercise_worker_static_fields(mut state StandaloneIntegerState) string {
	saved := '${state.count}:${state.label}'
	state.count++
	state.label += ':V'
	return saved
}

@[vphp.PhpExportMethod(name: 'touchWorkerStatics')]
pub fn StandaloneIntegerCounter.touch_worker_statics() string {
	mut state := StandaloneIntegerCounter.statics()
	return exercise_worker_static_fields(mut state)
}

@[vphp.PhpExportMethod(name: 'touchWorkerStatics')]
pub fn StandaloneLegacyIntegerCounter.touch_worker_statics() string {
	mut state := StandaloneLegacyIntegerCounter.statics()
	return exercise_worker_static_fields(mut state)
}

fn exercise_static_request_reentry(mut state StandaloneIntegerState, callback vphp.PhpCallable) string {
	state.count += 10
	state.label += ':outer'
	callback.invoke()
	resumed := '${state.count}:${state.label}'
	state.count++
	state.label += ':resumed'
	return resumed
}

@[vphp.PhpExportMethod(name: 'reenterWorkerStatics')]
pub fn StandaloneIntegerCounter.reenter_worker_statics(callback vphp.PhpCallable) string {
	mut state := StandaloneIntegerCounter.statics()
	return exercise_static_request_reentry(mut state, callback)
}

@[vphp.PhpExportMethod(name: 'reenterWorkerStatics')]
pub fn StandaloneLegacyIntegerCounter.reenter_worker_statics(callback vphp.PhpCallable) string {
	mut state := StandaloneLegacyIntegerCounter.statics()
	return exercise_static_request_reentry(mut state, callback)
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

@[php_function: 'vphp_smoke\\First\\hello']
pub fn hello(name string, punctuation string) string {
	return 'Second ${name}${punctuation}'
}

@[bridge.PhpExportConstant(name: 'vphp_smoke\\First\\VALUE')]
const second_value = 7
EOF

cat > "$tmp/verify-metadata.php" <<'EOF'
<?php
if (isset($argv[1])) {
    require $argv[1];
}
trait StandaloneWrappedCaseTrait {
    use VPHP\Smoke\CaseTrait;
}
class StandaloneNativeTraitConsumer {
    use VPHP\Smoke\CaseTrait { traitLabel as aliasedLabel; }
}
class StandaloneWrappedTraitConsumer {
    use StandaloneWrappedCaseTrait;
}
class StandaloneInheritedTraitConsumer extends StandaloneNativeTraitConsumer {}
class StandaloneCombinedTraitConsumer {
    use VPHP\Smoke\CombinedCaseTrait;

    public function callPrivateTraitLabel(string $label): string
    {
        return $this->traitLabel(label: $label);
    }

    private function formatValue(int $value): string
    {
        return "combined=$value";
    }
}
class StandaloneProtectedTraitAliasConsumer extends StandaloneCombinedTraitConsumer {
    public function callRivalLabel(?int $number = null): string
    {
        return $number === null ? $this->rivalLabel() : $this->rivalLabel(number: $number);
    }
}
class StandaloneTraitLocalOverride {
    use VPHP\Smoke\CombinedCaseTrait;

    public static function traitDouble(int $value): int
    {
        return $value + 1;
    }

    private function formatValue(int $value): string
    {
        return "override=$value";
    }
}
class StandalonePrivateRequirementConsumer {
    use VPHP\Smoke\PrivateRequirement;

    private function formatValue(int $value): string
    {
        return "value=$value";
    }
}

$requirement = new ReflectionMethod(VPHP\Smoke\PrivateRequirement::class, 'formatValue');
$implementation = new ReflectionMethod(StandalonePrivateRequirementConsumer::class, 'formatValue');
$value = $requirement->getParameters()[0];
if (!$requirement->isAbstract() || !$requirement->isPrivate()
    || (string) $requirement->getReturnType() !== 'string'
    || $requirement->getNumberOfRequiredParameters() !== 1
    || $value->getName() !== 'value' || (string) $value->getType() !== 'int'
    || $implementation->isAbstract() || !$implementation->isPrivate()
    || $implementation->invoke(new StandalonePrivateRequirementConsumer(), 7) !== 'value=7') {
    throw new RuntimeException('Unexpected private abstract trait requirement');
}

class StandaloneOverriddenTraitConstructor {
    use VPHP\Smoke\CaseTrait { __construct as private initializeTrait; }

    public function __construct(int $value)
    {
        $this->initializeTrait(level: $value, offset: 1);
    }
}

foreach (['VPHP\\Smoke_First', 'vphp_smoke\\First'] as $namespace) {
    $fullName = $namespace . '\\hello';
    $function = new ReflectionFunction($fullName);
    [$name, $punctuation] = $function->getParameters();
    if (!function_exists(strtolower($fullName)) || function_exists('hello')
        || $function->getName() !== $fullName || $function->getNamespaceName() !== $namespace
        || $function->getShortName() !== 'hello' || (string) $function->getReturnType() !== 'string'
        || $name->getName() !== 'name' || $punctuation->getName() !== 'punctuation') {
        throw new RuntimeException("Unexpected function metadata for $fullName");
    }
    if ($namespace === 'VPHP\\Smoke_First') {
        $attrs = $function->getAttributes(VPHP\Fixture\SmokeCallable::class);
        if ($function->getNumberOfRequiredParameters() !== 1 || $punctuation->getDefaultValue() !== '!'
            || count($attrs) !== 1 || $attrs[0]->getArguments() !== ['slot' => 'hello']) {
            throw new RuntimeException("Unexpected optional parameter or attribute for $fullName");
        }
    }
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
if (VPHP\Smoke_First\VALUE !== '雪\\path'
    || VPHP\Smoke_First\Value !== false || VPHP\Smoke_First\RATIO !== 2.0
    || vphp_smoke\First\VALUE !== 7 || defined('VALUE') || defined('VPHP\\Smoke_First\\value')
    || constant('vphp\\smoke_first\\VALUE') !== '雪\\path') {
    throw new RuntimeException('Unexpected namespaced constant values or casing');
}
if (extension_loaded('standalone_probe')) {
    $constants = (new ReflectionExtension('standalone_probe'))->getConstants();
    foreach (['VPHP\\Smoke_First\\VALUE' => '雪\\path', 'VPHP\\Smoke_First\\Value' => false,
        'VPHP\\Smoke_First\\RATIO' => 2.0, 'vphp_smoke\\First\\VALUE' => 7] as $name => $value) {
        if (!array_key_exists($name, $constants) || $constants[$name] !== $value) {
            throw new RuntimeException("Unexpected reflected constant $name");
        }
    }
}
foreach ([
    [new ReflectionFunction('VPHP\\Smoke\\checkedResult'), 'use the function result'],
    [new ReflectionMethod(VPHP\Smoke\Probe::class, 'answerValue'), 'use the method result'],
] as [$callable, $message]) {
    $attributes = $callable->getAttributes(NoDiscard::class);
    if (PHP_VERSION_ID >= 80500) {
        if (count($attributes) !== 1 || $attributes[0]->getArguments() !== ['message' => $message]) {
            throw new RuntimeException("Unexpected NoDiscard metadata for {$callable->getName()}");
        }
    } elseif ($attributes !== []) {
        throw new RuntimeException("NoDiscard appeared on PHP " . PHP_VERSION);
    }
}
foreach ([
    [new ReflectionMethod(VPHP\Smoke\OverrideChild::class, 'ParentValue'), VPHP\Smoke\OverrideBase::class],
    [new ReflectionMethod(VPHP\Smoke\OverrideImplementation::class, 'value'), VPHP\Smoke\OverrideContract::class],
] as [$method, $prototype]) {
    $attributes = $method->getAttributes(Override::class);
    if ($method->getPrototype()->getDeclaringClass()->getName() !== $prototype
        || (PHP_VERSION_ID >= 80300
            ? count($attributes) !== 1 || $attributes[0]->getArguments() !== []
                || !$attributes[0]->newInstance() instanceof Override
            : $attributes !== [])) {
        throw new RuntimeException("Unexpected Override metadata for {$method->getName()}");
    }
}
if (extension_loaded('standalone_probe')
    && (VPHP\Smoke\OverrideChild::ParentValue() !== 2
        || (new VPHP\Smoke\OverrideImplementation())->value() !== 3)) {
    throw new RuntimeException('Unexpected Override method results');
}
if (extension_loaded('standalone_probe')) {
    $probe = new VPHP\Smoke\Probe();
    $warnings = [];
    set_error_handler(static function (int $severity, string $message) use (&$warnings): bool {
        $warnings[] = $message;
        return true;
    }, E_WARNING);
    try {
        if (VPHP\Smoke\checkedResult() !== 17 || $probe->answerValue() !== 42 || $warnings !== []) {
            throw new RuntimeException('Consuming a NoDiscard result should succeed silently');
        }
        VPHP\Smoke\checkedResult();
        $probe->answerValue();
        if (PHP_VERSION_ID >= 80500) {
            eval('(void) VPHP\\Smoke\\checkedResult(); (void) $probe->answerValue();');
        }
    } finally {
        restore_error_handler();
    }
    if (PHP_VERSION_ID >= 80500) {
        if (count($warnings) !== 2 || !str_contains($warnings[0], 'use the function result')
            || !str_contains($warnings[1], 'use the method result')) {
            throw new RuntimeException('Discarding a NoDiscard result should emit one native warning per call');
        }
    } elseif ($warnings !== []) {
        throw new RuntimeException('NoDiscard warnings appeared on older PHP');
    }
}
$deprecations = [];
set_error_handler(static function (int $severity, string $message) use (&$deprecations): bool {
    $deprecations[] = $message;
    return true;
}, E_DEPRECATED | E_USER_DEPRECATED);
try {
    $oldValue = constant('STANDALONE_OLD_COUNT');
} finally {
    restore_error_handler();
}
if ($oldValue !== 7) {
    throw new RuntimeException('Unexpected value for STANDALONE_OLD_COUNT');
}
if (PHP_VERSION_ID >= 80500) {
    $constant = new ReflectionConstant('VPHP\\Smoke_First\\VALUE');
    $attrs = $constant->getAttributes(VPHP\Fixture\SmokeGlobalConstant::class);
    $deprecated = new ReflectionConstant('STANDALONE_OLD_COUNT');
    if (count($attrs) !== 1 || $attrs[0]->getTarget() !== Attribute::TARGET_CONSTANT
        || $attrs[0]->getArguments() !== ['kind' => 'global constant', 'data' => ['nested' => [1, '雪']]]
        || $constant->getValue() !== '雪\\path'
        || !$deprecated->isDeprecated() || count($deprecated->getAttributes(Deprecated::class)) !== 1
        || count($deprecations) !== 1 || !str_contains($deprecations[0], 'use STANDALONE_COUNT')) {
        throw new RuntimeException('Unexpected PHP 8.5 global constant attributes or deprecation');
    }
} elseif ($deprecations !== []
    || (class_exists(ReflectionConstant::class) && (new ReflectionConstant('STANDALONE_OLD_COUNT'))->isDeprecated())
    || (isset($argv[1]) && (str_contains(file_get_contents($argv[1]), 'SmokeGlobalConstant')
        || str_contains(file_get_contents($argv[1]), 'use STANDALONE_COUNT')))) {
    throw new RuntimeException('PHP 8.5 global constant attributes appeared on older PHP');
}
$nullable = new VPHP\Smoke\NullableProperties();
$nullableObject = new VPHP\Smoke\NullableObject();
$text = new ReflectionProperty($nullable, 'text');
$label = new ReflectionProperty($nullable, 'label');
$date = new ReflectionProperty($nullableObject, 'date');
if ((string) $text->getType() !== '?string' || $text->hasDefaultValue() || $text->isInitialized($nullable)
    || (string) $label->getType() !== '?string' || !$label->hasDefaultValue() || !$label->isInitialized($nullable)
    || $label->getDefaultValue() !== 'ready' || $nullable->label !== 'ready'
    || (string) $date->getType() !== '?DateTimeImmutable' || !$date->hasDefaultValue()
    || !$date->isInitialized($nullableObject) || $date->getDefaultValue() !== null || $nullableObject->date !== null) {
    throw new RuntimeException('Unexpected nullable property type or initialization');
}
try {
    $nullable->text;
    throw new RuntimeException('Reading an uninitialized property should fail');
} catch (Error $error) {
    if (!str_contains($error->getMessage(), 'before initialization')) {
        throw $error;
    }
}
$nullable->text = 'text';
$nullableObject->date = new DateTimeImmutable('2000-01-01');
if ($nullable->text !== 'text' || $nullableObject->date->format('Y-m-d') !== '2000-01-01') {
    throw new RuntimeException('Unexpected nullable property write');
}
try {
    $nullableObject->date = new stdClass();
    throw new RuntimeException('An incompatible object should fail property type validation');
} catch (TypeError) {
}
$nullable->text = null;
$nullableObject->date = null;
if (!$text->isInitialized($nullable) || $nullable->text !== null || $nullableObject->date !== null) {
    throw new RuntimeException('Could not assign null to a nullable property');
}
$union = new VPHP\Smoke\UnionProperties();
$unionObjects = new VPHP\Smoke\UnionObjects();
foreach ([
    [$union, 'value', ['int', 'string'], false, null],
    [$union, 'label', ['float', 'string'], true, 2.0],
    [$unionObjects, 'textOrDate', ['DateTimeImmutable', 'string'], false, null],
    [$unionObjects, 'date', ['DateTime', 'DateTimeImmutable', 'int', 'null'], true, null],
] as [$object, $name, $expectedTypes, $initialized, $default]) {
    $property = new ReflectionProperty($object, $name);
    $type = $property->getType();
    if (!$type instanceof ReflectionUnionType) {
        throw new RuntimeException("Expected a union type on $name");
    }
    $types = array_map(static fn (ReflectionNamedType $type): string => $type->getName(), $type->getTypes());
    sort($types, SORT_STRING);
    if ($types !== $expectedTypes || $property->hasDefaultValue() !== $initialized
        || $property->isInitialized($object) !== $initialized
        || ($initialized && ($property->getDefaultValue() !== $default || $object->$name !== $default))) {
        throw new RuntimeException("Unexpected union type or default on $name");
    }
}
foreach ([7, 'text'] as $value) {
    $union->value = $value;
    if ($union->value !== $value) {
        throw new RuntimeException('Unexpected scalar union assignment');
    }
}
foreach ([new DateTimeImmutable(), new DateTime(), 7, null] as $value) {
    $unionObjects->date = $value;
    if ($unionObjects->date !== $value) {
        throw new RuntimeException('Unexpected class union assignment');
    }
}
try {
    $unionObjects->date = new stdClass();
    throw new RuntimeException('An incompatible object should fail union type validation');
} catch (TypeError) {
}
$compound = new VPHP\Smoke\CompoundProperties();
$collection = new ReflectionProperty($compound, 'collection');
$entry = new ReflectionProperty($compound, 'entry');
$intersection = $collection->getType();
$dnf = $entry->getType();
if (!$intersection instanceof ReflectionIntersectionType || (string) $intersection !== 'Countable&IteratorAggregate'
    || $collection->hasDefaultValue() || $collection->isInitialized($compound)
    || !$dnf instanceof ReflectionUnionType || !in_array('(Countable&Iterator)', explode('|', (string) $dnf), true)
    || count($dnf->getTypes()) !== 3 || !$entry->hasDefaultValue() || !$entry->isInitialized($compound)
    || $entry->getDefaultValue() !== null || $compound->entry !== null) {
    throw new RuntimeException('Unexpected intersection or DNF property metadata');
}
$collectionValue = new ArrayObject([1]);
$compound->collection = $collectionValue;
if ($compound->collection !== $collectionValue) {
    throw new RuntimeException('Unexpected intersection assignment');
}
foreach ([new ArrayIterator([1]), 42, null] as $value) {
    $compound->entry = $value;
    if ($compound->entry !== $value) {
        throw new RuntimeException('Unexpected DNF assignment');
    }
}
try {
    $compound->entry = new EmptyIterator();
    throw new RuntimeException('Implementing only one interface should fail DNF validation');
} catch (TypeError) {
}
try {
    $compound->collection = new ArrayIterator();
    throw new RuntimeException('Implementing only one interface should fail intersection validation');
} catch (TypeError) {
}
class SmokeProtectedSetterChild extends VPHP\Smoke\ProtectedSetter
{
    public function initializeScore(int $score): void
    {
        $this->score = $score;
    }
}
class SmokePrivateSetterChild extends VPHP\Smoke\PrivateSetter
{
    public function assignNote(): void
    {
        $this->note = 'child';
    }
}
$protectedSetter = new SmokeProtectedSetterChild();
$privateSetter = new SmokePrivateSetterChild();
if (PHP_VERSION_ID >= 80400) {
    $score = new ReflectionProperty($protectedSetter, 'score');
    $note = new ReflectionProperty(VPHP\Smoke\PrivateSetter::class, 'note');
    if (!$score->isPublic() || !$score->isProtectedSet() || $score->isPrivateSet()
        || $score->isInitialized($protectedSetter) || $score->hasDefaultValue()
        || (string) $score->getType() !== 'int' || !$note->isPublic()
        || !$note->isPrivateSet() || !$note->isFinal() || (string) $note->getType() !== 'mixed'
        || $note->isInitialized($privateSetter) || $note->hasDefaultValue()) {
        throw new RuntimeException('Unexpected asymmetric property metadata');
    }
    $protectedSetter->initializeScore(7);
    $note->setValue($privateSetter, 'ready');
    foreach ([
        static function () use ($protectedSetter) { $protectedSetter->score = 9; },
        static function () use ($privateSetter) { $privateSetter->note = 'outside'; },
        $privateSetter->assignNote(...),
    ] as $attempt) {
        try {
            $attempt();
            throw new RuntimeException('Asymmetric property accepted an out-of-scope assignment');
        } catch (Error $error) {
            if (!str_contains($error->getMessage(), '(set)')) {
                throw $error;
            }
        }
    }
    if ($protectedSetter->score !== 7 || $privateSetter->note !== 'ready') {
        throw new RuntimeException('Unexpected asymmetric property value');
    }
} elseif (property_exists($protectedSetter, 'score') || property_exists($privateSetter, 'note')) {
    throw new RuntimeException('Asymmetric properties require PHP 8.4');
}
$readonlyNote = new ReflectionProperty(VPHP\Smoke\ReadonlyVisibility::class, 'note');
if (!$readonlyNote->isReadOnly() || !$readonlyNote->isProtected() || (string) $readonlyNote->getType() !== 'string') {
    throw new RuntimeException('Unexpected readonly property visibility or type');
}
readonly class SmokeReadonlyChild extends VPHP\Smoke\ReadonlyRecord {}
$readonlyRecord = new ReflectionClass(VPHP\Smoke\ReadonlyRecord::class);
$readonlyChild = new SmokeReadonlyChild();
if (!$readonlyRecord->isReadOnly() || !(new ReflectionClass($readonlyChild))->isReadOnly()
    || !(new ReflectionClass(VPHP\Smoke\ReadonlyEmpty::class))->isReadOnly()) {
    throw new RuntimeException('Explicit readonly class modifier is missing');
}
foreach (['number' => 'int', 'payload' => 'mixed'] as $name => $type) {
    $property = $readonlyRecord->getProperty($name);
    if (!$property->isReadOnly() || (string) $property->getType() !== $type
        || $property->hasDefaultValue() || $property->isInitialized($readonlyChild)) {
        throw new RuntimeException("Unexpected explicit readonly class property $name");
    }
}
$numberProperty = $readonlyRecord->getProperty('number');
$numberProperty->setValue($readonlyChild, 42);
if ($readonlyChild->number !== 42) {
    throw new RuntimeException('Readonly property initialization failed');
}
try {
    $readonlyChild->number = 43;
    throw new LogicException('Readonly property accepted a second assignment');
} catch (Error $error) {
    if (!str_contains($error->getMessage(), 'readonly property')) {
        throw $error;
    }
}
try {
    $readonlyEmpty = new VPHP\Smoke\ReadonlyEmpty();
    $readonlyEmpty->extra = 1;
    throw new LogicException('Readonly class accepted a dynamic property');
} catch (Error $error) {
    if (!str_contains($error->getMessage(), 'dynamic property')) {
        throw $error;
    }
}
$readonlyValue = new ReflectionClass(VPHP\Smoke\ReadonlyValue::class);
if (!$readonlyValue->isReadOnly() || !$readonlyValue->getProperty('value')->isReadOnly()
    || $readonlyValue->getProperty('value')->hasDefaultValue()
    || (extension_loaded('standalone_probe') && (new VPHP\Smoke\ReadonlyValue())->value !== 7)) {
    throw new RuntimeException('Explicit readonly class did not preserve its immutable V field');
}
if (extension_loaded('standalone_probe')) {
    try {
        $readonlyValue->getProperty('value')->setValue(new VPHP\Smoke\ReadonlyValue(), 9);
        throw new LogicException('Reflective write to an immutable V field succeeded');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), 'readonly property')) {
            throw $error;
        }
    }
}
class SmokeUserlandDynamicChild extends VPHP\Smoke\DynamicRecord {}
$dynamicBase = new ReflectionClass(VPHP\Smoke\DynamicRecord::class);
$dynamicAttributes = $dynamicBase->getAttributes(AllowDynamicProperties::class);
if (count($dynamicAttributes) !== 1 || !$dynamicAttributes[0]->newInstance() instanceof AllowDynamicProperties) {
    throw new RuntimeException('AllowDynamicProperties reflection metadata is missing');
}
$dynamicDeprecations = [];
set_error_handler(static function (int $severity, string $message) use (&$dynamicDeprecations): bool {
    $dynamicDeprecations[] = $message;
    return true;
}, E_DEPRECATED);
try {
    foreach ([VPHP\Smoke\DynamicRecord::class, VPHP\Smoke\DynamicRecordChild::class, SmokeUserlandDynamicChild::class] as $dynamicClass) {
        $object = new $dynamicClass();
        $object->extra = 42;
        $reflection = new ReflectionObject($object);
        if ($object->extra !== 42 || $reflection->getProperty('extra')->isDefault()
            || ($dynamicClass !== $dynamicBase->getName() && $reflection->getAttributes(AllowDynamicProperties::class) !== [])) {
            throw new RuntimeException("Unexpected dynamic property behavior on $dynamicClass");
        }
        $reference =& $object->extra;
        $reference++;
        if ($object->extra !== 43) {
            throw new RuntimeException("Dynamic property reference did not update $dynamicClass");
        }
        unset($object->extra, $reference);
        if (isset($object->extra)) {
            throw new RuntimeException("Could not unset dynamic property on $dynamicClass");
        }
    }
    $control = new VPHP\Smoke\DynamicControl();
    $control->extra = 1;
} finally {
    restore_error_handler();
}
if (count($dynamicDeprecations) !== 1 || !str_contains($dynamicDeprecations[0], 'DynamicControl::$extra')) {
    throw new RuntimeException('AllowDynamicProperties did not change the PHP dynamic property deprecation behavior');
}

class SmokeRestrictedDefaultsChild extends VPHP\Smoke\RestrictedDefaults
{
    public function changeTag(): void
    {
        $this->options['tags'][0] = 'changed';
    }
}
$restricted = new SmokeRestrictedDefaultsChild();
$restrictedNull = new VPHP\Smoke\RestrictedNullDefault();
if (PHP_VERSION_ID >= 80400) {
    $expected = ['tags' => ['雪', null]];
    $options = new ReflectionProperty($restricted, 'options');
    $note = new ReflectionProperty($restrictedNull, 'note');
    if (!$options->isProtectedSet() || (string) $options->getType() !== 'array'
        || !$options->hasDefaultValue() || $options->getDefaultValue() !== $expected
        || !$options->isInitialized($restricted) || $restricted->options !== $expected
        || !$note->isPrivateSet() || (string) $note->getType() !== '?string'
        || !$note->hasDefaultValue() || $note->getDefaultValue() !== null
        || !$note->isInitialized($restrictedNull) || $restrictedNull->note !== null) {
        throw new RuntimeException('Unexpected asymmetric property default or metadata');
    }
    $another = new SmokeRestrictedDefaultsChild();
    $restricted->changeTag();
    if ($restricted->options['tags'][0] !== 'changed' || $another->options !== $expected
        || (new SmokeRestrictedDefaultsChild())->options !== $expected
        || $options->getDefaultValue() !== $expected) {
        throw new RuntimeException('Changing an asymmetric property affected its default or another instance');
    }
} elseif (property_exists($restricted, 'options') || property_exists($restrictedNull, 'note')) {
    throw new RuntimeException('Asymmetric properties with defaults require PHP 8.4');
}
class SmokeRestrictedStaticChild extends VPHP\Smoke\RestrictedStatic
{
    public static function changeLimit(int $limit): void
    {
        self::$limit = $limit;
    }

    public static function changeNote(): void
    {
        self::$note = 'child';
    }
}
$staticClass = new ReflectionClass(VPHP\Smoke\RestrictedStatic::class);
if (PHP_VERSION_ID >= 80500) {
    $limit = $staticClass->getProperty('limit');
    $staticNote = $staticClass->getProperty('note');
    if (!$limit->isStatic() || !$limit->isPublic() || !$limit->isProtectedSet()
        || (string) $limit->getType() !== 'int' || !$limit->hasDefaultValue()
        || $limit->getDefaultValue() !== 3 || VPHP\Smoke\RestrictedStatic::$limit !== 3
        || !$staticNote->isStatic() || !$staticNote->isPublic() || !$staticNote->isPrivateSet()
        || !$staticNote->isFinal() || (string) $staticNote->getType() !== '?string'
        || $staticNote->hasDefaultValue() || $staticNote->isInitialized()) {
        throw new RuntimeException('Unexpected static asymmetric property metadata');
    }
    SmokeRestrictedStaticChild::changeLimit(7);
    $staticNote->setValue(null, 'ready');
    foreach ([
        static function () { VPHP\Smoke\RestrictedStatic::$limit = 9; },
        static function () { VPHP\Smoke\RestrictedStatic::$note = 'outside'; },
        SmokeRestrictedStaticChild::changeNote(...),
    ] as $attempt) {
        try {
            $attempt();
            throw new RuntimeException('Static asymmetric property accepted an out-of-scope assignment');
        } catch (Error $error) {
            if (!str_contains($error->getMessage(), '(set)')) {
                throw $error;
            }
        }
    }
    if (VPHP\Smoke\RestrictedStatic::$limit !== 7 || VPHP\Smoke\RestrictedStatic::$note !== 'ready'
        || $limit->getDefaultValue() !== 3) {
        throw new RuntimeException('Unexpected static asymmetric property value');
    }
} elseif ($staticClass->hasProperty('limit') || $staticClass->hasProperty('note')) {
    throw new RuntimeException('Static asymmetric properties require PHP 8.5');
}
class SmokeFinalPropertyChild extends VPHP\Smoke\FinalProperty {}
$finalProperty = new SmokeFinalPropertyChild();
if (PHP_VERSION_ID >= 80400) {
    $finalLimit = new ReflectionProperty($finalProperty, 'limit');
    if (!$finalLimit->isFinal() || !$finalLimit->isPublic() || $finalLimit->isReadOnly()
        || $finalLimit->isProtectedSet() || $finalLimit->isPrivateSet()
        || $finalLimit->getDeclaringClass()->getName() !== VPHP\Smoke\FinalProperty::class
        || (string) $finalLimit->getType() !== 'int' || $finalLimit->getDefaultValue() !== 3
        || $finalProperty->limit !== 3) {
        throw new RuntimeException('Unexpected final property metadata');
    }
    $finalProperty->limit = 7;
    if ($finalProperty->limit !== 7 || (new SmokeFinalPropertyChild())->limit !== 3) {
        throw new RuntimeException('Unexpected final property write or default');
    }
} elseif (property_exists($finalProperty, 'limit')) {
    throw new RuntimeException('Final properties require PHP 8.4');
}
if ($finalProperty->other !== 0) {
    throw new RuntimeException('The sibling declaration should remain available');
}
class SmokeFinalMethodsChild extends VPHP\Smoke\FinalMethods {}
class SmokeFinalConstructorChild extends VPHP\Smoke\FinalConstructor {}
$fixed = new ReflectionMethod(SmokeFinalMethodsChild::class, 'fixedValue');
$static = new ReflectionMethod(SmokeFinalMethodsChild::class, 'staticValue');
$constructor = new ReflectionMethod(SmokeFinalConstructorChild::class, '__construct');
if (!$fixed->isFinal() || !$fixed->isPublic() || $fixed->isStatic()
    || !$static->isFinal() || !$static->isPublic() || !$static->isStatic()
    || !$constructor->isFinal() || !$constructor->isConstructor()
    || (string) $fixed->getReturnType() !== 'int'
    || $fixed->getParameters()[0]->getName() !== 'value'
    || $constructor->getParameters()[0]->getName() !== 'start') {
    throw new RuntimeException('Unexpected final method metadata');
}
if ($fixed->isInternal()
    && ((new SmokeFinalMethodsChild())->fixedValue(value: 4) !== 5
        || SmokeFinalMethodsChild::staticValue() !== 7
        || (new SmokeFinalConstructorChild(start: 8))->start !== 8)) {
    throw new RuntimeException('Unexpected final method call result');
}
class SmokeRestrictedConstantsChild extends VPHP\Smoke\RestrictedConstants
{
    public static function inheritedValue(): int { return self::LOCKED; }
}
$constantClass = new ReflectionClass(VPHP\Smoke\RestrictedConstants::class);
$locked = $constantClass->getReflectionConstant('LOCKED');
$secret = $constantClass->getReflectionConstant('SECRET');
$ratio = $constantClass->getReflectionConstant('RATIO');
if (!$locked->isProtected() || !$locked->isFinal() || $locked->getValue() !== 7
    || !$secret->isPrivate() || $secret->isFinal() || $secret->getValue() !== "雪 \"quoted\" \\ path\x00end"
    || !$ratio->isPublic() || $ratio->getValue() !== 1.25
    || VPHP\Smoke\RestrictedConstants::VISIBLE !== true
    || SmokeRestrictedConstantsChild::inheritedValue() !== 7) {
    throw new RuntimeException('Unexpected class constant modifier or value');
}
if (PHP_VERSION_ID >= 80300
    && ((string) $locked->getType() !== 'int' || (string) $secret->getType() !== 'string'
        || (string) $ratio->getType() !== 'float')) {
    throw new RuntimeException('Unexpected class constant type');
}
foreach ([
    'protected' => static fn () => VPHP\Smoke\RestrictedConstants::LOCKED,
    'private' => static fn () => VPHP\Smoke\RestrictedConstants::SECRET,
] as $visibility => $read) {
    try {
        $read();
        throw new RuntimeException('Class constant was readable outside its visibility');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), "Cannot access $visibility constant")) {
            throw $error;
        }
    }
}
class SmokeMethodVisibilityChild extends VPHP\Smoke\MethodVisibility
{
    public function privateInstance(): int { return 21; }
    public function accessProtected(): int { return $this->restricted(); }
}
$methodVisibility = new ReflectionClass(VPHP\Smoke\MethodVisibility::class);
$visibilityTarget = $methodVisibility->newInstance();
$privateMethod = $methodVisibility->getMethod('privateInstance');
$privateStatic = $methodVisibility->getMethod('privateStatic');
$privateConstructor = new ReflectionMethod(VPHP\Smoke\PrivateConstructor::class, '__construct');
if (!$privateMethod->isPrivate() || $privateMethod->isStatic()
    || !$privateStatic->isPrivate() || !$privateStatic->isStatic()
    || !$methodVisibility->getMethod('restricted')->isProtected()
    || !$methodVisibility->getMethod('defaultProtected')->isProtected()
    || !$methodVisibility->getMethod('promoted')->isPublic()
    || !$privateConstructor->isPrivate() || !$privateConstructor->isFinal()) {
    throw new RuntimeException('Unexpected explicit method visibility');
}
$visibilityChild = new SmokeMethodVisibilityChild();
if ($visibilityChild->privateInstance() !== 21
    || ($privateMethod->isInternal()
        && ($privateMethod->invoke($visibilityTarget) !== 11 || $privateStatic->invoke(null) !== 12
            || $visibilityChild->accessProtected() !== 13 || $visibilityTarget->promoted() !== 14))) {
    throw new RuntimeException('Unexpected method visibility dispatch');
}
foreach ([
    'private method' => static fn () => $visibilityTarget->privateInstance(),
    'private method VPHP\\Smoke\\MethodVisibility::privateStatic' => static fn () => VPHP\Smoke\MethodVisibility::privateStatic(),
    'protected method' => static fn () => $visibilityTarget->restricted(),
    'private VPHP\\Smoke\\PrivateConstructor::__construct' => static fn () => new VPHP\Smoke\PrivateConstructor(),
] as $message => $invoke) {
    try {
        $invoke();
        throw new RuntimeException('Non-public method was callable outside its visibility');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), $message)) {
            throw $error;
        }
    }
}
class SmokeProtectedPropertyChild extends VPHP\Smoke\ProtectedProperty
{
    public function increment(): int { return ++$this->count; }
}
class SmokePrivatePropertyChild extends VPHP\Smoke\PrivateProperty
{
    public string $secret = 'child';
}
class SmokeRestrictedPropertyChild extends VPHP\Smoke\RestrictedProperty
{
    public function readLevel(): int { return $this->level; }
    public function writeLevel(): void { $this->level = 6; }
}
$protectedObject = new SmokeProtectedPropertyChild();
$privateObject = new VPHP\Smoke\PrivateProperty();
$privateChild = new SmokePrivatePropertyChild();
$protectedProperty = new ReflectionProperty(VPHP\Smoke\ProtectedProperty::class, 'count');
$privateProperty = new ReflectionProperty(VPHP\Smoke\PrivateProperty::class, 'secret');
if (!$protectedProperty->isProtected() || (string) $protectedProperty->getType() !== 'int'
    || $protectedProperty->getDefaultValue() !== 3 || $protectedObject->increment() !== 4
    || $protectedProperty->getValue($protectedObject) !== 4
    || !$privateProperty->isPrivate() || (string) $privateProperty->getType() !== 'string'
    || $privateProperty->getDefaultValue() !== 'parent' || $privateProperty->getValue($privateChild) !== 'parent'
    || $privateChild->secret !== 'child') {
    throw new RuntimeException('Unexpected declared property visibility or value');
}
foreach ([
    'protected' => static fn () => $protectedObject->count,
    'private' => static fn () => $privateObject->secret,
] as $visibility => $read) {
    try {
        $read();
        throw new RuntimeException('Declared property was readable outside its visibility');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), "Cannot access $visibility property")) {
            throw $error;
        }
    }
}
$restrictedObject = new SmokeRestrictedPropertyChild();
if (PHP_VERSION_ID >= 80400) {
    $level = new ReflectionProperty(VPHP\Smoke\RestrictedProperty::class, 'level');
    $symmetric = new ReflectionProperty(VPHP\Smoke\SymmetricPrivateProperty::class, 'note');
    if (!$level->isProtected() || !$level->isPrivateSet() || !$level->isFinal() || $restrictedObject->readLevel() !== 4
        || !$symmetric->isPrivate() || $symmetric->isPrivateSet() || $symmetric->isFinal()) {
        throw new RuntimeException('Unexpected combined read and write visibility');
    }
    try {
        $restrictedObject->writeLevel();
        throw new RuntimeException('Child class could write a private(set) property');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), 'private(set)')) {
            throw $error;
        }
    }
} elseif (property_exists($restrictedObject, 'level') || property_exists(VPHP\Smoke\SymmetricPrivateProperty::class, 'note')) {
    throw new RuntimeException('Asymmetric declarations require PHP 8.4');
}
$interfaceConstant = new ReflectionClassConstant(VPHP\Smoke\ConstantImplementationChild::class, 'LIMIT');
$interfaceConstantAttributes = $interfaceConstant->getAttributes(VPHP\Fixture\SmokeConstant::class);
if (!$interfaceConstant->isPublic() || !$interfaceConstant->isFinal()
    || !$interfaceConstant->getDeclaringClass()->isInterface()
    || $interfaceConstant->getDeclaringClass()->getName() !== VPHP\Smoke\ConstantContract::class
    || $interfaceConstant->getValue() !== 7 || count($interfaceConstantAttributes) !== 1
    || $interfaceConstantAttributes[0]->getArguments() !== ['slot' => 'contract']
    || (PHP_VERSION_ID >= 80300 && (string) $interfaceConstant->getType() !== 'int')
    || VPHP\Smoke\ConstantContract::REVISION !== 1 || VPHP\Smoke\VersionedContract::REVISION !== 2
    || VPHP\Smoke\ConstantImplementation::REVISION !== 3 || VPHP\Smoke\ConstantImplementationChild::REVISION !== 4
    || (new VPHP\Smoke\ConstantImplementationChild())->label !== 'parent') {
    throw new RuntimeException('Unexpected interface constant metadata or inheritance');
}
$enumConstants = new ReflectionEnum(VPHP\Smoke\EnumConstants::class);
$enumOrdinary = $enumConstants->getReflectionConstant('ACTIVE');
$enumLimit = $enumConstants->getReflectionConstant('LIMIT');
$enumSecret = $enumConstants->getReflectionConstant('SECRET');
$enumCase = $enumConstants->getCase('active');
$enumOrdinaryAttrs = $enumOrdinary->getAttributes(VPHP\Fixture\SmokeConstant::class);
$enumCaseAttrs = $enumCase->getAttributes(VPHP\Fixture\SmokeConstant::class);
$enumAlias = $enumConstants->getReflectionConstant('PREFERRED');
$inferredAlias = $enumConstants->getReflectionConstant('INFERRED');
$remoteAlias = $enumConstants->getReflectionConstant('REMOTE');
$aliasAttrs = $enumAlias->getAttributes(VPHP\Fixture\SmokeConstant::class);
if (count($enumConstants->getCases()) !== 2
    || array_map(
        static fn (ReflectionClassConstant $constant): string => $constant->getName(),
        $enumConstants->getReflectionConstants(),
    ) !== ['active', 'idle', 'ACTIVE', 'SECRET', 'LIMIT', 'PREFERRED', 'INFERRED', 'REMOTE']
    || !$enumCase->isEnumCase() || $enumCase->getBackingValue() !== 7
    || !$enumConstants->getCase('idle')->isEnumCase() || $enumConstants->getCase('idle')->getBackingValue() !== 8
    || $enumOrdinary->isEnumCase() || !$enumOrdinary->isPublic() || $enumOrdinary->isFinal()
    || $enumOrdinary->getValue() !== 42 || VPHP\Smoke\EnumConstants::ACTIVE !== 42
    || VPHP\Smoke\EnumConstants::active->value !== 7
    || $enumLimit->isEnumCase() || !$enumLimit->isProtected() || !$enumLimit->isFinal() || $enumLimit->getValue() !== 2.5
    || $enumSecret->isEnumCase() || !$enumSecret->isPrivate()
    || $enumSecret->getValue() !== "雪 \"enum\" \\ path\x00end"
    || count($enumOrdinaryAttrs) !== 1 || $enumOrdinaryAttrs[0]->getArguments() !== ['slot' => 'enum constant']
    || count($enumCaseAttrs) !== 1 || $enumCaseAttrs[0]->getArguments() !== ['slot' => 'enum case']) {
    throw new RuntimeException('Unexpected enum case or ordinary constant metadata');
}
if ($enumConstants->hasCase('PREFERRED') || $enumConstants->hasCase('INFERRED') || $enumConstants->hasCase('REMOTE')
    || $enumAlias->isEnumCase() || !$enumAlias->isPublic()
    || $enumAlias->getValue() !== $enumCase->getValue()
    || VPHP\Smoke\EnumConstants::PREFERRED !== VPHP\Smoke\EnumConstants::active
    || $inferredAlias->isEnumCase() || !$inferredAlias->isProtected() || !$inferredAlias->isFinal()
    || $inferredAlias->getValue() !== VPHP\Smoke\EnumConstants::active
    || $remoteAlias->isEnumCase() || $remoteAlias->getValue() !== VPHP\Smoke\EnumAliasTarget::ready
    || VPHP\Smoke\EnumConstants::REMOTE !== VPHP\Smoke\EnumAliasTarget::ready
    || VPHP\Smoke\EnumConstants::REMOTE === VPHP\Smoke\EnumConstants::active
    || count($aliasAttrs) !== 1 || $aliasAttrs[0]->getArguments() !== ['slot' => 'enum alias']) {
    throw new RuntimeException('Unexpected enum alias identity or metadata');
}
foreach ([
    [VPHP\Smoke\ConstantImplementation::class, 'DEFAULT_MODE', VPHP\Smoke\ConstantImplementation::class,
        VPHP\Smoke\EnumConstants::active, 'class mode', false],
    [VPHP\Smoke\ConstantImplementationChild::class, 'DEFAULT_MODE', VPHP\Smoke\ConstantImplementation::class,
        VPHP\Smoke\EnumConstants::active, 'class mode', false],
    [VPHP\Smoke\ConstantContract::class, 'CONTRACT_MODE', VPHP\Smoke\ConstantContract::class,
        VPHP\Smoke\EnumAliasTarget::ready, 'contract mode', true],
    [VPHP\Smoke\VersionedContract::class, 'CONTRACT_MODE', VPHP\Smoke\ConstantContract::class,
        VPHP\Smoke\EnumAliasTarget::ready, 'contract mode', true],
    [VPHP\Smoke\ConstantImplementationChild::class, 'CONTRACT_MODE', VPHP\Smoke\ConstantContract::class,
        VPHP\Smoke\EnumAliasTarget::ready, 'contract mode', true],
    [VPHP\Smoke\Probe::class, 'TRAIT_MODE', VPHP\Smoke\Probe::class,
        VPHP\Smoke\EnumAliasTarget::ready, 'trait mode', true],
    [VPHP\Smoke\ConstantImplementation::class, 'TRAIT_MODE', VPHP\Smoke\ConstantImplementation::class,
        VPHP\Smoke\EnumAliasTarget::ready, 'trait mode', true],
    [VPHP\Smoke\ConstantImplementationChild::class, 'TRAIT_MODE', VPHP\Smoke\ConstantImplementation::class,
        VPHP\Smoke\EnumAliasTarget::ready, 'trait mode', true],
] as [$owner, $name, $declaringClass, $case, $slot, $final]) {
    $alias = new ReflectionClassConstant($owner, $name);
    $attributes = $alias->getAttributes(VPHP\Fixture\SmokeConstant::class);
    if (constant("$owner::$name") !== $case || $alias->getValue() !== $case || $alias->isEnumCase()
        || !$alias->isPublic() || $alias->isFinal() !== $final
        || $alias->getDeclaringClass()->getName() !== $declaringClass
        || count($attributes) !== 1 || $attributes[0]->getArguments() !== ['slot' => $slot]
        || (PHP_VERSION_ID >= 80300 && (string) $alias->getType() !== $case::class)) {
        throw new RuntimeException("Unexpected enum case reference for $owner::$name");
    }
}
$traitIdle = new ReflectionClassConstant(VPHP\Smoke\Probe::class, 'TRAIT_IDLE');
if (VPHP\Smoke\Probe::TRAIT_MODE !== VPHP\Smoke\EnumAliasTarget::ready
    || VPHP\Smoke\Probe::FALLBACK !== 'old' || VPHP\Smoke\ConstantImplementation::FALLBACK !== 'trait'
    || !$traitIdle->isProtected() || $traitIdle->isFinal() || $traitIdle->isEnumCase()
    || $traitIdle->getValue() !== VPHP\Smoke\EnumConstants::idle
    || (PHP_VERSION_ID >= 80300 && (string) $traitIdle->getType() !== VPHP\Smoke\EnumConstants::class)) {
    throw new RuntimeException('Unexpected composed trait constant metadata');
}
$nativeTrait = VPHP\Smoke\CaseTrait::class;
if (!trait_exists($nativeTrait, false)
    || !(new ReflectionClass($nativeTrait))->isTrait()
    || !in_array($nativeTrait, class_uses(StandaloneNativeTraitConsumer::class), true)
    || StandaloneNativeTraitConsumer::TRAIT_MODE !== VPHP\Smoke\EnumAliasTarget::ready
    || StandaloneWrappedTraitConsumer::TRAIT_MODE !== VPHP\Smoke\EnumAliasTarget::ready
    || StandaloneInheritedTraitConsumer::TRAIT_MODE !== VPHP\Smoke\EnumAliasTarget::ready
    || StandaloneNativeTraitConsumer::FALLBACK !== 'trait') {
    throw new RuntimeException('Unexpected native trait composition or case identity');
}
$staticCounter = new ReflectionClass(VPHP\Smoke\StaticCounter::class);
foreach (['count' => ['int', 12], 'label' => ['string', "雪\0initial"], 'enabled' => ['bool', true]] as $name => [$type, $default]) {
    $property = $staticCounter->getProperty($name);
    if (!$property->isPublic() || !$property->isStatic() || (string) $property->getType() !== $type
        || $property->getDefaultValue() !== $default || $property->getValue() !== $default) {
        throw new RuntimeException("Unexpected static table metadata for $name");
    }
}
if (extension_loaded('standalone_probe')) {
    VPHP\Smoke\StaticCounter::$count = 20;
    $label = "PHP\0label";
    VPHP\Smoke\StaticCounter::$label =& $label;
    VPHP\Smoke\StaticCounter::$enabled = false;
    if (VPHP\Smoke\StaticCounter::advance(by: 3) !== 23 || VPHP\Smoke\StaticCounter::$count !== 23
        || $label !== "PHP\0label\0V" || VPHP\Smoke\StaticCounter::$enabled !== true) {
        throw new RuntimeException('Unexpected bidirectional synchronization for the static table');
    }
}
$integerCounter = new ReflectionProperty(VPHP\Smoke\IntegerCounter::class, 'count');
if (!$integerCounter->isStatic() || $integerCounter->getDefaultValue() !== 5) {
    throw new RuntimeException('Unexpected integer static table default');
}
if (extension_loaded('standalone_probe')
    && (standalone_initial_integer_state() !== 5
        || VPHP\Smoke\IntegerCounter::increment() !== 6 || VPHP\Smoke\IntegerCounter::$count !== 6)) {
    throw new RuntimeException('Integer static table state did not synchronize');
}
if (extension_loaded('standalone_probe')) {
    VPHP\Smoke\IntegerCounter::$count = 20;
    VPHP\Smoke\IntegerCounter::increment();
    for ($index = 0; $index < 2; $index++) {
        try {
            vphp_standalone_probe_with_static_request(static function (): void {
                if (standalone_initial_integer_state() !== 5 || VPHP\Smoke\IntegerCounter::$count !== 5
                    || VPHP\Smoke\IntegerCounter::increment() !== 6 || VPHP\Smoke\IntegerCounter::$count !== 6) {
                    throw new LogicException('Worker static table did not start fresh');
                }
                throw new RuntimeException('end worker request');
            });
        } catch (RuntimeException $error) {
            if ($error->getMessage() !== 'end worker request') {
                throw $error;
            }
        }
        if (standalone_initial_integer_state() !== 21 || VPHP\Smoke\IntegerCounter::$count !== 21) {
            throw new RuntimeException('Worker static table did not restore its outer state');
        }
    }
    foreach ([VPHP\Smoke\IntegerCounter::class, VPHP\Smoke\LegacyIntegerCounter::class] as $class) {
        foreach ([false, true] as $fails) {
            $class::$count = 5;
            $seen = $class::outerSync(static function () use ($class, $fails): void {
                if ($class::$count !== 15) {
                    throw new LogicException('PHP callback did not observe the pending V write');
                }
                $class::$count += 4;
                try {
                    if ($class::innerSync(fail: $fails) !== 21 || $fails) {
                        throw new LogicException('Inner V method did not observe the PHP write');
                    }
                } catch (Exception $error) {
                    if (!$fails || $error->getMessage() !== 'reentrant inner failure') {
                        throw $error;
                    }
                }
                if ($class::$count !== 21) {
                    throw new LogicException('PHP did not observe the inner V write');
                }
                $class::$count += 8;
            });
            if ($seen !== 29 || $class::$count !== 29) {
                throw new LogicException('Outer V method did not reload the final PHP write');
            }
        }
        $class::$count = 2;
        try {
            $class::outerSync(static fn () => $class::innerSync(fail: true));
            throw new LogicException('Expected the inner exception to propagate');
        } catch (Exception $error) {
            if ($error->getMessage() !== 'reentrant inner failure') {
                throw $error;
            }
        }
        if ($class::$count !== 14 || $class::innerSync(fail: false) !== 16 || $class::$count !== 16) {
            throw new LogicException('Uncaught inner exception left the static table inconsistent');
        }
    }
    $exerciseStaticReentry = static function (string $outer, string $middle, bool $shared): void {
        $checkCounts = static function (int $outerCount, int $middleCount, string $stage) use ($outer, $middle): void {
            $actual = [$outer::$count, $middle::$count];
            if ($actual !== [$outerCount, $middleCount]) {
                throw new LogicException("$outer at $stage: expected $outerCount/$middleCount, got " . implode('/', $actual));
            }
        };
        foreach ([false, true] as $fails) {
            $outer::$count = 5;
            if (!$shared) {
                $middle::$count = 100;
            }
            try {
                $outerResult = $outer::outerSync(static function () use ($outer, $middle, $shared, $fails, $checkCounts): void {
                    $checkCounts(15, $shared ? 15 : 100, 'first PHP callback');
                    $outer::$count += 4;
                    $middle::$count += 7;
                    try {
                        $middleResult = $middle::outerSync(static function () use ($outer, $middle, $shared, $fails, $checkCounts): void {
                            $checkCounts($shared ? 36 : 19, $shared ? 36 : 117, 'second PHP callback');
                            $outer::$count += 3;
                            $middle::$count += 5;
                            try {
                                if ($outer::innerSync(fail: $fails) !== ($shared ? 46 : 24)) {
                                    throw new LogicException('Reentrant V method did not read the latest PHP value');
                                }
                            } finally {
                                $checkCounts($shared ? 46 : 24, $shared ? 46 : 122, 'exit from reentrant V method');
                                $outer::$count += 6;
                                $middle::$count += 9;
                            }
                        });
                        if ($middleResult !== ($shared ? 61 : 131)) {
                            throw new LogicException('Middle V method did not reload its static table');
                        }
                    } finally {
                        $checkCounts($shared ? 61 : 30, $shared ? 61 : 131, 'exit from middle V method');
                        $outer::$count += 8;
                        $middle::$count += 11;
                    }
                });
                if ($fails || $outerResult !== ($shared ? 80 : 38)) {
                    throw new LogicException('Outer V method did not reload its static table or propagate the inner exception');
                }
            } catch (Exception $error) {
                if (!$fails || $error->getMessage() !== 'reentrant inner failure') {
                    throw $error;
                }
            }
            $checkCounts($shared ? 80 : 38, $shared ? 80 : 142, 'exit from outer V method');
            if ($outer::innerSync(fail: false) !== ($shared ? 82 : 40)
                || $middle::innerSync(fail: false) !== ($shared ? 84 : 144)) {
                throw new LogicException('Later V calls did not read the final values of both static tables');
            }
            $checkCounts($shared ? 84 : 40, $shared ? 84 : 144, 'subsequent V calls');
        }
    };

    class SharedIntegerCounter extends VPHP\Smoke\IntegerCounter {}
    class SeparateIntegerCounter extends VPHP\Smoke\IntegerCounter { public static int $count = 100; }
    class InheritedSeparateIntegerCounter extends SeparateIntegerCounter {}
    class SharedLegacyIntegerCounter extends VPHP\Smoke\LegacyIntegerCounter {}
    class SeparateLegacyIntegerCounter extends VPHP\Smoke\LegacyIntegerCounter { public static int $count = 100; }
    class InheritedSeparateLegacyIntegerCounter extends SeparateLegacyIntegerCounter {}

    foreach ([
        [VPHP\Smoke\IntegerCounter::class, VPHP\Smoke\LegacyIntegerCounter::class, false],
        [VPHP\Smoke\IntegerCounter::class, SharedIntegerCounter::class, true],
        [VPHP\Smoke\IntegerCounter::class, SeparateIntegerCounter::class, false],
        [SeparateIntegerCounter::class, InheritedSeparateIntegerCounter::class, true],
        [VPHP\Smoke\LegacyIntegerCounter::class, SharedLegacyIntegerCounter::class, true],
        [VPHP\Smoke\LegacyIntegerCounter::class, SeparateLegacyIntegerCounter::class, false],
        [SeparateLegacyIntegerCounter::class, InheritedSeparateLegacyIntegerCounter::class, true],
    ] as [$left, $right, $shared]) {
        $exerciseStaticReentry($left, $right, $shared);
        $exerciseStaticReentry($right, $left, $shared);
    }

    foreach ([
        [VPHP\Smoke\IntegerCounter::class, SeparateIntegerCounter::class, 'standalone_initial_integer_state'],
        [VPHP\Smoke\LegacyIntegerCounter::class, SeparateLegacyIntegerCounter::class, 'standalone_legacy_integer_shadow'],
    ] as [$base, $child, $readBase]) {
        $base::$count = 10;
        $base::innerSync(fail: false);
        $child::$count = 100;
        $result = $child::outerSync(static function () use ($base, $child, $readBase): void {
            if ($child::$count !== 110 || $readBase() !== 12 || $base::innerSync(fail: false) !== 14) {
                throw new LogicException('Redeclared property leaked into the parent V state');
            }
            $child::$count += 5;
        });
        if ($result !== 115 || $child::$count !== 115 || $base::$count !== 14 || $readBase() !== 14) {
            throw new LogicException('Parent V state changed when the child method returned');
        }
    }

    class PartiallySeparateCounter extends VPHP\Smoke\StaticCounter { public static int $count = 100; }
    VPHP\Smoke\StaticCounter::$count = 20;
    VPHP\Smoke\StaticCounter::$label = 'shared';
    if (PartiallySeparateCounter::advance(by: 3) !== 103 || PartiallySeparateCounter::$count !== 103
        || VPHP\Smoke\StaticCounter::$count !== 20 || VPHP\Smoke\StaticCounter::$label !== "shared\0V"
        || PartiallySeparateCounter::$label !== "shared\0V") {
        throw new LogicException('A partially redeclared table did not preserve the inherited fields');
    }

    class WorkerIntegerChild extends VPHP\Smoke\IntegerCounter {
        private const INITIAL = 100;
        public static int $count = self::INITIAL;
    }
    class_alias(WorkerIntegerChild::class, 'WorkerIntegerAlias');
    class WorkerIntegerGrandchild extends WorkerIntegerChild {}

    $outsideLabel = 'outside';
    VPHP\Smoke\IntegerCounter::$count = 400;
    VPHP\Smoke\IntegerCounter::$label =& $outsideLabel;
    WorkerIntegerChild::$count = 500;
    foreach ([false, true, false] as $fail) {
        try {
            vphp_standalone_probe_with_static_request(static function () use ($fail): void {
                if (!class_exists('WorkerLegacyChild', false)) {
                    class WorkerLegacyChild extends VPHP\Smoke\LegacyIntegerCounter {
                        private const INITIAL = 200;
                        public static int $count = self::INITIAL;
                    }
                }
                foreach ([
                    [VPHP\Smoke\IntegerCounter::class, WorkerIntegerAlias::class, 5, 100, 'default'],
                    [VPHP\Smoke\LegacyIntegerCounter::class, WorkerLegacyChild::class, 0, 200, ''],
                ] as [$base, $child, $baseInitial, $childInitial, $labelInitial]) {
                    if ([$base::$count, $child::$count, $base::$label, $child::$label]
                        !== [$baseInitial, $childInitial, $labelInitial, $labelInitial]) {
                        throw new LogicException('Worker inherited table did not start from its declarations');
                    }
                    $child::$count += 10;
                    $base::$label = 'PHP';
                    if ($child::touchWorkerStatics() !== ($childInitial + 10) . ':PHP'
                        || [$base::$count, $child::$count, $base::$label, $child::$label]
                            !== [$baseInitial, $childInitial + 11, 'PHP:V', 'PHP:V']
                        || $base::touchWorkerStatics() !== "$baseInitial:PHP:V"
                        || [$base::$count, $child::$count, $child::$label] !== [$baseInitial + 1, $childInitial + 11, 'PHP:V:V']) {
                        throw new LogicException('Worker inherited table did not synchronize in both directions');
                    }
                }
                if (WorkerIntegerGrandchild::$count !== 111) {
                    throw new LogicException('Worker grandchild did not share the redeclared field');
                }
                if ($fail) {
                    throw new RuntimeException('end inherited worker request');
                }
            });
            if ($fail) {
                throw new LogicException('Worker exception did not propagate');
            }
        } catch (RuntimeException $error) {
            if (!$fail || $error->getMessage() !== 'end inherited worker request') {
                throw $error;
            }
        }
        if ([VPHP\Smoke\IntegerCounter::$count, WorkerIntegerChild::$count, VPHP\Smoke\IntegerCounter::$label,
            $outsideLabel, WorkerLegacyChild::$count] !== [400, 500, 'outside', 'outside', 200]) {
            throw new LogicException('Worker inherited table did not restore the outer state');
        }
    }
    WorkerIntegerGrandchild::$label = 'after worker';
    if ($outsideLabel !== 'after worker') {
        throw new LogicException('Worker did not restore the inherited PHP reference binding');
    }
    class WorkerFloatChild extends VPHP\Smoke\StaticCounter {
        private const INITIAL = 100;
        public static float $ratio = self::INITIAL;
    }
    WorkerFloatChild::$ratio = 250.0;
    vphp_standalone_probe_with_static_request(static function (): void {
        if (WorkerFloatChild::$ratio !== 100.0 || VPHP\Smoke\StaticCounter::$ratio !== 2.5) {
            throw new LogicException('Worker default did not preserve the float property type');
        }
    });
    if (WorkerFloatChild::$ratio !== 250.0) {
        throw new LogicException('Worker did not restore the outer float property');
    }

    foreach ([
        [VPHP\Smoke\IntegerCounter::class, WorkerIntegerChild::class, [5, 100, 'default']],
        [VPHP\Smoke\LegacyIntegerCounter::class, WorkerLegacyChild::class, [0, 200, '']],
    ] as [$base, $child, $defaults]) {
        vphp_standalone_probe_with_static_request(static function () use ($base, $child, $defaults): void {
            foreach ([false, true] as $fails) {
                $count = 70;
                $label = 'outer';
                $base::$count =& $count;
                $child::$count =& $count;
                $base::$label =& $label;
                if ($child::touchWorkerStatics() !== '70:outer') {
                    throw new LogicException('Child V method did not observe the shared outer references');
                }
                $failure = new RuntimeException('inner worker failure');
                try {
                    $result = vphp_standalone_probe_with_static_request(
                        static function () use ($base, $child, $defaults, $fails, $failure, &$count, &$label): string {
                            if ([$base::$count, $child::$count, $child::$label] !== $defaults
                                || [$count, $label] !== [71, 'outer:V']) {
                                throw new LogicException('Nested worker did not start with isolated defaults');
                            }
                            $count = 800;
                            $label = 'inner';
                            $child::$label =& $label;
                            $child::$count = 900;
                            if ($child::touchWorkerStatics() !== '900:inner'
                                || [$base::$count, $child::$count, $base::$label, $label] !== [$defaults[0], 901, 'inner:V', 'inner:V']) {
                                throw new LogicException('Nested worker V/PHP synchronization failed');
                            }
                            if ($fails) {
                                throw $failure;
                            }
                            return 'inner result';
                        }
                    );
                    if ($fails || $result !== 'inner result') {
                        throw new LogicException('Nested worker did not preserve its return or exception');
                    }
                } catch (RuntimeException $error) {
                    if ($error !== $failure) {
                        throw $error;
                    }
                }
                if ([$base::$count, $child::$count, $base::$label, $child::$label, $count, $label]
                    !== [71, 71, 'outer:V', 'outer:V', 71, 'outer:V']) {
                    throw new LogicException('Nested worker did not restore both classes and their PHP aliases');
                }
                $child::$count++;
                $label = 'after';
                if ($base::touchWorkerStatics() !== '72:after'
                    || [$child::$count, $count, $child::$label, $label] !== [73, 73, 'after:V', 'after:V']) {
                    throw new LogicException('Nested worker did not restore the original reference bindings');
                }
                try {
                    $label = [];
                    throw new LogicException('Nested worker lost the typed reference constraint');
                } catch (TypeError $expected) {
                }
            }
        });
    }

    foreach ([
        [VPHP\Smoke\IntegerCounter::class, WorkerIntegerChild::class, [5, 100, 'default']],
        [VPHP\Smoke\LegacyIntegerCounter::class, WorkerLegacyChild::class, [0, 200, '']],
    ] as [$base, $child, $defaults]) {
        vphp_standalone_probe_with_static_request(static function () use ($base, $child, $defaults): void {
            foreach ([[$base, $child], [$child, $base]] as [$outer, $other]) {
                foreach (['return', 'catch', 'propagate'] as $mode) {
                    $baseCount = 40;
                    $childCount = 70;
                    $label = 'outside';
                    $base::$count =& $baseCount;
                    $child::$count =& $childCount;
                    $child::$label =& $label;
                    $flushed = $outer === $base ? [50, 70, 'outside:outer'] : [40, 80, 'outside:outer'];
                    $checkFlushed = static function () use ($base, $child, $flushed, &$baseCount, &$childCount, &$label): void {
                        if ([$base::$count, $child::$count, $child::$label] !== $flushed
                            || [$baseCount, $childCount, $base::$label] !== $flushed || $label !== $flushed[2]) {
                            throw new LogicException('Worker reentry lost the pending writes or reference values');
                        }
                    };
                    $innerError = null;
                    try {
                        $resumed = $outer::reenterWorkerStatics(
                            static function () use ($base, $child, $outer, $other, $mode, $defaults, $checkFlushed,
                                &$baseCount, &$childCount, &$label, &$innerError): void {
                                $checkFlushed();
                                try {
                                    $result = vphp_standalone_probe_with_static_request(
                                        static function () use ($base, $child, $outer, $other, $mode, $defaults,
                                            &$baseCount, &$childCount, &$label): string {
                                            if ([$base::$count, $child::$count, $base::$label] !== $defaults) {
                                                throw new LogicException('Worker reentry did not start the inner scope with defaults');
                                            }
                                            $baseCount = 400;
                                            $childCount = 700;
                                            $label = 'inside';
                                            $child::$label =& $label;
                                            $outerDefault = $outer === $base ? $defaults[0] : $defaults[1];
                                            $otherDefault = $other === $base ? $defaults[0] : $defaults[1];
                                            if ($other::touchWorkerStatics() !== "$otherDefault:inside"
                                                || $outer::touchWorkerStatics() !== "$outerDefault:inside:V"
                                                || $base::$label !== 'inside:V:V' || $label !== 'inside:V:V'
                                                || $outer::$count !== $outerDefault + 1 || $other::$count !== $otherDefault + 1) {
                                                throw new LogicException('Worker reentry did not synchronize both inner V views');
                                            }
                                            if ($mode !== 'return') {
                                                $outer::innerSync(fail: true);
                                            }
                                            return 'inner return';
                                        }
                                    );
                                    if ($mode !== 'return' || $result !== 'inner return') {
                                        throw new LogicException('Worker reentry lost the inner return or exception');
                                    }
                                } catch (Exception $error) {
                                    if ($mode === 'return' || $error->getMessage() !== 'reentrant inner failure') {
                                        throw $error;
                                    }
                                    $innerError = $error;
                                    if ($mode === 'propagate') {
                                        throw $error;
                                    }
                                } finally {
                                    $checkFlushed();
                                }
                            }
                        );
                        $expected = ($outer === $base ? $flushed[0] : $flushed[1]) . ':outside:outer';
                        if ($mode === 'propagate' || $resumed !== $expected) {
                            throw new LogicException('Outer V method did not resume with its saved state or propagate the exception');
                        }
                    } catch (Exception $error) {
                        if ($mode !== 'propagate' || $error !== $innerError) {
                            throw $error;
                        }
                    }
                    $pending = $outer === $base ? [51, 70, 'outside:outer:resumed'] : [40, 81, 'outside:outer:resumed'];
                    if ([$baseCount, $childCount, $label] !== $pending
                        || [$base::$count, $child::$count, $child::$label] !== $pending) {
                        throw new LogicException('Outer V writes after worker reentry were not published');
                    }
                    $baseCount++;
                    $child::$count++;
                    $label = 'restored binding';
                    if ([$base::$count, $childCount, $child::$label] !== [$pending[0] + 1, $pending[1] + 1, $label]) {
                        throw new LogicException('Worker reentry did not restore the original PHP bindings');
                    }
                }
            }
        });
    }
    foreach ([
        [VPHP\Smoke\IntegerCounter::class, WorkerIntegerChild::class, [5, 100, 'default']],
        [VPHP\Smoke\LegacyIntegerCounter::class, WorkerLegacyChild::class, [0, 200, '']],
    ] as [$base, $child, $defaults]) {
        $read = static fn (): array => [$base::$count, $child::$count, $child::$label];
        $bind = static function (array &$values) use ($base, $child): void {
            $base::$count =& $values[0];
            $child::$count =& $values[1];
            $base::$label =& $values[2];
        };
        $assertRestored = static function (array $values, array $expected, string $stage) use ($base, $child, $read): void {
            if ($values !== $expected || $read() !== $expected || $base::$label !== $expected[2]) {
                throw new LogicException("Three worker scopes left incorrect values at $stage");
            }
            $properties = [&$base::$count, &$child::$count, &$child::$label];
            foreach ($properties as $index => $value) {
                $expectedId = ReflectionReference::fromArrayElement($values, $index)?->getId();
                if ($expectedId === null || ReflectionReference::fromArrayElement($properties, $index)?->getId() !== $expectedId) {
                    throw new LogicException("Three worker scopes changed reference $index at $stage");
                }
            }
        };

        foreach (['return', 'catch-middle', 'catch-outer', 'escape-worker'] as $mode) {
            $rootValues = [11, 22, 'root'];
            $bind($rootValues);
            $failure = match ($mode) {
                'escape-worker' => new Error('deepest worker failure'),
                'catch-outer' => new Exception('deepest worker failure'),
                default => new RuntimeException('deepest worker failure'),
            };
            $runOuter = static function () use ($base, $child, $defaults, $mode, $failure, $read, $bind, $assertRestored, &$rootValues): void {
                if ($read() !== $defaults) {
                    throw new LogicException('Outer worker did not start with defaults');
                }
                [$rootValues[0], $rootValues[1], $rootValues[2]] = [111, 222, 'changed from outer'];
                $outerValues = [40, 70, 'outer'];
                $bind($outerValues);
                $runOuterCallback = static function () use ($base, $child, $defaults, $mode, $failure, $read, $bind, $assertRestored, &$outerValues): void {
                    $assertRestored($outerValues, [50, 70, 'outer:outer'], 'outer callback entry');
                    $runMiddle = static function () use ($base, $child, $defaults, $mode, $failure, $read, $bind, $assertRestored, &$outerValues): void {
                        if ($read() !== $defaults) {
                            throw new LogicException('Middle worker did not start with defaults');
                        }
                        [$outerValues[0], $outerValues[1], $outerValues[2]] = [400, 700, 'changed from middle'];
                        $middleValues = [140, 170, 'middle'];
                        $bind($middleValues);
                        $runDeepest = static function () use ($base, $child, $defaults, $mode, $failure, $read, &$middleValues): string {
                            if ($read() !== $defaults) {
                                throw new LogicException('Deepest worker did not start with defaults');
                            }
                            [$middleValues[0], $middleValues[1], $middleValues[2]] = [1400, 1700, 'deepest'];
                            $child::$label =& $middleValues[2];
                            if ($base::touchWorkerStatics() !== $defaults[0] . ':deepest'
                                || $child::touchWorkerStatics() !== $defaults[1] . ':deepest:V'
                                || $read() !== [$defaults[0] + 1, $defaults[1] + 1, 'deepest:V:V']) {
                                throw new LogicException('Deepest worker did not synchronize both V static tables');
                            }
                            if ($mode !== 'return') {
                                throw $failure;
                            }
                            return 'deepest return';
                        };
                        try {
                            $middleResult = $child::reenterWorkerStatics(
                                static function () use ($child, $mode, $failure, $runDeepest, $assertRestored, &$middleValues): void {
                                    $assertRestored($middleValues, [140, 180, 'middle:outer'], 'middle callback entry');
                                    try {
                                        $result = vphp_standalone_probe_with_static_request($runDeepest);
                                        if ($mode !== 'return' || $result !== 'deepest return') {
                                            throw new LogicException('Deepest worker lost the expected return or exception');
                                        }
                                    } catch (RuntimeException $error) {
                                        if ($mode !== 'catch-middle' || $error !== $failure) {
                                            throw $error;
                                        }
                                    } finally {
                                        $assertRestored($middleValues, [140, 180, 'middle:outer'], 'deepest worker exit');
                                    }
                                    $middleValues[0]++;
                                    $child::$label .= ':PHP';
                                }
                            );
                        } finally {
                            $expected = in_array($mode, ['catch-outer', 'escape-worker'], true)
                                ? [140, 181, 'middle:outer:resumed']
                                : [141, 181, 'middle:outer:PHP:resumed'];
                            $assertRestored($middleValues, $expected, 'middle V method exit');
                        }
                        if ($middleResult !== '180:middle:outer:PHP') {
                            throw new LogicException('Middle V method did not resume with the restored state and PHP writes');
                        }
                    };

                    $caughtOutside = false;
                    try {
                        vphp_standalone_probe_with_static_request($runMiddle);
                    } catch (Exception $error) {
                        if ($mode !== 'catch-outer' || $error !== $failure) {
                            throw $error;
                        }
                        $caughtOutside = true;
                    } finally {
                        $assertRestored($outerValues, [50, 70, 'outer:outer'], 'middle worker exit');
                    }
                    if ($mode === 'catch-outer') {
                        if (!$caughtOutside) {
                            throw new LogicException('Deepest exception did not reach the outer callback');
                        }
                        $outerValues[1]++;
                        $child::$label .= ':caught';
                    }
                };
                $suffix = $mode === 'catch-outer' ? ':caught' : '';
                $expectedChildCount = $mode === 'catch-outer' ? 71 : 70;
                try {
                    $outerResult = $base::reenterWorkerStatics($runOuterCallback);
                } finally {
                    $assertRestored($outerValues, [51, $expectedChildCount, "outer:outer$suffix:resumed"], 'outer V method exit');
                }
                if ($outerResult !== "50:outer:outer$suffix") {
                    throw new LogicException('Outer V method did not resume with the restored state and PHP writes');
                }
            };
            try {
                vphp_standalone_probe_with_static_request($runOuter);
                if ($mode === 'escape-worker') {
                    throw new LogicException('Deepest throwable did not escape the outer worker');
                }
            } catch (Error $error) {
                if ($mode !== 'escape-worker' || $error !== $failure) {
                    throw $error;
                }
            }
            $assertRestored($rootValues, [11, 22, 'root'], 'outer worker exit');
            if ($mode === 'escape-worker') {
                vphp_standalone_probe_with_static_request(
                    static function () use ($base, $child, $defaults, $read, $bind, $assertRestored): void {
                        if ($read() !== $defaults) {
                            throw new LogicException('Next worker started with state from the failed worker');
                        }
                        $nextValues = [60, 90, 'next'];
                        $bind($nextValues);
                        if ($base::touchWorkerStatics() !== '60:next'
                            || $child::touchWorkerStatics() !== '90:next:V') {
                            throw new LogicException('Next worker could not read its own static table writes');
                        }
                        $assertRestored($nextValues, [61, 91, 'next:V:V'], 'next worker writes');
                    }
                );
                $assertRestored($rootValues, [11, 22, 'root'], 'next worker exit');
            }
        }
    }
}
$combinedTrait = new ReflectionClass(VPHP\Smoke\CombinedCaseTrait::class);
$combinedConstant = $combinedTrait->getReflectionConstant('TRAIT_MODE');
$combinedRequirement = $combinedTrait->getMethod('formatValue');
$combinedMethod = $combinedTrait->getMethod('traitLabel');
$aliasedMethod = $combinedTrait->getMethod('init');
$aliasedConstructor = $combinedTrait->getMethod('reinitialize');
$rivalTrait = VPHP\Smoke\RivalCaseTrait::class;
$excludedMethod = $combinedTrait->getMethod('rivalLabel');
$excludedAlias = $excludedMethod->getParameters()[0];
$traitFinal = PHP_VERSION_ID >= 80300;
if ($combinedTrait->getTraitNames() !== [$rivalTrait, $nativeTrait, VPHP\Smoke\AlternateCaseTrait::class, VPHP\Smoke\PrivateRequirement::class]
    || $combinedTrait->getTraitNames() !== array_keys($combinedTrait->getTraits())
    || $combinedTrait->getTraitAliases() !== ['init' => $nativeTrait . '::traitLabel',
        'twice' => $nativeTrait . '::traitDouble', 'reinitialize' => $nativeTrait . '::__construct',
        'rivalLabel' => $rivalTrait . '::traitLabel']
    || (string) $excludedAlias->getType() !== 'int' || $excludedAlias->getName() !== 'number'
    || $excludedAlias->getDefaultValue() !== 5
    || !$combinedMethod->isPrivate() || !$excludedMethod->isProtected() || !$aliasedMethod->isPublic()
    || $excludedMethod->isFinal() !== $traitFinal
    || $combinedTrait->getMethod('traitDouble')->isFinal() !== $traitFinal
    || $combinedTrait->getMethod('twice')->isFinal() !== $traitFinal
    || (new ReflectionMethod($nativeTrait, 'traitDouble'))->isFinal()
    || (new ReflectionMethod(StandaloneCombinedTraitConsumer::class, 'twice'))->isFinal() !== $traitFinal
    || (new ReflectionMethod(StandaloneTraitLocalOverride::class, 'traitDouble'))->isFinal()
    || StandaloneTraitLocalOverride::traitDouble(value: 4) !== 5
    || !(new ReflectionMethod($nativeTrait, 'traitLabel'))->isPublic()
    || !(new ReflectionMethod(StandaloneCombinedTraitConsumer::class, 'traitLabel'))->isPrivate()
    || !(new ReflectionMethod(StandaloneProtectedTraitAliasConsumer::class, 'rivalLabel'))->isProtected()
    || $aliasedMethod->isConstructor() || (string) $aliasedMethod->getReturnType() !== 'string'
    || $aliasedConstructor->isConstructor() || $aliasedConstructor->hasReturnType()
    || $aliasedConstructor->getParameters()[0]->getDefaultValue() !== 3
    || $aliasedMethod->getParameters()[0]->getName() !== 'label'
    || $aliasedMethod->getParameters()[0]->getDefaultValue() !== 'default'
    || $combinedConstant->getValue() !== VPHP\Smoke\EnumAliasTarget::ready
    || StandaloneCombinedTraitConsumer::TRAIT_MODE !== VPHP\Smoke\EnumAliasTarget::ready
    || $combinedConstant->getDeclaringClass()->getName() !== $combinedTrait->getName()
    || !$combinedRequirement->isAbstract() || !$combinedRequirement->isPrivate()
    || $combinedMethod->getDeclaringClass()->getName() !== $combinedTrait->getName()
    || $combinedMethod->getParameters()[0]->getDefaultValue() !== 'default'
    || (PHP_VERSION_ID >= 80300 && (string) $combinedConstant->getType() !== VPHP\Smoke\EnumAliasTarget::class)) {
    throw new RuntimeException('Unexpected reflection metadata on composed native trait');
}
foreach ([
    $nativeTrait => $nativeTrait,
    StandaloneNativeTraitConsumer::class => StandaloneNativeTraitConsumer::class,
    StandaloneWrappedTraitConsumer::class => StandaloneWrappedTraitConsumer::class,
    StandaloneInheritedTraitConsumer::class => StandaloneNativeTraitConsumer::class,
] as $owner => $declaringClass) {
    $alias = new ReflectionClassConstant($owner, 'TRAIT_MODE');
    $attrs = $alias->getAttributes(VPHP\Fixture\SmokeConstant::class);
    $idle = new ReflectionClassConstant($owner, 'TRAIT_IDLE');
    $property = new ReflectionProperty($owner, 'traitLevel');
    $method = new ReflectionMethod($owner, 'traitLabel');
    $param = $method->getParameters()[0];
    $constructor = new ReflectionMethod($owner, '__construct');
    [$level, $offset] = $constructor->getParameters();
    if ($alias->getDeclaringClass()->getName() !== $declaringClass || $alias->isEnumCase()
        || !$alias->isFinal() || !$alias->isPublic() || $alias->getValue() !== VPHP\Smoke\EnumAliasTarget::ready
        || count($attrs) !== 1 || $attrs[0]->getArguments() !== ['slot' => 'trait mode']
        || !$idle->isProtected() || $idle->getValue() !== VPHP\Smoke\EnumConstants::idle
        || (PHP_VERSION_ID >= 80300 && (string) $alias->getType() !== VPHP\Smoke\EnumAliasTarget::class)
        || (string) $property->getType() !== 'int' || $property->getDefaultValue() !== 2
        || (string) $method->getReturnType() !== 'string' || $param->getName() !== 'label'
        || $param->getDefaultValue() !== 'default'
        || $constructor->getDeclaringClass()->getName() !== $declaringClass
        || $constructor->hasReturnType() || $constructor->getNumberOfRequiredParameters() !== 0
        || $level->getName() !== 'level' || (string) $level->getType() !== 'int' || $level->getDefaultValue() !== 3
        || $offset->getName() !== 'offset' || (string) $offset->getType() !== 'int' || $offset->getDefaultValue() !== 0) {
        throw new RuntimeException("Unexpected native trait metadata for $owner");
    }
}
$combined = (new ReflectionClass(StandaloneCombinedTraitConsumer::class))->newInstanceWithoutConstructor();
foreach (['traitLabel' => 'private', 'rivalLabel' => 'protected'] as $name => $visibility) {
    try {
        $combined->$name();
        throw new RuntimeException("Expected $name to be $visibility");
    } catch (Error $e) {
        if (!str_contains($e->getMessage(), "Call to $visibility method")) {
            throw $e;
        }
    }
}
if (extension_loaded('standalone_probe')) {
    $consumer = new StandaloneNativeTraitConsumer();
    $combined = new StandaloneCombinedTraitConsumer();
    $combined->reinitialize(level: 9);
    if ($consumer->traitLevel !== 3 || $consumer->traitLabel() !== 'trait:default'
        || $consumer->aliasedLabel(label: 'named') !== 'trait:named'
        || StandaloneNativeTraitConsumer::traitDouble(value: 5) !== 10
        || VPHP\Smoke\Probe::traitDouble(value: 5) !== 10
        || (new StandaloneNativeTraitConsumer(5, 3))->traitLevel !== 8
        || (new StandaloneInheritedTraitConsumer(offset: 4))->traitLevel !== 7
        || (new StandaloneOverriddenTraitConstructor(6))->traitLevel !== 7
        || (new VPHP\Smoke\Probe(offset: 1))->traitLevel !== 4
        || (new StandaloneCombinedTraitConsumer(offset: 3))->traitLevel !== 6
        || $combined->callPrivateTraitLabel(label: 'composed') !== 'trait:composed'
        || (new StandaloneProtectedTraitAliasConsumer())->callRivalLabel() !== 'rival:5'
        || (new StandaloneProtectedTraitAliasConsumer())->callRivalLabel(number: 9) !== 'rival:9'
        || (new StandaloneCombinedTraitConsumer())->init(label: 'alias') !== 'trait:alias'
        || $combined->traitLevel !== 9
        || StandaloneCombinedTraitConsumer::traitDouble(value: 6) !== 12
        || StandaloneCombinedTraitConsumer::twice(value: 6) !== 12) {
        throw new RuntimeException('Unexpected native trait member invocation');
    }
}
if (PHP_VERSION_ID >= 80300
    && ((string) $enumOrdinary->getType() !== 'int' || (string) $enumLimit->getType() !== 'float'
        || (string) $enumSecret->getType() !== 'string'
        || (string) $enumAlias->getType() !== VPHP\Smoke\EnumConstants::class
        || (string) $inferredAlias->getType() !== VPHP\Smoke\EnumConstants::class
        || (string) $remoteAlias->getType() !== VPHP\Smoke\EnumAliasTarget::class)) {
    throw new RuntimeException('Unexpected enum constant types');
}
foreach ([
    'protected' => static fn () => VPHP\Smoke\EnumConstants::LIMIT,
    'private' => static fn () => VPHP\Smoke\EnumConstants::SECRET,
] as $visibility => $read) {
    try {
        $read();
        throw new RuntimeException('Enum constant was readable outside its visibility');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), "Cannot access $visibility constant")) {
            throw $error;
        }
    }
}
$arrayDefault = ['tags' => ['雪', null], 4 => ['enabled' => false], '08' => 'kept', 5 => 7];
$left = new VPHP\Smoke\ArrayDefault();
$right = new VPHP\Smoke\ArrayDefault();
$options = new ReflectionProperty($left, 'options');
$reflected = $options->getDefaultValue();
if ((string) $options->getType() !== 'array' || !$options->hasDefaultValue()
    || $reflected !== $arrayDefault || $left->options !== $arrayDefault || $right->options !== $arrayDefault) {
    throw new RuntimeException('Unexpected array property default');
}
$left->options['tags'][0] = 'changed';
$tags =& $left->options['tags'];
$tags[] = 'left only';
unset($left->options[4]);
$reflected['tags'][0] = 'reflection only';
if ($left->options['tags'] !== ['changed', null, 'left only'] || isset($left->options[4])
    || $right->options !== $arrayDefault || (new VPHP\Smoke\ArrayDefault())->options !== $arrayDefault
    || $options->getDefaultValue() !== $arrayDefault) {
    throw new RuntimeException('Mutating an array property changed the shared default');
}
$unionArray = new VPHP\Smoke\UnionArrayDefault();
$unionOptions = new ReflectionProperty($unionArray, 'options');
if (!$unionOptions->getType() instanceof ReflectionUnionType || $unionOptions->getDefaultValue() !== [[]]
    || $unionArray->options !== [[]]) {
    throw new RuntimeException('Unexpected array default for a union property');
}
foreach ([
    [VPHP\Smoke\StringDefault::class, 'label', 'string', '雪'],
    [VPHP\Smoke\IntDefault::class, 'limit', 'int', -12],
    [VPHP\Smoke\FloatDefault::class, 'ratio', 'float', 2.0],
    [VPHP\Smoke\BoolDefault::class, 'enabled', 'bool', true],
    [VPHP\Smoke\NullDefault::class, 'optionalValue', 'mixed', null],
] as [$className, $name, $type, $value]) {
    $defaults = new $className();
    $property = new ReflectionProperty($defaults, $name);
    if ($property->getType()?->getName() !== $type || !$property->hasDefaultValue()
        || $property->getDefaultValue() !== $value || $defaults->$name !== $value) {
        throw new RuntimeException("Unexpected property default for $name");
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
if [ "$(uname -s)" = Linux ] && command -v readelf >/dev/null 2>&1; then
    readelf -d "$project/build/standalone_probe.so" | grep -q 'FLAGS_1.*NODELETE'
fi
"${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" \
    -r 'require $argv[1]; verifyWorkerStaticFibers();' "$repo/cmd/vphp/tests/worker-static-fibers.php"
if [ -n "$vhttpd_root" ]; then
    "${VPHP_PHP:-php}" "$repo/cmd/vphp/tests/worker-static-http.php" \
        "$vhttpd_root" "${VHTTPD_BIN:-$vhttpd_root/vhttpd}" "$tmp" "$project/build/standalone_probe.so"
fi
"${VPHP_PHP:-php}" -n -d opcache.enable_cli=1 -d opcache.file_update_protection=0 \
    -d "extension=$project/build/standalone_probe.so" "$tmp/verify-metadata.php"
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
        || VPHP\Smoke_First\hello(name: "PHP") !== "First PHP!"
        || VPHP\Smoke_First\hello(punctuation: "?", name: "PHP") !== "First PHP?"
        || vphp_smoke\First\hello(punctuation: ".", name: "PHP") !== "Second PHP."
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
grep -F '\VPHP\Smoke\CaseTrait::traitLabel insteadof \VPHP\Smoke\RivalCaseTrait, \VPHP\Smoke\AlternateCaseTrait;' "$tmp/Standalone Stub.php"
grep -F '\VPHP\Smoke\CaseTrait::traitLabel as private;' "$tmp/Standalone Stub.php"
grep -F '\VPHP\Smoke\RivalCaseTrait::traitLabel as protected rivalLabel;' "$tmp/Standalone Stub.php"
"${VPHP_PHP:-php}" -n "$tmp/verify-metadata.php" "$tmp/Standalone Stub.php"

date_fixture="$repo/cmd/vphp/tests/fixtures/date-time-immutable"
mkdir "$tmp/DateTimeImmutable"
(
    cd "$tmp/DateTimeImmutable"
    cp "$date_fixture/entry.v" .
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "${VPHP_PHP:-php}" -n -l build/date_time_immutable_probe.php
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/date_time_immutable_probe.so" "$date_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$date_fixture/verify.php" "$PWD/build/date_time_immutable_probe.php"
)

lazy_fixture="$repo/cmd/vphp/tests/fixtures/lazy-objects"
mkdir "$tmp/Lazy Objects"
(
    cd "$tmp/Lazy Objects"
    cp "$lazy_fixture/entry.v" .
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "${VPHP_PHP:-php}" -n -l build/lazy_objects_probe.php
    "${VPHP_PHP:-php}" -n -d opcache.enable_cli=1 -d opcache.file_update_protection=0 \
        -d extension="$PWD/build/lazy_objects_probe.so" "$lazy_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$lazy_fixture/verify.php" "$PWD/build/lazy_objects_probe.php"
)

attribute_constants_fixture="$repo/cmd/vphp/tests/fixtures/attribute-constants"
shared_tokenizer=$("${VPHP_PHP:-php}" -n "$repo/vphp/stub/tokenizer_path.php")
if [ -n "$shared_tokenizer" ]; then
    "${VPHP_PHP:-php}" -n -d "extension=$shared_tokenizer" -r 'exit(function_exists("token_get_all") ? 0 : 1);'
fi
mkdir "$tmp/Attribute Constants"
(
    cd "$tmp/Attribute Constants"
    cp "$attribute_constants_fixture/entry.v" .
    "$repo/bin/vphp" check
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "${VPHP_PHP:-php}" -n -l build/attribute_constants_probe.php
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/attribute_constants_probe.so" "$attribute_constants_fixture/verify.php"
    "${VPHP_PHP:-php}" -n -d opcache.enable_cli=1 -d opcache.file_update_protection=0 \
        -d extension="$PWD/build/attribute_constants_probe.so" "$attribute_constants_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$attribute_constants_fixture/verify.php" "$PWD/build/attribute_constants_probe.php"
)

mkdir "$tmp/Invalid Parameter Attribute"
(
    cd "$tmp/Invalid Parameter Attribute"
    for target in apiKey ctx; do
        cat > entry.v <<EOF
module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_sensitive_parameter' }

@[vphp.PhpExportFunction(name: 'inspectSecret')]
@[vphp.PhpSensitiveParameter(v_name: '$target')]
fn inspect_secret(ctx vphp.Context, api_key string) string {
    return api_key
}
EOF
        if "$repo/bin/vphp" check >diagnostic.log 2>&1; then
            echo "VPHP accepted a parameter attribute for $target" >&2
            exit 1
        fi
        grep -F "PHP parameter attribute on inspectSecret: \`$target\` is not a PHP-visible V parameter" diagnostic.log
    done
    cat > entry.v <<'EOF'
module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_sensitive_field' }

struct InvalidSensitiveField {
    api_key string @[vphp.PhpSensitiveField]
}
EOF
    if "$repo/bin/vphp" check >diagnostic.log 2>&1; then
        echo 'VPHP accepted a sensitive field outside a params struct' >&2
        exit 1
    fi
    grep -F 'PhpSensitiveField requires a field of a @[params] struct:' diagnostic.log
)

mkdir "$tmp/Invalid Function Version"
cat > "$tmp/Invalid Function Version/entry.v" <<'EOF'
module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_function_version' }

@[vphp.PhpFunctionSince(version: .php86)]
fn internal_helper() {}
EOF
if "$repo/bin/vphp" check "$tmp/Invalid Function Version" > "$tmp/function-version.log" 2>&1; then
    echo 'Accepted a PHP version gate on an unexported function' >&2
    exit 1
fi
grep -F 'PhpFunctionSince requires an exported PHP function: internal_helper' "$tmp/function-version.log"

mkdir "$tmp/Invalid Constant Version"
cat > "$tmp/Invalid Constant Version/entry.v" <<'EOF'
module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_constant_version' }

@[vphp.PhpGlobalConstantSince(version: .php86)]
const internal_value = 86
EOF
if "$repo/bin/vphp" check "$tmp/Invalid Constant Version" > "$tmp/constant-version.log" 2>&1; then
    echo 'Accepted a PHP version gate on an unexported constant' >&2
    exit 1
fi
grep -F 'PhpGlobalConstantSince requires an exported PHP scalar constant' "$tmp/constant-version.log"

check_versioned_contract_fixture() (
    fixture="$repo/cmd/vphp/tests/fixtures/$1"
    project="$tmp/$2"
    extension="$project/build/$3.so"
    stub="$project/build/$3.php"
    interface_error="$4"
    abstract_error="$5"
    contract_php="${VPHP_PHP:-php}"
    mkdir "$project"
    cd "$project"
    cp "$fixture/entry.v" .
    "$repo/bin/vphp" check
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "$contract_php" -n -l "$stub"
    "$contract_php" -n -d extension="$extension" "$fixture/verify.php"
    "$contract_php" -n "$fixture/verify.php" "$stub"
    if [ "$1" = 'property-versions' ] && "$contract_php" -n -r 'exit(extension_loaded("Zend OPcache") ? 0 : 1);'; then
        "$contract_php" -n -d opcache.enable_cli=1 -d opcache.file_update_protection=0 \
            -d extension="$extension" "$fixture/verify.php"
        "$contract_php" -n -d opcache.enable_cli=1 -d opcache.file_update_protection=0 \
            "$fixture/verify.php" "$stub"
    fi
    contract_version=$("$contract_php" -n -r 'echo PHP_VERSION_ID;')
    missing_contract="$fixture/verify-missing-contract.php"
    for kind in interface abstract; do
        case "$kind" in
            interface) expected="$interface_error" ;;
            abstract) expected="$abstract_error" ;;
        esac
        for mode in extension stub; do
            if [ "$mode" = extension ]; then
                set -- -n -d "extension=$extension" "$missing_contract" "$kind"
            else
                set -- -n "$missing_contract" "$kind" "$stub"
            fi
            if [ "$contract_version" -ge 80600 ]; then
                if "$contract_php" "$@" > "$kind-$mode.log" 2>&1; then
                    echo "PHP accepted a missing $kind contract in the $mode ($fixture)" >&2
                    exit 1
                fi
                grep -F "$expected" "$kind-$mode.log"
            else
                "$contract_php" "$@"
            fi
        done
    done
)

check_versioned_contract_fixture property-versions "Property Versions" property_versions_probe \
    'VphpVersionedContract::$item::get' 'VphpVersionedAbstract::$token::get'
check_versioned_contract_fixture method-versions "Method Versions" method_versions_probe \
    'VphpVersionedMethods::pick' 'VphpVersionedMethodBase::revision'

trait_versions_fixture="$repo/cmd/vphp/tests/fixtures/trait-method-versions"
mkdir "$tmp/Trait Method Versions"
(
    cd "$tmp/Trait Method Versions"
    cp "$trait_versions_fixture/entry.v" .
    "$repo/bin/vphp" check
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "${VPHP_PHP:-php}" -n -l build/trait_method_versions_probe.php
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/trait_method_versions_probe.so" "$trait_versions_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$trait_versions_fixture/verify.php" "$PWD/build/trait_method_versions_probe.php"
    if [ -n "$vhttpd_root" ] && "${VPHP_PHP:-php}" -n -r 'exit(extension_loaded("Zend OPcache") ? 0 : 1);'; then
        "${VPHP_PHP:-php}" -n "$trait_versions_fixture/verify-opcache.php" \
            "$PWD/build/trait_method_versions_probe.so" "$PWD/opcache-server.log"
    fi
)

mkdir "$tmp/Invalid Deprecated Type"
(
    cd "$tmp/Invalid Deprecated Type"
    cat > entry.v <<'EOF'
module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_deprecated_type' }

@[vphp.PhpExportClass(name: 'DeprecatedClassProbe')]
@[vphp.PhpClassAttribute(name: 'Deprecated', args: '')]
struct DeprecatedClassProbe {}
EOF
    if "$repo/bin/vphp" check >diagnostic.log 2>&1; then
        echo 'VPHP accepted Deprecated on an ordinary class' >&2
        exit 1
    fi
    grep -F 'PHP attribute Deprecated on DeprecatedClassProbe: requires an exported native trait' diagnostic.log
)

constructor_versions_fixture="$repo/cmd/vphp/tests/fixtures/constructor-versions"
mkdir "$tmp/Constructor Versions"
(
    cd "$tmp/Constructor Versions"
    cp "$constructor_versions_fixture/entry.v" "$constructor_versions_fixture/exception.v" .
    cp -R "$constructor_versions_fixture/ancestor" .
    "$repo/bin/vphp" check
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "${VPHP_PHP:-php}" -n -l build/constructor_versions_probe.php
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/constructor_versions_probe.so" "$constructor_versions_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$constructor_versions_fixture/verify.php" "$PWD/build/constructor_versions_probe.php"
)

type_versions_fixture="$repo/cmd/vphp/tests/fixtures/type-versions"
mkdir "$tmp/Invalid Type Version"
cat > "$tmp/Invalid Type Version/entry.v" <<'EOF'
module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_type_version' }

@[vphp.PhpTypeSince(version: .php86)]
struct InternalType {}
EOF
if "$repo/bin/vphp" check "$tmp/Invalid Type Version" > "$tmp/type-version.log" 2>&1; then
    echo 'Accepted a PHP version gate on an unexported type' >&2
    exit 1
fi
grep -F 'PhpTypeSince requires an exported PHP type: InternalType' "$tmp/type-version.log"

mkdir "$tmp/Invalid Gated Parent"
cat > "$tmp/Invalid Gated Parent/entry.v" <<'EOF'
module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_gated_parent' }

@[vphp.PhpExportClass(name: 'VphpInvalidGatedParent')]
@[vphp.PhpTypeSince(version: .php86)]
@[vphp.PhpExtends(name: 'VphpMissingNativeParent')]
struct InvalidGatedParent {}
EOF
if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80600 ? 0 : 1);'; then
    if "$repo/bin/vphp" check "$tmp/Invalid Gated Parent" > "$tmp/gated-parent.log" 2>&1; then
        echo 'Accepted an active class with a missing native parent' >&2
        exit 1
    fi
    grep -F 'PHP parent class `VphpMissingNativeParent` was not found' "$tmp/gated-parent.log"
else
    "$repo/bin/vphp" check "$tmp/Invalid Gated Parent"
fi

mkdir "$tmp/Type Versions"
(
    cd "$tmp/Type Versions"
    cp "$type_versions_fixture/entry.v" .
    "$repo/bin/vphp" check
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "${VPHP_PHP:-php}" -n -l build/type_versions_probe.php
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/type_versions_probe.so" "$type_versions_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$type_versions_fixture/verify.php" "$PWD/build/type_versions_probe.php"
)

mkdir "$tmp/Version Gated Serialization"
cp "$repo/cmd/vphp/tests/fixtures/version-gated-serialization/entry.v" "$tmp/Version Gated Serialization/"
if "$repo/bin/vphp" check "$tmp/Version Gated Serialization" > "$tmp/serialization-gate.log" 2>&1; then
    echo 'Accepted a version-gated serialization hook' >&2
    exit 1
fi
grep -F 'serializable class VersionGatedCopy must expose __unserialize on every supported PHP version' "$tmp/serialization-gate.log"

property_override_fixture="$repo/cmd/vphp/tests/fixtures/property-override"
mkdir "$tmp/Property Override" "$tmp/Unmatched Property Override"
(
    cd "$tmp/Property Override"
    cp "$property_override_fixture/valid.v" entry.v
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub --output "$PWD/property_override.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/property_override.so" "$property_override_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$property_override_fixture/verify.php" "$PWD/property_override.php"
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80500 ? 0 : 1);'; then
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/property_override.so" \
            "$property_override_fixture/verify.php" --unmatched-interface
    fi
)
(
    cd "$tmp/Unmatched Property Override"
    cp "$property_override_fixture/invalid.v" entry.v
    "$repo/bin/vphp" build
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80500 ? 0 : 1);'; then
        if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/unmatched_property_override.so" \
            -r 'exit(extension_loaded("unmatched_property_override") ? 0 : 1);' > "$tmp/unmatched-property-override.log" 2>&1; then
            echo 'Override accepted a property with only a private parent match' >&2
            exit 1
        fi
        grep -F 'UnmatchedPropertyOverride::$hidden has #[\Override] attribute, but no matching parent property exists' \
            "$tmp/unmatched-property-override.log"
    else
        "$repo/bin/vphp" stub --output "$PWD/unmatched_property_override.php"
        verify='exit((new ReflectionProperty("UnmatchedPropertyOverride", "hidden"))->getAttributes("Override") === [] ? 0 : 1);'
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/unmatched_property_override.so" -r "$verify"
        "${VPHP_PHP:-php}" -n -r "require \$argv[1]; $verify" unmatched_property_override.php
    fi
)

hook_fixture="$repo/cmd/vphp/tests/fixtures/property-hooks"
mkdir "$tmp/Property Hooks" "$tmp/Unmatched Property Hook"
(
    cd "$tmp/Property Hooks"
    cp "$hook_fixture/valid.v" entry.v
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub --output "$PWD/property_hooks.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/property_hooks.so" "$hook_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$hook_fixture/verify.php" "$PWD/property_hooks.php"
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80500 ? 0 : 1);'; then
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/property_hooks.so" \
            "$hook_fixture/verify.php" --get-only-interface
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/property_hooks.so" \
            "$hook_fixture/verify.php" --set-only-interface
    fi
)
(
    cd "$tmp/Unmatched Property Hook"
    cp "$hook_fixture/invalid.v" entry.v
    "$repo/bin/vphp" build
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80500 ? 0 : 1);'; then
        if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/unmatched_property_hook.so" \
            -r 'exit(extension_loaded("unmatched_property_hook") ? 0 : 1);' > "$tmp/unmatched-property-hook.log" 2>&1; then
            echo 'Override accepted a setter when the parent property only has a getter' >&2
            exit 1
        fi
        grep -F 'HookMissingSetter::$score::set() has #[\Override] attribute, but no matching parent method exists' \
            "$tmp/unmatched-property-hook.log"
    else
        "$repo/bin/vphp" stub --output "$PWD/unmatched_property_hook.php"
        verify='if (PHP_VERSION_ID >= 80400) { $property = new ReflectionProperty("HookMissingSetter", "score"); $hooks = $property->getHooks(); exit(isset($hooks["get"], $hooks["set"]) && $hooks["set"]->getAttributes("Override") === [] ? 0 : 1); } exit(property_exists("HookMissingSetter", "score") ? 1 : 0);'
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/unmatched_property_hook.so" -r "$verify"
        "${VPHP_PHP:-php}" -n -r "require \$argv[1]; $verify" unmatched_property_hook.php
    fi
)

interface_fixture="$repo/cmd/vphp/tests/fixtures/interface-properties"
mkdir "$tmp/Interface Properties" "$tmp/Invalid Interface Property"
(
    cd "$tmp/Interface Properties"
    cp "$interface_fixture/valid.v" entry.v
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub --output "$PWD/interface_properties.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/interface_properties.so" "$interface_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$interface_fixture/verify.php" "$PWD/interface_properties.php"
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
        for operation in get set; do
            log="$tmp/missing-interface-property-$operation.log"
            if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/interface_properties.so" \
                "$interface_fixture/verify.php" "--missing-$operation" > "$log" 2>&1; then
                echo "The native interface accepted a PHP class missing $operation" >&2
                exit 1
            fi
            grep -F '::$score::'"$operation" "$log"
            if "${VPHP_PHP:-php}" -n "$interface_fixture/verify.php" "$PWD/interface_properties.php" \
                "--missing-$operation" > "$log" 2>&1; then
                echo "The stub interface accepted a PHP class missing $operation" >&2
                exit 1
            fi
            grep -F '::$score::'"$operation" "$log"
        done
    fi
)
(
    cd "$tmp/Invalid Interface Property"
    cp "$interface_fixture/invalid.v" entry.v
    "$repo/bin/vphp" build
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
        if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/invalid_interface_property.so" \
            -r 'exit(extension_loaded("invalid_interface_property") ? 0 : 1);' > "$tmp/invalid-interface-property.log" 2>&1; then
            echo 'The native interface accepted a VPHP class missing its setter' >&2
            exit 1
        fi
        grep -F 'Class VMissingPropertyWrite must implement property hook RequiresPropertyWrite::$score::set()' \
            "$tmp/invalid-interface-property.log"
    else
        "$repo/bin/vphp" stub --output "$PWD/invalid_interface_property.php"
        verify='exit(property_exists("RequiresPropertyWrite", "score") || property_exists("VMissingPropertyWrite", "score") ? 1 : 0);'
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/invalid_interface_property.so" -r "$verify"
        "${VPHP_PHP:-php}" -n -r "require \$argv[1]; $verify" invalid_interface_property.php
    fi
)

abstract_fixture="$repo/cmd/vphp/tests/fixtures/abstract-properties"
mkdir "$tmp/Abstract Properties" "$tmp/Invalid Abstract Property"
(
    cd "$tmp/Abstract Properties"
    cp "$abstract_fixture/valid.v" entry.v
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub --output "$PWD/abstract_properties.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/abstract_properties.so" "$abstract_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$abstract_fixture/verify.php" "$PWD/abstract_properties.php"
    php_version=$("${VPHP_PHP:-php}" -n -r 'echo PHP_VERSION_ID;')
    if [ "$php_version" -ge 80400 ]; then
        set -- 'missing-get' 'missing-set'
        if [ "$php_version" -ge 80500 ]; then
            set -- "$@" 'invalid-override'
        fi
        for scenario in "$@"; do
            case "$scenario" in
                missing-get) expected='AbstractRead::$score::get' ;;
                missing-set) expected='AbstractWrite::$score::set' ;;
                invalid-override) expected='PhpWrongAbstractOverride::$score::set() has #[\Override]' ;;
            esac
            log="$tmp/abstract-property-$scenario.log"
            if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/abstract_properties.so" \
                "$abstract_fixture/verify.php" "--$scenario" > "$log" 2>&1; then
                echo "The extension accepted an invalid abstract property implementation in $scenario" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
            if "${VPHP_PHP:-php}" -n "$abstract_fixture/verify.php" "$PWD/abstract_properties.php" \
                "--$scenario" > "$log" 2>&1; then
                echo "The stub accepted an invalid abstract property implementation in $scenario" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
        done
    fi
)
(
    cd "$tmp/Invalid Abstract Property"
    cp "$abstract_fixture/invalid.v" entry.v
    "$repo/bin/vphp" build
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
        if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/invalid_abstract_property.so" \
            -r 'exit(extension_loaded("invalid_abstract_property") ? 0 : 1);' > "$tmp/invalid-abstract-property.log" 2>&1; then
            echo 'The extension accepted a VPHP class missing its abstract setter' >&2
            exit 1
        fi
        grep -F 'Class VMissingAbstractWrite must implement property hook BasePropertyWrite::$score::set()' \
            "$tmp/invalid-abstract-property.log"
    else
        "$repo/bin/vphp" stub --output "$PWD/invalid_abstract_property.php"
        verify='exit(property_exists("BasePropertyWrite", "score") || property_exists("VMissingAbstractWrite", "score") ? 1 : 0);'
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/invalid_abstract_property.so" -r "$verify"
        "${VPHP_PHP:-php}" -n -r "require \$argv[1]; $verify" invalid_abstract_property.php
    fi
)

final_hook_fixture="$repo/cmd/vphp/tests/fixtures/final-property-hooks"
mkdir "$tmp/Final Property Hooks"
(
    cd "$tmp/Final Property Hooks"
    cp "$final_hook_fixture/valid.v" entry.v
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub --output "$PWD/final_property_hooks.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/final_property_hooks.so" "$final_hook_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$final_hook_fixture/verify.php" "$PWD/final_property_hooks.php"
)
for operation in get set; do
    mkdir "$tmp/Override Final Hook $operation"
    (
        cd "$tmp/Override Final Hook $operation"
        cp "$final_hook_fixture/valid.v" entry.v
        cp "$final_hook_fixture/invalid-$operation.v" override.v
        "$repo/bin/vphp" build
        if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
            case "$operation" in
                get) expected='Cannot override final property hook LockedGetter::$score::get()' ;;
                set) expected='Cannot override final property hook LockedSetter::$score::set()' ;;
            esac
            log="$tmp/override-final-hook-$operation.log"
            if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/final_property_hooks.so" \
                -r 'exit(extension_loaded("final_property_hooks") ? 0 : 1);' > "$log" 2>&1; then
                echo "VPHP accepted an override of a final $operation hook" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
            if "${VPHP_PHP:-php}" -n -d extension="$tmp/Final Property Hooks/build/final_property_hooks.so" \
                "$final_hook_fixture/verify.php" "--override-$operation" > "$log" 2>&1; then
                echo "PHP accepted an override of a final $operation hook in the extension" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
            if "${VPHP_PHP:-php}" -n "$final_hook_fixture/verify.php" \
                "$tmp/Final Property Hooks/final_property_hooks.php" "--override-$operation" > "$log" 2>&1; then
                echo "PHP accepted an override of a final $operation hook in the stub" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
        else
            "${VPHP_PHP:-php}" -n -d extension="$PWD/build/final_property_hooks.so" \
                "$final_hook_fixture/verify.php"
        fi
    )
done

reference_hook_fixture="$repo/cmd/vphp/tests/fixtures/reference-property-hooks"
mkdir "$tmp/Reference Property Hooks"
(
    cd "$tmp/Reference Property Hooks"
    cp "$reference_hook_fixture/valid.v" entry.v
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub --output "$PWD/reference_property_hooks.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_hooks.so" "$reference_hook_fixture/verify.php"
    "${VPHP_PHP:-php}" -n "$reference_hook_fixture/verify.php" "$PWD/reference_property_hooks.php"
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
        for scenario in value-override backed-pair; do
            log="$tmp/reference-hook-php-$scenario.log"
            case "$scenario" in
                value-override) expected='PhpRefValueOverride::$score::get()' ;;
                backed-pair) expected='with set hook may not return by reference' ;;
            esac
            if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_hooks.so" \
                "$reference_hook_fixture/verify.php" "--$scenario" > "$log" 2>&1; then
                echo "PHP accepted the invalid reference hook scenario $scenario" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
            if "${VPHP_PHP:-php}" -n "$reference_hook_fixture/verify.php" "$PWD/reference_property_hooks.php" \
                "--$scenario" > "$log" 2>&1; then
                echo "The stub accepted the invalid reference hook scenario $scenario" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
        done
    fi
)
for invalid in invalid invalid-backed-pair; do
    mkdir "$tmp/Reference Property Hooks $invalid"
    (
        cd "$tmp/Reference Property Hooks $invalid"
        cp "$reference_hook_fixture/valid.v" entry.v
        cp "$reference_hook_fixture/$invalid.v" invalid.v
        "$repo/bin/vphp" build
        if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
            case "$invalid" in
                invalid) expected='Property hook RefHookValueOverride::$score::get() must return by reference like RefHookBase::$score::get()' ;;
                invalid-backed-pair) expected='Get hook of backed property RefHookBackedPair::$score with set hook may not return by reference' ;;
            esac
            log="$tmp/reference-hook-$invalid.log"
            if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_hooks.so" \
                -r 'exit(extension_loaded("reference_property_hooks") ? 0 : 1);' > "$log" 2>&1; then
                echo "VPHP accepted the invalid reference hook fixture $invalid" >&2
                exit 1
            fi
            grep -F "$expected" "$log"
        else
            "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_hooks.so" "$reference_hook_fixture/verify.php"
        fi
    )
done

ref_contract_fixture="$repo/cmd/vphp/tests/fixtures/reference-property-contracts"
stage_reference_contract_fixture() {
    cp "$ref_contract_fixture/valid.v" entry.v
    cp -R "$ref_contract_fixture/dnf_defaults" .
}
mkdir "$tmp/Reference Property Contracts"
(
    cd "$tmp/Reference Property Contracts"
    stage_reference_contract_fixture
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub --output "$PWD/reference_property_contracts.php"
    "${VPHP_PHP:-php}" -n -l "$PWD/reference_property_contracts.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" "$ref_contract_fixture/verify.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" \
        "$ref_contract_fixture/verify-object-property-read.php"
    "${VPHP_PHP:-php}" -n -d opcache.enable_cli=1 -d opcache.file_update_protection=0 \
        -d extension="$PWD/build/reference_property_contracts.so" "$ref_contract_fixture/verify-object-property-read.php"
    "${VPHP_PHP:-php}" -n -d opcache.enable_cli=1 -d opcache.file_update_protection=0 \
        -d extension="$PWD/build/reference_property_contracts.so" "$ref_contract_fixture/verify-weak-map.php"
    "${VPHP_PHP:-php}" -n "$ref_contract_fixture/verify.php" "$PWD/reference_property_contracts.php"
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" \
        "$ref_contract_fixture/verify.php" --external-interface-is-class
    exit_status=0
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" \
        "$ref_contract_fixture/verify.php" --capture-unwind-exit > "$tmp/capture-unwind-exit.log" 2>&1 || exit_status=$?
    if [ "$exit_status" -ne 37 ] || [ -s "$tmp/capture-unwind-exit.log" ]; then
        cat "$tmp/capture-unwind-exit.log"
        echo "VPHP exception capture did not preserve exit(37)" >&2
        exit 1
    fi
    exit_status=0
    "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" \
        "$ref_contract_fixture/verify-fiber.php" --exit-with-parked-fiber > "$tmp/parked-fiber-exit.log" 2>&1 || exit_status=$?
    if [ "$exit_status" -ne 41 ] || [ "$(cat "$tmp/parked-fiber-exit.log")" != 'closed parked Fiber' ]; then
        cat "$tmp/parked-fiber-exit.log"
        echo "VPHP did not clean up a parked Fiber during request shutdown" >&2
        exit 1
    fi
    reject_interface_implementation() {
        mode=$1
        expected=$2
        shift 2
        if "$@" "$mode" >"$tmp/invalid-interface-implementation.log" 2>&1; then
            echo "PHP accepted an incompatible interface implementation ($mode)"
            exit 1
        fi
        grep -F "$expected" "$tmp/invalid-interface-implementation.log"
    }
    for invalid in static type; do
        case "$invalid" in
            static) expected='Cannot make static method VPHP\ReferenceProbe\EnumSelectorFactory::choose() non static' ;;
            type) expected='must be compatible with VPHP\ReferenceProbe\TypedValueContract::typedValue(' ;;
        esac
        reject_interface_implementation "--invalid-interface-$invalid" "$expected" \
            "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" "$ref_contract_fixture/verify.php"
        reject_interface_implementation "--invalid-interface-$invalid" "$expected" \
            "${VPHP_PHP:-php}" -n "$ref_contract_fixture/verify.php" "$PWD/reference_property_contracts.php"
    done
)
mkdir "$tmp/Invalid Embedded Interface"
(
    cd "$tmp/Invalid Embedded Interface"
    cp "$ref_contract_fixture/invalid-embedded-interface.v" entry.v
    if "$repo/bin/vphp" check >"$tmp/invalid-embedded-interface.log" 2>&1; then
        echo 'VPHP accepted an embedded interface without a PHP export'
        exit 1
    fi
    grep -F 'PHP interface MissingParent: embedded V interface main.VInternalParent must be exported to PHP' \
        "$tmp/invalid-embedded-interface.log"
)
for invalid in duplicate range; do
    mkdir "$tmp/Invalid Enum Backing $invalid"
    (
        cd "$tmp/Invalid Enum Backing $invalid"
        cp "$ref_contract_fixture/invalid-enum-backing-$invalid.v" entry.v
        "$repo/bin/vphp" build
        case "$invalid" in
            duplicate) expected='DuplicateEnumBacking::second duplicates an integer backing value' ;;
            range) expected='OutOfRangeEnumBacking::too_large has a backing value outside the PHP integer range' ;;
        esac
        log="$tmp/invalid-enum-backing-$invalid.log"
        if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/invalid_enum_backing.so" -r 'exit(extension_loaded("invalid_enum_backing") ? 0 : 1);' >"$log" 2>&1; then
            echo "PHP loaded an enum with invalid integer backing values" >&2
            exit 1
        fi
        grep -F "$expected" "$log"
    )
done
for invalid in mixed untyped; do
    mkdir "$tmp/Invalid Class Property $invalid"
    (
        cd "$tmp/Invalid Class Property $invalid"
        stage_reference_contract_fixture
        cp "$ref_contract_fixture/invalid-class-$invalid.v" invalid.v
        "$repo/bin/vphp" build
        case "$invalid" in
            mixed) child=UnexpectedMixed; parent=VClassUntypedBase ;;
            untyped) child=UnexpectedUntyped; parent=VClassMixedBase ;;
        esac
        require_property_type_error() {
            class=$1
            shift
            if "$@" > "$log" 2>&1; then
                echo "PHP accepted incompatible inherited property ${class}::\$slot" >&2
                exit 1
            fi
            grep -F "Type of ${class}::\$slot" "$log" | grep -F "$parent"
        }
        php_bin=${VPHP_PHP:-php}
        log="$tmp/invalid-class-property-$invalid.log"
        valid="$tmp/Reference Property Contracts"
        require_property_type_error "VClass$child" "$php_bin" -n -d extension="$PWD/build/reference_property_contracts.so" -r 'exit(extension_loaded("reference_property_contracts") ? 0 : 1);'
        require_property_type_error "PhpClass$child" "$php_bin" -n -d extension="$valid/build/reference_property_contracts.so" \
            "$ref_contract_fixture/verify.php" "--invalid-class-$invalid"
        require_property_type_error "PhpClass$child" "$php_bin" -n "$ref_contract_fixture/verify.php" \
            "$valid/reference_property_contracts.php" "--invalid-class-$invalid"
    )
done
mkdir "$tmp/Invalid Class Property typed"
(
    cd "$tmp/Invalid Class Property typed"
    stage_reference_contract_fixture
    cp "$ref_contract_fixture/invalid-class-typed.v" invalid.v
    log="$tmp/invalid-class-property-typed.log"
    if "$repo/bin/vphp" check > "$log" 2>&1; then
        echo "VPHP accepted incompatible inherited property VClassUnexpectedTyped::\$choice" >&2
        exit 1
    fi
    grep -F 'PHP property VClassUnexpectedTyped::$choice: type must match VClassTypedBase::$choice' "$log"
    php_bin=${VPHP_PHP:-php}
    valid="$tmp/Reference Property Contracts"
    if "$php_bin" -n -d extension="$valid/build/reference_property_contracts.so" \
        "$ref_contract_fixture/verify.php" --invalid-class-typed > "$log" 2>&1; then
        echo "PHP accepted incompatible inherited property PhpClassUnexpectedTyped::\$choice" >&2
        exit 1
    fi
    grep -F 'Type of PhpClassUnexpectedTyped::$choice' "$log" | grep -F 'VClassTypedBase'
    if "$php_bin" -n "$ref_contract_fixture/verify.php" "$valid/reference_property_contracts.php" \
        --invalid-class-typed > "$log" 2>&1; then
        echo "The stub accepted incompatible inherited property PhpClassUnexpectedTyped::\$choice" >&2
        exit 1
    fi
    grep -F 'Type of PhpClassUnexpectedTyped::$choice' "$log" | grep -F 'VClassTypedBase'
)
for conflict in static type signature constant mixed; do
    mkdir "$tmp/Conflicting Native Trait $conflict"
    (
        cd "$tmp/Conflicting Native Trait $conflict"
        stage_reference_contract_fixture
        cp "$ref_contract_fixture/invalid-native-trait-$conflict.v" invalid.v
        log="$tmp/conflicting-native-trait-$conflict.log"
        if "$repo/bin/vphp" check > "$log" 2>&1; then
            echo "VPHP accepted a conflicting $conflict declaration in a composed trait" >&2
            exit 1
        fi
        case "$conflict" in
            static) expected='VConflictingStaticComposition: incompatible property VConflictingNativeStaticStorageTrait::trait_rate' ;;
            type) expected='VConflictingTypeComposition: incompatible property VConflictingNativeStaticTypeTrait::trait_choice' ;;
            signature) expected='VConflictingSignatureRequirements: incompatible abstract requirement for VReferenceSignatureRequirement::selectValue' ;;
            constant) expected='VConflictingConstantComposition: incompatible constant VConflictingConstantTrait::LIMIT' ;;
            mixed) expected='VConflictingMixedComposition: incompatible property VUntypedPropertyTrait::slot' ;;
        esac
        grep -F "PHP trait $expected" "$log"
    )
done
for invalid in interface abstract; do
    mkdir "$tmp/Reference Property Contract $invalid"
    (
        cd "$tmp/Reference Property Contract $invalid"
        stage_reference_contract_fixture
        cp "$ref_contract_fixture/invalid-$invalid.v" invalid.v
        "$repo/bin/vphp" build
        if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
            case "$invalid" in
                interface) owner='RefPropertyContract'; implementation='ValueInterfaceImplementation' ;;
                abstract) owner='AbstractRefProperty'; implementation='ValueAbstractImplementation' ;;
            esac
            log="$tmp/reference-contract-$invalid.log"
            if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" \
                -r 'exit(extension_loaded("reference_property_contracts") ? 0 : 1);' > "$log" 2>&1; then
                echo "VPHP accepted a by-value getter for a reference $invalid contract" >&2
                exit 1
            fi
            grep -F "V${implementation}::\$score::get()" "$log"
            grep -F "${owner}::\$score::get()" "$log"
            if "${VPHP_PHP:-php}" -n -d extension="$tmp/Reference Property Contracts/build/reference_property_contracts.so" \
                "$ref_contract_fixture/verify.php" "--invalid-$invalid" > "$log" 2>&1; then
                echo "PHP accepted a by-value getter for a reference $invalid contract" >&2
                exit 1
            fi
            grep -F "Php${implementation}::\$score::get()" "$log"
            grep -F "${owner}::\$score::get()" "$log"
            if "${VPHP_PHP:-php}" -n "$ref_contract_fixture/verify.php" \
                "$tmp/Reference Property Contracts/reference_property_contracts.php" "--invalid-$invalid" > "$log" 2>&1; then
                echo "The stub accepted a by-value getter for a reference $invalid contract" >&2
                exit 1
            fi
            grep -F "Php${implementation}::\$score::get()" "$log"
            grep -F "${owner}::\$score::get()" "$log"
        else
            "${VPHP_PHP:-php}" -n -d extension="$PWD/build/reference_property_contracts.so" "$ref_contract_fixture/verify.php"
        fi
    )
done

for access in readonly protected; do
    for contract in interface abstract; do
        probe="$tmp/Restricted Reference Property $access $contract"
        mkdir "$probe"
        (
            cd "$probe"
            stage_reference_contract_fixture
            sh "$ref_contract_fixture/restricted-source.sh" "$access" "$contract" > invalid.v
            "$repo/bin/vphp" build
            extension="$PWD/build/reference_property_contracts.so"
            php_bin="${VPHP_PHP:-php}"
            if "$php_bin" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
                log="$probe/contract.log"
                if "$php_bin" -n -d extension="$extension" -r 'exit(extension_loaded("reference_property_contracts") ? 0 : 1);' > "$log" 2>&1; then
                    echo "VPHP accepted a restricted property for a writable $contract contract" >&2
                    exit 1
                fi
                grep -F 'Set access level of VRestrictedRef::$score must be omitted' "$log"
                valid="$tmp/Reference Property Contracts"
                if "$php_bin" -n -d extension="$valid/build/reference_property_contracts.so" \
                    "$ref_contract_fixture/verify.php" "--restricted-$access-$contract" > "$log" 2>&1; then
                    echo "PHP accepted a restricted property for a writable $contract contract" >&2
                    exit 1
                fi
                grep -F 'Set access level of PhpRestrictedRef::$score must be omitted' "$log"
                if "$php_bin" -n "$ref_contract_fixture/verify.php" "$valid/reference_property_contracts.php" \
                    "--restricted-$access-$contract" > "$log" 2>&1; then
                    echo "The stub accepted a restricted property for a writable $contract contract" >&2
                    exit 1
                fi
                grep -F 'Set access level of PhpRestrictedRef::$score must be omitted' "$log"
            else
                "$php_bin" -n -d extension="$extension" "$ref_contract_fixture/verify.php"
            fi
        )
    done
done

for contract in Interface Abstract; do
    probe="$tmp/Private Reference Property $contract"
    mkdir "$probe"
    (
        cd "$probe"
        stage_reference_contract_fixture
        cat > invalid.v <<EOF
module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VPrivateRef${contract}')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '1')]
pub struct VPrivateRefRedeclaration {}
EOF
        "$repo/bin/vphp" build
        extension="$PWD/build/reference_property_contracts.so"
        php_bin="${VPHP_PHP:-php}"
        if "$php_bin" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
            log="$probe/redeclaration.log"
            if "$php_bin" -n -d extension="$extension" -r 'exit(extension_loaded("reference_property_contracts") ? 0 : 1);' > "$log" 2>&1; then
                echo "VPHP accepted redeclaration of the private(set) property" >&2
                exit 1
            fi
            grep -F "Cannot override final property VPrivateRef${contract}::\$score" "$log"
            valid="$tmp/Reference Property Contracts"
            for parent in "VPrivateRef${contract}" "PhpPrivateRef${contract}"; do
                if "$php_bin" -n -d extension="$valid/build/reference_property_contracts.so" \
                    "$ref_contract_fixture/verify.php" "--redeclaration-$parent" > "$log" 2>&1; then
                    echo "PHP accepted redeclaration of $parent's private(set) property" >&2
                    exit 1
                fi
                grep -F "Cannot override final property $parent::\$score" "$log"
                if "$php_bin" -n "$ref_contract_fixture/verify.php" "$valid/reference_property_contracts.php" \
                    "--redeclaration-$parent" > "$log" 2>&1; then
                    echo "The stub accepted redeclaration of $parent's private(set) property" >&2
                    exit 1
                fi
                grep -F "Cannot override final property $parent::\$score" "$log"
            done
        else
            "$php_bin" -n -d extension="$extension" "$ref_contract_fixture/verify.php"
        fi
    )
done

for contract in interface abstract; do
    probe="$tmp/Value Method Reference $contract"
    mkdir "$probe"
    (
        cd "$probe"
        stage_reference_contract_fixture
        sh "$ref_contract_fixture/value-method-source.sh" "$contract" > invalid.v
        "$repo/bin/vphp" build
        extension="$PWD/build/reference_property_contracts.so"
        php_bin="${VPHP_PHP:-php}"
        log="$probe/call.log"
        if "$php_bin" -n -d extension="$extension" -r 'exit(extension_loaded("reference_property_contracts") ? 0 : 1);' > "$log" 2>&1; then
            echo "VPHP accepted a by-value method for a by-reference $contract contract" >&2
            exit 1
        fi
        case "$contract" in
            interface) owner=RefMethodContract ;;
            abstract) owner=RefMethodBase ;;
        esac
        grep -F "ValueRefMethodImplementation::slot() must return by reference like $owner::slot()" "$log"
        valid="$tmp/Reference Property Contracts"
        if "$php_bin" -n -d extension="$valid/build/reference_property_contracts.so" \
            "$ref_contract_fixture/verify.php" "--value-method-$contract" > "$log" 2>&1; then
            echo "PHP accepted a by-value method for a by-reference $contract contract" >&2
            exit 1
        fi
        grep -F 'PhpValueRefMethod::slot' "$log"
        grep -E "&[[:space:]]*${owner}::slot" "$log"
        if "$php_bin" -n "$ref_contract_fixture/verify.php" "$valid/reference_property_contracts.php" \
            "--value-method-$contract" > "$log" 2>&1; then
            echo "The stub accepted a by-value method for a by-reference $contract contract" >&2
            exit 1
        fi
        grep -F 'PhpValueRefMethod::slot' "$log"
        grep -E "&[[:space:]]*${owner}::slot" "$log"
    )
done

mkdir "$tmp/Unmatched Override"
(
    cd "$tmp/Unmatched Override"
    cat > entry.v <<'EOF'
module main

import vphp

const ext_config = vphp.ExtensionConfig{name: 'unmatched_override'}

@[vphp.PhpExportClass(name: '')]
pub struct OverridePrivateParent {}

@[vphp.PhpExportMethod(name: 'hidden')]
@[vphp.PhpMethodVisibility(.private)]
pub fn OverridePrivateParent.hidden() int {
	return 1
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('OverridePrivateParent')]
pub struct OverrideUnmatched {}

@[vphp.PhpExportMethod(name: 'hidden')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn OverrideUnmatched.hidden() int {
	return 2
}
EOF
    "$repo/bin/vphp" build
    if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80300 ? 0 : 1);'; then
        if "${VPHP_PHP:-php}" -n -d extension="$PWD/build/unmatched_override.so" \
            -r 'exit(extension_loaded("unmatched_override") ? 0 : 1);' > "$tmp/unmatched-override.log" 2>&1; then
            echo 'Override accepted a method with only a private parent match' >&2
            exit 1
        fi
        grep -F 'OverrideUnmatched::hidden() has #[\Override] attribute, but no matching parent method exists' \
            "$tmp/unmatched-override.log"
    else
        "$repo/bin/vphp" stub --output "$PWD/unmatched_override.php"
        verify='exit((new ReflectionMethod("OverrideUnmatched", "hidden"))->getAttributes("Override") === [] ? 0 : 1);'
        "${VPHP_PHP:-php}" -n -d extension="$PWD/build/unmatched_override.so" -r "$verify"
        "${VPHP_PHP:-php}" -n -r "require \$argv[1]; $verify" unmatched_override.php
    fi
)
cp "$project/entry.v" "$tmp/original-rule-name.v"
sed -e 's/^const combined_trait_rules =/const renamed_composition =/' \
    -e 's/^const restricted_constant_table =/const renamed_class_table =/' \
    -e 's/^const contract_constant_table =/const renamed_interface_table =/' \
    -e 's/^const enum_constant_table =/const renamed_enum_table =/' \
    -e 's/^const standalone_static_table =/const renamed_static_table =/' \
    "$tmp/original-rule-name.v" > "$project/entry.v"
"$repo/bin/vphp" stub --output "$tmp/Renamed Rules Stub.php"
cmp "$tmp/Standalone Stub.php" "$tmp/Renamed Rules Stub.php"
cp "$tmp/original-rule-name.v" "$project/entry.v"
cat > "$tmp/override-final-trait-method.php" <<'EOF'
<?php
if ($argv[1] !== '') {
    require $argv[1];
}
class SmokeFinalTraitConsumer {
    use VPHP\Smoke\CombinedCaseTrait;

    private function formatValue(int $value): string { return "value=$value"; }
}
$name = $argv[2];
eval(match ($name) {
    'traitDouble', 'twice' => "class SmokeFinalTraitChild extends SmokeFinalTraitConsumer {
        public static function $name(int \$value): int { return \$value + 1; }
    }",
    'rivalLabel' => 'class SmokeFinalTraitChild extends SmokeFinalTraitConsumer {
        public function rivalLabel(int $number = 5): string { return "child:$number"; }
    }',
});
EOF
php_version_id=$("${VPHP_PHP:-php}" -n -r 'echo PHP_VERSION_ID;')
if [ "$php_version_id" -ge 80300 ]; then
    grep -F '\VPHP\Smoke\CaseTrait::traitDouble as final;' "$tmp/Standalone Stub.php"
    grep -F '\VPHP\Smoke\CaseTrait::traitDouble as final twice;' "$tmp/Standalone Stub.php"
else
    grep -F '\VPHP\Smoke\CaseTrait::traitDouble as twice;' "$tmp/Standalone Stub.php"
    if grep -F '::traitDouble as final' "$tmp/Standalone Stub.php"; then
        echo 'PHP 8.2 stub contains an as final rule' >&2
        exit 1
    fi
fi
for method in traitDouble twice rivalLabel; do
    for kind in extension stub; do
        if [ "$kind" = extension ]; then
            set -- -d "extension=$project/build/standalone_probe.so" "$tmp/override-final-trait-method.php" ''
        else
            set -- "$tmp/override-final-trait-method.php" "$tmp/Standalone Stub.php"
        fi
        log="$tmp/trait-final-$kind.log"
        if [ "$php_version_id" -ge 80300 ]; then
            if "${VPHP_PHP:-php}" -n "$@" "$method" > "$log" 2>&1; then
                echo "PHP accepted a subclass override of $method from the $kind" >&2
                exit 1
            fi
            grep -F "Cannot override final method SmokeFinalTraitConsumer::$method()" "$log"
        else
            "${VPHP_PHP:-php}" -n "$@" "$method"
        fi
    done
done
cat > "$tmp/invalid-trait-requirement.php" <<'EOF'
<?php
if (isset($argv[1])) {
    require $argv[1];
}
class InvalidTraitRequirement {
    use VPHP\Smoke\PrivateRequirement;
}
EOF
if "${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" "$tmp/invalid-trait-requirement.php" > "$tmp/trait-requirement-extension.log" 2>&1; then
    echo 'extension accepted a class with an unimplemented private trait requirement' >&2
    exit 1
fi
if "${VPHP_PHP:-php}" -n "$tmp/invalid-trait-requirement.php" "$tmp/Standalone Stub.php" > "$tmp/trait-requirement-stub.log" 2>&1; then
    echo 'stub accepted a class with an unimplemented private trait requirement' >&2
    exit 1
fi
for log in "$tmp/trait-requirement-extension.log" "$tmp/trait-requirement-stub.log"; do
    grep -Fi 'InvalidTraitRequirement::formatValue' "$log"
done
cat > "$tmp/override-final-method.php" <<'EOF'
<?php
if (isset($argv[1])) {
    require $argv[1];
}
class SmokeIllegalMethodOverride extends VPHP\Smoke\FinalMethods {
    public function fixedvalue(int $value): int { return $value; }
}
EOF
if "${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" "$tmp/override-final-method.php" > "$tmp/final-method-extension.log" 2>&1; then
    echo 'PHP accepted an override of an extension final method' >&2
    exit 1
fi
if "${VPHP_PHP:-php}" -n "$tmp/override-final-method.php" "$tmp/Standalone Stub.php" > "$tmp/final-method-stub.log" 2>&1; then
    echo 'PHP accepted an override of a stub final method' >&2
    exit 1
fi
grep -F 'Cannot override final method' "$tmp/final-method-extension.log"
grep -F 'Cannot override final method' "$tmp/final-method-stub.log"
cat > "$tmp/override-final-constant.php" <<'EOF'
<?php
if (isset($argv[1])) {
    require $argv[1];
}
class SmokeIllegalConstantOverride extends VPHP\Smoke\RestrictedConstants {
    public const LOCKED = 10;
}
EOF
if "${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" "$tmp/override-final-constant.php" > "$tmp/final-constant-extension.log" 2>&1; then
    echo 'PHP accepted an override of an extension final constant' >&2
    exit 1
fi
if "${VPHP_PHP:-php}" -n "$tmp/override-final-constant.php" "$tmp/Standalone Stub.php" > "$tmp/final-constant-stub.log" 2>&1; then
    echo 'PHP accepted an override of a stub final constant' >&2
    exit 1
fi
grep -F 'cannot override final constant' "$tmp/final-constant-extension.log"
grep -F 'cannot override final constant' "$tmp/final-constant-stub.log"
cat > "$tmp/override-interface-constant.php" <<'EOF'
<?php
if (isset($argv[1])) {
    require $argv[1];
}
interface SmokeIllegalContractOverride extends VPHP\Smoke\VersionedContract {
    public const LIMIT = 10;
}
EOF
if "${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" "$tmp/override-interface-constant.php" > "$tmp/interface-constant-extension.log" 2>&1; then
    echo 'PHP accepted an override of an extension final interface constant' >&2
    exit 1
fi
if "${VPHP_PHP:-php}" -n "$tmp/override-interface-constant.php" "$tmp/Standalone Stub.php" > "$tmp/interface-constant-stub.log" 2>&1; then
    echo 'PHP accepted an override of a stub final interface constant' >&2
    exit 1
fi
grep -F 'cannot override final constant' "$tmp/interface-constant-extension.log"
grep -F 'cannot override final constant' "$tmp/interface-constant-stub.log"
if "${VPHP_PHP:-php}" -n -r 'exit(PHP_VERSION_ID >= 80400 ? 0 : 1);'; then
    cat > "$tmp/redeclare-final.php" <<'EOF'
<?php
if (isset($argv[1])) {
    require $argv[1];
}
class SmokeIllegalRedeclaration extends VPHP\Smoke\FinalProperty {
    public int $limit = 10;
}
EOF
    if "${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" "$tmp/redeclare-final.php" > "$tmp/final-extension.log" 2>&1; then
        echo 'PHP accepted redeclaration of an extension final property' >&2
        exit 1
    fi
    if "${VPHP_PHP:-php}" -n "$tmp/redeclare-final.php" "$tmp/Standalone Stub.php" > "$tmp/final-stub.log" 2>&1; then
        echo 'PHP accepted redeclaration of a stub final property' >&2
        exit 1
    fi
    grep -F 'Cannot override final property' "$tmp/final-extension.log"
    grep -F 'Cannot override final property' "$tmp/final-stub.log"
fi
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
grep -F 'public string $captionText = ' "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'public static int $sharedCount = 0;' "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'public int $phpCount = 0;' "$tmp/Standalone Stub.php"
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
grep -F 'unknown field `unknown` in attribute `vphp.PhpExportFunction`' "$tmp/attribute.log"

sed 's/PhpExportFunction(name:/PhpExportClass(name:/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/target.log" 2>&1; then
    echo 'check accepted a class export attribute on a function' >&2
    exit 1
fi
grep -F 'cannot be applied to `fn`' "$tmp/target.log" | grep -F 'PhpExportClass'

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'EOF'

@[vphp.PhpExportFunction(name: 'vphp\\smoke_first\\HELLO')]
fn duplicate_hello() {}
EOF
if "$repo/bin/vphp" check > "$tmp/duplicate-function.log" 2>&1; then
    echo 'check accepted duplicate PHP function names differing only by case' >&2
    exit 1
fi
grep -F 'duplicate exported PHP function name' "$tmp/duplicate-function.log"

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'EOF'

@[vphp.PhpExportConstant(name: 'vphp\\smoke_first\\VALUE')]
const duplicate_value = 1
EOF
if "$repo/bin/vphp" check > "$tmp/duplicate-constant.log" 2>&1; then
    echo 'check accepted duplicate PHP constant names with differently cased namespaces' >&2
    exit 1
fi
grep -F 'duplicate exported PHP constant name' "$tmp/duplicate-constant.log"

sed "s/php_type: 'int', default_value: '-12'/php_type: 'int', default_value: 'true'/" \
    "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/property-default.log" 2>&1; then
    echo 'check accepted a boolean default for an int property' >&2
    exit 1
fi
grep -F 'default: bool does not match type int' "$tmp/property-default.log"

sed "s/name: 'text', php_type: '?string'/name: 'text', php_type: '?callable'/" \
    "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/nullable-property.log" 2>&1; then
    echo 'check accepted an invalid nullable property type' >&2
    exit 1
fi
grep -F 'unsupported nullable type ?callable' "$tmp/nullable-property.log"

sed "s/php_type: 'INT|string'/php_type: 'int|callable'/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/union-property.log" 2>&1; then
    echo 'check accepted callable in a property union' >&2
    exit 1
fi
grep -F 'unsupported or invalid compound type int|callable' "$tmp/union-property.log"

sed "s/Countable&IteratorAggregate/Countable\&INT/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/intersection-property.log" 2>&1; then
    echo 'check accepted a scalar inside a property intersection' >&2
    exit 1
fi
grep -F 'unsupported or invalid compound type Countable&INT' "$tmp/intersection-property.log"

sed "s/set_visibility: .protected/set_visibility: .public/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/set-visibility.log" 2>&1; then
    echo 'check accepted an invalid asymmetric setter visibility' >&2
    exit 1
fi
grep -F 'expects an enum value: .protected, .private' "$tmp/set-visibility.log"

sed "s/set_visibility: .protected/set_visibility: 'protected'/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/string-visibility.log" 2>&1; then
    echo 'check accepted a string for enum setter visibility' >&2
    exit 1
fi
grep -F 'expects an enum value: .protected, .private' "$tmp/string-visibility.log"

sed "s/php_type: 'int'/v_type: 'int'/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/legacy-property-type.log" 2>&1; then
    echo 'check accepted the old v_type field' >&2
    exit 1
fi
grep -F 'unknown field `v_type` in attribute' "$tmp/legacy-property-type.log"

sed "s/\.private, 'null')/.private, '7')/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/asymmetric-default.log" 2>&1; then
    echo 'check accepted an int default for a nullable string property' >&2
    exit 1
fi
grep -F 'default: int does not match type ?string' "$tmp/asymmetric-default.log"

sed "s/PhpFinalDeclaredProperty('limit')/PhpFinalDeclaredProperty('missing')/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/final-missing.log" 2>&1; then
    echo 'check accepted a final modifier for an undeclared property' >&2
    exit 1
fi
grep -F 'final modifier targets unknown PHP-only property `missing`' "$tmp/final-missing.log"

sed '/^pub fn (target StandaloneFinalMethods) fixed_value/i\
@[vphp.PhpAbstractMethod]
' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/final-abstract.log" 2>&1; then
    echo 'check accepted an abstract final method' >&2
    exit 1
fi
grep -F 'an abstract method cannot be final' "$tmp/final-abstract.log"

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'EOF'

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\InvalidFinalOverride')]
@[vphp.PhpExtends(name: 'StandaloneFinalMethods')]
pub struct StandaloneInvalidFinalOverride {}

@[vphp.PhpExportMethod(name: 'fixedvalue')]
pub fn (target StandaloneInvalidFinalOverride) override_value(value int) int {
	return value
}
EOF
if "$repo/bin/vphp" check > "$tmp/final-method-override.log" 2>&1; then
    echo 'check accepted an override of a final method in the extension' >&2
    exit 1
fi
grep -F 'cannot override final method' "$tmp/final-method-override.log"

sed 's/PhpClassConstantVisibility(visibility: .protected)/PhpClassConstantVisibility(visibility: .private)/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/private-final-constant.log" 2>&1; then
    echo 'check accepted a private final constant' >&2
    exit 1
fi
grep -F 'a private constant cannot be final' "$tmp/private-final-constant.log"

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'EOF'

struct InvalidConstantOverrideValues {
	locked int
}

const invalid_constant_override_values = InvalidConstantOverrideValues{locked: 3}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\InvalidConstantOverride')]
@[vphp.PhpExtends(name: 'StandaloneConstantModifiers')]
@[vphp.PhpClassConstants('invalid_constant_override_values')]
pub struct StandaloneInvalidConstantOverride {}
EOF
if "$repo/bin/vphp" check > "$tmp/final-constant-override.log" 2>&1; then
    echo 'check accepted an override of a final constant in the extension' >&2
    exit 1
fi
grep -F 'cannot override final constant' "$tmp/final-constant-override.log"

sed '/^pub fn (target StandaloneMethodVisibility) private_instance/i\
@[vphp.PhpAbstractMethod]
' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/private-abstract-method.log" 2>&1; then
    echo 'check accepted a private abstract method' >&2
    exit 1
fi
grep -F 'an abstract method cannot be private' "$tmp/private-abstract-method.log"

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'EOF'

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\InvalidVisibilityOverride')]
@[vphp.PhpExtends(name: 'StandaloneMethodVisibility')]
pub struct StandaloneInvalidVisibilityOverride {}

@[vphp.PhpExportMethod(name: 'promoted')]
@[vphp.PhpMethodVisibility(.private)]
pub fn (target StandaloneInvalidVisibilityOverride) override_promoted() int {
	return 0
}
EOF
if "$repo/bin/vphp" check > "$tmp/method-visibility-override.log" 2>&1; then
    echo 'check accepted a narrower override of a public method in the extension' >&2
    exit 1
fi
grep -F 'access must be public or wider' "$tmp/method-visibility-override.log"

sed "s/PhpDeclaredPropertyVisibility('note', .private)/PhpDeclaredPropertyVisibility('note', .missing)/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/invalid-read-visibility.log" 2>&1; then
    echo 'check accepted an invalid read visibility' >&2
    exit 1
fi
grep -F 'expects an enum value: .public, .protected, .private' "$tmp/invalid-read-visibility.log"

sed "s/PhpDeclaredPropertyWithSetVisibility('note', '?string', .private)/PhpDeclaredPropertyWithSetVisibility('note', '?string', .protected)/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/wider-set-visibility.log" 2>&1; then
    echo 'check accepted write visibility wider than read visibility' >&2
    exit 1
fi
grep -F 'set visibility cannot be wider than read visibility' "$tmp/wider-set-visibility.log"

sed '/slot: "contract"/s/; vphp.PhpFinalClassConstant/; vphp.PhpClassConstantVisibility(.protected); vphp.PhpFinalClassConstant/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/interface-constant-visibility.log" 2>&1; then
    echo 'check accepted a non-public interface constant' >&2
    exit 1
fi
grep -F 'visibility must be public' "$tmp/interface-constant-visibility.log"

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'EOF'

struct InvalidInterfaceOverrideValues {
	limit int
}

const invalid_interface_override_values = InvalidInterfaceOverrideValues{limit: 3}

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\InvalidInterfaceOverride')]
@[vphp.PhpExtends('StandaloneConstantImplementationChild')]
@[vphp.PhpClassConstants('invalid_interface_override_values')]
pub struct StandaloneInvalidInterfaceOverride {}
EOF
if "$repo/bin/vphp" check > "$tmp/interface-constant-override.log" 2>&1; then
    echo 'check accepted an override of a final interface constant in the extension' >&2
    exit 1
fi
grep -F 'cannot override final interface constant' "$tmp/interface-constant-override.log"

sed '/^struct StandaloneEnumValues {/,/^}/s/PhpClassConstantVisibility(.private)]/PhpClassConstantVisibility(.private); vphp.PhpFinalClassConstant]/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/private-final-enum-constant.log" 2>&1; then
    echo 'check accepted a private final enum constant' >&2
    exit 1
fi
grep -F 'EnumConstants::SECRET: a private constant cannot be final' "$tmp/private-final-enum-constant.log"

sed 's/values: standalone_enum_values/values: missing_enum_values/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/missing-enum-constant-source.log" 2>&1; then
    echo 'check accepted an undeclared enum constant source' >&2
    exit 1
fi
grep -F 'constant source `missing_enum_values` must be a V constant struct' "$tmp/missing-enum-constant-source.log"

sed 's/preferred: StandaloneEnumConstants.active/preferred: StandaloneEnumConstants.missing/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/missing-enum-alias-case.log" 2>&1; then
    echo 'check accepted an enum alias to an unknown case' >&2
    exit 1
fi
grep -F 'unknown case `missing`' "$tmp/missing-enum-alias-case.log"

sed 's/default_mode: StandaloneEnumConstants.active/default_mode: StandaloneEnumConstants.missing/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/missing-class-alias-case.log" 2>&1; then
    echo 'check accepted a class constant reference to an unknown case' >&2
    exit 1
fi
grep -F '::DEFAULT_MODE: unknown case `missing`' "$tmp/missing-class-alias-case.log"

sed 's/contract_mode: .ready/contract_mode: .missing/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/missing-interface-alias-case.log" 2>&1; then
    echo 'check accepted an interface constant reference to an unknown case' >&2
    exit 1
fi
grep -F '::CONTRACT_MODE: unknown case `missing`' "$tmp/missing-interface-alias-case.log"

sed 's/trait_mode: StandaloneEnumAliasTarget.ready/trait_mode: StandaloneEnumAliasTarget.missing/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/missing-trait-alias-case.log" 2>&1; then
    echo 'check accepted a trait constant reference to an unknown case' >&2
    exit 1
fi
grep -F 'CaseTrait::TRAIT_MODE: unknown case `missing`' "$tmp/missing-trait-alias-case.log"

sed 's/init_trait(ctx vphp.Context, level int, offset int) {/init_trait(ctx vphp.Context, level int, offset int) int {/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/trait-constructor-return.log" 2>&1; then
    echo 'check accepted a native trait constructor returning a value' >&2
    exit 1
fi
grep -F 'CaseTrait::__construct: a constructor cannot return a value' "$tmp/trait-constructor-return.log"

sed '/^struct StandaloneCaseTrait {}/i\
@[vphp.PhpUsesTraits(source: "cyclic_trait_sources")]
' "$tmp/valid.v" > "$project/entry.v"
printf '\nconst cyclic_trait_sources = [StandaloneCombinedCaseTrait{}]\n' >> "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/trait-cycle.log" 2>&1; then
    echo 'check accepted cyclic native trait composition' >&2
    exit 1
fi
grep -F 'cyclic PHP type registration dependency' "$tmp/trait-cycle.log"

sed 's/CaseTrait::TRAITLABEL as init/CaseTrait::missingMethod as init/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/trait-unknown-alias.log" 2>&1; then
    echo 'check accepted a native trait alias for an unknown method' >&2
    exit 1
fi
grep -F 'CaseTrait::missingMethod` in alias' "$tmp/trait-unknown-alias.log"

sed '/precedences: combined_trait_precedences/d' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/trait-conflict.log" 2>&1; then
    echo 'check accepted a conflicting trait method without a precedence rule' >&2
    exit 1
fi
grep -F 'conflicting method' "$tmp/trait-conflict.log"

sed 's/instead_of: \[StandaloneRivalCaseTrait{}, StandaloneAlternateCaseTrait{}\]/instead_of: [StandaloneCombinedCaseTrait{}]/' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/trait-indirect-exclusion.log" 2>&1; then
    echo 'check accepted an excluded trait outside the direct composition' >&2
    exit 1
fi
grep -F 'excluded trait `main.StandaloneCombinedCaseTrait` must be directly used' "$tmp/trait-indirect-exclusion.log"

cp "$tmp/valid.v" "$project/entry.v"
printf '\nconst duplicate_composition = vphp.PhpTraitRules[StandaloneCombinedCaseTrait]{}\n' >> "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/trait-duplicate-rules.log" 2>&1; then
    echo 'check accepted duplicate generic rule tables for one native trait' >&2
    exit 1
fi
grep -F 'duplicate PhpTraitRules for main.StandaloneCombinedCaseTrait' "$tmp/trait-duplicate-rules.log"

sed '/^struct StandaloneCombinedCaseTrait {}/i\
@[vphp.PhpUsesTraits(source: "combined_trait_sources")]
' "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/trait-overlapping-rules.log" 2>&1; then
    echo 'check accepted two declarations for the same trait rule field' >&2
    exit 1
fi
grep -F 'PhpTraitRules combined_trait_rules.uses and PhpUsesTraits both declare uses' "$tmp/trait-overlapping-rules.log"

sed "s/default_value: '\[\[\]\]'/default_value: '[[PHP_VERSION]]'/" "$tmp/valid.v" > "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/array-default.log" 2>&1; then
    echo 'check accepted an unquoted constant inside a property array default' >&2
    exit 1
fi
grep -F 'array literal, got `PHP_VERSION`' "$tmp/array-default.log"

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'EOF'

@[vphp.PhpExportFunction(name: 'nodiscard_void')]
@[vphp.PhpCallableAttribute(name: 'NoDiscard', args: '')]
fn nodiscard_void() {}
EOF
if "$repo/bin/vphp" check > "$tmp/nodiscard-void.log" 2>&1; then
    echo 'check accepted NoDiscard on a void function' >&2
    exit 1
fi
grep -F 'PHP attribute NoDiscard on nodiscard_void: requires a callable that returns a value' "$tmp/nodiscard-void.log"

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

assert_readonly_diagnostic() {
    if "$repo/bin/vphp" check > "$tmp/readonly-class.log" 2>&1; then
        echo "check accepted an invalid readonly class: $1" >&2
        exit 1
    fi
    grep -F "$1" "$tmp/readonly-class.log"
}

sed "/^pub struct StandaloneReadonlyRecord {}/i\\
@[vphp.PhpDeclaredPropertyWithDefault('invalid', 'int', '1')]
" "$tmp/valid.v" > "$project/entry.v"
assert_readonly_diagnostic 'default values are not allowed'

sed '/^pub struct StandaloneReadonlyValue {$/,+2 s/^pub:$/pub mut:/' \
    "$tmp/valid.v" > "$project/entry.v"
assert_readonly_diagnostic 'exported V fields must be immutable'

sed '/^pub struct StandaloneReadonlyValue {$/,+2 s/^	value int = 7$/	@[vphp.PhpStaticProperty]\
	value int = 7/' "$tmp/valid.v" > "$project/entry.v"
assert_readonly_diagnostic 'static properties are not allowed'

sed "/^pub struct StandaloneReadonlyRecord {}/i\\
@[vphp.PhpClassAttribute('AllowDynamicProperties', '')]
" "$tmp/valid.v" > "$project/entry.v"
assert_readonly_diagnostic 'AllowDynamicProperties is not allowed'

cp "$tmp/valid.v" "$project/entry.v"
cat >> "$project/entry.v" <<'V'

@[vphp.PhpExportClass(name: 'VPHP\\Smoke\\InvalidReadonlyChild')]
@[vphp.PhpExtends('StandaloneReadonlyRecord')]
pub struct StandaloneInvalidReadonlyChild {}
V
assert_readonly_diagnostic 'readonly modifier must match parent'

sed "/^pub struct StandaloneDynamicRecord {}/i\\
@[vphp.PhpClassAttribute('allowdynamicproperties', '')]
" "$tmp/valid.v" > "$project/entry.v"
assert_readonly_diagnostic 'AllowDynamicProperties must not be repeated'

task_scheduler_fixture="$repo/cmd/vphp/tests/fixtures/task-scheduler"
mkdir "$tmp/Task Scheduler"
(
    cd "$tmp/Task Scheduler"
    cp "$task_scheduler_fixture/entry.v" .
    mkdir taskx
    cp "$repo/vslim/src/taskx/task.v" "$repo/vslim/src/taskx/channel.v" taskx/
    "$repo/bin/vphp" check
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    "${VPHP_PHP:-php}" -n -l build/task_scheduler_probe.php
    set -- "${VPHP_PHP:-php}" -n -d "extension=$PWD/build/task_scheduler_probe.so" \
        "$task_scheduler_fixture/verify.php" build/task_scheduler_probe.php
    if command -v timeout >/dev/null 2>&1; then
        # A stale wait can keep polling after the Fiber has already finished.
        timeout -k 2s 30s "$@"
    else
        "$@"
    fi
    exit_status=0
    "${VPHP_PHP:-php}" -n -d "extension=$PWD/build/task_scheduler_probe.so" \
        "$task_scheduler_fixture/verify.php" --cleanup-exit >cleanup-exit.log 2>&1 || exit_status=$?
    if [ "$exit_status" -ne 43 ] || [ -s cleanup-exit.log ]; then
        cat cleanup-exit.log
        echo 'VPHP cleanup did not preserve exit(43)' >&2
        exit 1
    fi
)

userland_fixture="$repo/cmd/vphp/tests/fixtures/userland-subclass"
mkdir "$tmp/Userland Subclass"
(
    cd "$tmp/Userland Subclass"
    cp -R "$userland_fixture"/. .
    "$repo/bin/vphp" check
    "$repo/bin/vphp" build
    "$repo/bin/vphp" stub
    php_bin="${VPHP_PHP:-php}"
    declarations=build/userland_subclass_probe.so.classes.php
    "$php_bin" -n -l "$declarations"
    "$php_bin" -n -l build/userland_subclass_probe.php
    grep -F 'class Counter extends \VphpFixture\Author\Counter' build/userland_subclass_probe.php
    set -- 'VphpFixture\Extension\Counter' "$declarations"
    if command -v composer >/dev/null 2>&1; then
        composer dump-autoload --no-interaction --no-scripts --no-plugins
        set -- "$@" vendor/autoload.php
    fi
    "$php_bin" -n -d extension=build/userland_subclass_probe.so verify.php "$@"
)
