module appx

import sessionx
import vphp

@[php_method]
pub fn (app &VSlimApp) session(request vphp.PhpObject) &sessionx.VSlimSessionStore {
	return sessionx.VSlimSessionStore.from_config_and_request(app.config_ref, request)
}

@[php_method]
pub fn (app &VSlimApp) auth(request vphp.PhpObject) &sessionx.VSlimAuthSessionGuard {
	mut session := app.session(request)
	return sessionx.VSlimAuthSessionGuard.from_store_and_config(session, app.config_ref)
}

@[php_method: 'setAuthUserResolver']
pub fn (mut app VSlimApp) set_auth_user_resolver(resolver vphp.PhpCallable) &VSlimApp {
	app.auth_user_resolver.release()
	app.auth_user_resolver = resolver.retain().to_value()
	app.sync_auth_services_to_container()
	return &app
}

@[php_method: 'setAuthUserProvider']
pub fn (mut app VSlimApp) set_auth_user_provider(provider vphp.PhpValue) &VSlimApp {
	if sessionx.is_auth_user_provider(provider) {
		app.auth_user_resolver.release()
		app.auth_user_resolver = provider.retain()
		app.sync_auth_services_to_container()
		return &app
	}
	vphp.PhpException.raise_class('InvalidArgumentException',
		'auth user provider must be callable or an object with findById()/resolve()', 0)
	return &app
}

@[php_method: 'setAuthGateResolver']
pub fn (mut app VSlimApp) set_auth_gate_resolver(resolver vphp.PhpCallable) &VSlimApp {
	app.auth_gate_resolver.release()
	app.auth_gate_resolver = resolver.retain()
	app.sync_auth_services_to_container()
	return &app
}

@[php_method: 'setAuthRedirectTo']
pub fn (mut app VSlimApp) set_auth_redirect_path(path string) &VSlimApp {
	app.auth_redirect_path = path.trim_space()
	return &app
}

@[php_method: 'hasAuthUserProvider']
pub fn (app &VSlimApp) has_auth_user_provider() bool {
	return sessionx.is_auth_user_provider(app.auth_user_resolver)
}

@[php_method: 'authRedirectTo']
pub fn (app &VSlimApp) auth_redirect_to() string {
	return app.auth_redirect_path.trim_space()
}

@[php_method: 'resolveAuthUser']
@[php_arg_name: 'user_id=userId']
pub fn (app &VSlimApp) resolve_auth_user(user_id string) vphp.PhpValue {
	return sessionx.resolve_auth_user(app.auth_user_resolver, user_id)
}

@[php_method: 'authUser']
pub fn (app &VSlimApp) auth_user(request vphp.PhpObject) vphp.PhpValue {
	mut guard := app.auth(request)
	if !guard.check() {
		return vphp.PhpValue.null()
	}
	user_id := guard.id()
	mut user := app.resolve_auth_user(user_id)
	if !user.is_valid() || user.is_null() || user.is_undef() {
		return user
	}
	return user.to_request_owned()
}

@[php_method: 'authCheck']
pub fn (app &VSlimApp) auth_check(request vphp.PhpObject) bool {
	mut guard := app.auth(request)
	return guard.check()
}

@[php_method: 'authGuest']
pub fn (app &VSlimApp) auth_guest(request vphp.PhpObject) bool {
	mut guard := app.auth(request)
	return guard.guest()
}

@[php_method: 'authId']
pub fn (app &VSlimApp) auth_id(request vphp.PhpObject) string {
	mut guard := app.auth(request)
	return guard.id()
}

@[php_arg_name: 'user_id=userId']
@[php_method]
pub fn (app &VSlimApp) login(request vphp.PhpObject, response vphp.PhpObject, user_id string) bool {
	mut guard := app.auth(request)
	guard.login(user_id)
	mut store := guard.store()
	return store.commit(response)
}

@[php_method]
pub fn (app &VSlimApp) logout(request vphp.PhpObject, response vphp.PhpObject) bool {
	mut guard := app.auth(request)
	guard.logout()
	mut store := guard.store()
	return store.destroy(response)
}

@[php_method]
pub fn (app &VSlimApp) can(ability string, request vphp.PhpObject) bool {
	normalized := ability.trim_space().to_lower()
	mut guard := app.auth(request)
	if !app.auth_gate_resolver.is_valid() || !app.auth_gate_resolver.is_callable() {
		return match normalized {
			'authenticated', 'auth' { guard.check() }
			'guest' { guard.guest() }
			else { false }
		}
	}
	mut user := app.auth_user(request)
	defer {
		user.release()
	}
	mut ability_arg := vphp.PhpString.of(ability)
	defer {
		ability_arg.release()
	}
	mut result := app.auth_gate_resolver.invoke(ability_arg, user, request)
	defer {
		result.release()
	}
	return result.to_bool()
}

@[php_method]
pub fn (app &VSlimApp) cannot(ability string, request vphp.PhpObject) bool {
	return !app.can(ability, request)
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'startSessionMiddleware']
pub fn (app &VSlimApp) start_session_middleware() &sessionx.VSlimSessionStartMiddleware {
	unsafe {
		mut writable := &VSlimApp(app)
		return sessionx.VSlimSessionStartMiddleware.from_container(writable.container())
	}
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'authMiddleware']
pub fn (app &VSlimApp) auth_middleware() &sessionx.VSlimAuthRequireMiddleware {
	unsafe {
		mut writable := &VSlimApp(app)
		return sessionx.VSlimAuthRequireMiddleware.from_container(writable.container(),
			app.auth_redirect_path.trim_space())
	}
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'guestMiddleware']
pub fn (app &VSlimApp) guest_middleware() &sessionx.VSlimAuthGuestMiddleware {
	unsafe {
		mut writable := &VSlimApp(app)
		return sessionx.VSlimAuthGuestMiddleware.from_container(writable.container(),
			app.auth_redirect_path.trim_space())
	}
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'abilityMiddleware']
pub fn (app &VSlimApp) ability_middleware(ability string) &sessionx.VSlimAuthRequireAbilityMiddleware {
	unsafe {
		mut writable := &VSlimApp(app)
		return sessionx.VSlimAuthRequireAbilityMiddleware.from_container(writable.container(),
			ability.trim_space())
	}
}
