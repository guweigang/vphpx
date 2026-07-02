import rt

pub fn Class_WP_REST_Server.readable() string {
	return 'GET'
}

pub fn Class_WP_REST_Server.creatable() string {
	return 'POST'
}

pub fn Class_WP_REST_Server.editable() string {
	return 'POST, PUT, PATCH'
}

pub fn Class_WP_REST_Server.deletable() string {
	return 'DELETE'
}

pub fn Class_WP_REST_Server.allmethods() string {
	return 'GET, POST, PUT, PATCH, DELETE'
}

struct Class_WP_REST_Server {
	rt.PhpObjectBase
pub mut:
	namespaces           rt.PhpVal = rt.new_array()
	endpoints            rt.PhpVal = rt.new_array()
	route_options        rt.PhpVal = rt.new_array()
	embed_cache          rt.PhpVal = rt.new_array()
	dispatching_requests rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Server) construct() {
	this.endpoints = rt.create_array([
		rt.ArrayItem{ key: '/', val: rt.create_array([
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Server', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'get_index' },
			]) },
			rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: 'default', val: 'view' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: '/batch/v1', val: rt.create_array([
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Server', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'serve_batch_request_v1' },
			]) },
			rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'validation', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'require-all-validate' },
						rt.ArrayItem{ key: none, val: 'normal' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'normal' },
				]) },
				rt.ArrayItem{ key: 'requests', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'maxItems', val: this.get_max_batch_size() },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'method', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'enum', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'POST' },
									rt.ArrayItem{ key: none, val: 'PUT' },
									rt.ArrayItem{ key: none, val: 'PATCH' },
									rt.ArrayItem{ key: none, val: 'DELETE' },
								]) },
								rt.ArrayItem{ key: 'default', val: 'POST' },
							]) },
							rt.ArrayItem{ key: 'path', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'required', val: true },
							]) },
							rt.ArrayItem{ key: 'body', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'properties', val: rt.new_array() },
								rt.ArrayItem{ key: 'additionalProperties', val: true },
							]) },
							rt.ArrayItem{ key: 'headers', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'properties', val: rt.new_array() },
								rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'string' },
										rt.ArrayItem{ key: none, val: 'array' },
									]) },
									rt.ArrayItem{ key: 'items', val: rt.create_array([
										rt.ArrayItem{ key: 'type', val: 'string' },
									]) },
								]) },
							]) },
						]) },
					]) },
				]) },
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Server) check_authentication() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('rest_authentication_errors'),
		rt.new_null(),
	])
}

fn (mut this Class_WP_REST_Server) error_to_response(var_error rt.PhpVal) rt.PhpVal {
	mut var_error_mutated := var_error
	return rt.call_function('rest_convert_error_to_response', [
		var_error_mutated.clone()])
}

fn (mut this Class_WP_REST_Server) json_error(var_code rt.PhpVal, var_message rt.PhpVal, var_status rt.PhpVal) rt.PhpVal {
	mut var_code_mutated := var_code
	if rt.is_true(var_status) {
		this.set_status(var_status.clone())
	}
	mut var_error := rt.call_function('compact', [rt.new_string('code'),
		rt.new_string('message')])
	return rt.call_function('wp_json_encode', [var_error.clone()])
}

fn (mut this Class_WP_REST_Server) get_json_encode_options(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_options := rt.new_int(0)
	if rt.is_true(rt.call_method(var_request_mutated, 'has_param', [
		rt.new_string('_pretty'),
	]))
	{
		rt.new_null()
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_json_encode_options'),
		var_options.clone(), var_request_mutated])
}

