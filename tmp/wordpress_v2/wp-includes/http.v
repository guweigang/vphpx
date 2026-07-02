import rt

fn _wp_http_get_object() rt.PhpVal {
	mut var_http := rt.new_null()
	if rt.is_true(rt.new_bool(var_http.clone().is_null())) {
	var_http = create_wp_http()
	}
	return var_http.clone()
}

fn wp_safe_remote_request(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_args.array_set('reject_unsafe_urls', true)
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'request', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_safe_remote_get(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_args.array_set('reject_unsafe_urls', true)
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'get', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_safe_remote_post(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_args.array_set('reject_unsafe_urls', true)
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'post', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_safe_remote_head(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_args.array_set('reject_unsafe_urls', true)
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'head', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_remote_request(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'request', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_remote_get(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'get', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_remote_post(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'post', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_remote_head(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_http := rt.new_null()
	var_http = _wp_http_get_object()
	return rt.call_method(var_http, 'head', [var_url.clone(), rt.create_array_from_native_map(var_args)])
}

fn wp_remote_retrieve_headers(var_response rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_wp_error', [rt.create_array_from_native_map(var_response)])) || !(var_response.array_isset(rt.new_string('headers'))) {
		return rt.new_array()
	}
	return var_response.array_get(rt.new_string('headers'))
}

fn wp_remote_retrieve_header(var_response rt.PhpVal, var_header rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_wp_error', [rt.create_array_from_native_map(var_response)])) || !(var_response.array_isset(rt.new_string('headers'))) {
		return ''
	}
	return (if !(var_response.array_get(rt.new_string('headers')).array_get(var_header)).is_null() { var_response.array_get(rt.new_string('headers')).array_get(var_header) } else { rt.new_string('') }).str()
}

fn wp_remote_retrieve_response_code(var_response rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_wp_error', [rt.create_array_from_native_map(var_response)])) || !(var_response.array_isset(rt.new_string('response'))) || !(var_response.array_get(rt.new_string('response')).is_array()) {
		return ''
	}
	return (var_response.array_get(rt.new_string('response')).array_get(rt.new_string('code'))).str()
}

fn wp_remote_retrieve_response_message(var_response rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_wp_error', [rt.create_array_from_native_map(var_response)])) || !(var_response.array_isset(rt.new_string('response'))) || !(var_response.array_get(rt.new_string('response')).is_array()) {
		return ''
	}
	return (var_response.array_get(rt.new_string('response')).array_get(rt.new_string('message'))).str()
}

fn wp_remote_retrieve_body(var_response rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_wp_error', [rt.create_array_from_native_map(var_response)])) || !(var_response.array_isset(rt.new_string('body'))) {
		return ''
	}
	return (var_response.array_get(rt.new_string('body'))).str()
}

fn wp_remote_retrieve_cookies(var_response rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_wp_error', [rt.create_array_from_native_map(var_response)])) || !rt.is_true(var_response.array_get(rt.new_string('cookies'))) {
		return rt.new_array()
	}
	return var_response.array_get(rt.new_string('cookies'))
}

fn wp_remote_retrieve_cookie(var_response rt.PhpVal, var_name rt.PhpVal) string {
	mut var_cookies := rt.new_null()
	mut var_cookie := rt.new_null()
	var_cookies = wp_remote_retrieve_cookies(rt.create_array_from_native_map(var_response))
	if !rt.is_true(var_cookies) {
		return ''
	}
	mut iter_1 := var_cookies.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cookie_shadow := item_1.val
		if rt.is_true(rt.identical(rt.get_property(var_cookie_shadow, 'name'), var_name)) {
			return (var_cookie_shadow).str()
		}
	}
	return ''
}

fn wp_remote_retrieve_cookie_value(var_response rt.PhpVal, var_name rt.PhpVal) string {
	mut var_cookie := ''
	var_cookie = wp_remote_retrieve_cookie(rt.create_array_from_native_map(var_response), var_name.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_string((var_cookie).str()), 'WP_Http_Cookie')))))) {
		return ''
	}
	return (rt.get_property(rt.new_string((var_cookie).str()), 'value')).str()
}

