module main

import vphp

const session_flash_prefix = '__flash__.'

fn effective_auth_middleware_app(app_ref &VSlimApp) &VSlimApp {
	runtime := current_runtime_dispatch_app()
	if runtime != unsafe { nil } {
		return runtime
	}
	return app_ref
}

fn auth_request_with_attribute(request vphp.RequestBorrowedZBox, name string, value vphp.ZVal) vphp.RequestOwnedZBox {
	raw_request := request.to_zval()
	if raw_request.is_valid() && raw_request.is_object()
		&& raw_request.method_exists('withAttribute') {
		mut out := vphp.PhpObject.borrowed(raw_request).method_request_owned('withAttribute',
			vphp.PhpString.of(name), vphp.PhpValue.from_zval(value))
		return out
	}
	return request.clone_request_owned()
}

fn auth_unauthorized_psr_response(app &VSlimApp, redirect_path string) &VSlimPsr7Response {
	if redirect_path.trim_space() != '' {
		mut redirect := VSlimResponse{
			status:       302
			body:         ''
			content_type: 'text/plain; charset=utf-8'
			headers:      {
				'content-type': 'text/plain; charset=utf-8'
			}
		}
		redirect.redirect(redirect_path.trim_space())
		return new_psr7_response_from_vslim_response(redirect)
	}
	return default_error_response_psr(app, 401, 'Unauthorized', 'unauthorized')
}

fn auth_guest_redirect_psr_response(redirect_path string) &VSlimPsr7Response {
	target := if redirect_path.trim_space() == '' { '/' } else { redirect_path.trim_space() }
	mut redirect := VSlimResponse{
		status:       302
		body:         ''
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type': 'text/plain; charset=utf-8'
		}
	}
	redirect.redirect(target)
	return new_psr7_response_from_vslim_response(redirect)
}

fn session_cookie_header_value(session &VSlimSessionStore) string {
	if session.destroyed {
		return build_set_cookie_header(session.cookie_name_value(), '', session.path_value(),
			session.domain_value(), -1, session.secure_value(), session.http_only_value(),
			session.same_site_value())
	}
	return build_set_cookie_header(session.cookie_name_value(), session_encode_values(session.values,
		session.secret_value()), session.path_value(), session.domain_value(), session.ttl_seconds_value(),
		session.secure_value(), session.http_only_value(), session.same_site_value())
}

fn session_commit_psr_response(mut session VSlimSessionStore, response &VSlimPsr7Response) &VSlimPsr7Response {
	if !session.dirty && !session.destroyed {
		return response
	}
	mut headers := clone_header_values(response.headers)
	mut header_names := clone_header_names(response.header_names)
	headers['set-cookie'] = [session_cookie_header_value(session)]
	header_names['set-cookie'] = 'Set-Cookie'
	session.dirty = false
	return clone_psr7_response(response, response.protocol_version, headers, header_names,
		response_body_or_empty(response), response.status, response.reason_phrase)
}

fn session_new_string_map_zval(values map[string]string) vphp.ZVal {
	mut out := vphp.ZVal.new_null()
	out.array_init()
	for key, value in values {
		out.add_assoc_string(key, value)
	}
	return out
}

fn session_base64url_encode(raw string) string {
	mut encoded := vphp.PhpFunction.named('base64_encode').result_string(vphp.PhpString.of(raw))
	encoded = encoded.replace('+', '-').replace('/', '_').replace('=', '')
	return encoded
}

fn session_base64url_decode(raw string) !string {
	if raw.trim_space() == '' {
		return ''
	}
	mut normalized := raw.replace('-', '+').replace('_', '/')
	padding := normalized.len % 4
	if padding > 0 {
		normalized += '='.repeat(4 - padding)
	}
	mut decoded := vphp.PhpFunction.named('base64_decode').request_owned(vphp.PhpString.of(normalized),
		vphp.PhpBool.of(true))
	defer {
		decoded.release()
	}
	if !decoded.is_valid() || decoded.is_null() || decoded.is_undef() {
		return error('invalid base64 payload')
	}
	if decoded.to_zval().is_bool() && !decoded.to_bool() {
		return error('invalid base64 payload')
	}
	return decoded.to_string()
}

