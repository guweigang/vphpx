module sessionx

import configx
import containerx
import httpx
import vphp

pub fn VSlimSessionStartMiddleware.from_container(container &containerx.VSlimContainer) &VSlimSessionStartMiddleware {
	return &VSlimSessionStartMiddleware{
		container_ref: container
	}
}

pub fn VSlimAuthRequireMiddleware.from_container(container &containerx.VSlimContainer, redirect_path string) &VSlimAuthRequireMiddleware {
	return &VSlimAuthRequireMiddleware{
		container_ref: container
		redirect_path: redirect_path.trim_space()
	}
}

pub fn VSlimAuthGuestMiddleware.from_container(container &containerx.VSlimContainer, redirect_path string) &VSlimAuthGuestMiddleware {
	return &VSlimAuthGuestMiddleware{
		container_ref: container
		redirect_path: redirect_path.trim_space()
	}
}

pub fn VSlimAuthRequireAbilityMiddleware.from_container(container &containerx.VSlimContainer, ability string) &VSlimAuthRequireAbilityMiddleware {
	return &VSlimAuthRequireAbilityMiddleware{
		container_ref: container
		ability:       ability.trim_space()
		status:        403
		message:       'Forbidden'
	}
}

fn middleware_container_or_error(container_ref &containerx.VSlimContainer, label string) !&containerx.VSlimContainer {
	if container_ref == unsafe { nil } {
		return error('${label} container is not configured')
	}
	return container_ref
}

fn config_from_container(container &containerx.VSlimContainer) &configx.VSlimConfig {
	unsafe {
		mut writable := &containerx.VSlimContainer(container)
		value := writable.get_value(configx.service_config) or { return nil }
		return value.to_v_object[configx.VSlimConfig]() or { nil }
	}
}

fn session_for_request(container &containerx.VSlimContainer, request vphp.PhpObject) &VSlimSessionStore {
	return VSlimSessionStore.from_config_and_request(config_from_container(container), request)
}

fn auth_for_request(container &containerx.VSlimContainer, request vphp.PhpObject) &VSlimAuthSessionGuard {
	mut session := session_for_request(container, request)
	return VSlimAuthSessionGuard.from_store_and_config(session, config_from_container(container))
}

fn auth_redirect_to(container &containerx.VSlimContainer, fallback string) string {
	if fallback.trim_space() != '' {
		return fallback.trim_space()
	}
	return auth_redirect_path_from_config(config_from_container(container), '')
}

fn auth_user_provider_from_container(container &containerx.VSlimContainer) vphp.PhpValue {
	unsafe {
		mut writable := &containerx.VSlimContainer(container)
		return writable.get_value(service_auth_user_provider) or { vphp.PhpValue.invalid() }
	}
}

fn auth_gate_resolver_from_container(container &containerx.VSlimContainer) vphp.PhpValue {
	unsafe {
		mut writable := &containerx.VSlimContainer(container)
		return writable.get_value(service_auth_gate_resolver) or { vphp.PhpValue.invalid() }
	}
}

fn resolve_auth_user_from_provider(provider vphp.PhpValue, user_id string) vphp.PhpValue {
	normalized_id := user_id.trim_space()
	if normalized_id == '' {
		return vphp.PhpValue.null()
	}
	if !provider.is_valid() {
		return vphp.PhpString.of(normalized_id).take_value()
	}
	mut normalized_id_arg := vphp.PhpString.of(normalized_id)
	defer {
		normalized_id_arg.release()
	}
	if callable := provider.as_callable() {
		return callable.invoke(normalized_id_arg)
	}
	if provider_obj := provider.as_object() {
		if provider_obj.method_exists('findById') {
			return provider_obj.call_method('findById', normalized_id_arg)
		}
		if provider_obj.method_exists('resolve') {
			return provider_obj.call_method('resolve', normalized_id_arg)
		}
	}
	return vphp.PhpString.of(normalized_id).take_value()
}

fn auth_user(container &containerx.VSlimContainer, request vphp.PhpObject) vphp.PhpValue {
	mut guard := auth_for_request(container, request)
	if !guard.check() {
		return vphp.PhpValue.null()
	}
	mut provider := auth_user_provider_from_container(container)
	defer {
		provider.release()
	}
	mut user := resolve_auth_user_from_provider(provider, guard.id())
	if !user.is_valid() || user.is_null() || user.is_undef() {
		return user
	}
	return user.to_request_owned()
}

fn can(container &containerx.VSlimContainer, ability string, request vphp.PhpObject) bool {
	normalized := ability.trim_space().to_lower()
	mut guard := auth_for_request(container, request)
	mut resolver := auth_gate_resolver_from_container(container)
	defer {
		resolver.release()
	}
	if !resolver.is_valid() || !resolver.is_callable() {
		return match normalized {
			'authenticated', 'auth' { guard.check() }
			'guest' { guard.guest() }
			else { false }
		}
	}
	mut user := auth_user(container, request)
	defer {
		user.release()
	}
	mut ability_arg := vphp.PhpString.of(ability)
	defer {
		ability_arg.release()
	}
	mut result := resolver.as_callable() or { return false }.invoke(ability_arg, user, request)
	defer {
		result.release()
	}
	return result.to_bool()
}

