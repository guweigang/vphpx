import rt

pub fn Class_WpOrg_Requests_Transport_Curl.curl_7_10_5() i64 {
	return 461317
}
pub fn Class_WpOrg_Requests_Transport_Curl.curl_7_16_2() i64 {
	return 462850
}
struct Class_WpOrg_Requests_Transport_Curl {
	rt.PhpObjectBase
pub mut:
		headers string
		response_data string
		info rt.PhpVal = rt.new_null()
		version rt.PhpVal = rt.new_null()
		handle rt.PhpVal = rt.new_null()
		hooks rt.PhpVal = rt.new_null()
		done_headers bool
		stream_handle rt.PhpVal = rt.new_null()
		response_bytes i64
		response_byte_limit rt.PhpVal = rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) construct()  {
	mut var_curl := rt.call_function('curl_version', []rt.PhpVal{})
	this.version = var_curl.array_get('version_number')
	this.handle = rt.call_function('curl_init', []rt.PhpVal{})
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HEADER'), rt.new_bool(false)])
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_RETURNTRANSFER'), rt.new_int(1)])
	if rt.is_true(rt.greater_equal(this.version, Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Curl.curl_7_10_5())) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_ENCODING'), rt.new_string('')])
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('CURLOPT_PROTOCOLS')])) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_PROTOCOLS'), rt.bitwise_or(rt.get_constant('CURLPROTO_HTTP'), rt.get_constant('CURLPROTO_HTTPS'))])
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('CURLOPT_REDIR_PROTOCOLS')])) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_REDIR_PROTOCOLS'), rt.bitwise_or(rt.get_constant('CURLPROTO_HTTP'), rt.get_constant('CURLPROTO_HTTPS'))])
	}
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) magic_destruct()  {
	if rt.is_true(rt.call_function('is_resource', [this.handle])) {
		rt.call_function('curl_close', [this.handle])
	}
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) request(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) string {
	mut var_url_mutated := var_url
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut var_options_mutated := var_options
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_string_or_stringable(arg_0) }(var_url_mutated.dup()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$url'), rt.new_string('string|Stringable'), rt.call_function('gettype', [var_url_mutated.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_headers_mutated.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$headers'), rt.new_string('array'), rt.call_function('gettype', [var_headers_mutated.dup()])))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.dup().is_array()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.dup().is_string()))))))) {
		if rt.is_true(rt.identical(var_data_mutated, rt.new_null())) {
			var_data_mutated = rt.new_string(rt.new_string(''))
		} else {
			rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(3), rt.new_string('$data'), rt.new_string('array|string'), rt.call_function('gettype', [var_data_mutated.dup()])))
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options_mutated.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(4), rt.new_string('$options'), rt.new_string('array'), rt.call_function('gettype', [var_options_mutated.dup()])))
	}
	this.hooks = var_options_mutated.array_get('hooks')
	this.setup_handle(var_url_mutated.dup(), var_headers_mutated.dup(), var_data_mutated.dup(), var_options_mutated.dup())
	rt.call_method(var_options_mutated.array_get('hooks'), 'dispatch', [rt.new_string('curl.before_send'), rt.create_array([rt.ArrayItem{ key: none, val: this.handle }])])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.stream_handle = rt.call_function('fopen', [var_options_mutated.array_get('filename'), rt.new_string('wb')])
		if rt.is_true(rt.identical(this.stream_handle, rt.new_bool(false))) {
			mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_error.array_get('message'), rt.new_string('fopen'))))
		}
	}
	this.response_data = ''
	this.response_bytes = 0
	this.response_byte_limit = rt.new_bool(false)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.response_byte_limit = var_options_mutated.array_get('max_bytes')
	}
	if var_options_mutated.array_isset(rt.new_string('verify')) {
		if rt.is_true(rt.identical(var_options_mutated.array_get('verify'), rt.new_bool(false))) {
			rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_SSL_VERIFYHOST'), rt.new_int(0)])
			rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_SSL_VERIFYPEER'), rt.new_int(0)])
		} else if rt.is_true(rt.new_bool(var_options_mutated.array_get('verify').is_string())) {
			rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_CAINFO'), var_options_mutated.array_get('verify')])
		}
	}
	if rt.is_true(rt.new_bool(var_options_mutated.array_isset(rt.new_string('verifyname')) && rt.is_true(rt.identical(var_options_mutated.array_get('verifyname'), rt.new_bool(false))))) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_SSL_VERIFYHOST'), rt.new_int(0)])
	}
	rt.call_function('curl_exec', [this.handle])
	mut var_response := rt.new_string(this.response_data)
	rt.call_method(var_options_mutated.array_get('hooks'), 'dispatch', [rt.new_string('curl.after_send'), rt.new_array()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('curl_errno', [this.handle]), rt.get_constant('CURLE_WRITE_ERROR'))) || rt.is_true(rt.identical(rt.call_function('curl_errno', [this.handle]), rt.get_constant('CURLE_BAD_CONTENT_ENCODING'))))) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_ENCODING'), rt.new_string('none')])
		this.response_data = ''
		this.response_bytes = 0
		rt.call_function('curl_exec', [this.handle])
		var_response = rt.new_string(this.response_data)
	}
	this.process_response(var_response.dup(), var_options_mutated.dup())
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HEADERFUNCTION'), rt.new_null()])
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_WRITEFUNCTION'), rt.new_null()])
	return this.headers
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) request_multiple(var_requests rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	if !rt.is_true(var_requests) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.has_array_access(arg_0) }(var_requests.dup()), rt.new_bool(false))) || rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_iterable(arg_0) }(var_requests.dup()), rt.new_bool(false))))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$requests'), rt.new_string('array|ArrayAccess&Traversable'), rt.call_function('gettype', [var_requests.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options_mutated.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$options'), rt.new_string('array'), rt.call_function('gettype', [var_options_mutated.dup()])))
	}
	mut var_multihandle := rt.call_function('curl_multi_init', []rt.PhpVal{})
	mut var_subrequests := rt.new_array()
	mut var_subhandles := rt.new_array()
	mut var_class := rt.call_function('get_class', [rt.new_object('WpOrg_Requests_Transport_Curl', ['Transport'], &this)])
	{
		mut iter_1 := var_requests.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_request := item_1.val
			mut var_id := item_1.key
			var_subrequests.array_set(var_id, rt.create_object_dynamically(var_class, []rt.PhpVal{}))
			var_subhandles.array_set(var_id, rt.call_method(var_subrequests.array_get(var_id), 'get_subrequest_handle', [var_request.array_get('url'), var_request.array_get('headers'), var_request.array_get('data'), var_request.array_get('options')]))
			rt.call_method(var_request.array_get('options').array_get('hooks'), 'dispatch', [rt.new_string('curl.before_multi_add'), rt.create_array([rt.ArrayItem{ key: none, val: var_subhandles.array_get(var_id) }])])
			rt.call_function('curl_multi_add_handle', [var_multihandle.dup(), var_subhandles.array_get(var_id)])
		}
	}
	mut var_completed := rt.new_int(rt.new_int(0))
	mut var_responses := rt.new_array()
	mut var_subrequestcount := rt.new_int(rt.new_int(var_subrequests.dup().array_count()))
	rt.call_method(var_request.array_get('options').array_get('hooks'), 'dispatch', [rt.new_string('curl.before_multi_exec'), rt.create_array([rt.ArrayItem{ key: none, val: var_multihandle }])])
	for {
		mut var_active := rt.new_int(rt.new_int(0))
		for {
			mut var_status := rt.call_function('curl_multi_exec', [var_multihandle.dup(), var_active.dup()])
			if !(rt.is_true(rt.identical(var_status, rt.get_constant('CURLM_CALL_MULTI_PERFORM')))) {
				break
			}
		}
		mut var_to_process := rt.new_array()
		for rt.is_true(mut var_done := rt.call_function('curl_multi_info_read', [var_multihandle.dup()])) {
			mut var_key := rt.call_function('array_search', [var_done.array_get('handle'), var_subhandles.dup(), rt.new_bool(true)])
			if !(var_to_process.array_isset(var_key)) {
				var_to_process.array_set(var_key, var_done.dup())
			}
		}
		{
			mut iter_1 := var_to_process.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_done_shadow := item_1.val
				mut var_key_shadow := item_1.key
				var_options_mutated = var_requests.array_get(var_key_shadow).array_get('options')
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					mut var_reason := rt.call_function('curl_error', [var_done_shadow.array_get('handle')])
					mut var_exception := create_wporg_requests_exception_transport_curl(var_reason.dup(), Class_WpOrg_Requests_Exception_Transport_Curl.easy(), var_done_shadow.array_get('handle'), var_done_shadow.array_get('result'))
					var_responses.array_set(var_key_shadow, var_exception.dup())
					rt.call_method(var_options_mutated.array_get('hooks'), 'dispatch', [rt.new_string('transport.internal.parse_error'), rt.create_array([rt.ArrayItem{ key: none, val: var_responses.array_get(var_key_shadow) }, rt.ArrayItem{ key: none, val: var_requests.array_get(var_key_shadow) }])])
				} else {
					var_responses.array_set(var_key_shadow, rt.call_method(var_subrequests.array_get(var_key_shadow), 'process_response', [rt.get_property(var_subrequests.array_get(var_key_shadow), 'response_data'), var_options_mutated.dup()]))
					rt.call_method(var_options_mutated.array_get('hooks'), 'dispatch', [rt.new_string('transport.internal.parse_response'), rt.create_array([rt.ArrayItem{ key: none, val: var_responses.array_get(var_key_shadow) }, rt.ArrayItem{ key: none, val: var_requests.array_get(var_key_shadow) }])])
				}
				rt.call_function('curl_multi_remove_handle', [var_multihandle.dup(), var_done_shadow.array_get('handle')])
				if rt.is_true(rt.call_function('is_resource', [var_done_shadow.array_get('handle')])) {
					rt.call_function('curl_close', [var_done_shadow.array_get('handle')])
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_responses.array_get(var_key_shadow).is_string()))))) {
					rt.call_method(var_options_mutated.array_get('hooks'), 'dispatch', [rt.new_string('multiple.request.complete'), rt.create_array([rt.ArrayItem{ key: none, val: var_responses.array_get(var_key_shadow) }, rt.ArrayItem{ key: none, val: var_key_shadow }])])
				}
				rt.post_inc(var_completed)
			}
		}
		if !(rt.is_true(rt.new_bool(rt.is_true(var_active) || rt.is_true(rt.less(var_completed, var_subrequestcount))))) {
			break
		}
	}
	rt.call_method(var_request.array_get('options').array_get('hooks'), 'dispatch', [rt.new_string('curl.after_multi_exec'), rt.create_array([rt.ArrayItem{ key: none, val: var_multihandle }])])
	rt.call_function('curl_multi_close', [var_multihandle.dup()])
	return var_responses.dup()
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) get_subrequest_handle(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut var_options_mutated := var_options
	this.setup_handle(var_url_mutated.dup(), var_headers_mutated.dup(), var_data_mutated.dup(), var_options_mutated.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.stream_handle = rt.call_function('fopen', [var_options_mutated.array_get('filename'), rt.new_string('wb')])
	}
	this.response_data = ''
	this.response_bytes = 0
	this.response_byte_limit = rt.new_bool(false)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.response_byte_limit = var_options_mutated.array_get('max_bytes')
	}
	this.hooks = var_options_mutated.array_get('hooks')
	return this.handle
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) setup_handle(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal)  {
	mut var_url_mutated := var_url
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut var_options_mutated := var_options
	rt.call_method(, 'dispatch', [, ])
	if !(.array_isset()) {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) process_response(var_response rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_options_mutated := var_options
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) stream_headers(var_handle rt.PhpVal, var_headers rt.PhpVal) i64 {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) stream_body(var_handle rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn Class_WpOrg_Requests_Transport_Curl.format_get(var_url rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_data_mutated := var_data
}

fn Class_WpOrg_Requests_Transport_Curl.test(var_capabilities rt.PhpVal) bool {
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) get_expect_header(var_data rt.PhpVal) string {
	mut var_data_mutated := var_data
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_Transport_Curl {
	rt.PhpObjectBase
}

fn create_wporg_requests_transport_curl() &Class_WpOrg_Requests_Transport_Curl {
	mut obj := &Class_WpOrg_Requests_Transport_Curl{
		PhpObjectBase: rt.PhpObjectBase{}
		headers: ''
		response_data: ''
		info: rt.new_null()
		version: rt.new_null()
		handle: rt.new_null()
		hooks: rt.new_null()
		done_headers: false
		stream_handle: rt.new_null()
		response_bytes: i64(0)
		response_byte_limit: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wporg_requests_utility_inputvalidator() &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
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

fn create_wporg_requests_exception_transport_curl() &Class_WpOrg_Requests_Exception_Transport_Curl {
	mut obj := &Class_WpOrg_Requests_Exception_Transport_Curl{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(this.request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'request_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.request_multiple(dispatch_arg_0, dispatch_arg_1)
		}
		'get_subrequest_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_subrequest_handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'setup_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.setup_handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'process_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.process_response(dispatch_arg_0, dispatch_arg_1)
		}
		'stream_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.stream_headers(dispatch_arg_0, dispatch_arg_1))
		}
		'stream_body' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.stream_body(dispatch_arg_0, dispatch_arg_1)
		}
		'format_get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WpOrg_Requests_Transport_Curl.format_get(dispatch_arg_0, dispatch_arg_1)
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Transport_Curl.test(dispatch_arg_0))
		}
		'get_expect_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_expect_header(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Transport_Curl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'headers' { return rt.new_string(this.headers) }
		'response_data' { return rt.new_string(this.response_data) }
		'info' { return this.info }
		'version' { return this.version }
		'handle' { return this.handle }
		'hooks' { return this.hooks }
		'done_headers' { return rt.new_bool(this.done_headers) }
		'stream_handle' { return this.stream_handle }
		'response_bytes' { return rt.new_int(this.response_bytes) }
		'response_byte_limit' { return this.response_byte_limit }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'headers' { this.headers = (val).str(); return true }
		'response_data' { this.response_data = (val).str(); return true }
		'info' { this.info = val; return true }
		'version' { this.version = val; return true }
		'handle' { this.handle = val; return true }
		'hooks' { this.hooks = val; return true }
		'done_headers' { this.done_headers = (val).to_bool(); return true }
		'stream_handle' { this.stream_handle = val; return true }
		'response_bytes' { this.response_bytes = (val).to_i64(); return true }
		'response_byte_limit' { this.response_byte_limit = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WpOrg_Requests_Exception_Transport_Curl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_Transport_Curl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_Transport_Curl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WpOrg_Requests_Transport_Curl', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_transport_curl()
		return rt.new_object('WpOrg_Requests_Transport_Curl', ['Transport'], obj)
	})
	rt.register_class_factory('WpOrg_Requests_Utility_InputValidator', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_utility_inputvalidator()
		return rt.new_object('WpOrg_Requests_Utility_InputValidator', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception_InvalidArgument', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception_invalidargument()
		return rt.new_object('WpOrg_Requests_Exception_InvalidArgument', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception()
		return rt.new_object('WpOrg_Requests_Exception', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception_Transport_Curl', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception_transport_curl()
		return rt.new_object('WpOrg_Requests_Exception_Transport_Curl', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_requests_src_transport_curl_php() {
}