fn (mut this Class_WP_REST_Server) serve_request(var_path rt.PhpVal) rt.PhpVal {
	mut var__FILES := rt.new_null()
	mut var_path_mutated := var_path
	mut var_current_user := rt.get_superglobal('current_user')
	if rt.is_true(rt.new_bool(rt.instance_of(var_current_user, 'WP_User')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_current_user, 'exists', []rt.PhpVal{}))))) {
		var_current_user = rt.new_null()
	}
	mut var_jsonp_enabled := rt.call_function('apply_filters', [
		rt.new_string('rest_jsonp_enabled'),
		rt.new_bool(true),
	])
	mut var_jsonp_callback := rt.new_bool(false)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_jsonp')) {
		var_jsonp_callback = rt.get_superglobal('_GET').array_get(rt.new_string('_jsonp'))
	}
	mut var_content_type := rt.new_string((if rt.is_true(var_jsonp_callback)
		&& rt.is_true(var_jsonp_enabled) {
		'application/javascript'
	} else {
		'application/json'
	}).str())
	this.send_header(rt.new_string('Content-Type'), rt.new_string(var_content_type.str() +
		'; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str()))
	this.send_header(rt.new_string('X-Robots-Tag'), rt.new_string('noindex'))
	mut var_api_root := rt.call_function('get_rest_url', []rt.PhpVal{})
	if !(!rt.is_true(var_api_root)) {
		this.send_header(rt.new_string('Link'), rt.new_string('<' +
			(rt.call_function('sanitize_url', [var_api_root.clone()])).str() +
			'>; rel="https://api.w.org/"'))
	}
	this.send_header(rt.new_string('X-Content-Type-Options'), rt.new_string('nosniff'))
	rt.call_function('apply_filters_deprecated', [rt.new_string('rest_enabled'),
		rt.create_array([rt.ArrayItem{ key: none, val: true }]),
		rt.new_string('4.7.0'), rt.new_string('rest_authentication_errors'),
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The REST API can no longer be completely disabled, the %s filter can be used to restrict access to the API, instead.'),
			]),
			rt.new_string('rest_authentication_errors'),
		])])
	if rt.is_true(var_jsonp_callback) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_jsonp_enabled)))) {
			rt.echo_val(this.json_error(rt.new_string('rest_callback_disabled'), rt.call_function('__', [
				rt.new_string('JSONP support is disabled on this site.'),
			]), rt.new_int(400)))
			return rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_check_jsonp_callback', [
			var_jsonp_callback.clone(),
		])))))
		{
			rt.echo_val(this.json_error(rt.new_string('rest_callback_invalid'), rt.call_function('__', [
				rt.new_string('Invalid JSONP callback function.'),
			]), rt.new_int(400)))
			return rt.new_bool(false)
		}
	}
	if !rt.is_true(var_path_mutated) {
		var_path_mutated = if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO'))).is_null() {
			rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO'))
		} else {
			rt.new_string('/')
		}
	}
	mut var_request := create_wp_rest_request(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')),
		var_path_mutated.clone())
	rt.call_method(var_request, 'set_query_params', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_GET').clone()]),
	])
	rt.call_method(var_request, 'set_body_params', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()]),
	])
	rt.call_method(var_request, 'set_file_params', [var__FILES.clone()])
	rt.call_method(var_request, 'set_headers', [
		this.get_headers(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').clone()])),
	])
	rt.call_method(var_request, 'set_body', [Class_WP_REST_Server.get_raw_data()])
	mut var_method_overridden := rt.new_bool(false)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_method')) {
		rt.call_method(var_request, 'set_method', [
			rt.get_superglobal('_GET').array_get(rt.new_string('_method')),
		])
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_HTTP_METHOD_OVERRIDE')) {
		rt.call_method(var_request, 'set_method', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_HTTP_METHOD_OVERRIDE')),
		])
		var_method_overridden = rt.new_bool(true)
	}
	mut var_expose_headers := rt.create_array([
		rt.ArrayItem{ key: none, val: 'X-WP-Total' },
		rt.ArrayItem{ key: none, val: 'X-WP-TotalPages' },
		rt.ArrayItem{ key: none, val: 'Link' },
	])
	var_expose_headers = rt.call_function('apply_filters', [
		rt.new_string('rest_exposed_cors_headers'),
		var_expose_headers.clone(),
		var_request.clone(),
	])
	this.send_header(rt.new_string('Access-Control-Expose-Headers'), rt.call_function('implode', [
		rt.new_string(', '),
		var_expose_headers.clone(),
	]))
	mut var_allow_headers := rt.create_array([
		rt.ArrayItem{ key: none, val: 'Authorization' },
		rt.ArrayItem{ key: none, val: 'X-WP-Nonce' },
		rt.ArrayItem{ key: none, val: 'Content-Disposition' },
		rt.ArrayItem{ key: none, val: 'Content-MD5' },
		rt.ArrayItem{ key: none, val: 'Content-Type' },
	])
	var_allow_headers = rt.call_function('apply_filters', [
		rt.new_string('rest_allowed_cors_headers'),
		var_allow_headers.clone(),
		var_request.clone(),
	])
	this.send_header(rt.new_string('Access-Control-Allow-Headers'), rt.call_function('implode', [
		rt.new_string(', '),
		var_allow_headers.clone(),
	]))
	mut var_result := this.check_authentication()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_result.clone()])))))
	{
		var_result = this.dispatch(var_request.clone())
	}
	var_result = rt.call_function('rest_ensure_response', [var_result.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		var_result = this.error_to_response(var_result.clone())
	}
	var_result = rt.call_function('apply_filters', [rt.new_string('rest_post_dispatch'),
		rt.call_function('rest_ensure_response', [var_result.clone()]),
		rt.new_object('WP_REST_Server', []string{}, &this), var_request.clone()])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_envelope')) {
		mut var_embed := if rt.get_superglobal('_GET').array_isset(rt.new_string('_embed')) { rt.call_function('rest_parse_embed_param', [
				rt.get_superglobal('_GET').array_get(rt.new_string('_embed')),
			]) } else { rt.new_bool(false) }
		var_result = this.envelope_response(var_result.clone(), var_embed.clone())
	}
	mut var_headers := rt.call_method(var_result, 'get_headers', []rt.PhpVal{})
	this.send_headers(var_headers.clone())
	mut var_code := rt.call_method(var_result, 'get_status', []rt.PhpVal{})
	this.set_status(var_code.clone())
	mut var_send_no_cache_headers := rt.call_function('apply_filters', [
		rt.new_string('rest_send_nocache_headers'),
		rt.call_function('is_user_logged_in', []rt.PhpVal{}),
	])
	if rt.is_true(var_send_no_cache_headers)
		|| (rt.is_true(rt.identical(rt.new_bool(true), var_method_overridden))
		&& rt.is_true(rt.call_function('str_starts_with', [var_code.clone(), rt.new_string('4')]))) {
		mut iter_1 := rt.call_function('wp_get_nocache_headers', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_header_value := item_1.val
			mut var_header := item_1.key
			if !rt.is_true(var_header_value) {
				this.remove_header(var_header.clone())
			} else {
				this.send_header(var_header.clone(), var_header_value.clone())
			}
		}
	}
	mut var_served := rt.call_function('apply_filters', [
		rt.new_string('rest_pre_serve_request'),
		rt.new_bool(false),
		var_result.clone(),
		var_request.clone(),
		rt.new_object('WP_REST_Server', []string{}, &this),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_served)))) {
		if rt.is_true(rt.identical(rt.new_string('HEAD'), rt.call_method(var_request, 'get_method',
			[]rt.PhpVal{})))
		{
			return rt.new_null()
		}
		var_embed = if rt.get_superglobal('_GET').array_isset(rt.new_string('_embed')) { rt.call_function('rest_parse_embed_param', [
				rt.get_superglobal('_GET').array_get(rt.new_string('_embed')),
			]) } else { rt.new_bool(false) }
		var_result = this.response_to_data(var_result.clone(), var_embed.clone())
		var_result = rt.call_function('apply_filters', [
			rt.new_string('rest_pre_echo_response'),
			var_result.clone(),
			rt.new_object('WP_REST_Server', []string{}, &this),
			var_request.clone(),
		])
		if rt.is_true(rt.identical(rt.new_int(204), var_code))
			|| rt.is_true(rt.identical(rt.new_null(), var_result)) {
			return rt.new_null()
		}
		var_result = rt.call_function('wp_json_encode', [var_result.clone(),
			this.get_json_encode_options(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))])
		mut var_json_error_message := rt.new_bool(this.get_json_last_error())
		if rt.is_true(var_json_error_message) {
			this.set_status(rt.new_int(500))
			mut var_json_error_obj := create_wp_error(rt.new_string('rest_encode_error'),
				var_json_error_message.clone(), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 500 },
			]))
			var_result = this.error_to_response(rt.new_object('WP_Error', []string{},
				var_json_error_obj))
			var_result = rt.call_function('wp_json_encode', [
				rt.get_property(var_result, 'data'),
				this.get_json_encode_options(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request)),
			])
		}
		if rt.is_true(var_jsonp_callback) {
			print('/**/' + var_jsonp_callback.str() + '(' + var_result.str() + ')')
		} else {
			rt.echo_val(var_result)
		}
	}
	return rt.new_null()
}

fn (mut this Class_WP_REST_Server) response_to_data(var_response rt.PhpVal, var_embed rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_embed_mutated := var_embed
	mut var_data := rt.call_method(var_response_mutated, 'get_data', []rt.PhpVal{})
	mut var_links := Class_WP_REST_Server.get_compact_response_links(var_response_mutated.clone())
	if !(!rt.is_true(var_links)) {
		var_data.array_set('_links', var_links.clone())
	}
	if rt.is_true(var_embed_mutated) {
		this.embed_cache = rt.new_array()
		if rt.is_true(rt.call_function('wp_is_numeric_array', [
			var_data.clone()]))
		{
			mut iter_2 := var_data.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_item := item_2.val
				mut var_key := item_2.key
				var_data.array_set(var_key, this.embed_links(var_item.clone(),
					var_embed_mutated.to_bool()))
			}
		} else {
			var_data = this.embed_links(var_data.clone(), var_embed_mutated.to_bool())
		}
		this.embed_cache = rt.new_array()
	}
	return var_data.clone()
}

fn Class_WP_REST_Server.get_response_links(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_links := rt.call_method(var_response_mutated, 'get_links', []rt.PhpVal{})
	if !rt.is_true(var_links) {
		return rt.new_array()
	}
	mut var_data := rt.new_array()
	mut iter_3 := var_links.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_items := item_3.val
		mut var_rel := item_3.key
		var_data.array_set(var_rel, rt.new_array())
		mut iter_4 := var_items.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_item := item_4.val
			mut var_attributes := var_item.array_get(rt.new_string('attributes'))
			var_attributes.array_set('href', var_item.array_get(rt.new_string('href')))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('self'), var_rel)))) {
				var_data.array_get_mut(var_rel).array_push(var_attributes.clone())
				continue
			}
			mut var_target_hints :=
				Class_WP_REST_Server.get_target_hints_for_link(var_attributes.clone())
			if rt.is_true(var_target_hints) {
				var_attributes.array_set('targetHints', var_target_hints.clone())
			}
			var_data.array_get_mut(var_rel).array_push(var_attributes.clone())
		}
	}
	return var_data.clone()
}

