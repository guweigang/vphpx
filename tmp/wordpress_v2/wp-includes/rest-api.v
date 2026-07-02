import rt

const global_const_rest_api_version = '2.0'
fn register_rest_route(var_route_namespace rt.PhpVal, var_route rt.PhpVal, var_args_arg rt.PhpVal, override bool) bool {
	mut var_override := override
	mut var_args := var_args_arg
	mut var_clean_namespace := ''
	mut var_common_args := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_arg_group := rt.new_null()
	mut var_key := rt.new_null()
	mut var_arg := rt.new_null()
	mut var_full_route := rt.new_null()
	if !rt.is_true(var_route_namespace) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Routes must be namespaced with plugin or theme name and version. Instead there seems to be an empty namespace \'%1$s\' for route \'%2$s\'.')]), rt.new_string('<code>' + (var_route_namespace).str() + '</code>'), rt.new_string('<code>' + (var_route).str() + '</code>')]), rt.new_string('4.4.0')])
		return false
	} else if !rt.is_true(var_route) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Route must be specified. Instead within the namespace \'%1$s\', there seems to be an empty route \'%2$s\'.')]), rt.new_string('<code>' + (var_route_namespace).str() + '</code>'), rt.new_string('<code>' + (var_route).str() + '</code>')]), rt.new_string('4.4.0')])
		return false
	}
	var_clean_namespace = var_route_namespace.clone().to_string().trim_space()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string((var_clean_namespace).str()), var_route_namespace)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Namespace must not start or end with a slash. Instead namespace \'%1$s\' for route \'%2$s\' seems to contain a slash.')]), rt.new_string('<code>' + (var_route_namespace).str() + '</code>'), rt.new_string('<code>' + (var_route).str() + '</code>')]), rt.new_string('5.4.2')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('rest_api_init')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('REST API routes must be registered on the %1$s action. Instead route \'%2$s\' with namespace \'%3$s\' was not registered on this action.')]), rt.new_string('<code>rest_api_init</code>'), rt.new_string('<code>' + (var_route).str() + '</code>'), rt.new_string('<code>' + (var_route_namespace).str() + '</code>')]), rt.new_string('5.1.0')])
	}
	if var_args.array_isset(rt.new_string('args')) {
		var_common_args = var_args.array_get(rt.new_string('args'))
		var_args.array_unset(rt.new_string('args'))
	} else {
	var_common_args = rt.new_array()
	}
	if var_args.array_isset(rt.new_string('callback')) {
	var_args = rt.create_array([rt.ArrayItem{ key: none, val: var_args }])
	}
	var_defaults = { 'methods': rt.new_string('GET'), 'callback': rt.new_null(), 'args': rt.new_array() }
	mut iter_1 := var_args.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_arg_group_shadow := item_1.val
		mut var_key_shadow := item_1.key
		if !(var_key_shadow.clone().is_long() || var_key_shadow.clone().is_double()) {
			continue
		}
		var_arg_group_shadow = rt.call_function('array_merge', [rt.create_array_from_native_map(var_defaults), var_arg_group_shadow.clone()])
		var_arg_group_shadow.array_set('args', rt.call_function('array_merge', [var_common_args.clone(), var_arg_group_shadow.array_get(rt.new_string('args'))]))
		if !(var_arg_group_shadow.array_isset(rt.new_string('permission_callback'))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The REST API route definition for %1$s is missing the required %2$s argument. For REST API routes that are intended to be public, use %3$s as the permission callback.')]), rt.new_string('<code>' + var_clean_namespace + '/' + var_route.clone().to_string().trim_space() + '</code>'), rt.new_string('<code>permission_callback</code>'), rt.new_string('<code>__return_true</code>')]), rt.new_string('5.5.0')])
		}
		mut iter_2 := var_arg_group_shadow.array_get(rt.new_string('args')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_arg_shadow := item_2.val
			if !(var_arg_shadow.clone().is_array()) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('REST API %1$s should be an array of arrays. Non-array value detected for %2$s.')]), rt.new_string('<code>$args</code>'), rt.new_string('<code>' + var_clean_namespace + '/' + var_route.clone().to_string().trim_space() + '</code>')]), rt.new_string('6.1.0')])
				break
			}
		}
	}
	var_full_route = rt.new_string('/' + var_clean_namespace + '/' + var_route.clone().to_string().trim_space())
	rt.call_method(rest_get_server(), 'register_route', [rt.new_string((var_clean_namespace).str()).clone(), var_full_route.clone(), var_args.clone(), rt.new_bool(override)])
	return true
}

fn register_rest_field(var_object_type_arg rt.PhpVal, var_attribute rt.PhpVal, var_args_arg rt.PhpVal) {
	mut var_object_type := var_object_type_arg
	mut var_args := var_args_arg
	mut var_wp_rest_additional_fields := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_object_types := rt.new_null()
	var_defaults = { 'get_callback': rt.new_null(), 'update_callback': rt.new_null(), 'schema': rt.new_null() }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_object_types = rt.cast_array(var_object_type)
	mut iter_3 := var_object_types.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_object_type_shadow := item_3.val
		var_wp_rest_additional_fields.array_get_mut(var_object_type_shadow).array_set(var_attribute, var_args.clone())
	}
}

fn rest_api_init() {
	mut var_wp := rt.new_null()
	rest_api_register_rewrites()
	rt.call_method(var_wp, 'add_query_var', [rt.new_string('rest_route')])
}

fn rest_api_register_rewrites() {
	mut var_wp_rewrite := rt.new_null()
	rt.call_function('add_rewrite_rule', [rt.new_string('^' + (rest_get_url_prefix()).str() + '/?$'), rt.new_string('index.php?rest_route=/'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^' + (rest_get_url_prefix()).str() + '/(.*)?'), rt.new_string('index.php?rest_route=/$matches[1]'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^' + (rt.get_property(var_wp_rewrite, 'index')).str() + '/' + (rest_get_url_prefix()).str() + '/?$'), rt.new_string('index.php?rest_route=/'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^' + (rt.get_property(var_wp_rewrite, 'index')).str() + '/' + (rest_get_url_prefix()).str() + '/(.*)?'), rt.new_string('index.php?rest_route=/$matches[1]'), rt.new_string('top')])
}

fn rest_api_default_filters() {
	if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('deprecated_function_run'), rt.new_string('rest_handle_deprecated_function'), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_filter', [rt.new_string('deprecated_function_trigger_error'), rt.new_string('__return_false')])
		rt.call_function('add_action', [rt.new_string('deprecated_argument_run'), rt.new_string('rest_handle_deprecated_argument'), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_filter', [rt.new_string('deprecated_argument_trigger_error'), rt.new_string('__return_false')])
		rt.call_function('add_action', [rt.new_string('doing_it_wrong_run'), rt.new_string('rest_handle_doing_it_wrong'), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_filter', [rt.new_string('doing_it_wrong_trigger_error'), rt.new_string('__return_false')])
	}
	rt.call_function('add_filter', [rt.new_string('rest_pre_serve_request'), rt.new_string('rest_send_cors_headers')])
	rt.call_function('add_filter', [rt.new_string('rest_post_dispatch'), rt.new_string('rest_send_allow_header'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('rest_post_dispatch'), rt.new_string('rest_filter_response_fields'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('rest_pre_dispatch'), rt.new_string('rest_handle_options_request'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('rest_index'), rt.new_string('rest_add_application_passwords_to_index')])
}

fn create_initial_rest_routes() {
	mut var_post_type := rt.new_null()
	mut var_controller := rt.new_null()
	mut var_revisions_controller := rt.new_null()
	mut var_autosaves_controller := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_search_handlers := rt.new_null()
	mut var_site_health := rt.new_null()
	mut var_font_collections_controller := rt.new_null()
	mut var_abilities_categories_controller := rt.new_null()
	mut var_abilities_run_controller := rt.new_null()
	mut var_abilities_list_controller := rt.new_null()
	mut var_icons_controller := rt.new_null()
	mut iter_4 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_post_type_shadow := item_4.val
		var_controller = rt.call_method(var_post_type_shadow, 'get_rest_controller', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_controller)))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type_shadow, 'late_route_registration'))))) {
			rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
		}
		var_revisions_controller = rt.call_method(var_post_type_shadow, 'get_revisions_rest_controller', []rt.PhpVal{})
		if rt.is_true(var_revisions_controller) {
			rt.call_method(var_revisions_controller, 'register_routes', []rt.PhpVal{})
		}
		var_autosaves_controller = rt.call_method(var_post_type_shadow, 'get_autosave_rest_controller', []rt.PhpVal{})
		if rt.is_true(var_autosaves_controller) {
			rt.call_method(var_autosaves_controller, 'register_routes', []rt.PhpVal{})
		}
		if rt.is_true(rt.get_property(var_post_type_shadow, 'late_route_registration')) {
			rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
		}
	}
	var_controller = create_wp_rest_post_types_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_post_statuses_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_taxonomies_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	mut iter_5 := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('object')]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_taxonomy_shadow := item_5.val
		var_controller = rt.call_method(var_taxonomy_shadow, 'get_rest_controller', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_controller)))) {
			continue
		}
		rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	}
	var_controller = create_wp_rest_users_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_application_passwords_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_comments_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_search_handlers = rt.create_array([rt.ArrayItem{ key: none, val: create_wp_rest_post_search_handler() }, rt.ArrayItem{ key: none, val: create_wp_rest_term_search_handler() }, rt.ArrayItem{ key: none, val: create_wp_rest_post_format_search_handler() }])
	var_search_handlers = rt.call_function('apply_filters', [rt.new_string('wp_rest_search_handlers'), var_search_handlers.clone()])
	var_controller = create_wp_rest_search_controller(var_search_handlers.clone())
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_block_renderer_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_block_types_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_settings_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_themes_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_plugins_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_sidebars_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_widget_types_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_widgets_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_block_directory_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_pattern_directory_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_block_patterns_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_block_pattern_categories_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	mut iife_temp_0 := Class_WP_Site_Health{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_site_health = iife_result_0
	var_controller = create_wp_rest_site_health_controller(var_site_health.clone())
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_url_details_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_menu_locations_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_edit_site_export_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_navigation_fallback_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_font_collections_controller = create_wp_rest_font_collections_controller()
	var_font_collections_controller.register_routes()
	var_abilities_categories_controller = create_wp_rest_abilities_v1_categories_controller()
	var_abilities_categories_controller.register_routes()
	var_abilities_run_controller = create_wp_rest_abilities_v1_run_controller()
	var_abilities_run_controller.register_routes()
	var_abilities_list_controller = create_wp_rest_abilities_v1_list_controller()
	var_abilities_list_controller.register_routes()
	var_icons_controller = create_wp_rest_icons_controller()
	var_icons_controller.register_routes()
}

fn rest_api_loaded() {
	mut var_GLOBALS := rt.new_null()
	mut var_rest_type_error := rt.new_null()
	mut var_server := rt.new_null()
	mut var_route := rt.new_null()
	if !rt.is_true(rt.get_property(var_GLOBALS.array_get(rt.new_string('wp')), 'query_vars').array_get(rt.new_string('rest_route'))) {
		return
	}
	if !(rt.get_property(var_GLOBALS.array_get(rt.new_string('wp')), 'query_vars').array_get(rt.new_string('rest_route')).is_string()) {
		var_rest_type_error = create_wp_error(rt.new_string('rest_path_invalid_type'), rt.call_function('__', [rt.new_string('The REST route parameter must be a string.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		rt.call_function('wp_die', [var_rest_type_error])
	}
	rt.call_function('define', [rt.new_string('REST_REQUEST'), rt.new_bool(true)])
	var_server = rest_get_server()
	var_route = rt.call_function('untrailingslashit', [rt.get_property(var_GLOBALS.array_get(rt.new_string('wp')), 'query_vars').array_get(rt.new_string('rest_route'))])
	if !rt.is_true(var_route) {
	var_route = rt.new_string('/')
	}
	rt.call_method(var_server, 'serve_request', [var_route.clone()])
	exit(0)
}

fn rest_get_url_prefix() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('rest_url_prefix'), rt.new_string('wp-json')])
}

fn get_rest_url(var_blog_id rt.PhpVal, path string, scheme string) rt.PhpVal {
	mut var_path := path
	mut var_scheme := scheme
	mut var_wp_rewrite := rt.new_null()
	mut var_url := rt.new_null()
	if var_path == '' {
	var_path = '/'
	}
	var_path = '/' + var_path.trim_left(' \t\n\r')
	if (rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('get_blog_option', [var_blog_id.clone(), rt.new_string('permalink_structure')]))) || rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		if rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{})) {
		var_url = rt.call_function('get_home_url', [var_blog_id.clone(), rt.new_string((rt.get_property(var_wp_rewrite, 'index')).str() + '/' + (rest_get_url_prefix()).str()), rt.new_string(scheme)])
		} else {
		var_url = rt.call_function('get_home_url', [var_blog_id.clone(), rest_get_url_prefix(), rt.new_string(scheme)])
		}
		var_url = rt.concat(var_url, rt.new_string((var_path).str()))
	} else {
		var_url = rt.call_function('trailingslashit', [rt.call_function('get_home_url', [var_blog_id.clone(), rt.new_string(''), rt.new_string(scheme)])])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [var_url.clone(), rt.new_string('index.php')]))))) {
			var_url = rt.concat(var_url, rt.new_string('index.php'))
		}
	var_url = rt.call_function('add_query_arg', [rt.new_string('rest_route'), rt.new_string((var_path).str()), var_url.clone()])
	}
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('SERVER_NAME')) {
		if rt.is_true(rt.identical(rt.call_function('parse_url', [rt.call_function('get_home_url', [var_blog_id.clone()]), rt.get_constant('PHP_URL_HOST')]), rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_NAME')))) {
		var_url = rt.call_function('set_url_scheme', [var_url.clone(), rt.new_string('https')])
		}
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(rt.call_function('force_ssl_admin', []rt.PhpVal{})) {
	var_url = rt.call_function('set_url_scheme', [var_url.clone(), rt.new_string('https')])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_url'), var_url.clone(), rt.new_string((var_path).str()), var_blog_id.clone(), rt.new_string(scheme)])
}

fn rest_url(path string, scheme string) rt.PhpVal {
	mut var_path := path
	mut var_scheme := scheme
	return get_rest_url(rt.new_null(), var_path, scheme)
}

fn rest_do_request(var_request_arg rt.PhpVal) rt.PhpVal {
	mut var_request := var_request_arg
	var_request = rest_ensure_request(var_request.clone())
	return rt.call_method(rest_get_server(), 'dispatch', [var_request.clone()])
}

fn rest_get_server() rt.PhpVal {
	mut var_wp_rest_server_class := rt.new_null()
	mut var_wp_rest_server := rt.new_null()
	if !rt.is_true(var_wp_rest_server) {
		var_wp_rest_server_class = rt.call_function('apply_filters', [rt.new_string('wp_rest_server_class'), rt.new_string('WP_REST_Server')])
		var_wp_rest_server = rt.create_object_dynamically(var_wp_rest_server_class, []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('rest_api_init'), var_wp_rest_server.clone()])
	}
	return var_wp_rest_server.clone()
}

fn rest_ensure_request(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_request, 'WP_REST_Request'))) {
		return var_request.clone()
	}
	if rt.is_true(rt.new_bool(var_request.clone().is_string())) {
		return rt.new_object('WP_REST_Request', []string{}, create_wp_rest_request(rt.new_string('GET'), var_request.clone()))
	}
	return rt.new_object('WP_REST_Request', []string{}, create_wp_rest_request(rt.new_string('GET'), rt.new_string(''), var_request.clone()))
}

