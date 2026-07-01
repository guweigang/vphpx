import rt

struct Class_WC_REST_Taxes_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Taxes_Controller) add_tax_rate_locales(var_data rt.PhpVal, var_tax rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	var_data_mutated = this.Class_WC_REST_Taxes_V2_Controller.add_tax_rate_locales(var_data_mutated.dup(), var_tax.dup())
	var_data_mutated.array_set('postcodes', rt.new_array())
	var_data_mutated.array_set('cities', rt.new_array())
	mut var_locales := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT location_code, location_type\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rate_locations\n\t\t\t\tWHERE tax_rate_id = %d\n\t\t\t\t')), rt.get_property(var_tax, 'tax_rate_id')])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_tax.dup()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_tax.dup().is_null()))))))) {
		{
			mut iter_1 := var_locales.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_locale := item_1.val
				if rt.is_true(rt.identical(rt.new_string('postcode'), rt.get_property(var_locale, 'location_type'))) {
					var_data_mutated.array_get_mut('postcodes').array_push(rt.get_property(var_locale, 'location_code'))
				} else if rt.is_true(rt.identical(rt.new_string('city'), rt.get_property(var_locale, 'location_type'))) {
					var_data_mutated.array_get_mut('cities').array_push(rt.get_property(var_locale, 'location_code'))
				}
			}
		}
	}
	return var_data_mutated.dup()
}

fn (mut this Class_WC_REST_Taxes_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WC_REST_Taxes_V2_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_set('postcodes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of postcodes / ZIPs. Introduced in WooCommerce 5.3.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
	var_schema.array_get_mut('properties').array_set('cities', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of city names. Introduced in WooCommerce 5.3.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
	var_schema.array_get_mut('properties').array_get_mut('postcode').array_set('description', rt.call_function('__', [rt.new_string('Postcode/ZIP, it doesn\'t support multiple values. Deprecated as of WooCommerce 5.3, \'postcodes\' should be used instead.'), rt.new_string('woocommerce')]))
	var_schema.array_get_mut('properties').array_get_mut('city').array_set('description', rt.call_function('__', [rt.new_string('City name, it doesn\'t support multiple values. Deprecated as of WooCommerce 5.3, \'cities\' should be used instead.'), rt.new_string('woocommerce')]))
	return var_schema.dup()
}

fn (mut this Class_WC_REST_Taxes_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	this.adjust_cities_and_postcodes(var_request_mutated.dup())
	return this.Class_WC_REST_Taxes_V2_Controller.create_item(var_request_mutated.dup())
}

fn (mut this Class_WC_REST_Taxes_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	this.adjust_cities_and_postcodes(var_request_mutated.dup())
	return this.Class_WC_REST_Taxes_V2_Controller.update_item(var_request_mutated.dup())
}

fn (mut this Class_WC_REST_Taxes_Controller) adjust_cities_and_postcodes(var_request rt.PhpVal)  {
	mut var_request_mutated := var_request
	if var_request_mutated.array_isset(rt.new_string('cities')) {
		var_request_mutated.array_set('city', rt.call_function('join', [rt.new_string(';'), var_request_mutated.array_get('cities')]))
	}
	if var_request_mutated.array_isset(rt.new_string('postcodes')) {
		var_request_mutated.array_set('postcode', rt.call_function('join', [rt.new_string(';'), var_request_mutated.array_get('postcodes')]))
	}
}

struct Class_WC_REST_Taxes_V2_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_taxes_controller() &Class_WC_REST_Taxes_Controller {
	mut obj := &Class_WC_REST_Taxes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_taxes_v2_controller() &Class_WC_REST_Taxes_V2_Controller {
	mut obj := &Class_WC_REST_Taxes_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Taxes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_tax_rate_locales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_tax_rate_locales(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'adjust_cities_and_postcodes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.adjust_cities_and_postcodes(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Taxes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Taxes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Taxes_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Taxes_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Taxes_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_taxes_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