fn Class_WP_REST_Server.get_target_hints_for_link(var_link rt.PhpVal) rt.PhpVal {
	if var_link.array_get(rt.new_string('targetHints')).array_isset(rt.new_string('allow')) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_WP_REST_Request{}
	mut iife_result_0 := iife_temp_0.from_url(var_link.array_get(rt.new_string('href')))
	mut var_request := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) {
		return rt.new_null()
	}
	mut var_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut var_match := rt.call_method(var_server, 'match_request_to_handler', [
		var_request.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_match.clone()])) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_wp_error', [
		rt.call_method(var_request, 'has_valid_params', []rt.PhpVal{}),
	]))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_wp_error', [
		rt.call_method(var_request, 'sanitize_params', []rt.PhpVal{}),
	]))
	{
		return rt.new_null()
	}
	mut var_target_hints := rt.new_array()
	mut var_response := create_wp_rest_response()
	rt.call_method(var_response, 'set_matched_route', [var_match.array_get(rt.new_int(0))])
	rt.call_method(var_response, 'set_matched_handler', [var_match.array_get(rt.new_int(1))])
	mut var_headers := rt.call_method(rt.call_function('rest_send_allow_header', [
		var_response.clone(),
		var_server.clone(),
		var_request.clone(),
	]), 'get_headers', []rt.PhpVal{})
	mut iter_5 := var_headers.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value := item_5.val
		mut var_name := item_5.key
		mut iife_temp_1 := Class_WP_REST_Request{}
		mut iife_result_1 := iife_temp_1.canonicalize_header_name(var_name.clone())
		var_name = iife_result_1
		var_target_hints.array_set(var_name, rt.call_function('array_map', [
			rt.new_string('trim'),
			rt.call_function('explode', [rt.new_string(','), var_value.clone()]),
		]))
	}
	return var_target_hints.clone()
}

fn Class_WP_REST_Server.get_compact_response_links(var_response rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_response_mutated := var_response
	mut var_links := Class_WP_REST_Server.get_response_links(var_response_mutated.clone())
	if !rt.is_true(var_links) {
		return rt.new_array()
	}
	mut var_curies := rt.call_method(var_response_mutated, 'get_curies', []rt.PhpVal{})
	mut var_used_curies := rt.new_array()
	mut iter_6 := var_links.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_items := item_6.val
		mut var_rel := item_6.key
		mut iter_7 := var_curies.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_curie := item_7.val
			mut var_href_prefix := rt.call_function('substr', [
				var_curie.array_get(rt.new_string('href')),
				rt.new_int(0),
				rt.call_function('strpos', [var_curie.array_get(rt.new_string('href')),
					rt.new_string('{rel}')]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
				var_rel.clone(),
				var_href_prefix.clone(),
			])))))
			{
				continue
			}
			mut var_rel_regex := rt.call_function('str_replace', [
				rt.new_string('\\{rel\\}'),
				rt.new_string('(.+)'),
				rt.call_function('preg_quote', [var_curie.array_get(rt.new_string('href')),
					rt.new_string('!')]),
			])
			rt.call_function('preg_match', [
				rt.new_string('!' + var_rel_regex.str() + '!'),
				var_rel.clone(),
				var_matches.clone(),
			])
			if rt.is_true(var_matches) {
				mut var_new_rel := rt.new_string(
					(var_curie.array_get(rt.new_string('name'))).str() + ':' +
					(var_matches.array_get(rt.new_int(1))).str())
				var_used_curies.array_set(var_curie.array_get(rt.new_string('name')),
					var_curie.clone())
				var_links.array_set(var_new_rel, var_items.clone())
				var_links.array_unset(var_rel)
				break
			}
		}
	}
	if rt.is_true(var_used_curies) {
		var_links.array_set('curies', rt.call_function('array_values', [
			var_used_curies.clone()]))
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Server) embed_links(var_data rt.PhpVal, embed bool) rt.PhpVal {
	mut var_data_mutated := var_data
	mut embed_mutated := embed
	if !rt.is_true(var_data_mutated.array_get(rt.new_string('_links'))) {
		return var_data_mutated.clone()
	}
	mut var_embedded := rt.new_array()
	mut iter_8 := var_data_mutated.array_get(rt.new_string('_links')).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_links := item_8.val
		mut var_rel := item_8.key
		if rt.new_bool(embed_mutated).clone().is_array()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_rel.clone(), rt.new_bool(embed_mutated).clone(), rt.new_bool(true)]))))) {
			continue
		}
		mut var_embeds := rt.new_array()
		mut iter_9 := var_links.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_item := item_9.val
			if !rt.is_true(var_item.array_get(rt.new_string('embeddable'))) {
				var_embeds << rt.new_array()
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.embed_cache.array_isset(var_item.array_get(rt.new_string('href')))))))) {
				mut iife_temp_2 := Class_WP_REST_Request{}
				mut iife_result_2 := iife_temp_2.from_url(var_item.array_get(rt.new_string('href')))
				mut var_request := iife_result_2
				if rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) {
					var_embeds << rt.new_array()
					continue
				}
				if !rt.is_true(var_request.array_get(rt.new_string('context'))) {
					var_request.array_set('context', 'embed')
				}
				if !rt.is_true(var_request.array_get(rt.new_string('per_page'))) {
					mut var_matched := this.match_request_to_handler(var_request.clone())
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_matched.clone()])))))
						&& var_matched.array_get(rt.new_int(1)).array_get(rt.new_string('args')).array_get(rt.new_string('per_page')).array_isset(rt.new_string('maximum')) {
						var_request.array_set('per_page',
							rt.new_int((var_matched.array_get(rt.new_int(1)).array_get(rt.new_string('args')).array_get(rt.new_string('per_page')).array_get(rt.new_string('maximum'))).to_i64()))
					}
				}
				mut var_response := this.dispatch(var_request.clone())
				var_response = rt.call_function('apply_filters', [
					rt.new_string('rest_post_dispatch'),
					rt.call_function('rest_ensure_response', [
						var_response.clone()]),
					rt.new_object('WP_REST_Server', []string{}, &this),
					var_request.clone(),
				])
				this.embed_cache.array_set(var_item.array_get(rt.new_string('href')), this.response_to_data(var_response.clone(),
					rt.new_bool(false)))
			}
			var_embeds << this.embed_cache.array_get(var_item.array_get(rt.new_string('href')))
		}
		mut var_has_links := rt.new_int(rt.call_function('array_filter', [
			rt.create_array_from_list(var_embeds),
		]).array_count())
		if rt.is_true(var_has_links) {
			var_embedded.array_set(var_rel, var_embeds.clone())
		}
	}
	if !(!rt.is_true(var_embedded)) {
		var_data_mutated.array_set('_embedded', var_embedded.clone())
	}
	return var_data_mutated.clone()
}