fn rest_ensure_response(var_response rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_response, 'WP_REST_Response'))) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_response, 'WP_HTTP_Response'))) {
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.call_method(var_response, 'get_data', []rt.PhpVal{}), rt.call_method(var_response, 'get_status', []rt.PhpVal{}), rt.call_method(var_response, 'get_headers', []rt.PhpVal{})))
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone()))
}

fn rest_handle_deprecated_function(var_function_name rt.PhpVal, var_replacement rt.PhpVal, var_version rt.PhpVal) {
	mut var_string := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) || rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return
	}
	if !(!rt.is_true(var_replacement)) {
	var_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s (since %2$s; use %3$s instead)')]), var_function_name.clone(), var_version.clone(), var_replacement.clone()])
	} else {
	var_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s (since %2$s; no alternative available)')]), var_function_name.clone(), var_version.clone()])
	}
	rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('X-WP-DeprecatedFunction: %s'), var_string.clone()])])
}

fn rest_handle_deprecated_argument(var_function_name rt.PhpVal, var_message rt.PhpVal, var_version rt.PhpVal) {
	mut var_string := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) || rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(var_message) {
	var_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s (since %2$s; %3$s)')]), var_function_name.clone(), var_version.clone(), var_message.clone()])
	} else {
	var_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s (since %2$s; no alternative available)')]), var_function_name.clone(), var_version.clone()])
	}
	rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('X-WP-DeprecatedParam: %s'), var_string.clone()])])
}

fn rest_handle_doing_it_wrong(var_function_name rt.PhpVal, var_message rt.PhpVal, var_version rt.PhpVal) {
	mut var_string := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) || rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(var_version) {
	var_string = rt.call_function('__', [rt.new_string('%1$s (since %2$s; %3$s)')])
	var_string = rt.call_function('sprintf', [var_string.clone(), var_function_name.clone(), var_version.clone(), var_message.clone()])
	} else {
	var_string = rt.call_function('__', [rt.new_string('%1$s (%2$s)')])
	var_string = rt.call_function('sprintf', [var_string.clone(), var_function_name.clone(), var_message.clone()])
	}
	rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('X-WP-DoingItWrong: %s'), var_string.clone()])])
}

fn rest_send_cors_headers(var_value rt.PhpVal) rt.PhpVal {
	mut var_origin := rt.new_null()
	var_origin = rt.call_function('get_http_origin', []rt.PhpVal{})
	if rt.is_true(var_origin) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('null'), var_origin)))) {
		var_origin = rt.call_function('sanitize_url', [var_origin.clone()])
		}
		rt.call_function('header', [rt.new_string('Access-Control-Allow-Origin: ' + (var_origin).str())])
		rt.call_function('header', [rt.new_string('Access-Control-Allow-Methods: OPTIONS, GET, POST, PUT, PATCH, DELETE')])
		rt.call_function('header', [rt.new_string('Access-Control-Allow-Credentials: true')])
		rt.call_function('header', [rt.new_string('Vary: Origin'), rt.new_bool(false)])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) && rt.is_true(rt.identical(rt.new_string('GET'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.new_string('Vary: Origin'), rt.new_bool(false)])
	}
	return var_value.clone()
}

fn rest_handle_options_request(var_response_arg rt.PhpVal, var_handler rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response := var_response_arg
	mut var_matches := rt.new_null()
	mut var_data := rt.new_null()
	mut var_endpoints := rt.new_null()
	mut var_route := rt.new_null()
	mut var_match := rt.new_null()
	mut var_args := rt.new_null()
	mut var_value := rt.new_null()
	mut var_param := rt.new_null()
	mut var_endpoint := rt.new_null()
	if !(!rt.is_true(var_response)) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_request, 'get_method', []rt.PhpVal{}), rt.new_string('OPTIONS'))))) {
		return var_response.clone()
	}
	var_response = create_wp_rest_response()
	var_data = rt.new_array()
	mut iter_6 := rt.call_method(var_handler, 'get_routes', []rt.PhpVal{}).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_endpoints_shadow := item_6.val
		mut var_route_shadow := item_6.key
		var_match = rt.call_function('preg_match', [rt.new_string('@^' + (var_route_shadow).str() + '$@i'), rt.call_method(var_request, 'get_route', []rt.PhpVal{}), var_matches.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_match)))) {
			continue
		}
		var_args = rt.new_array()
		mut iter_7 := var_matches.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_value_shadow := item_7.val
			mut var_param_shadow := item_7.key
			if !(var_param_shadow.clone().is_long()) {
				var_args.array_set(var_param_shadow, var_value_shadow.clone())
			}
		}
		mut iter_8 := var_endpoints_shadow.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_endpoint_shadow := item_8.val
			rt.call_method(var_request, 'set_url_params', [var_args.clone()])
			rt.call_method(var_request, 'set_attributes', [var_endpoint_shadow.clone()])
		}
		var_data = rt.call_method(var_handler, 'get_data_for_route', [var_route_shadow.clone(), var_endpoints_shadow.clone(), rt.new_string('help')])
		rt.call_method(var_response, 'set_matched_route', [var_route_shadow.clone()])
		break
	}
	rt.call_method(var_response, 'set_data', [var_data.clone()])
	return var_response.clone()
}

fn rest_send_allow_header(var_response rt.PhpVal, var_server rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_matched_route := rt.new_null()
	mut var_routes := rt.new_null()
	mut var_allowed_methods := rt.new_null()
	mut var__handler := map[string]rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_handler_method := rt.new_null()
	mut var_permission := rt.new_null()
	var_matched_route = rt.call_method(var_response, 'get_matched_route', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_matched_route)))) {
		return var_response.clone()
	}
	var_routes = rt.call_method(var_server, 'get_routes', []rt.PhpVal{})
	var_allowed_methods = rt.new_array()
	mut iter_9 := var_routes.array_get(var_matched_route).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var__handler_shadow := item_9.val
		mut iter_10 := var__handler_shadow['methods'].iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_value_shadow := item_10.val
			mut var_handler_method_shadow := item_10.key
			if !(!rt.is_true(var__handler_shadow['permission_callback'])) {
				var_permission = rt.call_function('call_user_func', [var__handler_shadow['permission_callback'], var_request.clone()])
				var_allowed_methods.array_set(var_handler_method_shadow, rt.identical(rt.new_bool(true), var_permission))
			} else {
				var_allowed_methods.array_set(var_handler_method_shadow, true)
			}
		}
	}
	var_allowed_methods = rt.call_function('array_filter', [var_allowed_methods.clone()])
	if rt.is_true(var_allowed_methods) {
		rt.call_method(var_response, 'header', [rt.new_string('Allow'), rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.new_string('strtoupper'), rt.func_array_keys(var_allowed_methods.clone())])])])
	}
	return var_response.clone()
}

fn _rest_array_intersect_key_recursive(var_array1_arg rt.PhpVal, var_array2 rt.PhpVal) rt.PhpVal {
	mut var_array1 := var_array1_arg
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	var_array1 = rt.call_function('array_intersect_key', [var_array1.clone(), var_array2.clone()])
	mut iter_11 := var_array1.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_value_shadow := item_11.val
		mut var_key_shadow := item_11.key
		if var_value_shadow.clone().is_array() && var_array2.array_get(var_key_shadow).is_array() {
			var_array1.array_set(var_key_shadow, _rest_array_intersect_key_recursive(var_value_shadow.clone(), var_array2.array_get(var_key_shadow)))
		}
	}
	return var_array1.clone()
}

fn rest_filter_response_fields(var_response rt.PhpVal, var_server rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_ref := rt.new_null()
	mut var_data := rt.new_null()
	mut var_fields := rt.new_null()
	mut var_fields_as_keyed := rt.new_null()
	mut var_field := rt.new_null()
	mut var_parts := rt.new_null()
	mut var_next := rt.new_null()
	mut var_last := rt.new_null()
	mut var_new_data := rt.new_null()
	mut var_item := rt.new_null()
	if !(var_request.array_isset(rt.new_string('_fields'))) || rt.is_true(rt.call_method(var_response, 'is_error', []rt.PhpVal{})) {
		return var_response.clone()
	}
	var_data = rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	var_fields = rt.call_function('wp_parse_list', [var_request.array_get(rt.new_string('_fields'))])
	if 0 == var_fields.clone().array_count() {
		return var_response.clone()
	}
	var_fields = rt.call_function('array_map', [rt.new_string('trim'), var_fields.clone()])
	var_fields_as_keyed = rt.new_array()
	mut iter_12 := var_fields.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_field_shadow := item_12.val
		var_parts = rt.call_function('explode', [rt.new_string('.'), var_field_shadow.clone()])
		var_ref = var_fields_as_keyed
		for var_parts.clone().array_count() > 1 {
			var_next = rt.call_function('array_shift', [var_parts.clone()])
			if var_ref.array_isset(var_next) && rt.is_true(rt.identical(rt.new_bool(true), var_ref.array_get(var_next))) {
				break
			}
			var_ref.array_set(var_next, if !(var_ref.array_get(var_next)).is_null() { var_ref.array_get(var_next) } else { rt.new_array() })
			var_ref = var_ref.array_get(var_next)
		}
		var_last = rt.call_function('array_shift', [var_parts.clone()])
		var_ref.array_set(var_last, true)
	}
	if rt.is_true(rt.call_function('wp_is_numeric_array', [var_data.clone()])) {
		var_new_data = rt.new_array()
		mut iter_13 := var_data.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_item_shadow := item_13.val
			var_new_data.array_push(_rest_array_intersect_key_recursive(var_item_shadow.clone(), var_fields_as_keyed.clone()))
		}
	} else {
	var_new_data = _rest_array_intersect_key_recursive(var_data.clone(), var_fields_as_keyed.clone())
	}
	rt.call_method(var_response, 'set_data', [var_new_data.clone()])
	return var_response.clone()
}

fn rest_is_field_included(var_field rt.PhpVal, var_fields rt.PhpVal) bool {
	mut var_accepted_field := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [var_field.clone(), var_fields.clone(), rt.new_bool(true)])) {
		return true
	}
	mut iter_14 := var_fields.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_accepted_field_shadow := item_14.val
		if rt.is_true(rt.call_function('str_starts_with', [var_accepted_field_shadow.clone(), rt.new_string("${var_field.to_string()}.")])) {
			return true
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_field.clone(), rt.new_string("${var_accepted_field.to_string()}.")])) {
			return true
		}
	}
	return false
}

fn rest_output_rsd() {
	mut var_api_root := rt.new_null()
	var_api_root = get_rest_url(rt.new_null(), '', '')
	if !rt.is_true(var_api_root) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_api_root.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn rest_output_link_wp_head() {
	mut var_api_root := rt.new_null()
	mut var_resource := rt.new_null()
	var_api_root = get_rest_url(rt.new_null(), '', '')
	if !rt.is_true(var_api_root) {
		return
	}
	rt.call_function('printf', [rt.new_string('<link rel="https://api.w.org/" href="%s" />'), rt.call_function('esc_url', [var_api_root.clone()])])
	var_resource = rest_get_queried_resource_route()
	if rt.is_true(var_resource) {
		rt.call_function('printf', [rt.new_string('<link rel="alternate" title="%1$s" type="application/json" href="%2$s" />'), rt.call_function('_x', [rt.new_string('JSON'), rt.new_string('REST API resource link name')]), rt.call_function('esc_url', [rest_url(var_resource.clone(), '')])])
	}
}

fn rest_output_link_header() {
	mut var_api_root := rt.new_null()
	mut var_resource := rt.new_null()
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return
	}
	var_api_root = get_rest_url(rt.new_null(), '', '')
	if !rt.is_true(var_api_root) {
		return
	}
	rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('Link: <%s>; rel="https://api.w.org/"'), rt.call_function('sanitize_url', [var_api_root.clone()])]), rt.new_bool(false)])
	var_resource = rest_get_queried_resource_route()
	if rt.is_true(var_resource) {
		rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('Link: <%1$s>; rel="alternate"; title="%2$s"; type="application/json"'), rt.call_function('sanitize_url', [rest_url(var_resource.clone(), '')]), rt.call_function('_x', [rt.new_string('JSON'), rt.new_string('REST API resource link name')])]), rt.new_bool(false)])
	}
}

fn rest_cookie_check_errors(var_result_arg rt.PhpVal) bool {
	mut var_result := var_result_arg
	mut var_wp_rest_auth_cookie := rt.new_null()
	mut var_nonce := rt.new_null()
	if !(!rt.is_true(var_result)) {
		return (var_result).to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_wp_rest_auth_cookie)))) && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		return (var_result).to_bool()
	}
	var_nonce = rt.new_null()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce')) {
	var_nonce = rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_WP_NONCE')) {
	var_nonce = rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_WP_NONCE'))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_nonce)) {
		rt.call_function('wp_set_current_user', [rt.new_int(0)])
		return true
	}
	var_result = rt.call_function('wp_verify_nonce', [var_nonce.clone(), rt.new_string('wp_rest')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.call_function('add_filter', [rt.new_string('rest_send_nocache_headers'), rt.new_string('__return_true'), rt.new_int(20)])
		return (create_wp_error(rt.new_string('rest_cookie_invalid_nonce'), rt.call_function('__', [rt.new_string('Cookie check failed')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	rt.call_method(rest_get_server(), 'send_header', [rt.new_string('X-WP-Nonce'), rt.call_function('wp_create_nonce', [rt.new_string('wp_rest')])])
	return true
}

fn rest_cookie_collect_status() {
	mut var_status_type := rt.new_null()
	mut var_wp_rest_auth_cookie := rt.new_null()
	var_status_type = rt.call_function('current_action', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auth_cookie_valid'), var_status_type)))) {
		var_wp_rest_auth_cookie = rt.call_function('substr', [var_status_type.clone(), rt.new_int(12)])
		return
	}
var_wp_rest_auth_cookie = rt.new_bool(true)
}

fn rest_application_password_collect_status(var_user_or_error rt.PhpVal, var_app_password rt.PhpVal) {
	mut var_wp_rest_application_password_status := rt.new_null()
	mut var_wp_rest_application_password_uuid := rt.new_null()
	var_wp_rest_application_password_status = var_user_or_error
	if !rt.is_true(var_app_password.array_get(rt.new_string('uuid'))) {
	var_wp_rest_application_password_uuid = rt.new_null()
	} else {
	var_wp_rest_application_password_uuid = var_app_password.array_get(rt.new_string('uuid'))
	}
}

fn rest_get_authenticated_app_password() rt.PhpVal {
	mut var_wp_rest_application_password_uuid := rt.new_null()
	return var_wp_rest_application_password_uuid.clone()
}

fn rest_application_password_check_errors(var_result rt.PhpVal) bool {
	mut var_wp_rest_application_password_status := rt.new_null()
	mut var_data := rt.new_null()
	if !(!rt.is_true(var_result)) {
		return (var_result).to_bool()
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_wp_rest_application_password_status.clone()])) {
		var_data = rt.call_method(var_wp_rest_application_password_status, 'get_error_data', []rt.PhpVal{})
		if !(var_data.array_isset(rt.new_string('status'))) {
			var_data.array_set('status', 401)
		}
		rt.call_method(var_wp_rest_application_password_status, 'add_data', [var_data.clone()])
		return (var_wp_rest_application_password_status).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_rest_application_password_status, 'WP_User'))) {
		return true
	}
	return (var_result).to_bool()
}

fn rest_add_application_passwords_to_index(var_response rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_application_passwords_available', []rt.PhpVal{}))))) {
		return var_response.clone()
	}
	rt.get_property(var_response, 'data').array_get_mut('authentication').array_set('application-passwords', rt.create_array([rt.ArrayItem{ key: 'endpoints', val: rt.create_array([rt.ArrayItem{ key: 'authorization', val: rt.call_function('admin_url', [rt.new_string('authorize-application.php')]) }]) }]))
	return var_response.clone()
}

