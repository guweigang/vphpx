import rt

struct Class_WC_REST_Data_Continents_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		rest_base rt.PhpVal = rt.new_string('data/continents')
}

fn (mut this Class_WC_REST_Data_Continents_Controller) construct()  {
	this.initialize_rest_api_cache()
}

fn (mut this Class_WC_REST_Data_Continents_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Continents_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Continents_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Continents_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<location>[\\w-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Continents_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Continents_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'continent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('2 character continent code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Data_Continents_Controller', ['WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Data_Continents_Controller) get_continent(var_continent_code rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_continent_code_mutated := var_continent_code
	mut var_continents := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_continents', []rt.PhpVal{})
	mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})
	mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_states', []rt.PhpVal{})
	mut var_locale_info := rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/locale-info.php', '1')
	mut var_data := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_continents.dup().array_isset(var_continent_code_mutated.dup())))))) {
		return rt.new_bool(false)
	}
	mut var_continent_list := var_continents.array_get(var_continent_code_mutated)
	mut var_continent := rt.create_array([rt.ArrayItem{ key: 'code', val: var_continent_code_mutated }, rt.ArrayItem{ key: 'name', val: var_continent_list.array_get('name') }])
	mut var_local_countries := rt.new_array()
	{
		mut iter_1 := var_continent_list.array_get('countries').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_country_code := item_1.val
			if var_countries.array_isset(var_country_code) {
				mut var_country := rt.create_array([rt.ArrayItem{ key: 'code', val: var_country_code }, rt.ArrayItem{ key: 'name', val: var_countries.array_get(var_country_code) }])
				if rt.is_true(rt.new_bool(var_locale_info.dup().array_isset(var_country_code.dup()))) {
					mut var_country_data := rt.call_function('wp_parse_args', [var_locale_info.array_get(var_country_code), rt.create_array([rt.ArrayItem{ key: 'currency_code', val: 'USD' }, rt.ArrayItem{ key: 'currency_pos', val: 'left' }, rt.ArrayItem{ key: 'decimal_sep', val: '.' }, rt.ArrayItem{ key: 'dimension_unit', val: 'in' }, rt.ArrayItem{ key: 'num_decimals', val: 2 }, rt.ArrayItem{ key: 'thousand_sep', val: ',' }, rt.ArrayItem{ key: 'weight_unit', val: 'lbs' }])])
					var_country = rt.call_function('array_merge', [var_country.dup(), var_country_data.dup()])
				}
				mut var_local_states := rt.new_array()
				if var_states.array_isset(var_country_code) {
					{
						mut iter_2 := var_states.array_get(var_country_code).iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_state_name := item_2.val
							mut var_state_code := item_2.key
							var_local_states << rt.create_array([rt.ArrayItem{ key: 'code', val: var_state_code }, rt.ArrayItem{ key: 'name', val: var_state_name }])
						}
					}
				}
				var_country.array_set('states', var_local_states.dup())
				mut var_allowed := ['code', 'currency_code', 'currency_pos', 'decimal_sep', 'dimension_unit', 'name', 'num_decimals', 'states', 'thousand_sep', 'weight_unit']
				var_country = rt.call_function('array_intersect_key', [var_country.dup(), rt.call_function('array_flip', [var_allowed.dup()])])
				var_local_countries << var_country.dup()
			}
		}
	}
	var_continent.array_set('countries', var_local_countries.dup())
	return var_continent.dup()
}

fn (mut this Class_WC_REST_Data_Continents_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_continents := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_continents', []rt.PhpVal{})
	mut var_data := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_continents.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_continent_code := item_1.val
			mut var_continent := this.get_continent(var_continent_code.dup(), var_request.dup())
			mut var_response := this.prepare_item_for_response(var_continent.dup(), var_request.dup())
			var_data.array_push(this.prepare_response_for_collection(var_response.dup()))
		}
	}
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WC_REST_Data_Continents_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.get_continent(rt.new_string(var_request.array_get('location').to_string().to_upper()), var_request.dup())
	if !rt.is_true(var_data) {
		return create_wp_error(rt.new_string('woocommerce_rest_data_invalid_location'), rt.call_function('__', [rt.new_string('There are no locations matching these parameters.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return this.prepare_item_for_response(var_data.dup(), var_request.dup())
}

fn (mut this Class_WC_REST_Data_Continents_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.add_additional_fields_to_object(var_item.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), rt.new_string('view'))
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_item.dup())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_data_continent'), var_response.dup(), var_item.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Data_Continents_Controller) prepare_links(var_item rt.PhpVal) rt.PhpVal {
	mut var_continent_code := rt.new_string(rt.new_string(var_item.array_get('code').to_string().to_lower()))
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), this.namespace, this.rest_base, var_continent_code.dup()])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])]) } }
	return var_links.dup()
}

fn (mut this Class_WC_REST_Data_Continents_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('data_continents'), 'type': rt.new_string('object'), 'properties': { 'code': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('2 character continent code.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Full name of continent.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'countries': { 'type': rt.new_string('array'), 'description': rt.call_function('__', [rt.new_string('List of countries on this continent.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'code': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('ISO3166 alpha-2 country code.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'currency_code': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Default ISO4127 alpha-3 currency code for the country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'currency_pos': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Currency symbol position for this country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'decimal_sep': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Decimal separator for displayed prices for this country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'dimension_unit': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('The unit lengths are defined in for this country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Full name of country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'num_decimals': { 'type': rt.new_string('integer'), 'description': rt.call_function('__', [rt.new_string('Number of decimal points shown in displayed prices for this country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'states': { 'type': rt.new_string('array'), 'description': rt.call_function('__', [rt.new_string('List of states in this country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'code': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('State code.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Full name of state.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'thousand_sep': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('Thousands separator for displayed prices in this country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'weight_unit': { 'type': rt.new_string('string'), 'description': rt.call_function('__', [rt.new_string('The unit weights are defined in for this country.'), rt.new_string('woocommerce')]), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_WC_REST_Data_Continents_Controller) get_default_response_entity_type() string {
	return 'continent'
}

fn (mut this Class_WC_REST_Data_Continents_Controller) get_files_relevant_to_response_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'i18n/continents.php' }, rt.ArrayItem{ key: none, val: 'i18n/countries.php' }, rt.ArrayItem{ key: none, val: 'i18n/states.php' }, rt.ArrayItem{ key: none, val: 'i18n/locale-info.php' }])
}

fn (mut this Class_WC_REST_Data_Continents_Controller) get_hooks_relevant_to_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_continents' }, rt.ArrayItem{ key: none, val: 'woocommerce_countries' }, rt.ArrayItem{ key: none, val: 'woocommerce_states' }, rt.ArrayItem{ key: none, val: 'woocommerce_rest_prepare_data_continent' }])
}

fn (mut this Class_WC_REST_Data_Continents_Controller) response_cache_vary_by_user(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) bool {
	return false
}

fn (mut this Class_WC_REST_Data_Continents_Controller) extract_entity_ids_from_response(mut var_response_data Class_array, mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	return rt.new_array()
}

struct Class_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_data_continents_controller() &Class_WC_REST_Data_Continents_Controller {
	mut obj := &Class_WC_REST_Data_Continents_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('data/continents')
	}
	obj.construct()
	return obj
}

fn create_wc_rest_data_controller() &Class_WC_REST_Data_Controller {
	mut obj := &Class_WC_REST_Data_Controller{
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

fn (mut this Class_WC_REST_Data_Continents_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_continent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_continent(dispatch_arg_0, dispatch_arg_1)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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

fn (this &Class_WC_REST_Data_Continents_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Data_Continents_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_data_continents_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
