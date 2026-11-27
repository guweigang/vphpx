module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'lazy_objects_probe' }

@[vphp.PhpExportConstant(name: 'VphpProbe\\VALUE85')]
@[vphp.PhpGlobalConstantSince(version: .php85)]
const value_85 = '雪'

@[vphp.PhpExportConstant(name: 'VphpProbe\\VALUE86')]
@[vphp.PhpGlobalConstantSince(version: .php86)]
@[vphp.PhpGlobalConstantAttribute(name: 'VphpLazyTag', args: 'version: 86')]
const value_86 = 86

@[vphp.PhpExportEnum(name: 'VphpProbe\\Mode')]
pub enum ProbeMode {
	ready
}

// The local vfmt rewrites typed enum field attributes into syntax V rejects.
// vfmt off
struct ProbeModeConstants {
	alias ProbeMode @[vphp.PhpClassConstantSince(version: .php86)]
}

const mode_constants = vphp.PhpConstantTable[ProbeMode, ProbeModeConstants]{
	values: ProbeModeConstants{ alias: .ready }
}

@[vphp.PhpExportInterface(name: 'VphpProbe\\Contract')]
@[vphp.PhpInterfaceConstants(source: 'contract_constants')]
pub interface VersionedContract {}

struct VersionedContractConstants {
	feature ProbeMode @[vphp.PhpClassConstantSince(version: .php86)]
}

const contract_constants = VersionedContractConstants{ feature: .ready }

@[vphp.PhpExportClass(name: 'VphpProbe\\VersionedClass')]
pub struct VersionedClass {}

struct VersionedClassConstants {
	level int @[vphp.PhpClassConstantSince(version: .php85); vphp.PhpClassConstantVisibility(visibility: .protected); vphp.PhpFinalClassConstant]
}

const class_constants = vphp.PhpConstantTable[VersionedClass, VersionedClassConstants]{
	values: VersionedClassConstants{ level: 85 }
}

@[vphp.PhpExportTrait(name: 'VphpProbe\\SourceTrait')]
struct SourceTrait {}

struct SourceTraitConstants {
	option ProbeMode @[vphp.PhpClassConstantSince(version: .php85); vphp.PhpClassConstantAttribute(name: 'VphpLazyTag', args: 'source: "base"')]
}

const source_trait_constants = vphp.PhpConstantTable[SourceTrait, SourceTraitConstants]{
	values: SourceTraitConstants{ option: .ready }
}

@[vphp.PhpExportTrait(name: 'VphpProbe\\CombinedTrait')]
struct CombinedTrait {}

struct CombinedTraitConstants {
	option ProbeMode @[vphp.PhpClassConstantSince(version: .php86); vphp.PhpClassConstantAttribute(name: 'VphpLazyTag', args: 'source: "combined"')]
}

const combined_trait_constants = vphp.PhpConstantTable[CombinedTrait, CombinedTraitConstants]{
	values: CombinedTraitConstants{ option: .ready }
}
// vfmt on

const combined_trait_rules = vphp.PhpTraitRules[CombinedTrait]{
	uses: [SourceTrait{}]
}

@[vphp.PhpExportTrait(name: 'VphpProbe\\OuterTrait')]
struct OuterTrait {}

const outer_trait_rules = vphp.PhpTraitRules[OuterTrait]{
	uses: [CombinedTrait{}]
}

@[vphp.PhpExportFunction(name: 'VphpProbe\\baseline')]
@[vphp.PhpFunctionSince(version: .php82)]
pub fn probe_baseline() int {
	return 82
}

@[vphp.PhpExportFunction(name: 'VphpProbe\\since85')]
@[vphp.PhpFunctionSince(version: .php85)]
pub fn probe_since_85() int {
	return 85
}

@[vphp.PhpExportFunction(name: 'VphpProbe\\since86')]
@[vphp.PhpFunctionSince(version: .php86)]
@[vphp.PhpArgName(v_name: 'input', php_name: 'value')]
@[vphp.PhpArgType(v_name: 'input', php_type: '(Countable&ArrayAccess)|int')]
@[vphp.PhpArgDefault(v_name: 'input', default_value: '\\VphpProbe\\VALUE86')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int')]
@[vphp.PhpCallableAttribute(name: 'VphpLazyTag', args: '')]
pub fn probe_since_86(input vphp.PhpValue) vphp.PhpValue {
	return input
}

@[vphp.PhpExportClass(name: 'VphpLazyProbe')]
pub struct LazyProbe {}

@[vphp.PhpExportMethod(name: 'supported')]
pub fn LazyProbe.supported() bool {
	return vphp.php_lazy_objects_supported()
}

@[vphp.PhpExportMethod(name: 'ghost')]
@[vphp.PhpMethodSince(version: .php84)]
@[vphp.PhpArgName(v_name: 'class_name', php_name: 'className')]
pub fn LazyProbe.ghost(class_name string, initializer vphp.PhpCallable) !vphp.PhpObject {
	mut ghost := vphp.PhpClass.named(class_name).new_lazy_ghost(initializer)!
	mut value := ghost.take_value()
	return value.move_to_request_scope().as_object() or { error('invalid lazy ghost') }
}

@[vphp.PhpExportMethod(name: 'pending')]
@[vphp.PhpMethodSince(version: .php84)]
pub fn LazyProbe.pending(object vphp.PhpObject) bool {
	return object.is_uninitialized_lazy()
}

@[vphp.PhpExportMethod(name: 'proxy')]
@[vphp.PhpMethodSince(version: .php84)]
pub fn LazyProbe.proxy(initializer vphp.PhpCallable) !vphp.PhpObject {
	mut proxy := vphp.PhpClass.named('VphpUserLazyService').new_lazy_proxy(initializer)!
	mut value := proxy.take_value()
	return value.move_to_request_scope().as_object() or { error('invalid lazy proxy') }
}

@[vphp.PhpExportMethod(name: 'initialize')]
@[vphp.PhpMethodSince(version: .php84)]
pub fn LazyProbe.initialize(object vphp.PhpObject) !vphp.PhpObject {
	mut instance := object.initialize_lazy()!
	mut value := instance.take_value()
	return value.move_to_request_scope().as_object() or { error('invalid initialized object') }
}

@[vphp.PhpExportMethod(name: 'since85')]
@[vphp.PhpMethodSince(version: .php85)]
@[vphp.PhpArgType(v_name: 'value', php_type: 'int|string')]
@[vphp.PhpCallableAttribute(name: 'VphpLazyTag', args: '')]
pub fn LazyProbe.since_85(value vphp.PhpValue) string {
	return value.to_string()
}

@[vphp.PhpExportMethod(name: 'since86')]
@[vphp.PhpMethodSince(version: .php86)]
@[vphp.PhpArgName(v_name: 'input', php_name: 'value')]
@[vphp.PhpArgType(v_name: 'input', php_type: 'int|string')]
@[vphp.PhpArgDefault(v_name: 'input', default_value: '42')]
@[vphp.PhpCallableAttribute(name: 'VphpLazyTag', args: '')]
pub fn LazyProbe.since_86(input vphp.PhpValue) string {
	return input.to_string()
}