fn session_sign(payload string, secret string) string {
	return vphp.PhpFunction.named('hash_hmac').result_string(vphp.PhpString.of('sha256'),
		vphp.PhpString.of(payload), vphp.PhpString.of(secret))
}

fn session_secure_equals(left string, right string) bool {
	return vphp.PhpFunction.named('hash_equals').result_bool(vphp.PhpString.of(left),
		vphp.PhpString.of(right))
}

fn session_encode_values(values map[string]string, secret string) string {
	mut payload_z := session_new_string_map_zval(values)
	payload_json := vphp.PhpJson.encode(payload_z)
	payload_z.release()
	payload_b64 := session_base64url_encode(payload_json)
	if secret.trim_space() == '' {
		return payload_b64
	}
	return '${payload_b64}.${session_sign(payload_b64, secret)}'
}

fn session_decode_values(raw string, secret string) map[string]string {
	token := raw.trim_space()
	if token == '' {
		return map[string]string{}
	}
	mut payload_b64 := token
	if token.contains('.') {
		parts := token.split_nth('.', 2)
		if parts.len != 2 {
			return map[string]string{}
		}
		payload_b64 = parts[0]
		signature := parts[1]
		if secret.trim_space() != '' {
			expected := session_sign(payload_b64, secret)
			if !session_secure_equals(expected, signature) {
				return map[string]string{}
			}
		}
	}
	payload_json := session_base64url_decode(payload_b64) or { return map[string]string{} }
	mut decoded := vphp.PhpJson.decode_assoc(payload_json)
	defer {
		decoded.release()
	}
	if !decoded.is_valid() || !decoded.is_array() {
		return map[string]string{}
	}
	return decoded.to_string_map()
}

fn session_request_cookie(request vphp.RequestBorrowedZBox, cookie_name string) string {
	raw_request := request.to_zval()
	if !raw_request.is_valid() {
		return ''
	}
	if raw_request.is_object() {
		if raw_request.method_exists('cookie') {
			mut out := vphp.PhpObject.borrowed(raw_request).method_request_owned('cookie',
				vphp.PhpString.of(cookie_name))
			defer {
				out.release()
			}
			return out.to_zval().to_string()
		}
		if raw_request.method_exists('getCookieParams') {
			mut out := vphp.PhpObject.borrowed(raw_request).method_request_owned('getCookieParams')
			defer {
				out.release()
			}
			return out.to_zval().to_string_map()[cookie_name] or { '' }
		}
		if raw_request.method_exists('cookies') {
			mut out := vphp.PhpObject.borrowed(raw_request).method_request_owned('cookies')
			defer {
				out.release()
			}
			return out.to_zval().to_string_map()[cookie_name] or { '' }
		}
	}
	if raw_request.is_array() {
		cookies_z := raw_request.get('cookies') or { return '' }
		if cookies_z.is_valid() && cookies_z.is_array() {
			return cookies_z.to_string_map()[cookie_name] or { '' }
		}
	}
	return ''
}

