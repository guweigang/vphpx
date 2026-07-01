import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('refunds')
		post_type rt.PhpVal = rt.new_string('shop_order_refund')
		item_schema rt.PhpVal = rt.new_null()
		collection_query rt.PhpVal = rt.new_null()
		data_utils rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) init(mut var_item_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema, mut var_collection_query Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery, mut var_data_utils Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils)  {
	this.item_schema = var_item_schema.dup()
	this.collection_query = var_collection_query.dup()
	this.data_utils = var_data_utils.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_query_schema() rt.PhpVal {
	return rt.call_method(this.collection_query, 'get_query_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_endpoint_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'num_decimals', val: rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of decimal points to use in each resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: 'args', val: this.get_endpoint_args() }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'api_refund', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('When true, the payment gateway API is used to perform the refund. If the payment gateway does not support refunds, the refund will fail.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }]) }, rt.ArrayItem{ key: 'api_restock', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('When true, refunded items are restocked.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args(), rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }])]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) prepare_links(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_response Class_WP_REST_Response) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), this.rest_base, rt.call_method(var_item, 'get_id', []rt.PhpVal{})])]) }]) }, rt.ArrayItem{ key: 'collection', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), this.rest_base])]) }]) }, rt.ArrayItem{ key: 'up', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), rt.call_method(var_item, 'get_parent_id', []rt.PhpVal{})])]) }]) }])
	if rt.is_true(rt.call_method(var_item, 'get_refunded_by', []rt.PhpVal{})) {
		var_links.array_set('refunded_by', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/wp/v2/users/%d'), rt.call_method(var_item, 'get_refunded_by', []rt.PhpVal{})])]) }, rt.ArrayItem{ key: 'embeddable', val: true }]))
	}
	return var_links.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_item_response(var_refund rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_refund_mutated := var_refund
	return rt.call_method(this.item_schema, 'get_item_response', [var_refund_mutated.dup(), var_request, this.get_fields_for_response(rt.new_object('WP_REST_Request', []string{}, var_request))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_refund := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if !(this.is_valid_refund_for_request(var_refund.dup())) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller.invalid_id())
	}
	return this.prepare_item_for_response(var_refund.dup(), var_request.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := rt.call_method(this.collection_query, 'get_query_args', [var_request.dup()])
	mut var_results := rt.call_method(this.collection_query, 'get_query_results', [rt.call_function('array_merge', [var_query_args.dup(), rt.create_array([rt.ArrayItem{ key: 'post_type', val: this.post_type }, rt.ArrayItem{ key: 'post_status', val: rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})) }])]), var_request.dup()])
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller.resource_exists())
	}
	mut var_order := rt.call_function('wc_get_order', [var_request.array_get('order_id')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller.invalid_id())
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_validation_error := rt.call_method(this.data_utils, 'validate_line_items', [var_request.array_get('line_items'), var_order.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_validation_error.dup()])) {
		return this.get_route_error_response(rt.call_method(var_validation_error, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_validation_error, 'get_error_message', []rt.PhpVal{}))
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_line_item_data := rt.call_method(this.data_utils, 'convert_line_items_to_internal_format', [var_request.array_get('line_items'), var_order.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_calculated_total := if !(!rt.is_true(var_request.array_get('line_items'))) { rt.call_method(this.data_utils, 'calculate_refund_amount', [var_request.array_get('line_items')]) } else { rt.new_int(0) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_refund_amount := if !(!rt.is_true(var_request.array_get('amount'))) { var_request.array_get('amount') } else { var_calculated_total }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.new_int(0), var_refund_amount)) || rt.is_true(rt.new_bool(!(rt.is_true(var_refund_amount)))))) {
		return this.get_route_error_response(rt.new_string('invalid_refund_amount'), rt.call_function('__', [rt.new_string('Refund total must be greater than zero.'), rt.new_string('woocommerce')]))
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_request.array_get('amount'))) && rt.is_true(rt.greater(var_calculated_total, rt.new_int(0))))) && rt.is_true(rt.less(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(// unsupported expression: Expr_Cast_Double, rt.call_function('wc_get_price_decimals', []rt.PhpVal{})), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(var_calculated_total.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})))))) {
		return this.get_route_error_response(rt.new_string('invalid_refund_amount'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Refund amount (%1$s) cannot be less than the total of line items (%2$s).'), rt.new_string('woocommerce')]), rt.call_function('wc_format_decimal', [var_refund_amount.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), rt.call_function('wc_format_decimal', [var_calculated_total.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])]))
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_refund := rt.call_function('wc_create_refund', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'amount', val: var_refund_amount }, rt.ArrayItem{ key: 'reason', val: var_request.array_get('reason') }, rt.ArrayItem{ key: 'line_items', val: var_line_item_data }, rt.ArrayItem{ key: 'refund_payment', val: var_request.array_get('api_refund') }, rt.ArrayItem{ key: 'restock_items', val: var_request.array_get('api_restock') }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_refund)))) {
		return this.get_route_error_response(rt.new_string('cannot_create_refund'), rt.call_function('__', [rt.new_string('Cannot create order refund.'), rt.new_string('woocommerce')]))
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_refund.dup()])) {
		return this.get_route_error_response(rt.new_string('cannot_create_refund'), rt.call_method(var_refund, 'get_error_message', []rt.PhpVal{}))
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(var_request.array_get('meta_data'))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1) }(var_request.array_get('meta_data'), var_refund.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_refund, 'save_meta_data', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.update_additional_fields_for_object(var_refund.dup(), var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [(this.get_hook_prefix()).str() + 'created', var_refund.dup(), var_request.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response := this.prepare_item_for_response(var_refund.dup(), var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_response, 'set_status', [Class_WP_Http.created()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller', ['Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController'], &this), 'namespace'), this.rest_base, rt.call_method(var_refund, 'get_id', []rt.PhpVal{})])])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_response.dup()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_WC_Data_Exception') {
		mut var_e := var_e_1.dup()
		return this.get_route_error_response(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_WC_REST_Exception') {
		mut var_e := var_e_1.dup()
		return this.get_route_error_response(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_refund := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if !(this.is_valid_refund_for_request(var_refund.dup())) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller.invalid_id())
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := create_wp_rest_response(rt.new_null(), rt.new_int(204))
	mut var_result := rt.call_method(var_refund, 'delete', [rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller.cannot_delete())
	}
	rt.call_function('do_action', [(this.get_hook_prefix()).str() + 'deleted', var_refund.dup(), var_response.dup(), var_request.dup()])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) is_valid_refund_for_request(var_refund rt.PhpVal) bool {
	mut var_refund_mutated := var_refund
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_refund_mutated, 'WC_Order_Refund'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.identical(rt.new_string('shop_order_refund'), rt.call_method(var_refund_mutated, 'get_type', []rt.PhpVal{})))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read'), var_request.array_get('id')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('create')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('delete'), var_request.array_get('id')]))))) {
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_refunds_controller() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('refunds')
		post_type: rt.new_string('shop_order_refund')
		item_schema: rt.new_null()
		collection_query: rt.new_null()
		data_utils: rt.new_null()
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

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_metadatautil() &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Schema_RefundSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils](if args.len > 2 { args[2] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
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
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'is_valid_refund_for_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_refund_for_request(dispatch_arg_0))
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
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		'item_schema' { return this.item_schema }
		'collection_query' { return this.collection_query }
		'data_utils' { return this.data_utils }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		'item_schema' { this.item_schema = val; return true }
		'collection_query' { this.collection_query = val; return true }
		'data_utils' { this.data_utils = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_refunds_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
