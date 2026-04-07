module main

import os
import vphp

#include "php_bridge.h"

fn zval_to_json_fragment(value vphp.ZVal) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return 'null'
	}
	return vphp.json_encode(value)
}

fn exception_class_name(exception vphp.RequestBorrowedZBox) string {
	raw := exception.to_zval()
	if !raw.is_valid() || !raw.is_object() {
		return ''
	}
	return raw.class_name().trim_space()
}

fn exception_message_value(exception vphp.RequestBorrowedZBox, fallback string) string {
	raw := exception.to_zval()
	if !raw.is_valid() || !raw.is_object() || !raw.method_exists('getMessage') {
		return fallback
	}
	mut out := vphp.method_request_owned_box(raw, 'getMessage', []vphp.ZVal{})
	defer {
		out.release()
	}
	message := out.to_zval().to_string().trim_space()
	if message == '' {
		return fallback
	}
	return message
}

fn exception_status_code(exception vphp.RequestBorrowedZBox, fallback_status int) int {
	raw := exception.to_zval()
	if raw.is_valid() && raw.is_object() && raw.method_exists('getCode') {
		mut out := vphp.method_request_owned_box(raw, 'getCode', []vphp.ZVal{})
		defer {
			out.release()
		}
		code := out.to_zval().to_int()
		if code >= 400 && code <= 599 {
			return code
		}
	}
	class_name := exception_class_name(exception)
	if class_name == '' {
		return fallback_status
	}
	if class_name == 'InvalidArgumentException' || class_name == 'DomainException'
		|| class_name == 'VSlim\\Psr16\\InvalidArgumentException'
		|| class_name == 'VSlim\\Psr6\\InvalidArgumentException' {
		return 400
	}
	if class_name == 'VSlim\\Container\\NotFoundException' {
		return 404
	}
	if class_name == 'VSlim\\Auth\\UnauthorizedException' {
		return 401
	}
	if class_name == 'VSlim\\Auth\\ForbiddenException' {
		return 403
	}
	if class_name == 'VSlim\\ValidationException' || class_name == 'ValidationException' {
		return 422
	}
	return fallback_status
}

fn exception_error_code(exception vphp.RequestBorrowedZBox) string {
	class_name := exception_class_name(exception)
	return match class_name {
		'InvalidArgumentException', 'DomainException', 'VSlim\\Psr16\\InvalidArgumentException',
		'VSlim\\Psr6\\InvalidArgumentException' { 'invalid_argument' }
		'VSlim\\Container\\NotFoundException' { 'not_found' }
		'VSlim\\Auth\\UnauthorizedException' { 'unauthorized' }
		'VSlim\\Auth\\ForbiddenException' { 'forbidden' }
		'VSlim\\ValidationException', 'ValidationException' { 'validation_error' }
		else { 'runtime_error' }
	}
}

@[php_method]
pub fn (mut app VSlimApp) set_base_path(base_path string) &VSlimApp {
	app.base_path = RoutePath.normalize_base_path(base_path)
	return app
}

