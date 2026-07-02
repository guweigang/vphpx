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
	headers             string
	response_data       string
	info                rt.PhpVal = rt.new_null()
	version             rt.PhpVal = rt.new_null()
	handle              rt.PhpVal = rt.new_null()
	hooks               rt.PhpVal = rt.new_null()
	done_headers        bool
	stream_handle       rt.PhpVal = rt.new_null()
	response_bytes      i64
	response_byte_limit rt.PhpVal = rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) construct() {
	mut var_curl := rt.call_function('curl_version', []rt.PhpVal{})
	this.version = var_curl.array_get(rt.new_string('version_number'))
	this.handle = rt.call_function('curl_init', []rt.PhpVal{})
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HEADER'),
		rt.new_bool(false)])
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_RETURNTRANSFER'),
		rt.new_int(1)])
	if rt.is_true(rt.greater_equal(this.version,
		Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Curl.curl_7_10_5()))
	{
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_ENCODING'),
			rt.new_string('')])
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('CURLOPT_PROTOCOLS')])) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_PROTOCOLS'),
			rt.bitwise_or(rt.get_constant('CURLPROTO_HTTP'), rt.get_constant('CURLPROTO_HTTPS'))])
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('CURLOPT_REDIR_PROTOCOLS')])) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_REDIR_PROTOCOLS'),
			rt.bitwise_or(rt.get_constant('CURLPROTO_HTTP'), rt.get_constant('CURLPROTO_HTTPS'))])
	}
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) magic_destruct() {
	if rt.is_true(rt.call_function('is_resource', [this.handle])) {
		rt.call_function('curl_close', [this.handle])
	}
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) request(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) string {
	mut var_url_mutated := var_url
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut var_options_mutated := var_options
	mut iife_temp_0 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_0 := iife_temp_0.is_string_or_stringable(var_url_mutated.clone())
	if rt.is_true(rt.identical(iife_result_0, rt.new_bool(false))) {
		mut iife_temp_1 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_1 := iife_temp_1.create(rt.new_int(1), rt.new_string('$url'),
			rt.new_string('string|Stringable'), rt.call_function('gettype', [
			var_url_mutated.clone()]))
		rt.throw_exception(iife_result_1)
	}
	if rt.is_true(rt.identical(rt.new_bool(var_headers_mutated.clone().is_array()),
		rt.new_bool(false)))
	{
		mut iife_temp_2 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_2 := iife_temp_2.create(rt.new_int(2), rt.new_string('$headers'),
			rt.new_string('array'), rt.call_function('gettype', [
			var_headers_mutated.clone()]))
		rt.throw_exception(iife_result_2)
	}
	if !(var_data_mutated.clone().is_array()) && !(var_data_mutated.clone().is_string()) {
		if rt.is_true(rt.identical(var_data_mutated, rt.new_null())) {
			var_data_mutated = rt.new_string('')
		} else {
			mut iife_temp_3 := Class_WpOrg_Requests_Exception_InvalidArgument{}
			mut iife_result_3 := iife_temp_3.create(rt.new_int(3), rt.new_string('$data'),
				rt.new_string('array|string'), rt.call_function('gettype', [
				var_data_mutated.clone()]))
			rt.throw_exception(iife_result_3)
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options_mutated.clone().is_array()),
		rt.new_bool(false)))
	{
		mut iife_temp_4 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_4 := iife_temp_4.create(rt.new_int(4), rt.new_string('$options'),
			rt.new_string('array'), rt.call_function('gettype', [
			var_options_mutated.clone()]))
		rt.throw_exception(iife_result_4)
	}
	this.hooks = var_options_mutated.array_get(rt.new_string('hooks'))
	this.setup_handle(var_url_mutated.clone(), var_headers_mutated.clone(),
		var_data_mutated.clone(), var_options_mutated.clone())
	rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('curl.before_send'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.handle }]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('filename')),
		rt.new_bool(false)))))
	{
		this.stream_handle = rt.call_function('fopen', [
			var_options_mutated.array_get(rt.new_string('filename')),
			rt.new_string('wb'),
		])
		if rt.is_true(rt.identical(this.stream_handle, rt.new_bool(false))) {
			mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_error.array_get(rt.new_string('message')),
				rt.new_string('fopen'))))
		}
	}
	this.response_data = ''
	this.response_bytes = 0
	this.response_byte_limit = rt.new_bool(false)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('max_bytes')),
		rt.new_bool(false)))))
	{
		this.response_byte_limit = var_options_mutated.array_get(rt.new_string('max_bytes'))
	}
	if var_options_mutated.array_isset(rt.new_string('verify')) {
		if rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('verify')),
			rt.new_bool(false)))
		{
			rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_SSL_VERIFYHOST'),
				rt.new_int(0)])
			rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_SSL_VERIFYPEER'),
				rt.new_int(0)])
		} else if rt.is_true(rt.new_bool(var_options_mutated.array_get(rt.new_string('verify')).is_string())) {
			rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_CAINFO'),
				var_options_mutated.array_get(rt.new_string('verify'))])
		}
	}
	if var_options_mutated.array_isset(rt.new_string('verifyname'))
		&& rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('verifyname')), rt.new_bool(false))) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_SSL_VERIFYHOST'),
			rt.new_int(0)])
	}
	rt.call_function('curl_exec', [this.handle])
	mut var_response := rt.new_string(this.response_data)
	rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('curl.after_send'),
		rt.new_array(),
	])
	if rt.is_true(rt.identical(rt.call_function('curl_errno', [this.handle]), rt.get_constant('CURLE_WRITE_ERROR')))
		|| rt.is_true(rt.identical(rt.call_function('curl_errno', [this.handle]), rt.get_constant('CURLE_BAD_CONTENT_ENCODING'))) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_ENCODING'),
			rt.new_string('none')])
		this.response_data = ''
		this.response_bytes = 0
		rt.call_function('curl_exec', [this.handle])
		var_response = rt.new_string(this.response_data)
	}
	this.process_response(var_response.clone(), var_options_mutated.clone())
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HEADERFUNCTION'),
		rt.new_null()])
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_WRITEFUNCTION'),
		rt.new_null()])
	return this.headers
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) request_multiple(var_requests rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	if !rt.is_true(var_requests) {
		return rt.new_array()
	}
	mut iife_temp_5 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_5 := iife_temp_5.has_array_access(var_requests.clone())
	mut iife_temp_6 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_6 := iife_temp_6.is_iterable(var_requests.clone())
	if rt.is_true(rt.identical(iife_result_5, rt.new_bool(false)))
		|| rt.is_true(rt.identical(iife_result_6, rt.new_bool(false))) {
		mut iife_temp_7 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_7 := iife_temp_7.create(rt.new_int(1), rt.new_string('$requests'),
			rt.new_string('array|ArrayAccess&Traversable'), rt.call_function('gettype', [
			var_requests.clone(),
		]))
		rt.throw_exception(iife_result_7)
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options_mutated.clone().is_array()),
		rt.new_bool(false)))
	{
		mut iife_temp_8 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_8 := iife_temp_8.create(rt.new_int(2), rt.new_string('$options'),
			rt.new_string('array'), rt.call_function('gettype', [
			var_options_mutated.clone()]))
		rt.throw_exception(iife_result_8)
	}
	mut var_multihandle := rt.call_function('curl_multi_init', []rt.PhpVal{})
	mut var_subrequests := rt.new_array()
	mut var_subhandles := rt.new_array()
	mut var_class := rt.call_function('get_class', [
		rt.new_object('WpOrg_Requests_Transport_Curl', ['Transport'], &this),
	])
	mut iter_1 := var_requests.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_request := item_1.val
		mut var_id := item_1.key
		var_subrequests.array_set(var_id, rt.create_object_dynamically(var_class, []rt.PhpVal{}))
		var_subhandles.array_set(var_id, rt.call_method(var_subrequests.array_get(var_id),
			'get_subrequest_handle', [var_request.array_get(rt.new_string('url')),
			var_request.array_get(rt.new_string('headers')), var_request.array_get(rt.new_string('data')),
			var_request.array_get(rt.new_string('options'))]))
		rt.call_method(var_request.array_get(rt.new_string('options')).array_get(rt.new_string('hooks')),
			'dispatch', [rt.new_string('curl.before_multi_add'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_subhandles.array_get(var_id) },
			])])
		rt.call_function('curl_multi_add_handle', [var_multihandle.clone(),
			var_subhandles.array_get(var_id)])
	}
	mut var_completed := rt.new_int(0)
	mut var_responses := rt.new_array()
	mut var_subrequestcount := rt.new_int(var_subrequests.clone().array_count())
	rt.call_method(var_request.array_get(rt.new_string('options')).array_get(rt.new_string('hooks')),
		'dispatch', [rt.new_string('curl.before_multi_exec'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_multihandle }])])
	for {
		mut var_active := rt.new_int(0)
		for {
			mut var_status := rt.call_function('curl_multi_exec', [
				var_multihandle.clone(), var_active.clone()])
			if !(rt.is_true(rt.identical(var_status, rt.get_constant('CURLM_CALL_MULTI_PERFORM')))) {
				break
			}
		}
		mut var_to_process := rt.new_array()
		mut var_done := rt.call_function('curl_multi_info_read', [
			var_multihandle.clone()])
		for rt.is_true(var_done) {
			mut var_key := rt.call_function('array_search', [
				var_done.array_get(rt.new_string('handle')),
				var_subhandles.clone(),
				rt.new_bool(true),
			])
			if !(var_to_process.array_isset(var_key)) {
				var_to_process.array_set(var_key, var_done.clone())
			}
		}
		mut iter_2 := var_to_process.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_done_shadow := item_2.val
			mut var_key_shadow := item_2.key
			var_options_mutated =
				var_requests.array_get(var_key_shadow).array_get(rt.new_string('options'))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_done_shadow.array_get(rt.new_string('result')),
				rt.get_constant('CURLE_OK')))))
			{
				mut var_reason := rt.call_function('curl_error', [
					var_done_shadow.array_get(rt.new_string('handle')),
				])
				mut var_exception := create_wporg_requests_exception_transport_curl(var_reason.clone(),
					Class_WpOrg_Requests_Exception_Transport_Curl.easy(),
					var_done_shadow.array_get(rt.new_string('handle')),
					var_done_shadow.array_get(rt.new_string('result')))
				var_responses.array_set(var_key_shadow, var_exception)
				rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
					rt.new_string('transport.internal.parse_error'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_responses.array_get(var_key_shadow) },
						rt.ArrayItem{ key: none, val: var_requests.array_get(var_key_shadow) },
					]),
				])
			} else {
				var_responses.array_set(var_key_shadow, rt.call_method(var_subrequests.array_get(var_key_shadow),
					'process_response', [
					rt.get_property(var_subrequests.array_get(var_key_shadow), 'response_data'),
					var_options_mutated.clone(),
				]))
				rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
					rt.new_string('transport.internal.parse_response'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_responses.array_get(var_key_shadow) },
						rt.ArrayItem{ key: none, val: var_requests.array_get(var_key_shadow) },
					]),
				])
			}
			rt.call_function('curl_multi_remove_handle', [var_multihandle.clone(),
				var_done_shadow.array_get(rt.new_string('handle'))])
			if rt.is_true(rt.call_function('is_resource', [
				var_done_shadow.array_get(rt.new_string('handle')),
			]))
			{
				rt.call_function('curl_close', [var_done_shadow.array_get(rt.new_string('handle'))])
			}
			if !(var_responses.array_get(var_key_shadow).is_string()) {
				rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
					rt.new_string('multiple.request.complete'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_responses.array_get(var_key_shadow) },
						rt.ArrayItem{ key: none, val: var_key_shadow },
					]),
				])
			}
			rt.post_inc(var_completed)
		}
		if !(rt.is_true(var_active) || rt.is_true(rt.less(var_completed, var_subrequestcount))) {
			break
		}
	}
	rt.call_method(var_request.array_get(rt.new_string('options')).array_get(rt.new_string('hooks')),
		'dispatch', [rt.new_string('curl.after_multi_exec'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_multihandle }])])
	rt.call_function('curl_multi_close', [var_multihandle.clone()])
	return var_responses.clone()
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) get_subrequest_handle(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut var_options_mutated := var_options
	this.setup_handle(var_url_mutated.clone(), var_headers_mutated.clone(),
		var_data_mutated.clone(), var_options_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('filename')),
		rt.new_bool(false)))))
	{
		this.stream_handle = rt.call_function('fopen', [
			var_options_mutated.array_get(rt.new_string('filename')),
			rt.new_string('wb'),
		])
	}
	this.response_data = ''
	this.response_bytes = 0
	this.response_byte_limit = rt.new_bool(false)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('max_bytes')),
		rt.new_bool(false)))))
	{
		this.response_byte_limit = var_options_mutated.array_get(rt.new_string('max_bytes'))
	}
	this.hooks = var_options_mutated.array_get(rt.new_string('hooks'))
	return this.handle
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) setup_handle(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) {
	mut var_url_mutated := var_url
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut var_options_mutated := var_options
	rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('curl.before_request'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.handle }]),
	])
	if !(var_headers_mutated.array_isset(rt.new_string('Connection'))) {
		var_headers_mutated.array_set('Connection', 'close')
	}
	if !(var_headers_mutated.array_isset(rt.new_string('Expect')))
		&& rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('protocol_version')), rt.new_float(1.1))) {
		var_headers_mutated.array_set('Expect', this.get_expect_header(var_data_mutated.clone()))
	}
	mut iife_temp_9 := Class_WpOrg_Requests_Requests{}
	mut iife_result_9 := iife_temp_9.flatten(var_headers_mutated.clone())
	var_headers_mutated = iife_result_9
	if !(!rt.is_true(var_data_mutated)) {
		mut var_data_format := var_options_mutated.array_get(rt.new_string('data_format'))
		if rt.is_true(rt.identical(var_data_format, rt.new_string('query'))) {
			var_url_mutated = Class_WpOrg_Requests_Transport_Curl.format_get(var_url_mutated.clone(),
				var_data_mutated.clone())
			var_data_mutated = rt.new_string('')
		} else if !(var_data_mutated.clone().is_string()) {
			var_data_mutated = rt.call_function('http_build_query', [
				var_data_mutated.clone(), rt.new_string(''), rt.new_string('&')])
		}
	}
	mut switch_val_1 := var_options_mutated.array_get(rt.new_string('type'))
	if rt.is_true(rt.equal(switch_val_1, Class_WpOrg_Requests_Requests.post())) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_POST'),
			rt.new_bool(true)])
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_POSTFIELDS'),
			var_data_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, Class_WpOrg_Requests_Requests.head())) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_CUSTOMREQUEST'),
			var_options_mutated.array_get(rt.new_string('type'))])
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_NOBODY'),
			rt.new_bool(true)])
	} else if rt.is_true(rt.equal(switch_val_1, Class_WpOrg_Requests_Requests.trace())) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_CUSTOMREQUEST'),
			var_options_mutated.array_get(rt.new_string('type'))])
	} else {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_CUSTOMREQUEST'),
			var_options_mutated.array_get(rt.new_string('type'))])
		if !(!rt.is_true(var_data_mutated)) {
			rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_POSTFIELDS'),
				var_data_mutated.clone()])
		}
	}
	mut var_timeout := rt.call_function('max', [var_options_mutated.array_get(rt.new_string('timeout')),
		rt.new_int(1)])
	if var_timeout.clone().is_long()
		|| rt.is_true(rt.less(this.version, Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Curl.curl_7_16_2())) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_TIMEOUT'),
			rt.call_function('ceil', [var_timeout.clone()])])
	} else {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_TIMEOUT_MS'),
			rt.call_function('round', [rt.mul(var_timeout, rt.new_int(1000))])])
	}
	if var_options_mutated.array_get(rt.new_string('connect_timeout')).is_long()
		|| rt.is_true(rt.less(this.version, Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Curl.curl_7_16_2())) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_CONNECTTIMEOUT'),
			rt.call_function('ceil',
				[var_options_mutated.array_get(rt.new_string('connect_timeout'))])])
	} else {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_CONNECTTIMEOUT_MS'),
			rt.call_function('round', [
				rt.mul(var_options_mutated.array_get(rt.new_string('connect_timeout')),
					rt.new_int(1000)),
			])])
	}
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_URL'),
		var_url_mutated.clone()])
	rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_USERAGENT'),
		var_options_mutated.array_get(rt.new_string('useragent'))])
	if !(!rt.is_true(var_headers_mutated)) {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HTTPHEADER'),
			var_headers_mutated.clone()])
	}
	if rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('protocol_version')),
		rt.new_float(1.1)))
	{
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HTTP_VERSION'),
			rt.get_constant('CURL_HTTP_VERSION_1_1')])
	} else {
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HTTP_VERSION'),
			rt.get_constant('CURL_HTTP_VERSION_1_0')])
	}
	if rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('blocking')),
		rt.new_bool(true)))
	{
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_HEADERFUNCTION'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Transport_Curl', [
					'Transport',
				], &this) },
				rt.ArrayItem{ key: none, val: 'stream_headers' },
			])])
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_WRITEFUNCTION'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Transport_Curl', [
					'Transport',
				], &this) },
				rt.ArrayItem{ key: none, val: 'stream_body' },
			])])
		rt.call_function('curl_setopt', [this.handle, rt.get_constant('CURLOPT_BUFFERSIZE'),
			Class_WpOrg_Requests_Requests.buffer_size()])
	}
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) process_response(var_response rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_options_mutated := var_options
	if rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('blocking')),
		rt.new_bool(false)))
	{
		mut var_fake_headers := rt.new_string('')
		rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
			rt.new_string('curl.after_request'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_fake_headers }]),
		])
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_options_mutated.array_get(rt.new_string('filename')), rt.new_bool(false)))))
		&& rt.is_true(this.stream_handle) {
		rt.call_function('fclose', [this.stream_handle])
		this.headers = this.headers.trim_space()
	} else {
		this.headers = rt.concat(this.headers, var_response_mutated)
	}
	if rt.is_true(rt.call_function('curl_errno', [this.handle])) {
		mut var_error := rt.call_function('sprintf', [rt.new_string('cURL error %s: %s'),
			rt.call_function('curl_errno', [this.handle]), rt.call_function('curl_error', [
				this.handle])])
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_error.clone(),
			rt.new_string('curlerror'), this.handle)))
	}
	this.info = rt.call_function('curl_getinfo', [this.handle])
	rt.call_method(var_options_mutated.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('curl.after_request'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.headers },
			rt.ArrayItem{ key: none, val: this.info }]),
	])
	return rt.new_string(this.headers)
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) stream_headers(var_handle rt.PhpVal, var_headers rt.PhpVal) i64 {
	mut var_headers_mutated := var_headers
	if this.done_headers {
		this.headers = ''
		this.done_headers = false
	}
	this.headers = rt.concat(this.headers, var_headers_mutated)
	if rt.is_true(rt.identical(var_headers_mutated, rt.new_string('\r\n'))) {
		this.done_headers = true
	}
	return var_headers_mutated.clone().to_string().len
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) stream_body(var_handle rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	rt.call_method(this.hooks, 'dispatch', [rt.new_string('request.progress'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_data_mutated },
			rt.ArrayItem{ key: none, val: this.response_bytes },
			rt.ArrayItem{ key: none, val: this.response_byte_limit }])])
	mut var_data_length := rt.new_int(var_data_mutated.clone().to_string().len)
	if rt.is_true(this.response_byte_limit) {
		if rt.is_true(rt.identical(this.response_bytes, this.response_byte_limit)) {
			return var_data_length.clone()
		}
		if rt.is_true(rt.greater(rt.add(this.response_bytes, var_data_length),
			this.response_byte_limit))
		{
			mut var_limited_length := rt.sub(this.response_byte_limit, this.response_bytes)
			var_data_mutated = rt.call_function('substr', [var_data_mutated.clone(),
				rt.new_int(0), var_limited_length.clone()])
		}
	}
	if rt.is_true(this.stream_handle) {
		rt.call_function('fwrite', [this.stream_handle, var_data_mutated.clone()])
	} else {
		this.response_data = rt.concat(this.response_data, var_data_mutated)
	}
	this.response_bytes = rt.add(this.response_bytes,
		rt.new_int(var_data_mutated.clone().to_string().len))
	return var_data_length.clone()
}

