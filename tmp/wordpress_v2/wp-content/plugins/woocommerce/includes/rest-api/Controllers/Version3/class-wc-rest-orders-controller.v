import rt

struct Class_WC_REST_Orders_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Orders_Controller) calculate_coupons(var_request rt.PhpVal, var_order rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_order_mutated := var_order
	if !(var_request_mutated.array_isset(rt.new_string('coupon_lines'))) {
		return false
	}
	mut var_coupon_codes := []rt.PhpVal{}
	mut var_discounts := create_wc_discounts(var_order_mutated.clone())
	mut var_current_order_coupons := rt.call_function('array_values', [
		var_order_mutated.get_coupons()])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_coupon := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (rt.call_function('wc_strtolower', [var_coupon.get_code()])).to_bool()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_coupon := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (rt.call_function('wc_strtolower', [var_coupon.get_code()])).to_bool()
	}
	mut var_current_order_coupon_codes := rt.call_function('array_map', [
		rt.new_closure(closure_1_fn),
		var_current_order_coupons.clone(),
	])
	mut iter_1 := var_request_mutated.array_get(rt.new_string('coupon_lines')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if !(!rt.is_true(var_item.array_get(rt.new_string('id')))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_coupon_item_id_readonly'), rt.call_function('__', [
				rt.new_string('Coupon item ID is readonly.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(400))))
		}
		mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_2 := iife_temp_2.get_value_or_default(var_item.clone(),
			rt.new_string('code'))
		mut var_coupon_code := iife_result_2
		mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_3 := iife_temp_3.is_null_or_whitespace(var_coupon_code.clone())
		if rt.is_true(iife_result_3) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_coupon'), rt.call_function('__', [
				rt.new_string('Coupon code is required.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(400))))
		}
		var_coupon_code = rt.call_function('wc_format_coupon_code', [
			rt.call_function('wc_clean', [var_coupon_code.clone()]),
		])
		mut var_coupon := create_wc_coupon(var_coupon_code.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.call_function('wc_strtolower', [var_coupon_code.clone()]),
			var_current_order_coupon_codes.clone(),
			rt.new_bool(true),
		])))))
		{
			mut var_check_result := var_discounts.is_coupon_valid(rt.new_object('WC_Coupon',
				[]string{}, var_coupon))
			if rt.is_true(rt.call_function('is_wp_error', [var_check_result.clone()])) {
				rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(
					'woocommerce_rest_' +
					(rt.call_method(var_check_result, 'get_error_code', []rt.PhpVal{})).str(), rt.call_method(var_check_result,
					'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
			}
		}
		var_coupon_codes << var_coupon_code.clone()
	}
	mut iter_2 := var_order_mutated.get_items(rt.new_string('coupon')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_existing_coupon := item_2.val
		var_order_mutated.remove_coupon(rt.call_method(var_existing_coupon, 'get_code',
			[]rt.PhpVal{}))
	}
	for var_new_coupon in var_coupon_codes {
		mut var_results := var_order_mutated.apply_coupon(var_new_coupon.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_results.clone()])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(
				'woocommerce_rest_' +
				(rt.call_method(var_results, 'get_error_code', []rt.PhpVal{})).str(), rt.call_method(var_results,
				'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
		}
	}
	return true
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := if var_request_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [
			var_request_mutated.array_get(rt.new_string('id')),
		]) } else { rt.new_int(0) }
	mut var_order := create_wc_order(var_id.clone())
	mut var_schema := this.get_item_schema()
	mut var_data_keys := rt.func_array_keys(rt.call_function('array_filter', [
		var_schema.array_get(rt.new_string('properties')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_Controller', [
				'WC_REST_Orders_V2_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'filter_writable_props' },
		]),
	]))
	mut iter_3 := var_data_keys.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_key := item_3.val
		mut var_value := var_request_mutated.array_get(var_key)
		if !(var_value.clone().is_null()) {
			mut switch_val_1 := var_key
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('created_via'))) {
				if !var_creating {
					var_request_mutated.array_unset(var_key)
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_lines')))
				|| rt.is_true(rt.equal(switch_val_1, rt.new_string('status'))) {
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('billing')))
				|| rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping'))) {
				this.update_address(rt.new_object('WC_Order', []string{}, var_order),
					var_value.clone(), var_key.clone())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('line_items')))
				|| rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_lines')))
				|| rt.is_true(rt.equal(switch_val_1, rt.new_string('fee_lines'))) {
				if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
					mut iter_4 := var_value.iterator()
					for {
						item_4 := iter_4.next() or { break }
						mut var_item := item_4.val
						if rt.is_true(rt.new_bool(var_item.clone().is_array())) {
							if rt.is_true(this.item_is_null(var_item.clone()))
								|| (var_item.array_isset(rt.new_string('quantity'))
								&& rt.is_true(rt.identical(rt.new_int(0), var_item.array_get(rt.new_string('quantity'))))) {
								this.remove_item(mut var_order, var_key.str(),
									(var_item.array_get(rt.new_string('id'))).to_i64())
							} else {
								this.set_item(rt.new_object('WC_Order', []string{}, var_order),
									var_key.clone(), var_item.clone())
							}
						}
					}
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('meta_data'))) {
				mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
				mut iife_result_4 := iife_temp_4.update(var_value.clone(), rt.new_object('WC_Order',
					[]string{}, var_order))
			} else {
				if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_order },
						rt.ArrayItem{ key: none, val: 'set_${var_key.to_string()}' }]),
				]))
				{
					rt.call_method(var_order, 'set_${var_key.to_string()}', [
						var_value.clone()])
				}
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), rt.get_property(rt.new_object('WC_REST_Orders_Controller', [
			'WC_REST_Orders_V2_Controller',
		], &this), 'post_type')), rt.new_string('_object')),
		var_order,
		var_request_mutated.clone(),
		rt.new_bool(creating),
	])
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_line_items(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_prepared := this.Class_WC_REST_Orders_V2_Controller.prepare_line_items(var_posted.clone(),
		rt.new_string(action), var_item_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_prepared, 'has_cogs', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))) {
		return var_prepared.clone()
	}
	mut var_cogs_value := if !(var_posted.array_get(rt.new_string('cost_of_goods_sold')).array_get(rt.new_string('value'))).is_null() {
		var_posted.array_get(rt.new_string('cost_of_goods_sold')).array_get(rt.new_string('value'))
	} else {
		rt.new_null()
	}
	if !(var_cogs_value.clone().is_null()) {
		rt.call_method(var_prepared, 'set_cogs_value', [
			rt.new_float(var_cogs_value.to_f64()),
		])
	}
	return var_prepared.clone()
}