fn rest_get_avatar_urls(var_id_or_email rt.PhpVal) rt.PhpVal {
	mut var_avatar_sizes := rt.new_null()
	mut var_urls := rt.new_null()
	mut var_size := rt.new_null()
	var_avatar_sizes = rest_get_avatar_sizes()
	var_urls = rt.new_array()
	mut iter_15 := var_avatar_sizes.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_size_shadow := item_15.val
		var_urls.array_set(var_size_shadow, rt.call_function('get_avatar_url', [var_id_or_email.clone(), rt.create_array([rt.ArrayItem{ key: 'size', val: var_size_shadow }])]))
	}
	return var_urls.clone()
}

fn rest_get_avatar_sizes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('rest_avatar_sizes'), rt.create_array([rt.ArrayItem{ key: none, val: 24 }, rt.ArrayItem{ key: none, val: 48 }, rt.ArrayItem{ key: none, val: 96 }])])
}

fn rest_parse_date(var_date_arg rt.PhpVal, force_utc bool) bool {
	mut var_force_utc := force_utc
	mut var_date := var_date_arg
	mut var_matches := rt.new_null()
	mut var_regex := ''
	if var_force_utc {
	var_date = rt.call_function('preg_replace', [rt.new_string('/[+-]\\d+:?\\d+$/'), rt.new_string('+00:00'), var_date.clone()])
	}
	var_regex = '#^\\d{4}-\\d{2}-\\d{2}[Tt ]\\d{2}:\\d{2}:\\d{2}(?:\\.\\d+)?(?:Z|[+-]\\d{2}(?::\\d{2})?)?$#'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string((var_regex).str()).clone(), var_date.clone(), var_matches.clone()]))))) {
		return false
	}
	return (rt.call_function('strtotime', [var_date.clone()])).to_bool()
}

fn rest_parse_hex_color(var_color rt.PhpVal) bool {
	mut var_matches := rt.new_null()
	mut var_regex := ''
	var_regex = '|^#([A-Fa-f0-9]{3}){1,2}$|'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string((var_regex).str()).clone(), var_color.clone(), var_matches.clone()]))))) {
		return false
	}
	return (var_color).to_bool()
}

fn rest_get_date_with_gmt(var_date_arg rt.PhpVal, is_utc bool) rt.PhpVal {
	mut var_is_utc := is_utc
	mut var_date := var_date_arg
	mut var_has_timezone := rt.new_null()
	mut var_local := rt.new_null()
	mut var_utc := rt.new_null()
	var_has_timezone = rt.call_function('preg_match', [rt.new_string('#(Z|[+-]\\d{2}(:\\d{2})?)$#'), rt.new_bool(var_date).clone()])
	var_date = rest_parse_date(var_date)
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_date))) {
		return rt.new_null()
	}
	if !(var_is_utc) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_timezone)))) {
	var_local = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.new_bool(var_date).clone()])
	var_utc = rt.call_function('get_gmt_from_date', [var_local.clone()])
	} else {
	var_utc = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.new_bool(var_date).clone()])
	var_local = rt.call_function('get_date_from_gmt', [var_utc.clone()])
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_local }, rt.ArrayItem{ key: none, val: var_utc }])
}

fn rest_authorization_required_code() i64 {
	return if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) { 403 } else { 401 }
}

fn rest_validate_request_arg(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_attributes := rt.new_null()
	mut var_args := rt.new_null()
	var_attributes = rt.call_method(var_request, 'get_attributes', []rt.PhpVal{})
	if !(var_attributes.array_get(rt.new_string('args')).array_isset(var_param)) || !(var_attributes.array_get(rt.new_string('args')).array_get(var_param).is_array()) {
		return true
	}
	var_args = var_attributes.array_get(rt.new_string('args')).array_get(var_param)
	return rest_validate_value_from_schema(var_value.clone(), var_args.clone(), var_param.clone())
}

fn rest_sanitize_request_arg(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.new_null()
	mut var_args := rt.new_null()
	var_attributes = rt.call_method(var_request, 'get_attributes', []rt.PhpVal{})
	if !(var_attributes.array_get(rt.new_string('args')).array_isset(var_param)) || !(var_attributes.array_get(rt.new_string('args')).array_get(var_param).is_array()) {
		return var_value.clone()
	}
	var_args = var_attributes.array_get(rt.new_string('args')).array_get(var_param)
	return rest_sanitize_value_from_schema(var_value.clone(), var_args.clone(), var_param.clone())
}

fn rest_parse_request_arg(var_value_arg rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_value := var_value_arg
	mut var_is_valid := false
	var_is_valid = rest_validate_request_arg(var_value.clone(), var_request.clone(), var_param.clone())
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_is_valid).clone()])) {
		return var_is_valid
	}
	var_value = rest_sanitize_request_arg(var_value.clone(), var_request.clone(), var_param.clone())
	return (var_value).to_bool()
}

fn rest_is_ip_address(var_ip rt.PhpVal) bool {
	mut var_ipv4_pattern := ''
	var_ipv4_pattern = '/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/'
	mut iife_temp_1 := Class_WpOrg_Requests_Ipv6{}
	mut iife_result_1 := iife_temp_1.check_ipv6(var_ip.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string((var_ipv4_pattern).str()).clone(), var_ip.clone()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return false
	}
	return (var_ip).to_bool()
}

fn rest_sanitize_boolean(var_value_arg rt.PhpVal) bool {
	mut var_value := var_value_arg
	if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
		var_value = rt.new_string(var_value.clone().to_string().to_lower())
		if rt.is_true(rt.call_function('in_array', [var_value.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'false' }, rt.ArrayItem{ key: none, val: '0' }]), rt.new_bool(true)])) {
		var_value = rt.new_bool(false)
		}
	}
	return (var_value).to_bool()
}

fn rest_is_boolean(var_maybe_bool_arg rt.PhpVal) bool {
	mut var_maybe_bool := var_maybe_bool_arg
	mut var_valid_boolean_values := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.new_string((var_maybe_bool).str()).clone().is_bool())) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.new_string((var_maybe_bool).str()).clone().is_string())) {
		var_maybe_bool = var_maybe_bool.to_lower()
		var_valid_boolean_values = ['false', 'true', '0', '1']
		return (rt.call_function('in_array', [rt.new_string((var_maybe_bool).str()).clone(), rt.create_array_from_list(var_valid_boolean_values), rt.new_bool(true)])).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.new_string((var_maybe_bool).str()).clone().is_long())) {
		return (rt.call_function('in_array', [rt.new_string((var_maybe_bool).str()).clone(), rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 1 }]), rt.new_bool(true)])).to_bool()
	}
	return false
}

fn rest_is_integer(var_maybe_integer rt.PhpVal) bool {
	return var_maybe_integer.clone().is_long() || var_maybe_integer.clone().is_double() && rt.is_true(rt.identical(rt.call_function('round', [rt.new_float((var_maybe_integer).to_f64())]), rt.new_float((var_maybe_integer).to_f64())))
}

fn rest_is_array(var_maybe_array_arg rt.PhpVal) rt.PhpVal {
	mut var_maybe_array := var_maybe_array_arg
	if rt.is_true(rt.call_function('is_scalar', [var_maybe_array.clone()])) {
	var_maybe_array = rt.call_function('wp_parse_list', [var_maybe_array.clone()])
	}
	return rt.call_function('wp_is_numeric_array', [var_maybe_array.clone()])
}

fn rest_sanitize_array(var_maybe_array rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_scalar', [var_maybe_array.clone()])) {
		return rt.call_function('wp_parse_list', [var_maybe_array.clone()])
	}
	if !(var_maybe_array.clone().is_array()) {
		return rt.new_array()
	}
	return rt.call_function('array_values', [var_maybe_array.clone()])
}

fn rest_is_object(var_maybe_object_arg rt.PhpVal) bool {
	mut var_maybe_object := var_maybe_object_arg
	if rt.is_true(rt.identical(rt.new_string(''), var_maybe_object)) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_maybe_object, 'stdClass'))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_maybe_object, 'JsonSerializable'))) {
	var_maybe_object = rt.call_method(var_maybe_object, 'jsonSerialize', []rt.PhpVal{})
	}
	return var_maybe_object.clone().is_array()
}

fn rest_sanitize_object(var_maybe_object_arg rt.PhpVal) rt.PhpVal {
	mut var_maybe_object := var_maybe_object_arg
	if rt.is_true(rt.identical(rt.new_string(''), var_maybe_object)) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_maybe_object, 'stdClass'))) {
		return rt.cast_array(var_maybe_object)
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_maybe_object, 'JsonSerializable'))) {
	var_maybe_object = rt.call_method(var_maybe_object, 'jsonSerialize', []rt.PhpVal{})
	}
	if !(var_maybe_object.clone().is_array()) {
		return rt.new_array()
	}
	return var_maybe_object.clone()
}

fn rest_get_best_type_for_value(var_value rt.PhpVal, var_types rt.PhpVal) string {
	mut var_checks := rt.new_null()
	mut var_type := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string(''), var_value)) && rt.is_true(rt.call_function('in_array', [rt.new_string('string'), var_types.clone(), rt.new_bool(true)])) {
		return 'string'
	}
	mut iter_16 := var_types.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_type_shadow := item_16.val
		if var_checks.array_isset(var_type_shadow) && rt.is_true(rt.call_callable(var_checks.array_get(var_type_shadow), [var_value.clone()])) {
			return (var_type_shadow).str()
		}
	}
	return ''
}

fn rest_handle_multi_type_schema(var_value rt.PhpVal, var_args rt.PhpVal, param string) string {
	mut var_param := param
	mut var_allowed_types := []rt.PhpVal{}
	mut var_invalid_types := rt.new_null()
	mut var_best_type := rt.new_null()
	var_allowed_types = ['array', 'object', 'string', 'number', 'integer', 'boolean', 'null']
	var_invalid_types = rt.call_function('array_diff', [var_args.array_get(rt.new_string('type')), rt.create_array_from_list(var_allowed_types)])
	if rt.is_true(var_invalid_types) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('wp_sprintf', [rt.call_function('__', [rt.new_string('The "type" schema keyword for %1$s can only contain the built-in types: %2$l.')]), rt.new_string(param), rt.create_array_from_list(var_allowed_types)]), rt.new_string('5.5.0')])
	}
	var_best_type = rt.new_string(rest_get_best_type_for_value(var_value.clone(), var_args.array_get(rt.new_string('type'))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_best_type)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_invalid_types)))) {
			return ''
		}
	var_best_type = rt.call_function('reset', [var_invalid_types.clone()])
	}
	return (var_best_type).str()
}

fn rest_validate_array_contains_unique_items(var_input_array rt.PhpVal) bool {
	mut var_seen := rt.new_null()
	mut var_item := rt.new_null()
	mut var_stabilized := rt.new_null()
	mut var_key := rt.new_null()
	var_seen = rt.new_array()
	mut iter_17 := var_input_array.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_item_shadow := item_17.val
		var_stabilized = rest_stabilize_value(var_item_shadow.clone())
		var_key = rt.call_function('serialize', [var_stabilized.clone()])
		if !(var_seen.array_isset(var_key)) {
			var_seen.array_set(var_key, true)
			continue
		}
		return false
	}
	return true
}

fn rest_stabilize_value(var_value rt.PhpVal) rt.PhpVal {
	mut var_v := rt.new_null()
	mut var_k := rt.new_null()
	if rt.is_true(rt.call_function('is_scalar', [var_value.clone()])) || var_value.clone().is_null() {
		return var_value.clone()
	}
	if rt.is_true(rt.new_bool(var_value.clone().is_object())) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Cannot stabilize objects. Convert the object to an array first.')]), rt.new_string('5.5.0')])
		return var_value.clone()
	}
	rt.call_function('ksort', [var_value.clone()])
	mut iter_18 := var_value.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_v_shadow := item_18.val
		mut var_k_shadow := item_18.key
		var_value.array_set(var_k_shadow, rest_stabilize_value(var_v_shadow.clone()))
	}
	return var_value.clone()
}

fn rest_validate_json_schema_pattern(var_pattern rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_escaped_pattern := rt.new_null()
	var_escaped_pattern = rt.call_function('str_replace', [rt.new_string('#'), rt.new_string('\\#'), var_pattern.clone()])
	return rt.identical(rt.new_int(1), rt.call_function('preg_match', [rt.new_string('#' + (var_escaped_pattern).str() + '#u'), var_value.clone()]))
}

fn rest_find_matching_pattern_property_schema(var_property rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_child_schema := rt.new_null()
	mut var_pattern := rt.new_null()
	if var_args.array_isset(rt.new_string('patternProperties')) {
		mut iter_19 := var_args.array_get(rt.new_string('patternProperties')).iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_child_schema_shadow := item_19.val
			mut var_pattern_shadow := item_19.key
			if rt.is_true(rest_validate_json_schema_pattern(var_pattern_shadow.clone(), rt.create_array_from_native_map(var_property))) {
				return var_child_schema_shadow.clone()
			}
		}
	}
	return rt.new_null()
}

fn rest_format_combining_operation_error(var_param rt.PhpVal, var_error rt.PhpVal) rt.PhpVal {
	mut var_position := rt.new_null()
	mut var_reason := rt.new_null()
	mut var_title := rt.new_null()
	var_position = var_error.array_get(rt.new_string('index'))
	var_reason = rt.call_method(var_error.array_get(rt.new_string('error_object')), 'get_error_message', []rt.PhpVal{})
	if var_error.array_get(rt.new_string('schema')).array_isset(rt.new_string('title')) {
		var_title = var_error.array_get(rt.new_string('schema')).array_get(rt.new_string('title'))
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_no_matching_schema'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not a valid %2$s. Reason: %3$s')]), var_param.clone(), var_title.clone(), var_reason.clone()]), rt.create_array([rt.ArrayItem{ key: 'position', val: var_position }])))
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_no_matching_schema'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s does not match the expected format. Reason: %2$s')]), var_param.clone(), var_reason.clone()]), rt.create_array([rt.ArrayItem{ key: 'position', val: var_position }])))
}