@[php_method]
pub fn (app &VSlimApp) has_container() bool {
	return app.container_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_container(container &VSlimContainer) &VSlimApp {
	app.container_ref = container
	app.container_ref.app_ref = &app
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) container() &VSlimContainer {
	if app.container_ref == unsafe { nil } {
		app.container_ref = new_vslim_container()
	}
	app.container_ref.app_ref = &app
	app.sync_standard_services_to_container()
	return app.container_ref
}

@[php_method]
pub fn (app &VSlimApp) has_config() bool {
	return app.config_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_config(config &VSlimConfig) &VSlimApp {
	app.config_ref = config
	configure_default_auth_settings(mut app, app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) config() &VSlimConfig {
	if app.config_ref == unsafe { nil } {
		mut created := &VSlimConfig{}
		created.construct()
		app.config_ref = created
		configure_default_auth_settings(mut app, app.config_ref)
		app.sync_standard_services_to_container()
	}
	return app.config_ref
}

@[php_method]
pub fn (mut app VSlimApp) load_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.load(path)
	configure_default_auth_settings(mut app, app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) load_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.load_text(text)
	configure_default_auth_settings(mut app, app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) merge_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.merge_file(path)
	configure_default_auth_settings(mut app, app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) merge_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.merge_text(text)
	configure_default_auth_settings(mut app, app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) validate(data vphp.RequestBorrowedZBox, rules vphp.RequestBorrowedZBox) &VSlimValidator {
	mut validator := VSlimValidator.make(data, rules)
	validator.validate()
	return validator
}

@[php_method]
pub fn (app &VSlimApp) session(request vphp.RequestBorrowedZBox) &VSlimSessionStore {
	mut session := &VSlimSessionStore{}
	session.construct()
	configure_default_session_store(mut session, app.config_ref)
	session.load(request)
	return session
}

@[php_method]
pub fn (app &VSlimApp) auth(request vphp.RequestBorrowedZBox) &VSlimAuthSessionGuard {
	mut session := app.session(request)
	mut guard := &VSlimAuthSessionGuard{}
	guard.construct()
	guard.set_store(session)
	configure_default_auth_guard(mut guard, app.config_ref)
	return guard
}

@[php_method: 'setAuthUserResolver']
pub fn (mut app VSlimApp) set_auth_user_resolver(resolver vphp.RequestBorrowedZBox) &VSlimApp {
	if !resolver.is_valid() || !resolver.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'auth user resolver must be callable',
			0)
		return &app
	}
	mut old := app.auth_user_resolver
	old.release()
	app.auth_user_resolver = vphp.PersistentOwnedZBox.from_callable_zval(resolver.to_zval())
	return &app
}

@[php_method: 'setAuthGateResolver']
pub fn (mut app VSlimApp) set_auth_gate_resolver(resolver vphp.RequestBorrowedZBox) &VSlimApp {
	if !resolver.is_valid() || !resolver.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'auth gate resolver must be callable',
			0)
		return &app
	}
	mut old := app.auth_gate_resolver
	old.release()
	app.auth_gate_resolver = vphp.PersistentOwnedZBox.from_callable_zval(resolver.to_zval())
	return &app
}

@[php_method: 'setAuthRedirectTo']
pub fn (mut app VSlimApp) set_auth_redirect_path(path string) &VSlimApp {
	app.auth_redirect_path = path.trim_space()
	return &app
}

@[php_method: 'authRedirectTo']
pub fn (app &VSlimApp) auth_redirect_to() string {
	return app.auth_redirect_path.trim_space()
}

@[php_method: 'authUser']
pub fn (app &VSlimApp) auth_user(request vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	mut guard := app.auth(request)
	if !guard.check() {
		return vphp.RequestOwnedZBox.new_null()
	}
	user_id := guard.id()
	if !app.auth_user_resolver.is_valid() || !app.auth_user_resolver.is_callable() {
		return vphp.RequestOwnedZBox.new_string(user_id)
	}
	mut result := app.auth_user_resolver.call_request_owned([
		vphp.RequestOwnedZBox.new_string(user_id).to_zval(),
	])
	return result
}

@[php_method: 'authCheck']
pub fn (app &VSlimApp) auth_check(request vphp.RequestBorrowedZBox) bool {
	mut guard := app.auth(request)
	return guard.check()
}

@[php_method: 'authGuest']
pub fn (app &VSlimApp) auth_guest(request vphp.RequestBorrowedZBox) bool {
	mut guard := app.auth(request)
	return guard.guest()
}

@[php_method: 'authId']
pub fn (app &VSlimApp) auth_id(request vphp.RequestBorrowedZBox) string {
	mut guard := app.auth(request)
	return guard.id()
}

@[php_method]
pub fn (app &VSlimApp) can(ability string, request vphp.RequestBorrowedZBox) bool {
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
	mut result := app.auth_gate_resolver.call_request_owned([
		vphp.RequestOwnedZBox.new_string(ability).to_zval(),
		user.to_zval(),
		request.to_zval(),
	])
	defer {
		result.release()
	}
	return result.to_zval().to_bool()
}