fn Class_WpOrg_Requests_Transport_Curl.format_get(var_url rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_data_mutated := var_data
	if !(!rt.is_true(var_data_mutated)) {
		mut var_query := rt.new_string('')
		mut var_url_parts := rt.call_function('parse_url', [var_url_mutated.clone()])
		if !rt.is_true(var_url_parts.array_get(rt.new_string('query'))) {
			var_url_parts.array_set('query', '')
		} else {
			var_query = var_url_parts.array_get(rt.new_string('query'))
		}
		var_query = rt.concat(var_query,
			rt.new_string('&' +(rt.call_function('http_build_query', [var_data_mutated.clone(), rt.new_string(''), rt.new_string('&')])).str()))
		var_query = rt.new_string(var_query.clone().to_string().trim_space())
		if !rt.is_true(var_url_parts.array_get(rt.new_string('query'))) {
			var_url_mutated = rt.concat(var_url_mutated, rt.new_string('?' + var_query.str()))
		} else {
			var_url_mutated = rt.call_function('str_replace', [
				var_url_parts.array_get(rt.new_string('query')),
				var_query.clone(),
				var_url_mutated.clone(),
			])
		}
	}
	return var_url_mutated.clone()
}

fn Class_WpOrg_Requests_Transport_Curl.test(var_capabilities rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_init')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_exec')]))))) {
		return false
	}
	if var_capabilities.array_isset(Class_WpOrg_Requests_Capability.ssl())
		&& rt.is_true(var_capabilities.array_get(Class_WpOrg_Requests_Capability.ssl())) {
		mut var_curl_version := rt.call_function('curl_version', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.bitwise_and(rt.get_constant('CURL_VERSION_SSL'),
			var_curl_version.array_get(rt.new_string('features')))))))
		{
			return false
		}
	}
	return true
}

