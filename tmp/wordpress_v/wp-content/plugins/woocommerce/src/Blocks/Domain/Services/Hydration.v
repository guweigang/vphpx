import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration {
	rt.PhpObjectBase
pub mut:
		asset_data_registry rt.PhpVal = rt.new_null()
		cached_store_notices rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) construct(mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry)  {
	this.asset_data_registry = var_asset_data_registry.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) get_rest_api_response_data(path string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [rt.new_string(path), rt.new_string('/wc/store')]))))) {
		return rt.new_array()
	}
	mut var_available_routes := rt.call_method(rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_StoreApi{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_StoreApi_RoutesController.class()]), 'get_all_routes', [rt.new_string('v1'), rt.new_bool(true)])
	mut var_route_match := this.match_route_to_handler(rt.new_string(path), var_available_routes.dup())
	this.disable_nonce_check()
	this.cache_store_notices()
	mut var_preloaded_data := rt.new_array()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_response := rt.new_bool(this.get_response_from_controller(var_route_match.array_get('controller'), rt.new_string(path), var_route_match.array_get('url_params'), var_route_match.array_get('query_params')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(var_response) {
			var_preloaded_data = rt.create_array([rt.ArrayItem{ key: 'body', val: rt.call_method(var_response, 'get_data', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'headers', val: rt.call_method(var_response, 'get_headers', []rt.PhpVal{}) }])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blocks_Domain_Services_Exception') {
			mut var_e := var_e_1.dup()
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', ['Error in hydrating REST API request: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'blocks-hydration' }, rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'path', val: path }, rt.ArrayItem{ key: 'controller', val: if !(var_route_match.array_get('controller')).is_null() { var_route_match.array_get('controller') } else { rt.new_null() } }]) }, rt.ArrayItem{ key: 'backtrace', val: true }])])
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	} else {
		mut var_preloaded_requests := rt.call_function('rest_preload_api_request', [rt.new_array(), rt.new_string(path)])
		var_preloaded_data = if !(var_preloaded_requests.array_get(path)).is_null() { var_preloaded_requests.array_get(path) } else { rt.new_array() }
	}
	this.restore_cached_store_notices()
	this.restore_nonce_check()
	return var_preloaded_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) get_response_from_controller(var_controller_class rt.PhpVal, var_path rt.PhpVal, var_url_params rt.PhpVal, var_query_params rt.PhpVal) bool {
	mut var_url_params_mutated := var_url_params
	mut var_query_params_mutated := var_query_params
	if rt.is_true(rt.identical(rt.new_null(), var_controller_class)) {
		return false
	}
	mut var_request := create_automattic_woocommerce_blocks_domain_services_wp_rest_request(rt.new_string('GET'), var_path.dup())
	if !(!rt.is_true(var_url_params_mutated)) {
		var_request.set_url_params(var_url_params_mutated.dup())
	}
	if !(!rt.is_true(var_query_params_mutated)) {
		var_request.set_query_params(var_query_params_mutated.dup())
	}
	mut var_schema_controller := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_StoreApi{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_StoreApi_SchemaController.class()])
	mut var_controller := rt.create_object_dynamically(var_controller_class, [var_schema_controller.dup(), rt.call_method(var_schema_controller, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_{"nodeType":"Expr_Variable","line":134,"name":"controller_class"}.schema_type(), Class_Automattic_WooCommerce_Blocks_Domain_Services_{"nodeType":"Expr_Variable","line":134,"name":"controller_class"}.schema_version()])])
	mut var_controller_args := if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_controller }, rt.ArrayItem{ key: none, val: 'get_args' }])])) { rt.call_method(var_controller, 'get_args', []rt.PhpVal{}) } else { rt.new_array() }
	if !rt.is_true(var_controller_args) {
		return false
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_method_handler := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_method_handler.dup().is_array())) && var_method_handler.array_isset(rt.new_string('methods')))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Server.readable(), var_method_handler.array_get('methods')))
	}
	mut var_method_handler := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_method_handler.dup().is_array())) && var_method_handler.array_isset(rt.new_string('methods')))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Server.readable(), var_method_handler.array_get('methods')))
	}
	mut var_handler := rt.call_function('current', [rt.call_function('array_filter', [var_controller_args.dup(), rt.new_closure(closure_1_fn)])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_handler)))) {
		return false
	}
	mut var_hydration_result := rt.call_function('apply_filters', [rt.new_string('woocommerce_hydration_dispatch_request'), rt.new_null(), var_request, var_path.dup(), var_handler.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_response := var_hydration_result.dup()
	} else {
		var_response = rt.call_function('call_user_func_array', [var_handler.array_get('callback'), rt.create_array([rt.ArrayItem{ key: none, val: var_request }])])
	}
	var_response = rt.call_function('apply_filters', [rt.new_string('woocommerce_hydration_request_after_callbacks'), var_response.dup(), var_handler.dup(), var_request])
	return (var_response).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) match_route_to_handler(var_path rt.PhpVal, var_available_routes rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_available_routes_mutated := var_available_routes
	mut var_query_params := rt.new_array()
	mut var_parsed_url := rt.call_function('wp_parse_url', [var_path.dup()])
	mut var_clean_path := if !(var_parsed_url.array_get('path')).is_null() { var_parsed_url.array_get('path') } else { var_path }
	if var_parsed_url.array_isset(rt.new_string('query')) {
		rt.call_function('parse_str', [var_parsed_url.array_get('query'), var_query_params.dup()])
	}
	{
		mut iter_1 := var_available_routes_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_controller := item_1.val
			mut var_route_path := item_1.key
			if rt.is_true(rt.call_function('preg_match', ['@^' + (var_route_path).str() + '$@i', var_clean_path.dup(), var_matches.dup()])) {
				mut var_url_params := rt.call_function('array_intersect_key', [var_matches.dup(), rt.call_function('array_flip', [rt.call_function('array_filter', [rt.func_array_keys(var_matches.dup()), rt.new_string('is_string')])])])
				return rt.create_array([rt.ArrayItem{ key: 'controller', val: var_controller }, rt.ArrayItem{ key: 'url_params', val: var_url_params }, rt.ArrayItem{ key: 'query_params', val: var_query_params }])
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) disable_nonce_check()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_store_api_disable_nonce_check'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_Hydration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'disable_nonce_check_callback' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) disable_nonce_check_callback() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) restore_nonce_check()  {
	rt.call_function('remove_filter', [rt.new_string('woocommerce_store_api_disable_nonce_check'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_Hydration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'disable_nonce_check_callback' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) cache_store_notices()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) || rt.is_true(rt.identical(rt.new_null(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))))) {
		return rt.new_null()
	}
	this.cached_store_notices = rt.call_function('wc_get_notices', []rt.PhpVal{})
	rt.call_function('wc_clear_notices', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) restore_cached_store_notices()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) || rt.is_true(rt.identical(rt.new_null(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))))) {
		return rt.new_null()
	}
	rt.call_function('wc_set_notices', [this.cached_store_notices])
	this.cached_store_notices = rt.new_array()
}

