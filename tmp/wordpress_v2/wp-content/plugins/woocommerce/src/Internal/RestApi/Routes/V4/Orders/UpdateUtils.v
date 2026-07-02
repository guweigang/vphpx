import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils {
	rt.PhpObjectBase
pub mut:
	order_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) init(mut var_order_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema) {
	this.order_schema = var_order_schema
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_order_from_request(mut var_order Class_WC_Order, mut var_request Class_WP_REST_Request) {
	mut var_ignore_keys := rt.create_array([
		rt.ArrayItem{ key: none, val: 'created_via' },
		rt.ArrayItem{ key: none, val: 'status' },
		rt.ArrayItem{ key: none, val: 'customer_id' },
	])
	mut var_data_keys := rt.call_function('array_diff', [
		rt.func_array_keys(rt.call_method(this.order_schema, 'get_writable_item_schema_properties',
			[]rt.PhpVal{})),
		var_ignore_keys.clone(),
	])
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	mut iter_1 := var_data_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		mut var_value := var_request.array_get(var_key)
		if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('billing'), var_key))
			|| rt.is_true(rt.identical(rt.new_string('shipping'), var_key)) {
			this.update_address(mut var_order, var_key.str(), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)))
		} else if rt.is_true(rt.identical(rt.new_string('coupon_lines'), var_key)) {
			this.update_line_items(mut var_order, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)),
				(Class_Automattic_WooCommerce_Enums_OrderItemType.coupon()).str())
		} else if rt.is_true(rt.identical(rt.new_string('line_items'), var_key)) {
			this.update_line_items(mut var_order, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)),
				(Class_Automattic_WooCommerce_Enums_OrderItemType.line_item()).str())
		} else if rt.is_true(rt.identical(rt.new_string('shipping_lines'), var_key)) {
			this.update_line_items(mut var_order, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)),
				(Class_Automattic_WooCommerce_Enums_OrderItemType.shipping()).str())
		} else if rt.is_true(rt.identical(rt.new_string('fee_lines'), var_key)) {
			this.update_line_items(mut var_order, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)),
				(Class_Automattic_WooCommerce_Enums_OrderItemType.fee()).str())
		} else if rt.is_true(rt.identical(rt.new_string('meta_data'), var_key)) {
			this.update_meta_data(mut var_order, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)))
		} else if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_order },
				rt.ArrayItem{ key: none, val: 'set_${var_key.to_string()}' }]),
		]))
		{
			rt.call_method(var_order, 'set_${var_key.to_string()}', [
				var_value.clone()])
		}
	}
	if !(var_request.array_get(rt.new_string('customer_id')).is_null())
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_request.array_get(rt.new_string('customer_id')))))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_0 :=
			iife_temp_0.get_user_in_current_site(var_request.array_get(rt.new_string('customer_id')))
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_1 :=
			iife_temp_1.get_user_in_current_site(var_request.array_get(rt.new_string('customer_id')))
		if rt.is_true(rt.call_function('is_wp_error', [iife_result_0])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_customer_id'), rt.call_function('esc_html__', [
				rt.new_string('Customer ID is invalid.'),
				rt.new_string('woocommerce'),
			]), rt.new_int((Class_WP_Http.bad_request()).to_i64()))))
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_request.array_get(rt.new_string('customer_id'))]))))) {
			rt.call_function('add_user_to_blog', [
				rt.call_function('get_current_blog_id', []rt.PhpVal{}),
				var_request.array_get(rt.new_string('customer_id')),
				rt.new_string('customer'),
			])
		}
		var_order.set_customer_id(rt.new_int((var_request.array_get(rt.new_string('customer_id'))).to_i64()))
	}
	var_order.save()
	if var_request.array_isset(rt.new_string('billing'))
		|| var_request.array_isset(rt.new_string('shipping'))
		|| var_request.array_isset(rt.new_string('line_items'))
		|| var_request.array_isset(rt.new_string('shipping_lines'))
		|| var_request.array_isset(rt.new_string('fee_lines')) {
		var_order.calculate_totals(rt.new_bool(true))
	}
	if var_request.array_isset(rt.new_string('coupon_lines')) {
		var_order.recalculate_coupons()
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('status')))) {
		var_order.set_status(var_request.array_get(rt.new_string('status')), rt.new_string(''),
			rt.new_bool(true))
		var_order.save()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_address(mut var_order Class_WC_Order, type string, mut var_request_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array) {
	mut iter_2 := var_request_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_order },
				rt.ArrayItem{ key: none, val: 'set_${var_type}_${var_key.to_string()}' }]),
		]))
		{
			rt.call_method(var_order, 'set_${var_type}_${var_key.to_string()}', [
				var_value.clone(),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_meta_data(mut var_order Class_WC_Order, mut var_meta_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array) {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_2 := iife_temp_2.update(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array',
		[]string{}, var_meta_data), rt.new_object('WC_Order', []string{}, var_order))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_line_items(mut var_order Class_WC_Order, mut var_line_items Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array, line_items_type string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(line_items_type),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderItemType.line_item()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderItemType.shipping()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.fee() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.coupon() },
		]),
		rt.new_bool(true),
	])))))
	{
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_line_items_type'), rt.call_function('esc_html__', [
			rt.new_string('Invalid line items type.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	mut var_existing_items := var_order.get_items(rt.new_string(line_items_type))
	mut var_processed_item_ids := rt.new_array()
	mut iter_3 := var_line_items.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_line_item_data := item_3.val
		if !(var_line_item_data.clone().is_array()) {
			continue
		}
		if this.item_is_null_or_zero(var_line_item_data.clone()) {
			if rt.is_true(var_line_item_data.array_get(rt.new_string('id'))) {
				this.remove_item_from_order(mut var_order, line_items_type,
					rt.new_int((var_line_item_data.array_get(rt.new_string('id'))).to_i64()))
			}
			continue
		}
		var_processed_item_ids.array_push(this.update_line_item(mut var_order, line_items_type, mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](var_line_item_data)))
	}
	mut iter_4 := var_existing_items.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_existing_item := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.call_method(var_existing_item, 'get_id', []rt.PhpVal{}),
			var_processed_item_ids.clone(),
			rt.new_bool(true),
		])))))
		{
			this.remove_item_from_order(mut var_order, line_items_type, (rt.call_method(var_existing_item,
				'get_id', []rt.PhpVal{})).to_i64())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_line_item(mut var_order Class_WC_Order, line_items_type string, mut var_line_item_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_action := rt.new_string((if !rt.is_true(var_line_item_data.array_get(rt.new_string('id'))) {
		'create'
	} else {
		'update'
	}).str())
	mut var_method := rt.new_string('prepare_' + line_items_type + '_data')
	mut var_item := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('update'), var_action)) {
		var_item = var_order.get_item(rt.call_function('absint', [
			var_line_item_data.array_get(rt.new_string('id')),
		]), rt.new_bool(false))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('esc_html__', [
				rt.new_string('Order item ID provided is not associated with order.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(400))))
		}
	}
	var_item = rt.call_method(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils',
		[]string{}, &this), var_method, [var_line_item_data, var_action.clone(),
		var_item.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_set_order_item'),
		var_item.clone(), var_line_item_data])
	if rt.is_true(rt.identical(rt.new_string('create'), var_action)) {
		var_order.add_item(var_item.clone())
	} else {
		rt.call_method(var_item, 'save', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(), rt.new_string(line_items_type)))
		&& rt.is_true(rt.call_function('in_array', [var_order.get_status(), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
	}, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
	}]), rt.new_bool(true)])) {
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
		mut var_changed_stock := rt.call_function('wc_maybe_adjust_line_item_product_stock', [
			var_item.clone(),
		])
		if rt.is_true(var_changed_stock)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_changed_stock.clone()]))))) {
			var_order.add_order_note(rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Adjusted stock: %s.'),
					rt.new_string('woocommerce')]),
				rt.call_function('sprintf', [rt.new_string('%1$s (%2$s&rarr;%3$s)'),
					rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
					var_changed_stock.array_get(rt.new_string('from')),
					var_changed_stock.array_get(rt.new_string('to'))]),
			]), rt.new_bool(false), rt.new_bool(true), rt.create_array([
				rt.ArrayItem{
					key: 'note_group'
					val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock()
				},
			]))
		}
	}
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) item_is_null_or_zero(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'product_id' },
		rt.ArrayItem{ key: none, val: 'method_id' }, rt.ArrayItem{ key: none, val: 'method_title' },
		rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'code' }])
	mut iter_5 := var_keys.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_key := item_5.val
		if rt.is_true(rt.new_bool(var_item_mutated.clone().array_isset(var_key.clone())))
			&& var_item_mutated.array_get(var_key).is_null() {
			return true
		}
	}
	if rt.is_true(rt.new_bool(var_item_mutated.clone().array_isset(rt.new_string('quantity'))))
		&& rt.is_true(rt.identical(rt.new_int(0), var_item_mutated.array_get(rt.new_string('quantity')))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) remove_item_from_order(mut var_order Class_WC_Order, line_items_type string, item_id i64) {
	mut var_item := var_order.get_item(rt.new_int(item_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('esc_html__', [
			rt.new_string('Order item ID provided is not associated with order.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(),
		rt.new_string(line_items_type)))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
		rt.call_function('wc_maybe_adjust_line_item_product_stock', [
			var_item.clone(), rt.new_int(0)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_remove_order_item'),
		var_item.clone()])
	var_order.remove_item(rt.new_int(item_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) get_product_id_from_line_item(var_request_data rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('sku')))) {
		mut var_product_id := rt.new_int((rt.call_function('wc_get_product_id_by_sku', [
			var_request_data.array_get(rt.new_string('sku')),
		])).to_i64())
	} else if !(!rt.is_true(var_request_data.array_get(rt.new_string('product_id'))))
		&& !rt.is_true(var_request_data.array_get(rt.new_string('variation_id'))) {
		var_product_id =
			rt.new_int((var_request_data.array_get(rt.new_string('product_id'))).to_i64())
	} else if !(!rt.is_true(var_request_data.array_get(rt.new_string('variation_id')))) {
		var_product_id =
			rt.new_int((var_request_data.array_get(rt.new_string('variation_id'))).to_i64())
	} else if rt.is_true(rt.identical(rt.new_string('update'), rt.new_string(action_mutated))) {
		var_product_id = rt.new_int(0)
	} else {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_required_product_reference'), rt.call_function('esc_html__', [
			rt.new_string('Product ID or SKU is required.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	return var_product_id.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_line_item_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_product(if !(!rt.is_true(var_request_data.array_get(rt.new_string('id')))) {
			var_request_data.array_get(rt.new_string('id'))
		} else {
			rt.new_string('')
		})
	 } else { var_item_mutated
	 }
	mut var_product := rt.call_function('wc_get_product', [
		this.get_product_id_from_line_item(var_request_data.clone(), action_mutated),
	])
	if rt.is_true(var_product)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_product, rt.call_method(var_item_mutated, 'get_product', []rt.PhpVal{}))))) {
		rt.call_method(var_item_mutated, 'set_product', [var_product.clone()])
		if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
			mut var_quantity := if var_request_data.array_isset(rt.new_string('quantity')) {
				var_request_data.array_get(rt.new_string('quantity'))
			} else {
				rt.new_int(1)
			}
			mut var_total := rt.call_function('wc_get_price_excluding_tax', [
				var_product.clone(), rt.create_array([
					rt.ArrayItem{ key: 'qty', val: var_quantity },
				])])
			rt.call_method(var_item_mutated, 'set_total', [var_total.clone()])
			rt.call_method(var_item_mutated, 'set_subtotal', [
				var_total.clone()])
		}
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'name' },
		rt.ArrayItem{ key: none, val: 'quantity' },
		rt.ArrayItem{ key: none, val: 'total' },
		rt.ArrayItem{ key: none, val: 'subtotal' },
		rt.ArrayItem{ key: none, val: 'tax_class' },
	]), var_request_data.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_request_data.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'has_cogs', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))) {
		return var_item_mutated.clone()
	}
	mut var_cogs_value := if !(var_request_data.array_get(rt.new_string('cost_of_goods_sold')).array_get(rt.new_string('total_value'))).is_null() {
		var_request_data.array_get(rt.new_string('cost_of_goods_sold')).array_get(rt.new_string('total_value'))
	} else {
		rt.new_null()
	}
	if !(var_cogs_value.clone().is_null()) {
		rt.call_method(var_item_mutated, 'set_cogs_value', [
			rt.new_float(var_cogs_value.to_f64()),
		])
	}
	return var_item_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_shipping_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_shipping(if !(!rt.is_true(var_request_data.array_get(rt.new_string('id')))) {
			var_request_data.array_get(rt.new_string('id'))
		} else {
			rt.new_string('')
		})
	 } else { var_item_mutated
	 }
	if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated)))
		&& !rt.is_true(var_request_data.array_get(rt.new_string('method_id'))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_shipping_item'), rt.call_function('esc_html__', [
			rt.new_string('Shipping method ID is required.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'method_id' },
		rt.ArrayItem{ key: none, val: 'method_title' },
		rt.ArrayItem{ key: none, val: 'total' },
		rt.ArrayItem{ key: none, val: 'instance_id' },
	]), var_request_data.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_request_data.clone())
	return var_item_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_fee_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_fee(if !(!rt.is_true(var_request_data.array_get(rt.new_string('id')))) {
			var_request_data.array_get(rt.new_string('id'))
		} else {
			rt.new_string('')
		})
	 } else { var_item_mutated
	 }
	if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated)))
		&& !rt.is_true(var_request_data.array_get(rt.new_string('name'))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_fee_item'), rt.call_function('esc_html__', [
			rt.new_string('Fee name is required.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'name' },
		rt.ArrayItem{ key: none, val: 'tax_class' },
		rt.ArrayItem{ key: none, val: 'tax_status' },
		rt.ArrayItem{ key: none, val: 'total' },
	]), var_request_data.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_request_data.clone())
	return var_item_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_coupon_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if var_item_mutated.clone().is_null() { create_wc_order_item_coupon(if !(!rt.is_true(var_request_data.array_get(rt.new_string('id')))) {
			var_request_data.array_get(rt.new_string('id'))
		} else {
			rt.new_string('')
		})
	 } else { var_item_mutated
	 }
	if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_3 := iife_temp_3.get_value_or_default(var_request_data.clone(),
			rt.new_string('code'))
		mut var_coupon_code := iife_result_3
		mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_4 := iife_temp_4.is_null_or_whitespace(var_coupon_code.clone())
		if rt.is_true(iife_result_4) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_coupon_coupon'), rt.call_function('esc_html__', [
				rt.new_string('Coupon code is required.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(400))))
		}
	}
	this.maybe_set_item_props(var_item_mutated.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'code' },
		rt.ArrayItem{ key: none, val: 'discount' },
	]), var_request_data.clone())
	this.maybe_set_item_meta_data(var_item_mutated.clone(), var_request_data.clone())
	return var_item_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) maybe_set_item_prop(var_item rt.PhpVal, var_prop rt.PhpVal, var_request_data rt.PhpVal) {
	mut var_item_mutated := var_item
	if var_request_data.array_isset(var_prop)
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_item_mutated
	}, rt.ArrayItem{ key: none, val: 'set_${var_prop.to_string()}' }])]) {
		rt.call_method(var_item_mutated, 'set_${var_prop.to_string()}', [
			var_request_data.array_get(var_prop),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) maybe_set_item_props(var_item rt.PhpVal, var_props rt.PhpVal, var_request_data rt.PhpVal) {
	mut var_item_mutated := var_item
	mut iter_6 := var_props.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_prop := item_6.val
		this.maybe_set_item_prop(var_item_mutated.clone(), var_prop.clone(),
			var_request_data.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) maybe_set_item_meta_data(var_item rt.PhpVal, var_request_data rt.PhpVal) {
	mut var_item_mutated := var_item
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('meta_data'))))
		&& var_request_data.array_get(rt.new_string('meta_data')).is_array() {
		mut iter_7 := var_request_data.array_get(rt.new_string('meta_data')).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_meta := item_7.val
			if var_meta.array_isset(rt.new_string('key')) {
				mut var_value := if var_meta.array_isset(rt.new_string('value')) {
					var_meta.array_get(rt.new_string('value'))
				} else {
					rt.new_null()
				}
				rt.call_method(var_item_mutated, 'update_meta_data', [
					var_meta.array_get(rt.new_string('key')),
					var_value.clone(),
					if var_meta.array_isset(rt.new_string('id')) {
						var_meta.array_get(rt.new_string('id'))
					} else {
						rt.new_string('')
					},
				])
			}
		}
	}
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

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_updateutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
		order_schema:  rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_order_from_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.update_order_from_request(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'update_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.update_address(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'update_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.update_meta_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'update_line_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.update_line_items(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_line_item' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.update_line_item(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'item_is_null_or_zero' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.item_is_null_or_zero(dispatch_arg_0))
		}
		'remove_item_from_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.remove_item_from_order(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_product_id_from_line_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_product_id_from_line_item(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_line_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_line_item_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_shipping_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_shipping_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_fee_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_fee_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_coupon_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_coupon_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_schema' { return this.order_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_schema' {
			this.order_schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
