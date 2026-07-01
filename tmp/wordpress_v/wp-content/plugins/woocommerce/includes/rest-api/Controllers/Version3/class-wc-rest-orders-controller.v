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
	mut var_discounts := create_wc_discounts(var_order_mutated.dup())
	mut var_current_order_coupons := rt.call_function('array_values', [var_order_mutated.get_coupons()])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_coupon := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.call_function('wc_strtolower', [var_coupon.get_code()])).to_bool()
	}
	mut var_coupon := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.call_function('wc_strtolower', [var_coupon.get_code()])).to_bool()
	}
	mut var_current_order_coupon_codes := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_current_order_coupons.dup()])
	{
		mut iter_1 := var_request_mutated.array_get('coupon_lines').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if !(!rt.is_true(var_item.array_get('id'))) {
				rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_coupon_item_id_readonly'), rt.call_function('__', [rt.new_string('Coupon item ID is readonly.'), rt.new_string('woocommerce')]), rt.new_int(400))))
			}
			mut var_coupon_code := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.get_value_or_default(arg_0, arg_1) }(var_item.dup(), rt.new_string('code'))
			if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.is_null_or_whitespace(arg_0) }(var_coupon_code.dup())) {
				rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_coupon'), rt.call_function('__', [rt.new_string('Coupon code is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
			}
			var_coupon_code = rt.call_function('wc_format_coupon_code', [rt.call_function('wc_clean', [var_coupon_code.dup()])])
			mut var_coupon := create_wc_coupon(var_coupon_code.dup())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('wc_strtolower', [var_coupon_code.dup()]), var_current_order_coupon_codes.dup(), rt.new_bool(true)]))))) {
				mut var_check_result := var_discounts.is_coupon_valid(rt.new_object('WC_Coupon', []string{}, var_coupon))
				if rt.is_true(rt.call_function('is_wp_error', [var_check_result.dup()])) {
					rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception('woocommerce_rest_' + (rt.call_method(var_check_result, 'get_error_code', []rt.PhpVal{})).str(), rt.call_method(var_check_result, 'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
				}
			}
			var_coupon_codes << var_coupon_code.dup()
		}
	}
	{
		mut iter_1 := var_order_mutated.get_items(rt.new_string('coupon')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_existing_coupon := item_1.val
			var_order_mutated.remove_coupon(rt.call_method(var_existing_coupon, 'get_code', []rt.PhpVal{}))
		}
	}
	for var_new_coupon in var_coupon_codes {
		mut var_results := var_order_mutated.apply_coupon(var_new_coupon.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_results.dup()])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception('woocommerce_rest_' + (rt.call_method(var_results, 'get_error_code', []rt.PhpVal{})).str(), rt.call_method(var_results, 'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
		}
	}
	return true
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := if var_request_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_request_mutated.array_get('id')]) } else { rt.new_int(0) }
	mut var_order := create_wc_order(var_id.dup())
	mut var_schema := this.get_item_schema()
	mut var_data_keys := rt.func_array_keys(rt.call_function('array_filter', [var_schema.array_get('properties'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Orders_Controller', ['WC_REST_Orders_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'filter_writable_props' }])]))
	{
		mut iter_1 := var_data_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			mut var_value := var_request_mutated.array_get(var_key)
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_null()))))) {
				mut switch_val_1 := var_key
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('created_via'))) {
					if !(var_creating) {
						var_request_mutated.array_unset(var_key)
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_lines'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('status'))) {
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('billing'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping'))) {
					this.update_address(rt.new_object('WC_Order', []string{}, var_order), var_value.dup(), var_key.dup())
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('line_items'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_lines'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('fee_lines'))) {
					if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
						{
							mut iter_2 := var_value.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_item := item_2.val
								if rt.is_true(rt.new_bool(var_item.dup().is_array())) {
									if rt.is_true(rt.new_bool(rt.is_true(this.item_is_null(var_item.dup())) || rt.is_true(rt.new_bool(var_item.array_isset(rt.new_string('quantity')) && rt.is_true(rt.identical(rt.new_int(0), var_item.array_get('quantity'))))))) {
										this.remove_item(mut var_order, (var_key).str(), (var_item.array_get('id')).to_i64())
									} else {
										this.set_item(rt.new_object('WC_Order', []string{}, var_order), var_key.dup(), var_item.dup())
									}
								}
							}
						}
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('meta_data'))) {
					fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1) }(var_value.dup(), rt.new_object('WC_Order', []string{}, var_order))
				} else {
					if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: "set_${var_key.to_string()}" }])])) {
						rt.call_method(var_order, "set_${var_key.to_string()}", [var_value.dup()])
					}
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), rt.get_property(rt.new_object('WC_REST_Orders_Controller', ['WC_REST_Orders_V2_Controller'], &this), 'post_type')), rt.new_string('_object')), var_order, var_request_mutated.dup(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_line_items(var_posted rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_prepared := this.Class_WC_REST_Orders_V2_Controller.prepare_line_items(var_posted.dup(), rt.new_string(action), var_item_mutated.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_prepared, 'has_cogs', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))))) {
		return var_prepared.dup()
	}
	mut var_cogs_value := if !(var_posted.array_get('cost_of_goods_sold').array_get('value')).is_null() { var_posted.array_get('cost_of_goods_sold').array_get('value') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cogs_value.dup().is_null()))))) {
		rt.call_method(var_prepared, 'set_cogs_value', [// unsupported expression: Expr_Cast_Double])
	}
	return var_prepared.dup()
}

fn (mut this Class_WC_REST_Orders_Controller) remove_item(mut var_order Class_WC_Order, item_type string, item_id i64)  {
	mut var_order_mutated := var_order
	mut var_item := var_order_mutated.get_item(rt.new_int(item_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('esc_html__', [rt.new_string('Order item ID provided is not associated with order.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	if rt.is_true(rt.identical(rt.new_string('line_items'), rt.new_string(item_type))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
		rt.call_function('wc_maybe_adjust_line_item_product_stock', [var_item.dup(), rt.new_int(0)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_remove_order_item'), var_item.dup()])
	var_order_mutated.remove_item(rt.new_int(item_id))
}

fn (mut this Class_WC_REST_Orders_Controller) save_object(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_object := rt.new_null()
	var_object = this.prepare_object_for_database(var_request_mutated.dup(), creating)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_object.dup()])) {
		return var_object.dup()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_request_mutated.array_get('customer_id').is_null()))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if rt.is_true(rt.call_function('is_wp_error', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_user_in_current_site(arg_0) }(var_request_mutated.array_get('customer_id'))])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_customer_id'), rt.call_function('__', [rt.new_string('Customer ID is invalid.'), rt.new_string('woocommerce')]), rt.new_int(400))))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_request_mutated.array_get('customer_id')]))))))) {
			rt.call_function('add_user_to_blog', [rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_request_mutated.array_get('customer_id'), rt.new_string('customer')])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_creating {
		rt.call_method(var_object, 'set_created_via', [if !(!rt.is_true(var_request_mutated.array_get('created_via'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [var_request_mutated.array_get('created_via')])]) } else { rt.new_string('rest-api') }])
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
	this.calculate_coupons(var_request_mutated.dup(), var_object.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(var_request_mutated.array_get('status'))) {
		mut var_manual_update := if var_request_mutated.array_isset(rt.new_string('manual_update')) { var_request_mutated.array_get('manual_update') } else { rt.new_bool(false) }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_object, 'set_status', [var_request_mutated.array_get('status'), rt.new_string(''), var_manual_update.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_object, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get('set_paid'))) {
		if rt.is_true(rt.new_bool(var_creating || rt.is_true(rt.call_method(var_object, 'needs_payment', []rt.PhpVal{})))) {
			rt.call_method(var_object, 'payment_complete', [var_request_mutated.array_get('transaction_id')])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return this.get_object(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.dup()
		mut var_data := rt.call_method(var_e, 'getErrorData', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_creating && rt.is_true(var_object))) && rt.is_true(rt.call_method(var_object, 'get_id', []rt.PhpVal{})))) {
			rt.call_method(var_object, 'set_status', [rt.new_string('checkout-draft')])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			rt.call_method(var_object, 'save', []rt.PhpVal{})
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			// unsupported statement: Stmt_Nop
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'Exception') {
				mut var__ := var_e_2.dup()
				// unsupported statement: Stmt_Nop
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
			var_data.array_set('new_draft_order_id', rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
		}
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), var_data.dup())
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_statuses := var_request_mutated.array_get('status')
	var_request_mutated.array_unset(rt.new_string('status'))
	mut var_args := this.Class_WC_REST_Orders_V2_Controller.prepare_objects_query(var_request_mutated.dup())
	var_args.array_set('post_status', []rt.PhpVal{})
	{
		mut iter_1 := var_statuses.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_status.dup(), this.get_order_statuses(), rt.new_bool(true)])) {
				var_args.array_get_mut('post_status').array_push('wc-' + (var_status).str())
			} else if rt.is_true(rt.identical(rt.new_string('any'), var_status)) {
				var_args.array_set('post_status', 'any')
				break
			} else {
				var_args.array_get_mut('post_status').array_push(var_status.dup())
			}
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get('created_via'))) {
		if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()) {
			var_args.array_set('created_via', var_request_mutated.array_get('created_via'))
		} else {
			var_args.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_created_via' }, rt.ArrayItem{ key: 'value', val: var_request_mutated.array_get('created_via') }, rt.ArrayItem{ key: 'compare', val: 'IN' }]))
		}
	}
	var_request_mutated.array_set('status', var_statuses.dup())
	return var_args.dup()
}

fn (mut this Class_WC_REST_Orders_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WC_REST_Orders_V2_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_get_mut('created_via').array_set('readonly', false)
	.array_get_mut().array_get_mut().array_get_mut().array_get_mut().array_get_mut().array_set(, )
	
}

fn (mut this Class_WC_REST_Orders_Controller) add_cogs_related_schema(mut var_schema Class_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
}

fn (mut this Class_WC_REST_Orders_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Orders_Controller) prepare_object_for_response_core(var_order rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_request_mutated := var_request
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

fn create_wc_rest_orders_controller() &Class_WC_REST_Orders_Controller {
	mut obj := &Class_WC_REST_Orders_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_orders_v2_controller() &Class_WC_REST_Orders_V2_Controller {
	mut obj := &Class_WC_REST_Orders_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_discounts() &Class_WC_Discounts {
	mut obj := &Class_WC_Discounts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception() &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
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

fn create_wc_order() &Class_WC_Order {
	mut obj := &Class_WC_Order{
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

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
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

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'namespace' { this.namespace = val; return true }
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



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_orders_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
