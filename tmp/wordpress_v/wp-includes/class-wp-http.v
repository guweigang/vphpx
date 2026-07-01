import rt

pub fn Class_WP_Http.http_continue() i64 {
	return 100
}
pub fn Class_WP_Http.switching_protocols() i64 {
	return 101
}
pub fn Class_WP_Http.processing() i64 {
	return 102
}
pub fn Class_WP_Http.early_hints() i64 {
	return 103
}
pub fn Class_WP_Http.ok() i64 {
	return 200
}
pub fn Class_WP_Http.created() i64 {
	return 201
}
pub fn Class_WP_Http.accepted() i64 {
	return 202
}
pub fn Class_WP_Http.non_authoritative_information() i64 {
	return 203
}
pub fn Class_WP_Http.no_content() i64 {
	return 204
}
pub fn Class_WP_Http.reset_content() i64 {
	return 205
}
pub fn Class_WP_Http.partial_content() i64 {
	return 206
}
pub fn Class_WP_Http.multi_status() i64 {
	return 207
}
pub fn Class_WP_Http.im_used() i64 {
	return 226
}
pub fn Class_WP_Http.multiple_choices() i64 {
	return 300
}
pub fn Class_WP_Http.moved_permanently() i64 {
	return 301
}
pub fn Class_WP_Http.found() i64 {
	return 302
}
pub fn Class_WP_Http.see_other() i64 {
	return 303
}
pub fn Class_WP_Http.not_modified() i64 {
	return 304
}
pub fn Class_WP_Http.use_proxy() i64 {
	return 305
}
pub fn Class_WP_Http.reserved() i64 {
	return 306
}
pub fn Class_WP_Http.temporary_redirect() i64 {
	return 307
}
pub fn Class_WP_Http.permanent_redirect() i64 {
	return 308
}
pub fn Class_WP_Http.bad_request() i64 {
	return 400
}
pub fn Class_WP_Http.unauthorized() i64 {
	return 401
}
pub fn Class_WP_Http.payment_required() i64 {
	return 402
}
pub fn Class_WP_Http.forbidden() i64 {
	return 403
}
pub fn Class_WP_Http.not_found() i64 {
	return 404
}
pub fn Class_WP_Http.method_not_allowed() i64 {
	return 405
}
pub fn Class_WP_Http.not_acceptable() i64 {
	return 406
}
pub fn Class_WP_Http.proxy_authentication_required() i64 {
	return 407
}
pub fn Class_WP_Http.request_timeout() i64 {
	return 408
}
pub fn Class_WP_Http.conflict() i64 {
	return 409
}
pub fn Class_WP_Http.gone() i64 {
	return 410
}
pub fn Class_WP_Http.length_required() i64 {
	return 411
}
pub fn Class_WP_Http.precondition_failed() i64 {
	return 412
}
pub fn Class_WP_Http.request_entity_too_large() i64 {
	return 413
}
pub fn Class_WP_Http.request_uri_too_long() i64 {
	return 414
}
pub fn Class_WP_Http.unsupported_media_type() i64 {
	return 415
}
pub fn Class_WP_Http.requested_range_not_satisfiable() i64 {
	return 416
}
pub fn Class_WP_Http.expectation_failed() i64 {
	return 417
}
pub fn Class_WP_Http.im_a_teapot() i64 {
	return 418
}
pub fn Class_WP_Http.misdirected_request() i64 {
	return 421
}
pub fn Class_WP_Http.unprocessable_entity() i64 {
	return 422
}
pub fn Class_WP_Http.locked() i64 {
	return 423
}
pub fn Class_WP_Http.failed_dependency() i64 {
	return 424
}
pub fn Class_WP_Http.too_early() i64 {
	return 425
}
pub fn Class_WP_Http.upgrade_required() i64 {
	return 426
}
pub fn Class_WP_Http.precondition_required() i64 {
	return 428
}
pub fn Class_WP_Http.too_many_requests() i64 {
	return 429
}
pub fn Class_WP_Http.request_header_fields_too_large() i64 {
	return 431
}
pub fn Class_WP_Http.unavailable_for_legal_reasons() i64 {
	return 451
}
pub fn Class_WP_Http.internal_server_error() i64 {
	return 500
}
pub fn Class_WP_Http.not_implemented() i64 {
	return 501
}
pub fn Class_WP_Http.bad_gateway() i64 {
	return 502
}
pub fn Class_WP_Http.service_unavailable() i64 {
	return 503
}
pub fn Class_WP_Http.gateway_timeout() i64 {
	return 504
}
pub fn Class_WP_Http.http_version_not_supported() i64 {
	return 505
}
pub fn Class_WP_Http.variant_also_negotiates() i64 {
	return 506
}
pub fn Class_WP_Http.insufficient_storage() i64 {
	return 507
}
pub fn Class_WP_Http.not_extended() i64 {
	return 510
}
pub fn Class_WP_Http.network_authentication_required() i64 {
	return 511
}
struct Class_WP_Http {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Http) request(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_args_mutated := var_args
	mut var_defaults := { 'method': rt.new_string('GET'), 'timeout': rt.call_function('apply_filters', [rt.new_string('http_request_timeout'), rt.new_int(5), var_url_mutated.dup()]), 'redirection': rt.call_function('apply_filters', [rt.new_string('http_request_redirection_count'), rt.new_int(5), var_url_mutated.dup()]), 'httpversion': rt.call_function('apply_filters', [rt.new_string('http_request_version'), rt.new_string('1.0'), var_url_mutated.dup()]), 'user-agent': rt.call_function('apply_filters', [rt.new_string('http_headers_useragent'), 'WordPress/' + (rt.call_function('get_bloginfo', [rt.new_string('version')])).str() + '; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str(), var_url_mutated.dup()]), 'reject_unsafe_urls': rt.call_function('apply_filters', [rt.new_string('http_request_reject_unsafe_urls'), rt.new_bool(false), var_url_mutated.dup()]), 'blocking': rt.new_bool(true), 'headers': map[string]rt.PhpVal{}, 'cookies': map[string]rt.PhpVal{}, 'body': rt.new_null(), 'compress': rt.new_bool(false), 'decompress': rt.new_bool(true), 'sslverify': rt.new_bool(true), 'sslcertificates': (rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/certificates/ca-bundle.crt', 'stream': rt.new_bool(false), 'filename': rt.new_null(), 'limit_response_size': rt.new_null() }
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup()])
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('method')) && rt.is_true(rt.identical(rt.new_string('HEAD'), var_args_mutated.array_get('method'))))) {
		var_defaults['redirection'] = rt.new_int(0)
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_defaults.dup()])
	var_parsed_args = rt.call_function('apply_filters', [rt.new_string('http_request_args'), var_parsed_args.dup(), var_url_mutated.dup()])
	if !(var_parsed_args.array_isset(rt.new_string('_redirection'))) {
		var_parsed_args.array_set('_redirection', var_parsed_args.array_get('redirection'))
	}
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('pre_http_request'), rt.new_bool(false), var_parsed_args.dup(), var_url_mutated.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_pre.dup()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_kses_bad_protocol')])) {
		if rt.is_true(var_parsed_args.array_get('reject_unsafe_urls')) {
			var_url_mutated = rt.call_function('wp_http_validate_url', [var_url_mutated.dup()])
		}
		if rt.is_true(var_url_mutated) {
			var_url_mutated = rt.call_function('wp_kses_bad_protocol', [var_url_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }, rt.ArrayItem{ key: none, val: 'ssl' }])])
		}
	}
	mut var_parsed_url := rt.call_function('parse_url', [var_url_mutated.dup()])
	if !rt.is_true(var_url_mutated) || !rt.is_true(var_parsed_url.array_get('scheme')) {
		mut var_response := create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('A valid URL was not provided.')]))
		rt.call_function('do_action', [rt.new_string('http_api_debug'), var_response.dup(), rt.new_string('response'), rt.new_string('WpOrg\\Requests\\Requests'), var_parsed_args.dup(), var_url_mutated.dup()])
		return var_response.dup()
	}
	if this.block_request(var_url_mutated.dup()) {
		var_response = create_wp_error(rt.new_string('http_request_not_executed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('User has blocked requests through HTTP to the URL: %s.')]), var_url_mutated.dup()]))
		rt.call_function('do_action', [rt.new_string('http_api_debug'), var_response.dup(), rt.new_string('response'), rt.new_string('WpOrg\\Requests\\Requests'), var_parsed_args.dup(), var_url_mutated.dup()])
		return var_response.dup()
	}
	if rt.is_true(var_parsed_args.array_get('stream')) {
		if !rt.is_true(var_parsed_args.array_get('filename')) {
			var_parsed_args.array_set('filename', (rt.call_function('get_temp_dir', []rt.PhpVal{})).str() + (rt.call_function('basename', [var_url_mutated.dup()])).str())
		}
		var_parsed_args.array_set('blocking', true)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_writable', [rt.call_function('dirname', [var_parsed_args.array_get('filename')])]))))) {
			var_response = create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('Destination directory for file streaming does not exist or is not writable.')]))
			rt.call_function('do_action', [rt.new_string('http_api_debug'), var_response.dup(), rt.new_string('response'), rt.new_string('WpOrg\\Requests\\Requests'), var_parsed_args.dup(), var_url_mutated.dup()])
			return var_response.dup()
		}
	}
	if rt.is_true(rt.new_bool(var_parsed_args.array_get('headers').is_null())) {
		var_parsed_args.array_set('headers', map[string]rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_parsed_args.array_get('headers').is_array()))))) {
		mut var_processed_headers := Class_WP_Http.processheaders((var_parsed_args.array_get('headers')).str())
		var_parsed_args.array_set('headers', var_processed_headers.array_get('headers'))
	}
	mut var_headers := var_parsed_args.array_get('headers')
	mut var_data := var_parsed_args.array_get('body')
	mut var_type := var_parsed_args.array_get('method')
	mut var_options := { 'timeout': var_parsed_args.array_get('timeout'), 'useragent': var_parsed_args.array_get('user-agent'), 'blocking': var_parsed_args.array_get('blocking'), 'hooks': create_wp_http_requests_hooks(var_url_mutated.dup(), var_parsed_args.dup()) }
	rt.call_method(var_options.array_get('hooks'), 'register', [rt.new_string('requests.before_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: Class_static.class() }, rt.ArrayItem{ key: none, val: 'browser_redirect_compatibility' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_kses_bad_protocol')])) && rt.is_true(var_parsed_args.array_get('reject_unsafe_urls')))) {
		rt.call_method(var_options.array_get('hooks'), 'register', [rt.new_string('requests.before_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: Class_static.class() }, rt.ArrayItem{ key: none, val: 'validate_redirects' }])])
	}
	if rt.is_true(var_parsed_args.array_get('stream')) {
		var_options['filename'] = var_parsed_args.array_get('filename')
	}
	if !rt.is_true(var_parsed_args.array_get('redirection')) {
		var_options['follow_redirects'] = rt.new_bool(false)
	} else {
		var_options['redirects'] = var_parsed_args.array_get('redirection')
	}
	if var_parsed_args.array_isset(rt.new_string('limit_response_size')) {
		var_options['max_bytes'] = var_parsed_args.array_get('limit_response_size')
	}
	if !(!rt.is_true(var_parsed_args.array_get('cookies'))) {
		var_options['cookies'] = Class_WP_Http.normalize_cookies(var_parsed_args.array_get('cookies'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get('sslverify'))))) {
		var_options['verify'] = rt.new_bool(false)
		var_options['verifyname'] = rt.new_bool(false)
	} else {
		var_options['verify'] = var_parsed_args.array_get('sslcertificates')
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_options['data_format'] = rt.new_string('body')
	}
	var_options['verify'] = rt.call_function('apply_filters', [rt.new_string('https_ssl_verify'), var_options.array_get('verify'), var_url_mutated.dup()])
	mut var_proxy := create_wp_http_proxy()
	if rt.is_true(rt.new_bool(rt.is_true(var_proxy.is_enabled()) && rt.is_true(var_proxy.send_through_proxy(var_url_mutated.dup())))) {
		var_options['proxy'] = create_wporg_requests_proxy_http((var_proxy.host()).str() + ':' + (var_proxy.port()).str())
		if rt.is_true(var_proxy.use_authentication()) {
			rt.set_property(var_options.array_get('proxy'), 'use_authentication', rt.new_bool(true))
			rt.set_property(var_options.array_get('proxy'), 'user', var_proxy.username())
			rt.set_property(var_options.array_get('proxy'), 'pass', var_proxy.password())
		}
	}
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	mut var_requests_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Requests{}; return temp.request(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_url_mutated.dup(), var_headers.dup(), var_data.dup(), var_type.dup(), var_options.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_http_response := create_wp_http_requests_response(var_requests_response.dup(), var_parsed_args.array_get('filename'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_response = var_http_response.to_array()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_response.array_set('http_response', var_http_response.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WpOrg_Requests_Exception') {
		mut var_e := var_e_1.dup()
		var_response = create_wp_error(rt.new_string('http_request_failed'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('http_api_debug'), var_response.dup(), rt.new_string('response'), rt.new_string('WpOrg\\Requests\\Requests'), var_parsed_args.dup(), var_url_mutated.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		return var_response.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get('blocking'))))) {
		return rt.create_array([rt.ArrayItem{ key: 'headers', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'body', val: '' }, rt.ArrayItem{ key: 'response', val: rt.create_array([rt.ArrayItem{ key: 'code', val: false }, rt.ArrayItem{ key: 'message', val: false }]) }, rt.ArrayItem{ key: 'cookies', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'http_response', val: rt.new_null() }])
	}
	return rt.call_function('apply_filters', [rt.new_string('http_response'), var_response.dup(), var_parsed_args.dup(), var_url_mutated.dup()])
}

fn Class_WP_Http.normalize_cookies(var_cookies rt.PhpVal) rt.PhpVal {
	mut var_cookies_mutated := var_cookies
	mut var_cookie_jar := create_wporg_requests_cookie_jar()
	{
		mut iter_1 := var_cookies_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_name := item_1.key
			if rt.is_true(rt.new_bool(rt.instance_of(var_value, 'WP_Http_Cookie'))) {
				closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_attr := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
				mut var_attributes := rt.call_function('array_filter', [rt.call_method(var_value, 'get_attributes', []rt.PhpVal{}), rt.new_closure(closure_1_fn)])
				var_cookie_jar.array_set(rt.get_property(var_value, 'name'), create_wporg_requests_cookie(// unsupported expression: Expr_Cast_String, rt.get_property(var_value, 'value'), var_attributes.dup(), rt.create_array([rt.ArrayItem{ key: 'host-only', val: rt.get_property(var_value, 'host_only') }])))
			} else if rt.is_true(rt.call_function('is_scalar', [var_value.dup()])) {
				var_cookie_jar.array_set(var_name, create_wporg_requests_cookie(// unsupported expression: Expr_Cast_String, // unsupported expression: Expr_Cast_String))
			}
		}
	}
	return var_cookie_jar.dup()
}

fn Class_WP_Http.browser_redirect_compatibility(var_location rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal, var_original rt.PhpVal)  {
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut var_options_mutated := var_options
	if rt.is_true(rt.identical(rt.new_int(302), rt.get_property(var_original, 'status_code'))) {
		var_options_mutated.array_set('type', Class_WpOrg_Requests_Requests.get())
	}
}

fn Class_WP_Http.validate_redirects(var_location rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_http_validate_url', [var_location.dup()]))))) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.call_function('__', [rt.new_string('A valid URL was not provided.')]), rt.new_string('wp_http.redirect_failed_validation'))))
	}
}

fn (mut this Class_WP_Http) _get_first_available_transport(var_args rt.PhpVal, var_url rt.PhpVal) bool {
	mut var_args_mutated := var_args
	mut var_url_mutated := var_url
	mut var_transports := rt.create_array([rt.ArrayItem{ key: none, val: 'curl' }, rt.ArrayItem{ key: none, val: 'streams' }])
	mut var_request_order := rt.call_function('apply_filters_deprecated', [rt.new_string('http_api_transports'), rt.create_array([rt.ArrayItem{ key: none, val: var_transports }, rt.ArrayItem{ key: none, val: var_args_mutated }, rt.ArrayItem{ key: none, val: var_url_mutated }]), rt.new_string('6.4.0')])
	{
		mut iter_1 := var_request_order.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_transport := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_transport.dup(), var_transports.dup(), rt.new_bool(true)])) {
				var_transport = rt.call_function('ucfirst', [var_transport.dup()])
			}
			mut var_class := rt.new_string('WP_Http_' + (var_transport).str())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: var_class }, rt.ArrayItem{ key: none, val: 'test' }]), var_args_mutated.dup(), var_url_mutated.dup()]))))) {
				continue
			}
			return (var_class).to_bool()
		}
	}
	return false
}

