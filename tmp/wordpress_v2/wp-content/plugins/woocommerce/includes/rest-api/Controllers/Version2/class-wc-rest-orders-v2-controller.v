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

fn (mut this Class_WC_REST_Orders_V2_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str()), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/batch'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_object(var_id rt.PhpVal) bool {
	mut var_id_mutated := var_id
	mut var_order := rt.call_function('wc_get_order', [var_id_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.identical(rt.new_string('shop_order_refund'), rt.call_method(var_order, 'get_type', []rt.PhpVal{}))) {
		return false
	}
	return (var_order).to_bool()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_bool(this.get_object(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	return this.Class_WC_REST_CRUD_Controller.get_item_permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_bool(this.get_object(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	return this.Class_WC_REST_CRUD_Controller.update_item_permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_bool(this.get_object(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	return this.Class_WC_REST_CRUD_Controller.delete_item_permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_order_item_data(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_data := rt.call_method(var_item_mutated, 'get_data', []rt.PhpVal{})
	mut var_format_decimal := rt.create_array([rt.ArrayItem{ key: none, val: 'subtotal' }, rt.ArrayItem{ key: none, val: 'subtotal_tax' }, rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'total_tax' }, rt.ArrayItem{ key: none, val: 'tax_total' }, rt.ArrayItem{ key: none, val: 'shipping_tax_total' }])
	mut iter_1 := var_format_decimal.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if var_data.array_isset(var_key) {
			var_data.array_set(var_key, rt.call_function('wc_format_decimal', [var_data.array_get(var_key), this.request.array_get(rt.new_string('dp'))]))
		}
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_product' }])])) {
		mut var_product := rt.call_method(var_item_mutated, 'get_product', []rt.PhpVal{})
		var_data.array_set('sku', if rt.is_true(var_product) { rt.call_method(var_product, 'get_sku', []rt.PhpVal{}) } else { rt.new_null() })
		var_data.array_set('global_unique_id', if rt.is_true(var_product) { rt.call_method(var_product, 'get_global_unique_id', []rt.PhpVal{}) } else { rt.new_null() })
		var_data.array_set('price', if rt.is_true(rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})) { rt.div(rt.call_method(var_item_mutated, 'get_total', []rt.PhpVal{}), rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})) } else { rt.new_int(0) })
		mut var_image_id := if rt.is_true(var_product) { rt.call_method(var_product, 'get_image_id', []rt.PhpVal{}) } else { rt.new_int(0) }
		var_data.array_set('image', rt.create_array([rt.ArrayItem{ key: 'id', val: var_image_id }, rt.ArrayItem{ key: 'src', val: if rt.is_true(var_image_id) { rt.call_function('wp_get_attachment_image_url', [var_image_id.clone(), rt.new_string('full')]) } else { rt.new_string('') } }]))
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product }, rt.ArrayItem{ key: none, val: 'get_parent_data' }])])) {
			var_data.array_set('parent_name', rt.call_method(var_product, 'get_title', []rt.PhpVal{}))
		} else {
			var_data.array_set('parent_name', rt.new_null())
		}
	}
	if !(!rt.is_true(var_data.array_get(rt.new_string('taxes')).array_get(rt.new_string('total')))) {
		mut var_taxes := []rt.PhpVal{}
		mut iter_2 := var_data.array_get(rt.new_string('taxes')).array_get(rt.new_string('total')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tax := item_2.val
			mut var_tax_rate_id := item_2.key
			var_taxes << rt.create_array([rt.ArrayItem{ key: 'id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [var_tax.clone(), this.request.array_get(rt.new_string('dp'))]) }, rt.ArrayItem{ key: 'subtotal', val: if var_data.array_get(rt.new_string('taxes')).array_get(rt.new_string('subtotal')).array_isset(var_tax_rate_id) { rt.call_function('wc_format_decimal', [var_data.array_get(rt.new_string('taxes')).array_get(rt.new_string('subtotal')).array_get(var_tax_rate_id), this.request.array_get(rt.new_string('dp'))]) } else { rt.new_string('') } }])
		}
		var_data.array_set('taxes', var_taxes.clone())
	} else if var_data.array_isset(rt.new_string('taxes')) {
		var_data.array_set('taxes', []rt.PhpVal{})
	}
	if var_data.array_isset(rt.new_string('code')) || var_data.array_isset(rt.new_string('rate_code')) || var_data.array_isset(rt.new_string('method_title')) {
		var_data.array_unset(rt.new_string('name'))
	}
	var_data.array_unset(rt.new_string('order_id'))
	var_data.array_unset(rt.new_string('type'))
	mut var_formatted_meta_data := rt.call_method(var_item_mutated, 'get_all_formatted_meta_data', [rt.new_null()])
	if !(var_product).is_null() && rt.is_true(rt.identical(rt.new_string('true'), this.request.array_get(rt.new_string('order_item_display_meta')))) {
		mut var_order_item_name := var_data.array_get(rt.new_string('name'))
		closure_1_fn := fn [var_product, var_order_item_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_display_value := rt.call_function('wp_kses_post', [rt.call_function('rawurldecode', [rt.new_string((rt.get_property(var_meta, 'value')).str())])])
			if rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) && rt.is_true(rt.call_function('wc_is_attribute_in_product_name', [var_display_value.clone(), var_order_item_name.clone()])) {
				return rt.new_bool(false)
			}
			return rt.new_bool(true)
			}
		var_data.array_set('meta_data', rt.call_function('array_filter', [var_data.array_get(rt.new_string('meta_data')), rt.new_closure(closure_1_fn)]))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_item_mutated, 'WC_Order_Item_Coupon'))) {
		mut iife_temp_1 := Class_WC_Coupon{}
		mut iife_result_1 := iife_temp_1.from_order_item(var_item_mutated.clone())
		mut var_coupon := iife_result_1
		var_data.array_set('discount_type', rt.call_method(var_coupon, 'get_discount_type', []rt.PhpVal{}))
		var_data.array_set('nominal_amount', rt.new_float((rt.call_method(var_coupon, 'get_amount', []rt.PhpVal{})).to_f64()))
		var_data.array_set('free_shipping', rt.call_method(var_coupon, 'get_free_shipping', []rt.PhpVal{}))
	}
	var_data.array_set('meta_data', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'merge_meta_item_with_formatted_meta_display_attributes' }]), var_data.array_get(rt.new_string('meta_data')), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_data.array_get(rt.new_string('meta_data')).array_count()), var_formatted_meta_data.clone()])]))
	return var_data.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) merge_meta_item_with_formatted_meta_display_attributes(var_meta_item rt.PhpVal, var_formatted_meta_data rt.PhpVal) rt.PhpVal {
	mut var_formatted_meta_data_mutated := var_formatted_meta_data
	mut var_result := { 'id': rt.get_property(var_meta_item, 'id'), 'key': rt.get_property(var_meta_item, 'key'), 'value': rt.get_property(var_meta_item, 'value'), 'display_key': rt.get_property(var_meta_item, 'key'), 'display_value': rt.get_property(var_meta_item, 'value') }
	if rt.is_true(rt.new_bool(var_formatted_meta_data_mutated.clone().array_isset(rt.get_property(var_meta_item, 'id')))) {
		mut var_formatted_meta_item := var_formatted_meta_data_mutated.array_get(rt.get_property(var_meta_item, 'id'))
		var_result['display_key'] = rt.call_function('wc_clean', [rt.get_property(var_formatted_meta_item, 'display_key')])
		var_result['display_value'] = rt.call_function('wc_clean', [rt.get_property(var_formatted_meta_item, 'display_value')])
	}
	return var_result.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) filter_internal_meta_keys(var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_meta_data_mutated := var_meta_data
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.custom_orders_table_usage_is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return var_meta_data_mutated.clone()
	}
	mut var_cpt_hidden_keys := rt.call_method(create_wc_order_data_store_cpt(), 'get_internal_meta_keys', []rt.PhpVal{})
	closure_4_fn := fn [var_cpt_hidden_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'key'), var_cpt_hidden_keys.clone(), rt.new_bool(true)]))))
		}
	var_meta_data_mutated = rt.call_function('array_filter', [var_meta_data_mutated.clone(), rt.new_closure(closure_4_fn)])
	return rt.call_function('array_values', [var_meta_data_mutated.clone()])
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
		if rt.is_true(rt.call_function('in_array', [rt.new_string(field_key), var_fields.clone(), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(dependency), var_fields.clone(), rt.new_bool(true)]))))) {
			var_fields.array_push(dependency)
		}
	}
	var_extra_fields = rt.call_function('array_intersect', [var_extra_fields.clone(), var_fields.clone()])
	var_format_decimal = rt.call_function('array_intersect', [var_format_decimal.clone(), var_fields.clone()])
	var_format_date = rt.call_function('array_intersect', [var_format_date.clone(), var_fields.clone()])
	var_format_line_items = rt.call_function('array_intersect', [var_format_line_items.clone(), var_fields.clone()])
	mut var_data := rt.call_method(var_order_mutated, 'get_base_data', []rt.PhpVal{})
	mut iter_3 := var_extra_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		mut switch_val_1 := var_field
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('meta_data'))) {
			mut var_meta_data := rt.call_method(var_order_mutated, 'get_meta_data', []rt.PhpVal{})
			var_data.array_set('meta_data', this.get_meta_data_for_response(this.request, var_meta_data.clone()))
			var_data.array_set('meta_data', this.filter_internal_meta_keys(var_data.array_get(rt.new_string('meta_data'))))
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
			mut iter_4 := rt.call_method(var_order_mutated, 'get_refunds', []rt.PhpVal{}).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_refund := item_4.val
				var_data.array_get_mut('refunds').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_refund, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'reason', val: if rt.is_true(rt.call_method(var_refund, 'get_reason', []rt.PhpVal{})) { rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'total', val: '-' + (rt.call_function('wc_format_decimal', [rt.call_method(var_refund, 'get_amount', []rt.PhpVal{}), this.request.array_get(rt.new_string('dp'))])).str() }, rt.ArrayItem{ key: 'total_tax', val: rt.call_function('wc_format_decimal', [rt.new_float((rt.call_method(var_refund, 'get_total_tax', []rt.PhpVal{})).to_f64()), this.request.array_get(rt.new_string('dp'))]) }]))
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
	mut iter_5 := var_format_decimal.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_key := item_5.val
		var_data.array_set(var_key, rt.call_function('wc_format_decimal', [var_data.array_get(var_key), this.request.array_get(rt.new_string('dp'))]))
	}
	mut iter_6 := var_format_date.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_key := item_6.val
		mut var_datetime := var_data.array_get(var_key)
		var_data.array_set(var_key, rt.call_function('wc_rest_prepare_date_response', [var_datetime.clone(), rt.new_bool(false)]))
		var_data.array_set((var_key).str() + '_gmt', rt.call_function('wc_rest_prepare_date_response', [var_datetime.clone()]))
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_4 := iife_temp_4.remove_status_prefix(var_data.array_get(rt.new_string('status')))
	var_data.array_set('status', iife_result_4)
	mut iter_7 := var_format_line_items.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_key := item_7.val
		var_data.array_set(var_key, rt.call_function('array_values', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_order_item_data' }]), var_data.array_get(var_key)])]))
	}
	mut var_allowed_fields := ['id', 'parent_id', 'number', 'order_key', 'created_via', 'version', 'status', 'currency', 'date_created', 'date_created_gmt', 'date_modified', 'date_modified_gmt', 'discount_total', 'discount_tax', 'shipping_total', 'shipping_tax', 'cart_tax', 'total', 'total_tax', 'prices_include_tax', 'customer_id', 'customer_ip_address', 'customer_user_agent', 'customer_note', 'billing', 'shipping', 'payment_method', 'payment_method_title', 'transaction_id', 'date_paid', 'date_paid_gmt', 'date_completed', 'date_completed_gmt', 'cart_hash', 'meta_data', 'line_items', 'tax_lines', 'shipping_lines', 'fee_lines', 'coupon_lines', 'refunds', 'payment_url', 'is_editable', 'needs_payment', 'needs_processing']
	var_data = rt.call_function('array_intersect_key', [var_data.clone(), rt.call_function('array_flip', [rt.create_array_from_list(var_allowed_fields)])])
	return var_data.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_data := this.prepare_object_for_response_core(var_object_mutated.clone(), var_request_mutated.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object_mutated.clone(), var_request_mutated.clone())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), rt.new_string('_object')), var_response.clone(), var_object_mutated.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_object_for_response_core(var_order rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_request_mutated := var_request
	this.request = var_request_mutated.clone()
	this.request.array_set('dp', if this.request.array_get(rt.new_string('dp')).is_null() { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [this.request.array_get(rt.new_string('dp'))]) })
	var_request_mutated.array_set('context', if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) { var_request_mutated.array_get(rt.new_string('context')) } else { rt.new_string('view') })
	mut var_data := this.get_formatted_item_data(var_order_mutated.clone())
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_request_mutated.array_get(rt.new_string('context')))
	return var_data.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])]) }, 'email_templates': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d/actions/email_templates'), this.namespace, this.rest_base, rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})])]), 'embeddable': rt.new_bool(true) } }
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.call_method(var_object_mutated, 'get_customer_id', []rt.PhpVal{})).to_i64()))) {
		var_links['customer'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/customers/%d'), this.namespace, rt.call_method(var_object_mutated, 'get_customer_id', []rt.PhpVal{})])]) }])
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})).to_i64()))) {
		var_links['up'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), this.namespace, rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})])]) }])
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_request_mutated := var_request
	mut var_args := this.Class_WC_REST_CRUD_Controller.prepare_objects_query(var_request_mutated.clone())
	if rt.is_true(rt.call_function('in_array', [var_request_mutated.array_get(rt.new_string('status')), this.get_order_statuses(), rt.new_bool(true)])) {
		var_args.array_set('post_status', 'wc-' + (var_request_mutated.array_get(rt.new_string('status'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('any'), var_request_mutated.array_get(rt.new_string('status')))) {
		var_args.array_set('post_status', 'any')
	} else {
		var_args.array_set('post_status', var_request_mutated.array_get(rt.new_string('status')))
	}
	if var_request_mutated.array_isset(rt.new_string('customer')) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_5 := iife_temp_5.custom_orders_table_usage_is_enabled()
		if rt.is_true(iife_result_5) {
			var_args.array_set('customer_id', var_request_mutated.array_get(rt.new_string('customer')))
		} else {
			if !(!rt.is_true(var_args.array_get(rt.new_string('meta_query')))) {
				var_args.array_set('meta_query', []rt.PhpVal{})
			}
			var_args.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_customer_user' }, rt.ArrayItem{ key: 'value', val: var_request_mutated.array_get(rt.new_string('customer')) }, rt.ArrayItem{ key: 'type', val: 'NUMERIC' }]))
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('product')))) {
		mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT order_id\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items\n\t\t\t\t\tWHERE order_item_id IN ( SELECT order_item_id FROM ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta WHERE meta_key = \'_product_id\' AND meta_value = %d )\n\t\t\t\t\tAND order_item_type = \'line_item\'')), var_request_mutated.array_get(rt.new_string('product'))])])
		var_order_ids = if !(!rt.is_true(var_order_ids)) { var_order_ids } else { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) }
		var_args.array_set('post__in', var_order_ids.clone())
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_6 := iife_temp_6.custom_orders_table_usage_is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_6)))) && !(!rt.is_true(var_args.array_get(rt.new_string('s')))) {
		var_order_ids = rt.call_function('wc_order_search', [var_args.array_get(rt.new_string('s'))])
		if !(!rt.is_true(var_order_ids)) {
			var_args.array_unset(rt.new_string('s'))
			var_args.array_set('post__in', rt.call_function('array_merge', [var_order_ids.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 0 }])]))
		}
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_orders_prepare_object_query'), var_args.clone(), var_request_mutated.clone()])
	return var_args.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) filter_writable_props(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	return rt.new_bool(!rt.is_true(var_schema_mutated.array_get(rt.new_string('readonly'))))
}

