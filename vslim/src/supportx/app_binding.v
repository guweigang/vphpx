module supportx

import vphp

fn (provider &VSlimServiceProvider) app_object() ?vphp.PhpObject {
	if provider.app_ref.is_valid() {
		return provider.app_ref.retain()
	}
	return none
}

fn (mut provider VSlimServiceProvider) bind_app_object(app vphp.PhpObject) {
	if !app.is_valid() {
		return
	}
	mut old := provider.app_ref
	old.release()
	provider.app_ref = app.retain()
}

fn (mod &VSlimModule) app_object() ?vphp.PhpObject {
	if mod.app_ref.is_valid() {
		return mod.app_ref.retain()
	}
	return none
}

fn (mut mod VSlimModule) bind_app_object(app vphp.PhpObject) {
	if !app.is_valid() {
		return
	}
	mut old := mod.app_ref
	old.release()
	mod.app_ref = app.retain()
}