fn (mut this Class_WP_REST_Server) envelope_response(var_response rt.PhpVal, var_embed rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_embed_mutated := var_embed
	mut var_envelope := rt.create_array([
		rt.ArrayItem{ key: 'body', val: this.response_to_data(var_response_mutated.clone(),
			var_embed_mutated.clone()) },
		rt.ArrayItem{ key: 'status', val: rt.call_method(var_response_mutated, 'get_status',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'headers', val: rt.call_method(var_response_mutated, 'get_headers',
			[]rt.PhpVal{}) },
	])
	var_envelope = rt.call_function('apply_filters', [
		rt.new_string('rest_envelope_response'),
		var_envelope.clone(),
		var_response_mutated.clone(),
	])
	return rt.call_function('rest_ensure_response', [var_envelope.clone()])
}

fn (mut this Class_WP_REST_Server) register_route(var_route_namespace rt.PhpVal, var_route rt.PhpVal, var_route_args rt.PhpVal, override bool) {
	mut var_route_mutated := var_route
	mut var_route_args_mutated := var_route_args
	if !(this.namespaces.array_isset(var_route_namespace)) {
		this.namespaces.array_set(var_route_namespace, rt.new_array())
		this.register_route(var_route_namespace.clone(), rt.new_string('/' +
			var_route_namespace.str()), rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Server', []string{}, &this) },
					rt.ArrayItem{ key: none, val: 'get_namespace_index' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'namespace', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: var_route_namespace },
					]) },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					]) },
				]) },
			]) },
		]), false)
	}
	this.namespaces.array_get_mut(var_route_namespace).array_set(var_route_mutated, true)
	var_route_args_mutated.array_set('namespace', var_route_namespace.clone())
	if var_override || !rt.is_true(this.endpoints.array_get(var_route_mutated)) {
		this.endpoints.array_set(var_route_mutated, var_route_args_mutated.clone())
	} else {
		this.endpoints.array_set(var_route_mutated, rt.call_function('array_merge', [
			this.endpoints.array_get(var_route_mutated),
			var_route_args_mutated.clone(),
		]))
	}
}

fn (mut this Class_WP_REST_Server) get_routes(route_namespace string) rt.PhpVal {
	mut var_endpoints := this.endpoints
	if var_route_namespace.len > 0 && var_route_namespace != '0' {
		var_endpoints = rt.call_function('wp_list_filter', [var_endpoints.clone(),
			rt.create_array([rt.ArrayItem{ key: 'namespace', val: route_namespace }])])
	}
	var_endpoints = rt.call_function('apply_filters', [rt.new_string('rest_endpoints'),
		var_endpoints.clone()])
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'methods', val: '' },
		rt.ArrayItem{ key: 'accept_json', val: false }, rt.ArrayItem{ key: 'accept_raw', val: false },
		rt.ArrayItem{ key: 'show_in_index', val: true }, rt.ArrayItem{
			key: 'args'
			val: rt.new_array()
		}])
	mut iter_10 := var_endpoints.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_handlers := item_10.val
		mut var_route := item_10.key
		if var_handlers.array_isset(rt.new_string('callback')) {
			var_handlers = rt.create_array([rt.ArrayItem{ key: none, val: var_handlers }])
		}
		if !(this.route_options.array_isset(var_route)) {
			this.route_options.array_set(var_route, rt.new_array())
		}
		mut iter_11 := var_handlers.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_handler := item_11.val
			mut var_key := item_11.key
			if !(var_key.clone().is_long() || var_key.clone().is_double()) {
				this.route_options.array_get_mut(var_route).array_set(var_key, var_handler.clone())
				var_handlers.array_unset(var_key)
				continue
			}
			var_handler = rt.call_function('wp_parse_args', [
				var_handler.clone(), var_defaults.clone()])
			if rt.is_true(rt.new_bool(var_handler.array_get(rt.new_string('methods')).is_string())) {
				mut var_methods := rt.call_function('explode', [
					rt.new_string(','), var_handler.array_get(rt.new_string('methods'))])
			} else if rt.is_true(rt.new_bool(var_handler.array_get(rt.new_string('methods')).is_array())) {
				var_methods = var_handler.array_get(rt.new_string('methods'))
			} else {
				var_methods = rt.new_array()
			}
			var_handler.array_set('methods', rt.new_array())
			mut iter_12 := var_methods.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_method := item_12.val
				var_method = rt.new_string(var_method.clone().to_string().trim_space().to_upper())
				var_handler.array_get_mut('methods').array_set(var_method, true)
			}
		}
	}
	return var_endpoints.clone()
}

fn (mut this Class_WP_REST_Server) get_namespaces() rt.PhpVal {
	return rt.func_array_keys(this.namespaces)
}

fn (mut this Class_WP_REST_Server) get_route_options(var_route rt.PhpVal) rt.PhpVal {
	mut var_route_mutated := var_route
	if !(this.route_options.array_isset(var_route_mutated)) {
		return rt.new_null()
	}
	return this.route_options.array_get(var_route_mutated)
}

