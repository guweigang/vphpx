module httpx

import psrx
import vphp

@[php_arg_name: 'default_uri=defaultUri']
@[php_arg_default: 'default_uri=""']
@[php_arg_optional: 'default_uri']
@[php_method]
pub fn (mut u VSlimPsr7Uri) construct(default_uri string) &VSlimPsr7Uri {
	parsed := VSlimPsr7Uri.parse(default_uri)
	u.scheme = parsed.scheme
	u.user = parsed.user
	u.password = parsed.password
	u.host = parsed.host
	u.port = parsed.port
	u.path = parsed.path
	u.query = parsed.query
	u.fragment = parsed.fragment
	return &u
}

@[php_method]
pub fn (u &VSlimPsr7Uri) str() string {
	return build_psr7_uri_string(u)
}

@[php_method: 'getScheme']
pub fn (u &VSlimPsr7Uri) get_scheme() string {
	return psrx.normalize_scheme(u.scheme)
}

@[php_method: 'getAuthority']
pub fn (u &VSlimPsr7Uri) get_authority() string {
	return build_psr7_authority(u)
}

@[php_method: 'getUserInfo']
pub fn (u &VSlimPsr7Uri) get_user_info() string {
	if u.user == '' {
		return ''
	}
	if u.password == '' {
		return u.user
	}
	return '${u.user}:${u.password}'
}

@[php_method: 'getHost']
pub fn (u &VSlimPsr7Uri) get_host() string {
	return psrx.normalize_host(u.host)
}

@[php_method: 'getPort']
pub fn (u &VSlimPsr7Uri) get_port() ?int {
	port := psrx.normalize_port(u.port)
	if port <= 0 {
		return none
	}
	scheme := psrx.normalize_scheme(u.scheme)
	if standard := psrx.default_port_for_scheme(scheme) {
		if port == standard {
			return none
		}
	}
	return port
}

@[php_method: 'getPath']
pub fn (u &VSlimPsr7Uri) get_path() string {
	return u.path
}

@[php_method: 'getQuery']
pub fn (u &VSlimPsr7Uri) get_query() string {
	return psrx.normalize_query(u.query)
}

