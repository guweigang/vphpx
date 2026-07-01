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
		namespaces rt.PhpVal = rt.new_array()
		endpoints rt.PhpVal = rt.new_array()
		route_options rt.PhpVal = rt.new_array()
		embed_cache rt.PhpVal = rt.new_array()
		dispatching_requests rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Server) construct()  {
	this.endpoints = rt.create_array([rt.ArrayItem{ key: '/', val: rt.create_array([rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Server', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_index' }]) }, rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }]) }]) }]) }, rt.ArrayItem{ key: '/batch/v1', val: rt.create_array([rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Server', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'serve_batch_request_v1' }]) }, rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'validation', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'require-all-validate' }, rt.ArrayItem{ key: none, val: 'normal' }]) }, rt.ArrayItem{ key: 'default', val: 'normal' }]) }, rt.ArrayItem{ key: 'requests', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'maxItems', val: this.get_max_batch_size() }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'method', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'POST' }, rt.ArrayItem{ key: none, val: 'PUT' }, rt.ArrayItem{ key: none, val: 'PATCH' }, rt.ArrayItem{ key: none, val: 'DELETE' }]) }, rt.ArrayItem{ key: 'default', val: 'POST' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.new_array() }, rt.ArrayItem{ key: 'additionalProperties', val: true }]) }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.new_array() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'array' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }]) }]) }]) }]) }])
}

fn (mut this Class_WP_REST_Server) check_authentication() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('rest_authentication_errors'), rt.new_null()])
}

fn (mut this Class_WP_REST_Server) error_to_response(var_error rt.PhpVal) rt.PhpVal {
	mut var_error_mutated := var_error
	return rt.call_function('rest_convert_error_to_response', [var_error_mutated.dup()])
}

fn (mut this Class_WP_REST_Server) json_error(var_code rt.PhpVal, var_message rt.PhpVal, var_status rt.PhpVal) rt.PhpVal {
	mut var_code_mutated := var_code
	if rt.is_true(var_status) {
		this.set_status(var_status.dup())
	}
	mut var_error := rt.call_function('compact', [rt.new_string('code'), rt.new_string('message')])
	return rt.call_function('wp_json_encode', [var_error.dup()])
}

fn (mut this Class_WP_REST_Server) get_json_encode_options(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_options := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.call_method(var_request_mutated, 'has_param', [rt.new_string('_pretty')])) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_json_encode_options'), var_options.dup(), var_request_mutated.dup()])
}

