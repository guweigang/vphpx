import rt

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order_id := rt.new_null()
	mut var_show_downloads := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_null()
	}
	mut var_order_items := rt.call_method(var_order, 'get_items', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_purchase_order_item_types'),
			rt.new_string('line_item'),
		]),
	])
	mut var_show_purchase_note := rt.call_method(var_order, 'has_status', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_purchase_note_order_statuses'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'completed' },
				rt.ArrayItem{ key: none, val: 'processing' }]),
		]),
	])
	mut var_downloads := rt.call_method(var_order, 'get_downloadable_items', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(rt.new_string('view'), var_key)))
	}
	mut var_actions := rt.call_function('array_filter', [
		rt.call_function('wc_get_account_orders_actions', [var_order.clone()]),
		rt.new_closure(closure_1_fn),
		rt.get_constant('ARRAY_FILTER_USE_KEY'),
	])
	mut var_show_customer_details := (rt.identical(rt.call_method(var_order, 'get_user_id',
		[]rt.PhpVal{}), rt.call_function('get_current_user_id', []rt.PhpVal{}))).to_bool()
	if rt.is_true(var_show_downloads) {
		rt.call_function('wc_get_template', [rt.new_string('order/order-downloads.php'),
			rt.create_array([rt.ArrayItem{ key: 'downloads', val: var_downloads },
				rt.ArrayItem{ key: 'show_title', val: true }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_details_before_order_table'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order details'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('order-fulfillment'))
	mut var_fulfillments_data_store := iife_result_1
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [
		Class_WC_Order.class(),
		rt.new_string((rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()),
	])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_2 := iife_temp_2.has_pending_items(var_order.clone(), var_fulfillments.clone())
	if rt.is_true(iife_result_2) {
		mut iife_temp_3 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_3 := iife_temp_3.get_pending_items(var_order.clone(),
			var_fulfillments.clone())
		mut var_pending_items := iife_result_3
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Pending items'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_order_details_before_order_table_items'),
			var_order.clone(),
		])
		mut iter_1 := var_pending_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_product := rt.call_method(var_item.array_get(rt.new_string('item')),
				'get_product', []rt.PhpVal{})
			rt.call_function('wc_get_template', [
				rt.new_string('order/order-details-fulfillment-item.php'),
				rt.create_array([rt.ArrayItem{ key: 'order', val: var_order },
					rt.ArrayItem{ key: 'item_id', val: var_item.array_get(rt.new_string('item_id')) },
					rt.ArrayItem{ key: 'item', val: var_item.array_get(rt.new_string('item')) },
					rt.ArrayItem{ key: 'quantity', val: var_item.array_get(rt.new_string('qty')) },
					rt.ArrayItem{ key: 'is_pending_item', val: true },
					rt.ArrayItem{ key: 'show_purchase_note', val: var_show_purchase_note },
					rt.ArrayItem{
						key: 'purchase_note'
						val: if rt.is_true(var_product) {
							rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})
						} else {
							rt.new_string('')
						}
					}, rt.ArrayItem{ key: 'product', val: var_product }]),
			])
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_order_details_after_order_table_items'),
			var_order.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_fulfillments)) {
		mut iter_2 := var_fulfillments.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_fulfillment := item_2.val
			mut var_index := item_2.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_fulfillment,
				'get_is_fulfilled', []rt.PhpVal{})))))
			{
				continue
			}
			mut iife_temp_4 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
			mut iife_result_4 := iife_temp_4.get_fulfillment_items(var_order.clone(),
				var_fulfillment.clone())
			mut var_fulfillment_items := iife_result_4
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('esc_html__', [rt.new_string('Shipment %s'),
					rt.new_string('woocommerce')]),
				rt.new_int(var_index.clone().to_i64() + 1),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('do_action', [
				rt.new_string('woocommerce_order_details_before_order_table_items'),
				var_order.clone(),
			])
			mut iter_3 := var_fulfillment_items.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_item := item_3.val
				mut var_product := rt.call_method(var_item.array_get(rt.new_string('item')),
					'get_product', []rt.PhpVal{})
				rt.call_function('wc_get_template', [
					rt.new_string('order/order-details-fulfillment-item.php'),
					rt.create_array([rt.ArrayItem{ key: 'order', val: var_order },
						rt.ArrayItem{
							key: 'item_id'
							val: var_item.array_get(rt.new_string('item_id'))
						}, rt.ArrayItem{ key: 'item', val: var_item.array_get(rt.new_string('item')) },
						rt.ArrayItem{ key: 'quantity', val: var_item.array_get(rt.new_string('qty')) },
						rt.ArrayItem{ key: 'is_pending_item', val: false },
						rt.ArrayItem{ key: 'show_purchase_note', val: var_show_purchase_note },
						rt.ArrayItem{
							key: 'purchase_note'
							val: if rt.is_true(var_product) {
								rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})
							} else {
								rt.new_string('')
							}
						}, rt.ArrayItem{ key: 'product', val: var_product }]),
				])
			}
			rt.call_function('do_action', [
				rt.new_string('woocommerce_order_details_after_order_table_items'),
				var_order.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_actions)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Actions'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_wp_button_class := rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
			rt.new_string('button'),
		]))
		{
			' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
		} else {
			''
		}).str())
		mut iter_4 := var_actions.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_action := item_4.val
			mut var_key := item_4.key
			if !rt.is_true(var_action.array_get(rt.new_string('aria-label'))) {
				mut var_action_aria_label := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s order number %2$s'),
						rt.new_string('woocommerce')]),
					var_action.array_get(rt.new_string('name')),
					rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}),
				])
			} else {
				var_action_aria_label = var_action.array_get(rt.new_string('aria-label'))
			}
			print('<a href="' +
				(rt.call_function('esc_url', [var_action.array_get(rt.new_string('url'))])).str() +
				'" class="woocommerce-button' +
				(rt.call_function('esc_attr', [var_wp_button_class.clone()])).str() + ' button ' +
				(rt.call_function('sanitize_html_class', [var_key.clone()])).str() +
				' order-actions-button " aria-label="' +
				(rt.call_function('esc_attr', [var_action_aria_label.clone()])).str() + '">' +
				(rt.call_function('esc_html', [var_action.array_get(rt.new_string('name'))])).str() +
				'</a>')
			var_action_aria_label = rt.new_null()
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_5 := rt.call_method(var_order, 'get_order_item_totals', []rt.PhpVal{}).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_total := item_5.val
		mut var_key := item_5.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_total.array_get(rt.new_string('label'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			var_total.array_get(rt.new_string('value')),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Note:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('nl2br', [
				rt.call_function('wptexturize', [
					rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{}),
				]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'br', val: rt.new_array() },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_details_after_order_table'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_order_details'),
		var_order.clone()])
	if var_show_customer_details {
		rt.call_function('wc_get_template', [
			rt.new_string('order/order-details-customer.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }]),
		])
	}
}
