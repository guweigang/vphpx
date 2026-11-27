module supportx

import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn (mut mod VSlimModule) construct() &VSlimModule {
	return &mod
}

@[vphp.PhpExportMethod(name: 'setApp')]
pub fn (mut mod VSlimModule) set_app(app vphp.PhpObject) &VSlimModule {
	mod.bind_app_object(app)
	return &mod
}

@[vphp.PhpExportMethod(name: 'hasApp')]
pub fn (mod &VSlimModule) has_app() bool {
	return mod.app_ref.is_valid()
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mod &VSlimModule) app() vphp.PhpObject {
	app := mod.app_object() or {
		vphp.PhpException.raise_class('RuntimeException', 'module is not bound to an app', 0)
		return vphp.PhpObject.invalid()
	}
	return app
}

pub fn (mut mod VSlimModule) cleanup() {
	mut app := mod.app_ref
	app.release()
	mod.app_ref = vphp.PhpObject.invalid()
}