@[php_method]
pub fn (app &VSlimApp) cannot(ability string, request vphp.RequestBorrowedZBox) bool {
	return !app.can(ability, request)
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'startSessionMiddleware']
pub fn (app &VSlimApp) start_session_middleware() &VSlimSessionStartMiddleware {
	return &VSlimSessionStartMiddleware{
		app_ref: app
	}
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'authMiddleware']
pub fn (app &VSlimApp) auth_middleware() &VSlimAuthRequireMiddleware {
	return &VSlimAuthRequireMiddleware{
		app_ref:       app
		redirect_path: app.auth_redirect_path.trim_space()
	}
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'guestMiddleware']
pub fn (app &VSlimApp) guest_middleware() &VSlimAuthGuestMiddleware {
	return &VSlimAuthGuestMiddleware{
		app_ref:       app
		redirect_path: app.auth_redirect_path.trim_space()
	}
}

@[php_return_type: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_method: 'abilityMiddleware']
pub fn (app &VSlimApp) ability_middleware(ability string) &VSlimAuthRequireAbilityMiddleware {
	return &VSlimAuthRequireAbilityMiddleware{
		app_ref: app
		ability: ability.trim_space()
		status:  403
		message: 'Forbidden'
	}
}

@[php_optional_args: 'error_code']
@[php_method: 'errorResponse']
pub fn (app &VSlimApp) error_response(status int, message string, error_code string) &VSlimResponse {
	code := if error_code.trim_space() == '' { 'runtime_error' } else { error_code.trim_space() }
	return to_vslim_response(default_error_response(app, status, message, code))
}

@[php_optional_args: 'status']
@[php_method: 'validationError']
pub fn (app &VSlimApp) validation_error(errors vphp.RequestBorrowedZBox, status int) &VSlimResponse {
	error_status := if status <= 0 { 422 } else { status }
	json_body := '{"ok":false,"code":"validation_error","error":"validation_error","status":${error_status},"message":"Validation failed","errors":${zval_to_json_fragment(errors.to_zval())}}'
	return to_vslim_response(json_response(error_status, json_body))
}

@[php_optional_args: 'message']
@[php_method: 'unauthorized']
pub fn (app &VSlimApp) unauthorized_response(message string) &VSlimResponse {
	msg := if message.trim_space() == '' { 'Unauthorized' } else { message }
	return to_vslim_response(default_error_response(app, 401, msg, 'unauthorized'))
}

@[php_optional_args: 'message']
@[php_method: 'forbidden']
pub fn (app &VSlimApp) forbidden_response(message string) &VSlimResponse {
	msg := if message.trim_space() == '' { 'Forbidden' } else { message }
	return to_vslim_response(default_error_response(app, 403, msg, 'forbidden'))
}

@[php_optional_args: 'fallback_status']
@[php_method: 'exceptionResponse']
pub fn (app &VSlimApp) exception_response(exception vphp.RequestBorrowedZBox, fallback_status int) &VSlimResponse {
	status := if fallback_status >= 400 && fallback_status <= 599 { fallback_status } else { 500 }
	resolved_status := exception_status_code(exception, status)
	message := exception_message_value(exception, 'Internal Server Error')
	code := exception_error_code(exception)
	return to_vslim_response(default_error_response(app, resolved_status, message, code))
}

