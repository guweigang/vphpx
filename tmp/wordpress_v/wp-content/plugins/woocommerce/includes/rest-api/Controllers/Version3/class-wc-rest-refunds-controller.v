import rt

struct Class_WC_REST_Refunds_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		rest_base rt.PhpVal = rt.new_string('refunds')
		post_type rt.PhpVal = rt.new_string('shop_order_refund')
}

fn (mut this Class_WC_REST_Refunds_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Refunds_Controller', ['WC_REST_Order_Refunds_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Refunds_Controller', ['WC_REST_Order_Refunds_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Refunds_Controller', ['WC_REST_Order_Refunds_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Refunds_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := this.Class_WC_REST_Order_Refunds_Controller.prepare_objects_query(var_request.dup())
	var_args.array_unset(rt.new_string('post_parent__in'))
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_refunds_prepare_object_query'), var_args.dup(), var_request.dup()])
	return var_args.dup()
}

fn (mut this Class_WC_REST_Refunds_Controller) prepare_object_for_response(var_refund rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	this.dispatch_set_prop('request', var_request.dup())
	rt.get_property(rt.new_object('WC_REST_Refunds_Controller', ['WC_REST_Order_Refunds_Controller'], &this), 'request').array_set('dp', if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_REST_Refunds_Controller', ['WC_REST_Order_Refunds_Controller'], &this), 'request').array_get('dp').is_null())) { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [rt.get_property(rt.new_object('WC_REST_Refunds_Controller', ['WC_REST_Order_Refunds_Controller'], &this), 'request').array_get('dp')]) })
	mut var_data := this.get_formatted_item_data(var_refund.dup())
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_refund.dup(), var_request.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), rt.new_string('_object')), var_response.dup(), var_refund.dup(), var_request.dup()])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_REST_Refunds_Controller) get_formatted_item_data(var_refund rt.PhpVal) rt.PhpVal {
	mut var_data := this.Class_WC_REST_Order_Refunds_Controller.get_formatted_item_data(var_refund.dup())
	var_data = rt.call_function('array_merge', [rt.call_function('array_slice', [var_data.dup(), rt.new_int(0), rt.new_int(1), rt.new_bool(true)]), rt.create_array([rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{}) }]), rt.call_function('array_slice', [var_data.dup(), rt.new_int(1), rt.new_null(), rt.new_bool(true)])])
	return var_data.dup()
}

fn (mut this Class_WC_REST_Refunds_Controller) prepare_links(var_refund rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_base := rt.call_function('str_replace', [rt.new_string('(?P<order_id>[\\d]+)'), rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{}), rt.new_string('orders/(?P<order_id>[\\d]+)/refunds')])
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, var_base.dup(), rt.call_method(var_refund, 'get_id', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, var_base.dup()])]) }, 'up': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), this.namespace, rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})])]) } }
	return var_links.dup()
}

fn (mut this Class_WC_REST_Refunds_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WC_REST_Order_Refunds_Controller.get_item_schema()
	var_schema.array_set('properties', rt.call_function('array_merge', [rt.call_function('array_slice', [var_schema.array_get('properties'), rt.new_int(0), rt.new_int(1), rt.new_bool(true)]), rt.create_array([rt.ArrayItem{ key: 'parent_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Parent order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]), rt.call_function('array_slice', [var_schema.array_get('properties'), rt.new_int(1), rt.new_null(), rt.new_bool(true)])]))
	return var_schema.dup()
}

struct Class_WC_REST_Order_Refunds_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_refunds_controller() &Class_WC_REST_Refunds_Controller {
	mut obj := &Class_WC_REST_Refunds_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('refunds')
		post_type: rt.new_string('shop_order_refund')
	}
	return obj
}

fn create_wc_rest_order_refunds_controller() &Class_WC_REST_Order_Refunds_Controller {
	mut obj := &Class_WC_REST_Order_Refunds_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Refunds_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_formatted_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_item_data(dispatch_arg_0)
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

fn (this &Class_WC_REST_Refunds_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Refunds_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Order_Refunds_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Order_Refunds_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Order_Refunds_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_refunds_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
