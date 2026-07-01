import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer {
	rt.PhpObjectBase
pub mut:
		fulfillments_cache rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) register()  {
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()) {
		rt.call_function('add_filter', [rt.new_string('manage_woocommerce_page_wc-orders_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_fulfillment_columns' }])])
		rt.call_function('add_action', [rt.new_string('manage_woocommerce_page_wc-orders_custom_column'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_column_row_data' }]), rt.new_int(10), rt.new_int(2)])
	} else {
		rt.call_function('add_filter', [rt.new_string('manage_edit-shop_order_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_fulfillment_columns' }])])
		rt.call_function('add_action', [rt.new_string('manage_shop_order_posts_custom_column'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_column_row_data_legacy' }]), rt.new_int(25), rt.new_int(1)])
	}
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_drawer_slot' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'load_components' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_order_data_header_right'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_order_details_badges' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_details_before_order_table'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_customer_details' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init_admin_hooks' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_details_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_status_text' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_tracking_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_status_text' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) init_admin_hooks()  {
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()) {
		rt.call_function('add_filter', [rt.new_string('bulk_actions-woocommerce_page_wc-orders'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'define_fulfillment_bulk_actions' }])])
		rt.call_function('add_filter', [rt.new_string('handle_bulk_actions-woocommerce_page_wc-orders'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_fulfillment_bulk_actions' }]), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_action', [rt.new_string('woocommerce_order_list_table_restrict_manage_orders'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_filters' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_order_list_table_restrict_manage_orders'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_shipping_provider_filter' }])])
		rt.call_function('add_filter', [rt.new_string('woocommerce_order_query_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_orders_list_table_query' }]), rt.new_int(10), rt.new_int(1)])
		rt.call_function('add_filter', [rt.new_string('woocommerce_order_list_table_prepare_items_query_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_orders_by_shipping_provider' }]), rt.new_int(10), rt.new_int(1)])
	} else {
		rt.call_function('add_filter', [rt.new_string('bulk_actions-edit-shop_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'define_fulfillment_bulk_actions' }])])
		rt.call_function('add_filter', [rt.new_string('handle_bulk_actions-edit-shop_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_fulfillment_bulk_actions' }]), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_action', [rt.new_string('restrict_manage_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_fulfillment_filters_legacy' }])])
		rt.call_function('add_action', [rt.new_string('restrict_manage_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_shipping_provider_filter_legacy' }])])
		rt.call_function('add_action', [rt.new_string('pre_get_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_legacy_orders_list_query' }])])
		rt.call_function('add_action', [rt.new_string('pre_get_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_legacy_orders_by_shipping_provider' }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) add_fulfillment_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_new_columns := rt.new_array()
	{
		mut iter_1 := var_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_info := item_1.val
			mut var_column_name := item_1.key
			var_new_columns.array_set(var_column_name, var_column_info.dup())
			if rt.is_true(rt.identical(rt.new_string('order_status'), var_column_name)) {
				var_new_columns.array_set(var_column_name, 'Order Status')
				var_new_columns.array_set('fulfillment_status', rt.call_function('__', [rt.new_string('Fulfillment Status'), rt.new_string('woocommerce')]))
				var_new_columns.array_set('shipment_tracking', rt.call_function('__', [rt.new_string('Shipment Tracking'), rt.new_string('woocommerce')]))
				var_new_columns.array_set('shipment_provider', rt.call_function('__', [rt.new_string('Shipment Provider'), rt.new_string('woocommerce')]))
			}
		}
	}
	return var_new_columns.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_column_row_data_legacy(column_name string) rt.PhpVal {
	mut var_the_order := rt.new_null()
	// unsupported statement: Stmt_Global
	this.render_fulfillment_column_row_data(column_name, mut rt.cast_object_ptr[Class_WC_Order](var_the_order))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_column_row_data(column_name string, mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
	mut var_fulfillments := this.maybe_read_fulfillments(mut var_order_mutated)
	mut switch_val_1 := rt.new_string(column_name)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('fulfillment_status'))) {
		this.render_order_fulfillment_status_column_row_data(mut var_order_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipment_tracking'))) {
		this.render_shipment_tracking_column_row_data(mut var_order_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_fulfillments))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipment_provider'))) {
		this.render_shipment_provider_column_row_data(mut var_order_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_fulfillments))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_order_fulfillment_status_column_row_data(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
	mut var_order_fulfillment_status := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_order_fulfillment_status(arg_0) }(rt.new_object('WC_Order', []string{}, var_order_mutated))
	print('<div class=\'fulfillment-status-wrapper\'>')
	this.render_order_fulfillment_status_badge(rt.new_object('WC_Order', []string{}, var_order_mutated), (var_order_fulfillment_status).str())
	print('</div>')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_order_fulfillment_status_badge(var_order rt.PhpVal, order_fulfillment_status string)  {
	mut var_order_mutated := var_order
	mut order_fulfillment_status_mutated := order_fulfillment_status
	mut var_status_props := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_order_fulfillment_statuses() }().array_get(order_fulfillment_status_mutated)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_status_props)))) {
		var_status_props = rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Unknown'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'background_color', val: '#f0f0f0' }, rt.ArrayItem{ key: 'text_color', val: '#000' }])
	}
	print('<mark class="fulfillment-status fulfillments-trigger" style="background-color:' + (rt.call_function('esc_attr', [var_status_props.array_get('background_color')])).str() + '; color: ' + (rt.call_function('esc_attr', [var_status_props.array_get('text_color')])).str() + ';" role="button" tabindex="0" data-order-id="' + (rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String])).str() + '"><span>' + (rt.call_function('esc_html', [var_status_props.array_get('label')])).str() + '</span></mark>')
	print('<a href=\'#\' class=\'fulfillments-trigger\' data-order-id=\'' + (rt.call_function('esc_attr', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])).str() + '\' title=\'' + (rt.call_function('esc_attr__', [rt.new_string('View Fulfillments'), rt.new_string('woocommerce')])).str() + '\'>\n\t\t\t<svg width=\'16\' height=\'16\' viewBox=\'0 0 12 14\' xmlns=\'http://www.w3.org/2000/svg\'>\n\t\t\t\t<path d=\'M11.8333 2.83301L9.33329 0.333008L2.24996 7.41634L1.41663 10.7497L4.74996 9.91634L11.8333 2.83301ZM5.99996 12.4163H0.166626V13.6663H5.99996V12.4163Z\' />\n\t\t\t</svg>\n\t\t</a>')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipment_provider_column_row_data(mut var_order Class_WC_Order, mut var_fulfillments Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array)  {
	mut var_order_mutated := var_order
	mut var_fulfillments_mutated := var_fulfillments
	mut var_providers := rt.new_array()
	{
		mut iter_1 := var_fulfillments_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fulfillment := item_1.val
			mut var_provider := rt.call_method(var_fulfillment, 'get_shipment_provider', []rt.PhpVal{})
			if !(!rt.is_true(var_provider)) {
				mut var_provider_name := rt.call_method(var_fulfillment, 'get_meta', [rt.new_string('_provider_name')])
				mut var_key := if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('other'), var_provider)) && !(!rt.is_true(var_provider_name)))) { (var_provider).str() + '::' + (var_provider_name).str() } else { var_provider }
				var_providers.array_set(var_key, var_fulfillment.dup())
			}
		}
	}
	if var_providers.dup().array_count() > 1 {
		print('<span>' + (rt.call_function('esc_html__', [rt.new_string('Multiple providers'), rt.new_string('woocommerce')])).str() + '</span>')
	} else if 1 == var_providers.dup().array_count() {
		mut var_provider_fulfillment := rt.call_function('reset', [var_providers.dup()])
		mut var_provider_slug := rt.call_method(var_provider_fulfillment, 'get_shipment_provider', []rt.PhpVal{})
		mut var_known_providers := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_shipping_providers() }()
		mut var_provider_name_meta := rt.call_method(var_provider_fulfillment, 'get_meta', [rt.new_string('_provider_name')])
		mut var_provider_display_label := if var_known_providers.array_isset(var_provider_slug) { rt.call_method(var_known_providers.array_get(var_provider_slug), 'get_name', []rt.PhpVal{}) } else { if !(!rt.is_true(var_provider_name_meta)) { var_provider_name_meta } else { var_provider_slug } }
		print('<span>' + (rt.call_function('esc_html', [var_provider_display_label.dup()])).str() + '</span>')
	} else {
		print('<span>--</span>')
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipment_tracking_column_row_data(mut var_order Class_WC_Order, mut var_fulfillments Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array)  {
	mut var_order_mutated := var_order
	mut var_fulfillments_mutated := var_fulfillments
	mut var_tracking := rt.new_array()
	{
		mut iter_1 := var_fulfillments_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fulfillment := item_1.val
			mut var_number := rt.call_method(var_fulfillment, 'get_tracking_number', []rt.PhpVal{})
			if !(!rt.is_true(var_number)) {
				var_tracking.array_push(rt.create_array([rt.ArrayItem{ key: 'number', val: var_number }, rt.ArrayItem{ key: 'url', val: rt.call_method(var_fulfillment, 'get_tracking_url', []rt.PhpVal{}) }]))
			}
		}
	}
	if var_tracking.dup().array_count() > 1 {
		print('<span>' + (rt.call_function('esc_html__', [rt.new_string('Multiple trackings'), rt.new_string('woocommerce')])).str() + '</span>')
	} else if 1 == var_tracking.dup().array_count() {
		mut var_entry := var_tracking.array_get(0)
		if !(!rt.is_true(var_entry.array_get('url'))) {
			print('<a href="' + (rt.call_function('esc_url', [var_entry.array_get('url')])).str() + '" target="_blank" rel="noopener noreferrer" style="text-decoration: underline; color: #2f2f2f;">' + (rt.call_function('esc_html', [var_entry.array_get('number')])).str() + '</a>')
		} else {
			print('<span>' + (rt.call_function('esc_html', [var_entry.array_get('number')])).str() + '</span>')
		}
	} else {
		print('<span>--</span>')
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_drawer_slot()  {
	if !(this.should_render_fulfillment_drawer()) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) define_fulfillment_bulk_actions(var_actions rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	var_actions_mutated.array_set('fulfill', rt.call_function('__', [rt.new_string('Mark as fulfilled'), rt.new_string('woocommerce')]))
	return var_actions_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) handle_fulfillment_bulk_actions(var_redirect_to rt.PhpVal, var_action rt.PhpVal, var_post_ids rt.PhpVal) rt.PhpVal {
	mut var_redirect_to_mutated := var_redirect_to
	if rt.is_true(rt.identical(rt.new_string('fulfill'), var_action)) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_bulk_action_used(arg_0, arg_1) }(rt.new_string('fulfill_orders'), rt.new_int(var_post_ids.dup().array_count()))
		{
			mut iter_1 := var_post_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_post_id := item_1.val
				mut var_order := rt.call_function('wc_get_order', [var_post_id.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
					continue
				}
				mut var_fulfillments := this.maybe_read_fulfillments(mut rt.cast_object_ptr[Class_WC_Order](var_order))
				{
					mut iter_2 := var_fulfillments.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_fulfillment := item_2.val
						rt.call_method(var_fulfillment, 'set_status', [rt.new_string('fulfilled')])
						rt.call_method(var_fulfillment, 'save', []rt.PhpVal{})
					}
				}
				closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: var_item.array_get('item_id') }, rt.ArrayItem{ key: 'qty', val: var_item.array_get('qty') }])
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: var_item.array_get('item_id') }, rt.ArrayItem{ key: 'qty', val: var_item.array_get('qty') }])
	}
				mut var_remaining_items := rt.call_function('array_map', [rt.new_closure(closure_1_fn), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_pending_items(arg_0, arg_1) }(var_order.dup(), var_fulfillments.dup())])
				if 0 < var_remaining_items.dup().array_count() {
					mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
					var_fulfillment.set_entity_type(Class_WC_Order.class())
					var_fulfillment.set_entity_id(// unsupported expression: Expr_Cast_String)
					var_fulfillment.set_status(rt.new_string('fulfilled'))
					var_fulfillment.set_items(var_remaining_items.dup())
					var_fulfillment.save()
				}
			}
		}
		var_redirect_to_mutated = rt.call_function('add_query_arg', [, .dup()])
	}
	return var_redirect_to_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_status_text(order_status string, mut var_order Class_WC_Order) string {
	mut order_status_mutated := order_status
	mut var_order_mutated := var_order
	mut var_fulfillments := 
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_customer_details(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_order_details_badges(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) load_components()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) register_fulfillments_assets()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) load_fulfillments_js_settings()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_filters()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_filters_legacy()  {
	mut var_typenow := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_orders_list_table_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_legacy_orders_list_query(var_query rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipping_provider_filter()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipping_provider_filter_legacy()  {
	mut var_typenow := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_orders_by_shipping_provider(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_legacy_orders_by_shipping_provider(var_query rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) get_order_ids_by_shipping_provider(shipping_provider string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut shipping_provider_mutated := shipping_provider
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) should_render_fulfillment_drawer() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) maybe_read_fulfillments(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentsrenderer() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer{
		PhpObjectBase: rt.PhpObjectBase{}
		fulfillments_cache: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentstracker() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init_admin_hooks' {
			this.init_admin_hooks()
			return rt.new_null()
		}
		'add_fulfillment_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_fulfillment_columns(dispatch_arg_0)
		}
		'render_fulfillment_column_row_data_legacy' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.render_fulfillment_column_row_data_legacy(dispatch_arg_0)
		}
		'render_fulfillment_column_row_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.render_fulfillment_column_row_data(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'render_order_fulfillment_status_column_row_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_order_fulfillment_status_column_row_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_fulfillment_status_badge' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.render_order_fulfillment_status_badge(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'render_shipment_provider_column_row_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.render_shipment_provider_column_row_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'render_shipment_tracking_column_row_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.render_shipment_tracking_column_row_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'render_fulfillment_drawer_slot' {
			this.render_fulfillment_drawer_slot()
			return rt.new_null()
		}
		'define_fulfillment_bulk_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_fulfillment_bulk_actions(dispatch_arg_0)
		}
		'handle_fulfillment_bulk_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.handle_fulfillment_bulk_actions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_fulfillment_status_text' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.render_fulfillment_status_text(dispatch_arg_0, mut dispatch_arg_1))
		}
		'render_fulfillment_customer_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_fulfillment_customer_details(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_details_badges' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_order_details_badges(mut dispatch_arg_0)
			return rt.new_null()
		}
		'load_components' {
			this.load_components()
			return rt.new_null()
		}
		'register_fulfillments_assets' {
			this.register_fulfillments_assets()
			return rt.new_null()
		}
		'load_fulfillments_js_settings' {
			this.load_fulfillments_js_settings()
			return rt.new_null()
		}
		'render_fulfillment_filters' {
			this.render_fulfillment_filters()
			return rt.new_null()
		}
		'render_fulfillment_filters_legacy' {
			this.render_fulfillment_filters_legacy()
			return rt.new_null()
		}
		'filter_orders_list_table_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_orders_list_table_query(dispatch_arg_0)
		}
		'filter_legacy_orders_list_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.filter_legacy_orders_list_query(dispatch_arg_0)
			return rt.new_null()
		}
		'render_shipping_provider_filter' {
			this.render_shipping_provider_filter()
			return rt.new_null()
		}
		'render_shipping_provider_filter_legacy' {
			this.render_shipping_provider_filter_legacy()
			return rt.new_null()
		}
		'filter_orders_by_shipping_provider' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_orders_by_shipping_provider(dispatch_arg_0)
		}
		'filter_legacy_orders_by_shipping_provider' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.filter_legacy_orders_by_shipping_provider(dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_ids_by_shipping_provider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_ids_by_shipping_provider(dispatch_arg_0)
		}
		'should_render_fulfillment_drawer' {
			return rt.new_bool(this.should_render_fulfillment_drawer())
		}
		'maybe_read_fulfillments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.maybe_read_fulfillments(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fulfillments_cache' { return this.fulfillments_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fulfillments_cache' { this.fulfillments_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_fulfillmentsrenderer_php() {
	// unsupported statement: Stmt_Declare
}
