module appx

import configx as cfgx
import databasex
import errorx
import fsx
import httpx
import os
import sessionx
import vphp

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_name: 'error_code=errorCode']
@[php_arg_default: 'error_code=""']
@[php_method: 'errorResponse']
@[php_arg_optional: 'error_code']
pub fn (app &VSlimApp) error_response(status int, message string, error_code string) &httpx.VSlimPsr7Response {
	code := if error_code.trim_space() == '' { 'runtime_error' } else { error_code.trim_space() }
	return app.default_error_response(status, message, code).to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'validationError']
@[php_arg_default: 'status=422']
@[php_arg_optional: 'status']
pub fn (app &VSlimApp) validation_error(errors vphp.PhpValue, status int) &httpx.VSlimPsr7Response {
	error_status := if status <= 0 { 422 } else { status }
	json_body := errorx.validation_error_json_body(error_status, errors)
	return httpx.VSlimResponse.json(error_status, json_body).to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'message="Unauthorized"']
@[php_method: 'unauthorized']
@[php_arg_optional: 'message']
pub fn (app &VSlimApp) unauthorized_response(message string) &httpx.VSlimPsr7Response {
	msg := if message.trim_space() == '' { 'Unauthorized' } else { message }
	return app.default_error_response(401, msg, 'unauthorized').to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'message="Forbidden"']
@[php_method: 'forbidden']
@[php_arg_optional: 'message']
pub fn (app &VSlimApp) forbidden_response(message string) &httpx.VSlimPsr7Response {
	msg := if message.trim_space() == '' { 'Forbidden' } else { message }
	return app.default_error_response(403, msg, 'forbidden').to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'message="Bad Request"']
@[php_method: 'badRequest']
@[php_arg_optional: 'message']
pub fn (app &VSlimApp) bad_request_response(message string) &httpx.VSlimPsr7Response {
	msg := if message.trim_space() == '' { 'Bad Request' } else { message }
	return app.default_error_response(400, msg, 'bad_request').to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'message="Not Found"']
@[php_method: 'notFound']
@[php_arg_optional: 'message']
pub fn (app &VSlimApp) not_found_response_helper(message string) &httpx.VSlimPsr7Response {
	msg := if message.trim_space() == '' { 'Not Found' } else { message }
	return app.default_error_response(404, msg, 'not_found').to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'message="Conflict"']
@[php_method: 'conflict']
@[php_arg_optional: 'message']
pub fn (app &VSlimApp) conflict_response(message string) &httpx.VSlimPsr7Response {
	msg := if message.trim_space() == '' { 'Conflict' } else { message }
	return app.default_error_response(409, msg, 'conflict').to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'message="Service Unavailable"']
@[php_method: 'serviceUnavailable']
@[php_arg_optional: 'message']
pub fn (app &VSlimApp) service_unavailable_response(message string) &httpx.VSlimPsr7Response {
	msg := if message.trim_space() == '' { 'Service Unavailable' } else { message }
	return app.default_error_response(503, msg, 'service_unavailable').to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_name: 'fallback_status=fallbackStatus']
@[php_arg_default: 'fallback_status=500']
@[php_method: 'exceptionResponse']
@[php_arg_optional: 'fallback_status']
pub fn (app &VSlimApp) exception_response(exception vphp.PhpObject, fallback_status int) &httpx.VSlimPsr7Response {
	status := if fallback_status >= 400 && fallback_status <= 599 { fallback_status } else { 500 }
	resolved_status := errorx.exception_status_code(exception, status)
	message := errorx.exception_message_value(exception, 'Internal Server Error')
	code := errorx.exception_error_code(exception)
	return app.default_error_response(resolved_status, message, code).to_psr7_response()
}

@[php_method: 'doctor']
pub fn (mut app VSlimApp) doctor_report() map[string]string {
	mut cfg_ref := &cfgx.VSlimConfig(unsafe { nil })
	if app.has_config() {
		cfg_ref = app.config()
	}
	config_loaded := cfg_ref != unsafe { nil } && cfg_ref.is_loaded()
	config_path := if cfg_ref != unsafe { nil } { cfg_ref.path() } else { '' }
	config_mode := if config_path.trim_space() == '' {
		'none'
	} else if fsx.is_dir(config_path) {
		'dir'
	} else {
		'file'
	}
	mut database_report := databasex.empty_database_diagnostics()
	if app.has_database() || (cfg_ref != unsafe { nil } && cfg_ref.has('database.driver')) {
		mut db := app.database()
		database_report = db.diagnostics(cfg_ref)
	}
	session_report := sessionx.session_diagnostics(cfg_ref)
	auth_provider_defined := if app.has_auth_user_provider() { 'true' } else { 'false' }
	return {
		'config_loaded':                   if config_loaded {
			'true'
		} else {
			'false'
		}
		'config_path':                     config_path
		'config_mode':                     config_mode
		'route_count':                     app.route_count().str()
		'provider_count':                  app.provider_count().str()
		'module_count':                    app.module_count().str()
		'database_transport':              database_report['database_transport']
		'database_driver':                 database_report['database_driver']
		'database_pool_name':              database_report['database_pool_name']
		'database_upstream_socket':        database_report['database_upstream_socket']
		'database_upstream_socket_source': database_report['database_upstream_socket_source']
		'error_response_json':             if app.error_response_json_enabled() {
			'true'
		} else {
			'false'
		}
		'auth_redirect_to':                app.auth_redirect_to()
		'session_cookie':                  session_report['session_cookie']
		'session_secret_configured':       session_report['session_secret_configured']
		'session_secret_placeholder':      session_report['session_secret_placeholder']
		'session_configured':              session_report['session_configured']
		'auth_user_provider_defined':      auth_provider_defined
		'auth_resolver_defined':           if app.auth_user_resolver.is_valid()
			&& app.auth_user_resolver.is_callable() {
			'true'
		} else {
			'false'
		}
	}
}

fn (app &VSlimApp) migrator_project_root() string {
	if app.config_ref != unsafe { nil } {
		mut config_path := app.config_ref.path().trim_space()
		if config_path != '' {
			config_path = config_path.trim_right('/\\')
			if fsx.is_dir(config_path) {
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