fn session_commit_cookie(mut session VSlimSessionStore, response vphp.RequestBorrowedZBox) bool {
	raw_response := response.to_zval()
	if !raw_response.is_valid() || !raw_response.is_object() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'session response must be an object',
			0)
		return false
	}
	if session.destroyed {
		if raw_response.method_exists('deleteCookie') {
			vphp.PhpObject.borrowed(raw_response).with_method_result_zval('deleteCookie',
				fn (_ vphp.ZVal) bool {
				return true
			}, vphp.RequestOwnedZBox.new_string(session.cookie_name_value()).to_zval())
			session.dirty = false
			return true
		}
		if raw_response.method_exists('delete_cookie') {
			vphp.PhpObject.borrowed(raw_response).with_method_result_zval('delete_cookie',
				fn (_ vphp.ZVal) bool {
				return true
			}, vphp.RequestOwnedZBox.new_string(session.cookie_name_value()).to_zval())
			session.dirty = false
			return true
		}
		vphp.PhpException.raise_class('RuntimeException', 'response does not support delete_cookie()',
			0)
		return false
	}
	if !session.dirty {
		return true
	}
	if raw_response.method_exists('setCookieFull') {
		vphp.PhpObject.borrowed(raw_response).with_method_result_zval('setCookieFull',
			fn (_ vphp.ZVal) bool {
			return true
		}, vphp.RequestOwnedZBox.new_string(session.cookie_name_value()).to_zval(), vphp.RequestOwnedZBox.new_string(session_encode_values(session.values,
			session.secret_value())).to_zval(), vphp.RequestOwnedZBox.new_string(session.path_value()).to_zval(),
			vphp.RequestOwnedZBox.new_string(session.domain_value()).to_zval(), vphp.RequestOwnedZBox.new_int(session.ttl_seconds_value()).to_zval(),
			vphp.RequestOwnedZBox.new_bool(session.secure_value()).to_zval(), vphp.RequestOwnedZBox.new_bool(session.http_only_value()).to_zval(),
			vphp.RequestOwnedZBox.new_string(session.same_site_value()).to_zval())
		session.dirty = false
		return true
	}
	if raw_response.method_exists('set_cookie_full') {
		vphp.PhpObject.borrowed(raw_response).with_method_result_zval('set_cookie_full',
			fn (_ vphp.ZVal) bool {
			return true
		}, vphp.RequestOwnedZBox.new_string(session.cookie_name_value()).to_zval(), vphp.RequestOwnedZBox.new_string(session_encode_values(session.values,
			session.secret_value())).to_zval(), vphp.RequestOwnedZBox.new_string(session.path_value()).to_zval(),
			vphp.RequestOwnedZBox.new_string(session.domain_value()).to_zval(), vphp.RequestOwnedZBox.new_int(session.ttl_seconds_value()).to_zval(),
			vphp.RequestOwnedZBox.new_bool(session.secure_value()).to_zval(), vphp.RequestOwnedZBox.new_bool(session.http_only_value()).to_zval(),
			vphp.RequestOwnedZBox.new_string(session.same_site_value()).to_zval())
		session.dirty = false
		return true
	}
	vphp.PhpException.raise_class('RuntimeException', 'response does not support set_cookie_full()',
		0)
	return false
}

@[php_method]
pub fn (mut session VSlimSessionStore) construct() &VSlimSessionStore {
	session.cookie_name = 'vslim_session'
	session.secret = ''
	session.ttl_seconds = 7200
	session.path = '/'
	session.domain = ''
	session.secure = false
	session.http_only = true
	session.same_site = 'lax'
	session.values = map[string]string{}
	session.loaded = false
	session.dirty = false
	session.destroyed = false
	return &session
}

@[php_method: 'setCookie']
pub fn (mut session VSlimSessionStore) set_cookie_name(name string) &VSlimSessionStore {
	clean := name.trim_space()
	if clean != '' {
		session.cookie_name = clean
	}
	return &session
}

@[php_method: 'cookie']
pub fn (session &VSlimSessionStore) cookie_name_value() string {
	if session.cookie_name.trim_space() == '' {
		return 'vslim_session'
	}
	return session.cookie_name.trim_space()
}

@[php_method: 'setSecret']
pub fn (mut session VSlimSessionStore) set_secret(secret string) &VSlimSessionStore {
	session.secret = secret.trim_space()
	return &session
}

@[php_method: 'secret']
pub fn (session &VSlimSessionStore) secret_value() string {
	return session.secret.trim_space()
}

@[php_arg_name: 'ttl_seconds=ttlSeconds']
@[php_method: 'setTtlSeconds']
pub fn (mut session VSlimSessionStore) set_ttl_seconds(ttl_seconds int) &VSlimSessionStore {
	if ttl_seconds >= 0 {
		session.ttl_seconds = ttl_seconds
	}
	return &session
}

@[php_method: 'ttlSeconds']
pub fn (session &VSlimSessionStore) ttl_seconds_value() int {
	if session.ttl_seconds < 0 {
		return 0
	}
	return session.ttl_seconds
}

@[php_method: 'setPath']
pub fn (mut session VSlimSessionStore) set_path(path string) &VSlimSessionStore {
	session.path = if path.trim_space() == '' { '/' } else { path.trim_space() }
	return &session
}

