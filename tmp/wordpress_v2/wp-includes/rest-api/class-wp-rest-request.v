import rt

struct Class_WP_REST_Request {
	rt.PhpObjectBase
pub mut:
	method      string
	params      rt.PhpVal = rt.new_null()
	headers     rt.PhpVal = rt.new_array()
	body        rt.PhpVal = rt.new_null()
	route       rt.PhpVal = rt.new_null()
	attributes  rt.PhpVal = rt.new_array()
	parsed_json bool
	parsed_body bool
}

fn (mut this Class_WP_REST_Request) construct(method string, route string, var_attributes rt.PhpVal) {
	mut route_mutated := route
	mut var_attributes_mutated := var_attributes
	this.params = rt.create_array([rt.ArrayItem{ key: 'URL', val: rt.new_array() },
		rt.ArrayItem{ key: 'GET', val: rt.new_array() }, rt.ArrayItem{
			key: 'POST'
			val: rt.new_array()
		}, rt.ArrayItem{ key: 'FILES', val: rt.new_array() },
		rt.ArrayItem{ key: 'JSON', val: rt.new_null() }, rt.ArrayItem{
			key: 'defaults'
			val: rt.new_array()
		}])
	this.set_method(rt.new_string(method))
	this.set_route(rt.new_string(route_mutated))
	this.set_attributes(var_attributes_mutated.clone())
}

fn (mut this Class_WP_REST_Request) get_method() string {
	return this.method
}

fn (mut this Class_WP_REST_Request) set_method(var_method rt.PhpVal) {
	this.method = var_method.clone().to_string().to_upper()
}

fn (mut this Class_WP_REST_Request) get_headers() rt.PhpVal {
	return this.headers
}

fn (mut this Class_WP_REST_Request) is_method(var_method rt.PhpVal) rt.PhpVal {
	return rt.identical(this.get_method(), rt.new_string(var_method.clone().to_string().to_upper()))
}

fn Class_WP_REST_Request.canonicalize_header_name(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	var_key_mutated = rt.new_string(var_key_mutated.clone().to_string().to_lower())
	var_key_mutated = rt.call_function('str_replace', [rt.new_string('-'),
		rt.new_string('_'), var_key_mutated.clone()])
	return var_key_mutated.clone()
}

fn (mut this Class_WP_REST_Request) get_header(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	var_key_mutated = this.canonicalize_header_name(var_key_mutated.clone())
	if !(this.headers.array_isset(var_key_mutated)) {
		return rt.new_null()
	}
	return rt.call_function('implode',
		[rt.new_string(','), this.headers.array_get(var_key_mutated)])
}

fn (mut this Class_WP_REST_Request) get_header_as_array(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	var_key_mutated = this.canonicalize_header_name(var_key_mutated.clone())
	if !(this.headers.array_isset(var_key_mutated)) {
		return rt.new_null()
	}
	return this.headers.array_get(var_key_mutated)
}

fn (mut this Class_WP_REST_Request) set_header(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_key_mutated := var_key
	mut var_value_mutated := var_value
	var_key_mutated = this.canonicalize_header_name(var_key_mutated.clone())
	var_value_mutated = rt.cast_array(var_value_mutated)
	this.headers.array_set(var_key_mutated, var_value_mutated.clone())
}

fn (mut this Class_WP_REST_Request) add_header(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_key_mutated := var_key
	mut var_value_mutated := var_value
	var_key_mutated = this.canonicalize_header_name(var_key_mutated.clone())
	var_value_mutated = rt.cast_array(var_value_mutated)
	if !(this.headers.array_isset(var_key_mutated)) {
		this.headers.array_set(var_key_mutated, rt.new_array())
	}
	this.headers.array_set(var_key_mutated, rt.call_function('array_merge', [
		this.headers.array_get(var_key_mutated),
		var_value_mutated.clone(),
	]))
}

fn (mut this Class_WP_REST_Request) remove_header(var_key rt.PhpVal) {
	mut var_key_mutated := var_key
	var_key_mutated = this.canonicalize_header_name(var_key_mutated.clone())
	this.headers.array_unset(var_key_mutated)
}