fn (mut this Class_WP_REST_Server) dispatch(var_request rt.PhpVal) rt.PhpVal {
	mut var_route := rt.new_null()
	mut var_handler := rt.new_null()
	mut var_request_mutated := var_request
	this.dispatching_requests.array_push(var_request_mutated.clone())
	mut var_result := rt.call_function('apply_filters', [
		rt.new_string('rest_pre_dispatch'),
		rt.new_null(),
		rt.new_object('WP_REST_Server', []string{}, &this),
		var_request_mutated.clone(),
	])
	if !(!rt.is_true(var_result)) {
		var_result = rt.call_function('rest_ensure_response', [
			var_result.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			var_result = this.error_to_response(var_result.clone())
		}
		rt.call_function('array_pop', [this.dispatching_requests])
		return var_result.clone()
	}
	mut var_error := rt.new_null()
	mut var_matched := this.match_request_to_handler(var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_matched.clone()])) {
		mut var_response := this.error_to_response(var_matched.clone())
		rt.call_function('array_pop', [this.dispatching_requests])
		return var_response.clone()
	}
	mut list_tmp_1 := var_matched
	var_route = list_tmp_1.array_get(0)
	var_handler = list_tmp_1.array_get(1)
	if !(rt.call_function('is_callable', [var_handler.array_get(rt.new_string('callback'))])) {
		var_error = create_wp_error(rt.new_string('rest_invalid_handler'), rt.call_function('__', [
			rt.new_string('The handler for the route is invalid.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_error.clone()])))))
	{
		mut var_check_required := rt.call_method(var_request_mutated, 'has_valid_params',
			[]rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_check_required.clone()])) {
			var_error = var_check_required.clone()
		} else {
			mut var_check_sanitized := rt.call_method(var_request_mutated, 'sanitize_params',
				[]rt.PhpVal{})
			if rt.is_true(rt.call_function('is_wp_error', [var_check_sanitized.clone()])) {
				var_error = var_check_sanitized.clone()
			}
		}
	}
	var_response = this.respond_to_request(var_request_mutated.clone(), var_route.clone(),
		var_handler.clone(), var_error.clone())
	rt.call_function('array_pop', [this.dispatching_requests])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Server) is_dispatching() bool {
	return (this.dispatching_requests).to_bool()
}

fn (mut this Class_WP_REST_Server) match_request_to_handler(var_request rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_request_mutated := var_request
	mut var_method := rt.call_method(var_request_mutated, 'get_method', []rt.PhpVal{})
	mut var_path := rt.call_method(var_request_mutated, 'get_route', []rt.PhpVal{})
	mut var_with_namespace := rt.new_array()
	mut iter_13 := this.get_namespaces().iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_namespace := item_13.val
		if rt.is_true(rt.call_function('str_starts_with', [
			rt.call_function('trailingslashit', [
				rt.new_string(var_path.clone().to_string().trim_left(' \t\n\r')),
			]),
			var_namespace.clone(),
		]))
		{
			var_with_namespace << this.get_routes(var_namespace.str())
		}
	}
	if rt.is_true(var_with_namespace) {
		mut var_routes := rt.call_function('array_merge', [
			rt.create_array_from_list(var_with_namespace),
		])
	} else {
		var_routes = this.get_routes('')
	}
	mut iter_14 := var_routes.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_handlers := item_14.val
		mut var_route := item_14.key
		mut var_match := rt.call_function('preg_match', [
			rt.new_string('@^' + var_route.str() + '$@i'),
			var_path.clone(),
			var_matches.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_match)))) {
			continue
		}
		mut var_args := rt.new_array()
		mut iter_15 := var_matches.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_value := item_15.val
			mut var_param := item_15.key
			if !(var_param.clone().is_long()) {
				var_args.array_set(var_param, var_value.clone())
			}
		}
		mut iter_16 := var_handlers.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_handler := item_16.val
			mut var_callback := var_handler.array_get(rt.new_string('callback'))
			mut var_checked_method := var_method.clone()
			if rt.is_true(rt.identical(rt.new_string('HEAD'), var_method))
				&& !rt.is_true(var_handler.array_get(rt.new_string('methods')).array_get(rt.new_string('HEAD'))) {
				var_checked_method = rt.new_string('GET')
			}
			if !rt.is_true(var_handler.array_get(rt.new_string('methods')).array_get(var_checked_method)) {
				continue
			}
			if !(rt.call_function('is_callable', [var_callback.clone()])) {
				return rt.create_array([rt.ArrayItem{ key: none, val: var_route },
					rt.ArrayItem{ key: none, val: var_handler }])
			}
			rt.call_method(var_request_mutated, 'set_url_params', [
				var_args.clone()])
			rt.call_method(var_request_mutated, 'set_attributes', [
				var_handler.clone()])
			mut var_defaults := rt.new_array()
			mut iter_17 := var_handler.array_get(rt.new_string('args')).iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_options := item_17.val
				mut var_arg := item_17.key
				if var_options.array_isset(rt.new_string('default')) {
					var_defaults.array_set(var_arg, var_options.array_get(rt.new_string('default')))
				}
			}
			rt.call_method(var_request_mutated, 'set_default_params', [
				var_defaults.clone()])
			return rt.create_array([rt.ArrayItem{ key: none, val: var_route },
				rt.ArrayItem{ key: none, val: var_handler }])
		}
	}
	return create_wp_error(rt.new_string('rest_no_route'), rt.call_function('__', [
		rt.new_string('No route was found matching the URL and request method.'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
}

fn (mut this Class_WP_REST_Server) respond_to_request(var_request rt.PhpVal, var_route rt.PhpVal, var_handler rt.PhpVal, var_response rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_route_mutated := var_route
	mut var_handler_mutated := var_handler
	mut var_response_mutated := var_response
	var_response_mutated = rt.call_function('apply_filters', [
		rt.new_string('rest_request_before_callbacks'),
		var_response_mutated.clone(),
		var_handler_mutated.clone(),
		var_request_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response_mutated.clone()])))))
		&& !(!rt.is_true(var_handler_mutated.array_get(rt.new_string('permission_callback')))) {
		mut var_permission := rt.call_function('call_user_func', [
			var_handler_mutated.array_get(rt.new_string('permission_callback')),
			var_request_mutated.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_permission.clone()])) {
			var_response_mutated = var_permission.clone()
		} else if rt.is_true(rt.identical(rt.new_bool(false), var_permission))
			|| rt.is_true(rt.identical(rt.new_null(), var_permission)) {
			var_response_mutated = create_wp_error(rt.new_string('rest_forbidden'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to do that.'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_response_mutated.clone()])))))
	{
		mut var_dispatch_result := rt.call_function('apply_filters', [
			rt.new_string('rest_dispatch_request'),
			rt.new_null(),
			var_request_mutated.clone(),
			var_route_mutated.clone(),
			var_handler_mutated.clone(),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_dispatch_result)))) {
			var_response_mutated = var_dispatch_result.clone()
		} else {
			var_response_mutated = rt.call_function('call_user_func', [
				var_handler_mutated.array_get(rt.new_string('callback')),
				var_request_mutated.clone(),
			])
		}
	}
	var_response_mutated = rt.call_function('apply_filters', [
		rt.new_string('rest_request_after_callbacks'),
		var_response_mutated.clone(),
		var_handler_mutated.clone(),
		var_request_mutated.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_response_mutated.clone()])) {
		var_response_mutated = this.error_to_response(var_response_mutated.clone())
	} else {
		var_response_mutated = rt.call_function('rest_ensure_response', [
			var_response_mutated.clone()])
	}
	rt.call_method(var_response_mutated, 'set_matched_route', [
		var_route_mutated.clone()])
	rt.call_method(var_response_mutated, 'set_matched_handler', [
		var_handler_mutated.clone()])
	return var_response_mutated.clone()
}

fn (mut this Class_WP_REST_Server) get_json_last_error() bool {
	if rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'), rt.call_function('json_last_error',
		[]rt.PhpVal{})))
	{
		return false
	}
	return (rt.call_function('json_last_error_msg', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WP_REST_Server) get_index(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_available := rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('get_option', [
			rt.new_string('blogname'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('get_option', [
			rt.new_string('blogdescription'),
		]) },
		rt.ArrayItem{ key: 'url', val: rt.call_function('get_option', [
			rt.new_string('siteurl'),
		]) },
		rt.ArrayItem{ key: 'home', val: rt.call_function('home_url', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'gmt_offset', val: rt.call_function('get_option', [
			rt.new_string('gmt_offset'),
		]) },
		rt.ArrayItem{ key: 'timezone_string', val: rt.call_function('get_option', [
			rt.new_string('timezone_string'),
		]) },
		rt.ArrayItem{ key: 'page_for_posts', val: rt.new_int((rt.call_function('get_option', [
			rt.new_string('page_for_posts'),
		])).to_i64()) },
		rt.ArrayItem{ key: 'page_on_front', val: rt.new_int((rt.call_function('get_option', [
			rt.new_string('page_on_front'),
		])).to_i64()) },
		rt.ArrayItem{ key: 'show_on_front', val: rt.call_function('get_option', [
			rt.new_string('show_on_front'),
		]) },
		rt.ArrayItem{ key: 'namespaces', val: rt.func_array_keys(this.namespaces) },
		rt.ArrayItem{ key: 'authentication', val: rt.new_array() },
		rt.ArrayItem{ key: 'routes', val: this.get_data_for_routes(this.get_routes(''),
			(var_request_mutated.array_get(rt.new_string('context'))).str()) },
	])
	mut var_response := create_wp_rest_response(var_available.clone())
	mut var_fields := if !(var_request_mutated.array_get(rt.new_string('_fields'))).is_null() {
		var_request_mutated.array_get(rt.new_string('_fields'))
	} else {
		rt.new_string('')
	}
	var_fields = rt.call_function('wp_parse_list', [var_fields.clone()])
	if !rt.is_true(var_fields) {
		var_fields.array_push('_links')
	}
	if rt.is_true(rt.call_method(var_request_mutated, 'has_param', [
		rt.new_string('_embed'),
	]))
	{
		var_fields.array_push('_embedded')
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_link', [rt.new_string('help'),
			rt.new_string('https://developer.wordpress.org/rest-api/')])
		this.add_active_theme_link_to_index(mut rt.cast_object_ptr[Class_WP_REST_Response](var_response))
		this.add_site_logo_to_index(mut rt.cast_object_ptr[Class_WP_REST_Response](var_response))
		this.add_site_icon_to_index(mut rt.cast_object_ptr[Class_WP_REST_Response](var_response))
	} else {
		if rt.is_true(rt.call_function('rest_is_field_included', [
			rt.new_string('site_logo'),
			var_fields.clone(),
		]))
		{
			this.add_site_logo_to_index(mut rt.cast_object_ptr[Class_WP_REST_Response](var_response))
		}
		if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('site_icon'), var_fields.clone()]))
			|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('site_icon_url'), var_fields.clone()])) {
			this.add_site_icon_to_index(mut rt.cast_object_ptr[Class_WP_REST_Response](var_response))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_index'),
		var_response.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WP_REST_Server) add_active_theme_link_to_index(mut var_response Class_WP_REST_Response) {
	mut var_response_mutated := var_response
	mut var_should_add := rt.new_bool(
		rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_add))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		var_should_add = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_add)))) {
		mut iter_18 := rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
			rt.new_string('objects'),
		]).iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_post_type := item_18.val
			if rt.is_true(rt.call_function('current_user_can', [
				rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
			]))
			{
				var_should_add = rt.new_bool(true)
				break
			}
		}
	}
	if rt.is_true(var_should_add) {
		mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
		rt.call_method(var_response_mutated, 'add_link', [
			rt.new_string('https://api.w.org/active-theme'),
			rt.call_function('rest_url', [
				rt.new_string('wp/v2/themes/' +
					(rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})).str()),
			]),
		])
	}
}