struct Class_Automattic_WooCommerce_StoreApi_StoreApi {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_hydration(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration{
		PhpObjectBase: rt.PhpObjectBase{}
		asset_data_registry: rt.new_null()
		cached_store_notices: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_storeapi_storeapi() &Class_Automattic_WooCommerce_StoreApi_StoreApi {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_StoreApi{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_wp_rest_request() &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_rest_api_response_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rest_api_response_data(dispatch_arg_0)
		}
		'get_response_from_controller' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.get_response_from_controller(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'match_route_to_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.match_route_to_handler(dispatch_arg_0, dispatch_arg_1)
		}
		'disable_nonce_check' {
			this.disable_nonce_check()
			return rt.new_null()
		}
		'disable_nonce_check_callback' {
			return rt.new_bool(this.disable_nonce_check_callback())
		}
		'restore_nonce_check' {
			this.restore_nonce_check()
			return rt.new_null()
		}
		'cache_store_notices' {
			this.cache_store_notices()
			return rt.new_null()
		}
		'restore_cached_store_notices' {
			this.restore_cached_store_notices()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'asset_data_registry' { return this.asset_data_registry }
		'cached_store_notices' { return this.cached_store_notices }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'asset_data_registry' { this.asset_data_registry = val; return true }
		'cached_store_notices' { this.cached_store_notices = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Blocks_Domain_Services_Hydration', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_automattic_woocommerce_blocks_domain_services_hydration(c_arg_0)
		return rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_Hydration', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_StoreApi', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_storeapi_storeapi()
		return rt.new_object('Automattic_WooCommerce_StoreApi_StoreApi', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_domain_services_wp_rest_request()
		return rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_WP_REST_Request', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_hydration_php() {
}
