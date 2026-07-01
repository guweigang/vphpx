import rt
import crypto.md5

struct Class_Automattic_WooCommerce_StoreApi_Authentication {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) init()  {
	if !(this.is_request_to_store_api()) {
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('rest_authentication_errors'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Authentication', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'check_authentication' }])])
	rt.call_function('add_filter', [rt.new_string('rest_authentication_errors'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Authentication', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'opt_in_checkout_endpoint' }]), rt.new_int(9), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('set_logged_in_cookie'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Authentication', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_logged_in_cookie' }])])
	rt.call_function('add_filter', [rt.new_string('rest_pre_serve_request'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Authentication', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'send_cors_headers' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('rest_allowed_cors_headers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Authentication', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'allowed_cors_headers' }])])
	rt.call_function('add_filter', [rt.new_string('rest_exposed_cors_headers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Authentication', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'exposed_cors_headers' }])])
	rt.call_function('remove_filter', [rt.new_string('rest_pre_serve_request'), rt.new_string('rest_send_cors_headers')])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) allowed_cors_headers(var_allowed_headers rt.PhpVal) rt.PhpVal {
	mut var_allowed_headers_mutated := var_allowed_headers
	var_allowed_headers_mutated.array_push('Cart-Token')
	var_allowed_headers_mutated.array_push('Nonce')
	return var_allowed_headers_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) maybe_use_store_api_session_handler(var_handler rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_store_api_request', []rt.PhpVal{}))))) && !(this.has_store_api_route_as_get_parameter()))) {
		return (var_handler).str()
	}
	mut var_cart_token := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get('HTTP_CART_TOKEN')).is_null() { rt.get_superglobal('_SERVER').array_get('HTTP_CART_TOKEN') } else { rt.new_string('') }])])
	var_cart_token = if rt.is_true(rt.new_bool(var_cart_token.dup().is_string())) { var_cart_token } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(var_cart_token) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.validate_cart_token(arg_0) }(var_cart_token.dup())))) {
		return (Class_Automattic_WooCommerce_StoreApi_SessionHandler.class()).str()
	}
	return (var_handler).str()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) exposed_cors_headers(var_exposed_headers rt.PhpVal) rt.PhpVal {
	mut var_exposed_headers_mutated := var_exposed_headers
	var_exposed_headers_mutated.array_push('Cart-Token')
	return var_exposed_headers_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) send_cors_headers(var_served rt.PhpVal, var_result rt.PhpVal, var_request rt.PhpVal, var_server rt.PhpVal) rt.PhpVal {
	mut var_result_mutated := var_result
	mut var_server_mutated := var_server
	mut var_origin := rt.call_function('get_http_origin', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_origin = rt.call_function('esc_url_raw', [var_origin.dup()])
	}
	rt.call_method(var_server_mutated, 'send_header', [rt.new_string('Access-Control-Allow-Methods'), rt.new_string('OPTIONS, GET, POST, PUT, PATCH, DELETE')])
	rt.call_method(var_server_mutated, 'send_header', [rt.new_string('Access-Control-Allow-Credentials'), rt.new_string('true')])
	rt.call_method(var_server_mutated, 'send_header', [rt.new_string('Vary'), rt.new_string('Origin'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.is_preflight() || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.validate_cart_token(arg_0) }(this.get_cart_token(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_WP_REST_Request](var_request)))))) || rt.is_true(rt.call_function('is_allowed_http_origin', [var_origin.dup()])))) {
		rt.call_method(var_server_mutated, 'send_header', [rt.new_string('Access-Control-Allow-Origin'), var_origin.dup()])
	}
	if this.is_preflight() {
		// unsupported expression: Expr_Exit
	}
	return var_served.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) has_store_api_route_as_get_parameter() bool {
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('rest_route'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('rest_route').is_string()))))))) {
		return false
	}
	mut var_rest_route := rt.call_function('rawurldecode', [rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('rest_route')])])])
	return (rt.identical(rt.new_int(0), rt.call_function('strpos', [var_rest_route.dup(), rt.new_string('/wc/store/')]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) is_preflight() bool {
	return rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_METHOD')) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCESS_CONTROL_REQUEST_METHOD')) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCESS_CONTROL_REQUEST_HEADERS')) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ORIGIN')) && rt.is_true(rt.identical(rt.new_string('OPTIONS'), rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD')))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) get_cart_token(mut var_request Class_Automattic_WooCommerce_StoreApi_WP_REST_Request) rt.PhpVal {
	return rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_request.get_header(rt.new_string('Cart-Token'))).is_null() { var_request.get_header(rt.new_string('Cart-Token')) } else { rt.new_string('') }])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) check_authentication(var_result rt.PhpVal) rt.PhpVal {
	mut var_result_mutated := var_result
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')]))))) {
		var_result_mutated = this.apply_rate_limiting(var_result_mutated.dup())
	}
	return if !(!rt.is_true(var_result_mutated)) { var_result_mutated } else { rt.new_bool(true) }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) set_logged_in_cookie(var_logged_in_cookie rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('LOGGED_IN_COOKIE')]))))) {
		return rt.new_null()
	}
	rt.get_superglobal('_COOKIE').array_set(rt.get_constant('LOGGED_IN_COOKIE'), var_logged_in_cookie.dup())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) opt_in_checkout_endpoint(var_result rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_result_mutated := var_result
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('rate_limit_checkout'))) && this.is_request_to_store_api())) && rt.is_true(rt.call_function('preg_match', [rt.new_string('#/wc/store(?:/v\\d+)?/checkout#'), rt.get_property(var_GLOBALS.array_get('wp'), 'query_vars').array_get('rest_route')])))) && this.is_only_post_request())) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_options := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_options.array_set('enabled', true)
	var_options.array_set('limit', 3)
	var_options.array_set('seconds', 60)
	return var_options.dup()
	}
		rt.call_function('add_filter', [rt.new_string('woocommerce_store_api_rate_limit_options'), rt.new_closure(closure_1_fn), rt.new_int(1), rt.new_int(1)])
	}
	return var_result_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) apply_rate_limiting(var_result rt.PhpVal) rt.PhpVal {
	mut var_result_mutated := var_result
	mut var_rate_limiting_options := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits{}; return temp.get_options() }()
	if rt.is_true(rt.get_property(var_rate_limiting_options, 'enabled')) {
		mut var_action_id := rt.new_string('store_api_request_' + (Class_Automattic_WooCommerce_StoreApi_Authentication.get_rate_limiting_id((rt.get_property(var_rate_limiting_options, 'proxy_support')).to_bool())).str())
		mut var_retry := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits{}; return temp.is_exceeded_retry_after(arg_0) }(var_action_id.dup())
		mut var_server := rt.call_function('rest_get_server', []rt.PhpVal{})
		rt.call_method(var_server, 'send_header', [rt.new_string('RateLimit-Limit'), rt.get_property(var_rate_limiting_options, 'limit')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(var_server, 'send_header', [rt.new_string('RateLimit-Remaining'), rt.new_int(0)])
			rt.call_method(var_server, 'send_header', [rt.new_string('RateLimit-Retry-After'), var_retry.dup()])
			rt.call_method(var_server, 'send_header', [rt.new_string('RateLimit-Reset'), rt.add(rt.call_function('time', []rt.PhpVal{}), var_retry)])
			rt.call_function('do_action', [rt.new_string('woocommerce_store_api_rate_limit_exceeded'), Class_Automattic_WooCommerce_StoreApi_Authentication.get_ip_address((rt.get_property(var_rate_limiting_options, 'proxy_support')).to_bool()), var_action_id.dup()])
			return create_automattic_woocommerce_storeapi_wp_error(rt.new_string('rate_limit_exceeded'), rt.call_function('sprintf', [rt.new_string('Too many requests. Please wait %d seconds before trying again.'), var_retry.dup()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		mut var_rate_limit := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits{}; return temp.update_rate_limit(arg_0) }(var_action_id.dup())
		rt.call_method(var_server, 'send_header', [rt.new_string('RateLimit-Remaining'), rt.get_property(var_rate_limit, 'remaining')])
		rt.call_method(var_server, 'send_header', [rt.new_string('RateLimit-Reset'), rt.get_property(var_rate_limit, 'reset')])
	}
	return var_result_mutated.dup()
}

fn Class_Automattic_WooCommerce_StoreApi_Authentication.get_rate_limiting_id(proxy_support bool) string {
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		mut var_id := // unsupported expression: Expr_Cast_String
	} else {
		var_id = rt.new_string(rt.new_string(md5.hexhash(Class_Automattic_WooCommerce_StoreApi_Authentication.get_ip_address(proxy_support).to_string())))
	}
	var_id = rt.call_function('apply_filters', [rt.new_string('woocommerce_store_api_rate_limit_id'), var_id.dup()])
	return (rt.call_function('sanitize_key', [var_id.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) is_request_to_store_api() bool {
	mut var_GLOBALS := rt.new_null()
	if !rt.is_true(rt.get_property(var_GLOBALS.array_get('wp'), 'query_vars').array_get('rest_route')) {
		return false
	}
	return (rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_GLOBALS.array_get('wp'), 'query_vars').array_get('rest_route'), rt.new_string('/wc/store/')]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) is_only_post_request() bool {
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_METHOD'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_HTTP_METHOD_OVERRIDE')) {
		mut var_method_override := rt.new_string(rt.new_string(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_X_HTTP_METHOD_OVERRIDE')])]).to_string().to_upper()))
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return false
		}
	}
	return true
}

fn Class_Automattic_WooCommerce_StoreApi_Authentication.get_ip_address(proxy_support bool) string {
	mut var_matches := rt.new_null()
	if !(var_proxy_support) {
		return (Class_Automattic_WooCommerce_StoreApi_Authentication.validate_ip(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR')).is_null() { rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR') } else { rt.new_string('unresolved_ip') }])]))).str()
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').dup().array_isset(rt.new_string('HTTP_X_REAL_IP')))) {
		return (Class_Automattic_WooCommerce_StoreApi_Authentication.validate_ip(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_X_REAL_IP')])]))).str()
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').dup().array_isset(rt.new_string('HTTP_CLIENT_IP')))) {
		return (Class_Automattic_WooCommerce_StoreApi_Authentication.validate_ip(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_CLIENT_IP')])]))).str()
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').dup().array_isset(rt.new_string('HTTP_X_FORWARDED_FOR')))) {
		mut var_ips := rt.call_function('explode', [rt.new_string(','), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_X_FORWARDED_FOR')])])])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_ips.dup().is_array())) && !(!rt.is_true(var_ips)))) {
			return (Class_Automattic_WooCommerce_StoreApi_Authentication.validate_ip(rt.new_string(var_ips.array_get(0).to_string().trim_space()))).str()
		}
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').dup().array_isset(rt.new_string('HTTP_FORWARDED')))) {
		rt.call_function('preg_match', [rt.new_string('/(?<=for\\=)[^;,]*/i'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_FORWARDED')])]), var_matches.dup()])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('preg_match', [rt.new_string('/(?<=\\[).*(?=\\])/i'), var_matches.array_get(0), var_matches.dup()])
		}
		if !(!rt.is_true(var_matches)) {
			return (Class_Automattic_WooCommerce_StoreApi_Authentication.validate_ip(rt.new_string(var_matches.array_get(0).to_string().trim_space()))).str()
		}
	}
	return '0.0.0.0'
}

fn Class_Automattic_WooCommerce_StoreApi_Authentication.validate_ip(var_ip rt.PhpVal) rt.PhpVal {
	mut var_ip_mutated := var_ip
	var_ip_mutated = rt.call_function('filter_var', [var_ip_mutated.dup(), rt.get_constant('FILTER_VALIDATE_IP'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('FILTER_FLAG_NO_RES_RANGE') }, rt.ArrayItem{ key: none, val: rt.get_constant('FILTER_FLAG_IPV6') }])])
	return if rt.is_true(var_ip_mutated) { var_ip_mutated } else { rt.new_string('0.0.0.0') }
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_authentication() &Class_Automattic_WooCommerce_StoreApi_Authentication {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Authentication{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_ratelimits() &Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_wp_error() &Class_Automattic_WooCommerce_StoreApi_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'allowed_cors_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.allowed_cors_headers(dispatch_arg_0)
		}
		'maybe_use_store_api_session_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.maybe_use_store_api_session_handler(dispatch_arg_0))
		}
		'exposed_cors_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.exposed_cors_headers(dispatch_arg_0)
		}
		'send_cors_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.send_cors_headers(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'has_store_api_route_as_get_parameter' {
			return rt.new_bool(this.has_store_api_route_as_get_parameter())
		}
		'is_preflight' {
			return rt.new_bool(this.is_preflight())
		}
		'get_cart_token' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_cart_token(mut dispatch_arg_0)
		}
		'check_authentication' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.check_authentication(dispatch_arg_0)
		}
		'set_logged_in_cookie' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_logged_in_cookie(dispatch_arg_0)
			return rt.new_null()
		}
		'opt_in_checkout_endpoint' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.opt_in_checkout_endpoint(dispatch_arg_0)
		}
		'apply_rate_limiting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.apply_rate_limiting(dispatch_arg_0)
		}
		'get_rate_limiting_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Authentication.get_rate_limiting_id(dispatch_arg_0))
		}
		'is_request_to_store_api' {
			return rt.new_bool(this.is_request_to_store_api())
		}
		'is_only_post_request' {
			return rt.new_bool(this.is_only_post_request())
		}
		'get_ip_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Authentication.get_ip_address(dispatch_arg_0))
		}
		'validate_ip' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Authentication.validate_ip(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Authentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_authentication_php() {
	// unsupported statement: Stmt_Declare
}
