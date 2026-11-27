module supportx

import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Support\\ServiceProvider')]
@[heap]
pub struct VSlimServiceProvider {
mut:
	app_ref vphp.PhpObject = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportClass(name: 'VSlim\\Support\\Module')]
@[heap]
pub struct VSlimModule {
mut:
	app_ref vphp.PhpObject = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
}
