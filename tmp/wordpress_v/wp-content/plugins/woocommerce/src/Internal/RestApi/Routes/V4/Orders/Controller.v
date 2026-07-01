import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('orders')
		post_type rt.PhpVal = rt.new_string('shop_order')
		item_schema rt.PhpVal = rt.new_null()
		query_utils rt.PhpVal = rt.new_null()
		update_utils rt.PhpVal = rt.new_null()
		action_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) init(mut var_item_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema, mut var_query_utils Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery, mut var_update_utils Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils, mut var_action_controller Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController)  {
	this.item_schema = var_item_schema.dup()
	this.dispatch_set_prop('collection_query', var_query_utils.dup())
	this.update_utils = var_update_utils.dup()
	this.action_controller = var_action_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_query_schema() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'collection_query'), 'get_query_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_endpoint_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'num_decimals', val: rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of decimal points to use in each resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args() }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args(), rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }])]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()), rt.call_method(this.action_controller, 'get_endpoint_args_for_actions', []rt.PhpVal{})]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) prepare_links(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_response Class_WP_REST_Response) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), this.rest_base, rt.call_method(var_item, 'get_id', []rt.PhpVal{})])]) }, rt.ArrayItem{ key: 'targetHints', val: rt.create_array([rt.ArrayItem{ key: 'allow', val: if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')])) { rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }, rt.ArrayItem{ key: none, val: 'PUT' }, rt.ArrayItem{ key: none, val: 'POST' }, rt.ArrayItem{ key: none, val: 'PATCH' }, rt.ArrayItem{ key: none, val: 'DELETE' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }]) } }]) }]) }, rt.ArrayItem{ key: 'collection', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), this.rest_base])]) }]) }, rt.ArrayItem{ key: 'email-templates', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/wc/v3/%s/%d/actions/email_templates'), this.rest_base, rt.call_method(var_item, 'get_id', []rt.PhpVal{})])]) }, rt.ArrayItem{ key: 'embeddable', val: true }]) }, rt.ArrayItem{ key: 'order-notes', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: // unsupported expression: Expr_Cast_Int }]), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/order-notes'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace')])])]) }, rt.ArrayItem{ key: 'embeddable', val: true }]) }, rt.ArrayItem{ key: 'refunds', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: // unsupported expression: Expr_Cast_Int }]), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/refunds'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace')])])]) }, rt.ArrayItem{ key: 'embeddable', val: true }]) }])
	if rt.is_true(rt.call_method(var_item, 'get_payment_method', []rt.PhpVal{})) {
		var_links.array_set('payment_gateway', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/settings/payment-gateways/%s'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), rt.call_function('rawurlencode', [rt.call_method(var_item, 'get_payment_method', []rt.PhpVal{})])])]) }, rt.ArrayItem{ key: 'embeddable', val: true }]))
	}
	if rt.is_true(rt.call_method(var_item, 'get_customer_id', []rt.PhpVal{})) {
		var_links.array_set('customer', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/customers/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), rt.call_method(var_item, 'get_customer_id', []rt.PhpVal{})])]) }]))
	}
	if rt.is_true(rt.call_method(var_item, 'get_parent_id', []rt.PhpVal{})) {
		var_links.array_set('up', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), rt.call_method(var_item, 'get_parent_id', []rt.PhpVal{})])]) }]))
	}
	return var_links.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_item_response(var_order rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_mutated := var_order
	return rt.call_method(this.item_schema, 'get_item_response', [var_order_mutated.dup(), var_request, this.get_fields_for_response(rt.new_object('WP_REST_Request', []string{}, var_request))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if !(this.is_valid_order_for_request(var_order.dup())) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.invalid_id())
	}
	return this.prepare_item_for_response(var_order.dup(), var_request.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := rt.cast_array(rt.call_function('apply_filters', [(this.get_hook_prefix()).str() + 'collection_query_args', rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'collection_query'), 'get_query_args', [var_request.dup()]), var_request.dup(), rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this)]))
	var_query_args = rt.call_function('wp_parse_args', [var_query_args.dup(), rt.create_array([rt.ArrayItem{ key: 'post_type', val: this.post_type }])])
	mut var_results := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'collection_query'), 'get_query_results', [var_query_args.dup(), var_request.dup()])
	mut var_items := rt.new_array()
	{
		mut iter_1 := var_results.array_get('results').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result := item_1.val
			var_items.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_result.dup(), var_request.dup())))
		}
	}
	mut var_pagination_util := create_automattic_woocommerce_storeapi_utilities_pagination()
	mut var_response := var_pagination_util.add_headers(rt.call_function('rest_ensure_response', [var_items.dup()]), var_request.dup(), var_results.array_get('total'), var_results.array_get('pages'))
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.resource_exists())
	}
	mut var_order := create_wc_order()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_created_via', [if !(!rt.is_true(var_request.array_get('created_via'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [var_request.array_get('created_via')])]) } else { rt.new_string('rest-api') }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_prices_include_tax', [rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')]))])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(this.update_utils, 'update_order_from_request', [var_order.dup(), var_request.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.update_additional_fields_for_object(var_order.dup(), var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [(this.get_hook_prefix()).str() + 'created', var_order.dup(), var_request.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response := this.prepare_item_for_response(var_order.dup(), var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_response, 'set_status', [Class_WP_Http.created()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), this.rest_base, rt.call_method(var_order, 'get_id', []rt.PhpVal{})])])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_response.dup()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Exception') {
		mut var_e := var_e_1.dup()
		mut var_data := rt.call_method(var_e, 'getErrorData', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))))) && rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{})))) {
			rt.call_method(var_order, 'set_status', [rt.new_string('checkout-draft')])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			rt.call_method(var_order, 'save', []rt.PhpVal{})
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			// unsupported statement: Stmt_Nop
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Exception') {
				mut var__ := var_e_2.dup()
				// unsupported statement: Stmt_Nop
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
			var_data.array_set('new_draft_order_id', rt.call_method(var_order, 'get_id', []rt.PhpVal{}))
		}
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), var_data.dup())
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_REST_Exception') {
		mut var_e := var_e_1.dup()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))))) && rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{})))) {
			rt.call_method(var_order, 'delete', [rt.new_bool(true)])
		}
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if !(this.is_valid_order_for_request(var_order.dup())) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.invalid_id())
	}
	rt.call_method(this.update_utils, 'update_order_from_request', [var_order.dup(), var_request.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	this.update_additional_fields_for_object(var_order.dup(), var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_method(this.action_controller, 'run_actions', [var_order.dup(), var_request.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_function('do_action', [(this.get_hook_prefix()).str() + 'updated', var_order.dup(), var_request.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return this.prepare_item_for_response(var_order.dup(), var_request.dup())
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Exception') {
		mut var_e := var_e_3.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{}))
		unsafe { goto end_label_3 }
	}
	else if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_REST_Exception') {
		mut var_e := var_e_3.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if !(this.is_valid_order_for_request(var_order.dup())) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.invalid_id())
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_force := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(var_force) {
		mut var_result := rt.call_method(var_order, 'delete', [rt.new_bool(true)])
		mut var_response := create_wp_rest_response(rt.new_null(), rt.new_int(204))
	} else {
		var_response = this.prepare_item_for_response(var_order.dup(), var_request.dup())
		mut var_supports_trash := rt.call_function('apply_filters', [(this.get_hook_prefix()).str() + 'object_trashable', rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0)), var_order.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.trash_not_supported())
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_method(var_order, 'get_status', []rt.PhpVal{}))) {
			return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.cannot_trash())
		}
		rt.call_method(var_order, 'delete', []rt.PhpVal{})
		var_result = rt.identical(rt.new_string('trash'), rt.call_method(var_order, 'get_status', []rt.PhpVal{}))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.cannot_delete())
	}
	rt.call_function('do_action', [(this.get_hook_prefix()).str() + 'deleted', var_order.dup(), var_response.dup(), var_request.dup()])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) is_valid_order_for_request(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read'), var_request.array_get('id')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('create')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('edit'), .array_get()]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return ().to_bool()
	}
	return 
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	rt.PhpObjectBase
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_controller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('orders')
		post_type: rt.new_string('shop_order')
		item_schema: rt.new_null()
		query_utils: rt.new_null()
		update_utils: rt.new_null()
		action_controller: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_pagination() &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order() &Class_WC_Order {
	mut obj := &Class_WC_Order{
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

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController](if args.len > 3 { args[3] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'get_schema' {
			return this.get_schema()
		}
		'get_query_schema' {
			return this.get_query_schema()
		}
		'get_endpoint_args' {
			return this.get_endpoint_args()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.prepare_links(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
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
		'is_valid_order_for_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_order_for_request(dispatch_arg_0))
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		'item_schema' { return this.item_schema }
		'query_utils' { return this.query_utils }
		'update_utils' { return this.update_utils }
		'action_controller' { return this.action_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		'item_schema' { this.item_schema = val; return true }
		'query_utils' { this.query_utils = val; return true }
		'update_utils' { this.update_utils = val; return true }
		'action_controller' { this.action_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_orders_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