@[php_method: 'doctor']
pub fn (mut app VSlimApp) doctor_report() map[string]string {
	config_loaded := app.has_config() && app.config().is_loaded()
	mut transport := ''
	if app.has_database() || (app.config_ref != unsafe { nil } && app.config_ref.has('database.driver')) {
		transport = app.database().transport()
	}
	session_configured := if app.config_ref != unsafe { nil } {
		if app.config_ref.has('session.cookie') || app.config_ref.has('session.secret') { 'true' } else { 'false' }
	} else {
		'false'
	}
	return {
		'config_loaded':         if config_loaded { 'true' } else { 'false' }
		'config_path':           if app.has_config() { app.config().path() } else { '' }
		'route_count':           app.route_count().str()
		'provider_count':        app.provider_count().str()
		'module_count':          app.module_count().str()
		'database_transport':    transport
		'error_response_json':   if app.error_response_json_enabled() { 'true' } else { 'false' }
		'auth_redirect_to':      app.auth_redirect_to()
		'session_configured':    session_configured
		'auth_resolver_defined': if app.auth_user_resolver.is_valid() && app.auth_user_resolver.is_callable() { 'true' } else { 'false' }
	}
}

fn (app &VSlimApp) migrator_project_root() string {
	if app.config_ref != unsafe { nil } {
		mut config_path := app.config_ref.path().trim_space()
		if config_path != '' {
			config_path = config_path.trim_right('/\\')
			if php_is_dir(config_path) {
				if config_path.ends_with('/config') || config_path.ends_with('\\config') {
					return os.dir(config_path)
				}
				return config_path
			}
			config_dir := os.dir(config_path)
			if config_dir.ends_with('/config') || config_dir.ends_with('\\config') {
				return os.dir(config_dir)
			}
			return config_dir
		}
	}
	return os.getwd()
}

fn (mut app VSlimApp) sync_standard_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	app.container_ref.app_ref = &app
}

fn (mut app VSlimApp) sync_config_service_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_clock_service_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_logger_services_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_event_services_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_cache_services_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_http_client_service_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_database_service_to_container() {
	app.sync_standard_services_to_container()
}

fn configure_default_app_logger(mut logger VSlimLogger, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('logging.channel') {
		logger.set_channel(config.get_string('logging.channel', logger.channel()))
	}
	if config.has('logging.level') {
		logger.set_level(config.get_string('logging.level', logger.level()))
	}
	if config.has('logging.output_file') {
		output_file := config.get_string('logging.output_file', '').trim_space()
		if output_file != '' {
			logger.set_output_file(output_file)
		}
	}
	if config.has('logging.target') {
		target := config.get_string('logging.target', '').trim_space().to_lower()
		match target {
			'stdout' {
				logger.console_target = 'stdout'
				reconfigure_vslim_logger(mut logger)
			}
			'stderr' {
				logger.console_target = 'stderr'
				reconfigure_vslim_logger(mut logger)
			}
			'file' {
				logger.console_target = ''
				reconfigure_vslim_logger(mut logger)
			}
			else {}
		}
	}
}

fn configure_default_http_client(mut client VSlimPsr18Client, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('http.client.timeout_seconds') {
		client.timeout(config.get_int('http.client.timeout_seconds', client.timeout_seconds_value()))
	}
}

fn configure_default_simple_cache(mut cache VSlimPsr16Cache, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('cache.prefix') {
		cache.set_namespace(config.get_string('cache.prefix', cache.namespace()))
	}
	if config.has('cache.default_ttl_seconds') {
		cache.set_default_ttl_seconds(config.get_int('cache.default_ttl_seconds',
			cache.default_ttl_seconds_value()))
	}
}

fn configure_default_cache_pool(mut pool VSlimPsr6CacheItemPool, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('cache.pool.prefix') {
		pool.set_namespace(config.get_string('cache.pool.prefix', pool.namespace()))
	} else if config.has('cache.prefix') {
		pool.set_namespace(config.get_string('cache.prefix', pool.namespace()))
	}
	if config.has('cache.pool.default_ttl_seconds') {
		pool.set_default_ttl_seconds(config.get_int('cache.pool.default_ttl_seconds',
			pool.default_ttl_seconds_value()))
	} else if config.has('cache.default_ttl_seconds') {
		pool.set_default_ttl_seconds(config.get_int('cache.default_ttl_seconds',
			pool.default_ttl_seconds_value()))
	}
}