fn (mut this Class_WP_REST_Server) serve_request(var_path rt.PhpVal) rt.PhpVal {
	mut var__FILES := rt.new_null()
	mut var_path_mutated := var_path
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_current_user, 'WP_User'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_current_user, 'exists', []rt.PhpVal{}))))))) {
		mut var_current_user := rt.new_null()
	}
	mut var_jsonp_enabled := rt.call_function('apply_filters', [rt.new_string('rest_jsonp_enabled'), rt.new_bool(true)])
	mut var_jsonp_callback := rt.new_bool(rt.new_bool(false))
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_jsonp')) {
		var_jsonp_callback = rt.get_superglobal('_GET').array_get('_jsonp')
	}
	mut var_content_type := rt.new_string(if rt.is_true(rt.new_bool(rt.is_true(var_jsonp_callback) && rt.is_true(var_jsonp_enabled))) { rt.new_string('application/javascript') } else { rt.new_string('application/json') })
	this.send_header(rt.new_string('Content-Type'), rt.new_string((var_content_type).str() + '; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str()))
	this.send_header(rt.new_string('X-Robots-Tag'), rt.new_string('noindex'))
	mut var_api_root := rt.call_function('get_rest_url', []rt.PhpVal{})
	if !(!rt.is_true(var_api_root)) {
		this.send_header(rt.new_string('Link'), rt.new_string('<' + (rt.call_function('sanitize_url', [var_api_root.dup()])).str() + '>; rel="https://api.w.org/"'))
	}
	this.send_header(rt.new_string('X-Content-Type-Options'), rt.new_string('nosniff'))
	rt.call_function('apply_filters_deprecated', [rt.new_string('rest_enabled'), rt.create_array([rt.ArrayItem{ key: none, val: true }]), rt.new_string('4.7.0'), rt.new_string('rest_authentication_errors'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The REST API can no longer be completely disabled, the %s filter can be used to restrict access to the API, instead.')]), rt.new_string('rest_authentication_errors')])])
	if rt.is_true(var_jsonp_callback) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_jsonp_enabled)))) {
			rt.echo_val(this.json_error(rt.new_string('rest_callback_disabled'), rt.call_function('__', [rt.new_string('JSONP support is disabled on this site.')]), rt.new_int(400)))
			return rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_check_jsonp_callback', [var_jsonp_callback.dup()]))))) {
			rt.echo_val(this.json_error(rt.new_string('rest_callback_invalid'), rt.call_function('__', [rt.new_string('Invalid JSONP callback function.')]), rt.new_int(400)))
			return rt.new_bool(false)
		}
	}
	if !rt.is_true(var_path_mutated) {
		var_path_mutated = if !(rt.get_superglobal('_SERVER').array_get('PATH_INFO')).is_null() { rt.get_superglobal('_SERVER').array_get('PATH_INFO') } else { rt.new_string('/') }
	}
	mut var_request := create_wp_rest_request(rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD'), var_path_mutated.dup())
	rt.call_method(var_request, 'set_query_params', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').dup()])])
	rt.call_method(var_request, 'set_body_params', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').dup()])])
	rt.call_method(var_request, 'set_file_params', [var__FILES.dup()])
	rt.call_method(var_request, 'set_headers', [this.get_headers(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').dup()]))])
	rt.call_method(var_request, 'set_body', [Class_WP_REST_Server.get_raw_data()])
	mut var_method_overridden := rt.new_bool(rt.new_bool(false))
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_method')) {
		rt.call_method(var_request, 'set_method', [rt.get_superglobal('_GET').array_get('_method')])
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_HTTP_METHOD_OVERRIDE')) {
		rt.call_method(var_request, 'set_method', [rt.get_superglobal('_SERVER').array_get('HTTP_X_HTTP_METHOD_OVERRIDE')])
		var_method_overridden = rt.new_bool(rt.new_bool(true))
	}
	mut var_expose_headers := rt.create_array([rt.ArrayItem{ key: none, val: 'X-WP-Total' }, rt.ArrayItem{ key: none, val: 'X-WP-TotalPages' }, rt.ArrayItem{ key: none, val: 'Link' }])
	var_expose_headers = rt.call_function('apply_filters', [rt.new_string('rest_exposed_cors_headers'), var_expose_headers.dup(), var_request.dup()])
	this.send_header(rt.new_string('Access-Control-Expose-Headers'), rt.call_function('implode', [rt.new_string(', '), var_expose_headers.dup()]))
	mut var_allow_headers := rt.create_array([rt.ArrayItem{ key: none, val: 'Authorization' }, rt.ArrayItem{ key: none, val: 'X-WP-Nonce' }, rt.ArrayItem{ key: none, val: 'Content-Disposition' }, rt.ArrayItem{ key: none, val: 'Content-MD5' }, rt.ArrayItem{ key: none, val: 'Content-Type' }])
	var_allow_headers = rt.call_function('apply_filters', [rt.new_string('rest_allowed_cors_headers'), var_allow_headers.dup(), var_request.dup()])
	this.send_header(rt.new_string('Access-Control-Allow-Headers'), rt.call_function('implode', [rt.new_string(', '), var_allow_headers.dup()]))
	mut var_result := this.check_authentication()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))) {
		var_result = this.dispatch(var_request.dup())
	}
	var_result = rt.call_function('rest_ensure_response', [var_result.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		var_result = this.error_to_response(var_result.dup())
	}
	var_result = rt.call_function('apply_filters', [rt.new_string('rest_post_dispatch'), rt.call_function('rest_ensure_response', [var_result.dup()]), rt.new_object('WP_REST_Server', []string{}, &this), var_request.dup()])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_envelope')) {
		mut var_embed := if rt.get_superglobal('_GET').array_isset(rt.new_string('_embed')) { rt.call_function('rest_parse_embed_param', [rt.get_superglobal('_GET').array_get('_embed')]) } else { rt.new_bool(false) }
		var_result = this.envelope_response(var_result.dup(), var_embed.dup())
	}
	mut var_headers := rt.call_method(var_result, 'get_headers', []rt.PhpVal{})
	this.send_headers(var_headers.dup())
	mut var_code := rt.call_method(var_result, 'get_status', []rt.PhpVal{})
	this.set_status(var_code.dup())
	mut var_send_no_cache_headers := rt.call_function('apply_filters', [rt.new_string('rest_send_nocache_headers'), rt.call_function('is_user_logged_in', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(var_send_no_cache_headers) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_method_overridden)) && rt.is_true(rt.call_function('str_starts_with', [var_code.dup(), rt.new_string('4')])))))) {
		{
			mut iter_1 := rt.call_function('wp_get_nocache_headers', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_header_value := item_1.val
				mut var_header := item_1.key
				if !rt.is_true(var_header_value) {
					this.remove_header(var_header.dup())
				} else {
					this.send_header(var_header.dup(), var_header_value.dup())
				}
			}
		}
	}
	mut var_served := rt.call_function('apply_filters', [rt.new_string('rest_pre_serve_request'), rt.new_bool(false), var_result.dup(), var_request.dup(), rt.new_object('WP_REST_Server', []string{}, &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_served)))) {
		if rt.is_true(rt.identical(rt.new_string('HEAD'), rt.call_method(var_request, 'get_method', []rt.PhpVal{}))) {
			return rt.new_null()
		}
		var_embed = if rt.get_superglobal('_GET').array_isset(rt.new_string('_embed')) { rt.call_function('rest_parse_embed_param', [rt.get_superglobal('_GET').array_get('_embed')]) } else { rt.new_bool(false) }
		var_result = this.response_to_data(var_result.dup(), var_embed.dup())
		var_result = rt.call_function('apply_filters', [rt.new_string('rest_pre_echo_response'), var_result.dup(), rt.new_object('WP_REST_Server', []string{}, &this), var_request.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(204), var_code)) || rt.is_true(rt.identical(rt.new_null(), var_result)))) {
			return rt.new_null()
		}
		var_result = rt.call_function('wp_json_encode', [var_result.dup(), this.get_json_encode_options(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))])
		mut var_json_error_message := rt.new_bool(this.get_json_last_error())
		if rt.is_true(var_json_error_message) {
			this.set_status(rt.new_int(500))
			mut var_json_error_obj := create_wp_error(rt.new_string('rest_encode_error'), var_json_error_message.dup(), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
			var_result = this.error_to_response(rt.new_object('WP_Error', []string{}, var_json_error_obj))
			var_result = rt.call_function('wp_json_encode', [rt.get_property(var_result, 'data'), this.get_json_encode_options(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))])
		}
		if rt.is_true(var_jsonp_callback) {
			print('/**/' + (var_jsonp_callback).str() + '(' + (var_result).str() + ')')
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
	mut var_links := Class_WP_REST_Server.get_compact_response_links(var_response_mutated.dup())
	if !(!rt.is_true(var_links)) {
		var_data.array_set('_links', var_links.dup())
	}
	if rt.is_true(var_embed_mutated) {
		this.embed_cache = rt.new_array()
		if rt.is_true(rt.call_function('wp_is_numeric_array', [var_data.dup()])) {
			{
				mut iter_1 := var_data.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_item := item_1.val
					mut var_key := item_1.key
					var_data.array_set(var_key, this.embed_links(var_item.dup(), (var_embed_mutated).to_bool()))
				}
			}
		} else {
			var_data = this.embed_links(var_data.dup(), (var_embed_mutated).to_bool())
		}
		this.embed_cache = rt.new_array()
	}
	return var_data.dup()
}

