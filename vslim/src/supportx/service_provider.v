module supportx

import vphp

@[php_method]
pub fn (mut provider VSlimServiceProvider) construct() &VSlimServiceProvider {
	return &provider
}

@[php_method: 'setApp']
pub fn (mut provider VSlimServiceProvider) set_app(app vphp.PhpObject) &VSlimServiceProvider {
	provider.bind_app_object(app)
	return &provider
}

@[php_method: 'hasApp']
pub fn (provider &VSlimServiceProvider) has_app() bool {
	return provider.app_ref.is_valid()
}

@[php_method]
pub fn (provider &VSlimServiceProvider) app() vphp.PhpObject {
	app := provider.app_object() or {
		vphp.PhpException.raise_class('RuntimeException',
			'service provider is not bound to an app', 0)
		return vphp.PhpObject.invalid()
	}
	return app
}

pub fn (mut provider VSlimServiceProvider) cleanup() {
	mut app := provider.app_ref
	app.release()
	provider.app_ref = vphp.PhpObject.invalid()
}
