module main

import vphp

fn session_new_string_map_zval(values map[string]string) vphp.ZVal {
	mut out := vphp.ZVal.new_null()
	out.array_init()
	for key, value in values {
		out.add_assoc_string(key, value)
	}
	return out
}

fn session_base64url_encode(raw string) string {
	mut encoded := vphp.call_php('base64_encode', [
		vphp.RequestOwnedZBox.new_string(raw).to_zval(),
	]).to_string()
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
	decoded := vphp.call_php('base64_decode', [
		vphp.RequestOwnedZBox.new_string(normalized).to_zval(),
		vphp.RequestOwnedZBox.new_bool(true).to_zval(),
	])
	if !decoded.is_valid() || decoded.is_null() || decoded.is_undef() {
		return error('invalid base64 payload')
	}
	if decoded.is_bool() && !decoded.to_bool() {
		return error('invalid base64 payload')
	}
	return decoded.to_string()
}

fn session_sign(payload string, secret string) string {
	return vphp.call_php('hash_hmac', [
		vphp.RequestOwnedZBox.new_string('sha256').to_zval(),
		vphp.RequestOwnedZBox.new_string(payload).to_zval(),
		vphp.RequestOwnedZBox.new_string(secret).to_zval(),
	]).to_string()
}

fn session_secure_equals(left string, right string) bool {
	res := vphp.call_php('hash_equals', [
		vphp.RequestOwnedZBox.new_string(left).to_zval(),
		vphp.RequestOwnedZBox.new_string(right).to_zval(),
	])
	return res.is_valid() && res.to_bool()
}

fn session_encode_values(values map[string]string, secret string) string {
	mut payload_z := session_new_string_map_zval(values)
	payload_json := vphp.json_encode(payload_z)
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
	mut decoded := vphp.json_decode_assoc(payload_json)
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
			mut out := vphp.method_request_owned_box(raw_request, 'cookie', [
				vphp.RequestOwnedZBox.new_string(cookie_name).to_zval(),
			])
			defer {
				out.release()
			}
			return out.to_zval().to_string()
		}
		if raw_request.method_exists('getCookieParams') {
			mut out := vphp.method_request_owned_box(raw_request, 'getCookieParams', []vphp.ZVal{})
			defer {
				out.release()
			}
			return out.to_zval().to_string_map()[cookie_name] or { '' }
		}
		if raw_request.method_exists('cookies') {
			mut out := vphp.method_request_owned_box(raw_request, 'cookies', []vphp.ZVal{})
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
		vphp.throw_exception_class('InvalidArgumentException', 'session response must be an object',
			0)
		return false
	}
	if session.destroyed {
		if raw_response.method_exists('delete_cookie') {
			vphp.with_method_result_zval(raw_response, 'delete_cookie', [
				vphp.RequestOwnedZBox.new_string(session.cookie_name_value()).to_zval(),
			], fn (_ vphp.ZVal) bool {
				return true
			})
			session.dirty = false
			return true
		}
		vphp.throw_exception_class('RuntimeException', 'response does not support delete_cookie()', 0)
		return false
	}
	if !session.dirty {
		return true
	}
	if raw_response.method_exists('set_cookie_full') {
		vphp.with_method_result_zval(raw_response, 'set_cookie_full', [
			vphp.RequestOwnedZBox.new_string(session.cookie_name_value()).to_zval(),
			vphp.RequestOwnedZBox.new_string(session_encode_values(session.values, session.secret_value())).to_zval(),
			vphp.RequestOwnedZBox.new_string(session.path_value()).to_zval(),
			vphp.RequestOwnedZBox.new_string(session.domain_value()).to_zval(),
			vphp.RequestOwnedZBox.new_int(session.ttl_seconds_value()).to_zval(),
			vphp.RequestOwnedZBox.new_bool(session.secure_value()).to_zval(),
			vphp.RequestOwnedZBox.new_bool(session.http_only_value()).to_zval(),
			vphp.RequestOwnedZBox.new_string(session.same_site_value()).to_zval(),
		], fn (_ vphp.ZVal) bool {
			return true
		})
		session.dirty = false
		return true
	}
	vphp.throw_exception_class('RuntimeException', 'response does not support set_cookie_full()', 0)
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

@[php_method: 'setHttpOnly']
pub fn (mut session VSlimSessionStore) set_http_only(http_only bool) &VSlimSessionStore {
	session.http_only = http_only
	return &session
}

@[php_method: 'httpOnly']
pub fn (session &VSlimSessionStore) http_only_value() bool {
	return session.http_only
}

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

@[php_method]
@[php_optional_args: 'default_value']
pub fn (session &VSlimSessionStore) get(key string, default_value string) string {
	return session.values[key] or { default_value }
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

@[php_method]
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

@[php_method]
pub fn (mut guard VSlimAuthSessionGuard) login(user_id string) &VSlimAuthSessionGuard {
	if guard.store_ref != unsafe { nil } {
		guard.store_ref.set(guard.user_key_value(), user_id)
	}
	return &guard
}

@[php_method]
pub fn (mut guard VSlimAuthSessionGuard) logout() &VSlimAuthSessionGuard {
	if guard.store_ref != unsafe { nil } {
		guard.store_ref.forget(guard.user_key_value())
	}
	return &guard
}