@[php_method: 'getFragment']
pub fn (u &VSlimPsr7Uri) get_fragment() string {
	return psrx.normalize_fragment(u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withScheme']
pub fn (u &VSlimPsr7Uri) with_scheme(scheme vphp.PhpValue) &VSlimPsr7Uri {
	return u.clone_with(scheme.to_string(), u.user, u.password, u.host, u.port, u.path,
		u.query, u.fragment)
}

@[php_arg_name: 'default_password=defaultPassword']
@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_arg_default: 'default_password=""']
@[php_arg_optional: 'default_password']
@[php_method: 'withUserInfo']
pub fn (u &VSlimPsr7Uri) with_user_info(user vphp.PhpValue, default_password vphp.PhpValue) &VSlimPsr7Uri {
	return u.clone_with(u.scheme, user.to_string(), default_password.to_string(), u.host,
		u.port, u.path, u.query, u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withHost']
pub fn (u &VSlimPsr7Uri) with_host(host vphp.PhpValue) &VSlimPsr7Uri {
	return u.clone_with(u.scheme, u.user, u.password, host.to_string(), u.port, u.path,
		u.query, u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withPort']
pub fn (u &VSlimPsr7Uri) with_port(port vphp.PhpValue) &VSlimPsr7Uri {
	next_port := value_subject(port).psr7_port()
	return u.clone_with(u.scheme, u.user, u.password, u.host, next_port, u.path, u.query,
		u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withPath']
pub fn (u &VSlimPsr7Uri) with_path(path vphp.PhpValue) &VSlimPsr7Uri {
	return u.clone_with(u.scheme, u.user, u.password, u.host, u.port, path.to_string(),
		u.query, u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withQuery']
pub fn (u &VSlimPsr7Uri) with_query(query vphp.PhpValue) &VSlimPsr7Uri {
	return u.clone_with(u.scheme, u.user, u.password, u.host, u.port, u.path,
		query.to_string(), u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withFragment']
pub fn (u &VSlimPsr7Uri) with_fragment(fragment vphp.PhpValue) &VSlimPsr7Uri {
	return u.clone_with(u.scheme, u.user, u.password, u.host, u.port, u.path, u.query,
		fragment.to_string())
}

pub fn VSlimPsr7Uri.from_string(raw string) &VSlimPsr7Uri {
	parsed := VSlimPsr7Uri.parse(raw)
	return &VSlimPsr7Uri{
		scheme:   parsed.scheme
		user:     parsed.user
		password: parsed.password
		host:     parsed.host
		port:     parsed.port
		path:     parsed.path
		query:    parsed.query
		fragment: parsed.fragment
	}
}

pub fn (uri &VSlimPsr7Uri) clone_or_default() &VSlimPsr7Uri {
	if uri == unsafe { nil } {
		return VSlimPsr7Uri.from_string('/')
	}
	return uri.clone_with(uri.scheme, uri.user, uri.password, uri.host, uri.port, uri.path,
		uri.query, uri.fragment)
}

fn (u &VSlimPsr7Uri) clone_with(scheme string, user string, password string, host string, port int, path string, query string, fragment string) &VSlimPsr7Uri {
	return &VSlimPsr7Uri{
		scheme:   psrx.normalize_scheme(scheme).clone()
		user:     user.clone()
		password: password.clone()
		host:     psrx.normalize_host(host).clone()
		port:     psrx.normalize_port(port)
		path:     psrx.normalize_path(path, psrx.normalize_host(host)).clone()
		query:    psrx.normalize_query(query).clone()
		fragment: psrx.normalize_fragment(fragment).clone()
	}
}

fn (subject PhpValueSubject) psr7_port() int {
	value := subject.value
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return -1
	}
	port := int(value.to_i64())
	if port < 1 || port > 65535 {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'port must be null or an integer between 1 and 65535', 0)
		return -1
	}
	return port
}

pub fn VSlimPsr7Uri.from_value(value vphp.PhpValue) &VSlimPsr7Uri {
	if object := value.as_object() {
		defer {
			object.release()
		}
		if object.is_instance_of('VSlim\\Psr7\\Uri') || object.is_instance_of('VSlimPsr7Uri') {
			return object.to_v_object[VSlimPsr7Uri]() or { VSlimPsr7Uri.from_string(value_subject(value).log_message()) }
		}
		if object.method_exists('__toString') {
			return object.with_method_result[vphp.PhpString, &VSlimPsr7Uri]('__toString',
				fn (raw vphp.PhpString) &VSlimPsr7Uri {
				return VSlimPsr7Uri.from_string(raw.value())
			}) or { VSlimPsr7Uri.from_string(value_subject(value).log_message()) }
		}
	}
	return VSlimPsr7Uri.from_string(value_subject(value).log_message())
}

fn build_psr7_authority(u &VSlimPsr7Uri) string {
	host := psrx.normalize_host(u.host)
	if host == '' {
		return ''
	}
	mut authority := ''
	user_info := u.get_user_info()
	if user_info != '' {
		authority += user_info + '@'
	}
	authority += host
	if port := u.get_port() {
		authority += ':' + port.str()
	}
	return authority
}

pub fn build_psr7_uri_string(u &VSlimPsr7Uri) string {
	scheme := psrx.normalize_scheme(u.scheme)
	authority := build_psr7_authority(u)
	mut path := psrx.normalize_path(u.path, u.host)
	if authority != '' && path != '' && !path.starts_with('/') {
		path = '/' + path
	}
	if authority == '' && path.starts_with('//') {
		path = '/' + path.trim_left('/')
	}
	mut out := ''
	if scheme != '' {
		out += scheme + ':'
	}
	if authority != '' {
		out += '//' + authority
	}
	out += path
	query := psrx.normalize_query(u.query)
	if query != '' {
		out += '?' + query
	}
	fragment := psrx.normalize_fragment(u.fragment)
	if fragment != '' {
		out += '#' + fragment
	}
	return out
}

pub fn build_psr7_request_target(uri &VSlimPsr7Uri) string {
	mut path := psrx.normalize_path(uri.path, uri.host)
	if path == '' {
		path = '/'
	}
	query := psrx.normalize_query(uri.query)
	return if query == '' { path } else { '${path}?${query}' }
}

pub fn build_psr7_host_header(uri &VSlimPsr7Uri) string {
	host := psrx.normalize_host(uri.host)
	if host == '' {
		return ''
	}
	mut out := host
	if port := uri.get_port() {
		out += ':' + port.str()
	}
	return out
}

pub fn apply_psr7_host_header(mut headers map[string][]string, mut header_names map[string]string, uri &VSlimPsr7Uri) {
	key := psrx.normalize_header_name('Host')
	host := build_psr7_host_header(uri)
	if host == '' {
		headers.delete(key)
		header_names.delete(key)
		return
	}
	headers[key] = [host]
	header_names[key] = 'Host'
}

pub fn VSlimPsr7Uri.parse(raw string) VSlimPsr7Uri {
	trimmed := raw.trim_space()
	if trimmed == '' {
		return VSlimPsr7Uri{
			port: -1
		}
	}
	// Relative request targets are the hot path for dispatch_request(). Keep URI
	// normalization inside V instead of bouncing bridge values back through PHP's parse_url().
	if trimmed.starts_with('/') || trimmed.starts_with('?') || trimmed.starts_with('#')
		|| (!trimmed.contains('://') && !trimmed.starts_with('//')) {
		return VSlimPsr7Uri.fallback(trimmed)
	}
	return absolute_psr7_uri(trimmed) or { VSlimPsr7Uri.fallback(trimmed) }
}

fn VSlimPsr7Uri.fallback(raw string) VSlimPsr7Uri {
	mut base := raw
	mut fragment := ''
	if idx := raw.index('#') {
		base = raw[..idx]
		fragment = raw[idx + 1..]
	}
	mut path := base
	mut query := ''
	if idx := base.index('?') {
		path = base[..idx]
		query = base[idx + 1..]
	}
	return VSlimPsr7Uri{
		port:     -1
		path:     psrx.normalize_path(path, '')
		query:    psrx.normalize_query(query)
		fragment: psrx.normalize_fragment(fragment)
	}
}

fn absolute_psr7_uri(raw string) ?VSlimPsr7Uri {
	scheme_sep := raw.index('://') or { return none }
	scheme := psrx.normalize_scheme(raw[..scheme_sep])
	if scheme == '' {
		return none
	}
	mut rest := raw[scheme_sep + 3..]
	mut fragment := ''
	if idx := rest.index('#') {
		fragment = psrx.normalize_fragment(rest[idx + 1..])
		rest = rest[..idx]
	}
	mut query := ''
	if idx := rest.index('?') {
		query = psrx.normalize_query(rest[idx + 1..])
		rest = rest[..idx]
	}
	mut authority := rest
	mut path := ''
	if idx := rest.index('/') {
		authority = rest[..idx]
		path = rest[idx..]
	}
	mut user := ''
	mut password := ''
	mut host_port := authority
	if at := authority.last_index('@') {
		user_info := authority[..at]
		host_port = authority[at + 1..]
		if colon := user_info.index(':') {
			user = user_info[..colon]
			password = user_info[colon + 1..]
		} else {
			user = user_info
		}
	}
	mut host := host_port
	mut port := -1
	if host_port.starts_with('[') {
		end := host_port.index(']') or { -1 }
		if end > 0 {
			host = host_port[..end + 1]
			if end + 1 < host_port.len && host_port[end + 1] == `:` {
				port = psrx.normalize_port(host_port[end + 2..].int())
			}
		}
	} else if colon := host_port.last_index(':') {
		port_candidate := host_port[colon + 1..]
		if port_candidate != '' && port_candidate.bytes().all(it >= `0` && it <= `9`) {
			host = host_port[..colon]
			port = psrx.normalize_port(port_candidate.int())
		}
	}
	return VSlimPsr7Uri{
		scheme:   scheme
		user:     user
		password: password
		host:     psrx.normalize_host(host)
		port:     port
		path:     psrx.normalize_path(path, psrx.normalize_host(host))
		query:    query
		fragment: fragment
	}
}