fn psr7_auth_unauthorized_response(redirect_path string) &httpx.VSlimPsr7Response {
	if redirect_path.trim_space() != '' {
		mut redirect := httpx.VSlimResponse.text(302, '')
		redirect.redirect(redirect_path.trim_space())
		return httpx.VSlimPsr7Response.from_vslim_response(redirect)
	}
	return httpx.VSlimPsr7Response.text(401, 'Unauthorized')
}

fn psr7_auth_guest_redirect(redirect_path string) &httpx.VSlimPsr7Response {
	target := if redirect_path.trim_space() == '' { '/' } else { redirect_path.trim_space() }
	mut redirect := httpx.VSlimResponse.text(302, '')
	redirect.redirect(target)
	return httpx.VSlimPsr7Response.from_vslim_response(redirect)
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimSessionStartMiddleware) construct() &VSlimSessionStartMiddleware {
	return &middleware
}

@[php_method: 'setContainer']
@[php_borrowed_return]
pub fn (mut middleware VSlimSessionStartMiddleware) set_container(container &containerx.VSlimContainer) &VSlimSessionStartMiddleware {
	middleware.container_ref = container
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimSessionStartMiddleware) set_app(app vphp.PhpValue) &VSlimSessionStartMiddleware {
	if app_obj := app.as_object() {
		mut result := app_obj.call_method('container')
		defer {
			result.release()
		}
		if container := result.to_v_object[containerx.VSlimContainer]() {
			middleware.container_ref = container
		}
	}
	return &middleware
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface,handler=Psr\\Http\\Server\\RequestHandlerInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (middleware &VSlimSessionStartMiddleware) process(request vphp.PhpObject, handler vphp.PhpObject) &httpx.VSlimPsr7Response {
	container := middleware_container_or_error(middleware.container_ref, 'Session middleware') or {
		return httpx.VSlimPsr7Response.text(500, err.msg())
	}
	if !request.is_valid() {
		return httpx.VSlimPsr7Response.text(500, 'Session middleware request is not an object')
	}
	mut session := session_for_request(container, request)
	mut result := handler.call_method('handle', request)
	defer {
		result.release()
	}
	response := httpx.VSlimPsr7Response.from_value(result)
	return session.commit_psr_response(response)
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimAuthRequireMiddleware) construct() &VSlimAuthRequireMiddleware {
	middleware.redirect_path = ''
	return &middleware
}

@[php_method: 'setContainer']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthRequireMiddleware) set_container(container &containerx.VSlimContainer) &VSlimAuthRequireMiddleware {
	middleware.container_ref = container
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthRequireMiddleware) set_app(app vphp.PhpValue) &VSlimAuthRequireMiddleware {
	if app_obj := app.as_object() {
		mut result := app_obj.call_method('container')
		defer {
			result.release()
		}
		if container := result.to_v_object[containerx.VSlimContainer]() {
			middleware.container_ref = container
		}
	}
	return &middleware
}

@[php_arg_name: 'path=redirectPath']
@[php_method: 'setRedirectTo']
pub fn (mut middleware VSlimAuthRequireMiddleware) set_redirect_path(path string) &VSlimAuthRequireMiddleware {
	middleware.redirect_path = path.trim_space()
	return &middleware
}

@[php_method: 'redirectTo']
pub fn (middleware &VSlimAuthRequireMiddleware) redirect_path_value() string {
	return middleware.redirect_path.trim_space()
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface,handler=Psr\\Http\\Server\\RequestHandlerInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (middleware &VSlimAuthRequireMiddleware) process(request vphp.PhpObject, handler vphp.PhpObject) &httpx.VSlimPsr7Response {
	container := middleware_container_or_error(middleware.container_ref, 'Auth middleware') or {
		return httpx.VSlimPsr7Response.text(500, err.msg())
	}
	if !request.is_valid() {
		return httpx.VSlimPsr7Response.text(500, 'Auth middleware request is not an object')
	}
	mut guard := auth_for_request(container, request)
	if !guard.check() {
		return psr7_auth_unauthorized_response(auth_redirect_to(container, middleware.redirect_path))
	}
	user_id := guard.id()
	mut user_id_arg := vphp.PhpString.of(user_id)
	defer {
		user_id_arg.release()
	}
	mut next_request := request.with_attribute('auth.user_id', user_id_arg)
	defer {
		next_request.release()
	}
	mut user := auth_user(container, request)
	defer {
		user.release()
	}
	if user.is_valid() && !user.is_null() && !user.is_undef() {
		mut enriched := next_request.with_attribute('auth.user', user)
		next_request.release()
		next_request = enriched
	}
	mut result := handler.call_method('handle', next_request)
	defer {
		result.release()
	}
	return httpx.VSlimPsr7Response.from_value(result)
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimAuthGuestMiddleware) construct() &VSlimAuthGuestMiddleware {
	middleware.redirect_path = ''
	return &middleware
}

@[php_method: 'setContainer']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthGuestMiddleware) set_container(container &containerx.VSlimContainer) &VSlimAuthGuestMiddleware {
	middleware.container_ref = container
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthGuestMiddleware) set_app(app vphp.PhpValue) &VSlimAuthGuestMiddleware {
	if app_obj := app.as_object() {
		mut result := app_obj.call_method('container')
		defer {
			result.release()
		}
		if container := result.to_v_object[containerx.VSlimContainer]() {
			middleware.container_ref = container
		}
	}
	return &middleware
}

