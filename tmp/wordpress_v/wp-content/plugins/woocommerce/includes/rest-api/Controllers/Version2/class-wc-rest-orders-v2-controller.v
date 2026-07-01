import rt

struct Class_WC_REST_Orders_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('orders')
		post_type rt.PhpVal = rt.new_string('shop_order')
		hierarchical rt.PhpVal = rt.new_bool(true)
		request rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_object(var_id rt.PhpVal) bool {
	mut var_id_mutated := var_id
	mut var_order := rt.call_function('wc_get_order', [var_id_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.identical(rt.new_string('shop_order_refund'), rt.call_method(var_order, 'get_type', []rt.PhpVal{}))))) {
		return false
	}
	return (var_order).to_bool()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_bool(this.get_object(// unsupported expression: Expr_Cast_Int))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))
	}
	return this.Class_WC_REST_CRUD_Controller.get_item_permissions_check(var_request_mutated.dup())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_bool(this.get_object(// unsupported expression: Expr_Cast_Int))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))
	}
	return this.Class_WC_REST_CRUD_Controller.update_item_permissions_check(var_request_mutated.dup())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_bool(this.get_object(// unsupported expression: Expr_Cast_Int))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))
	}
	return this.Class_WC_REST_CRUD_Controller.delete_item_permissions_check(var_request_mutated.dup())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_order_item_data(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_data := rt.call_method(var_item_mutated, 'get_data', []rt.PhpVal{})
	mut var_format_decimal := rt.create_array([rt.ArrayItem{ key: none, val: 'subtotal' }, rt.ArrayItem{ key: none, val: 'subtotal_tax' }, rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'total_tax' }, rt.ArrayItem{ key: none, val: 'tax_total' }, rt.ArrayItem{ key: none, val: 'shipping_tax_total' }])
	{
		mut iter_1 := var_format_decimal.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if var_data.array_isset(var_key) {
				var_data.array_set(var_key, rt.call_function('wc_format_decimal', [var_data.array_get(var_key), this.request.array_get('dp')]))
			}
		}
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_product' }])])) {
		mut var_product := rt.call_method(var_item_mutated, 'get_product', []rt.PhpVal{})
		var_data.array_set('sku', if rt.is_true(var_product) { rt.call_method(var_product, 'get_sku', []rt.PhpVal{}) } else { rt.new_null() })
		var_data.array_set('global_unique_id', if rt.is_true(var_product) { rt.call_method(var_product, 'get_global_unique_id', []rt.PhpVal{}) } else { rt.new_null() })
		var_data.array_set('price', if rt.is_true(rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})) { rt.div(rt.call_method(var_item_mutated, 'get_total', []rt.PhpVal{}), rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})) } else { rt.new_int(0) })
		mut var_image_id := if rt.is_true(var_product) { rt.call_method(var_product, 'get_image_id', []rt.PhpVal{}) } else { rt.new_int(0) }
		var_data.array_set('image', rt.create_array([rt.ArrayItem{ key: 'id', val: var_image_id }, rt.ArrayItem{ key: 'src', val: if rt.is_true(var_image_id) { rt.call_function('wp_get_attachment_image_url', [var_image_id.dup(), rt.new_string('full')]) } else { rt.new_string('') } }]))
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product }, rt.ArrayItem{ key: none, val: 'get_parent_data' }])])) {
			var_data.array_set('parent_name', rt.call_method(var_product, 'get_title', []rt.PhpVal{}))
		} else {
			var_data.array_set('parent_name', rt.new_null())
		}
	}
	if !(!rt.is_true(var_data.array_get('taxes').array_get('total'))) {
		mut var_taxes := []rt.PhpVal{}
		{
			mut iter_1 := var_data.array_get('taxes').array_get('total').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax := item_1.val
				mut var_tax_rate_id := item_1.key
				var_taxes << rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [var_tax.dup(), this.request.array_get('dp')]) }, rt.ArrayItem{ key: 'subtotal', val: if var_data.array_get('taxes').array_get('subtotal').array_isset(var_tax_rate_id) { rt.call_function('wc_format_decimal', [var_data.array_get('taxes').array_get('subtotal').array_get(var_tax_rate_id), this.request.array_get('dp')]) } else { rt.new_string('') } }])
			}
		}
		var_data.array_set('taxes', var_taxes.dup())
	} else if var_data.array_isset(rt.new_string('taxes')) {
		var_data.array_set('taxes', []rt.PhpVal{})
	}
	if var_data.array_isset(rt.new_string('code')) || var_data.array_isset(rt.new_string('rate_code')) || var_data.array_isset(rt.new_string('method_title')) {
		var_data.array_unset(rt.new_string('name'))
	}
	var_data.array_unset(rt.new_string('order_id'))
	var_data.array_unset(rt.new_string('type'))
	mut var_formatted_meta_data := rt.call_method(var_item_mutated, 'get_all_formatted_meta_data', [rt.new_null()])
	if rt.is_true(rt.new_bool(!(var_product).is_null() && rt.is_true(rt.identical(rt.new_string('true'), this.request.array_get('order_item_display_meta'))))) {
		mut var_order_item_name := var_data.array_get('name')
		closure_1_fn := fn [var_product, var_order_item_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_meta := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_display_value := rt.call_function('wp_kses_post', [rt.call_function('rawurldecode', [// unsupported expression: Expr_Cast_String])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])))) && rt.is_true(rt.call_function('wc_is_attribute_in_product_name', [var_display_value.dup(), var_order_item_name.dup()])))) {
		return rt.new_bool(false)
	}
	return rt.new_bool(true)
	}
		var_data.array_set('meta_data', rt.call_function('array_filter', [var_data.array_get('meta_data'), rt.new_closure(closure_1_fn)]))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_item_mutated, 'WC_Order_Item_Coupon'))) {
		mut var_coupon := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Coupon{}; return temp.from_order_item(arg_0) }(var_item_mutated.dup())
		var_data.array_set('discount_type', rt.call_method(var_coupon, 'get_discount_type', []rt.PhpVal{}))
		var_data.array_set('nominal_amount', // unsupported expression: Expr_Cast_Double)
		var_data.array_set('free_shipping', rt.call_method(var_coupon, 'get_free_shipping', []rt.PhpVal{}))
	}
	var_data.array_set('meta_data', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'merge_meta_item_with_formatted_meta_display_attributes' }]), var_data.array_get('meta_data'), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_data.array_get('meta_data').array_count()), var_formatted_meta_data.dup()])]))
	return var_data.dup()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) merge_meta_item_with_formatted_meta_display_attributes(var_meta_item rt.PhpVal, var_formatted_meta_data rt.PhpVal) rt.PhpVal {
	mut var_formatted_meta_data_mutated := var_formatted_meta_data
	mut var_result := { 'id': rt.get_property(var_meta_item, 'id'), 'key': rt.get_property(var_meta_item, 'key'), 'value': rt.get_property(var_meta_item, 'value'), 'display_key': rt.get_property(var_meta_item, 'key'), 'display_value': rt.get_property(var_meta_item, 'value') }
	if rt.is_true(rt.new_bool(var_formatted_meta_data_mutated.dup().array_isset(rt.get_property(var_meta_item, 'id')))) {
		mut var_formatted_meta_item := var_formatted_meta_data_mutated.array_get(rt.get_property(var_meta_item, 'id'))
		var_result['display_key'] = rt.call_function('wc_clean', [rt.get_property(var_formatted_meta_item, 'display_key')])
		var_result['display_value'] = rt.call_function('wc_clean', [rt.get_property(var_formatted_meta_item, 'display_value')])
	}
	return var_result.dup()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) filter_internal_meta_keys(var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_meta_data_mutated := var_meta_data
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }())))) {
		return var_meta_data_mutated.dup()
	}
	mut var_cpt_hidden_keys := rt.call_method(create_wc_order_data_store_cpt(), 'get_internal_meta_keys', []rt.PhpVal{})
	closure_2_fn := fn [var_cpt_hidden_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_meta := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'key'), var_cpt_hidden_keys.dup(), rt.new_bool(true)]))))
	}
	var_meta_data_mutated = rt.call_function('array_filter', [var_meta_data_mutated.dup(), rt.new_closure(closure_2_fn)])
	return rt.call_function('array_values', [var_meta_data_mutated.dup()])
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_formatted_item_data(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_extra_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'meta_data' }, rt.ArrayItem{ key: none, val: 'line_items' }, rt.ArrayItem{ key: none, val: 'tax_lines' }, rt.ArrayItem{ key: none, val: 'shipping_lines' }, rt.ArrayItem{ key: none, val: 'fee_lines' }, rt.ArrayItem{ key: none, val: 'coupon_lines' }, rt.ArrayItem{ key: none, val: 'refunds' }, rt.ArrayItem{ key: none, val: 'payment_url' }, rt.ArrayItem{ key: none, val: 'is_editable' }, rt.ArrayItem{ key: none, val: 'needs_payment' }, rt.ArrayItem{ key: none, val: 'needs_processing' }])
	mut var_format_decimal := rt.create_array([rt.ArrayItem{ key: none, val: 'discount_total' }, rt.ArrayItem{ key: none, val: 'discount_tax' }, rt.ArrayItem{ key: none, val: 'shipping_total' }, rt.ArrayItem{ key: none, val: 'shipping_tax' }, rt.ArrayItem{ key: none, val: 'shipping_total' }, rt.ArrayItem{ key: none, val: 'shipping_tax' }, rt.ArrayItem{ key: none, val: 'cart_tax' }, rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'total_tax' }])
	mut var_format_date := rt.create_array([rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'date_modified' }, rt.ArrayItem{ key: none, val: 'date_completed' }, rt.ArrayItem{ key: none, val: 'date_paid' }])
	mut var_dependent_fields := { 'date_created_gmt': 'date_created', 'date_modified_gmt': 'date_modified', 'date_completed_gmt': 'date_completed', 'date_paid_gmt': 'date_paid' }
	mut var_format_line_items := rt.create_array([rt.ArrayItem{ key: none, val: 'line_items' }, rt.ArrayItem{ key: none, val: 'tax_lines' }, rt.ArrayItem{ key: none, val: 'shipping_lines' }, rt.ArrayItem{ key: none, val: 'fee_lines' }, rt.ArrayItem{ key: none, val: 'coupon_lines' }])
	mut var_fields := this.get_fields_for_response(this.request)
	for var_field_key, var_dependency in var_dependent_fields {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(field_key), var_fields.dup(), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(dependency), var_fields.dup(), rt.new_bool(true)]))))))) {
			var_fields.array_push(dependency)
		}
	}
	var_extra_fields = rt.call_function('array_intersect', [var_extra_fields.dup(), var_fields.dup()])
	var_format_decimal = rt.call_function('array_intersect', [var_format_decimal.dup(), var_fields.dup()])
	var_format_date = rt.call_function('array_intersect', [var_format_date.dup(), var_fields.dup()])
	var_format_line_items = rt.call_function('array_intersect', [var_format_line_items.dup(), var_fields.dup()])
	mut var_data := rt.call_method(var_order_mutated, 'get_base_data', []rt.PhpVal{})
	{
		mut iter_1 := var_extra_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut switch_val_1 := var_field
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('meta_data'))) {
				mut var_meta_data := rt.call_method(var_order_mutated, 'get_meta_data', []rt.PhpVal{})
				var_data.array_set('meta_data', this.get_meta_data_for_response(this.request, var_meta_data.dup()))
				var_data.array_set('meta_data', this.filter_internal_meta_keys(var_data.array_get('meta_data')))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('line_items'))) {
				var_data.array_set('line_items', rt.call_method(var_order_mutated, 'get_items', [rt.new_string('line_item')]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_lines'))) {
				var_data.array_set('tax_lines', rt.call_method(var_order_mutated, 'get_items', [rt.new_string('tax')]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_lines'))) {
				var_data.array_set('shipping_lines', rt.call_method(var_order_mutated, 'get_items', [rt.new_string('shipping')]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fee_lines'))) {
				var_data.array_set('fee_lines', rt.call_method(var_order_mutated, 'get_items', [rt.new_string('fee')]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_lines'))) {
				var_data.array_set('coupon_lines', rt.call_method(var_order_mutated, 'get_items', [rt.new_string('coupon')]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('refunds'))) {
				var_data.array_set('refunds', []rt.PhpVal{})
				{
					mut iter_2 := rt.call_method(var_order_mutated, 'get_refunds', []rt.PhpVal{}).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_refund := item_2.val
						var_data.array_get_mut('refunds').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_refund, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'reason', val: if rt.is_true(rt.call_method(var_refund, 'get_reason', []rt.PhpVal{})) { rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'total', val: '-' + (rt.call_function('wc_format_decimal', [rt.call_method(var_refund, 'get_amount', []rt.PhpVal{}), this.request.array_get('dp')])).str() }, rt.ArrayItem{ key: 'total_tax', val: rt.call_function('wc_format_decimal', [// unsupported expression: Expr_Cast_Double, this.request.array_get('dp')]) }]))
					}
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('payment_url'))) {
				var_data.array_set('payment_url', rt.call_method(var_order_mutated, 'get_checkout_payment_url', []rt.PhpVal{}))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('is_editable'))) {
				var_data.array_set('is_editable', rt.call_method(var_order_mutated, 'is_editable', []rt.PhpVal{}))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('needs_payment'))) {
				var_data.array_set('needs_payment', rt.call_method(var_order_mutated, 'needs_payment', []rt.PhpVal{}))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('needs_processing'))) {
				var_data.array_set('needs_processing', rt.call_method(var_order_mutated, 'needs_processing', []rt.PhpVal{}))
			}
		}
	}
	{
		mut iter_1 := var_format_decimal.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_data.array_set(var_key, rt.call_function('wc_format_decimal', [, ]))
		}
	}
	{
		mut iter_1 := var_format_date.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			
		}
	}
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_object_for_response_core(var_order rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Orders_V2_Controller) filter_writable_props(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
}

fn (mut this Class_WC_REST_Orders_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Orders_V2_Controller) save_object(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) update_address(var_order rt.PhpVal, var_posted rt.PhpVal, type string)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_product_id(var_posted rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
}

fn (mut this Class_WC_REST_Orders_V2_Controller) maybe_set_item_prop(var_item rt.PhpVal, var_prop rt.PhpVal, var_posted rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) maybe_set_item_props(var_item rt.PhpVal, var_props rt.PhpVal, var_posted rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) maybe_set_item_meta_data(var_item rt.PhpVal, var_posted rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_line_items(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_shipping_lines(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_fee_lines(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_coupon_lines(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) set_item(var_order rt.PhpVal, var_item_type rt.PhpVal, var_posted rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_REST_Orders_V2_Controller) item_is_null(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_order_statuses() rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
}

struct Class_WC_REST_CRUD_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

fn create_wc_rest_orders_v2_controller() &Class_WC_REST_Orders_V2_Controller {
	mut obj := &Class_WC_REST_Orders_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('orders')
		post_type: rt.new_string('shop_order')
		hierarchical: rt.new_bool(true)
		request: rt.new_array()
	}
	return obj
}

fn create_wc_rest_crud_controller() &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
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

fn create_wc_coupon() &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_data_store_cpt() &Class_WC_Order_Data_Store_CPT {
	mut obj := &Class_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Orders_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_object(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'get_order_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_item_data(dispatch_arg_0)
		}
		'merge_meta_item_with_formatted_meta_display_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.merge_meta_item_with_formatted_meta_display_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_internal_meta_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_internal_meta_keys(dispatch_arg_0)
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
		'prepare_object_for_response_core' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response_core(dispatch_arg_0, dispatch_arg_1)
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
		'filter_writable_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_writable_props(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
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
		'update_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.update_address(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_product_id(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_set_item_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.maybe_set_item_prop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'maybe_set_item_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.maybe_set_item_props(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'maybe_set_item_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.maybe_set_item_meta_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_line_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_line_items(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_shipping_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_shipping_lines(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_fee_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_fee_lines(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_coupon_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_coupon_lines(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'item_is_null' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.item_is_null(dispatch_arg_0))
		}
		'get_order_statuses' {
			return this.get_order_statuses()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_objects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_objects(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Orders_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		'hierarchical' { return this.hierarchical }
		'request' { return this.request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Orders_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		'hierarchical' { this.hierarchical = val; return true }
		'request' { this.request = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_CRUD_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_CRUD_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_CRUD_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_orders_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
