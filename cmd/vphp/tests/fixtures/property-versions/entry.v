module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'property_versions_probe' }

@[vphp.PhpExportClass(name: 'VphpVersionedCopyState')]
@[vphp.PhpObjectCopy(cloneable: true, serializable: false)]
@[heap]
pub struct VersionedCopyState {
pub mut:
	score int = 3
}

pub fn (source &VersionedCopyState) clone_into(mut target VersionedCopyState) {
	target.score = source.score
}

@[vphp.PhpExportMethod(name: 'readScore')]
pub fn (source &VersionedCopyState) read_score() int {
	return source.score
}

@[vphp.PhpExportFunction(name: 'cloneVersionedObjectWith')]
@[vphp.PhpFunctionSince(version: .php85)]
pub fn clone_versioned_object_with(object vphp.PhpObject, properties vphp.PhpArray) !vphp.PhpObject {
	return object.clone_with(properties)
}

@[vphp.PhpExportClass(name: 'VphpVersionedBase')]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'label', php_type: 'string', default_value: "'base'")]
pub struct VersionedBase {}

@[vphp.PhpExportClass(name: 'VphpVersionedChild')]
@[vphp.PhpExtends(name: 'VersionedBase')]
pub struct VersionedChild {}

const child_properties = vphp.PhpDeclaredProperties[VersionedChild]{
	properties: [
		vphp.PhpDeclaredPropertySpec{
			name:          'label'
			php_type:      'string'
			default_value: "'child'"
			since:         .php86
		},
		vphp.PhpDeclaredPropertySpec{
			name:          'count'
			php_type:      'int'
			default_value: '85'
			since:         .php85
		},
		vphp.PhpDeclaredPropertySpec{
			name:           'shared'
			php_type:       'int'
			default_value:  '5'
			is_static:      true
			set_visibility: .protected
			since:          .php84
		},
		vphp.PhpDeclaredPropertySpec{
			name:     'derived'
			php_type: 'int'
			since:    .php86
		},
		vphp.PhpDeclaredPropertySpec{ name: 'lateRead', php_type: 'int', default_value: '7' },
		vphp.PhpDeclaredPropertySpec{ name: 'staggered', php_type: 'int', default_value: '4' },
		vphp.PhpDeclaredPropertySpec{ name: 'hookValue', php_type: 'int', default_value: '11' },
		vphp.PhpDeclaredPropertySpec{
			name:          'readonlyDefault'
			php_type:      'int'
			default_value: '86'
			is_readonly:   true
			since:         .php86
		},
	]
}

@[vphp.PhpExportClass(name: 'VphpVersionedReadonly')]
@[vphp.PhpReadonlyClass]
pub struct VersionedReadonly {}

const versioned_readonly_defaults = vphp.PhpDeclaredProperties[VersionedReadonly]{
	properties: [vphp.PhpDeclaredPropertySpec{
		name:          'payload'
		php_type:      '?string'
		default_value: 'null'
		since:         .php86
	}]
}

@[vphp.PhpExportClass(name: 'VphpVersionedReadonlyClass')]
@[vphp.PhpReadonlyClass]
@[vphp.PhpTypeSince(version: .php86)]
@[vphp.PhpDeclaredPropertyWithDefault(name: 'label', php_type: 'string', default_value: "'ready'")]
pub struct VersionedReadonlyClass {}

@[vphp.PhpPropertyGet(property: 'derived')]
pub fn (owner &VersionedChild) derived() int {
	return 86
}

@[vphp.PhpPropertyGet(property: 'lateRead')]
@[vphp.PhpMethodSince(version: .php86)]
pub fn (owner &VersionedChild) late_read() int {
	return 86
}

@[vphp.PhpPropertyGet(property: 'staggered')]
@[vphp.PhpMethodSince(version: .php85)]
pub fn (owner &VersionedChild) staggered_get() int {
	return int(vphp.ZendObject.current().prop_i64_or('hookValue', 0))
}

@[vphp.PhpPropertySet(property: 'staggered')]
@[vphp.PhpMethodSince(version: .php86)]
pub fn (owner &VersionedChild) staggered_set(value int) {
	vphp.ZendObject.current().set_prop('hookValue', vphp.ZVal.new_int(i64(value) * 2))
}

@[vphp.PhpExportTrait(name: 'VphpVersionedSource')]
pub struct VersionedSource {}

const source_properties = vphp.PhpDeclaredProperties[VersionedSource]{
	properties: [vphp.PhpDeclaredPropertySpec{
		name:          'fromTrait'
		php_type:      'string'
		default_value: "'ready'"
		since:         .php85
	}]
}

@[vphp.PhpExportTrait(name: 'VphpVersionedTrait')]
pub struct VersionedTrait {}

const trait_properties = vphp.PhpDeclaredProperties[VersionedTrait]{
	properties: [vphp.PhpDeclaredPropertySpec{
		name:          'fromTrait'
		php_type:      'string'
		default_value: "'ready'"
		since:         .php86
	}]
}

const versioned_trait_rules = vphp.PhpTraitRules[VersionedTrait]{
	uses: [VersionedSource{}]
}

@[vphp.PhpExportInterface(name: 'VphpVersionedContract')]
pub interface VersionedContract {}

const contract_properties = vphp.PhpInterfaceProperties[VersionedContract]{
	properties: [
		vphp.PhpInterfaceProperty{ name: 'active', php_type: 'bool', access: .get },
		vphp.PhpInterfaceProperty{
			name:     'phase'
			php_type: 'int'
			access:   .get
			since:    .php85
		},
		vphp.PhpInterfaceProperty{
			name:     'item'
			php_type: 'int'
			access:   .get_ref_set
			since:    .php86
		},
	]
}

@[vphp.PhpExportInterface(name: 'VphpInheritedVersionedContract')]
@[vphp.PhpExtendsInterfaces(names: 'VersionedContract')]
pub interface InheritedVersionedContract {}

@[vphp.PhpExportClass(name: 'VphpVersionedAbstract')]
@[vphp.PhpAbstractClass]
pub struct VersionedAbstract {}

const abstract_contract_properties = vphp.PhpAbstractProperties[VersionedAbstract]{
	properties: [vphp.PhpAbstractProperty{
		name:     'token'
		php_type: 'int'
		access:   .get_ref
		since:    .php86
	}]
}

@[vphp.PhpExportClass(name: 'VphpVersionedImplementation')]
@[vphp.PhpExtends(name: 'VersionedAbstract')]
@[vphp.PhpImplements(names: 'InheritedVersionedContract')]
pub struct VersionedImplementation {}

const implementation_properties = vphp.PhpDeclaredProperties[VersionedImplementation]{
	properties: [
		vphp.PhpDeclaredPropertySpec{ name: 'active', php_type: 'bool', default_value: 'true' },
		vphp.PhpDeclaredPropertySpec{ name: 'phase', php_type: 'int', since: .php85 },
		vphp.PhpDeclaredPropertySpec{
			name:          'item'
			php_type:      'int'
			default_value: '12'
			since:         .php86
		},
		vphp.PhpDeclaredPropertySpec{
			name:          'token'
			php_type:      'int'
			default_value: '24'
			since:         .php86
		},
	]
}

@[vphp.PhpPropertyGet(property: 'phase')]
@[vphp.PhpCallableAttribute(name: 'Override', args: '')]
pub fn (owner &VersionedImplementation) phase() int {
	return 85
}