fn rest_get_combining_operation_error(var_value rt.PhpVal, var_param rt.PhpVal, var_errors rt.PhpVal) rt.PhpVal {
	mut var_filtered_errors := []rt.PhpVal{}
	mut var_error := map[string]rt.PhpVal{}
	mut var_error_code := rt.new_null()
	mut var_error_data := rt.new_null()
	mut var_result := rt.new_null()
	mut var_number := i64(0)
	mut var_n := i64(0)
	mut var_schema_titles := []rt.PhpVal{}
	if 1 == var_errors.len {
		return rest_format_combining_operation_error(var_param.clone(), var_errors.array_get(rt.new_int(0)))
	}
	var_filtered_errors = rt.new_array()
	for var_error_shadow in var_errors {
		var_error_code = rt.call_method(var_error_shadow['error_object'], 'get_error_code', []rt.PhpVal{})
		var_error_data = rt.call_method(var_error_shadow['error_object'], 'get_error_data', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('rest_invalid_type'), var_error_code)))) || (var_error_data.array_isset(rt.new_string('param')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_param, var_error_data.array_get(rt.new_string('param'))))))) {
			var_filtered_errors << var_error_shadow.clone()
		}
	}
	if 1 == var_filtered_errors.len {
		return rest_format_combining_operation_error(var_param.clone(), var_filtered_errors[0])
	}
	if var_filtered_errors.len > 1 && rt.is_true(rt.identical(rt.new_string('object'), var_filtered_errors[0].array_get(rt.new_string('schema')).array_get(rt.new_string('type')))) {
		var_result = rt.new_null()
		var_number = 0
		for var_error_shadow in var_filtered_errors {
			if var_error_shadow['schema'].array_isset(rt.new_string('properties')) {
				var_n = rt.call_function('array_intersect_key', [var_error_shadow['schema'].array_get(rt.new_string('properties')), var_value.clone()]).array_count()
				if var_n > var_number {
				var_result = var_error_shadow
				var_number = var_n
				}
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) {
			return rest_format_combining_operation_error(var_param.clone(), var_result.clone())
		}
	}
	var_schema_titles = rt.new_array()
	for var_error_shadow in var_errors {
		if var_error_shadow['schema'].array_isset(rt.new_string('title')) {
			var_schema_titles << var_error_shadow['schema'].array_get(rt.new_string('title'))
		}
	}
	if var_schema_titles.len == var_errors.len {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_no_matching_schema'), rt.call_function('wp_sprintf', [rt.call_function('__', [rt.new_string('%1$s is not a valid %2$l.')]), var_param.clone(), rt.create_array_from_list(var_schema_titles)])))
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_no_matching_schema'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s does not match any of the expected formats.')]), var_param.clone()])))
}

fn rest_find_any_matching_schema(var_value rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_errors := []rt.PhpVal{}
	mut var_schema := map[string]rt.PhpVal{}
	mut var_index := rt.new_null()
	mut var_is_valid := rt.new_null()
	var_errors = rt.new_array()
	mut iter_20 := var_args.array_get(rt.new_string('anyOf')).iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_schema_shadow := item_20.val
		mut var_index_shadow := item_20.key
		if !(var_schema_shadow.array_isset(rt.new_string('type'))) && var_args.array_isset(rt.new_string('type')) {
			var_schema_shadow['type'] = var_args.array_get(rt.new_string('type'))
		}
		var_is_valid = rt.new_bool(rest_validate_value_from_schema(var_value.clone(), var_schema_shadow.clone(), var_param.clone()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_is_valid.clone()]))))) {
			return var_schema_shadow.clone()
		}
		var_errors << rt.create_array([rt.ArrayItem{ key: 'error_object', val: var_is_valid }, rt.ArrayItem{ key: 'schema', val: var_schema_shadow }, rt.ArrayItem{ key: 'index', val: var_index_shadow }])
	}
	return rest_get_combining_operation_error(var_value.clone(), var_param.clone(), rt.create_array_from_list(var_errors))
}

fn rest_find_one_matching_schema(var_value rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal, stop_after_first_match bool) rt.PhpVal {
	mut var_stop_after_first_match := stop_after_first_match
	mut var_matching_schemas := []rt.PhpVal{}
	mut var_errors := []rt.PhpVal{}
	mut var_schema := map[string]rt.PhpVal{}
	mut var_index := rt.new_null()
	mut var_is_valid := rt.new_null()
	mut var_schema_positions := []rt.PhpVal{}
	mut var_schema_titles := []rt.PhpVal{}
	var_matching_schemas = rt.new_array()
	var_errors = rt.new_array()
	mut iter_21 := var_args.array_get(rt.new_string('oneOf')).iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_schema_shadow := item_21.val
		mut var_index_shadow := item_21.key
		if !(var_schema_shadow.array_isset(rt.new_string('type'))) && var_args.array_isset(rt.new_string('type')) {
			var_schema_shadow['type'] = var_args.array_get(rt.new_string('type'))
		}
		var_is_valid = rt.new_bool(rest_validate_value_from_schema(var_value.clone(), var_schema_shadow.clone(), var_param.clone()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_is_valid.clone()]))))) {
			if var_stop_after_first_match {
				return var_schema_shadow.clone()
			}
			var_matching_schemas << rt.create_array([rt.ArrayItem{ key: 'schema_object', val: var_schema_shadow }, rt.ArrayItem{ key: 'index', val: var_index_shadow }])
		} else {
			var_errors << rt.create_array([rt.ArrayItem{ key: 'error_object', val: var_is_valid }, rt.ArrayItem{ key: 'schema', val: var_schema_shadow }, rt.ArrayItem{ key: 'index', val: var_index_shadow }])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_matching_schemas)))) {
		return rest_get_combining_operation_error(var_value.clone(), var_param.clone(), rt.create_array_from_list(var_errors))
	}
	if var_matching_schemas.len > 1 {
		var_schema_positions = rt.new_array()
		var_schema_titles = rt.new_array()
		for var_schema_shadow in var_matching_schemas {
			var_schema_positions << var_schema_shadow['index']
			if var_schema_shadow['schema_object'].array_isset(rt.new_string('title')) {
				var_schema_titles << var_schema_shadow['schema_object'].array_get(rt.new_string('title'))
			}
		}
		if var_schema_titles.len == var_matching_schemas.len {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_one_of_multiple_matches'), rt.call_function('wp_sprintf', [rt.call_function('__', [rt.new_string('%1$s matches %2$l, but should match only one.')]), var_param.clone(), rt.create_array_from_list(var_schema_titles)]), rt.create_array([rt.ArrayItem{ key: 'positions', val: var_schema_positions }])))
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_one_of_multiple_matches'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s matches more than one of the expected formats.')]), var_param.clone()]), rt.create_array([rt.ArrayItem{ key: 'positions', val: var_schema_positions }])))
	}
	return var_matching_schemas[0].array_get(rt.new_string('schema_object'))
}

fn rest_are_values_equal(var_value1 rt.PhpVal, var_value2 rt.PhpVal) bool {
	mut var_value := rt.new_null()
	mut var_index := rt.new_null()
	if var_value1.clone().is_array() && var_value2.clone().is_array() {
		if rt.is_true(rt.new_bool(var_value1.clone().array_count() != var_value2.clone().array_count())) {
			return false
		}
		mut iter_22 := var_value1.iterator()
		for {
			item_22 := iter_22.next() or { break }
			mut var_value_shadow := item_22.val
			mut var_index_shadow := item_22.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value2.clone().array_isset(var_index_shadow.clone())))))) || !(rest_are_values_equal(var_value_shadow.clone(), var_value2.array_get(var_index_shadow))) {
				return false
			}
		}
		return true
	}
	if (var_value1.clone().is_long() && var_value2.clone().is_double()) || (var_value1.clone().is_double() && var_value2.clone().is_long()) {
		return rt.new_bool(rt.new_float((var_value1).to_f64()) == rt.new_float((var_value2).to_f64()))
	}
	return (rt.identical(var_value1, var_value2)).to_bool()
}

fn rest_validate_enum(var_value rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_sanitized_value := rt.new_null()
	mut var_enum_value := rt.new_null()
	mut var_encoded_enum_values := []rt.PhpVal{}
	var_sanitized_value = rest_sanitize_value_from_schema(var_value.clone(), var_args.clone(), var_param.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_sanitized_value.clone()])) {
		return (var_sanitized_value).to_bool()
	}
	mut iter_23 := var_args.array_get(rt.new_string('enum')).iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_enum_value_shadow := item_23.val
		if rt.is_true(rt.new_bool(rest_are_values_equal(var_sanitized_value.clone(), var_enum_value_shadow.clone()))) {
			return true
		}
	}
	var_encoded_enum_values = rt.new_array()
	mut iter_24 := var_args.array_get(rt.new_string('enum')).iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_enum_value_shadow := item_24.val
		var_encoded_enum_values << if rt.is_true(rt.call_function('is_scalar', [var_enum_value_shadow.clone()])) { var_enum_value_shadow } else { rt.call_function('wp_json_encode', [var_enum_value_shadow.clone()]) }
	}
	if var_encoded_enum_values.len == 1 {
		return (create_wp_error(rt.new_string('rest_not_in_enum'), rt.call_function('wp_sprintf', [rt.call_function('__', [rt.new_string('%1$s is not %2$s.')]), var_param.clone(), var_encoded_enum_values[0]]))).to_bool()
	}
	return (create_wp_error(rt.new_string('rest_not_in_enum'), rt.call_function('wp_sprintf', [rt.call_function('__', [rt.new_string('%1$s is not one of %2$l.')]), var_param.clone(), rt.create_array_from_list(var_encoded_enum_values)]))).to_bool()
}

fn rest_get_allowed_schema_keywords() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'format' }, rt.ArrayItem{ key: none, val: 'enum' }, rt.ArrayItem{ key: none, val: 'items' }, rt.ArrayItem{ key: none, val: 'properties' }, rt.ArrayItem{ key: none, val: 'additionalProperties' }, rt.ArrayItem{ key: none, val: 'patternProperties' }, rt.ArrayItem{ key: none, val: 'minProperties' }, rt.ArrayItem{ key: none, val: 'maxProperties' }, rt.ArrayItem{ key: none, val: 'minimum' }, rt.ArrayItem{ key: none, val: 'maximum' }, rt.ArrayItem{ key: none, val: 'exclusiveMinimum' }, rt.ArrayItem{ key: none, val: 'exclusiveMaximum' }, rt.ArrayItem{ key: none, val: 'multipleOf' }, rt.ArrayItem{ key: none, val: 'minLength' }, rt.ArrayItem{ key: none, val: 'maxLength' }, rt.ArrayItem{ key: none, val: 'pattern' }, rt.ArrayItem{ key: none, val: 'minItems' }, rt.ArrayItem{ key: none, val: 'maxItems' }, rt.ArrayItem{ key: none, val: 'uniqueItems' }, rt.ArrayItem{ key: none, val: 'anyOf' }, rt.ArrayItem{ key: none, val: 'oneOf' }])
}

fn rest_validate_value_from_schema(var_value rt.PhpVal, var_args rt.PhpVal, param string) bool {
	mut var_param := param
	mut var_matching_schema := rt.new_null()
	mut var_allowed_types := []rt.PhpVal{}
	mut var_best_type := ''
	mut var_is_valid := rt.new_null()
	mut var_enum_contains_value := false
	if var_args.array_isset(rt.new_string('anyOf')) {
		var_matching_schema = rest_find_any_matching_schema(var_value.clone(), var_args.clone(), rt.new_string(param))
		if rt.is_true(rt.call_function('is_wp_error', [var_matching_schema.clone()])) {
			return (var_matching_schema).to_bool()
		}
		if !(var_args.array_isset(rt.new_string('type'))) && var_matching_schema.array_isset(rt.new_string('type')) {
			var_args.array_set('type', var_matching_schema.array_get(rt.new_string('type')))
		}
	}
	if var_args.array_isset(rt.new_string('oneOf')) {
		var_matching_schema = rest_find_one_matching_schema(var_value.clone(), var_args.clone(), rt.new_string(param), false)
		if rt.is_true(rt.call_function('is_wp_error', [var_matching_schema.clone()])) {
			return (var_matching_schema).to_bool()
		}
		if !(var_args.array_isset(rt.new_string('type'))) && var_matching_schema.array_isset(rt.new_string('type')) {
			var_args.array_set('type', var_matching_schema.array_get(rt.new_string('type')))
		}
	}
	var_allowed_types = ['array', 'object', 'string', 'number', 'integer', 'boolean', 'null']
	if !(var_args.array_isset(rt.new_string('type'))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The "type" schema keyword for %s is required.')]), rt.new_string(param)]), rt.new_string('5.5.0')])
	}
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('type')).is_array())) {
		var_best_type = rest_handle_multi_type_schema(var_value.clone(), var_args.clone(), param)
		if !(var_best_type.len > 0 && var_best_type != '0') {
			return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), rt.new_string(param), rt.call_function('implode', [rt.new_string(','), var_args.array_get(rt.new_string('type'))])]), rt.create_array([rt.ArrayItem{ key: 'param', val: param }]))).to_bool()
		}
		var_args.array_set('type', var_best_type)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('type')), rt.create_array_from_list(var_allowed_types), rt.new_bool(true)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('wp_sprintf', [rt.call_function('__', [rt.new_string('The "type" schema keyword for %1$s can only be one of the built-in types: %2$l.')]), rt.new_string(param), rt.create_array_from_list(var_allowed_types)]), rt.new_string('5.5.0')])
	}
	mut switch_val_1 := var_args.array_get(rt.new_string('type'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('null'))) {
	var_is_valid = rt.new_bool(rest_validate_null_value_from_schema(var_value.clone(), rt.new_string(param)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean'))) {
	var_is_valid = rt.new_bool(rest_validate_boolean_value_from_schema(var_value.clone(), rt.new_string(param)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('object'))) {
	var_is_valid = rt.new_bool(rest_validate_object_value_from_schema(var_value.clone(), var_args.clone(), rt.new_string(param)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('array'))) {
	var_is_valid = rt.new_bool(rest_validate_array_value_from_schema(var_value.clone(), var_args.clone(), rt.new_string(param)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('number'))) {
	var_is_valid = rt.new_bool(rest_validate_number_value_from_schema(var_value.clone(), var_args.clone(), rt.new_string(param)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('string'))) {
	var_is_valid = rt.new_bool(rest_validate_string_value_from_schema(var_value.clone(), var_args.clone(), rt.new_string(param)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('integer'))) {
	var_is_valid = rt.new_bool(rest_validate_integer_value_from_schema(var_value.clone(), var_args.clone(), rt.new_string(param)))
	} else {
	var_is_valid = rt.new_bool(true)
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.clone()])) {
		return (var_is_valid).to_bool()
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('enum')))) {
		var_enum_contains_value = rest_validate_enum(var_value.clone(), var_args.clone(), param)
		if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_enum_contains_value).clone()])) {
			return var_enum_contains_value
		}
	}
	if var_args.array_isset(rt.new_string('format')) && !(var_args.array_isset(rt.new_string('type'))) || rt.is_true(rt.identical(rt.new_string('string'), var_args.array_get(rt.new_string('type')))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('type')), rt.create_array_from_list(var_allowed_types), rt.new_bool(true)]))))) {
		mut switch_val_2 := var_args.array_get(rt.new_string('format'))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('hex-color'))) {
			if !(rest_parse_hex_color(var_value.clone())) {
				return (create_wp_error(rt.new_string('rest_invalid_hex_color'), rt.call_function('__', [rt.new_string('Invalid hex color.')]))).to_bool()
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('date-time'))) {
			if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(rest_parse_date(var_value.clone(), false)))) {
				return (create_wp_error(rt.new_string('rest_invalid_date'), rt.call_function('__', [rt.new_string('Invalid date.')]))).to_bool()
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('email'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value.clone()]))))) {
				return (create_wp_error(rt.new_string('rest_invalid_email'), rt.call_function('__', [rt.new_string('Invalid email address.')]))).to_bool()
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('ip'))) {
			if !(rest_is_ip_address(var_value.clone())) {
				return (create_wp_error(rt.new_string('rest_invalid_ip'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid IP address.')]), rt.new_string(param)]))).to_bool()
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('uuid'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_uuid', [var_value.clone()]))))) {
				return (create_wp_error(rt.new_string('rest_invalid_uuid'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid UUID.')]), rt.new_string(param)]))).to_bool()
			}
		}
	}
	return true
}

fn rest_validate_null_value_from_schema(var_value rt.PhpVal, var_param rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value)))) {
		return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), var_param.clone(), rt.new_string('null')]), rt.create_array([rt.ArrayItem{ key: 'param', val: var_param }]))).to_bool()
	}
	return true
}