fn wp_http_supports(var_capabilities_arg rt.PhpVal, var_url rt.PhpVal) rt.PhpVal {
	mut var_capabilities := var_capabilities_arg
	mut var_count := i64(0)
	mut var_scheme := rt.new_null()
	var_capabilities = rt.call_function('wp_parse_args', [var_capabilities.clone()])
	var_count = var_capabilities.clone().array_count()
	if var_count != 0 && rt.call_function('array_filter', [rt.func_array_keys(var_capabilities.clone()), rt.new_string('is_numeric')]).array_count() == var_count {
	var_capabilities = rt.call_function('array_combine', [rt.call_function('array_values', [var_capabilities.clone()]), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_count).clone(), rt.new_bool(true)])])
	}
	if rt.is_true(var_url) && !(var_capabilities.array_isset(rt.new_string('ssl'))) {
		var_scheme = rt.call_function('parse_url', [var_url.clone(), rt.get_constant('PHP_URL_SCHEME')])
		if rt.is_true(rt.identical(rt.new_string('https'), var_scheme)) || rt.is_true(rt.identical(rt.new_string('ssl'), var_scheme)) {
			var_capabilities.array_set('ssl', true)
		}
	}
	mut iife_temp_0 := Class_WpOrg_Requests_Requests{}
	mut iife_result_0 := iife_temp_0.has_capabilities(var_capabilities.clone())
	return iife_result_0
}

fn get_http_origin() rt.PhpVal {
	mut var_origin := rt.new_null()
	var_origin = rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_ORIGIN')))) {
	var_origin = rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_ORIGIN'))
	}
	return rt.call_function('apply_filters', [rt.new_string('http_origin'), var_origin.clone()])
}

fn get_allowed_http_origins() rt.PhpVal {
	mut var_admin_origin := rt.new_null()
	mut var_home_origin := rt.new_null()
	mut var_allowed_origins := rt.new_null()
	var_admin_origin = rt.call_function('parse_url', [rt.call_function('admin_url', []rt.PhpVal{})])
	var_home_origin = rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	var_allowed_origins = rt.call_function('array_unique', [rt.create_array([rt.ArrayItem{ key: none, val: 'http://' + (var_admin_origin.array_get(rt.new_string('host'))).str() }, rt.ArrayItem{ key: none, val: 'https://' + (var_admin_origin.array_get(rt.new_string('host'))).str() }, rt.ArrayItem{ key: none, val: 'http://' + (var_home_origin.array_get(rt.new_string('host'))).str() }, rt.ArrayItem{ key: none, val: 'https://' + (var_home_origin.array_get(rt.new_string('host'))).str() }])])
	return rt.call_function('apply_filters', [rt.new_string('allowed_http_origins'), var_allowed_origins.clone()])
}

fn is_allowed_http_origin(var_origin_arg rt.PhpVal) rt.PhpVal {
	mut var_origin := var_origin_arg
	mut var_origin_arg := rt.new_null()
	var_origin_arg = var_origin.clone()
	if rt.is_true(rt.identical(rt.new_null(), var_origin)) {
	var_origin = get_http_origin()
	}
	if rt.is_true(var_origin) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_origin.clone(), get_allowed_http_origins(), rt.new_bool(true)]))))) {
	var_origin = rt.new_string('')
	}
	return rt.call_function('apply_filters', [rt.new_string('allowed_http_origin'), var_origin.clone(), var_origin_arg.clone()])
}

