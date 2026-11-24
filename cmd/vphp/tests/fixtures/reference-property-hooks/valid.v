module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'reference_property_hooks' }

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '3')]
pub struct RefHookBase {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &RefHookBase) get_score() vphp.PhpReference {
	return vphp.PhpReference.hook_backing()
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('RefHookBase')]
pub struct RefHookChild {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('RefHookBase')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '5')]
pub struct RefHookBackedChild {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('RefHookBase')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '7')]
pub struct RefHookOverride {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &RefHookOverride) get_score() !vphp.PhpReference {
	return vphp.PhpReference.hook_backing()
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty('score', 'int')]
@[vphp.PhpDeclaredPropertyWithDefault('storage', 'int', '3')]
@[vphp.PhpDeclaredPropertyVisibility('storage', .private)]
pub struct VirtualRefHook {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VirtualRefHook) get_score() vphp.PhpReference {
	return vphp.PhpReference.hook_storage('storage')
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (target &VirtualRefHook) set_score(value int) {
	mut updated := vphp.PhpValue.int(i64(value) * 10)
	defer {
		updated.release()
	}
	vphp.PhpReference.hook_storage('storage').set_value(updated)
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VirtualRefHook')]
pub struct VirtualRefHookChild {}