fn Class_WP_REST_Server.get_response_links(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_links := rt.call_method(var_response_mutated, 'get_links', []rt.PhpVal{})
	if !rt.is_true(var_links) {
		return rt.new_array()
	}
	mut var_data := rt.new_array()
	{
		mut iter_1 := var_links.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_items := item_1.val
			mut var_rel := item_1.key
			var_data.array_set(var_rel, rt.new_array())
			{
				mut iter_2 := var_items.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_item := item_2.val
					mut var_attributes := var_item.array_get('attributes')
					var_attributes.array_set('href', var_item.array_get('href'))
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_data.array_get_mut(var_rel).array_push(var_attributes.dup())
						continue
					}
					mut var_target_hints := Class_WP_REST_Server.get_target_hints_for_link(var_attributes.dup())
					if rt.is_true(var_target_hints) {
						var_attributes.array_set('targetHints', var_target_hints.dup())
					}
					var_data.array_get_mut(var_rel).array_push(var_attributes.dup())
				}
			}
		}
	}
	return var_data.dup()
}

fn Class_WP_REST_Server.get_target_hints_for_link(var_link rt.PhpVal) rt.PhpVal {
	if var_link.array_get('targetHints').array_isset(rt.new_string('allow')) {
		return rt.new_null()
	}
	mut var_request := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_REST_Request{}; return temp.from_url(arg_0) }()
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return 
	}
	
}