fn configure_default_database_service(mut db VSlimDatabaseManager, config &VSlimConfig) {
	configure_default_database_manager(mut db, config)
}

fn configure_default_session_store(mut session VSlimSessionStore, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('session.cookie') {
		session.set_cookie_name(config.get_string('session.cookie', session.cookie_name_value()))
	}
	if config.has('session.secret') {
		session.set_secret(config.get_string('session.secret', session.secret_value()))
	} else if config.has('app.key') {
		session.set_secret(config.get_string('app.key', session.secret_value()))
	}
	if config.has('session.ttl_seconds') {
		session.set_ttl_seconds(config.get_int('session.ttl_seconds', session.ttl_seconds_value()))
	}
	if config.has('session.path') {
		session.set_path(config.get_string('session.path', session.path_value()))
	}
	if config.has('session.domain') {
		session.set_domain(config.get_string('session.domain', session.domain_value()))
	}
	if config.has('session.secure') {
		session.set_secure(config.get_bool('session.secure', session.secure_value()))
	}
	if config.has('session.http_only') {
		session.set_http_only(config.get_bool('session.http_only', session.http_only_value()))
	}
	if config.has('session.same_site') {
		session.set_same_site(config.get_string('session.same_site', session.same_site_value()))
	}
}

fn configure_default_auth_guard(mut guard VSlimAuthSessionGuard, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('auth.session_key') {
		guard.set_user_key(config.get_string('auth.session_key', guard.user_key_value()))
	}
}

fn configure_default_auth_settings(mut app VSlimApp, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('auth.redirect_to') {
		app.auth_redirect_path = config.get_string('auth.redirect_to', app.auth_redirect_to()).trim_space()
	}
}

fn (mut app VSlimApp) sync_clock_dependent_services() {
	clock_value := vphp.borrow_zbox(app.clock().to_zval())
	if app.cache_ref != unsafe { nil } {
		app.cache_ref.set_clock(clock_value)
	}
	if app.cache_pool_ref != unsafe { nil } {
		app.cache_pool_ref.set_clock(clock_value)
	}
}