@[php_arg_name: 'path=redirectPath']
@[php_method: 'setRedirectTo']
pub fn (mut middleware VSlimAuthGuestMiddleware) set_redirect_path(path string) &VSlimAuthGuestMiddleware {
	middleware.redirect_path = path.trim_space()
	return &middleware
}

@[php_method: 'redirectTo']
pub fn (middleware &VSlimAuthGuestMiddleware) redirect_path_value() string {
	return middleware.redirect_path.trim_space()
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface,handler=Psr\\Http\\Server\\RequestHandlerInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (middleware &VSlimAuthGuestMiddleware) process(request vphp.PhpObject, handler vphp.PhpObject) &httpx.VSlimPsr7Response {
	container := middleware_container_or_error(middleware.container_ref, 'Guest middleware') or {
		return httpx.VSlimPsr7Response.text(500, err.msg())
	}
	if !request.is_valid() {
		return httpx.VSlimPsr7Response.text(500, 'Guest middleware request is not an object')
	}
	mut guard := auth_for_request(container, request)
	if !guard.guest() {
		return psr7_auth_guest_redirect(auth_redirect_to(container, middleware.redirect_path))
	}
	mut result := handler.call_method('handle', request)
	defer {
		result.release()
	}
	return httpx.VSlimPsr7Response.from_value(result)
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) construct() &VSlimAuthRequireAbilityMiddleware {
	middleware.ability = ''
	middleware.status = 403
	middleware.message = 'Forbidden'
	return &middleware
}

@[php_method: 'setContainer']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) set_container(container &containerx.VSlimContainer) &VSlimAuthRequireAbilityMiddleware {
	middleware.container_ref = container
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) set_app(app vphp.PhpValue) &VSlimAuthRequireAbilityMiddleware {
	if app_obj := app.as_object() {
		mut result := app_obj.call_method('container')
		defer {
			result.release()
		}
		if container := result.to_v_object[containerx.VSlimContainer]() {
			middleware.container_ref = container
		}
	}
	return &middleware
}

@[php_method: 'setAbility']
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) set_ability(ability string) &VSlimAuthRequireAbilityMiddleware {
	middleware.ability = ability.trim_space()
	return &middleware
}

@[php_method]
pub fn (middleware &VSlimAuthRequireAbilityMiddleware) ability() string {
	return middleware.ability.trim_space()
}

@[php_method: 'setStatus']
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) set_status(status int) &VSlimAuthRequireAbilityMiddleware {
	if status > 0 {
		middleware.status = status
	}
	return &middleware
}

@[php_method]
pub fn (middleware &VSlimAuthRequireAbilityMiddleware) status() int {
	if middleware.status <= 0 {
		return 403
	}
	return middleware.status
}

@[php_method: 'setMessage']
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) set_message(message string) &VSlimAuthRequireAbilityMiddleware {
	middleware.message = message.trim_space()
	return &middleware
}

@[php_method]
pub fn (middleware &VSlimAuthRequireAbilityMiddleware) message() string {
	if middleware.message.trim_space() == '' {
		return 'Forbidden'
	}
	return middleware.message.trim_space()
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface,handler=Psr\\Http\\Server\\RequestHandlerInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (middleware &VSlimAuthRequireAbilityMiddleware) process(request vphp.PhpObject, handler vphp.PhpObject) &httpx.VSlimPsr7Response {
	container := middleware_container_or_error(middleware.container_ref, 'Ability middleware') or {
		return httpx.VSlimPsr7Response.text(500, err.msg())
	}
	if middleware.ability() == '' {
		return httpx.VSlimPsr7Response.text(500, 'Ability middleware ability is not configured')
	}
	if !request.is_valid() {
		return httpx.VSlimPsr7Response.text(500, 'Ability middleware request is not an object')
	}
	if !can(container, middleware.ability(), request) {
		return httpx.VSlimPsr7Response.text(middleware.status(), middleware.message())
	}
	mut result := handler.call_method('handle', request)
	defer {
		result.release()
	}
	return httpx.VSlimPsr7Response.from_value(result)
}