@[php_method: 'path']
pub fn (session &VSlimSessionStore) path_value() string {
	if session.path.trim_space() == '' {
		return '/'
	}
	return session.path.trim_space()
}

@[php_method: 'setDomain']
pub fn (mut session VSlimSessionStore) set_domain(domain string) &VSlimSessionStore {
	session.domain = domain.trim_space()
	return &session
}

@[php_method: 'domain']
pub fn (session &VSlimSessionStore) domain_value() string {
	return session.domain.trim_space()
}

@[php_method: 'setSecure']
pub fn (mut session VSlimSessionStore) set_secure(secure bool) &VSlimSessionStore {
	session.secure = secure
	return &session
}

@[php_method: 'secure']
pub fn (session &VSlimSessionStore) secure_value() bool {
	return session.secure
}

@[php_arg_name: 'http_only=httpOnly']
@[php_method: 'setHttpOnly']
pub fn (mut session VSlimSessionStore) set_http_only(http_only bool) &VSlimSessionStore {
	session.http_only = http_only
	return &session
}

@[php_method: 'httpOnly']
pub fn (session &VSlimSessionStore) http_only_value() bool {
	return session.http_only
}

@[php_arg_name: 'same_site=sameSite']
@[php_method: 'setSameSite']
pub fn (mut session VSlimSessionStore) set_same_site(same_site string) &VSlimSessionStore {
	session.same_site = same_site.trim_space().to_lower()
	return &session
}

@[php_method: 'sameSite']
pub fn (session &VSlimSessionStore) same_site_value() string {
	if session.same_site.trim_space() == '' {
		return 'lax'
	}
	return session.same_site.trim_space()
}

@[php_method]
pub fn (mut session VSlimSessionStore) load(request vphp.RequestBorrowedZBox) &VSlimSessionStore {
	session.values = session_decode_values(session_request_cookie(request, session.cookie_name_value()),
		session.secret_value())
	session.loaded = true
	session.destroyed = false
	return &session
}