fn rest_validate_boolean_value_from_schema(var_value rt.PhpVal, var_param rt.PhpVal) bool {
	if !(rest_is_boolean(var_value.clone())) {
		return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), var_param.clone(), rt.new_string('boolean')]), rt.create_array([rt.ArrayItem{ key: 'param', val: var_param }]))).to_bool()
	}
	return true
}

fn rest_validate_object_value_from_schema(var_value_arg rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_value := var_value_arg
	mut var_name := rt.new_null()
	mut var_property := map[string]rt.PhpVal{}
	mut var_v := rt.new_null()
	mut var_is_valid := false
	mut var_pattern_property_schema := rt.new_null()
	if !(rest_is_object(var_value.clone())) {
		return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), var_param.clone(), rt.new_string('object')]), rt.create_array([rt.ArrayItem{ key: 'param', val: var_param }]))).to_bool()
	}
	var_value = rest_sanitize_object(var_value.clone())
	if var_args.array_isset(rt.new_string('required')) && var_args.array_get(rt.new_string('required')).is_array() {
		mut iter_25 := var_args.array_get(rt.new_string('required')).iterator()
		for {
			item_25 := iter_25.next() or { break }
			mut var_name_shadow := item_25.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.clone().array_isset(var_name_shadow.clone())))))) {
				return (create_wp_error(rt.new_string('rest_property_required'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is a required property of %2$s.')]), var_name_shadow.clone(), var_param.clone()]))).to_bool()
			}
		}
	} else if var_args.array_isset(rt.new_string('properties')) {
		mut iter_26 := var_args.array_get(rt.new_string('properties')).iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_property_shadow := item_26.val
			mut var_name_shadow := item_26.key
			if var_property_shadow.array_isset(rt.new_string('required')) && rt.is_true(rt.identical(rt.new_bool(true), var_property_shadow['required'])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.clone().array_isset(var_name_shadow.clone())))))) {
				return (create_wp_error(rt.new_string('rest_property_required'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is a required property of %2$s.')]), var_name_shadow.clone(), var_param.clone()]))).to_bool()
			}
		}
	}
	mut iter_27 := var_value.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_v_shadow := item_27.val
		mut var_property_shadow := item_27.key
		if var_args.array_get(rt.new_string('properties')).array_isset(var_property_shadow) {
			var_is_valid = rest_validate_value_from_schema(var_v_shadow.clone(), var_args.array_get(rt.new_string('properties')).array_get(var_property_shadow), (var_param).str() + '[' + (var_property_shadow).str() + ']')
			if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_is_valid).clone()])) {
				return var_is_valid
			}
			continue
		}
		var_pattern_property_schema = rest_find_matching_pattern_property_schema(var_property_shadow.clone(), var_args.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pattern_property_schema)))) {
			var_is_valid = rest_validate_value_from_schema(var_v_shadow.clone(), var_pattern_property_schema.clone(), (var_param).str() + '[' + (var_property_shadow).str() + ']')
			if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_is_valid).clone()])) {
				return var_is_valid
			}
			continue
		}
		if var_args.array_isset(rt.new_string('additionalProperties')) {
			if rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_string('additionalProperties')))) {
				return (create_wp_error(rt.new_string('rest_additional_properties_forbidden'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not a valid property of Object.')]), var_property_shadow.clone()]))).to_bool()
			}
			if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('additionalProperties')).is_array())) {
				var_is_valid = rest_validate_value_from_schema(var_v_shadow.clone(), var_args.array_get(rt.new_string('additionalProperties')), (var_param).str() + '[' + (var_property_shadow).str() + ']')
				if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_is_valid).clone()])) {
					return var_is_valid
				}
			}
		}
	}
	if var_args.array_isset(rt.new_string('minProperties')) && rt.is_true(rt.less(rt.new_int(var_value.clone().array_count()), var_args.array_get(rt.new_string('minProperties')))) {
		return (create_wp_error(rt.new_string('rest_too_few_properties'), rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$s must contain at least %2$s property.'), rt.new_string('%1$s must contain at least %2$s properties.'), var_args.array_get(rt.new_string('minProperties'))]), var_param.clone(), rt.call_function('number_format_i18n', [var_args.array_get(rt.new_string('minProperties'))])]))).to_bool()
	}
	if var_args.array_isset(rt.new_string('maxProperties')) && rt.is_true(rt.greater(rt.new_int(var_value.clone().array_count()), var_args.array_get(rt.new_string('maxProperties')))) {
		return (create_wp_error(rt.new_string('rest_too_many_properties'), rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$s must contain at most %2$s property.'), rt.new_string('%1$s must contain at most %2$s properties.'), var_args.array_get(rt.new_string('maxProperties'))]), var_param.clone(), rt.call_function('number_format_i18n', [var_args.array_get(rt.new_string('maxProperties'))])]))).to_bool()
	}
	return true
}

fn rest_validate_array_value_from_schema(var_value_arg rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_value := var_value_arg
	mut var_v := rt.new_null()
	mut var_index := rt.new_null()
	mut var_is_valid := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rest_is_array(var_value.clone()))))) {
		return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), var_param.clone(), rt.new_string('array')]), rt.create_array([rt.ArrayItem{ key: 'param', val: var_param }]))).to_bool()
	}
	var_value = rest_sanitize_array(var_value.clone())
	if var_args.array_isset(rt.new_string('items')) {
		mut iter_28 := var_value.iterator()
		for {
			item_28 := iter_28.next() or { break }
			mut var_v_shadow := item_28.val
			mut var_index_shadow := item_28.key
			var_is_valid = rest_validate_value_from_schema(var_v_shadow.clone(), var_args.array_get(rt.new_string('items')), (var_param).str() + '[' + (var_index_shadow).str() + ']')
			if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_is_valid).clone()])) {
				return var_is_valid
			}
		}
	}
	if var_args.array_isset(rt.new_string('minItems')) && rt.is_true(rt.less(rt.new_int(var_value.clone().array_count()), var_args.array_get(rt.new_string('minItems')))) {
		return (create_wp_error(rt.new_string('rest_too_few_items'), rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$s must contain at least %2$s item.'), rt.new_string('%1$s must contain at least %2$s items.'), var_args.array_get(rt.new_string('minItems'))]), var_param.clone(), rt.call_function('number_format_i18n', [var_args.array_get(rt.new_string('minItems'))])]))).to_bool()
	}
	if var_args.array_isset(rt.new_string('maxItems')) && rt.is_true(rt.greater(rt.new_int(var_value.clone().array_count()), var_args.array_get(rt.new_string('maxItems')))) {
		return (create_wp_error(rt.new_string('rest_too_many_items'), rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$s must contain at most %2$s item.'), rt.new_string('%1$s must contain at most %2$s items.'), var_args.array_get(rt.new_string('maxItems'))]), var_param.clone(), rt.call_function('number_format_i18n', [var_args.array_get(rt.new_string('maxItems'))])]))).to_bool()
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('uniqueItems')))) && !(rest_validate_array_contains_unique_items(var_value.clone())) {
		return (create_wp_error(rt.new_string('rest_duplicate_items'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s has duplicate items.')]), var_param.clone()]))).to_bool()
	}
	return true
}

fn rest_validate_number_value_from_schema(var_value rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal) bool {
	if !(var_value.clone().is_long() || var_value.clone().is_double()) {
		return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), var_param.clone(), var_args.array_get(rt.new_string('type'))]), rt.create_array([rt.ArrayItem{ key: 'param', val: var_param }]))).to_bool()
	}
	if var_args.array_isset(rt.new_string('multipleOf')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('fmod', [var_value.clone(), var_args.array_get(rt.new_string('multipleOf'))]), rt.new_float(0))))) {
		return (create_wp_error(rt.new_string('rest_invalid_multiple'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be a multiple of %2$s.')]), var_param.clone(), var_args.array_get(rt.new_string('multipleOf'))]))).to_bool()
	}
	if var_args.array_isset(rt.new_string('minimum')) && !(var_args.array_isset(rt.new_string('maximum'))) {
		if !(!rt.is_true(var_args.array_get(rt.new_string('exclusiveMinimum')))) && rt.is_true(rt.less_equal(var_value, var_args.array_get(rt.new_string('minimum')))) {
			return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be greater than %2$d')]), var_param.clone(), var_args.array_get(rt.new_string('minimum'))]))).to_bool()
		}
		if !rt.is_true(var_args.array_get(rt.new_string('exclusiveMinimum'))) && rt.is_true(rt.less(var_value, var_args.array_get(rt.new_string('minimum')))) {
			return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be greater than or equal to %2$d')]), var_param.clone(), var_args.array_get(rt.new_string('minimum'))]))).to_bool()
		}
	}
	if var_args.array_isset(rt.new_string('maximum')) && !(var_args.array_isset(rt.new_string('minimum'))) {
		if !(!rt.is_true(var_args.array_get(rt.new_string('exclusiveMaximum')))) && rt.is_true(rt.greater_equal(var_value, var_args.array_get(rt.new_string('maximum')))) {
			return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be less than %2$d')]), var_param.clone(), var_args.array_get(rt.new_string('maximum'))]))).to_bool()
		}
		if !rt.is_true(var_args.array_get(rt.new_string('exclusiveMaximum'))) && rt.is_true(rt.greater(var_value, var_args.array_get(rt.new_string('maximum')))) {
			return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be less than or equal to %2$d')]), var_param.clone(), var_args.array_get(rt.new_string('maximum'))]))).to_bool()
		}
	}
	if var_args.array_isset(rt.new_string('minimum')) && var_args.array_isset(rt.new_string('maximum')) {
		if !(!rt.is_true(var_args.array_get(rt.new_string('exclusiveMinimum')))) && !(!rt.is_true(var_args.array_get(rt.new_string('exclusiveMaximum')))) {
			if rt.is_true(rt.greater_equal(var_value, var_args.array_get(rt.new_string('maximum')))) || rt.is_true(rt.less_equal(var_value, var_args.array_get(rt.new_string('minimum')))) {
				return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be between %2$d (exclusive) and %3$d (exclusive)')]), var_param.clone(), var_args.array_get(rt.new_string('minimum')), var_args.array_get(rt.new_string('maximum'))]))).to_bool()
			}
		}
		if !(!rt.is_true(var_args.array_get(rt.new_string('exclusiveMinimum')))) && !rt.is_true(var_args.array_get(rt.new_string('exclusiveMaximum'))) {
			if rt.is_true(rt.greater(var_value, var_args.array_get(rt.new_string('maximum')))) || rt.is_true(rt.less_equal(var_value, var_args.array_get(rt.new_string('minimum')))) {
				return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be between %2$d (exclusive) and %3$d (inclusive)')]), var_param.clone(), var_args.array_get(rt.new_string('minimum')), var_args.array_get(rt.new_string('maximum'))]))).to_bool()
			}
		}
		if !(!rt.is_true(var_args.array_get(rt.new_string('exclusiveMaximum')))) && !rt.is_true(var_args.array_get(rt.new_string('exclusiveMinimum'))) {
			if rt.is_true(rt.greater_equal(var_value, var_args.array_get(rt.new_string('maximum')))) || rt.is_true(rt.less(var_value, var_args.array_get(rt.new_string('minimum')))) {
				return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be between %2$d (inclusive) and %3$d (exclusive)')]), var_param.clone(), var_args.array_get(rt.new_string('minimum')), var_args.array_get(rt.new_string('maximum'))]))).to_bool()
			}
		}
		if !rt.is_true(var_args.array_get(rt.new_string('exclusiveMinimum'))) && !rt.is_true(var_args.array_get(rt.new_string('exclusiveMaximum'))) {
			if rt.is_true(rt.greater(var_value, var_args.array_get(rt.new_string('maximum')))) || rt.is_true(rt.less(var_value, var_args.array_get(rt.new_string('minimum')))) {
				return (create_wp_error(rt.new_string('rest_out_of_bounds'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s must be between %2$d (inclusive) and %3$d (inclusive)')]), var_param.clone(), var_args.array_get(rt.new_string('minimum')), var_args.array_get(rt.new_string('maximum'))]))).to_bool()
			}
		}
	}
	return true
}

fn rest_validate_string_value_from_schema(var_value rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal) bool {
	if !(var_value.clone().is_string()) {
		return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), var_param.clone(), rt.new_string('string')]), rt.create_array([rt.ArrayItem{ key: 'param', val: var_param }]))).to_bool()
	}
	if var_args.array_isset(rt.new_string('minLength')) && rt.is_true(rt.less(rt.call_function('mb_strlen', [var_value.clone()]), var_args.array_get(rt.new_string('minLength')))) {
		return (create_wp_error(rt.new_string('rest_too_short'), rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$s must be at least %2$s character long.'), rt.new_string('%1$s must be at least %2$s characters long.'), var_args.array_get(rt.new_string('minLength'))]), var_param.clone(), rt.call_function('number_format_i18n', [var_args.array_get(rt.new_string('minLength'))])]))).to_bool()
	}
	if var_args.array_isset(rt.new_string('maxLength')) && rt.is_true(rt.greater(rt.call_function('mb_strlen', [var_value.clone()]), var_args.array_get(rt.new_string('maxLength')))) {
		return (create_wp_error(rt.new_string('rest_too_long'), rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$s must be at most %2$s character long.'), rt.new_string('%1$s must be at most %2$s characters long.'), var_args.array_get(rt.new_string('maxLength'))]), var_param.clone(), rt.call_function('number_format_i18n', [var_args.array_get(rt.new_string('maxLength'))])]))).to_bool()
	}
	if var_args.array_isset(rt.new_string('pattern')) && rt.is_true(rt.new_bool(!(rt.is_true(rest_validate_json_schema_pattern(var_args.array_get(rt.new_string('pattern')), var_value.clone()))))) {
		return (create_wp_error(rt.new_string('rest_invalid_pattern'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s does not match pattern %2$s.')]), var_param.clone(), var_args.array_get(rt.new_string('pattern'))]))).to_bool()
	}
	return true
}

fn rest_validate_integer_value_from_schema(var_value rt.PhpVal, var_args rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_is_valid_number := false
	var_is_valid_number = rest_validate_number_value_from_schema(var_value.clone(), var_args.clone(), var_param.clone())
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_is_valid_number).clone()])) {
		return var_is_valid_number
	}
	if !(rest_is_integer(var_value.clone())) {
		return (create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.')]), var_param.clone(), rt.new_string('integer')]), rt.create_array([rt.ArrayItem{ key: 'param', val: var_param }]))).to_bool()
	}
	return true
}

fn rest_sanitize_value_from_schema(var_value_arg rt.PhpVal, var_args rt.PhpVal, param string) rt.PhpVal {
	mut var_param := param
	mut var_value := var_value_arg
	mut var_matching_schema := rt.new_null()
	mut var_allowed_types := []rt.PhpVal{}
	mut var_best_type := ''
	mut var_v := rt.new_null()
	mut var_index := rt.new_null()
	mut var_property := map[string]rt.PhpVal{}
	mut var_pattern_property_schema := rt.new_null()
	if var_args.array_isset(rt.new_string('anyOf')) {
		var_matching_schema = rest_find_any_matching_schema(var_value.clone(), var_args.clone(), rt.new_string(param))
		if rt.is_true(rt.call_function('is_wp_error', [var_matching_schema.clone()])) {
			return var_matching_schema.clone()
		}
		if !(var_args.array_isset(rt.new_string('type'))) {
			var_args.array_set('type', var_matching_schema.array_get(rt.new_string('type')))
		}
	var_value = rest_sanitize_value_from_schema(var_value.clone(), var_matching_schema.clone(), param)
	}
	if var_args.array_isset(rt.new_string('oneOf')) {
		var_matching_schema = rest_find_one_matching_schema(var_value.clone(), var_args.clone(), rt.new_string(param), false)
		if rt.is_true(rt.call_function('is_wp_error', [var_matching_schema.clone()])) {
			return var_matching_schema.clone()
		}
		if !(var_args.array_isset(rt.new_string('type'))) {
			var_args.array_set('type', var_matching_schema.array_get(rt.new_string('type')))
		}
	var_value = rest_sanitize_value_from_schema(var_value.clone(), var_matching_schema.clone(), param)
	}
	var_allowed_types = ['array', 'object', 'string', 'number', 'integer', 'boolean', 'null']
	if !(var_args.array_isset(rt.new_string('type'))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The "type" schema keyword for %s is required.')]), rt.new_string(param)]), rt.new_string('5.5.0')])
	}
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('type')).is_array())) {
		var_best_type = rest_handle_multi_type_schema(var_value.clone(), var_args.clone(), param)
		if !(var_best_type.len > 0 && var_best_type != '0') {
			return rt.new_null()
		}
		var_args.array_set('type', var_best_type)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('type')), rt.create_array_from_list(var_allowed_types), rt.new_bool(true)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('wp_sprintf', [rt.call_function('__', [rt.new_string('The "type" schema keyword for %1$s can only be one of the built-in types: %2$l.')]), rt.new_string(param), rt.create_array_from_list(var_allowed_types)]), rt.new_string('5.5.0')])
	}
	if rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get(rt.new_string('type')))) {
		var_value = rest_sanitize_array(var_value.clone())
		if !(!rt.is_true(var_args.array_get(rt.new_string('items')))) {
			mut iter_29 := var_value.iterator()
			for {
				item_29 := iter_29.next() or { break }
				mut var_v_shadow := item_29.val
				mut var_index_shadow := item_29.key
				var_value.array_set(var_index_shadow, rest_sanitize_value_from_schema(var_v_shadow.clone(), var_args.array_get(rt.new_string('items')), param + '[' + (var_index_shadow).str() + ']'))
			}
		}
		if !(!rt.is_true(var_args.array_get(rt.new_string('uniqueItems')))) && !(rest_validate_array_contains_unique_items(var_value.clone())) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_duplicate_items'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s has duplicate items.')]), rt.new_string(param)])))
		}
		return var_value.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('object'), var_args.array_get(rt.new_string('type')))) {
		var_value = rest_sanitize_object(var_value.clone())
		mut iter_30 := var_value.iterator()
		for {
			item_30 := iter_30.next() or { break }
			mut var_v_shadow := item_30.val
			mut var_property_shadow := item_30.key
			if var_args.array_get(rt.new_string('properties')).array_isset(var_property_shadow) {
				var_value.array_set(var_property_shadow, rest_sanitize_value_from_schema(var_v_shadow.clone(), var_args.array_get(rt.new_string('properties')).array_get(var_property_shadow), param + '[' + (var_property_shadow).str() + ']'))
				continue
			}
			var_pattern_property_schema = rest_find_matching_pattern_property_schema(var_property_shadow.clone(), var_args.clone())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pattern_property_schema)))) {
				var_value.array_set(var_property_shadow, rest_sanitize_value_from_schema(var_v_shadow.clone(), var_pattern_property_schema.clone(), param + '[' + (var_property_shadow).str() + ']'))
				continue
			}
			if var_args.array_isset(rt.new_string('additionalProperties')) {
				if rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_string('additionalProperties')))) {
					var_value.array_unset(var_property_shadow)
				} else if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('additionalProperties')).is_array())) {
					var_value.array_set(var_property_shadow, rest_sanitize_value_from_schema(var_v_shadow.clone(), var_args.array_get(rt.new_string('additionalProperties')), param + '[' + (var_property_shadow).str() + ']'))
				}
			}
		}
		return var_value.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('null'), var_args.array_get(rt.new_string('type')))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('integer'), var_args.array_get(rt.new_string('type')))) {
		return rt.new_int((var_value).to_i64())
	}
	if rt.is_true(rt.identical(rt.new_string('number'), var_args.array_get(rt.new_string('type')))) {
		return rt.new_float((var_value).to_f64())
	}
	if rt.is_true(rt.identical(rt.new_string('boolean'), var_args.array_get(rt.new_string('type')))) {
		return rt.new_bool(rest_sanitize_boolean(var_value.clone()))
	}
	if var_args.array_isset(rt.new_string('format')) && !(var_args.array_isset(rt.new_string('type'))) || rt.is_true(rt.identical(rt.new_string('string'), var_args.array_get(rt.new_string('type')))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('type')), rt.create_array_from_list(var_allowed_types), rt.new_bool(true)]))))) {
		mut switch_val_3 := var_args.array_get(rt.new_string('format'))
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('hex-color'))) {
			return rt.new_string((rt.call_function('sanitize_hex_color', [var_value.clone()])).str())
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('date-time'))) {
			return rt.call_function('sanitize_text_field', [var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('email'))) {
			return rt.call_function('sanitize_text_field', [var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('uri'))) {
			return rt.call_function('sanitize_url', [var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('ip'))) {
			return rt.call_function('sanitize_text_field', [var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('uuid'))) {
			return rt.call_function('sanitize_text_field', [var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('text-field'))) {
			return rt.call_function('sanitize_text_field', [var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('textarea-field'))) {
			return rt.call_function('sanitize_textarea_field', [var_value.clone()])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('string'), var_args.array_get(rt.new_string('type')))) {
		return rt.new_string((var_value).str())
	}
	return var_value.clone()
}

fn rest_preload_api_request(var_memo_arg rt.PhpVal, var_path_arg rt.PhpVal) rt.PhpVal {
	mut var_memo := var_memo_arg
	mut var_path := var_path_arg
	mut var_query_params := rt.new_null()
	mut var_method := rt.new_null()
	mut var_path_parts := rt.new_null()
	mut var_request := rt.new_null()
	mut var_response := rt.new_null()
	mut var_server := rt.new_null()
	mut var_embed := rt.new_null()
	mut var_data := rt.new_null()
	if !(var_memo.clone().is_array()) {
	var_memo = rt.new_array()
	}
	if !rt.is_true(var_path) {
		return var_memo.clone()
	}
	var_method = rt.new_string('GET')
	if var_path.clone().is_array() && 2 == var_path.clone().array_count() {
		var_method = rt.call_function('end', [var_path.clone()])
		var_path = rt.call_function('reset', [var_path.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_method.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }, rt.ArrayItem{ key: none, val: 'OPTIONS' }]), rt.new_bool(true)]))))) {
		var_method = rt.new_string('GET')
		}
	}
	var_path = rt.call_function('untrailingslashit', [var_path.clone()])
	if !rt.is_true(var_path) {
	var_path = rt.new_string('/')
	}
	var_path_parts = rt.call_function('parse_url', [var_path.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_path_parts)) {
		return var_memo.clone()
	}
	if var_path_parts.array_isset(rt.new_string('path')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), var_path_parts.array_get(rt.new_string('path')))))) {
		var_path_parts.array_set('path', rt.call_function('untrailingslashit', [var_path_parts.array_get(rt.new_string('path'))]))
	var_path = if rt.is_true(rt.call_function('str_contains', [var_path.clone(), rt.new_string('?')])) { (var_path_parts.array_get(rt.new_string('path'))).str() + '?' + (if !(var_path_parts.array_get(rt.new_string('query'))).is_null() { var_path_parts.array_get(rt.new_string('query')) } else { rt.new_string('') }).str() } else { var_path_parts.array_get(rt.new_string('path')) }
	}
	var_request = create_wp_rest_request(var_method.clone(), var_path_parts.array_get(rt.new_string('path')))
	if !(!rt.is_true(var_path_parts.array_get(rt.new_string('query')))) {
		rt.call_function('parse_str', [var_path_parts.array_get(rt.new_string('query')), var_query_params.clone()])
		rt.call_method(var_request, 'set_query_params', [var_query_params.clone()])
	}
	var_response = rest_do_request(var_request.clone())
	if rt.is_true(rt.identical(rt.new_int(200), rt.get_property(var_response, 'status'))) {
		var_server = rest_get_server()
		var_response = rt.call_function('apply_filters', [rt.new_string('rest_post_dispatch'), rest_ensure_response(var_response.clone()), var_server.clone(), var_request.clone()])
		var_embed = rt.new_bool(if rt.is_true(rt.call_method(var_request, 'has_param', [rt.new_string('_embed')])) { rest_parse_embed_param(var_request.array_get(rt.new_string('_embed'))) } else { false })
		var_data = rt.cast_array(rt.call_method(var_server, 'response_to_data', [var_response.clone(), var_embed.clone()]))
		if rt.is_true(rt.identical(rt.new_string('OPTIONS'), var_method)) {
			var_memo.array_get_mut(var_method).array_set(var_path, rt.create_array([rt.ArrayItem{ key: 'body', val: var_data }, rt.ArrayItem{ key: 'headers', val: rt.get_property(var_response, 'headers') }]))
		} else {
			var_memo.array_set(var_path, rt.create_array([rt.ArrayItem{ key: 'body', val: var_data }, rt.ArrayItem{ key: 'headers', val: rt.get_property(var_response, 'headers') }]))
		}
	}
	return var_memo.clone()
}