fn (mut this Class_WP_REST_Server) add_site_logo_to_index(mut var_response Class_WP_REST_Response) {
	mut var_response_mutated := var_response
	mut var_site_logo_id := rt.call_function('get_theme_mod', [
		rt.new_string('custom_logo'),
		rt.new_int(0),
	])
	this.add_image_to_index(mut var_response_mutated, var_site_logo_id.clone(),
		rt.new_string('site_logo'))
}

fn (mut this Class_WP_REST_Server) add_site_icon_to_index(mut var_response Class_WP_REST_Response) {
	mut var_response_mutated := var_response
	mut var_site_icon_id := rt.call_function('get_option', [rt.new_string('site_icon'),
		rt.new_int(0)])
	this.add_image_to_index(mut var_response_mutated, var_site_icon_id.clone(),
		rt.new_string('site_icon'))
	rt.get_property(var_response_mutated, 'data').array_set('site_icon_url', rt.call_function('get_site_icon_url',
		[]rt.PhpVal{}))
}

fn (mut this Class_WP_REST_Server) add_image_to_index(mut var_response Class_WP_REST_Response, var_image_id rt.PhpVal, var_type rt.PhpVal) {
	mut var_response_mutated := var_response
	rt.get_property(var_response_mutated, 'data').array_set(var_type,
		rt.new_int(var_image_id.to_i64()))
	if rt.is_true(var_image_id) {
		rt.call_method(var_response_mutated, 'add_link', [
			rt.new_string('https://api.w.org/featuredmedia'),
			rt.call_function('rest_url', [
				rt.call_function('rest_get_route_for_post', [
					var_image_id.clone()]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'embeddable', val: true },
				rt.ArrayItem{ key: 'type', val: var_type },
			]),
		])
	}
}

fn (mut this Class_WP_REST_Server) get_namespace_index(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_namespace := var_request_mutated.array_get(rt.new_string('namespace'))
	if !(this.namespaces.array_isset(var_namespace)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_namespace'), rt.call_function('__', [
			rt.new_string('The specified namespace could not be found.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_routes := this.namespaces.array_get(var_namespace)
	mut var_endpoints := rt.call_function('array_intersect_key', [
		this.get_routes(''), var_routes.clone()])
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'namespace', val: var_namespace },
		rt.ArrayItem{ key: 'routes', val: this.get_data_for_routes(var_endpoints.clone(),
			(var_request_mutated.array_get(rt.new_string('context'))).str()) },
	])
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_link', [rt.new_string('up'),
		rt.call_function('rest_url', [rt.new_string('/')])])
	return rt.call_function('apply_filters', [rt.new_string('rest_namespace_index'),
		var_response.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WP_REST_Server) get_data_for_routes(var_routes rt.PhpVal, context string) rt.PhpVal {
	mut var_routes_mutated := var_routes
	mut var_available := rt.new_array()
	mut iter_19 := var_routes_mutated.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_callbacks := item_19.val
		mut var_route := item_19.key
		mut var_data := this.get_data_for_route(var_route.clone(), var_callbacks.clone(), context)
		if !rt.is_true(var_data) {
			continue
		}
		var_available.array_set(var_route, rt.call_function('apply_filters', [
			rt.new_string('rest_endpoints_description'),
			var_data.clone(),
		]))
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_route_data'),
		var_available.clone(), var_routes_mutated.clone()])
}

fn (mut this Class_WP_REST_Server) get_data_for_route(var_route rt.PhpVal, var_callbacks rt.PhpVal, context string) rt.PhpVal {
	mut var_route_mutated := var_route
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'namespace', val: '' },
		rt.ArrayItem{ key: 'methods', val: rt.new_array() }, rt.ArrayItem{
			key: 'endpoints'
			val: rt.new_array()
		}])
	mut var_allow_batch := rt.new_bool(false)
	if this.route_options.array_isset(var_route_mutated) {
		mut var_options := this.route_options.array_get(var_route_mutated)
		if var_options.array_isset(rt.new_string('namespace')) {
			var_data.array_set('namespace', var_options.array_get(rt.new_string('namespace')))
		}
		var_allow_batch = if !(var_options.array_get(rt.new_string('allow_batch'))).is_null() {
			var_options.array_get(rt.new_string('allow_batch'))
		} else {
			rt.new_bool(false)
		}
		if var_options.array_isset(rt.new_string('schema'))
			&& rt.is_true(rt.identical(rt.new_string('help'), rt.new_string(context))) {
			var_data.array_set('schema', rt.call_function('call_user_func', [
				var_options.array_get(rt.new_string('schema')),
			]))
		}
	}
	mut var_allowed_schema_keywords := rt.call_function('array_flip', [
		rt.call_function('rest_get_allowed_schema_keywords', []rt.PhpVal{}),
	])
	var_route_mutated = rt.call_function('preg_replace', [
		rt.new_string('#\\(\\?P<(\\w+?)>.*?\\)#'),
		rt.new_string('{$1}'),
		var_route_mutated.clone(),
	])
	mut iter_20 := var_callbacks.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_callback := item_20.val
		if !rt.is_true(var_callback.array_get(rt.new_string('show_in_index'))) {
			continue
		}
		var_data.array_set('methods', rt.call_function('array_merge', [
			var_data.array_get(rt.new_string('methods')),
			rt.func_array_keys(var_callback.array_get(rt.new_string('methods'))),
		]))
		mut var_endpoint_data := {
			'methods': rt.func_array_keys(var_callback.array_get(rt.new_string('methods')))
		}
		mut var_callback_batch := if !(var_callback.array_get(rt.new_string('allow_batch'))).is_null() {
			var_callback.array_get(rt.new_string('allow_batch'))
		} else {
			var_allow_batch
		}
		if rt.is_true(var_callback_batch) {
			var_endpoint_data['allow_batch'] = var_callback_batch.clone()
		}
		if var_callback.array_isset(rt.new_string('args')) {
			var_endpoint_data['args'] = rt.new_array()
			mut iter_21 := var_callback.array_get(rt.new_string('args')).iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_opts := item_21.val
				mut var_key := item_21.key
				if rt.is_true(rt.new_bool(var_opts.clone().is_string())) {
					var_opts = rt.create_array([rt.ArrayItem{ key: var_opts, val: 0 }])
				} else if !(var_opts.clone().is_array()) {
					var_opts = rt.new_array()
				}
				mut var_arg_data := rt.call_function('array_intersect_key', [
					var_opts.clone(), var_allowed_schema_keywords.clone()])
				var_arg_data.array_set('required',
					!(!rt.is_true(var_opts.array_get(rt.new_string('required')))))
				var_endpoint_data.array_get_mut('args').array_set(var_key, var_arg_data.clone())
			}
		}
		var_data.array_get_mut('endpoints').array_push(var_endpoint_data.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			var_route_mutated.clone(),
			rt.new_string('{'),
		])))))
		{
			var_data.array_set('_links', rt.create_array([
				rt.ArrayItem{ key: 'self', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
							var_route_mutated.clone(),
						]) },
					]) },
				]) },
			]))
		}
	}
	if !rt.is_true(var_data.array_get(rt.new_string('methods'))) {
		return rt.new_null()
	}
	return var_data.clone()
}