fn (mut this Class_WpOrg_Requests_Transport_Curl) get_expect_header(var_data rt.PhpVal) string {
	mut var_data_mutated := var_data
	if !(var_data_mutated.clone().is_array()) {
		return if var_data_mutated.str().len >= 1048576 { '100-Continue' } else { '' }
	}
	mut var_bytesize := rt.new_int(0)
	mut var_iterator :=
		create_recursiveiteratoriterator(create_recursivearrayiterator(var_data_mutated.clone()))
	mut iter_3 := var_iterator.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_datum := item_3.val
		var_bytesize = rt.add(var_bytesize, rt.new_int(var_datum.str().len))
		if rt.is_true(rt.greater_equal(var_bytesize, rt.new_int(1048576))) {
			return '100-Continue'
		}
	}
	return ''
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

struct Class_WpOrg_Requests_Requests {
	rt.PhpObjectBase
}

struct Class_RecursiveIteratorIterator {
	rt.PhpObjectBase
}

struct Class_RecursiveArrayIterator {
	rt.PhpObjectBase
}

fn create_wporg_requests_transport_curl() &Class_WpOrg_Requests_Transport_Curl {
	mut obj := &Class_WpOrg_Requests_Transport_Curl{
		PhpObjectBase:       rt.PhpObjectBase{}
		headers:             ''
		response_data:       ''
		info:                rt.new_null()
		version:             rt.new_null()
		handle:              rt.new_null()
		hooks:               rt.new_null()
		done_headers:        false
		stream_handle:       rt.new_null()
		response_bytes:      i64(0)
		response_byte_limit: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wporg_requests_utility_inputvalidator(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_transport_curl(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_Transport_Curl {
	mut obj := &Class_WpOrg_Requests_Exception_Transport_Curl{
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

fn create_recursiveiteratoriterator(_args ...rt.PhpVal) &Class_RecursiveIteratorIterator {
	mut obj := &Class_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursivearrayiterator(_args ...rt.PhpVal) &Class_RecursiveArrayIterator {
	mut obj := &Class_RecursiveArrayIterator{
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
			return rt.new_string(this.request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
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
			return this.get_subrequest_handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
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
		else {
			return none
		}
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
		'headers' {
			this.headers = val.str()
			return true
		}
		'response_data' {
			this.response_data = val.str()
			return true
		}
		'info' {
			this.info = val
			return true
		}
		'version' {
			this.version = val
			return true
		}
		'handle' {
			this.handle = val
			return true
		}
		'hooks' {
			this.hooks = val
			return true
		}
		'done_headers' {
			this.done_headers = val.to_bool()
			return true
		}
		'stream_handle' {
			this.stream_handle = val
			return true
		}
		'response_bytes' {
			this.response_bytes = val.to_i64()
			return true
		}
		'response_byte_limit' {
			this.response_byte_limit = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WpOrg_Requests_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveIteratorIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_RecursiveArrayIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveArrayIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveArrayIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WpOrg_Requests_Transport_Curl', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_transport_curl()
		return rt.new_object('WpOrg_Requests_Transport_Curl', ['Transport'], obj)
	})
	rt.register_class_factory('WpOrg_Requests_Utility_InputValidator', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_utility_inputvalidator()
		return rt.new_object('WpOrg_Requests_Utility_InputValidator', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception_InvalidArgument', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception_invalidargument()
		return rt.new_object('WpOrg_Requests_Exception_InvalidArgument', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception()
		return rt.new_object('WpOrg_Requests_Exception', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception_Transport_Curl', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception_transport_curl()
		return rt.new_object('WpOrg_Requests_Exception_Transport_Curl', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Requests', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_requests()
		return rt.new_object('WpOrg_Requests_Requests', []string{}, obj)
	})
	rt.register_class_factory('RecursiveIteratorIterator', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_recursiveiteratoriterator()
		return rt.new_object('RecursiveIteratorIterator', []string{}, obj)
	})
	rt.register_class_factory('RecursiveArrayIterator', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_recursivearrayiterator()
		return rt.new_object('RecursiveArrayIterator', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