fn Class_WP_REST_Server.get_compact_response_links(var_response rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_REST_Server) embed_links(var_data rt.PhpVal, embed bool) rt.PhpVal {
	mut var_data_mutated := var_data
	mut embed_mutated := embed
}

fn (mut this Class_WP_REST_Server) envelope_response(var_response rt.PhpVal, var_embed rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_embed_mutated := var_embed
}

fn (mut this Class_WP_REST_Server) register_route(var_route_namespace rt.PhpVal, var_route rt.PhpVal, var_route_args rt.PhpVal, override bool)  {
	mut var_route_mutated := var_route
	mut var_route_args_mutated := var_route_args
}

fn (mut this Class_WP_REST_Server) get_routes(route_namespace string) rt.PhpVal {
}

fn (mut this Class_WP_REST_Server) get_namespaces() rt.PhpVal {
}

fn (mut this Class_WP_REST_Server) get_route_options(var_route rt.PhpVal) rt.PhpVal {
	mut var_route_mutated := var_route
}

fn (mut this Class_WP_REST_Server) dispatch(var_request rt.PhpVal) rt.PhpVal {
	mut var_route := rt.new_null()
	mut var_handler := rt.new_null()
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Server) is_dispatching() rt.PhpVal {
}

fn (mut this Class_WP_REST_Server) match_request_to_handler(var_request rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Server) respond_to_request(var_request rt.PhpVal, var_route rt.PhpVal, var_handler rt.PhpVal, var_response rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_route_mutated := var_route
	mut var_handler_mutated := var_handler
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_REST_Server) get_json_last_error() bool {
}

fn (mut this Class_WP_REST_Server) get_index(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Server) add_active_theme_link_to_index(mut var_response Class_WP_REST_Response)  {
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_REST_Server) add_site_logo_to_index(mut var_response Class_WP_REST_Response)  {
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_REST_Server) add_site_icon_to_index(mut var_response Class_WP_REST_Response)  {
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_REST_Server) add_image_to_index(mut var_response Class_WP_REST_Response, var_image_id rt.PhpVal, var_type rt.PhpVal)  {
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_REST_Server) get_namespace_index(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Server) get_data_for_routes(var_routes rt.PhpVal, context string) rt.PhpVal {
	mut var_routes_mutated := var_routes
}

fn (mut this Class_WP_REST_Server) get_data_for_route(var_route rt.PhpVal, var_callbacks rt.PhpVal, context string) rt.PhpVal {
	mut var_route_mutated := var_route
}

fn (mut this Class_WP_REST_Server) get_max_batch_size() rt.PhpVal {
}

fn (mut this Class_WP_REST_Server) serve_batch_request_v1(mut var_batch_request Class_WP_REST_Request) rt.PhpVal {
	mut var_route := rt.new_null()
	mut var_handler := rt.new_null()
}

fn (mut this Class_WP_REST_Server) set_status(var_code rt.PhpVal)  {
	mut var_code_mutated := var_code
}

fn (mut this Class_WP_REST_Server) send_header(var_key rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_REST_Server) send_headers(var_headers rt.PhpVal)  {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_WP_REST_Server) remove_header(var_key rt.PhpVal)  {
}

fn Class_WP_REST_Server.get_raw_data() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_REST_Server) get_headers(var_server rt.PhpVal) rt.PhpVal {
	mut var_server_mutated := var_server
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_server() &Class_WP_REST_Server {
	mut obj := &Class_WP_REST_Server{
		PhpObjectBase: rt.PhpObjectBase{}
		namespaces: rt.new_array()
		endpoints: rt.new_array()
		route_options: rt.new_array()
		embed_cache: rt.new_array()
		dispatching_requests: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_rest_request() &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return this.is_dispatching()
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
			return this.respond_to_request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_json_last_error' {
			return rt.new_bool(this.get_json_last_error())
		}
		'get_index' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_index(dispatch_arg_0)
		}
		'add_active_theme_link_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			this.add_active_theme_link_to_index(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_site_logo_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			this.add_site_logo_to_index(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_site_icon_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			this.add_site_icon_to_index(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_image_to_index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'namespaces' { this.namespaces = val; return true }
		'endpoints' { this.endpoints = val; return true }
		'route_options' { this.route_options = val; return true }
		'embed_cache' { this.embed_cache = val; return true }
		'dispatching_requests' { this.dispatching_requests = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_rest_api_class_wp_rest_server_php() {
}