fn rest_parse_embed_param(var_embed rt.PhpVal) bool {
	mut var_rels := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_embed)))) || rt.is_true(rt.identical(rt.new_string('true'), var_embed)) || rt.is_true(rt.identical(rt.new_string('1'), var_embed)) {
		return true
	}
	var_rels = rt.call_function('wp_parse_list', [var_embed.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_rels)))) {
		return true
	}
	return (var_rels).to_bool()
}

fn rest_filter_response_by_context(var_response_data_arg rt.PhpVal, var_schema rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_response_data := var_response_data_arg
	mut var_matching_schema := rt.new_null()
	mut var_type := rt.new_null()
	mut var_is_array_type := false
	mut var_is_object_type := false
	mut var_has_additional_properties := false
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_check := rt.new_null()
	mut var_pattern_property_schema := rt.new_null()
	mut var_new_value := rt.new_null()
	if var_schema.array_isset(rt.new_string('anyOf')) {
		var_matching_schema = rest_find_any_matching_schema(var_response_data.clone(), rt.create_array_from_native_map(var_schema), rt.new_string(''))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_matching_schema.clone()]))))) {
			if !(var_schema.array_isset(rt.new_string('type'))) {
				var_schema['type'] = var_matching_schema.array_get(rt.new_string('type'))
			}
		var_response_data = rest_filter_response_by_context(var_response_data.clone(), var_matching_schema.clone(), var_context.clone())
		}
	}
	if var_schema.array_isset(rt.new_string('oneOf')) {
		var_matching_schema = rest_find_one_matching_schema(var_response_data.clone(), rt.create_array_from_native_map(var_schema), rt.new_string(''), true)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_matching_schema.clone()]))))) {
			if !(var_schema.array_isset(rt.new_string('type'))) {
				var_schema['type'] = var_matching_schema.array_get(rt.new_string('type'))
			}
		var_response_data = rest_filter_response_by_context(var_response_data.clone(), var_matching_schema.clone(), var_context.clone())
		}
	}
	if !(var_response_data.clone().is_array()) && !(var_response_data.clone().is_object()) {
		return var_response_data.clone()
	}
	if var_schema.array_isset(rt.new_string('type')) {
	var_type = var_schema['type']
	} else if var_schema.array_isset(rt.new_string('properties')) {
	var_type = rt.new_string('object')
	} else {
		return var_response_data.clone()
	}
	var_is_array_type = rt.is_true(rt.identical(rt.new_string('array'), var_type)) || var_type.clone().is_array() && rt.is_true(rt.call_function('in_array', [rt.new_string('array'), var_type.clone(), rt.new_bool(true)]))
	var_is_object_type = rt.is_true(rt.identical(rt.new_string('object'), var_type)) || var_type.clone().is_array() && rt.is_true(rt.call_function('in_array', [rt.new_string('object'), var_type.clone(), rt.new_bool(true)]))
	if var_is_array_type && var_is_object_type {
		if rt.is_true(rest_is_array(var_response_data.clone())) {
		var_is_object_type = false
		} else {
		var_is_array_type = false
		}
	}
	var_has_additional_properties = var_is_object_type && var_schema.array_isset(rt.new_string('additionalProperties')) && var_schema['additionalProperties'].is_array()
	mut iter_31 := var_response_data.iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_value_shadow := item_31.val
		mut var_key_shadow := item_31.key
		var_check = rt.new_array()
		if var_is_array_type {
		var_check = if !(var_schema['items']).is_null() { var_schema['items'] } else { rt.new_array() }
		} else if var_is_object_type {
			if var_schema['properties'].array_isset(var_key_shadow) {
			var_check = var_schema['properties'].array_get(var_key_shadow)
			} else {
				var_pattern_property_schema = rest_find_matching_pattern_property_schema(var_key_shadow.clone(), rt.create_array_from_native_map(var_schema))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pattern_property_schema)))) {
				var_check = var_pattern_property_schema.clone()
				} else if var_has_additional_properties {
				var_check = var_schema['additionalProperties']
				}
			}
		}
		if !(var_check.array_isset(rt.new_string('context'))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_context.clone(), var_check.array_get(rt.new_string('context')), rt.new_bool(true)]))))) {
			if var_is_array_type {
				var_response_data = rt.new_array()
				break
			}
			if rt.is_true(rt.new_bool(var_response_data.clone().is_object())) {
				rt.get_property(var_response_data, '{"nodeType":"Expr_Variable","line":3121,"name":"key"}') = rt.new_null()
			} else {
				var_response_data.array_unset(var_key_shadow)
			}
		} else if var_value_shadow.clone().is_array() || var_value_shadow.clone().is_object() {
			var_new_value = rest_filter_response_by_context(var_value_shadow.clone(), var_check.clone(), var_context.clone())
			if rt.is_true(rt.new_bool(var_response_data.clone().is_object())) {
				rt.set_property(var_response_data, '{"nodeType":"Expr_Variable","line":3129,"name":"key"}', var_new_value.clone())
			} else {
				var_response_data.array_set(var_key_shadow, var_new_value.clone())
			}
		}
	}
	return var_response_data.clone()
}