fn (mut this Class_WP_Http) _dispatch_request(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_transports := rt.new_null()
	mut var_url_mutated := var_url
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Static
	mut var_class := rt.new_bool(this._get_first_available_transport(var_args_mutated.dup(), var_url_mutated.dup()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_class)))) {
		return create_wp_error(rt.new_string('http_failure'), rt.call_function('__', [rt.new_string('There are no HTTP transports available which can complete the requested request.')]))
	}
	if !rt.is_true(var_transports.array_get(var_class)) {
		var_transports.array_set(var_class, rt.create_object_dynamically(var_class, []rt.PhpVal{}))
	}
	mut var_response := rt.call_method(var_transports.array_get(var_class), 'request', [var_url_mutated.dup(), var_args_mutated.dup()])
	rt.call_function('do_action', [rt.new_string('http_api_debug'), var_response.dup(), rt.new_string('response'), var_class.dup(), var_args_mutated.dup(), var_url_mutated.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		return var_response.dup()
	}
	return rt.call_function('apply_filters', [rt.new_string('http_response'), var_response.dup(), var_args_mutated.dup(), var_url_mutated.dup()])
}

fn (mut this Class_WP_Http) post(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_args_mutated := var_args
	mut var_defaults := { 'method': rt.new_string('POST') }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_defaults.dup()])
	return this.request(var_url_mutated.dup(), var_parsed_args.dup())
}

