import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService) update_shipping_method_settings(var_method rt.PhpVal, var_settings rt.PhpVal) rt.PhpVal {
	mut var_method_mutated := var_method
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_settings.dup().is_array()))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_shipping_method_invalid_settings'), rt.call_function('__', [rt.new_string('Settings must be an array.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	rt.call_method(var_method_mutated, 'init_instance_settings', []rt.PhpVal{})
	mut var_instance_settings := rt.get_property(var_method_mutated, 'instance_settings')
	mut var_post_data := rt.new_array()
	{
		mut iter_1 := var_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_field_key := rt.call_method(var_method_mutated, 'get_field_key', [var_key.dup()])
			var_post_data.array_set(var_field_key, var_value.dup())
		}
	}
	mut var_form_fields := rt.call_method(var_method_mutated, 'get_instance_form_fields', []rt.PhpVal{})
	{
		mut iter_1 := var_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if var_form_fields.array_isset(var_key) {
				var_instance_settings.array_set(var_key, rt.call_method(var_method_mutated, 'get_field_value', [var_key.dup(), var_form_fields.array_get(var_key), var_post_data.dup()]))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				unsafe { goto end_label_1 }

catch_label_1:
				mut var_e_1 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Exception') {
					mut var_e := var_e_1.dup()
					return create_wp_error(rt.new_string('woocommerce_rest_shipping_method_invalid_setting'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
					unsafe { goto end_label_1 }
				}
				else {
					rt.throw_exception(var_e_1)
					unsafe { goto end_label_1 }
				}

end_label_1:
			}
		}
	}
	mut var_filtered_settings := rt.call_function('apply_filters', ['woocommerce_shipping_' + (rt.get_property(var_method_mutated, 'id')).str() + '_instance_settings_values', var_instance_settings.dup(), var_method_mutated.dup()])
	mut var_result := rt.call_function('update_option', [rt.call_method(var_method_mutated, 'get_instance_option_key', []rt.PhpVal{}), var_filtered_settings.dup()])
	if rt.is_true(var_result) {
		rt.set_property(var_method_mutated, 'instance_settings', var_instance_settings.dup())
	}
	return var_method_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService) update_shipping_zone_method(var_method rt.PhpVal, var_instance_id rt.PhpVal, var_data rt.PhpVal, var_zone_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_method_mutated := var_method
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'settings', val: rt.new_null() }, rt.ArrayItem{ key: 'enabled', val: rt.new_null() }, rt.ArrayItem{ key: 'order', val: rt.new_null() }])])
	mut var_updates := rt.new_array()
	mut var_formats := rt.new_array()
	mut var_enabled_changed := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.array_get('settings').is_null()))))) {
		mut var_result := this.update_shipping_method_settings(var_method_mutated.dup(), var_data_mutated.array_get('settings'))
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			return var_result.dup()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.array_get('enabled').is_null()))))) {
		var_updates.array_set('is_enabled', if rt.is_true(rt.call_function('wc_string_to_bool', [var_data_mutated.array_get('enabled')])) { 1 } else { 0 })
		var_formats.array_push('%d')
		rt.set_property(var_method_mutated, 'enabled', if rt.is_true(rt.call_function('wc_string_to_bool', [var_data_mutated.array_get('enabled')])) { rt.new_string('yes') } else { rt.new_string('no') })
		var_enabled_changed = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.array_get('order').is_null()))))) {
		var_updates.array_set('method_order', rt.call_function('absint', [var_data_mutated.array_get('order')]))
		var_formats.array_push('%d')
		rt.set_property(var_method_mutated, 'method_order', rt.call_function('absint', [var_data_mutated.array_get('order')]))
	}
	if !rt.is_true(var_updates) {
		return var_method_mutated.dup()
	}
	var_result = rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_methods')), var_updates.dup(), rt.create_array([rt.ArrayItem{ key: 'instance_id', val: var_instance_id }]), var_formats.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		return create_wp_error(rt.new_string('update_failed'), rt.call_function('__', [rt.new_string('Could not update shipping method.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_enabled_changed) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_shipping_zone_method_status_toggled'), var_instance_id.dup(), rt.get_property(var_method_mutated, 'id'), var_zone_id.dup(), // unsupported expression: Expr_Cast_Bool])
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('shipping'), rt.new_bool(true))
	return var_method_mutated.dup()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_shippingzonemethod_shippingzonemethodservice() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService{
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

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update_shipping_method_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_shipping_method_settings(dispatch_arg_0, dispatch_arg_1)
		}
		'update_shipping_zone_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.update_shipping_zone_method(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_ShippingZoneMethodService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_shippingzonemethod_shippingzonemethodservice_php() {
	// unsupported statement: Stmt_Declare
}