fn rest_default_additional_properties_to_false(var_schema rt.PhpVal) rt.PhpVal {
	mut var_type := rt.new_null()
	mut var_child_schema := rt.new_null()
	mut var_key := rt.new_null()
	var_type = rt.cast_array(var_schema['type'])
	if rt.is_true(rt.call_function('in_array', [rt.new_string('object'), var_type.clone(), rt.new_bool(true)])) {
		if var_schema.array_isset(rt.new_string('properties')) {
			mut iter_32 := var_schema['properties'].iterator()
			for {
				item_32 := iter_32.next() or { break }
				mut var_child_schema_shadow := item_32.val
				mut var_key_shadow := item_32.key
				var_schema.array_get_mut('properties').array_set(var_key_shadow, rest_default_additional_properties_to_false(var_child_schema_shadow.clone()))
			}
		}
		if var_schema.array_isset(rt.new_string('patternProperties')) {
			mut iter_33 := var_schema['patternProperties'].iterator()
			for {
				item_33 := iter_33.next() or { break }
				mut var_child_schema_shadow := item_33.val
				mut var_key_shadow := item_33.key
				var_schema.array_get_mut('patternProperties').array_set(var_key_shadow, rest_default_additional_properties_to_false(var_child_schema_shadow.clone()))
			}
		}
		if !(var_schema.array_isset(rt.new_string('additionalProperties'))) {
			var_schema['additionalProperties'] = rt.new_bool(false)
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('array'), var_type.clone(), rt.new_bool(true)])) {
		if var_schema.array_isset(rt.new_string('items')) {
			var_schema['items'] = rest_default_additional_properties_to_false(var_schema['items'])
		}
	}
	return var_schema.clone()
}

fn rest_get_route_for_post(var_post_arg rt.PhpVal) string {
	mut var_post := var_post_arg
	mut var_post_type_route := rt.new_null()
	mut var_route := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return ''
	}
	var_post_type_route = rt.new_string(rest_get_route_for_post_type_items(rt.get_property(var_post, 'post_type')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_route)))) {
		return ''
	}
	var_route = rt.call_function('sprintf', [rt.new_string('%s/%d'), var_post_type_route.clone(), rt.get_property(var_post, 'ID')])
	return (rt.call_function('apply_filters', [rt.new_string('rest_route_for_post'), var_route.clone(), var_post.clone()])).str()
}

fn rest_get_route_for_post_type_items(var_post_type_arg rt.PhpVal) string {
	mut var_post_type := var_post_type_arg
	mut var_namespace := rt.new_null()
	mut var_rest_base := rt.new_null()
	mut var_route := rt.new_null()
	var_post_type = rt.call_function('get_post_type_object', [var_post_type.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type, 'show_in_rest'))))) {
		return ''
	}
	var_namespace = if !(!rt.is_true(rt.get_property(var_post_type, 'rest_namespace'))) { rt.get_property(var_post_type, 'rest_namespace') } else { rt.new_string('wp/v2') }
	var_rest_base = if !(!rt.is_true(rt.get_property(var_post_type, 'rest_base'))) { rt.get_property(var_post_type, 'rest_base') } else { rt.get_property(var_post_type, 'name') }
	var_route = rt.call_function('sprintf', [rt.new_string('/%s/%s'), var_namespace.clone(), var_rest_base.clone()])
	return (rt.call_function('apply_filters', [rt.new_string('rest_route_for_post_type_items'), var_route.clone(), var_post_type.clone()])).str()
}

fn rest_get_route_for_term(var_term_arg rt.PhpVal) string {
	mut var_term := var_term_arg
	mut var_taxonomy_route := rt.new_null()
	mut var_route := rt.new_null()
	var_term = rt.call_function('get_term', [var_term.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term')))))) {
		return ''
	}
	var_taxonomy_route = rt.new_string(rest_get_route_for_taxonomy_items(rt.get_property(var_term, 'taxonomy')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_route)))) {
		return ''
	}
	var_route = rt.call_function('sprintf', [rt.new_string('%s/%d'), var_taxonomy_route.clone(), rt.get_property(var_term, 'term_id')])
	return (rt.call_function('apply_filters', [rt.new_string('rest_route_for_term'), var_route.clone(), var_term.clone()])).str()
}

fn rest_get_route_for_taxonomy_items(var_taxonomy_arg rt.PhpVal) string {
	mut var_taxonomy := var_taxonomy_arg
	mut var_namespace := rt.new_null()
	mut var_rest_base := rt.new_null()
	mut var_route := rt.new_null()
	var_taxonomy = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy)))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_in_rest'))))) {
		return ''
	}
	var_namespace = if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_namespace'))) { rt.get_property(var_taxonomy, 'rest_namespace') } else { rt.new_string('wp/v2') }
	var_rest_base = if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
	var_route = rt.call_function('sprintf', [rt.new_string('/%s/%s'), var_namespace.clone(), var_rest_base.clone()])
	return (rt.call_function('apply_filters', [rt.new_string('rest_route_for_taxonomy_items'), var_route.clone(), var_taxonomy.clone()])).str()
}

fn rest_get_queried_resource_route() rt.PhpVal {
	mut var_route := rt.new_null()
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
	var_route = rt.new_string(rest_get_route_for_post(rt.call_function('get_queried_object', []rt.PhpVal{})))
	} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
	var_route = rt.new_string(rest_get_route_for_term(rt.call_function('get_queried_object', []rt.PhpVal{})))
	} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
	var_route = rt.new_string('/wp/v2/users/' + (rt.call_function('get_queried_object_id', []rt.PhpVal{})).str())
	} else {
	var_route = rt.new_string('')
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_queried_resource_route'), var_route.clone()])
}

fn rest_get_endpoint_args_for_schema(var_schema rt.PhpVal, var_method rt.PhpVal) rt.PhpVal {
	mut var_schema_properties := rt.new_null()
	mut var_endpoint_args := rt.new_null()
	mut var_valid_schema_properties := rt.new_null()
	mut var_params := rt.new_null()
	mut var_field_id := rt.new_null()
	mut var_schema_prop := rt.new_null()
	var_schema_properties = if !(!rt.is_true(var_schema['properties'])) { var_schema['properties'] } else { rt.new_array() }
	var_endpoint_args = rt.new_array()
	var_valid_schema_properties = rest_get_allowed_schema_keywords()
	var_valid_schema_properties = rt.call_function('array_diff', [var_valid_schema_properties.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'required' }])])
	mut iter_34 := var_schema_properties.iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_params_shadow := item_34.val
		mut var_field_id_shadow := item_34.key
		if !(!rt.is_true(var_params_shadow.array_get(rt.new_string('readonly')))) {
			continue
		}
		var_endpoint_args.array_set(var_field_id_shadow, rt.create_array([rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_request_arg' }]))
		if rt.is_true(rt.identical(Class_WP_REST_Server.creatable(), var_method)) && var_params_shadow.array_isset(rt.new_string('default')) {
			var_endpoint_args.array_get_mut(var_field_id_shadow).array_set('default', var_params_shadow.array_get(rt.new_string('default')))
		}
		if rt.is_true(rt.identical(Class_WP_REST_Server.creatable(), var_method)) && !(!rt.is_true(var_params_shadow.array_get(rt.new_string('required')))) {
			var_endpoint_args.array_get_mut(var_field_id_shadow).array_set('required', true)
		}
		mut iter_35 := var_valid_schema_properties.iterator()
		for {
			item_35 := iter_35.next() or { break }
			mut var_schema_prop_shadow := item_35.val
			if var_params_shadow.array_isset(var_schema_prop_shadow) {
				var_endpoint_args.array_get_mut(var_field_id_shadow).array_set(var_schema_prop_shadow, var_params_shadow.array_get(var_schema_prop_shadow))
			}
		}
		if var_params_shadow.array_isset(rt.new_string('arg_options')) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_REST_Server.creatable(), var_method)))) {
				var_params_shadow.array_set('arg_options', rt.call_function('array_diff_key', [var_params_shadow.array_get(rt.new_string('arg_options')), rt.create_array([rt.ArrayItem{ key: 'required', val: '' }, rt.ArrayItem{ key: 'default', val: '' }])]))
			}
			var_endpoint_args.array_set(var_field_id_shadow, rt.call_function('array_merge', [var_endpoint_args.array_get(var_field_id_shadow), var_params_shadow.array_get(rt.new_string('arg_options'))]))
		}
	}
	return var_endpoint_args.clone()
}

fn rest_convert_error_to_response(var_error rt.PhpVal) rt.PhpVal {
	mut var_status := rt.new_null()
	mut var_errors := []rt.PhpVal{}
	mut var_messages := rt.new_null()
	mut var_code := rt.new_null()
	mut var_all_data := rt.new_null()
	mut var_last_data := rt.new_null()
	mut var_message := rt.new_null()
	mut var_formatted := map[string]rt.PhpVal{}
	mut var_data := rt.new_null()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_status := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_error_data := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if var_error_data.clone().is_array() && var_error_data.array_isset(rt.new_string('status')) && var_error_data.array_get(rt.new_string('status')).is_long() || var_error_data.array_get(rt.new_string('status')).is_double() {
		var_status = rt.new_int((var_error_data.array_get(rt.new_string('status'))).to_i64())
		}
		return var_status.clone()
		}
	var_status = rt.call_function('array_reduce', [rt.call_method(var_error, 'get_all_error_data', []rt.PhpVal{}), rt.new_closure(closure_3_fn), rt.new_int(500)])
	var_errors = rt.new_array()
	mut iter_36 := rt.cast_array(rt.get_property(var_error, 'errors')).iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_messages_shadow := item_36.val
		mut var_code_shadow := item_36.key
		var_all_data = rt.call_method(var_error, 'get_all_error_data', [var_code_shadow.clone()])
		var_last_data = rt.call_function('array_pop', [var_all_data.clone()])
		mut iter_37 := rt.cast_array(var_messages_shadow).iterator()
		for {
			item_37 := iter_37.next() or { break }
			mut var_message_shadow := item_37.val
			var_formatted = { 'code': var_code_shadow, 'message': var_message_shadow, 'data': var_last_data }
			if rt.is_true(var_all_data) {
				var_formatted['additional_data'] = var_all_data.clone()
			}
			var_errors << var_formatted.clone()
		}
	}
	var_data = var_errors[0]
	if var_errors.len > 1 {
		rt.call_function('array_shift', [rt.create_array_from_list(var_errors)])
		var_data.array_set('additional_errors', var_errors.clone())
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_data.clone(), var_status.clone()))
}

fn wp_is_rest_endpoint() bool {
	mut var_wp_rest_server := rt.new_null()
	mut var_is_rest_endpoint := rt.new_null()
	var_is_rest_endpoint = rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_rest_endpoint)))) {
	var_is_rest_endpoint = rt.new_bool(!(var_wp_rest_server).is_null() && rt.is_true(rt.call_method(var_wp_rest_server, 'is_dispatching', []rt.PhpVal{})))
	}
	return (rt.call_function('apply_filters', [rt.new_string('wp_is_rest_endpoint'), var_is_rest_endpoint.clone()])).to_bool()
}

struct Class_WP_REST_Post_Types_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Post_Statuses_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Taxonomies_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Users_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Application_Passwords_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Comments_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Post_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_REST_Term_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_REST_Post_Format_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_REST_Search_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Block_Renderer_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Block_Types_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Settings_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Themes_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Plugins_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Sidebars_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Widget_Types_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Widgets_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Block_Directory_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Pattern_Directory_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Block_Patterns_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Block_Pattern_Categories_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

struct Class_WP_REST_Site_Health_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_URL_Details_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Menu_Locations_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Edit_Site_Export_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Navigation_Fallback_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Font_Collections_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Abilities_V1_Categories_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Abilities_V1_Run_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Abilities_V1_List_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Icons_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Ipv6 {
	rt.PhpObjectBase
}