fn (mut this Class_WP_Http) get(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_args_mutated := var_args
	mut var_defaults := { 'method': rt.new_string('GET') }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_defaults.dup()])
	return this.request(var_url_mutated.dup(), var_parsed_args.dup())
}

fn (mut this Class_WP_Http) head(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_args_mutated := var_args
	mut var_defaults := { 'method': rt.new_string('HEAD') }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_defaults.dup()])
	return this.request(var_url_mutated.dup(), var_parsed_args.dup())
}

fn Class_WP_Http.processresponse(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	var_response_mutated = rt.call_function('explode', [, .dup(), ])
	return rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
}

fn Class_WP_Http.processheaders(var_headers rt.PhpVal, url string) rt.PhpVal {
	mut var_headers_mutated := var_headers
	mut url_mutated := url
	if rt.is_true() {
	}
	
}

fn Class_WP_Http.buildcookieheader(var_r rt.PhpVal)  {
}

fn Class_WP_Http.chunktransferdecode(var_body rt.PhpVal) rt.PhpVal {
	mut var_match := []rt.PhpVal{}
	mut var_body_mutated := var_body
	return rt.new_null()
}

fn (mut this Class_WP_Http) block_request(var_uri rt.PhpVal) bool {
	return false
}

fn Class_WP_Http.parse_url(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
}

