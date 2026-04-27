module main

import vphp

@[php_method]
pub fn (mut mod VSlimModule) construct() &VSlimModule {
	return &mod
}

@[php_method: 'setApp']
pub fn (mut mod VSlimModule) set_app(app &VSlimApp) &VSlimModule {
	mod.app_ref = app
	return &mod
}

@[php_method: 'hasApp']
pub fn (mod &VSlimModule) has_app() bool {
	return mod.app_ref != unsafe { nil }
}

@[php_method]
pub fn (mod &VSlimModule) app() &VSlimApp {
	if mod.app_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'module is not bound to an app', 0)
		return unsafe { nil }
	}
	return mod.app_ref
}
