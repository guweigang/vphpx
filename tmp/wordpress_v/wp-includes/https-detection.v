import rt

fn wp_is_using_https() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_home_url_using_https())))) {
		return false
	}
	return (wp_is_site_url_using_https()).to_bool()
}

fn wp_is_home_url_using_https() rt.PhpVal {
	return rt.identical(rt.new_string('https'), rt.call_function('wp_parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_SCHEME')]))
}

fn wp_is_site_url_using_https() rt.PhpVal {
	mut var_site_url := rt.call_function('apply_filters', [rt.new_string('site_url'), rt.call_function('get_option', [rt.new_string('siteurl')]), rt.new_string(''), rt.new_null(), rt.new_null()])
	return rt.identical(rt.new_string('https'), rt.call_function('wp_parse_url', [var_site_url.dup(), rt.get_constant('PHP_URL_SCHEME')]))
}

fn wp_is_https_supported() rt.PhpVal {
	mut var_https_detection_errors := wp_get_https_detection_errors()
	return rt.new_bool(!rt.is_true(var_https_detection_errors))
}

fn wp_get_https_detection_errors() rt.PhpVal {
	mut var_support_errors := rt.call_function('apply_filters', [rt.new_string('pre_wp_get_https_detection_errors'), rt.new_null()])
	if rt.is_true(rt.call_function('is_wp_error', [var_support_errors.dup()])) {
		return rt.get_property(var_support_errors, 'errors')
	}
	var_support_errors = create_wp_error()
	mut var_response := rt.call_function('wp_remote_request', [rt.call_function('home_url', [rt.new_string('/'), rt.new_string('https')]), rt.create_array([rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Cache-Control', val: 'no-cache' }]) }, rt.ArrayItem{ key: 'sslverify', val: true }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		mut var_unverified_response := rt.call_function('wp_remote_request', [rt.call_function('home_url', [rt.new_string('/'), rt.new_string('https')]), rt.create_array([rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Cache-Control', val: 'no-cache' }]) }, rt.ArrayItem{ key: 'sslverify', val: false }])])
		if rt.is_true(rt.call_function('is_wp_error', [var_unverified_response.dup()])) {
			rt.call_method(var_support_errors, 'add', [rt.new_string('https_request_failed'), rt.call_function('__', [rt.new_string('HTTPS request failed.')])])
		} else {
			rt.call_method(var_support_errors, 'add', [rt.new_string('ssl_verification_failed'), rt.call_function('__', [rt.new_string('SSL verification failed.')])])
		}
		var_response = var_unverified_response.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()]))))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(var_support_errors, 'add', [rt.new_string('bad_response_code'), rt.call_function('wp_remote_retrieve_response_message', [var_response.dup()])])
		} else if rt.is_true(rt.identical(rt.new_bool(false), wp_is_local_html_output(rt.call_function('wp_remote_retrieve_body', [var_response.dup()])))) {
			rt.call_method(var_support_errors, 'add', [rt.new_string('bad_response_source'), rt.call_function('__', [rt.new_string('It looks like the response did not come from this site.')])])
		}
	}
	return rt.get_property(var_support_errors, 'errors')
}

fn wp_is_local_html_output(var_html rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('has_action', [rt.new_string('wp_head'), rt.new_string('rsd_link')])) {
		mut var_pattern := rt.call_function('preg_replace', [rt.new_string('#^https?:(?=//)#'), rt.new_string(''), rt.call_function('esc_url', [rt.call_function('site_url', [rt.new_string('xmlrpc.php?rsd'), rt.new_string('rpc')])])])
		return rt.call_function('str_contains', [var_html.dup(), var_pattern.dup()])
	}
	if rt.is_true(rt.call_function('has_action', [rt.new_string('wp_head'), rt.new_string('rest_output_link_wp_head')])) {
		var_pattern = rt.call_function('preg_replace', [rt.new_string('#^https?:(?=//)#'), rt.new_string(''), rt.call_function('esc_url', [rt.call_function('get_rest_url', []rt.PhpVal{})])])
		return rt.call_function('str_contains', [var_html.dup(), var_pattern.dup()])
	}
	return rt.new_null()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_https_detection_php() {
}