fn (mut this Class_WP_REST_Request) set_headers(var_headers rt.PhpVal, override bool) {
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(override))) {
		this.headers = rt.new_array()
	}
	mut iter_1 := var_headers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		this.set_header(var_key.clone(), var_value.clone())
	}
}

fn (mut this Class_WP_REST_Request) get_content_type() rt.PhpVal {
	mut var_type := rt.new_null()
	mut var_subtype := rt.new_null()
	mut var_value := this.get_header(rt.new_string('Content-Type'))
	if !rt.is_true(var_value) {
		return rt.new_null()
	}
	mut var_parameters := rt.new_string('')
	if rt.is_true(rt.call_function('strpos', [var_value.clone(),
		rt.new_string(';')]))
	{
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(';'),
			var_value.clone(), rt.new_int(2)])
		var_value = list_tmp_1.array_get(0)
		var_parameters = list_tmp_1.array_get(1)
	}
	var_value = rt.new_string(var_value.clone().to_string().to_lower())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_value.clone(), rt.new_string('/')])))))
	{
		return rt.new_null()
	}
	mut list_tmp_2 := rt.call_function('explode', [rt.new_string('/'),
		var_value.clone(), rt.new_int(2)])
	var_type = list_tmp_2.array_get(0)
	var_subtype = list_tmp_2.array_get(1)
	mut var_data := rt.call_function('compact', [rt.new_string('value'),
		rt.new_string('type'), rt.new_string('subtype'), rt.new_string('parameters')])
	var_data = rt.call_function('array_map', [rt.new_string('trim'),
		var_data.clone()])
	return var_data.clone()
}

fn (mut this Class_WP_REST_Request) is_json_content_type() bool {
	mut var_content_type := this.get_content_type()
	return var_content_type.array_isset(rt.new_string('value'))
		&& rt.is_true(rt.call_function('wp_is_json_media_type', [var_content_type.array_get(rt.new_string('value'))]))
}

fn (mut this Class_WP_REST_Request) get_parameter_order() rt.PhpVal {
	mut var_order := rt.new_array()
	if this.is_json_content_type() {
		var_order.array_push('JSON')
	}
	this.parse_json_params()
	mut var_body := this.get_body()
	if rt.is_true(rt.new_bool('POST' != this.method)) && !(!rt.is_true(var_body)) {
		this.parse_body_params()
	}
	mut var_accepts_body_data := ['POST', 'PUT', 'PATCH', 'DELETE']
	if rt.is_true(rt.call_function('in_array', [rt.new_string(this.method),
		rt.create_array_from_list(var_accepts_body_data), rt.new_bool(true)]))
	{
		var_order.array_push('POST')
	}
	var_order.array_push('GET')
	var_order.array_push('URL')
	var_order.array_push('defaults')
	return rt.call_function('apply_filters', [
		rt.new_string('rest_request_parameter_order'),
		var_order.clone(),
		rt.new_object('WP_REST_Request', ['ArrayAccess'], &this),
	])
}

fn (mut this Class_WP_REST_Request) get_param(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	mut var_order := this.get_parameter_order()
	mut iter_2 := var_order.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_type := item_2.val
		if this.params.array_get(var_type).array_isset(var_key_mutated) {
			return this.params.array_get(var_type).array_get(var_key_mutated)
		}
	}
	return rt.new_null()
}

fn (mut this Class_WP_REST_Request) has_param(var_key rt.PhpVal) bool {
	mut var_key_mutated := var_key
	mut var_order := this.get_parameter_order()
	mut iter_3 := var_order.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_type := item_3.val
		if this.params.array_get(var_type).is_array()
			&& rt.is_true(rt.new_bool(this.params.array_get(var_type).array_isset(var_key_mutated.clone()))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_REST_Request) set_param(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_key_mutated := var_key
	mut var_value_mutated := var_value
	mut var_order := this.get_parameter_order()
	mut var_found_key := rt.new_bool(false)
	mut iter_4 := var_order.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_type := item_4.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('defaults'), var_type))))
			&& this.params.array_get(var_type).is_array()
			&& rt.is_true(rt.new_bool(this.params.array_get(var_type).array_isset(var_key_mutated.clone()))) {
			this.params.array_get_mut(var_type).array_set(var_key_mutated,
				var_value_mutated.clone())
			var_found_key = rt.new_bool(true)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found_key)))) {
		this.params.array_get_mut(var_order.array_get(rt.new_int(0))).array_set(var_key_mutated,
			var_value_mutated.clone())
	}
}

