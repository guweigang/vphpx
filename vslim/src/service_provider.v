module main

import vphp

@[php_method]
pub fn (mut provider VSlimServiceProvider) construct() &VSlimServiceProvider {
	return &provider
}

@[php_method: 'setApp']
pub fn (mut provider VSlimServiceProvider) set_app(app &VSlimApp) &VSlimServiceProvider {
	provider.app_ref = app
	return &provider
}

@[php_method: 'hasApp']
pub fn (provider &VSlimServiceProvider) has_app() bool {
	return provider.app_ref != unsafe { nil }
}

@[php_method]
pub fn (provider &VSlimServiceProvider) app() &VSlimApp {
	if provider.app_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'service provider is not bound to an app', 0)
		return unsafe { nil }
	}
	return provider.app_ref
}