fn (mut this Class_WC_REST_Orders_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_7 := iife_temp_7.get_order_type(var_id.clone())
	if !rt.is_true(var_id) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_7, this.post_type)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('ID is invalid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	return this.Class_WC_REST_CRUD_Controller.update_item(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := if var_request_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_request_mutated.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
	mut var_order := create_wc_order(var_id.clone())
	mut var_schema := this.get_item_schema()
	mut var_data_keys := rt.func_array_keys(rt.call_function('array_filter', [var_schema.array_get(rt.new_string('properties')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'filter_writable_props' }])]))
	mut iter_8 := var_data_keys.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_key := item_8.val
		mut var_value := var_request_mutated.array_get(var_key)
		if !(var_value.clone().is_null()) {
			mut switch_val_2 := var_key
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('status'))) {
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('billing'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping'))) {
				this.update_address(var_order.clone(), var_value.clone(), (var_key).str())
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('line_items'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_lines'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('fee_lines'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('coupon_lines'))) {
				if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
					mut iter_9 := var_value.iterator()
					for {
						item_9 := iter_9.next() or { break }
						mut var_item := item_9.val
						if rt.is_true(rt.new_bool(var_item.clone().is_array())) {
							if this.item_is_null(var_item.clone()) || (var_item.array_isset(rt.new_string('quantity')) && rt.is_true(rt.identical(rt.new_int(0), var_item.array_get(rt.new_string('quantity'))))) {
								rt.call_method(var_order, 'remove_item', [var_item.array_get(rt.new_string('id'))])
							} else {
								this.set_item(var_order.clone(), var_key.clone(), var_item.clone())
							}
						}
					}
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('meta_data'))) {
				if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
					mut iter_10 := var_value.iterator()
					for {
						item_10 := iter_10.next() or { break }
						mut var_meta := item_10.val
						rt.call_method(var_order, 'update_meta_data', [var_meta.array_get(rt.new_string('key')), var_meta.array_get(rt.new_string('value')), if var_meta.array_isset(rt.new_string('id')) { var_meta.array_get(rt.new_string('id')) } else { rt.new_string('') }])
					}
				}
			} else {
				if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: "set_${var_key.to_string()}" }])])) {
					rt.call_method(var_order, "set_${var_key.to_string()}", [var_value.clone()])
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type), rt.new_string('_object')), var_order.clone(), var_request_mutated.clone(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Orders_V2_Controller) save_object(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := this.prepare_object_for_database(var_request_mutated.clone(), creating)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_object.clone()])) {
		return var_object.clone()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_request_mutated.array_get(rt.new_string('customer_id')).is_null()) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_request_mutated.array_get(rt.new_string('customer_id')))))) {
		mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_8 := iife_temp_8.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('customer_id')))
		mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_9 := iife_temp_9.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('customer_id')))
		if rt.is_true(rt.call_function('is_wp_error', [iife_result_8])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_customer_id'), rt.call_function('__', [rt.new_string('Customer ID is invalid.'), rt.new_string('woocommerce')]), rt.new_int(400))))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_request_mutated.array_get(rt.new_string('customer_id'))]))))) {
			rt.call_function('add_user_to_blog', [rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_request_mutated.array_get(rt.new_string('customer_id')), rt.new_string('customer')])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_creating {
		rt.call_method(var_object, 'set_created_via', [rt.new_string('rest-api')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_object, 'set_prices_include_tax', [rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')]))])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_object, 'save', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_object, 'calculate_totals', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		if var_request_mutated.array_isset(rt.new_string('billing')) || var_request_mutated.array_isset(rt.new_string('shipping')) || var_request_mutated.array_isset(rt.new_string('line_items')) || var_request_mutated.array_isset(rt.new_string('shipping_lines')) || var_request_mutated.array_isset(rt.new_string('fee_lines')) || var_request_mutated.array_isset(rt.new_string('coupon_lines')) {
			rt.call_method(var_object, 'calculate_totals', [rt.new_bool(true)])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('status')))) {
		rt.call_method(var_object, 'set_status', [var_request_mutated.array_get(rt.new_string('status'))])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_object, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get(rt.new_string('set_paid')))) {
		if var_creating || rt.is_true(rt.call_method(var_object, 'needs_payment', []rt.PhpVal{})) {
			rt.call_method(var_object, 'payment_complete', [var_request_mutated.array_get(rt.new_string('transaction_id'))])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.new_bool(this.get_object(rt.call_method(var_object, 'get_id', []rt.PhpVal{})))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{})))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'WC_REST_Exception') {
		var_e = var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }])))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) update_address(var_order rt.PhpVal, var_posted rt.PhpVal, type string) {
	mut var_order_mutated := var_order
	mut iter_11 := var_posted.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_value := item_11.val
		mut var_key := item_11.key
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order_mutated }, rt.ArrayItem{ key: none, val: "set_${var_type}_${var_key.to_string()}" }])])) {
			rt.call_method(var_order_mutated, "set_${var_type}_${var_key.to_string()}", [var_value.clone()])
		}
	}
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_product_id(var_posted rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
	if !(!rt.is_true(var_posted.array_get(rt.new_string('sku')))) {
	mut var_product_id := rt.new_int((rt.call_function('wc_get_product_id_by_sku', [var_posted.array_get(rt.new_string('sku'))])).to_i64())
	} else if !(!rt.is_true(var_posted.array_get(rt.new_string('product_id')))) && !rt.is_true(var_posted.array_get(rt.new_string('variation_id'))) {
	var_product_id = rt.new_int((var_posted.array_get(rt.new_string('product_id'))).to_i64())
	} else if !(!rt.is_true(var_posted.array_get(rt.new_string('variation_id')))) {
	var_product_id = rt.new_int((var_posted.array_get(rt.new_string('variation_id'))).to_i64())
	} else if rt.is_true(rt.identical(rt.new_string('update'), rt.new_string(action_mutated))) {
	var_product_id = rt.new_int(0)
	} else {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_required_product_reference'), rt.call_function('__', [rt.new_string('Product ID or SKU is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	return var_product_id.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) maybe_set_item_prop(var_item rt.PhpVal, var_prop rt.PhpVal, var_posted rt.PhpVal) {
	mut var_item_mutated := var_item
	if var_posted.array_isset(var_prop) {
		rt.call_method(var_item_mutated, "set_${var_prop.to_string()}", [var_posted.array_get(var_prop)])
	}
}

fn (mut this Class_WC_REST_Orders_V2_Controller) maybe_set_item_props(var_item rt.PhpVal, var_props rt.PhpVal, var_posted rt.PhpVal) {
	mut var_item_mutated := var_item
	mut iter_12 := var_props.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_prop := item_12.val
		this.maybe_set_item_prop(var_item_mutated.clone(), var_prop.clone(), var_posted.clone())
	}
}

