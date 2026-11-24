module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'type_versions_probe' }

@[vphp.PhpExportInterface(name: 'VphpTypeGate\\Contract')]
@[vphp.PhpTypeSince(version: .php85)]
pub interface GateContract {}

@[vphp.PhpExportInterface(name: 'VphpTypeGate\\ChildContract')]
@[vphp.PhpExtendsInterfaces(names: 'GateContract')]
pub interface GateChildContract {}

@[vphp.PhpExportClass(name: 'VphpTypeGate\\Base')]
@[vphp.PhpImplements(names: 'GateChildContract')]
pub struct GateBase {}

@[vphp.PhpExportClass(name: 'VphpTypeGate\\Child')]
@[vphp.PhpExtends(name: 'GateBase')]
pub struct GateChild {}

@[vphp.PhpExportFunction(name: 'VphpTypeGate\\acceptChild')]
pub fn accept_child(value &GateChild) int {
	return 85
}

@[vphp.PhpExportClass(name: 'VphpTypeGate\\Future')]
@[vphp.PhpTypeSince(version: .php86)]
@[vphp.PhpImplements(names: 'Countable')]
pub struct GateFuture {
	amount int = 86
}

@[vphp.PhpExportClass(name: 'VphpTypeGate\\FutureStream')]
@[vphp.PhpTypeSince(version: .php86)]
@[vphp.PhpExtends(name: 'StreamException')]
pub struct GateFutureStream {}

@[vphp.PhpExportMethod(name: 'count')]
pub fn (value &GateFuture) count() int {
	return value.amount
}

@[vphp.PhpExportFunction(name: 'VphpTypeGate\\createFuture')]
pub fn create_future() &GateFuture {
	return &GateFuture{}
}

@[vphp.PhpExportFunction(name: 'VphpTypeGate\\acceptFuture')]
pub fn accept_future(value &GateFuture) int {
	return value.count()
}

@[vphp.PhpExportFunction(name: 'VphpTypeGate\\acceptCompound')]
@[vphp.PhpArgType(v_name: 'value', php_type: '(VphpTypeGate\\Future&Countable)|int')]
pub fn accept_compound(value vphp.PhpValue) vphp.PhpValue {
	return value
}

@[params]
pub struct GateOptions {
	value     int = gate_value()
	increment int = 0
}

fn gate_value() int {
	return 42
}

@[vphp.PhpExportFunction(name: 'VphpTypeGate\\createConfigured')]
pub fn create_configured(options GateOptions) &GateFuture {
	return &GateFuture{ amount: options.value + options.increment }
}

@[vphp.PhpExportMethod(name: 'configuredValue')]
pub fn (value &GateFuture) configured_value(options GateOptions) int {
	return options.value
}

@[vphp.PhpExportFunction(name: 'VphpTypeGate\\configuredValue')]
@[vphp.PhpFunctionSince(version: .php86)]
pub fn configured_value(base &GateBase, options GateOptions) int {
	return options.value + options.increment
}

@[vphp.PhpExportTrait(name: 'VphpTypeGate\\Source')]
@[vphp.PhpTypeSince(version: .php86)]
pub struct GateSource {}

@[vphp.PhpExportMethod(name: 'label')]
pub fn (value &GateSource) label() string {
	return 'trait'
}

@[vphp.PhpExportTrait(name: 'VphpTypeGate\\Combined')]
pub struct GateCombined {}

const rules = vphp.PhpTraitRules[GateCombined]{
	uses: [GateSource{}]
}

@[vphp.PhpExportEnum(name: 'VphpTypeGate\\Kind')]
@[vphp.PhpTypeSince(version: .php86)]
pub enum GateKind {
	ready
}

@[vphp.PhpExportClass(name: 'VphpTypeGate\\AliasHost')]
pub struct GateAliasHost {}

@[vphp.PhpExportMethod(name: 'configuredValue')]
@[vphp.PhpMethodSince(version: .php86)]
pub fn (value &GateAliasHost) configured_value(options GateOptions) int {
	return options.value
}

struct GateConstants {
	ready GateKind
}

const aliases = vphp.PhpConstantTable[GateAliasHost, GateConstants]{
	values: GateConstants{ ready: .ready }
}
