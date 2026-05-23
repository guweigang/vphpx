module supportx

import vphp

@[php_class: 'VSlim\\Support\\ServiceProvider']
@[heap]
pub struct VSlimServiceProvider {
mut:
	app_ref vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
}

@[php_class: 'VSlim\\Support\\Module']
@[heap]
pub struct VSlimModule {
mut:
	app_ref vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
}