fn create_wp_rest_post_types_controller(_args ...rt.PhpVal) &Class_WP_REST_Post_Types_Controller {
	mut obj := &Class_WP_REST_Post_Types_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_post_statuses_controller(_args ...rt.PhpVal) &Class_WP_REST_Post_Statuses_Controller {
	mut obj := &Class_WP_REST_Post_Statuses_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_taxonomies_controller(_args ...rt.PhpVal) &Class_WP_REST_Taxonomies_Controller {
	mut obj := &Class_WP_REST_Taxonomies_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_users_controller(_args ...rt.PhpVal) &Class_WP_REST_Users_Controller {
	mut obj := &Class_WP_REST_Users_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_application_passwords_controller(_args ...rt.PhpVal) &Class_WP_REST_Application_Passwords_Controller {
	mut obj := &Class_WP_REST_Application_Passwords_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_comments_controller(_args ...rt.PhpVal) &Class_WP_REST_Comments_Controller {
	mut obj := &Class_WP_REST_Comments_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_post_search_handler(_args ...rt.PhpVal) &Class_WP_REST_Post_Search_Handler {
	mut obj := &Class_WP_REST_Post_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_term_search_handler(_args ...rt.PhpVal) &Class_WP_REST_Term_Search_Handler {
	mut obj := &Class_WP_REST_Term_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_post_format_search_handler(_args ...rt.PhpVal) &Class_WP_REST_Post_Format_Search_Handler {
	mut obj := &Class_WP_REST_Post_Format_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_search_controller(_args ...rt.PhpVal) &Class_WP_REST_Search_Controller {
	mut obj := &Class_WP_REST_Search_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_block_renderer_controller(_args ...rt.PhpVal) &Class_WP_REST_Block_Renderer_Controller {
	mut obj := &Class_WP_REST_Block_Renderer_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_block_types_controller(_args ...rt.PhpVal) &Class_WP_REST_Block_Types_Controller {
	mut obj := &Class_WP_REST_Block_Types_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_settings_controller(_args ...rt.PhpVal) &Class_WP_REST_Settings_Controller {
	mut obj := &Class_WP_REST_Settings_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_themes_controller(_args ...rt.PhpVal) &Class_WP_REST_Themes_Controller {
	mut obj := &Class_WP_REST_Themes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_plugins_controller(_args ...rt.PhpVal) &Class_WP_REST_Plugins_Controller {
	mut obj := &Class_WP_REST_Plugins_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_sidebars_controller(_args ...rt.PhpVal) &Class_WP_REST_Sidebars_Controller {
	mut obj := &Class_WP_REST_Sidebars_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_widget_types_controller(_args ...rt.PhpVal) &Class_WP_REST_Widget_Types_Controller {
	mut obj := &Class_WP_REST_Widget_Types_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_widgets_controller(_args ...rt.PhpVal) &Class_WP_REST_Widgets_Controller {
	mut obj := &Class_WP_REST_Widgets_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_block_directory_controller(_args ...rt.PhpVal) &Class_WP_REST_Block_Directory_Controller {
	mut obj := &Class_WP_REST_Block_Directory_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_pattern_directory_controller(_args ...rt.PhpVal) &Class_WP_REST_Pattern_Directory_Controller {
	mut obj := &Class_WP_REST_Pattern_Directory_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_block_patterns_controller(_args ...rt.PhpVal) &Class_WP_REST_Block_Patterns_Controller {
	mut obj := &Class_WP_REST_Block_Patterns_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_block_pattern_categories_controller(_args ...rt.PhpVal) &Class_WP_REST_Block_Pattern_Categories_Controller {
	mut obj := &Class_WP_REST_Block_Pattern_Categories_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_health(_args ...rt.PhpVal) &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_site_health_controller(_args ...rt.PhpVal) &Class_WP_REST_Site_Health_Controller {
	mut obj := &Class_WP_REST_Site_Health_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_url_details_controller(_args ...rt.PhpVal) &Class_WP_REST_URL_Details_Controller {
	mut obj := &Class_WP_REST_URL_Details_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_menu_locations_controller(_args ...rt.PhpVal) &Class_WP_REST_Menu_Locations_Controller {
	mut obj := &Class_WP_REST_Menu_Locations_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_edit_site_export_controller(_args ...rt.PhpVal) &Class_WP_REST_Edit_Site_Export_Controller {
	mut obj := &Class_WP_REST_Edit_Site_Export_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_navigation_fallback_controller(_args ...rt.PhpVal) &Class_WP_REST_Navigation_Fallback_Controller {
	mut obj := &Class_WP_REST_Navigation_Fallback_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_font_collections_controller(_args ...rt.PhpVal) &Class_WP_REST_Font_Collections_Controller {
	mut obj := &Class_WP_REST_Font_Collections_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_abilities_v1_categories_controller(_args ...rt.PhpVal) &Class_WP_REST_Abilities_V1_Categories_Controller {
	mut obj := &Class_WP_REST_Abilities_V1_Categories_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_abilities_v1_run_controller(_args ...rt.PhpVal) &Class_WP_REST_Abilities_V1_Run_Controller {
	mut obj := &Class_WP_REST_Abilities_V1_Run_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_abilities_v1_list_controller(_args ...rt.PhpVal) &Class_WP_REST_Abilities_V1_List_Controller {
	mut obj := &Class_WP_REST_Abilities_V1_List_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_icons_controller(_args ...rt.PhpVal) &Class_WP_REST_Icons_Controller {
	mut obj := &Class_WP_REST_Icons_Controller{
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

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
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

fn create_wporg_requests_ipv6(_args ...rt.PhpVal) &Class_WpOrg_Requests_Ipv6 {
	mut obj := &Class_WpOrg_Requests_Ipv6{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Post_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Post_Statuses_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Statuses_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Taxonomies_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Taxonomies_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Taxonomies_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Users_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Users_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Users_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Application_Passwords_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Application_Passwords_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Comments_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Comments_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Comments_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Post_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Term_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Term_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Term_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Post_Format_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Format_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Search_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Search_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Search_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Block_Renderer_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Block_Renderer_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Block_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Block_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Settings_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Settings_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Settings_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Themes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Themes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Themes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Plugins_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Plugins_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Plugins_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Sidebars_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Sidebars_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Sidebars_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Widget_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Widget_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Widget_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Widgets_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Widgets_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Widgets_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Block_Directory_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Block_Directory_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Directory_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Pattern_Directory_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Pattern_Directory_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Block_Patterns_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Block_Patterns_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Block_Pattern_Categories_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Site_Health) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Site_Health_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Site_Health_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Site_Health_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_URL_Details_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_URL_Details_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_URL_Details_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Menu_Locations_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Menu_Locations_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Edit_Site_Export_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Edit_Site_Export_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Edit_Site_Export_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Navigation_Fallback_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Navigation_Fallback_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Font_Collections_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Font_Collections_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Font_Collections_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Abilities_V1_Categories_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Abilities_V1_Categories_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Abilities_V1_Categories_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Abilities_V1_Run_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Abilities_V1_List_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Abilities_V1_List_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Icons_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Icons_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Icons_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WpOrg_Requests_Ipv6) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Ipv6) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Ipv6) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('register_rest_route', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rt.new_bool(register_rest_route(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('register_rest_field', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return register_rest_field(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_api_init', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_init()
	})
	rt.register_func('rest_api_register_rewrites', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_register_rewrites()
	})
	rt.register_func('rest_api_default_filters', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_default_filters()
	})
	rt.register_func('create_initial_rest_routes', fn(args []rt.PhpVal) rt.PhpVal {
		return create_initial_rest_routes()
	})
	rt.register_func('rest_api_loaded', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_loaded()
	})
	rt.register_func('rest_get_url_prefix', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_url_prefix()
	})
	rt.register_func('get_rest_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_rest_url(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return rest_url(arg_0, arg_1)
	})
	rt.register_func('rest_do_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_do_request(arg_0)
	})
	rt.register_func('rest_get_server', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_server()
	})
	rt.register_func('rest_ensure_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_ensure_request(arg_0)
	})
	rt.register_func('rest_ensure_response', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_ensure_response(arg_0)
	})
	rt.register_func('rest_handle_deprecated_function', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_deprecated_function(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_handle_deprecated_argument', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_deprecated_argument(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_handle_doing_it_wrong', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_doing_it_wrong(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_send_cors_headers', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_send_cors_headers(arg_0)
	})
	rt.register_func('rest_handle_options_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_options_request(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_send_allow_header', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_send_allow_header(arg_0, arg_1, arg_2)
	})
	rt.register_func('_rest_array_intersect_key_recursive', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _rest_array_intersect_key_recursive(arg_0, arg_1)
	})
	rt.register_func('rest_filter_response_fields', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_filter_response_fields(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_is_field_included', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_is_field_included(arg_0, arg_1))
	})
	rt.register_func('rest_output_rsd', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_output_rsd()
	})
	rt.register_func('rest_output_link_wp_head', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_output_link_wp_head()
	})
	rt.register_func('rest_output_link_header', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_output_link_header()
	})
	rt.register_func('rest_cookie_check_errors', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_cookie_check_errors(arg_0))
	})
	rt.register_func('rest_cookie_collect_status', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_cookie_collect_status()
	})
	rt.register_func('rest_application_password_collect_status', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_application_password_collect_status(arg_0, arg_1)
	})
	rt.register_func('rest_get_authenticated_app_password', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_authenticated_app_password()
	})
	rt.register_func('rest_application_password_check_errors', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_application_password_check_errors(arg_0))
	})
	rt.register_func('rest_add_application_passwords_to_index', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_add_application_passwords_to_index(arg_0)
	})
	rt.register_func('rest_get_avatar_urls', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_get_avatar_urls(arg_0)
	})
	rt.register_func('rest_get_avatar_sizes', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_avatar_sizes()
	})
	rt.register_func('rest_parse_date', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(rest_parse_date(arg_0, arg_1))
	})
	rt.register_func('rest_parse_hex_color', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_parse_hex_color(arg_0))
	})
	rt.register_func('rest_get_date_with_gmt', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rest_get_date_with_gmt(arg_0, arg_1)
	})
	rt.register_func('rest_authorization_required_code', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(rest_authorization_required_code())
	})
	rt.register_func('rest_validate_request_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_request_arg(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_sanitize_request_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_sanitize_request_arg(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_parse_request_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_parse_request_arg(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_is_ip_address', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_ip_address(arg_0))
	})
	rt.register_func('rest_sanitize_boolean', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_sanitize_boolean(arg_0))
	})
	rt.register_func('rest_is_boolean', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_boolean(arg_0))
	})
	rt.register_func('rest_is_integer', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_integer(arg_0))
	})
	rt.register_func('rest_is_array', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_is_array(arg_0)
	})
	rt.register_func('rest_sanitize_array', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_sanitize_array(arg_0)
	})
	rt.register_func('rest_is_object', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_object(arg_0))
	})
	rt.register_func('rest_sanitize_object', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_sanitize_object(arg_0)
	})
	rt.register_func('rest_get_best_type_for_value', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(rest_get_best_type_for_value(arg_0, arg_1))
	})
	rt.register_func('rest_handle_multi_type_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_string(rest_handle_multi_type_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_array_contains_unique_items', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_validate_array_contains_unique_items(arg_0))
	})
	rt.register_func('rest_stabilize_value', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_stabilize_value(arg_0)
	})
	rt.register_func('rest_validate_json_schema_pattern', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_validate_json_schema_pattern(arg_0, arg_1)
	})
	rt.register_func('rest_find_matching_pattern_property_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_find_matching_pattern_property_schema(arg_0, arg_1)
	})
	rt.register_func('rest_format_combining_operation_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_format_combining_operation_error(arg_0, arg_1)
	})
	rt.register_func('rest_get_combining_operation_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_get_combining_operation_error(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_find_any_matching_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_find_any_matching_schema(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_find_one_matching_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rest_find_one_matching_schema(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('rest_are_values_equal', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_are_values_equal(arg_0, arg_1))
	})
	rt.register_func('rest_validate_enum', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_enum(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_get_allowed_schema_keywords', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_allowed_schema_keywords()
	})
	rt.register_func('rest_validate_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_bool(rest_validate_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_null_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_validate_null_value_from_schema(arg_0, arg_1))
	})
	rt.register_func('rest_validate_boolean_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_validate_boolean_value_from_schema(arg_0, arg_1))
	})
	rt.register_func('rest_validate_object_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_object_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_array_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_array_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_number_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_number_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_string_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_string_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_integer_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_integer_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_sanitize_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rest_sanitize_value_from_schema(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_preload_api_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_preload_api_request(arg_0, arg_1)
	})
	rt.register_func('rest_parse_embed_param', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_parse_embed_param(arg_0))
	})
	rt.register_func('rest_filter_response_by_context', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_filter_response_by_context(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_default_additional_properties_to_false', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_default_additional_properties_to_false(arg_0)
	})
	rt.register_func('rest_get_route_for_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_post(arg_0))
	})
	rt.register_func('rest_get_route_for_post_type_items', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_post_type_items(arg_0))
	})
	rt.register_func('rest_get_route_for_term', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_term(arg_0))
	})
	rt.register_func('rest_get_route_for_taxonomy_items', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_taxonomy_items(arg_0))
	})
	rt.register_func('rest_get_queried_resource_route', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_queried_resource_route()
	})
	rt.register_func('rest_get_endpoint_args_for_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_get_endpoint_args_for_schema(arg_0, arg_1)
	})
	rt.register_func('rest_convert_error_to_response', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_convert_error_to_response(arg_0)
	})
	rt.register_func('wp_is_rest_endpoint', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_is_rest_endpoint())
	})
	rt.register_class_factory('WP_REST_Post_Types_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_types_controller()
		return rt.new_object('WP_REST_Post_Types_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Post_Statuses_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_statuses_controller()
		return rt.new_object('WP_REST_Post_Statuses_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Taxonomies_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_taxonomies_controller()
		return rt.new_object('WP_REST_Taxonomies_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Users_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_users_controller()
		return rt.new_object('WP_REST_Users_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Application_Passwords_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_application_passwords_controller()
		return rt.new_object('WP_REST_Application_Passwords_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Comments_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_comments_controller()
		return rt.new_object('WP_REST_Comments_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Post_Search_Handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_search_handler()
		return rt.new_object('WP_REST_Post_Search_Handler', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Term_Search_Handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_term_search_handler()
		return rt.new_object('WP_REST_Term_Search_Handler', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Post_Format_Search_Handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_format_search_handler()
		return rt.new_object('WP_REST_Post_Format_Search_Handler', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Search_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_search_controller()
		return rt.new_object('WP_REST_Search_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Block_Renderer_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_block_renderer_controller()
		return rt.new_object('WP_REST_Block_Renderer_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Block_Types_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_block_types_controller()
		return rt.new_object('WP_REST_Block_Types_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Settings_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_settings_controller()
		return rt.new_object('WP_REST_Settings_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Themes_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_themes_controller()
		return rt.new_object('WP_REST_Themes_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Plugins_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_plugins_controller()
		return rt.new_object('WP_REST_Plugins_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Sidebars_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_sidebars_controller()
		return rt.new_object('WP_REST_Sidebars_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Widget_Types_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_widget_types_controller()
		return rt.new_object('WP_REST_Widget_Types_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Widgets_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_widgets_controller()
		return rt.new_object('WP_REST_Widgets_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Block_Directory_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_block_directory_controller()
		return rt.new_object('WP_REST_Block_Directory_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Pattern_Directory_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_pattern_directory_controller()
		return rt.new_object('WP_REST_Pattern_Directory_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Block_Patterns_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_block_patterns_controller()
		return rt.new_object('WP_REST_Block_Patterns_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Block_Pattern_Categories_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_block_pattern_categories_controller()
		return rt.new_object('WP_REST_Block_Pattern_Categories_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_Site_Health', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_site_health()
		return rt.new_object('WP_Site_Health', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Site_Health_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_site_health_controller()
		return rt.new_object('WP_REST_Site_Health_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_URL_Details_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_url_details_controller()
		return rt.new_object('WP_REST_URL_Details_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Menu_Locations_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_menu_locations_controller()
		return rt.new_object('WP_REST_Menu_Locations_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Edit_Site_Export_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_edit_site_export_controller()
		return rt.new_object('WP_REST_Edit_Site_Export_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Navigation_Fallback_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_navigation_fallback_controller()
		return rt.new_object('WP_REST_Navigation_Fallback_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Font_Collections_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_font_collections_controller()
		return rt.new_object('WP_REST_Font_Collections_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Abilities_V1_Categories_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_abilities_v1_categories_controller()
		return rt.new_object('WP_REST_Abilities_V1_Categories_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Abilities_V1_Run_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_abilities_v1_run_controller()
		return rt.new_object('WP_REST_Abilities_V1_Run_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Abilities_V1_List_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_abilities_v1_list_controller()
		return rt.new_object('WP_REST_Abilities_V1_List_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Icons_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_icons_controller()
		return rt.new_object('WP_REST_Icons_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Request', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_request()
		return rt.new_object('WP_REST_Request', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Response', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_response()
		return rt.new_object('WP_REST_Response', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Ipv6', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_ipv6()
		return rt.new_object('WpOrg_Requests_Ipv6', []string{}, obj)
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
