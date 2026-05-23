module sessionx

import configx as cfgx
import vphp

const session_flash_prefix = '__flash__.'

fn session_new_string_map(values map[string]string) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	for key, value in values {
		out.string(key, value)
	}
	return out
}

fn session_base64url_encode(raw string) string {
	mut raw_arg := vphp.PhpString.of(raw)
	defer {
		raw_arg.release()
	}
	mut encoded := vphp.PhpFunction.named('base64_encode').result_string(raw_arg)
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
	mut normalized_arg := vphp.PhpString.of(normalized)
	mut strict_arg := vphp.PhpBool.of(true)
	defer {
		normalized_arg.release()
		strict_arg.release()
	}
	mut decoded := vphp.PhpFunction.named('base64_decode').invoke(normalized_arg, strict_arg)
	defer {
		decoded.release()
	}
	if !decoded.is_valid() || decoded.is_null() || decoded.is_undef() {
		return error('invalid base64 payload')
	}
	if decoded.is_bool() && !decoded.to_bool() {
		return error('invalid base64 payload')
	}
	return decoded.to_string()
}

fn session_sign(payload string, secret string) string {
	mut algo_arg := vphp.PhpString.of('sha256')
	mut payload_arg := vphp.PhpString.of(payload)
	mut secret_arg := vphp.PhpString.of(secret)
	defer {
		algo_arg.release()
		payload_arg.release()
		secret_arg.release()
	}
	return vphp.PhpFunction.named('hash_hmac').result_string(algo_arg, payload_arg, secret_arg)
}

fn session_secure_equals(left string, right string) bool {
	mut left_arg := vphp.PhpString.of(left)
	mut right_arg := vphp.PhpString.of(right)
	defer {
		left_arg.release()
		right_arg.release()
	}
	return vphp.PhpFunction.named('hash_equals').result_bool(left_arg, right_arg)
}

fn session_encode_values(values map[string]string, secret string) string {
	mut payload := session_new_string_map(values)
	payload_json := payload.to_json()
	payload.release()
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

fn session_request_cookie(request vphp.PhpObject, cookie_name string) string {
	if !request.is_valid() {
		return ''
	}
	if request.method_exists('cookie') {
		mut cookie_name_arg := vphp.PhpString.of(cookie_name)
		defer {
			cookie_name_arg.release()
		}
		mut out := request.call_method('cookie', cookie_name_arg)
		defer {
			out.release()
		}
		return out.to_string()
	}
	if request.method_exists('getCookieParams') {
		mut out := request.call_method('getCookieParams')
		defer {
			out.release()
		}
		return out.to_string_map()[cookie_name] or { '' }
	}
	if request.method_exists('cookies') {
		mut out := request.call_method('cookies')
		defer {
			out.release()
		}
		return out.to_string_map()[cookie_name] or { '' }
	}
	return ''
}

fn (mut session VSlimSessionStore) commit_cookie(response vphp.PhpObject) bool {
	if !response.is_valid() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'session response must be an object', 0)
		return false
	}
	if session.destroyed {
		if response.method_exists('deleteCookie') {
			mut cookie_name_arg := vphp.PhpString.of(session.cookie_name_value())
			defer {
				cookie_name_arg.release()
			}
			response.with_method_result[vphp.PhpValue, bool]('deleteCookie', fn (_ vphp.PhpValue) bool {
				return true
			}, cookie_name_arg) or { return false }
			session.dirty = false
			return true
		}
		vphp.PhpException.raise_class('RuntimeException',
			'response does not support deleteCookie()', 0)
		return false
	}
	if !session.dirty {
		return true
	}
	if response.method_exists('setCookieFull') {
		mut cookie_name_arg := vphp.PhpString.of(session.cookie_name_value())
		defer {
			cookie_name_arg.release()
		}
		mut encoded_arg := vphp.PhpString.of(session.encoded_value())
		defer {
			encoded_arg.release()
		}
		mut path_arg := vphp.PhpString.of(session.path_value())
		defer {
			path_arg.release()
		}
		mut domain_arg := vphp.PhpString.of(session.domain_value())
		defer {
			domain_arg.release()
		}
		mut ttl_arg := vphp.PhpInt.of(session.ttl_seconds_value())
		defer {
			ttl_arg.release()
		}
		mut secure_arg := vphp.PhpBool.of(session.secure_value())
		defer {
			secure_arg.release()
		}
		mut http_only_arg := vphp.PhpBool.of(session.http_only_value())
		defer {
			http_only_arg.release()
		}
		mut same_site_arg := vphp.PhpString.of(session.same_site_value())
		defer {
			same_site_arg.release()
		}
		response.with_method_result[vphp.PhpValue, bool]('setCookieFull', fn (_ vphp.PhpValue) bool {
			return true
		}, cookie_name_arg, encoded_arg, path_arg, domain_arg, ttl_arg, secure_arg, http_only_arg,
			same_site_arg) or { return false }
		session.dirty = false
		return true
	}
	vphp.PhpException.raise_class('RuntimeException', 'response does not support setCookieFull()',
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

pub fn VSlimSessionStore.from_config_and_request(config &cfgx.VSlimConfig, request vphp.PhpObject) &VSlimSessionStore {
	mut session := &VSlimSessionStore{}
	session.construct()
	session.configure_defaults(config)
	session.load(request)
	return session
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
pub fn (mut session VSlimSessionStore) load(request vphp.PhpObject) &VSlimSessionStore {
	session.load_cookie_value(session_request_cookie(request, session.cookie_name_value()))
	return &session
}

pub fn (mut session VSlimSessionStore) load_cookie_value(cookie string) &VSlimSessionStore {
	session.values = session_decode_values(cookie, session.secret_value())
	session.loaded = true
	session.destroyed = false
	return &session
}

pub fn (session &VSlimSessionStore) encoded_value() string {
	return session_encode_values(session.values, session.secret_value())
}

pub fn (mut session VSlimSessionStore) set_many(values map[string]string) {
	for key, value in values {
		session.values[key] = value
	}
	session.dirty = true
	session.destroyed = false
}

pub fn (session &VSlimSessionStore) should_commit() bool {
	return session.dirty || session.destroyed
}

pub fn (session &VSlimSessionStore) is_destroyed() bool {
	return session.destroyed
}

pub fn (mut session VSlimSessionStore) mark_clean() {
	session.dirty = false
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
pub fn (mut session VSlimSessionStore) destroy(response vphp.PhpObject) bool {
	session.values = map[string]string{}
	session.dirty = false
	session.destroyed = true
	return session.commit_cookie(response)
}

@[php_method]
pub fn (mut session VSlimSessionStore) commit(response vphp.PhpObject) bool {
	return session.commit_cookie(response)
}

@[php_method: 'isLoaded']
pub fn (session &VSlimSessionStore) is_loaded() bool {
	return session.loaded
}

pub fn (mut session VSlimSessionStore) configure_defaults(config &cfgx.VSlimConfig) {
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