fn (mut this Class_WC_REST_Orders_Controller) remove_item(mut var_order Class_WC_Order, item_type string, item_id i64) {
	mut var_order_mutated := var_order
	mut var_item := var_order_mutated.get_item(rt.new_int(item_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('esc_html__', [
			rt.new_string('Order item ID provided is not associated with order.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	if rt.is_true(rt.identical(rt.new_string('line_items'), rt.new_string(item_type))) {
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
		rt.call_function('wc_maybe_adjust_line_item_product_stock', [
			var_item.clone(), rt.new_int(0)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_remove_order_item'),
		var_item.clone()])
	var_order_mutated.remove_item(rt.new_int(item_id))
}

fn (mut this Class_WC_REST_Orders_Controller) save_object(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_null()
	var_object = this.prepare_object_for_database(var_request_mutated.clone(), creating)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_object.clone()])) {
		return var_object.clone()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(var_request_mutated.array_get(rt.new_string('customer_id')).is_null())
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_request_mutated.array_get(rt.new_string('customer_id')))))) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_5 :=
			iife_temp_5.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('customer_id')))
		mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_6 :=
			iife_temp_6.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('customer_id')))
		if rt.is_true(rt.call_function('is_wp_error', [iife_result_5])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_customer_id'), rt.call_function('__', [
				rt.new_string('Customer ID is invalid.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(400))))
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_request_mutated.array_get(rt.new_string('customer_id'))]))))) {
			rt.call_function('add_user_to_blog', [
				rt.call_function('get_current_blog_id', []rt.PhpVal{}),
				var_request_mutated.array_get(rt.new_string('customer_id')),
				rt.new_string('customer'),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_creating {
		rt.call_method(var_object, 'set_created_via', [if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('created_via')))) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					var_request_mutated.array_get(rt.new_string('created_via')),
				]),
			]) } else { rt.new_string('rest-api') }])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_object, 'set_prices_include_tax', [
			rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
				rt.new_string('woocommerce_prices_include_tax'),
			])),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_object, 'save', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_object, 'calculate_totals', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else {
		if var_request_mutated.array_isset(rt.new_string('billing'))
			|| var_request_mutated.array_isset(rt.new_string('shipping'))
			|| var_request_mutated.array_isset(rt.new_string('line_items'))
			|| var_request_mutated.array_isset(rt.new_string('shipping_lines'))
			|| var_request_mutated.array_isset(rt.new_string('fee_lines'))
			|| var_request_mutated.array_isset(rt.new_string('coupon_lines')) {
			rt.call_method(var_object, 'calculate_totals', [rt.new_bool(true)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.calculate_coupons(var_request_mutated.clone(), var_object.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('status')))) {
		mut var_manual_update := if var_request_mutated.array_isset(rt.new_string('manual_update')) {
			var_request_mutated.array_get(rt.new_string('manual_update'))
		} else {
			rt.new_bool(false)
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_object, 'set_status', [var_request_mutated.array_get(rt.new_string('status')),
			rt.new_string(''), var_manual_update.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_object, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(true),
		var_request_mutated.array_get(rt.new_string('set_paid'))))
	{
		if var_creating || rt.is_true(rt.call_method(var_object, 'needs_payment', []rt.PhpVal{})) {
			rt.call_method(var_object, 'payment_complete', [
				var_request_mutated.array_get(rt.new_string('transaction_id')),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return this.get_object(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.clone()
		mut var_data := rt.call_method(var_e, 'getErrorData', []rt.PhpVal{})
		if var_creating && rt.is_true(var_object)
			&& rt.is_true(rt.call_method(var_object, 'get_id', []rt.PhpVal{})) {
			rt.call_method(var_object, 'set_status', [rt.new_string('checkout-draft')])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			rt.call_method(var_object, 'save', []rt.PhpVal{})
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			unsafe {
				goto end_label_2
			}
			catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'Exception') {
				mut var__ := var_e_2.clone()
				unsafe {
					goto end_label_2
				}
			} else {
				rt.throw_exception(var_e_2)
				unsafe {
					goto end_label_2
				}
			}

			end_label_2:
			var_data.array_set('new_draft_order_id', rt.call_method(var_object, 'get_id',
				[]rt.PhpVal{}))
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			var_data.clone()))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_statuses := var_request_mutated.array_get(rt.new_string('status'))
	var_request_mutated.array_unset(rt.new_string('status'))
	mut var_args :=
		this.Class_WC_REST_Orders_V2_Controller.prepare_objects_query(var_request_mutated.clone())
	var_args.array_set('post_status', []rt.PhpVal{})
	mut iter_5 := var_statuses.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_status := item_5.val
		if rt.is_true(rt.call_function('in_array', [var_status.clone(),
			this.get_order_statuses(), rt.new_bool(true)]))
		{
			var_args.array_get_mut('post_status').array_push('wc-' + var_status.str())
		} else if rt.is_true(rt.identical(rt.new_string('any'), var_status)) {
			var_args.array_set('post_status', 'any')
			break
		} else {
			var_args.array_get_mut('post_status').array_push(var_status.clone())
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('created_via')))) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_7 := iife_temp_7.custom_orders_table_usage_is_enabled()
		if rt.is_true(iife_result_7) {
			var_args.array_set('created_via',
				var_request_mutated.array_get(rt.new_string('created_via')))
		} else {
			var_args.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_created_via' },
				rt.ArrayItem{
					key: 'value'
					val: var_request_mutated.array_get(rt.new_string('created_via'))
				},
				rt.ArrayItem{ key: 'compare', val: 'IN' },
			]))
		}
	}
	var_request_mutated.array_set('status', var_statuses.clone())
	return var_args.clone()
}