fn (mut this Class_WP_REST_Server) get_max_batch_size() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('rest_get_max_batch_size'),
		rt.new_int(25)])
}

fn (mut this Class_WP_REST_Server) serve_batch_request_v1(mut var_batch_request Class_WP_REST_Request) rt.PhpVal {
	mut var_route := rt.new_null()
	mut var_handler := rt.new_null()
	mut var_requests := rt.new_array()
	mut iter_22 := var_batch_request.array_get(rt.new_string('requests')).iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_args := item_22.val
		mut var_parsed_url := rt.call_function('wp_parse_url', [
			var_args.array_get(rt.new_string('path')),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_parsed_url)) {
			var_requests << create_wp_error(rt.new_string('parse_path_failed'), rt.call_function('__', [
				rt.new_string('Could not parse the path.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			continue
		}
		mut var_single_request := create_wp_rest_request(if !(var_args.array_get(rt.new_string('method'))).is_null() {
			var_args.array_get(rt.new_string('method'))
		} else {
			rt.new_string('POST')
		}, var_parsed_url.array_get(rt.new_string('path')))
		if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('query')))) {
			mut var_query_args := rt.new_array()
			rt.call_function('wp_parse_str', [var_parsed_url.array_get(rt.new_string('query')),
				var_query_args.clone()])
			var_single_request.set_query_params(var_query_args.clone())
		}
		if !(!rt.is_true(var_args.array_get(rt.new_string('body')))) {
			var_single_request.set_body_params(var_args.array_get(rt.new_string('body')))
		}
		if !(!rt.is_true(var_args.array_get(rt.new_string('headers')))) {
			var_single_request.set_headers(var_args.array_get(rt.new_string('headers')))
		}
		var_requests << var_single_request
	}
	mut var_matches := rt.new_array()
	mut var_validation := rt.new_array()
	mut var_has_error := rt.new_bool(false)
	for var_single_request in var_requests {
		if rt.is_true(rt.call_function('is_wp_error', [var_single_request.clone()])) {
			var_has_error = rt.new_bool(true)
			var_validation.array_push(var_single_request.clone())
			continue
		}
		mut var_match := this.match_request_to_handler(var_single_request.clone())
		var_matches.array_push(var_match.clone())
		mut var_error := rt.new_null()
		if rt.is_true(rt.call_function('is_wp_error', [var_match.clone()])) {
			var_error = var_match.clone()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_error)))) {
			mut list_tmp_2 := var_match
			var_route = list_tmp_2.array_get(0)
			var_handler = list_tmp_2.array_get(1)
			if var_handler.array_isset(rt.new_string('allow_batch')) {
				mut var_allow_batch := var_handler.array_get(rt.new_string('allow_batch'))
			} else {
				mut var_route_options := this.get_route_options(var_route.clone())
				var_allow_batch = if !(var_route_options.array_get(rt.new_string('allow_batch'))).is_null() {
					var_route_options.array_get(rt.new_string('allow_batch'))
				} else {
					rt.new_bool(false)
				}
			}
			if !(var_allow_batch.clone().is_array())
				|| !rt.is_true(var_allow_batch.array_get(rt.new_string('v1'))) {
				var_error = create_wp_error(rt.new_string('rest_batch_not_allowed'), rt.call_function('__', [
					rt.new_string('The requested route does not support batch requests.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_error)))) {
			mut var_check_required := rt.call_method(var_single_request, 'has_valid_params',
				[]rt.PhpVal{})
			if rt.is_true(rt.call_function('is_wp_error', [var_check_required.clone()])) {
				var_error = var_check_required.clone()
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_error)))) {
			mut var_check_sanitized := rt.call_method(var_single_request, 'sanitize_params',
				[]rt.PhpVal{})
			if rt.is_true(rt.call_function('is_wp_error', [var_check_sanitized.clone()])) {
				var_error = var_check_sanitized.clone()
			}
		}
		if rt.is_true(var_error) {
			var_has_error = rt.new_bool(true)
			var_validation.array_push(var_error.clone())
		} else {
			var_validation.array_push(true)
		}
	}
	mut var_responses := rt.new_array()
	if rt.is_true(var_has_error)
		&& rt.is_true(rt.identical(rt.new_string('require-all-validate'), var_batch_request.array_get(rt.new_string('validation')))) {
		mut iter_23 := var_validation.iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_valid := item_23.val
			if rt.is_true(rt.call_function('is_wp_error', [var_valid.clone()])) {
				var_responses << rt.call_method(this.envelope_response(this.error_to_response(var_valid.clone()),
					rt.new_bool(false)), 'get_data', []rt.PhpVal{})
			} else {
				var_responses << rt.new_null()
			}
		}
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
			rt.ArrayItem{ key: 'failed', val: 'validation' },
			rt.ArrayItem{ key: 'responses', val: var_responses },
		]), Class_WP_Http.multi_status()))
	}
	for var_i, var_single_request in var_requests {
		if rt.is_true(rt.call_function('is_wp_error', [var_single_request.clone()])) {
			mut var_result := this.error_to_response(var_single_request.clone())
			var_responses << rt.call_method(this.envelope_response(var_result.clone(),
				rt.new_bool(false)), 'get_data', []rt.PhpVal{})
			continue
		}
		mut var_clean_request := var_single_request.dup()
		rt.call_method(var_clean_request, 'set_url_params', [
			rt.new_array()])
		rt.call_method(var_clean_request, 'set_attributes', [
			rt.new_array()])
		rt.call_method(var_clean_request, 'set_default_params', [
			rt.new_array()])
		var_result = rt.call_function('apply_filters', [
			rt.new_string('rest_pre_dispatch'),
			rt.new_null(),
			rt.new_object('WP_REST_Server', []string{}, &this),
			var_clean_request.clone(),
		])
		if !rt.is_true(var_result) {
			mut var_match := var_matches.array_get(rt.new_int(i))
			mut var_error := rt.new_null()
			if rt.is_true(rt.call_function('is_wp_error', [var_validation.array_get(rt.new_int(i))])) {
				var_error = var_validation.array_get(rt.new_int(i))
			}
			if rt.is_true(rt.call_function('is_wp_error', [var_match.clone()])) {
				var_result = this.error_to_response(var_match.clone())
			} else {
				mut list_tmp_3 := var_match
				var_route = list_tmp_3.array_get(0)
				var_handler = list_tmp_3.array_get(1)
				if rt.is_true(rt.new_bool(!(rt.is_true(var_error))))
					&& !(rt.call_function('is_callable', [var_handler.array_get(rt.new_string('callback'))])) {
					var_error = create_wp_error(rt.new_string('rest_invalid_handler'), rt.call_function('__', [
						rt.new_string('The handler for the route is invalid'),
					]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
				}
				var_result = this.respond_to_request(var_single_request.clone(), var_route.clone(),
					var_handler.clone(), var_error.clone())
			}
		}
		var_result = rt.call_function('apply_filters', [
			rt.new_string('rest_post_dispatch'),
			rt.call_function('rest_ensure_response', [var_result.clone()]),
			rt.new_object('WP_REST_Server', []string{}, &this),
			var_single_request.clone(),
		])
		var_responses << rt.call_method(this.envelope_response(var_result.clone(),
			rt.new_bool(false)), 'get_data', []rt.PhpVal{})
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'responses', val: var_responses },
	]), Class_WP_Http.multi_status()))
}

