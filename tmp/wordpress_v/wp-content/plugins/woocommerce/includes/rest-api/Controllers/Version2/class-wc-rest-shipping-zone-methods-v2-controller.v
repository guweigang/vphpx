import rt

struct Class_WC_REST_Shipping_Zone_Methods_V2_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'rest_base')).str() + '/(?P<zone_id>[\\d]+)/methods', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'zone_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique ID for the zone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'method_id', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method ID.'), rt.new_string('woocommerce')]) }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'rest_base')).str() + '/(?P<zone_id>[\\d]+)/methods/(?P<instance_id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'zone_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique ID for the zone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'instance_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique ID for the instance.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'delete_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := this.get_zone(var_request.array_get('zone_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	mut var_instance_id := // unsupported expression: Expr_Cast_Int
	mut var_methods := rt.call_method(var_zone, 'get_shipping_methods', []rt.PhpVal{})
	mut var_method := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method_obj := item_1.val
			if rt.is_true(rt.identical(var_instance_id, rt.get_property(var_method_obj, 'instance_id'))) {
				var_method = var_method_obj
				break
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_method)) {
		return create_wp_error(rt.new_string('woocommerce_rest_shipping_zone_method_invalid'), rt.call_function('__', [rt.new_string('Resource does not exist.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_data := this.prepare_item_for_response(var_method.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := this.get_zone(var_request.array_get('zone_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	mut var_methods := rt.call_method(var_zone, 'get_shipping_methods', []rt.PhpVal{})
	mut var_data := rt.new_array()
	{
		mut iter_1 := var_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method_obj := item_1.val
			mut var_method := this.prepare_item_for_response(var_method_obj.dup(), var_request.dup())
			var_data.array_push(var_method.dup())
		}
	}
	mut var_total := rt.new_int(rt.new_int(var_data.dup().array_count()))
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), if rt.is_true(var_total) { rt.new_int(1) } else { rt.new_int(0) }])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_method_id := var_request.array_get('method_id')
	mut var_zone := this.get_zone(var_request.array_get('zone_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	mut var_instance_id := rt.call_method(var_zone, 'add_shipping_method', [var_method_id.dup()])
	mut var_methods := rt.call_method(var_zone, 'get_shipping_methods', []rt.PhpVal{})
	mut var_method := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method_obj := item_1.val
			if rt.is_true(rt.identical(var_instance_id, rt.get_property(var_method_obj, 'instance_id'))) {
				var_method = var_method_obj
				break
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_method)) {
		return create_wp_error(rt.new_string('woocommerce_rest_shipping_zone_not_created'), rt.call_function('__', [rt.new_string('Resource cannot be created.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	var_method = this.update_fields(var_instance_id.dup(), var_method.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_method.dup()])) {
		return var_method.dup()
	}
	mut var_data := this.prepare_item_for_response(var_method.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := this.get_zone(var_request.array_get('zone_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	mut var_instance_id := // unsupported expression: Expr_Cast_Int
	mut var_force := var_request.array_get('force')
	mut var_methods := rt.call_method(var_zone, 'get_shipping_methods', []rt.PhpVal{})
	mut var_method := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method_obj := item_1.val
			if rt.is_true(rt.identical(var_instance_id, rt.get_property(var_method_obj, 'instance_id'))) {
				var_method = var_method_obj
				break
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_method)) {
		return create_wp_error(rt.new_string('woocommerce_rest_shipping_zone_method_invalid'), rt.call_function('__', [rt.new_string('Resource does not exist.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	var_method = this.update_fields(var_instance_id.dup(), var_method.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_method.dup()])) {
		return var_method.dup()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('view')])
	mut var_response := this.prepare_item_for_response(var_method.dup(), var_request.dup())
	if rt.is_true(var_force) {
		rt.call_method(var_zone, 'delete_shipping_method', [var_instance_id.dup()])
	} else {
		return create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('__', [rt.new_string('Shipping methods do not support trashing.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_delete_shipping_zone_method'), var_method.dup(), var_zone.dup(), var_response.dup(), var_request.dup()])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := this.get_zone(var_request.array_get('zone_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	mut var_instance_id := // unsupported expression: Expr_Cast_Int
	mut var_methods := rt.call_method(var_zone, 'get_shipping_methods', []rt.PhpVal{})
	mut var_method := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method_obj := item_1.val
			if rt.is_true(rt.identical(var_instance_id, rt.get_property(var_method_obj, 'instance_id'))) {
				var_method = var_method_obj
				break
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_method)) {
		return create_wp_error(rt.new_string('woocommerce_rest_shipping_zone_method_invalid'), rt.call_function('__', [rt.new_string('Resource does not exist.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	var_method = this.update_fields(var_instance_id.dup(), var_method.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_method.dup()])) {
		return var_method.dup()
	}
	mut var_data := this.prepare_item_for_response(var_method.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) update_fields(var_instance_id rt.PhpVal, var_method rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_instance_id_mutated := var_instance_id
	mut var_method_mutated := var_method
	// unsupported statement: Stmt_Global
	if var_request.array_isset(rt.new_string('settings')) {
		rt.call_method(var_method_mutated, 'init_instance_settings', []rt.PhpVal{})
		mut var_instance_settings := rt.get_property(var_method_mutated, 'instance_settings')
		mut var_errors_found := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := rt.call_method(var_method_mutated, 'get_instance_form_fields', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				mut var_key := item_1.key
				if var_request.array_get('settings').array_isset(var_key) {
					if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'validate_setting_' + (var_field.array_get('type')).str() + '_field' }])])) {
						mut var_value := rt.call_method(rt.new_object('WC_REST_Shipping_Zone_Methods_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'validate_setting_' + (var_field.array_get('type')).str() + '_field', [var_request.array_get('settings').array_get(var_key), var_field.dup()])
					} else {
						var_value = this.validate_setting_text_field(var_request.array_get('settings').array_get(var_key), var_field.dup())
					}
					if rt.is_true(rt.call_function('is_wp_error', [var_value.dup()])) {
						var_errors_found = rt.new_bool(rt.new_bool(true))
						break
					}
					var_instance_settings.array_set(var_key, var_value.dup())
				}
			}
		}
		if rt.is_true(var_errors_found) {
			return create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [rt.new_string('An invalid setting value was passed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		rt.call_function('update_option', [rt.call_method(var_method_mutated, 'get_instance_option_key', []rt.PhpVal{}), rt.call_function('apply_filters', ['woocommerce_shipping_' + (rt.get_property(var_method_mutated, 'id')).str() + '_instance_settings_values', var_instance_settings.dup(), var_method_mutated.dup()])])
	}
	if var_request.array_isset(rt.new_string('order')) {
		rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_methods')), rt.create_array([rt.ArrayItem{ key: 'method_order', val: rt.call_function('absint', [var_request.array_get('order')]) }]), rt.create_array([rt.ArrayItem{ key: 'instance_id', val: rt.call_function('absint', [var_instance_id_mutated.dup()]) }])])
		rt.set_property(var_method_mutated, 'method_order', rt.call_function('absint', [var_request.array_get('order')]))
	}
	if var_request.array_isset(rt.new_string('enabled')) {
		if rt.is_true(rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_methods')), rt.create_array([rt.ArrayItem{ key: 'is_enabled', val: var_request.array_get('enabled') }]), rt.create_array([rt.ArrayItem{ key: 'instance_id', val: rt.call_function('absint', [var_instance_id_mutated.dup()]) }])])) {
			rt.call_function('do_action', [rt.new_string('woocommerce_shipping_zone_method_status_toggled'), var_instance_id_mutated.dup(), rt.get_property(var_method_mutated, 'id'), var_request.array_get('zone_id'), var_request.array_get('enabled')])
			rt.set_property(var_method_mutated, 'enabled', if rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get('enabled'))) { rt.new_string('yes') } else { rt.new_string('no') })
		}
	}
	return var_method_mutated.dup()
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_method := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_item, 'instance_id') }, rt.ArrayItem{ key: 'instance_id', val: rt.get_property(var_item, 'instance_id') }, rt.ArrayItem{ key: 'title', val: if !(rt.get_property(var_item, 'instance_settings').array_get('title')).is_null() { rt.get_property(var_item, 'instance_settings').array_get('title') } else { rt.get_property(var_item, 'method_title') } }, rt.ArrayItem{ key: 'order', val: rt.get_property(var_item, 'method_order') }, rt.ArrayItem{ key: 'enabled', val: rt.identical(rt.new_string('yes'), rt.get_property(var_item, 'enabled')) }, rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_item, 'id') }, rt.ArrayItem{ key: 'method_title', val: rt.get_property(var_item, 'method_title') }, rt.ArrayItem{ key: 'method_description', val: rt.get_property(var_item, 'method_description') }, rt.ArrayItem{ key: 'settings', val: this.get_settings(var_item.dup()) }])
	mut var_context := if !rt.is_true(var_request.array_get('context')) { rt.new_string('view') } else { var_request.array_get('context') }
	mut var_data := this.add_additional_fields_to_object(var_method.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_request.array_get('zone_id'), rt.get_property(var_item, 'instance_id'))])
	var_response = this.prepare_response_for_collection(var_response.dup())
	return var_response.dup()
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) get_settings(var_item rt.PhpVal) rt.PhpVal {
	rt.call_method(var_item, 'init_instance_settings', []rt.PhpVal{})
	mut var_settings := 
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_id := item_1.key
		}
	}
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) prepare_links(var_zone_id rt.PhpVal, var_instance_id rt.PhpVal) rt.PhpVal {
	mut var_instance_id_mutated := var_instance_id
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) get_item_schema() rt.PhpVal {
}

struct Class_WC_REST_Shipping_Zones_Controller_Base {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_shipping_zone_methods_v2_controller() &Class_WC_REST_Shipping_Zone_Methods_V2_Controller {
	mut obj := &Class_WC_REST_Shipping_Zone_Methods_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_shipping_zones_controller_base() &Class_WC_REST_Shipping_Zones_Controller_Base {
	mut obj := &Class_WC_REST_Shipping_Zones_Controller_Base{
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

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'update_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_settings(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Shipping_Zone_Methods_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Shipping_Zone_Methods_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_Shipping_Zones_Controller_Base) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Shipping_Zones_Controller_Base) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Shipping_Zones_Controller_Base) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_shipping_zone_methods_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
