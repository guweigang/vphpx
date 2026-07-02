import rt

struct Class_WC_REST_Data_Currencies_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		rest_base rt.PhpVal = rt.new_string('data/currencies')
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) construct() {
	this.initialize_rest_api_cache()
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str()), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/current'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_current_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<currency>[\\w-]{3})'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ISO4217 currency code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Currencies_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_currency(var_code rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_code_mutated := var_code
	mut var_currencies := rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})
	mut var_data := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_currencies.clone().array_isset(var_code_mutated.clone())))))) {
		return rt.new_bool(false)
	}
	mut var_currency := rt.create_array([rt.ArrayItem{ key: 'code', val: var_code_mutated }, rt.ArrayItem{ key: 'name', val: var_currencies.array_get(var_code_mutated) }, rt.ArrayItem{ key: 'symbol', val: rt.call_function('get_woocommerce_currency_symbol', [var_code_mutated.clone()]) }])
	return var_currency.clone()
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_currencies := rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})
	mut var_data := rt.new_array()
	mut iter_1 := rt.func_array_keys(var_currencies.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_code := item_1.val
		mut var_currency := this.get_currency(var_code.clone(), var_request.clone())
		mut var_response := this.prepare_item_for_response(var_currency.clone(), var_request.clone())
		var_data.array_push(this.prepare_response_for_collection(var_response.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.get_currency(rt.new_string((var_request.array_get(rt.new_string('currency')).to_string().to_upper()).str()), var_request.clone())
	if !rt.is_true(var_data) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_data_invalid_currency'), rt.call_function('__', [rt.new_string('There are no currencies matching these parameters.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.prepare_item_for_response(var_data.clone(), var_request.clone())
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_currency := rt.call_function('get_option', [rt.new_string('woocommerce_currency')])
	return this.prepare_item_for_response(this.get_currency(var_currency.clone(), var_request.clone()), var_request.clone())
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.add_additional_fields_to_object(var_item.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), rt.new_string('view'))
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_item.clone())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_data_currency'), var_response.clone(), var_item.clone(), var_request.clone()])
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) prepare_links(var_item rt.PhpVal) rt.PhpVal {
	mut var_code := rt.new_string(var_item.array_get(rt.new_string('code')).to_string().to_upper())
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), this.namespace, this.rest_base, var_code.clone()])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])]) } }
	return var_links.clone()
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('data_currencies'), 'type': rt.new_string('object'), 'properties': { 'code': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('ISO4217 currency code.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Full name of currency.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'symbol': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Currency symbol.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_default_response_entity_type() string {
	return 'currency'
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_files_relevant_to_response_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'i18n/currencies.php' }])
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) get_hooks_relevant_to_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_rest_prepare_data_currency' }, rt.ArrayItem{ key: none, val: 'woocommerce_currencies' }])
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) response_cache_vary_by_user(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) bool {
	return false
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) extract_entity_ids_from_response(mut var_response_data Class_array, mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	return rt.new_array()
}

struct Class_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_data_currencies_controller() &Class_WC_REST_Data_Currencies_Controller {
	mut obj := &Class_WC_REST_Data_Currencies_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('data/currencies')
	}
	obj.construct()
	return obj
}

fn create_wc_rest_data_controller(_args ...rt.PhpVal) &Class_WC_REST_Data_Controller {
	mut obj := &Class_WC_REST_Data_Controller{
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

fn (mut this Class_WC_REST_Data_Currencies_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_currency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_currency(dispatch_arg_0, dispatch_arg_1)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_current_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_current_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_default_response_entity_type' {
			return rt.new_string(this.get_default_response_entity_type())
		}
		'get_files_relevant_to_response_caching' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_files_relevant_to_response_caching(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_hooks_relevant_to_caching' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_hooks_relevant_to_caching(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'response_cache_vary_by_user' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.response_cache_vary_by_user(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'extract_entity_ids_from_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.extract_entity_ids_from_response(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Data_Currencies_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Data_Currencies_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