fn (mut this Class_WC_REST_Orders_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WC_REST_Orders_V2_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_get_mut('created_via').array_set('readonly', false)
	var_schema.array_get_mut('properties').array_get_mut('coupon_lines').array_get_mut('items').array_get_mut('properties').array_get_mut('discount').array_set('readonly',
		true)
	var_schema.array_get_mut('properties').array_set('manual_update', rt.create_array([
		rt.ArrayItem{ key: 'default', val: false },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Set the action as manual so that the order note registers as "added by user".'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
	]))
	if rt.is_true(this.cogs_is_enabled()) {
		var_schema = this.add_cogs_related_schema(mut rt.cast_object_ptr[Class_array](var_schema))
	}
	return var_schema.clone()
}

fn (mut this Class_WC_REST_Orders_Controller) add_cogs_related_schema(mut var_schema Class_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	var_schema_mutated.array_get_mut('properties').array_set('cost_of_goods_sold', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Cost of Goods Sold data.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'total_value', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Total value of the Cost of Goods Sold for the order.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
		]) },
	]))
	var_schema_mutated.array_get_mut('properties').array_get_mut('line_items').array_get_mut('items').array_get_mut('properties').array_set('cost_of_goods_sold', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Cost of Goods Sold data. Only present for product line items.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'total_value', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Value of the Cost of Goods Sold for the order item.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
		]) },
	]))
	return rt.new_object('array', []string{}, var_schema_mutated)
}

