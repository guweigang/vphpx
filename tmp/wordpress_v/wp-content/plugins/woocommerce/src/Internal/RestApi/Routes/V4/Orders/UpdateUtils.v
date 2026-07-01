import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils {
	rt.PhpObjectBase
pub mut:
		order_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) init(mut var_order_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema)  {
	this.order_schema = var_order_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_order_from_request(mut var_order Class_WC_Order, mut var_request Class_WP_REST_Request)  {
	mut var_ignore_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'created_via' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'customer_id' }])
	mut var_data_keys := rt.call_function('array_diff', [rt.func_array_keys(rt.call_method(this.order_schema, 'get_writable_item_schema_properties', []rt.PhpVal{})), var_ignore_keys.dup()])
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	{
		mut iter_1 := var_data_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			mut var_value := var_request.array_get(var_key)
			if rt.is_true(rt.new_bool(var_value.dup().is_null())) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('billing'), var_key)) || rt.is_true(rt.identical(rt.new_string('shipping'), var_key)))) {
				this.update_address(mut var_order, (var_key).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)))
			} else if rt.is_true(rt.identical(rt.new_string('coupon_lines'), var_key)) {
				this.update_line_items(mut var_order, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)), (Class_Automattic_WooCommerce_Enums_OrderItemType.coupon()).str())
			} else if rt.is_true(rt.identical(rt.new_string('line_items'), var_key)) {
				this.update_line_items(mut var_order, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)), (Class_Automattic_WooCommerce_Enums_OrderItemType.line_item()).str())
			} else if rt.is_true(rt.identical(rt.new_string('shipping_lines'), var_key)) {
				this.update_line_items(mut var_order, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)), (Class_Automattic_WooCommerce_Enums_OrderItemType.shipping()).str())
			} else if rt.is_true(rt.identical(rt.new_string('fee_lines'), var_key)) {
				this.update_line_items(mut var_order, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)), (Class_Automattic_WooCommerce_Enums_OrderItemType.fee()).str())
			} else if rt.is_true(rt.identical(rt.new_string('meta_data'), var_key)) {
				this.update_meta_data(mut var_order, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](rt.cast_array(var_value)))
			} else if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: "set_${var_key.to_string()}" }])])) {
				rt.call_method(var_order, "set_${var_key.to_string()}", [var_value.dup()])
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_request.array_get('customer_id').is_null()))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if rt.is_true(rt.call_function('is_wp_error', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_user_in_current_site(arg_0) }(var_request.array_get('customer_id'))])) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_customer_id'), rt.call_function('esc_html__', [rt.new_string('Customer ID is invalid.'), rt.new_string('woocommerce')]), // unsupported expression: Expr_Cast_Int)))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_request.array_get('customer_id')]))))))) {
			rt.call_function('add_user_to_blog', [rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_request.array_get('customer_id'), rt.new_string('customer')])
		}
		var_order.set_customer_id(// unsupported expression: Expr_Cast_Int)
	}
	var_order.save()
	if var_request.array_isset(rt.new_string('billing')) || var_request.array_isset(rt.new_string('shipping')) || var_request.array_isset(rt.new_string('line_items')) || var_request.array_isset(rt.new_string('shipping_lines')) || var_request.array_isset(rt.new_string('fee_lines')) {
		var_order.calculate_totals(rt.new_bool(true))
	}
	if var_request.array_isset(rt.new_string('coupon_lines')) {
		var_order.recalculate_coupons()
	}
	if !(!rt.is_true(var_request.array_get('status'))) {
		var_order.set_status(var_request.array_get('status'), rt.new_string(''), rt.new_bool(true))
		var_order.save()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_address(mut var_order Class_WC_Order, type string, mut var_request_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array)  {
	{
		mut iter_1 := var_request_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: "set_${var_type}_${var_key.to_string()}" }])])) {
				rt.call_method(var_order, "set_${var_type}_${var_key.to_string()}", [var_value.dup()])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_meta_data(mut var_order Class_WC_Order, mut var_meta_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array', []string{}, var_meta_data), rt.new_object('WC_Order', []string{}, var_order))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_line_items(mut var_order Class_WC_Order, mut var_line_items Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array, line_items_type string)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(line_items_type), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.line_item() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.shipping() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.fee() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.coupon() }]), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_line_items_type'), rt.call_function('esc_html__', [rt.new_string('Invalid line items type.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	mut var_existing_items := var_order.get_items(rt.new_string(line_items_type))
	mut var_processed_item_ids := rt.new_array()
	{
		mut iter_1 := var_line_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line_item_data := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_line_item_data.dup().is_array()))))) {
				continue
			}
			if this.item_is_null_or_zero(var_line_item_data.dup()) {
				if rt.is_true(var_line_item_data.array_get('id')) {
					this.remove_item_from_order(mut var_order, line_items_type, (// unsupported expression: Expr_Cast_Int).to_i64())
				}
				continue
			}
			var_processed_item_ids.array_push(this.update_line_item(mut var_order, line_items_type, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](var_line_item_data)))
		}
	}
	{
		mut iter_1 := var_existing_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_existing_item := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_existing_item, 'get_id', []rt.PhpVal{}), var_processed_item_ids.dup(), rt.new_bool(true)]))))) {
				this.remove_item_from_order(mut var_order, line_items_type, (rt.call_method(var_existing_item, 'get_id', []rt.PhpVal{})).to_i64())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) update_line_item(mut var_order Class_WC_Order, line_items_type string, mut var_line_item_data Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_action := rt.new_string(if !rt.is_true(var_line_item_data.array_get('id')) { rt.new_string('create') } else { rt.new_string('update') })
	mut var_method := rt.new_string('prepare_' + line_items_type + '_data')
	mut var_item := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('update'), var_action)) {
		var_item = var_order.get_item(rt.call_function('absint', [var_line_item_data.array_get('id')]), rt.new_bool(false))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
			rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('esc_html__', [rt.new_string('Order item ID provided is not associated with order.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
	}
	var_item = rt.call_method(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils', []string{}, &this), var_method, [var_line_item_data, var_action.dup(), var_item.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_set_order_item'), var_item.dup(), var_line_item_data])
	if rt.is_true(rt.identical(rt.new_string('create'), var_action)) {
		var_order.add_item(var_item.dup())
	} else {
		rt.call_method(var_item, 'save', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(), rt.new_string(line_items_type))) && rt.is_true(rt.call_function('in_array', [var_order.get_status(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() }]), rt.new_bool(true)])))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
		mut var_changed_stock := rt.call_function('wc_maybe_adjust_line_item_product_stock', [var_item.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_changed_stock) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_changed_stock.dup()]))))))) {
			var_order.add_order_note(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Adjusted stock: %s.'), rt.new_string('woocommerce')]), rt.call_function('sprintf', [rt.new_string('%1$s (%2$s&rarr;%3$s)'), rt.call_method(var_item, 'get_name', []rt.PhpVal{}), var_changed_stock.array_get('from'), var_changed_stock.array_get('to')])]), rt.new_bool(false), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock() }]))
		}
	}
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) item_is_null_or_zero(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'product_id' }, rt.ArrayItem{ key: none, val: 'method_id' }, rt.ArrayItem{ key: none, val: 'method_title' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'code' }])
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_item_mutated.dup().array_isset(var_key.dup()))) && rt.is_true(rt.new_bool(var_item_mutated.array_get(var_key).is_null())))) {
				return true
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_item_mutated.dup().array_isset(rt.new_string('quantity')))) && rt.is_true(rt.identical(rt.new_int(0), var_item_mutated.array_get('quantity'))))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) remove_item_from_order(mut var_order Class_WC_Order, line_items_type string, item_id i64)  {
	mut var_item := var_order.get_item(rt.new_int(item_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_item_id'), rt.call_function('esc_html__', [rt.new_string('Order item ID provided is not associated with order.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(), rt.new_string(line_items_type))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
		rt.call_function('wc_maybe_adjust_line_item_product_stock', [var_item.dup(), rt.new_int(0)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_remove_order_item'), var_item.dup()])
	var_order.remove_item(rt.new_int(item_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) get_product_id_from_line_item(var_request_data rt.PhpVal, action string) rt.PhpVal {
	mut action_mutated := action
	if !(!rt.is_true(var_request_data.array_get('sku'))) {
		mut var_product_id := // unsupported expression: Expr_Cast_Int
	} else if !(!rt.is_true(var_request_data.array_get('product_id'))) && !rt.is_true(var_request_data.array_get('variation_id')) {
		var_product_id = // unsupported expression: Expr_Cast_Int
	} else if !(!rt.is_true(var_request_data.array_get('variation_id'))) {
		var_product_id = // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.identical(rt.new_string('update'), rt.new_string(action_mutated))) {
		var_product_id = rt.new_int(rt.new_int(0))
	} else {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_required_product_reference'), rt.call_function('esc_html__', [rt.new_string('Product ID or SKU is required.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	return var_product_id.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_line_item_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
	var_item_mutated = if rt.is_true(rt.new_bool(var_item_mutated.dup().is_null())) { create_wc_order_item_product(if !(!rt.is_true(var_request_data.array_get('id'))) { var_request_data.array_get('id') } else { rt.new_string('') }) } else { var_item_mutated }
	mut var_product := rt.call_function('wc_get_product', [this.get_product_id_from_line_item(var_request_data.dup(), action_mutated)])
	if rt.is_true(rt.new_bool(rt.is_true(var_product) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_method(var_item_mutated, 'set_product', [var_product.dup()])
		if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(action_mutated))) {
			mut var_quantity := if var_request_data.array_isset(rt.new_string('quantity')) { var_request_data.array_get('quantity') } else { rt.new_int(1) }
			mut var_total := rt.call_function('wc_get_price_excluding_tax', [var_product.dup(), rt.create_array([rt.ArrayItem{ key: 'qty', val: var_quantity }])])
			rt.call_method(var_item_mutated, 'set_total', [var_total.dup()])
			rt.call_method(var_item_mutated, 'set_subtotal', [var_total.dup()])
		}
	}
	this.maybe_set_item_props(var_item_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'quantity' }, rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'subtotal' }, rt.ArrayItem{ key: none, val: 'tax_class' }]), var_request_data.dup())
	this.maybe_set_item_meta_data(var_item_mutated.dup(), var_request_data.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(, 'has_cogs', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))))) {
		return var_item_mutated.dup()
	}
	mut var_cogs_value := if !().is_null() {  } else {  }
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_shipping_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_fee_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) prepare_coupon_data(var_request_data rt.PhpVal, action string, var_item rt.PhpVal) rt.PhpVal {
	mut action_mutated := action
	mut var_item_mutated := var_item
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) maybe_set_item_prop(var_item rt.PhpVal, var_prop rt.PhpVal, var_request_data rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) maybe_set_item_props(var_item rt.PhpVal, var_props rt.PhpVal, var_request_data rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) maybe_set_item_meta_data(var_item rt.PhpVal, var_request_data rt.PhpVal)  {
	mut var_item_mutated := var_item
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

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_updateutils() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
		order_schema: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
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

fn create_automattic_woocommerce_utilities_metadatautil() &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_product() &Class_WC_Order_Item_Product {
	mut obj := &Class_WC_Order_Item_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_UpdateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_OrderSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_order_from_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			this.update_order_from_request(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'update_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.update_address(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'update_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.update_meta_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'update_line_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.update_line_items(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_line_item' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.update_line_item(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'item_is_null_or_zero' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.item_is_null_or_zero(dispatch_arg_0))
		}
		'remove_item_from_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'order_schema' { this.order_schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_orders_updateutils_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