fn (mut this Class_WC_REST_Orders_V2_Controller) maybe_set_item_meta_data(var_item rt.PhpVal, var_posted rt.PhpVal) {
	mut var_item_mutated := var_item
mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
mut iife_result_10 := iife_temp_10.update(if !(var_posted.array_get(rt.new_string('meta_data'))).is_null() { var_posted.array_get(rt.new_string('meta_data')) } else { rt.new_null() }, var_item_mutated.clone())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_line_items(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_product(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') }) } else { var_item_mutated }
	mut var_product := rt.call_function('wc_get_product', [this.get_product_id(var_posted.clone(), action_mutated)])
	if rt.is_true(var_product) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_product, rt.call_method(var_item_mutated, 'get_product', []rt.PhpVal{}))))) {
		rt.call_method(var_item_mutated, 'set_product', [var_product.clone()])
		if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
			mut var_quantity := if var_posted.array_isset(rt.new_string('quantity')) { var_posted.array_get(rt.new_string('quantity')) } else { rt.new_int(1) }
			mut var_total := rt.call_function('wc_get_price_excluding_tax', [var_product.clone(), rt.create_array([rt.ArrayItem{ key: 'qty', val: var_quantity }])])
			rt.call_method(var_item_mutated, 'set_total', [var_total.clone()])
			rt.call_method(var_item_mutated, 'set_subtotal', [var_total.clone()])
		}
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'quantity' }, rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'subtotal' }, rt.ArrayItem{ key: none, val: 'tax_class' }]), var_posted.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_posted.clone())
	return var_item_mutated.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_shipping_lines(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_shipping(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') }) } else { var_item_mutated }
	if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
		if !rt.is_true(var_posted.array_get(rt.new_string('method_id'))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_shipping_item'), rt.call_function('__', [rt.new_string('Shipping method ID is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'method_id' }, rt.ArrayItem{ key: none, val: 'method_title' }, rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'instance_id' }]), var_posted.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_posted.clone())
	return var_item_mutated.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_fee_lines(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_fee(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') }) } else { var_item_mutated }
	if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
		if !rt.is_true(var_posted.array_get(rt.new_string('name'))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_fee_item'), rt.call_function('__', [rt.new_string('Fee name is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'tax_class' }, rt.ArrayItem{ key: none, val: 'tax_status' }, rt.ArrayItem{ key: none, val: 'total' }]), var_posted.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_posted.clone())
	return var_item_mutated.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) prepare_coupon_lines(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_coupon(if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) { var_posted.array_get(rt.new_string('id')) } else { rt.new_string('') }) } else { var_item_mutated }
	if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
		mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_11 := iife_temp_11.get_value_or_default(var_posted.clone(), rt.new_string('code'))
		mut var_coupon_code := iife_result_11
		mut iife_temp_12 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_12 := iife_temp_12.is_null_or_whitespace(var_coupon_code.clone())
		if rt.is_true(iife_result_12) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_coupon_coupon'), rt.call_function('__', [rt.new_string('Coupon code is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'code' }, rt.ArrayItem{ key: none, val: 'discount' }]), var_posted.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_posted.clone())
	return var_item_mutated.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) set_item(var_order rt.PhpVal, var_item_type rt.PhpVal, var_posted rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	if !(!rt.is_true(var_posted.array_get(rt.new_string('id')))) {
	mut var_action := rt.new_string('update')
	} else {
	var_action = rt.new_string('create')
	}
	mut var_method := rt.new_string('prepare_' + (var_item_type).str())
	mut var_item := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('update'), var_action)) {
		var_item = rt.call_method(var_order_mutated, 'get_item', [rt.call_function('absint', [var_posted.array_get(rt.new_string('id'))]), rt.new_bool(false)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('__', [rt.new_string('Order item ID provided is not associated with order.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	var_item = rt.call_method(rt.new_object('WC_REST_Orders_V2_Controller', ['WC_REST_CRUD_Controller'], &this), var_method, [var_posted.clone(), var_action.clone(), var_item.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_set_order_item'), var_item.clone(), var_posted.clone()])
	if rt.is_true(rt.identical(rt.new_string('create'), var_action)) {
		rt.call_method(var_order_mutated, 'add_item', [var_item.clone()])
	} else {
		rt.call_method(var_item, 'save', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string('line_items'), var_item_type)) && rt.is_true(rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() }]), rt.new_bool(true)])) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
		mut var_changed_stock := rt.call_function('wc_maybe_adjust_line_item_product_stock', [var_item.clone()])
		if rt.is_true(var_changed_stock) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_changed_stock.clone()]))))) {
			rt.call_method(var_order_mutated, 'add_order_note', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Adjusted stock: %s'), rt.new_string('woocommerce')]), rt.call_function('sprintf', [rt.new_string('%1$s (%2$s&rarr;%3$s)'), rt.call_method(var_item, 'get_name', []rt.PhpVal{}), var_changed_stock.array_get(rt.new_string('from')), var_changed_stock.array_get(rt.new_string('to'))])]), rt.new_bool(false), rt.new_bool(true)])
		}
	}
}

