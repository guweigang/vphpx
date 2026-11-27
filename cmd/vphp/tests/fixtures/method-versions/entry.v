module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'method_versions_probe' }

@[vphp.PhpExportFunction(name: 'VphpVersioned\\legacyValue')]
@[vphp.PhpCallableAttribute(name: '\\Deprecated', args: 'message: "Use currentValue()", since: "2.0"')]
pub fn legacy_value(value int) int {
	return value
}

@[vphp.PhpExportInterface(name: 'VphpVersionedMethods')]
pub interface VersionedMethods {
	phase() int
	pick(input vphp.PhpValue) vphp.PhpValue
}

const interface_methods = vphp.PhpInterfaceMethods[VersionedMethods]{
	methods: [
		vphp.PhpInterfaceMethod{
			v_name:     'phase'
			static_:    true
			since:      .php85
			attributes: [vphp.PhpAttributeSpec{ name: 'NoDiscard', args: 'message: "Use the phase"' }]
		},
		vphp.PhpInterfaceMethod{
			v_name:          'pick'
			php_return_type: '(Countable&ArrayAccess)|int'
			since:           .php86
			parameters:      [vphp.PhpInterfaceParameter{
				v_name:     'input'
				php_name:   'value'
				php_type:   '(Countable&ArrayAccess)|int'
				attributes: [vphp.PhpAttributeSpec{ name: 'VphpMethodTag', args: 'slot: "value"' }]
			}]
		},
	]
}

const interface_defaults = vphp.PhpInterfaceDefaults[VersionedMethods]{
	defaults: [vphp.PhpInterfaceDefault{
		method:        'pick'
		parameter:     'value'
		default_value: '86'
	}]
}

@[vphp.PhpExportInterface(name: 'VphpInheritedVersionedMethods')]
@[vphp.PhpExtendsInterfaces(names: 'VersionedMethods')]
pub interface InheritedVersionedMethods {}

@[vphp.PhpExportClass(name: 'VphpVersionedMethodBase')]
pub struct VersionedMethodBase {}

@[vphp.PhpExportMethod(name: 'legacyValue')]
@[vphp.PhpCallableAttribute(name: 'Deprecated', args: '"Use currentValue()"')]
pub fn VersionedMethodBase.legacy_value(value int) int {
	return value
}

@[vphp.PhpExportMethod(name: 'revision')]
@[vphp.PhpAbstractMethod]
@[vphp.PhpMethodSince(version: .php86)]
pub fn VersionedMethodBase.revision() int {
	return 0
}

@[vphp.PhpExportClass(name: 'VphpVersionedMethodImplementation')]
@[vphp.PhpExtends(name: 'VersionedMethodBase')]
@[vphp.PhpImplements(names: 'InheritedVersionedMethods')]
pub struct VersionedMethodImplementation {}

@[vphp.PhpExportMethod(name: 'phase')]
@[vphp.PhpMethodSince(version: .php85)]
pub fn VersionedMethodImplementation.phase() int {
	return 85
}

@[vphp.PhpExportMethod(name: 'revision')]
@[vphp.PhpMethodSince(version: .php86)]
@[vphp.PhpCallableAttribute(name: 'Override', args: '')]
pub fn VersionedMethodImplementation.revision() int {
	return 86
}

@[vphp.PhpExportMethod(name: 'pick')]
@[vphp.PhpMethodSince(version: .php86)]
@[vphp.PhpArgName(v_name: 'input', php_name: 'value')]
@[vphp.PhpArgType(v_name: 'input', php_type: '(Countable&ArrayAccess)|int')]
@[vphp.PhpArgDefault(v_name: 'input', default_value: '86')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int')]
@[vphp.PhpCallableAttribute(name: 'Override', args: '')]
pub fn (owner &VersionedMethodImplementation) pick(input vphp.PhpValue) vphp.PhpValue {
	return input
}