@[php_method]
pub fn (app &VSlimApp) has_mcp() bool {
	return app.mcp_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_mcp(mcp &VSlimMcpApp) &VSlimApp {
	app.mcp_ref = mcp
	return app
}

@[php_method]
pub fn (mut app VSlimApp) mcp() &VSlimMcpApp {
	if app.mcp_ref == unsafe { nil } {
		mut created := &VSlimMcpApp{}
		created.construct()
		app.mcp_ref = created
	}
	return app.mcp_ref
}

@[php_method]
pub fn (app &VSlimApp) handle_mcp_dispatch(frame vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if app.mcp_ref == unsafe { nil } {
		return vphp.RequestOwnedZBox.new_null()
	}
	return app.mcp_ref.handle_mcp_dispatch(frame)
}

@[php_method]
pub fn (app &VSlimApp) has_logger() bool {
	return app.logger_ref != unsafe { nil }
}

@[php_arg_type: 'clock=Psr\\Clock\\ClockInterface']
@[php_method: 'setClock']
pub fn (mut app VSlimApp) set_clock(clock vphp.RequestBorrowedZBox) &VSlimApp {
	if !psr20_is_clock(clock.to_zval()) {
		vphp.throw_exception_class('InvalidArgumentException', 'clock must implement Psr\\Clock\\ClockInterface',
			0)
		return app
	}
	mut old := app.clock_ref
	old.release()
	app.clock_ref = vphp.PersistentOwnedZBox.from_object_zval(clock.to_zval())
	app.sync_clock_dependent_services()
	app.sync_clock_service_to_container()
	return app
}

@[php_return_type: 'Psr\\Clock\\ClockInterface']
@[php_method]
pub fn (mut app VSlimApp) clock() vphp.RequestOwnedZBox {
	if !psr20_is_clock(app.clock_ref.to_zval()) {
		mut old := app.clock_ref
		old.release()
		app.clock_ref = new_psr20_system_clock_ref()
		app.sync_clock_service_to_container()
	}
	return app.clock_ref.clone_request_owned()
}

@[php_method]
pub fn (mut app VSlimApp) set_logger(logger &VSlimLogger) &VSlimApp {
	app.logger_ref = logger
	if app.psr_logger_ref != unsafe { nil } {
		app.psr_logger_ref.set_logger(logger)
	}
	app.sync_logger_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) logger() &VSlimLogger {
	if app.logger_ref == unsafe { nil } {
		mut created := &VSlimLogger{}
		created.construct()
		created.set_channel('vslim.app')
		configure_default_app_logger(mut created, app.config_ref)
		app.logger_ref = created
	}
	return app.logger_ref
}

@[php_return_type: 'Psr\\Log\\LoggerInterface']
@[php_method: 'psrLogger']
pub fn (mut app VSlimApp) psr_logger() &VSlimPsrLogger {
	if app.psr_logger_ref == unsafe { nil } {
		mut created := &VSlimPsrLogger{}
		created.construct()
		created.set_logger(app.logger())
		app.psr_logger_ref = created
	} else {
		app.psr_logger_ref.set_logger(app.logger())
	}
	return app.psr_logger_ref
}

@[php_arg_type: 'provider=Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'setListenerProvider']
pub fn (mut app VSlimApp) set_listener_provider(provider &VSlimPsr14ListenerProvider) &VSlimApp {
	app.listener_provider_ref = provider
	if app.dispatcher_ref != unsafe { nil } {
		app.dispatcher_ref.set_provider(provider)
	}
	app.sync_event_services_to_container()
	return app
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'listenerProvider']
pub fn (mut app VSlimApp) listener_provider() &VSlimPsr14ListenerProvider {
	if app.listener_provider_ref == unsafe { nil } {
		mut created := &VSlimPsr14ListenerProvider{}
		created.construct()
		app.listener_provider_ref = created
	}
	if app.dispatcher_ref != unsafe { nil } {
		app.dispatcher_ref.set_provider(app.listener_provider_ref)
	}
	return app.listener_provider_ref
}

@[php_arg_type: 'dispatcher=Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method: 'setDispatcher']
pub fn (mut app VSlimApp) set_dispatcher(dispatcher &VSlimPsr14EventDispatcher) &VSlimApp {
	app.dispatcher_ref = dispatcher
	unsafe {
		mut writable := &VSlimPsr14EventDispatcher(dispatcher)
		app.listener_provider_ref = writable.provider()
	}
	app.sync_event_services_to_container()
	return app
}

@[php_return_type: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method]
pub fn (mut app VSlimApp) dispatcher() &VSlimPsr14EventDispatcher {
	if app.dispatcher_ref == unsafe { nil } {
		mut created := &VSlimPsr14EventDispatcher{}
		created.construct()
		created.set_provider(app.listener_provider())
		app.dispatcher_ref = created
	} else {
		app.dispatcher_ref.set_provider(app.listener_provider())
	}
	return app.dispatcher_ref
}

@[php_return_type: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method: 'events']
pub fn (mut app VSlimApp) events() &VSlimPsr14EventDispatcher {
	return app.dispatcher()
}

@[php_arg_type: 'cache=Psr\\SimpleCache\\CacheInterface']
@[php_method: 'setCache']
pub fn (mut app VSlimApp) set_cache(cache &VSlimPsr16Cache) &VSlimApp {
	unsafe {
		mut writable := &VSlimPsr16Cache(cache)
		writable.set_clock(vphp.borrow_zbox(app.clock().to_zval()))
	}
	app.cache_ref = cache
	app.sync_cache_services_to_container()
	return app
}

@[php_return_type: 'Psr\\SimpleCache\\CacheInterface']
@[php_method]
pub fn (mut app VSlimApp) cache() &VSlimPsr16Cache {
	if app.cache_ref == unsafe { nil } {
		mut created := &VSlimPsr16Cache{}
		created.construct()
		created.set_clock(vphp.borrow_zbox(app.clock().to_zval()))
		configure_default_simple_cache(mut created, app.config_ref)
		app.cache_ref = created
	}
	return app.cache_ref
}

@[php_arg_type: 'pool=Psr\\Cache\\CacheItemPoolInterface']
@[php_method: 'setCachePool']
pub fn (mut app VSlimApp) set_cache_pool(pool &VSlimPsr6CacheItemPool) &VSlimApp {
	unsafe {
		mut writable := &VSlimPsr6CacheItemPool(pool)
		writable.set_clock(vphp.borrow_zbox(app.clock().to_zval()))
	}
	app.cache_pool_ref = pool
	app.sync_cache_services_to_container()
	return app
}

@[php_return_type: 'Psr\\Cache\\CacheItemPoolInterface']
@[php_method: 'cachePool']
pub fn (mut app VSlimApp) cache_pool() &VSlimPsr6CacheItemPool {
	if app.cache_pool_ref == unsafe { nil } {
		mut created := &VSlimPsr6CacheItemPool{}
		created.construct()
		created.set_clock(vphp.borrow_zbox(app.clock().to_zval()))
		configure_default_cache_pool(mut created, app.config_ref)
		app.cache_pool_ref = created
	}
	return app.cache_pool_ref
}

@[php_arg_type: 'client=Psr\\Http\\Client\\ClientInterface']
@[php_method: 'setHttpClient']
pub fn (mut app VSlimApp) set_http_client(client &VSlimPsr18Client) &VSlimApp {
	app.http_client_ref = client
	app.sync_http_client_service_to_container()
	return app
}

@[php_return_type: 'Psr\\Http\\Client\\ClientInterface']
@[php_method: 'httpClient']
pub fn (mut app VSlimApp) http_client() &VSlimPsr18Client {
	if app.http_client_ref == unsafe { nil } {
		mut created := &VSlimPsr18Client{}
		created.construct()
		configure_default_http_client(mut created, app.config_ref)
		app.http_client_ref = created
	}
	return app.http_client_ref
}

@[php_method: 'hasDatabase']
pub fn (app &VSlimApp) has_database() bool {
	return app.database_ref != unsafe { nil }
}

@[php_method: 'setDatabase']
pub fn (mut app VSlimApp) set_database(database &VSlimDatabaseManager) &VSlimApp {
	app.database_ref = database
	app.sync_database_service_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) database() &VSlimDatabaseManager {
	if app.database_ref == unsafe { nil } {
		mut created := &VSlimDatabaseManager{}
		created.construct()
		configure_default_database_service(mut created, app.config_ref)
		app.database_ref = created
	}
	return app.database_ref
}

@[php_method]
pub fn (mut app VSlimApp) db() &VSlimDatabaseManager {
	return app.database()
}

@[php_method]
pub fn (app &VSlimApp) has_migrator() bool {
	return app.migrator_ref != unsafe { nil }
}

@[php_method: 'setMigrator']
pub fn (mut app VSlimApp) set_migrator(migrator &VSlimDatabaseMigrator) &VSlimApp {
	app.migrator_ref = migrator
	app.migrator_ref.set_manager(app.database())
	root := app.migrator_project_root()
	app.migrator_ref.set_migrations_path(path_join(root, 'database/migrations'))
	app.migrator_ref.set_seeds_path(path_join(root, 'database/seeds'))
	return &app
}

@[php_method]
pub fn (mut app VSlimApp) migrator() &VSlimDatabaseMigrator {
	if app.migrator_ref == unsafe { nil } {
		mut created := &VSlimDatabaseMigrator{}
		created.construct()
		app.migrator_ref = created
	}
	app.migrator_ref.set_manager(app.database())
	root := app.migrator_project_root()
	app.migrator_ref.set_migrations_path(path_join(root, 'database/migrations'))
	app.migrator_ref.set_seeds_path(path_join(root, 'database/seeds'))
	return app.migrator_ref
}