fn (mut this Class_WC_REST_Orders_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Orders_V2_Controller.get_collection_params()
	var_params.array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'any' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to orders which have specific statuses.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'any' },
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash()
					}]),
				this.get_order_statuses(),
			]) },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('created_via', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to orders created via specific sources (e.g. checkout, admin).'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
	]))
	return var_params.clone()
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_object_for_response_core(var_order rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_request_mutated := var_request
	mut var_cogs_is_enabled := this.cogs_is_enabled()
	mut var_data := this.Class_WC_REST_Orders_V2_Controller.prepare_object_for_response_core(var_order_mutated.clone(),
		var_request_mutated.clone())
	if var_data.array_isset(rt.new_string('line_items')) {
		mut iter_6 := var_data.array_get(rt.new_string('line_items')).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_line_item_data := item_6.val
			if var_line_item_data.array_isset(rt.new_string('cogs_value')) {
				if rt.is_true(var_cogs_is_enabled) {
					var_line_item_data.array_get_mut('cost_of_goods_sold').array_set('value',
						var_line_item_data.array_get(rt.new_string('cogs_value')))
				}
				var_line_item_data.array_unset(rt.new_string('cogs_value'))
			}
		}
	}
	if rt.is_true(var_cogs_is_enabled) {
		var_data.array_get_mut('cost_of_goods_sold').array_set('total_value',
			var_order_mutated.get_cogs_total_value())
	}
	return var_data.clone()
}

struct Class_WC_REST_Orders_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Discounts {
	rt.PhpObjectBase
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_orders_controller(_args ...rt.PhpVal) &Class_WC_REST_Orders_Controller {
	mut obj := &Class_WC_REST_Orders_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_orders_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Orders_V2_Controller {
	mut obj := &Class_WC_REST_Orders_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_discounts(_args ...rt.PhpVal) &Class_WC_Discounts {
	mut obj := &Class_WC_Discounts{
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

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
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

fn create_automattic_woocommerce_utilities_metadatautil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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

fn (mut this Class_WC_REST_Orders_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'calculate_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.calculate_coupons(dispatch_arg_0, dispatch_arg_1))
		}
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_line_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_line_items(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'remove_item' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.remove_item(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'save_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.save_object(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'add_cogs_related_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_cogs_related_schema(mut dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_object_for_response_core' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response_core(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Orders_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Orders_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