fn (mut this Class_WP_REST_Request) get_params() rt.PhpVal {
	mut var_order := this.get_parameter_order()
	var_order = rt.call_function('array_reverse', [var_order.clone(),
		rt.new_bool(true)])
	mut var_params := rt.new_array()
	mut iter_5 := var_order.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_type := item_5.val
		mut iter_6 := rt.cast_array(this.params.array_get(var_type)).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_value := item_6.val
			mut var_key := item_6.key
			var_params.array_set(var_key, var_value.clone())
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [
		rt.new_string('permalink_structure'),
	])))))
	{
		var_params.array_unset(rt.new_string('rest_route'))
	}
	return var_params.clone()
}

fn (mut this Class_WP_REST_Request) get_url_params() rt.PhpVal {
	return this.params.array_get(rt.new_string('URL'))
}

fn (mut this Class_WP_REST_Request) set_url_params(var_params rt.PhpVal) {
	mut var_params_mutated := var_params
	this.params.array_set('URL', var_params_mutated.clone())
}

fn (mut this Class_WP_REST_Request) get_query_params() rt.PhpVal {
	return this.params.array_get(rt.new_string('GET'))
}

fn (mut this Class_WP_REST_Request) set_query_params(var_params rt.PhpVal) {
	mut var_params_mutated := var_params
	this.params.array_set('GET', var_params_mutated.clone())
}

fn (mut this Class_WP_REST_Request) get_body_params() rt.PhpVal {
	return this.params.array_get(rt.new_string('POST'))
}

fn (mut this Class_WP_REST_Request) set_body_params(var_params rt.PhpVal) {
	mut var_params_mutated := var_params
	this.params.array_set('POST', var_params_mutated.clone())
}

fn (mut this Class_WP_REST_Request) get_file_params() rt.PhpVal {
	return this.params.array_get(rt.new_string('FILES'))
}

fn (mut this Class_WP_REST_Request) set_file_params(var_params rt.PhpVal) {
	mut var_params_mutated := var_params
	this.params.array_set('FILES', var_params_mutated.clone())
}

fn (mut this Class_WP_REST_Request) get_default_params() rt.PhpVal {
	return this.params.array_get(rt.new_string('defaults'))
}

fn (mut this Class_WP_REST_Request) set_default_params(var_params rt.PhpVal) {
	mut var_params_mutated := var_params
	this.params.array_set('defaults', var_params_mutated.clone())
}

fn (mut this Class_WP_REST_Request) get_body() rt.PhpVal {
	return this.body
}

fn (mut this Class_WP_REST_Request) set_body(var_data rt.PhpVal) {
	mut var_data_mutated := var_data
	this.body = var_data_mutated.clone()
	this.parsed_json = false
	this.parsed_body = false
	this.params.array_set('JSON', rt.new_null())
}

fn (mut this Class_WP_REST_Request) get_json_params() rt.PhpVal {
	this.parse_json_params()
	return this.params.array_get(rt.new_string('JSON'))
}

fn (mut this Class_WP_REST_Request) parse_json_params() bool {
	if this.parsed_json {
		return true
	}
	this.parsed_json = true
	if !(this.is_json_content_type()) {
		return true
	}
	mut var_body := this.get_body()
	if !rt.is_true(var_body) {
		return true
	}
	mut var_params := rt.call_function('json_decode', [var_body.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_null(), var_params))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'), rt.call_function('json_last_error', []rt.PhpVal{}))))) {
		this.parsed_json = false
		mut var_error_data := {
			'status':             Class_WP_Http.bad_request()
			'json_error_code':    rt.call_function('json_last_error', []rt.PhpVal{})
			'json_error_message': rt.call_function('json_last_error_msg', []rt.PhpVal{})
		}
		return (create_wp_error(rt.new_string('rest_invalid_json'), rt.call_function('__', [
			rt.new_string('Invalid JSON body passed.'),
		]), var_error_data.clone())).to_bool()
	}
	this.params.array_set('JSON', var_params.clone())
	return true
}

