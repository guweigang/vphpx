import rt

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
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




pub fn init_wp_content_plugins_woocommerce_templates_order_order_details_fulfillments_php() {
	mut var_order_id := rt.new_null()
	mut var_show_downloads := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_null()
	}
	mut var_order_items := rt.call_method(var_order, 'get_items', [rt.call_function('apply_filters', [rt.new_string('woocommerce_purchase_order_item_types'), rt.new_string('line_item')])])
	mut var_show_purchase_note := rt.call_method(var_order, 'has_status', [rt.call_function('apply_filters', [rt.new_string('woocommerce_purchase_note_order_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: 'completed' }, rt.ArrayItem{ key: none, val: 'processing' }])])])
	mut var_downloads := rt.call_method(var_order, 'get_downloadable_items', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
	mut var_actions := rt.call_function('array_filter', [rt.call_function('wc_get_account_orders_actions', [var_order.dup()]), rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	mut var_show_customer_details := (rt.identical(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}), rt.call_function('get_current_user_id', []rt.PhpVal{}))).to_bool()
	if rt.is_true(var_show_downloads) {
		rt.call_function('wc_get_template', [rt.new_string('order/order-downloads.php'), rt.create_array([rt.ArrayItem{ key: 'downloads', val: var_downloads }, rt.ArrayItem{ key: 'show_title', val: true }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_order_details_before_order_table'), var_order.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order details'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_fulfillments_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment'))
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [Class_WC_Order.class(), // unsupported expression: Expr_Cast_String])
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.has_pending_items(arg_0, arg_1) }(var_order.dup(), var_fulfillments.dup())) {
		mut var_pending_items := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_pending_items(arg_0, arg_1) }(var_order.dup(), var_fulfillments.dup())
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Pending items'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_order_details_before_order_table_items'), var_order.dup()])
		{
			mut iter_1 := var_pending_items.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var_product := rt.call_method(var_item.array_get('item'), 'get_product', []rt.PhpVal{})
				rt.call_function('wc_get_template', [rt.new_string('order/order-details-fulfillment-item.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'item_id', val: var_item.array_get('item_id') }, rt.ArrayItem{ key: 'item', val: var_item.array_get('item') }, rt.ArrayItem{ key: 'quantity', val: var_item.array_get('qty') }, rt.ArrayItem{ key: 'is_pending_item', val: true }, rt.ArrayItem{ key: 'show_purchase_note', val: var_show_purchase_note }, rt.ArrayItem{ key: 'purchase_note', val: if rt.is_true(var_product) { rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'product', val: var_product }])])
			}
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_order_details_after_order_table_items'), var_order.dup()])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_fulfillments)) {
		{
			mut iter_1 := var_fulfillments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_fulfillment := item_1.val
				mut var_index := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_fulfillment, 'get_is_fulfilled', []rt.PhpVal{}))))) {
					continue
				}
				mut var_fulfillment_items := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_fulfillment_items(arg_0, arg_1) }(var_order.dup(), var_fulfillment.dup())
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Shipment %s'), rt.new_string('woocommerce')]), var_index.dup().to_i64() + 1])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('do_action', [rt.new_string('woocommerce_order_details_before_order_table_items'), var_order.dup()])
				{
					mut iter_2 := var_fulfillment_items.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_item := item_2.val
						mut var_product := rt.call_method(var_item.array_get('item'), 'get_product', []rt.PhpVal{})
						rt.call_function('wc_get_template', [rt.new_string('order/order-details-fulfillment-item.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'item_id', val: var_item.array_get('item_id') }, rt.ArrayItem{ key: 'item', val: var_item.array_get('item') }, rt.ArrayItem{ key: 'quantity', val: var_item.array_get('qty') }, rt.ArrayItem{ key: 'is_pending_item', val: false }, rt.ArrayItem{ key: 'show_purchase_note', val: var_show_purchase_note }, rt.ArrayItem{ key: 'purchase_note', val: if rt.is_true(var_product) { rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'product', val: var_product }])])
					}
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_order_details_after_order_table_items'), var_order.dup()])
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_actions)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Actions'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_wp_button_class := rt.new_string(if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') })
		{
			mut iter_1 := var_actions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action := item_1.val
				mut var_key := item_1.key
				if !rt.is_true(var_action.array_get('aria-label')) {
					mut var_action_aria_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s order number %2$s'), rt.new_string('woocommerce')]), var_action.array_get('name'), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})])
				} else {
					var_action_aria_label = var_action.array_get('aria-label')
				}
				print('<a href="' + (rt.call_function('esc_url', [var_action.array_get('url')])).str() + '" class="woocommerce-button' + (rt.call_function('esc_attr', [var_wp_button_class.dup()])).str() + ' button ' + (rt.call_function('sanitize_html_class', [var_key.dup()])).str() + ' order-actions-button " aria-label="' + (rt.call_function('esc_attr', [var_action_aria_label.dup()])).str() + '">' + (rt.call_function('esc_html', [var_action.array_get('name')])).str() + '</a>')
				var_action_aria_label = rt.new_null()
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.call_method(var_order, 'get_order_item_totals', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_total := item_1.val
			mut var_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_total.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_total.array_get('value')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Note:'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('nl2br', [rt.call_function('wptexturize', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})])]), rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() }])]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_order_details_after_order_table'), var_order.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_order_details'), var_order.dup()])
	if var_show_customer_details {
		rt.call_function('wc_get_template', [rt.new_string('order/order-details-customer.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }])])
	}
}