fn send_origin_headers() bool {
	mut var_origin := rt.new_null()
	var_origin = get_http_origin()
	if rt.is_true(is_allowed_http_origin(var_origin.clone())) {
		rt.call_function('header', [rt.new_string('Access-Control-Allow-Origin: ' + (var_origin).str())])
		rt.call_function('header', [rt.new_string('Access-Control-Allow-Credentials: true')])
		if rt.is_true(rt.identical(rt.new_string('OPTIONS'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')))) {
			exit(0)
		}
		return (var_origin).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('OPTIONS'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')))) {
		rt.call_function('status_header', [rt.new_int(403)])
		exit(0)
	}
	return false
}

fn wp_http_validate_url(var_url_arg rt.PhpVal) bool {
	mut var_url := var_url_arg
	mut var_original_url := rt.new_null()
	mut var_parsed_url := rt.new_null()
	mut var_parsed_home := rt.new_null()
	mut var_same_host := false
	mut var_host := ''
	mut var_ip := rt.new_null()
	mut var_parts := rt.new_null()
	mut var_port := rt.new_null()
	mut var_allowed_ports := rt.new_null()
	if !(var_url.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_url)) || var_url.clone().is_long() || var_url.clone().is_double() {
		return false
	}
	var_original_url = var_url.clone()
	var_url = rt.call_function('wp_kses_bad_protocol', [var_url.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) || rt.is_true(rt.new_bool(var_url.clone().to_string().to_lower() != var_original_url.clone().to_string().to_lower())) {
		return false
	}
	var_parsed_url = rt.call_function('parse_url', [var_url.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_url)))) || !rt.is_true(var_parsed_url.array_get(rt.new_string('host'))) {
		return false
	}
	if var_parsed_url.array_isset(rt.new_string('user')) || var_parsed_url.array_isset(rt.new_string('pass')) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpbrk', [var_parsed_url.array_get(rt.new_string('host')), rt.new_string(':#?[]')]))))) {
		return false
	}
	var_parsed_home = rt.call_function('parse_url', [rt.call_function('get_option', [rt.new_string('home')])])
	var_same_host = var_parsed_home.array_isset(rt.new_string('host')) && rt.is_true(rt.identical(rt.new_string(var_parsed_home.array_get(rt.new_string('host')).to_string().to_lower()), rt.new_string(var_parsed_url.array_get(rt.new_string('host')).to_string().to_lower())))
	var_host = var_parsed_url.array_get(rt.new_string('host')).to_string().trim_space()
	if !(var_same_host) {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^(([1-9]?\\d|1\\d\\d|25[0-5]|2[0-4]\\d)\\.){3}([1-9]?\\d|1\\d\\d|25[0-5]|2[0-4]\\d)$#'), rt.new_string((var_host).str()).clone()])) {
		var_ip = rt.new_string((var_host).str()).clone()
		} else {
			var_ip = rt.call_function('gethostbyname', [rt.new_string((var_host).str()).clone()])
			if rt.is_true(rt.identical(var_ip, rt.new_string((var_host).str()))) {
				return false
			}
		}
		if rt.is_true(var_ip) {
			var_parts = rt.call_function('array_map', [rt.new_string('intval'), rt.call_function('explode', [rt.new_string('.'), var_ip.clone()])])
			if (rt.is_true(rt.identical(rt.new_int(127), var_parts.array_get(rt.new_int(0)))) || rt.is_true(rt.identical(rt.new_int(10), var_parts.array_get(rt.new_int(0)))) || rt.is_true(rt.identical(rt.new_int(0), var_parts.array_get(rt.new_int(0)))) || (rt.is_true(rt.identical(rt.new_int(172), var_parts.array_get(rt.new_int(0)))) && rt.is_true(rt.less_equal(rt.new_int(16), var_parts.array_get(rt.new_int(1)))) && rt.is_true(rt.greater_equal(rt.new_int(31), var_parts.array_get(rt.new_int(1)))))) || (rt.is_true(rt.identical(rt.new_int(192), var_parts.array_get(rt.new_int(0)))) && rt.is_true(rt.identical(rt.new_int(168), var_parts.array_get(rt.new_int(1))))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('http_request_host_is_external'), rt.new_bool(false), rt.new_string((var_host).str()).clone(), var_url.clone()]))))) {
					return false
				}
			}
		}
	}
	if !rt.is_true(var_parsed_url.array_get(rt.new_string('port'))) {
		return (var_url).to_bool()
	}
	var_port = var_parsed_url.array_get(rt.new_string('port'))
	var_allowed_ports = rt.call_function('apply_filters', [rt.new_string('http_allowed_safe_ports'), rt.create_array([rt.ArrayItem{ key: none, val: 80 }, rt.ArrayItem{ key: none, val: 443 }, rt.ArrayItem{ key: none, val: 8080 }]), rt.new_string((var_host).str()).clone(), var_url.clone()])
	if var_allowed_ports.clone().is_array() && rt.is_true(rt.call_function('in_array', [var_port.clone(), var_allowed_ports.clone(), rt.new_bool(true)])) {
		return (var_url).to_bool()
	}
	if rt.is_true(var_parsed_home) && var_same_host && var_parsed_home.array_isset(rt.new_string('port')) && rt.is_true(rt.identical(var_parsed_home.array_get(rt.new_string('port')), var_port)) {
		return (var_url).to_bool()
	}
	return false
}