fn (mut this Class_WP_REST_Request) parse_body_params() {
	mut var_params := rt.new_null()
	if this.parsed_body {
		return
	}
	this.parsed_body = true
	mut var_content_type := this.get_content_type()
	if !(!rt.is_true(var_content_type))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('application/x-www-form-urlencoded'), var_content_type.array_get(rt.new_string('value')))))) {
		return
	}
	rt.call_function('parse_str', [this.get_body(), var_params.clone()])
	this.params.array_set('POST', rt.call_function('array_merge', [
		var_params.clone(), this.params.array_get(rt.new_string('POST'))]))
}

fn (mut this Class_WP_REST_Request) get_route() rt.PhpVal {
	return this.route
}

fn (mut this Class_WP_REST_Request) set_route(var_route rt.PhpVal) {
	mut var_route_mutated := var_route
	this.route = var_route_mutated.clone()
}

fn (mut this Class_WP_REST_Request) get_attributes() rt.PhpVal {
	return this.attributes
}

fn (mut this Class_WP_REST_Request) set_attributes(var_attributes rt.PhpVal) {
	mut var_attributes_mutated := var_attributes
	this.attributes = var_attributes_mutated.clone()
}

fn (mut this Class_WP_REST_Request) sanitize_params() bool {
	mut var_attributes := this.get_attributes()
	if !rt.is_true(var_attributes.array_get(rt.new_string('args'))) {
		return true
	}
	mut var_order := this.get_parameter_order()
	mut var_invalid_params := rt.new_array()
	mut var_invalid_details := rt.new_array()
	mut iter_7 := var_order.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_type := item_7.val
		if !rt.is_true(this.params.array_get(var_type)) {
			continue
		}
		mut iter_8 := this.params.array_get(var_type).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value := item_8.val
			mut var_key := item_8.key
			if !(var_attributes.array_get(rt.new_string('args')).array_isset(var_key)) {
				continue
			}
			mut var_param_args := var_attributes.array_get(rt.new_string('args')).array_get(var_key)
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_param_args.clone().array_isset(rt.new_string('sanitize_callback')))))))
				&& !(!rt.is_true(var_param_args.array_get(rt.new_string('type')))) {
				var_param_args.array_set('sanitize_callback', 'rest_parse_request_arg')
			}
			if !rt.is_true(var_param_args.array_get(rt.new_string('sanitize_callback'))) {
				continue
			}
			mut var_sanitized_value := rt.call_function('call_user_func', [
				var_param_args.array_get(rt.new_string('sanitize_callback')),
				var_value.clone(),
				rt.new_object('WP_REST_Request', ['ArrayAccess'], &this),
				var_key.clone(),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_sanitized_value.clone()])) {
				var_invalid_params.array_set(var_key, rt.call_function('implode', [
					rt.new_string(' '),
					rt.call_method(var_sanitized_value, 'get_error_messages', []rt.PhpVal{}),
				]))
				var_invalid_details.array_set(var_key, rt.call_method(rt.call_function('rest_convert_error_to_response', [
					var_sanitized_value.clone(),
				]), 'get_data', []rt.PhpVal{}))
			} else {
				this.params.array_get_mut(var_type).array_set(var_key, var_sanitized_value.clone())
			}
		}
	}
	if rt.is_true(var_invalid_params) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Invalid parameter(s): %s')]),
			rt.call_function('implode', [rt.new_string(', '),
				rt.func_array_keys(var_invalid_params.clone())]),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 },
			rt.ArrayItem{ key: 'params', val: var_invalid_params },
			rt.ArrayItem{ key: 'details', val: var_invalid_details }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Request) has_valid_params() bool {
	mut var_json_error := rt.new_bool(this.parse_json_params())
	if rt.is_true(rt.call_function('is_wp_error', [var_json_error.clone()])) {
		return var_json_error.to_bool()
	}
	mut var_attributes := this.get_attributes()
	mut var_required := rt.new_array()
	mut var_args := if !rt.is_true(var_attributes.array_get(rt.new_string('args'))) {
		rt.new_array()
	} else {
		var_attributes.array_get(rt.new_string('args'))
	}
	mut iter_9 := var_args.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_arg := item_9.val
		mut var_key := item_9.key
		mut var_param := this.get_param(var_key.clone())
		if var_arg.array_isset(rt.new_string('required'))
			&& rt.is_true(rt.identical(rt.new_bool(true), var_arg.array_get(rt.new_string('required'))))
			&& rt.is_true(rt.identical(rt.new_null(), var_param)) {
			var_required << var_key.clone()
		}
	}
	if !(!rt.is_true(var_required)) {
		return (create_wp_error(rt.new_string('rest_missing_callback_param'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Missing parameter(s): %s')]),
			rt.call_function('implode', [rt.new_string(', '),
				rt.create_array_from_list(var_required)]),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 },
			rt.ArrayItem{ key: 'params', val: var_required }]))).to_bool()
	}
	mut var_invalid_params := rt.new_array()
	mut var_invalid_details := rt.new_array()
	mut iter_10 := var_args.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_arg := item_10.val
		mut var_key := item_10.key
		mut var_param := this.get_param(var_key.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_param))))
			&& !(!rt.is_true(var_arg.array_get(rt.new_string('validate_callback')))) {
			mut var_valid_check := rt.call_function('call_user_func', [
				var_arg.array_get(rt.new_string('validate_callback')),
				var_param.clone(),
				rt.new_object('WP_REST_Request', ['ArrayAccess'], &this),
				var_key.clone(),
			])
			if rt.is_true(rt.identical(rt.new_bool(false), var_valid_check)) {
				var_invalid_params.array_set(var_key, rt.call_function('__', [
					rt.new_string('Invalid parameter.'),
				]))
			}
			if rt.is_true(rt.call_function('is_wp_error', [var_valid_check.clone()])) {
				var_invalid_params.array_set(var_key, rt.call_function('implode', [
					rt.new_string(' '),
					rt.call_method(var_valid_check, 'get_error_messages', []rt.PhpVal{}),
				]))
				var_invalid_details.array_set(var_key, rt.call_method(rt.call_function('rest_convert_error_to_response', [
					var_valid_check.clone(),
				]), 'get_data', []rt.PhpVal{}))
			}
		}
	}
	if rt.is_true(var_invalid_params) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Invalid parameter(s): %s')]),
			rt.call_function('implode', [rt.new_string(', '),
				rt.func_array_keys(var_invalid_params.clone())]),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 },
			rt.ArrayItem{ key: 'params', val: var_invalid_params },
			rt.ArrayItem{ key: 'details', val: var_invalid_details }]))).to_bool()
	}
	if var_attributes.array_isset(rt.new_string('validate_callback')) {
		mut var_valid_check := rt.call_function('call_user_func', [
			var_attributes.array_get(rt.new_string('validate_callback')),
			rt.new_object('WP_REST_Request', ['ArrayAccess'], &this),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_valid_check.clone()])) {
			return var_valid_check.to_bool()
		}
		if rt.is_true(rt.identical(rt.new_bool(false), var_valid_check)) {
			return (create_wp_error(rt.new_string('rest_invalid_params'), rt.call_function('__', [
				rt.new_string('Invalid parameters.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Request) offsetexists(var_offset rt.PhpVal) bool {
	mut var_order := this.get_parameter_order()
	mut iter_11 := var_order.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_type := item_11.val
		if this.params.array_get(var_type).array_isset(var_offset) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_REST_Request) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	return this.get_param(var_offset.clone())
}

fn (mut this Class_WP_REST_Request) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_param(var_offset.clone(), var_value_mutated.clone())
}

fn (mut this Class_WP_REST_Request) offsetunset(var_offset rt.PhpVal) {
	mut var_order := this.get_parameter_order()
	mut iter_12 := var_order.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_type := item_12.val
		this.params.array_get(var_type).array_unset(var_offset)
	}
}

fn Class_WP_REST_Request.from_url(var_url rt.PhpVal) rt.PhpVal {
	mut var_bits := rt.call_function('parse_url', [var_url.clone()])
	mut var_query_params := rt.new_array()
	if !(!rt.is_true(var_bits.array_get(rt.new_string('query')))) {
		rt.call_function('wp_parse_str', [var_bits.array_get(rt.new_string('query')),
			rt.create_array_from_native_map(var_query_params)])
	}
	mut var_api_root := rt.call_function('rest_url', []rt.PhpVal{})
	if rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')]))
		&& rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), var_api_root.clone()])) {
		mut var_api_url_part := rt.call_function('substr', [var_url.clone(),
			rt.new_int(rt.call_function('untrailingslashit', [
				var_api_root.clone()]).to_string().len)])
		mut var_route := rt.call_function('parse_url', [var_api_url_part.clone(),
			rt.get_constant('PHP_URL_PATH')])
	} else if !(!rt.is_true(var_query_params['rest_route'])) {
		var_route = var_query_params['rest_route']
		var_query_params.delete('rest_route')
	}
	mut var_request := rt.new_bool(false)
	if !(!rt.is_true(var_route)) {
		var_request = create_wp_rest_request('GET', var_route, rt.new_null())
		rt.call_method(var_request, 'set_query_params', [
			rt.create_array_from_native_map(var_query_params),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_request_from_url'),
		var_request.clone(), var_url.clone()])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_request(method string, route string, arg_2 rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
		method:        ''
		params:        rt.new_null()
		headers:       rt.new_array()
		body:          rt.new_null()
		route:         rt.new_null()
		attributes:    rt.new_array()
		parsed_json:   false
		parsed_body:   false
	}
	obj.construct(method, route, arg_2)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_method' {
			return rt.new_string(this.get_method())
		}
		'set_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_method(dispatch_arg_0)
			return rt.new_null()
		}
		'get_headers' {
			return this.get_headers()
		}
		'is_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_method(dispatch_arg_0)
		}
		'canonicalize_header_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_REST_Request.canonicalize_header_name(dispatch_arg_0)
		}
		'get_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_header(dispatch_arg_0)
		}
		'get_header_as_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_header_as_array(dispatch_arg_0)
		}
		'set_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_header(dispatch_arg_0)
			return rt.new_null()
		}
		'set_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.set_headers(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_content_type' {
			return this.get_content_type()
		}
		'is_json_content_type' {
			return rt.new_bool(this.is_json_content_type())
		}
		'get_parameter_order' {
			return this.get_parameter_order()
		}
		'get_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_param(dispatch_arg_0)
		}
		'has_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_param(dispatch_arg_0))
		}
		'set_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_param(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_params' {
			return this.get_params()
		}
		'get_url_params' {
			return this.get_url_params()
		}
		'set_url_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_url_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_query_params' {
			return this.get_query_params()
		}
		'set_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_body_params' {
			return this.get_body_params()
		}
		'set_body_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_body_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_file_params' {
			return this.get_file_params()
		}
		'set_file_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_file_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_params' {
			return this.get_default_params()
		}
		'set_default_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_default_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_body' {
			return this.get_body()
		}
		'set_body' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_body(dispatch_arg_0)
			return rt.new_null()
		}
		'get_json_params' {
			return this.get_json_params()
		}
		'parse_json_params' {
			return rt.new_bool(this.parse_json_params())
		}
		'parse_body_params' {
			this.parse_body_params()
			return rt.new_null()
		}
		'get_route' {
			return this.get_route()
		}
		'set_route' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_route(dispatch_arg_0)
			return rt.new_null()
		}
		'get_attributes' {
			return this.get_attributes()
		}
		'set_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize_params' {
			return rt.new_bool(this.sanitize_params())
		}
		'has_valid_params' {
			return rt.new_bool(this.has_valid_params())
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'from_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_REST_Request.from_url(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'method' { return rt.new_string(this.method) }
		'params' { return this.params }
		'headers' { return this.headers }
		'body' { return this.body }
		'route' { return this.route }
		'attributes' { return this.attributes }
		'parsed_json' { return rt.new_bool(this.parsed_json) }
		'parsed_body' { return rt.new_bool(this.parsed_body) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'method' {
			this.method = val.str()
			return true
		}
		'params' {
			this.params = val
			return true
		}
		'headers' {
			this.headers = val
			return true
		}
		'body' {
			this.body = val
			return true
		}
		'route' {
			this.route = val
			return true
		}
		'attributes' {
			this.attributes = val
			return true
		}
		'parsed_json' {
			this.parsed_json = val.to_bool()
			return true
		}
		'parsed_body' {
			this.parsed_body = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
