import rt

struct Class_WC_Helper_API {
	rt.PhpObjectBase
pub mut:
		api_base rt.PhpVal = rt.new_null()
}

fn Class_WC_Helper_API.load()  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_WC_Helper_API.request(var_endpoint rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_endpoint_mutated := var_endpoint
	mut var_args_mutated := var_args
	if !(var_args_mutated.array_isset(rt.new_string('query_string'))) {
		var_args_mutated.array_set('query_string', '')
	}
	mut var_url := Class_WC_Helper_API.url((var_endpoint_mutated).str(), var_args_mutated.array_get('query_string'))
	if !(!rt.is_true(var_args_mutated.array_get('authenticated'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Helper_API._authenticate(var_url.dup(), var_args_mutated.dup()))))) {
			return create_wp_error(rt.new_string('authentication'), rt.call_function('__', [rt.new_string('Authentication failed. Please try again after a few minutes. If the issue persists, disconnect your store from WooCommerce.com and reconnect.'), rt.new_string('woocommerce')]), rt.new_int(401))
		}
	}
	if !(var_args_mutated.array_isset(rt.new_string('user-agent'))) {
		var_args_mutated.array_set('user-agent', 'WooCommerce/' + (rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str())
	}
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_helper_api_request_args'), var_args_mutated.dup(), var_endpoint_mutated.dup()])
	return rt.call_function('wp_safe_remote_request', [var_url.dup(), var_args_mutated.dup()])
}

fn Class_WC_Helper_API.create_request_signature(access_token_secret string, url string, method string, var_body rt.PhpVal) string {
	mut url_mutated := url
	mut var_request_uri := rt.call_function('wp_parse_url', [rt.new_string(url_mutated).dup(), rt.get_constant('PHP_URL_PATH')])
	mut var_query_string := rt.call_function('wp_parse_url', [rt.new_string(url_mutated).dup(), rt.get_constant('PHP_URL_QUERY')])
	if rt.is_true(rt.new_bool(var_query_string.dup().is_string())) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_data := { 'host': rt.call_function('wp_parse_url', [rt.new_string(url_mutated).dup(), rt.get_constant('PHP_URL_HOST')]), 'request_uri': var_request_uri, 'method': rt.new_string(method) }
	if !(!rt.is_true(var_body)) {
		var_data['body'] = var_body.dup()
	}
	return (rt.call_function('hash_hmac', [rt.new_string('sha256'), rt.call_function('wp_json_encode', [var_data.dup()]), rt.new_string(access_token_secret)])).str()
}

fn Class_WC_Helper_API.add_auth_parameters(url string) string {
	mut url_mutated := url
	mut var_auth := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('auth'))
	if !rt.is_true(var_auth.array_get('access_token')) || !rt.is_true(var_auth.array_get('access_token_secret')) {
		return false
	}
	mut var_signature := Class_WC_Helper_API.create_request_signature((// unsupported expression: Expr_Cast_String).str(), url_mutated, 'GET')
	return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'token', val: var_auth.array_get('access_token') }, rt.ArrayItem{ key: 'signature', val: var_signature }]), rt.new_string(url_mutated).dup()])).str()
}

fn Class_WC_Helper_API._authenticate(var_url rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_url_mutated := var_url
	mut var_args_mutated := var_args
	mut var_auth := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('auth'))
	if !rt.is_true(var_auth.array_get('access_token')) || !rt.is_true(var_auth.array_get('access_token_secret')) {
		return false
	}
	mut var_signature := Class_WC_Helper_API.create_request_signature((// unsupported expression: Expr_Cast_String).str(), (var_url_mutated).str(), (if !(!rt.is_true(var_args_mutated.array_get('method'))) { var_args_mutated.array_get('method') } else { rt.new_string('GET') }).str(), if !(var_args_mutated.array_get('body')).is_null() { var_args_mutated.array_get('body') } else { rt.new_null() })
	if !rt.is_true(var_args_mutated.array_get('headers')) {
		var_args_mutated.array_set('headers', rt.new_array())
	}
	mut var_headers := { 'Authorization': 'Bearer ' + (var_auth.array_get('access_token')).str(), 'X-Woo-Signature': var_signature }
	var_args_mutated.array_set('headers', rt.call_function('wp_parse_args', [var_headers.dup(), var_args_mutated.array_get('headers')]))
	var_url_mutated = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'token', val: var_auth.array_get('access_token') }, rt.ArrayItem{ key: 'signature', val: var_signature }]), var_url_mutated.dup()])
	return true
}

fn Class_WC_Helper_API.get(var_endpoint rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_endpoint_mutated := var_endpoint
	mut var_args_mutated := var_args
	var_args_mutated.array_set('method', 'GET')
	return Class_WC_Helper_API.request(var_endpoint_mutated.dup(), var_args_mutated.dup())
}

fn Class_WC_Helper_API.post(var_endpoint rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_endpoint_mutated := var_endpoint
	mut var_args_mutated := var_args
	var_args_mutated.array_set('method', 'POST')
	return Class_WC_Helper_API.request(var_endpoint_mutated.dup(), var_args_mutated.dup())
}

fn Class_WC_Helper_API.put(var_endpoint rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_endpoint_mutated := var_endpoint
	mut var_args_mutated := var_args
	var_args_mutated.array_set('method', 'PUT')
	return Class_WC_Helper_API.request(var_endpoint_mutated.dup(), var_args_mutated.dup())
}

fn Class_WC_Helper_API.url(var_endpoint rt.PhpVal, query_string string) rt.PhpVal {
	mut var_endpoint_mutated := var_endpoint
	mut query_string_mutated := query_string
	var_endpoint_mutated = rt.new_string(rt.new_string(var_endpoint_mutated.dup().to_string().trim_left(' \t\n\r')))
	var_endpoint_mutated = rt.call_function('sprintf', [rt.new_string('%s/%s/%s'), // unsupported expression: Expr_StaticPropertyFetch, var_endpoint_mutated.dup(), rt.new_string(query_string_mutated).dup()])
	var_endpoint_mutated = rt.call_function('esc_url_raw', [var_endpoint_mutated.dup()])
	var_endpoint_mutated = rt.new_string(rt.new_string(var_endpoint_mutated.dup().to_string().trim_right(' \t\n\r')))
	return var_endpoint_mutated.dup()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

fn create_wc_helper_api() &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
		api_base: rt.new_null()
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_options() &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Helper_API.load()
			return rt.new_null()
		}
		'request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper_API.request(dispatch_arg_0, dispatch_arg_1)
		}
		'create_request_signature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(Class_WC_Helper_API.create_request_signature(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'add_auth_parameters' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WC_Helper_API.add_auth_parameters(dispatch_arg_0))
		}
		'_authenticate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper_API._authenticate(dispatch_arg_0, dispatch_arg_1))
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper_API.get(dispatch_arg_0, dispatch_arg_1)
		}
		'post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper_API.post(dispatch_arg_0, dispatch_arg_1)
		}
		'put' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper_API.put(dispatch_arg_0, dispatch_arg_1)
		}
		'url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_Helper_API.url(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'api_base' { return this.api_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'api_base' { this.api_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_class_wc_helper_api_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	Class_WC_Helper_API.load()
}