@[php_method]
pub fn (session &VSlimSessionStore) all() map[string]string {
	return session.values.clone()
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=""']
@[php_arg_optional: 'default_value']
@[php_method]
pub fn (session &VSlimSessionStore) get(key string, default_value string) string {
	return session.values[key] or { default_value }
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=""']
@[php_arg_optional: 'default_value']
@[php_method]
pub fn (mut session VSlimSessionStore) pull(key string, default_value string) string {
	value := session.values[key] or { default_value }
	if key in session.values {
		session.values.delete(key)
		session.dirty = true
	}
	return value
}

@[php_method]
pub fn (mut session VSlimSessionStore) flash(key string, value string) &VSlimSessionStore {
	session.values['${session_flash_prefix}${key}'] = value
	session.dirty = true
	session.destroyed = false
	return &session
}

@[php_method: 'hasFlash']
pub fn (session &VSlimSessionStore) has_flash(key string) bool {
	return '${session_flash_prefix}${key}' in session.values
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=""']
@[php_arg_optional: 'default_value']
@[php_method: 'getFlash']
pub fn (session &VSlimSessionStore) get_flash(key string, default_value string) string {
	return session.values['${session_flash_prefix}${key}'] or { default_value }
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=""']
@[php_arg_optional: 'default_value']
@[php_method: 'pullFlash']
pub fn (mut session VSlimSessionStore) pull_flash(key string, default_value string) string {
	flash_key := '${session_flash_prefix}${key}'
	value := session.values[flash_key] or { default_value }
	if flash_key in session.values {
		session.values.delete(flash_key)
		session.dirty = true
	}
	return value
}

@[php_method: 'clearFlashes']
pub fn (mut session VSlimSessionStore) clear_flashes() &VSlimSessionStore {
	mut changed := false
	for key in session.values.keys() {
		if key.starts_with(session_flash_prefix) {
			session.values.delete(key)
			changed = true
		}
	}
	if changed {
		session.dirty = true
	}
	return &session
}

@[php_method]
pub fn (session &VSlimSessionStore) has(key string) bool {
	return key in session.values
}

@[php_method]
pub fn (mut session VSlimSessionStore) set(key string, value string) &VSlimSessionStore {
	session.values[key] = value
	session.dirty = true
	session.destroyed = false
	return &session
}

@[php_method]
pub fn (mut session VSlimSessionStore) forget(key string) &VSlimSessionStore {
	session.values.delete(key)
	session.dirty = true
	return &session
}

@[php_method]
pub fn (mut session VSlimSessionStore) clear() &VSlimSessionStore {
	session.values = map[string]string{}
	session.dirty = true
	session.destroyed = false
	return &session
}

@[php_method]
pub fn (mut session VSlimSessionStore) destroy(response vphp.RequestBorrowedZBox) bool {
	session.values = map[string]string{}
	session.dirty = false
	session.destroyed = true
	return session_commit_cookie(mut session, response)
}

@[php_method]
pub fn (mut session VSlimSessionStore) commit(response vphp.RequestBorrowedZBox) bool {
	return session_commit_cookie(mut session, response)
}

@[php_method: 'isLoaded']
pub fn (session &VSlimSessionStore) is_loaded() bool {
	return session.loaded
}

@[php_method]
pub fn (mut guard VSlimAuthSessionGuard) construct() &VSlimAuthSessionGuard {
	guard.user_key = 'auth.user_id'
	return &guard
}

@[php_method: 'setStore']
pub fn (mut guard VSlimAuthSessionGuard) set_store(store &VSlimSessionStore) &VSlimAuthSessionGuard {
	guard.store_ref = store
	return &guard
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) store() &VSlimSessionStore {
	return guard.store_ref
}

@[php_arg_name: 'key=userKey']
@[php_method: 'setUserKey']
pub fn (mut guard VSlimAuthSessionGuard) set_user_key(key string) &VSlimAuthSessionGuard {
	if key.trim_space() != '' {
		guard.user_key = key.trim_space()
	}
	return &guard
}

@[php_method: 'userKey']
pub fn (guard &VSlimAuthSessionGuard) user_key_value() string {
	if guard.user_key.trim_space() == '' {
		return 'auth.user_id'
	}
	return guard.user_key.trim_space()
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) check() bool {
	return guard.store_ref != unsafe { nil } && guard.store_ref.has(guard.user_key_value())
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) guest() bool {
	return !guard.check()
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) id() string {
	if guard.store_ref == unsafe { nil } {
		return ''
	}
	return guard.store_ref.get(guard.user_key_value(), '')
}

@[php_method: 'userId']
pub fn (guard &VSlimAuthSessionGuard) user_id() string {
	return guard.id()
}

@[php_arg_name: 'user_id=userId']
@[php_borrowed_return; php_method]
pub fn (mut guard VSlimAuthSessionGuard) login(user_id string) &VSlimAuthSessionGuard {
	if guard.store_ref != unsafe { nil } {
		guard.store_ref.set(guard.user_key_value(), user_id)
	}
	return &guard
}

@[php_borrowed_return; php_method]
pub fn (mut guard VSlimAuthSessionGuard) logout() &VSlimAuthSessionGuard {
	if guard.store_ref != unsafe { nil } {
		guard.store_ref.forget(guard.user_key_value())
	}
	return &guard
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimSessionStartMiddleware) construct() &VSlimSessionStartMiddleware {
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimSessionStartMiddleware) set_app(app &VSlimApp) &VSlimSessionStartMiddleware {
	middleware.app_ref = app
	return &middleware
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface,handler=Psr\\Http\\Server\\RequestHandlerInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (middleware &VSlimSessionStartMiddleware) process(request vphp.RequestBorrowedZBox, handler vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	app := effective_auth_middleware_app(middleware.app_ref)
	if app == unsafe { nil } {
		return new_psr7_text_response(500, 'Session middleware app is not configured')
	}
	mut session := app.session(request)
	mut result := vphp.PhpObject.borrowed(handler.to_zval()).method_request_owned('handle',
		vphp.PhpValue.from_zval(request.to_zval()))
	defer {
		result.release()
	}
	response := normalize_to_psr7_response(result.to_zval())
	return session_commit_psr_response(mut session, response)
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimAuthRequireMiddleware) construct() &VSlimAuthRequireMiddleware {
	middleware.redirect_path = ''
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthRequireMiddleware) set_app(app &VSlimApp) &VSlimAuthRequireMiddleware {
	middleware.app_ref = app
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
pub fn (middleware &VSlimAuthRequireMiddleware) process(request vphp.RequestBorrowedZBox, handler vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	app := effective_auth_middleware_app(middleware.app_ref)
	if app == unsafe { nil } {
		return new_psr7_text_response(500, 'Auth middleware app is not configured')
	}
	mut guard := app.auth(request)
	if !guard.check() {
		redirect_path := if middleware.redirect_path.trim_space() != '' {
			middleware.redirect_path_value()
		} else {
			app.auth_redirect_to()
		}
		return auth_unauthorized_psr_response(app, redirect_path)
	}
	user_id := guard.id()
	mut next_request := auth_request_with_attribute(request, 'auth.user_id', vphp.RequestOwnedZBox.new_string(user_id).to_zval())
	defer {
		next_request.release()
	}
	if app.auth_user_resolver.is_valid() && app.auth_user_resolver.is_callable() {
		mut user := app.auth_user(request)
		defer {
			user.release()
		}
		if user.is_valid() && !user.to_zval().is_null() && !user.to_zval().is_undef() {
			mut enriched := auth_request_with_attribute(vphp.RequestBorrowedZBox.of(next_request.to_zval()),
				'auth.user', user.to_zval())
			next_request.release()
			next_request = enriched
		}
	}
	mut result := vphp.PhpObject.borrowed(handler.to_zval()).method_request_owned('handle',
		vphp.PhpValue.from_zval(next_request.to_zval()))
	defer {
		result.release()
	}
	return normalize_to_psr7_response(result.to_zval())
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimAuthGuestMiddleware) construct() &VSlimAuthGuestMiddleware {
	middleware.redirect_path = ''
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthGuestMiddleware) set_app(app &VSlimApp) &VSlimAuthGuestMiddleware {
	middleware.app_ref = app
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
pub fn (middleware &VSlimAuthGuestMiddleware) process(request vphp.RequestBorrowedZBox, handler vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	app := effective_auth_middleware_app(middleware.app_ref)
	if app == unsafe { nil } {
		return new_psr7_text_response(500, 'Guest middleware app is not configured')
	}
	mut guard := app.auth(request)
	if !guard.guest() {
		redirect_path := if middleware.redirect_path.trim_space() != '' {
			middleware.redirect_path_value()
		} else {
			app.auth_redirect_to()
		}
		return auth_guest_redirect_psr_response(redirect_path)
	}
	mut result := vphp.PhpObject.borrowed(handler.to_zval()).method_request_owned('handle',
		vphp.PhpValue.from_zval(request.to_zval()))
	defer {
		result.release()
	}
	return normalize_to_psr7_response(result.to_zval())
}

@[php_borrowed_return; php_method]
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) construct() &VSlimAuthRequireAbilityMiddleware {
	middleware.ability = ''
	middleware.status = 403
	middleware.message = 'Forbidden'
	return &middleware
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut middleware VSlimAuthRequireAbilityMiddleware) set_app(app &VSlimApp) &VSlimAuthRequireAbilityMiddleware {
	middleware.app_ref = app
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
pub fn (middleware &VSlimAuthRequireAbilityMiddleware) process(request vphp.RequestBorrowedZBox, handler vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	app := effective_auth_middleware_app(middleware.app_ref)
	if app == unsafe { nil } {
		return new_psr7_text_response(500, 'Ability middleware app is not configured')
	}
	if middleware.ability() == '' {
		return new_psr7_text_response(500, 'Ability middleware ability is not configured')
	}
	if !app.can(middleware.ability(), request) {
		return default_error_response_psr(app, middleware.status(), middleware.message(),
			'forbidden')
	}
	mut result := vphp.PhpObject.borrowed(handler.to_zval()).method_request_owned('handle',
		vphp.PhpValue.from_zval(request.to_zval()))
	defer {
		result.release()
	}
	return normalize_to_psr7_response(result.to_zval())
}
