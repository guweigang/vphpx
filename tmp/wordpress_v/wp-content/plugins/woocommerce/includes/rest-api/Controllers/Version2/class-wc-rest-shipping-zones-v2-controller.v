import rt

struct Class_WC_REST_Shipping_Zones_V2_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'rest_base')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping zone name.'), rt.new_string('woocommerce')]) }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique ID for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'delete_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := this.get_zone(rt.call_method(var_request, 'get_param', [rt.new_string('id')]))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	mut var_data := rt.call_method(var_zone, 'get_data', []rt.PhpVal{})
	var_data = this.prepare_item_for_response(var_data.dup(), var_request.dup())
	var_data = this.prepare_response_for_collection(var_data.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_rest_of_the_world := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Shipping_Zones{}; return temp.get_zone_by(arg_0, arg_1) }(rt.new_string('zone_id'), rt.new_int(0))
	mut var_zones := fn () rt.PhpVal { mut temp := Class_WC_Shipping_Zones{}; return temp.get_zones() }()
	rt.call_function('array_unshift', [var_zones.dup(), rt.call_method(var_rest_of_the_world, 'get_data', []rt.PhpVal{})])
	mut var_data := rt.new_array()
	{
		mut iter_1 := var_zones.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_zone_obj := item_1.val
			mut var_zone := this.prepare_item_for_response(var_zone_obj.dup(), var_request.dup())
			var_zone = this.prepare_response_for_collection(var_zone.dup())
			var_data.array_push(var_zone.dup())
		}
	}
	mut var_total := rt.new_int(rt.new_int(var_data.dup().array_count()))
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), rt.new_int(1)])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := create_wc_shipping_zone(rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('name')]).is_null()))))) {
		rt.call_method(var_zone, 'set_zone_name', [rt.call_method(var_request, 'get_param', [rt.new_string('name')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('order')]).is_null()))))) {
		rt.call_method(var_zone, 'set_zone_order', [rt.call_method(var_request, 'get_param', [rt.new_string('order')])])
	}
	rt.call_method(var_zone, 'save', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_request, 'set_param', [rt.new_string('id'), rt.call_method(var_zone, 'get_id', []rt.PhpVal{})])
		mut var_response := this.get_item(var_request.dup())
		rt.call_method(var_response, 'set_status', [rt.new_int(201)])
		rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'namespace'), rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'rest_base'), rt.call_method(var_zone, 'get_id', []rt.PhpVal{})])])])
		return var_response.dup()
	} else {
		return create_wp_error(rt.new_string('woocommerce_rest_shipping_zone_not_created'), rt.call_function('__', [rt.new_string('Resource cannot be created. Check to make sure \'order\' and \'name\' are present.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	return rt.new_null()
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := this.get_zone(rt.call_method(var_request, 'get_param', [rt.new_string('id')]))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_zone, 'get_id', []rt.PhpVal{}))) {
		return create_wp_error(rt.new_string('woocommerce_rest_shipping_zone_invalid_zone'), rt.call_function('__', [rt.new_string('The "locations not covered by your other zones" zone cannot be updated.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))
	}
	mut var_zone_changed := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('name')]).is_null()))))) {
		rt.call_method(var_zone, 'set_zone_name', [rt.call_method(var_request, 'get_param', [rt.new_string('name')])])
		var_zone_changed = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('order')]).is_null()))))) {
		rt.call_method(var_zone, 'set_zone_order', [rt.call_method(var_request, 'get_param', [rt.new_string('order')])])
		var_zone_changed = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(var_zone_changed) {
		rt.call_method(var_zone, 'save', []rt.PhpVal{})
	}
	return this.get_item(var_request.dup())
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_zone := this.get_zone(rt.call_method(var_request, 'get_param', [rt.new_string('id')]))
	if rt.is_true(rt.call_function('is_wp_error', [var_zone.dup()])) {
		return var_zone.dup()
	}
	mut var_force := var_request.array_get('force')
	mut var_response := this.get_item(var_request.dup())
	if rt.is_true(var_force) {
		rt.call_method(var_zone, 'delete', []rt.PhpVal{})
	} else {
		return create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('__', [rt.new_string('Shipping zones do not support trashing.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'name', val: var_item.array_get('zone_name') }, rt.ArrayItem{ key: 'order', val: // unsupported expression: Expr_Cast_Int }])
	mut var_context := if !rt.is_true(var_request.array_get('context')) { rt.new_string('view') } else { var_request.array_get('context') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_data.array_get('id'))])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) prepare_links(var_zone_id rt.PhpVal) rt.PhpVal {
	mut var_base := rt.new_string('/' + (rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'namespace')).str() + '/' + (rt.get_property(rt.new_object('WC_REST_Shipping_Zones_V2_Controller', ['WC_REST_Shipping_Zones_Controller_Base'], &this), 'rest_base')).str())
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.concat(rt.call_function('trailingslashit', [var_base.dup()]), var_zone_id)]) }, 'collection': { 'href': rt.call_function('rest_url', [var_base.dup()]) }, 'describedby': { 'href': rt.call_function('rest_url', [(rt.call_function('trailingslashit', [var_base.dup()])).str() + (var_zone_id).str() + '/locations']) } }
	return var_links.dup()
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('shipping_zone'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('Shipping zone name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } }, 'order': { 'description': rt.call_function('__', [rt.new_string('Shipping zone order.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Shipping_Zones_Controller_Base {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_shipping_zones_v2_controller() &Class_WC_REST_Shipping_Zones_V2_Controller {
	mut obj := &Class_WC_REST_Shipping_Zones_V2_Controller{
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

fn create_wc_shipping_zones() &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zone() &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
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

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_WC_REST_Shipping_Zones_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Shipping_Zones_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_shipping_zones_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