fn Class_WP_Http.make_absolute_url(var_maybe_relative_path rt.PhpVal, var_url rt.PhpVal) string {
	mut var_url_mutated := var_url
}

fn Class_WP_Http.handle_redirects(var_url rt.PhpVal, var_args rt.PhpVal, var_response rt.PhpVal) bool {
	mut var_url_mutated := var_url
	mut var_args_mutated := var_args
	mut var_response_mutated := var_response
}

fn Class_WP_Http.is_ip_address(var_maybe_ip rt.PhpVal) rt.PhpVal {
}

struct Class_WpOrg_Requests_Autoload {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Requests {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_HTTP_Requests_Hooks {
	rt.PhpObjectBase
}

struct Class_WP_HTTP_Proxy {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Proxy_Http {
	rt.PhpObjectBase
}

struct Class_WP_HTTP_Requests_Response {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Cookie_Jar {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Cookie {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

fn create_wp_http() &Class_WP_Http {
	mut obj := &Class_WP_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_autoload() &Class_WpOrg_Requests_Autoload {
	mut obj := &Class_WpOrg_Requests_Autoload{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_requests() &Class_WpOrg_Requests_Requests {
	mut obj := &Class_WpOrg_Requests_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_requests_hooks() &Class_WP_HTTP_Requests_Hooks {
	mut obj := &Class_WP_HTTP_Requests_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_proxy() &Class_WP_HTTP_Proxy {
	mut obj := &Class_WP_HTTP_Proxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_proxy_http() &Class_WpOrg_Requests_Proxy_Http {
	mut obj := &Class_WpOrg_Requests_Proxy_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_requests_response() &Class_WP_HTTP_Requests_Response {
	mut obj := &Class_WP_HTTP_Requests_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_cookie_jar() &Class_WpOrg_Requests_Cookie_Jar {
	mut obj := &Class_WpOrg_Requests_Cookie_Jar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_cookie() &Class_WpOrg_Requests_Cookie {
	mut obj := &Class_WpOrg_Requests_Cookie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception() &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.request(dispatch_arg_0, dispatch_arg_1)
		}
		'normalize_cookies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Http.normalize_cookies(dispatch_arg_0)
		}
		'browser_redirect_compatibility' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			Class_WP_Http.browser_redirect_compatibility(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'validate_redirects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Http.validate_redirects(dispatch_arg_0)
			return rt.new_null()
		}
		'_get_first_available_transport' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._get_first_available_transport(dispatch_arg_0, dispatch_arg_1))
		}
		'_dispatch_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._dispatch_request(dispatch_arg_0, dispatch_arg_1)
		}
		'post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.post(dispatch_arg_0, dispatch_arg_1)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'head' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.head(dispatch_arg_0, dispatch_arg_1)
		}
		'processResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Http.processresponse(dispatch_arg_0)
		}
		'processHeaders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WP_Http.processheaders(dispatch_arg_0, dispatch_arg_1)
		}
		'buildCookieHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Http.buildcookieheader(dispatch_arg_0)
			return rt.new_null()
		}
		'chunkTransferDecode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Http.chunktransferdecode(dispatch_arg_0)
		}
		'block_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.block_request(dispatch_arg_0))
		}
		'parse_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Http.parse_url(dispatch_arg_0)
		}
		'make_absolute_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Http.make_absolute_url(dispatch_arg_0, dispatch_arg_1))
		}
		'handle_redirects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Http.handle_redirects(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'is_ip_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Http.is_ip_address(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Autoload) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Autoload) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Autoload) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTTP_Requests_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTTP_Requests_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Requests_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTTP_Proxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTTP_Proxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Proxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Proxy_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Proxy_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTTP_Requests_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTTP_Requests_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Requests_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Cookie_Jar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Cookie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Cookie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Cookie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WP_Http', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_http()
		return rt.new_object('WP_Http', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Autoload', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_autoload()
		return rt.new_object('WpOrg_Requests_Autoload', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Requests', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_requests()
		return rt.new_object('WpOrg_Requests_Requests', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WP_HTTP_Requests_Hooks', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_http_requests_hooks()
		return rt.new_object('WP_HTTP_Requests_Hooks', []string{}, obj)
	})
	rt.register_class_factory('WP_HTTP_Proxy', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_http_proxy()
		return rt.new_object('WP_HTTP_Proxy', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Proxy_Http', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_proxy_http()
		return rt.new_object('WpOrg_Requests_Proxy_Http', []string{}, obj)
	})
	rt.register_class_factory('WP_HTTP_Requests_Response', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_http_requests_response()
		return rt.new_object('WP_HTTP_Requests_Response', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Cookie_Jar', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_cookie_jar()
		return rt.new_object('WpOrg_Requests_Cookie_Jar', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Cookie', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_cookie()
		return rt.new_object('WpOrg_Requests_Cookie', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception()
		return rt.new_object('WpOrg_Requests_Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_class_wp_http_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WpOrg\\Requests\\Autoload')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/Requests/src/Autoload.php', '3')
		fn () rt.PhpVal { mut temp := Class_WpOrg_Requests_Autoload{}; return temp.register() }()
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Requests{}; return temp.set_certificate_path(arg_0) }(rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/certificates/ca-bundle.crt'))
	}
}
