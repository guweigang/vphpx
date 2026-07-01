import rt

struct Class_WC_REST_Order_Refunds_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('orders/(?P<order_id>[\\d]+)/refunds')
		post_type rt.PhpVal = rt.new_string('shop_order_refund')
		request rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) construct()  {
	rt.call_function('add_filter', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_object_trashable')), rt.new_string('__return_false')])
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: true }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as resource does not support trashing.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) get_object(var_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_get_order', [var_id.dup()])
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) get_formatted_item_data(var_object rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_data := rt.call_method(var_object_mutated, 'get_data', []rt.PhpVal{})
	mut var_format_decimal := ['amount']
	mut var_format_date := ['date_created']
	mut var_format_line_items := ['line_items', 'shipping_lines', 'tax_lines', 'fee_lines']
	for var_key in var_format_decimal {
		var_data.array_set(key, rt.call_function('wc_format_decimal', [var_data.array_get(key), this.request.array_get('dp')]))
	}
	for var_key in var_format_date {
		mut var_datetime := var_data.array_get(key)
		var_data.array_set(key, rt.call_function('wc_rest_prepare_date_response', [var_datetime.dup(), rt.new_bool(false)]))
		var_data.array_set(key + '_gmt', rt.call_function('wc_rest_prepare_date_response', [var_datetime.dup()]))
	}
	for var_key in var_format_line_items {
		var_data.array_set(key, rt.call_function('array_values', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Refunds_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_order_item_data' }]), var_data.array_get(key)])]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: var_data.array_get('date_created') }, rt.ArrayItem{ key: 'date_created_gmt', val: var_data.array_get('date_created_gmt') }, rt.ArrayItem{ key: 'amount', val: var_data.array_get('amount') }, rt.ArrayItem{ key: 'reason', val: var_data.array_get('reason') }, rt.ArrayItem{ key: 'refunded_by', val: var_data.array_get('refunded_by') }, rt.ArrayItem{ key: 'refunded_payment', val: var_data.array_get('refunded_payment') }, rt.ArrayItem{ key: 'meta_data', val: var_data.array_get('meta_data') }, rt.ArrayItem{ key: 'line_items', val: var_data.array_get('line_items') }, rt.ArrayItem{ key: 'shipping_lines', val: var_data.array_get('shipping_lines') }, rt.ArrayItem{ key: 'tax_lines', val: var_data.array_get('tax_lines') }, rt.ArrayItem{ key: 'fee_lines', val: var_data.array_get('fee_lines') }])
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	this.request = var_request.dup()
	this.request.array_set('dp', if rt.is_true(rt.new_bool(this.request.array_get('dp').is_null())) { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [this.request.array_get('dp')]) })
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_order_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object_mutated)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_order_refund_id'), rt.call_function('__', [rt.new_string('Invalid order refund ID.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	mut var_data := this.get_formatted_item_data(var_object_mutated.dup())
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object_mutated.dup(), var_request.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), rt.new_string('_object')), var_response.dup(), var_object_mutated.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_base := rt.call_function('str_replace', [rt.new_string('(?P<order_id>[\\d]+)'), rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{}), this.rest_base])
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, var_base.dup(), rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, var_base.dup()])]) }, 'up': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), this.namespace, rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})])]) } }
	return var_links.dup()
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := this.Class_WC_REST_Orders_V2_Controller.prepare_objects_query(var_request.dup())
	var_args.array_set('post_status', rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})))
	var_args.array_set('post_parent__in', rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('absint', [var_request.array_get('order_id')]) }]))
	return var_args.dup()
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_order_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	if rt.is_true(rt.greater(rt.new_int(0), var_request.array_get('amount'))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_order_refund'), rt.call_function('__', [rt.new_string('Refund amount must be greater than zero.'), rt.new_string('woocommerce')]), rt.new_int(400))
	}
	mut var_refund := rt.call_function('wc_create_refund', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'amount', val: var_request.array_get('amount') }, rt.ArrayItem{ key: 'reason', val: if !rt.is_true(var_request.array_get('reason')) { rt.new_null() } else { var_request.array_get('reason') } }, rt.ArrayItem{ key: 'refund_payment', val: if rt.is_true(rt.new_bool(var_request.array_get('api_refund').is_bool())) { var_request.array_get('api_refund') } else { rt.new_bool(true) } }, rt.ArrayItem{ key: 'restock_items', val: true }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_refund.dup()])) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_create_order_refund'), rt.call_method(var_refund, 'get_error_message', []rt.PhpVal{}), rt.new_int(500))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_refund)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_create_order_refund'), rt.call_function('__', [rt.new_string('Cannot create order refund, please try again.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	if !(!rt.is_true(var_request.array_get('meta_data'))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1) }(var_request.array_get('meta_data'), var_refund.dup())
		rt.call_method(var_refund, 'save_meta_data', []rt.PhpVal{})
	}
	var_refund = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type), rt.new_string('_object')), var_refund.dup(), var_request.dup(), rt.new_bool(creating)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_thing := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return if rt.is_true(rt.call_function('is_wp_error', [var_thing.dup()])) { var_thing } else { create_wp_error(rt.new_string('woocommerce_rest_cannot_verify_refund_created'), rt.call_function('__', [rt.new_string('An unexpected error occurred while generating the refund.'), rt.new_string('woocommerce')])) }
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Types{}; return temp.ensure_instance_of(arg_0, arg_1, arg_2) }(var_refund.dup(), Class_WC_Data.class(), rt.new_closure(closure_1_fn))
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) save_object(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_object := this.prepare_object_for_database(var_request.dup(), creating)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_object.dup()])) {
		return var_object.dup()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return this.get_object(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'WC_REST_Exception') {
		mut var_e := var_e_1.dup()
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

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': this.post_type, 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the order refund was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the order refund was created, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'amount': { 'description': rt.call_function('__', [rt.new_string('Refund amount.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'reason': { 'description': rt.call_function('__', [rt.new_string('Reason for refund.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'refunded_by': { 'description': rt.call_function('__', [rt.new_string('User ID of user who created the refund.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'refunded_payment': { 'description': rt.call_function('__', [rt.new_string('If the payment was refunded via the API.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} } } } }, 'line_items': { 'description': rt.call_function('__', [rt.new_string('Line items data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'product_id': { 'description': rt.call_function('__', [rt.new_string('Product ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'variation_id': { 'description': rt.call_function('__', [rt.new_string('Variation ID, if applicable.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'quantity': { 'description': rt.call_function('__', [rt.new_string('Quantity ordered.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'tax_class': { 'description': rt.call_function('__', [rt.new_string('Tax class of product.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'subtotal': { 'description': rt.call_function('__', [rt.new_string('Line subtotal (before discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'subtotal_tax': { 'description': rt.call_function('__', [rt.new_string('Line subtotal tax (before discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'total': { 'description': rt.call_function('__', [rt.new_string('Line total (after discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'total_tax': { 'description': rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'taxes': { 'description': rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'total': { 'description': rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'subtotal': { 'description': rt.call_function('__', [rt.new_string('Tax subtotal.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'sku': { 'description': rt.call_function('__', [rt.new_string('Product SKU.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'price': { 'description': rt.call_function('__', [rt.new_string('Product price.'), rt.new_string('woocommerce')]), 'type': rt.new_string('number'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'tax_lines': { 'description': rt.call_function('__', [rt.new_string('Tax lines data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'rate_code': { 'description': rt.call_function('__', [rt.new_string('Tax rate code.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'rate_id': { 'description': rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'label': { 'description': rt.call_function('__', [rt.new_string('Tax rate label.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'compound': { 'description': rt.call_function('__', [rt.new_string('Show if is a compound tax rate.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'tax_total': { 'description': rt.call_function('__', [rt.new_string('Tax total (not including shipping taxes).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'shipping_tax_total': { 'description': rt.call_function('__', [rt.new_string('Shipping tax total.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} } } } } } } }, 'shipping_lines': { 'description': rt.call_function('__', [rt.new_string('Shipping lines data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'method_title': { 'description': rt.call_function('__', [rt.new_string('Shipping method name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} }, 'method_id': { 'description': rt.call_function('__', [rt.new_string('Shipping method ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} }, 'instance_id': { 'description': rt.call_function('__', [rt.new_string('Shipping instance ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'total': { 'description': rt.call_function('__', [rt.new_string('Line total (after discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'total_tax': { 'description': rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'taxes': { 'description': rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'total': { 'description': rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} } } } } } } }, 'fee_lines': { 'description': rt.call_function('__', [rt.new_string('Fee lines data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('Fee name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} }, 'tax_class': { 'description': rt.call_function('__', [rt.new_string('Tax class of fee.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'tax_status': { 'description': rt.call_function('__', [rt.new_string('Tax status of fee.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'enum': map[string]rt.PhpVal{} }, 'total': { 'description': rt.call_function('__', [rt.new_string('Line total (after discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'total_tax': { 'description': rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'taxes': { 'description': rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'total': { 'description': rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'subtotal': { 'description': rt.call_function('__', [rt.new_string('Tax subtotal.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} } } } } } } }, 'api_refund': { 'description': rt.call_function('__', [rt.new_string('When true, the payment gateway API is used to generate the refund.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'default': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Orders_V2_Controller.get_collection_params()
	var_params.array_unset(rt.new_string('status'))
	var_params.array_unset(rt.new_string('customer'))
	var_params.array_unset(rt.new_string('product'))
	return var_params.dup()
}

struct Class_WC_REST_Orders_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Types {
	rt.PhpObjectBase
}

fn create_wc_rest_order_refunds_v2_controller() &Class_WC_REST_Order_Refunds_V2_Controller {
	mut obj := &Class_WC_REST_Order_Refunds_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('orders/(?P<order_id>[\\d]+)/refunds')
		post_type: rt.new_string('shop_order_refund')
		request: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wc_rest_orders_v2_controller() &Class_WC_REST_Orders_V2_Controller {
	mut obj := &Class_WC_REST_Orders_V2_Controller{
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

fn create_automattic_woocommerce_utilities_metadatautil() &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_types() &Class_Automattic_WooCommerce_Internal_Utilities_Types {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Types{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_object(dispatch_arg_0)
		}
		'get_formatted_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_item_data(dispatch_arg_0)
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'save_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.save_object(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Order_Refunds_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		'request' { return this.request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		'request' { this.request = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Orders_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Orders_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Orders_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Types) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Types) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Types) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_order_refunds_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