fn (mut this Class_WC_REST_Orders_V2_Controller) item_is_null(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_keys := ['product_id', 'method_id', 'method_title', 'name', 'code']
	for var_key in var_keys {
		if rt.is_true(rt.new_bool(var_item_mutated.clone().array_isset(rt.new_string(key)))) && var_item_mutated.array_get(rt.new_string(key)).is_null() {
			return true
		}
	}
	return false
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_order_statuses() rt.PhpVal {
	mut var_order_statuses := [Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()]
	mut iter_13 := rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_status := item_13.val
		var_order_statuses << rt.call_function('str_replace', [rt.new_string('wc-'), rt.new_string(''), var_status.clone()])
	}
	return var_order_statuses.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: this.post_type }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'parent_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Parent order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'number', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order number.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'order_key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'created_via', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows where the order was created.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'version', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Version of WooCommerce which last updated the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: 'enum', val: this.get_order_statuses() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'currency', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Currency the order was created with, in ISO format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was last modified, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'discount_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total discount amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'discount_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total discount tax amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total shipping amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total shipping tax amount for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'cart_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sum of line item taxes only.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Grand total, including tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sum of all taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'prices_include_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether prices included tax during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('User ID who owns the order. 0 for guests.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 0 }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'customer_ip_address', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Customer\'s IP address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_user_agent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('User agent of the customer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'customer_note', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Note left by customer during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'billing', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Billing address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Company name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('City name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ISO code or name of the state, province or district.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Postal code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code in ISO 3166-1 alpha-2 format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'format', val: 'email' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'phone', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Phone number.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'shipping', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Company name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('City name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ISO code or name of the state, province or district.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Postal code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code in ISO 3166-1 alpha-2 format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'payment_method', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment method ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'payment_method_title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment method title.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }, rt.ArrayItem{ key: 'transaction_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique transaction ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_paid', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was paid, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_paid_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was paid, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_completed', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was completed, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_completed_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order was completed, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'cart_hash', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('MD5 hash of cart items to ensure orders are not modified.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'line_items', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line items data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'parent_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Parent product name if the product is a variation.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'variation_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation ID, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Quantity ordered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax class of product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line subtotal, excluding tax (before discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'subtotal_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line subtotal tax (before discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total, excluding tax (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line total tax (after discounts).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax subtotal.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'display_key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key for UI display.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'display_value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value for UI display.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'sku', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product SKU.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'global_unique_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('GTIN, UPC, EAN or ISBN.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'image', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Properties of the main product image.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'src', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'tax_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax lines data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rate_code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rate_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate label.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'compound', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Show if is a compound tax rate.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'tax_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total (not including shipping taxes).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_tax_total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'shipping_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping lines data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'method_title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'method_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping method ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'instance_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping instance ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping total, excluding tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping total tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'fee_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fee lines data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fee name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax class of fee.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax status of fee.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'taxable' }, rt.ArrayItem{ key: none, val: 'none' }]) }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fee total, excluding tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fee total tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line taxes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax rate ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'subtotal', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax subtotal.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'coupon_lines', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupons line data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Item ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'discount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Discount total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'discount_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Discount total tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'discount_type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Discount type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'nominal_amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Discount amount as defined in the coupon (absolute value or a percent, depending on the discount type).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'free_shipping', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the coupon grants free shipping or not.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'refunds', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of refunds.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refund ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'reason', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refund reason.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refund total, including tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Refund total tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'payment_url', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order payment URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'set_paid', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Define if the order is paid. It will set the status to processing and reduce stock items.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'is_editable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether an order can be edited.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'needs_payment', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether an order needs payment, based on status and order total.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'needs_processing', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether an order needs processing before it can be completed.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_CRUD_Controller.get_collection_params()
	var_params.array_set('status', rt.create_array([rt.ArrayItem{ key: 'default', val: 'any' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders assigned a specific status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'any' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }]), this.get_order_statuses()]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('customer', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders assigned a specific customer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('product', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders assigned a specific product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('dp', rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of decimal points to use in each resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('order_item_display_meta', rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Only show meta which is meant to be displayed for an order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('include_meta', rt.create_array([rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit meta_data to specific keys.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }]))
	var_params.array_set('exclude_meta', rt.create_array([rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Ensure meta_data excludes specific keys.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }]))
	return var_params.clone()
}

fn (mut this Class_WC_REST_Orders_V2_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
	mut iife_temp_13 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_13 := iife_temp_13.custom_orders_table_usage_is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_13)))) {
		return this.Class_WC_REST_CRUD_Controller.get_objects(var_query_args.clone())
	}
	mut var_query := create_wc_order_query(rt.call_function('array_merge', [var_query_args.clone(), rt.create_array([rt.ArrayItem{ key: 'paginate', val: true }])]))
	mut var_results := var_query.get_orders()
	return rt.create_array([rt.ArrayItem{ key: 'objects', val: rt.get_property(var_results, 'orders') }, rt.ArrayItem{ key: 'total', val: rt.get_property(var_results, 'total') }, rt.ArrayItem{ key: 'pages', val: rt.get_property(var_results, 'max_num_pages') }])
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

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Product {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Fee {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_WC_Order_Query {
	rt.PhpObjectBase
}

fn create_wc_rest_orders_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Orders_V2_Controller {
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

fn create_wc_rest_crud_controller(_args ...rt.PhpVal) &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_WC_Order_Data_Store_CPT {
	mut obj := &Class_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception(_args ...rt.PhpVal) &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_metadatautil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_product(_args ...rt.PhpVal) &Class_WC_Order_Item_Product {
	mut obj := &Class_WC_Order_Item_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_shipping(_args ...rt.PhpVal) &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_fee(_args ...rt.PhpVal) &Class_WC_Order_Item_Fee {
	mut obj := &Class_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_coupon(_args ...rt.PhpVal) &Class_WC_Order_Item_Coupon {
	mut obj := &Class_WC_Order_Item_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_query(_args ...rt.PhpVal) &Class_WC_Order_Query {
	mut obj := &Class_WC_Order_Query{
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


fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Order_Item_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