fn allowed_http_request_hosts(var_is_external_arg rt.PhpVal, var_host rt.PhpVal) bool {
	mut var_is_external := var_is_external_arg
	if !(var_is_external) && rt.is_true(rt.call_function('wp_validate_redirect', [rt.new_string('http://' + (var_host).str())])) {
	var_is_external = true
	}
	return var_is_external
}

fn ms_allowed_http_request_hosts(var_is_external rt.PhpVal, var_host rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_queried := rt.new_null()
	if rt.is_true(var_is_external) {
		return (var_is_external).to_bool()
	}
	if rt.is_true(rt.identical(rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'domain'), var_host)) {
		return true
	}
	if var_queried.array_isset(var_host) {
		return (var_queried.array_get(var_host)).to_bool()
	}
	var_queried.array_set(var_host, (rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT domain FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE domain = %s LIMIT 1')), var_host.clone()])])).to_bool())
	return (var_queried.array_get(var_host)).to_bool()
}

fn wp_parse_url(var_url_arg rt.PhpVal, var_component rt.PhpVal) rt.PhpVal {
	mut var_url := var_url_arg
	mut var_to_unset := []rt.PhpVal{}
	mut var_parts := rt.new_null()
	mut var_key := rt.new_null()
	var_to_unset = rt.new_array()
	var_url = rt.new_string((var_url).str())
	if rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('//')])) {
		var_to_unset << 'scheme'
	var_url = rt.new_string('placeholder:' + (var_url).str())
	} else if rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('/')])) {
		var_to_unset << 'scheme'
		var_to_unset << 'host'
	var_url = rt.new_string('placeholder://placeholder' + (var_url).str())
	}
	var_parts = rt.call_function('parse_url', [var_url.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_parts)) {
		return var_parts.clone()
	}
	for var_key_shadow in var_to_unset {
		var_parts.array_unset(rt.new_string((var_key_shadow).str()))
	}
	return _get_component_from_parsed_url_array(var_parts.clone(), var_component.clone())
}

fn _get_component_from_parsed_url_array(var_url_parts rt.PhpVal, var_component rt.PhpVal) rt.PhpVal {
	mut var_key := rt.new_null()
	if rt.is_true(rt.identical(-1, var_component)) {
		return var_url_parts.clone()
	}
	var_key = rt.new_bool(_wp_translate_php_url_constant_to_key(var_component.clone()))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) && var_url_parts.clone().is_array() && var_url_parts.array_isset(var_key) {
		return var_url_parts.array_get(var_key)
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn _wp_translate_php_url_constant_to_key(var_constant rt.PhpVal) bool {
	mut var_translation := rt.new_null()
	var_translation = rt.create_array([rt.ArrayItem{ key: rt.get_constant('PHP_URL_SCHEME'), val: 'scheme' }, rt.ArrayItem{ key: rt.get_constant('PHP_URL_HOST'), val: 'host' }, rt.ArrayItem{ key: rt.get_constant('PHP_URL_PORT'), val: 'port' }, rt.ArrayItem{ key: rt.get_constant('PHP_URL_USER'), val: 'user' }, rt.ArrayItem{ key: rt.get_constant('PHP_URL_PASS'), val: 'pass' }, rt.ArrayItem{ key: rt.get_constant('PHP_URL_PATH'), val: 'path' }, rt.ArrayItem{ key: rt.get_constant('PHP_URL_QUERY'), val: 'query' }, rt.ArrayItem{ key: rt.get_constant('PHP_URL_FRAGMENT'), val: 'fragment' }])
	if var_translation.array_isset(var_constant) {
		return (var_translation.array_get(var_constant)).to_bool()
	} else {
		return false
	}
	return false
}

struct Class_WP_Http {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Requests {
	rt.PhpObjectBase
}

fn create_wp_http(_args ...rt.PhpVal) &Class_WP_Http {
	mut obj := &Class_WP_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_requests(_args ...rt.PhpVal) &Class_WpOrg_Requests_Requests {
	mut obj := &Class_WpOrg_Requests_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