fn (mut this Class_WP_REST_Server) set_status(var_code rt.PhpVal) {
	mut var_code_mutated := var_code
	rt.call_function('status_header', [var_code_mutated.clone()])
}

fn (mut this Class_WP_REST_Server) send_header(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	var_value_mutated = rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
		rt.new_string(' '), var_value_mutated.clone()])
	rt.call_function('header', [
		rt.call_function('sprintf', [rt.new_string('%s: %s'),
			var_key.clone(), var_value_mutated.clone()]),
	])
}

fn (mut this Class_WP_REST_Server) send_headers(var_headers rt.PhpVal) {
	mut var_headers_mutated := var_headers
	mut iter_24 := var_headers_mutated.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_value := item_24.val
		mut var_key := item_24.key
		this.send_header(var_key.clone(), var_value.clone())
	}
}

fn (mut this Class_WP_REST_Server) remove_header(var_key rt.PhpVal) {
	rt.call_function('header_remove', [var_key.clone()])
}

fn Class_WP_REST_Server.get_raw_data() rt.PhpVal {
	mut var_HTTP_RAW_POST_DATA := rt.get_superglobal('HTTP_RAW_POST_DATA')
	if !(!var_HTTP_RAW_POST_DATA.is_null()) {
		var_HTTP_RAW_POST_DATA = rt.call_function('file_get_contents', [
			rt.new_string('php://input'),
		])
	}
	return var_HTTP_RAW_POST_DATA.clone()
	return rt.new_null()
}

fn (mut this Class_WP_REST_Server) get_headers(var_server rt.PhpVal) rt.PhpVal {
	mut var_server_mutated := var_server
	mut var_headers := rt.new_array()
	mut var_additional := {
		'CONTENT_LENGTH': true
		'CONTENT_MD5':    true
		'CONTENT_TYPE':   true
	}
	mut iter_25 := var_server_mutated.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_value := item_25.val
		mut var_key := item_25.key
		if rt.is_true(rt.call_function('str_starts_with', [var_key.clone(),
			rt.new_string('HTTP_')]))
		{
			var_headers.array_set(rt.call_function('substr', [
				var_key.clone(), rt.new_int(5)]), var_value.clone())
		} else if rt.is_true(rt.identical(rt.new_string('REDIRECT_HTTP_AUTHORIZATION'), var_key))
			&& !rt.is_true(var_server_mutated.array_get(rt.new_string('HTTP_AUTHORIZATION'))) {
			var_headers.array_set('AUTHORIZATION', var_value.clone())
		} else if var_additional.array_isset(var_key) {
			var_headers.array_set(var_key, var_value.clone())
		}
	}
	return var_headers.clone()
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_server() &Class_WP_REST_Server {
	mut obj := &Class_WP_REST_Server{
		PhpObjectBase:        rt.PhpObjectBase{}
		namespaces:           rt.new_array()
		endpoints:            rt.new_array()
		route_options:        rt.new_array()
		embed_cache:          rt.new_array()
		dispatching_requests: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'check_authentication' {
			return this.check_authentication()
		}
		'error_to_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.error_to_response(dispatch_arg_0)
		}
		'json_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.json_error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_json_encode_options' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_json_encode_options(mut dispatch_arg_0)
		}
		'serve_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.serve_request(dispatch_arg_0)
		}
		'response_to_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.response_to_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_response_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_REST_Server.get_response_links(dispatch_arg_0)
		}
		'get_target_hints_for_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_REST_Server.get_target_hints_for_link(dispatch_arg_0)
		}
		'get_compact_response_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_REST_Server.get_compact_response_links(dispatch_arg_0)
		}
		'embed_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.embed_links(dispatch_arg_0, dispatch_arg_1)
		}
		'envelope_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.envelope_response(dispatch_arg_0, dispatch_arg_1)
		}
		'register_route' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.register_route(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_routes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_routes(dispatch_arg_0)
		}
		'get_namespaces' {
			return this.get_namespaces()
		}
		'get_route_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_route_options(dispatch_arg_0)
		}
		'dispatch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.dispatch(dispatch_arg_0)
		}
		'is_dispatching' {
			return rt.new_bool(this.is_dispatching())
		}
		'match_request_to_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.match_request_to_handler(dispatch_arg_0)
		}
		'respond_to_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.respond_to_request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_json_last_error' {
			return rt.new_bool(this.get_json_last_error())
		}
		'get_index' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_index(dispatch_arg_0)
		}
		'add_active_theme_link_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_active_theme_link_to_index(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_site_logo_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_site_logo_to_index(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_site_icon_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_site_icon_to_index(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_image_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_image_to_index(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_namespace_index' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_namespace_index(dispatch_arg_0)
		}
		'get_data_for_routes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_data_for_routes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_data_for_route' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_data_for_route(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_max_batch_size' {
			return this.get_max_batch_size()
		}
		'serve_batch_request_v1' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.serve_batch_request_v1(mut dispatch_arg_0)
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'send_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.send_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'send_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.send_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_header(dispatch_arg_0)
			return rt.new_null()
		}
		'get_raw_data' {
			return Class_WP_REST_Server.get_raw_data()
		}
		'get_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_headers(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespaces' { return this.namespaces }
		'endpoints' { return this.endpoints }
		'route_options' { return this.route_options }
		'embed_cache' { return this.embed_cache }
		'dispatching_requests' { return this.dispatching_requests }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespaces' {
			this.namespaces = val
			return true
		}
		'endpoints' {
			this.endpoints = val
			return true
		}
		'route_options' {
			this.route_options = val
			return true
		}
		'embed_cache' {
			this.embed_cache = val
			return true
		}
		'dispatching_requests' {
			this.dispatching_requests = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
