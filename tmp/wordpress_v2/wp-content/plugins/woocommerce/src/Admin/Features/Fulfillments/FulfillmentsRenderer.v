import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer {
	rt.PhpObjectBase
pub mut:
	fulfillments_cache rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) register() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_0) {
		rt.call_function('add_filter', [
			rt.new_string('manage_woocommerce_page_wc-orders_columns'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_fulfillment_columns' },
			]),
		])
		rt.call_function('add_action', [
			rt.new_string('manage_woocommerce_page_wc-orders_custom_column'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'render_fulfillment_column_row_data' },
			]),
			rt.new_int(10),
			rt.new_int(2),
		])
	} else {
		rt.call_function('add_filter', [rt.new_string('manage_edit-shop_order_columns'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_fulfillment_columns' },
			])])
		rt.call_function('add_action', [
			rt.new_string('manage_shop_order_posts_custom_column'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'render_fulfillment_column_row_data_legacy' },
			]),
			rt.new_int(25),
			rt.new_int(1),
		])
	}
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_fulfillment_drawer_slot' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'load_components' },
		])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_order_data_header_right'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_order_details_badges' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_details_before_order_table'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_fulfillment_customer_details' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_admin_hooks' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_details_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_fulfillment_status_text' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_tracking_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_fulfillment_status_text' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) init_admin_hooks() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_1) {
		rt.call_function('add_filter', [
			rt.new_string('bulk_actions-woocommerce_page_wc-orders'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'define_fulfillment_bulk_actions' },
			]),
		])
		rt.call_function('add_filter', [
			rt.new_string('handle_bulk_actions-woocommerce_page_wc-orders'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'handle_fulfillment_bulk_actions' },
			]),
			rt.new_int(10),
			rt.new_int(3),
		])
		rt.call_function('add_action', [
			rt.new_string('woocommerce_order_list_table_restrict_manage_orders'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'render_fulfillment_filters' },
			]),
		])
		rt.call_function('add_action', [
			rt.new_string('woocommerce_order_list_table_restrict_manage_orders'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'render_shipping_provider_filter' },
			]),
		])
		rt.call_function('add_filter', [rt.new_string('woocommerce_order_query_args'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'filter_orders_list_table_query' },
			]),
			rt.new_int(10), rt.new_int(1)])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_order_list_table_prepare_items_query_args'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'filter_orders_by_shipping_provider' },
			]),
			rt.new_int(10),
			rt.new_int(1),
		])
	} else {
		rt.call_function('add_filter', [rt.new_string('bulk_actions-edit-shop_order'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'define_fulfillment_bulk_actions' },
			])])
		rt.call_function('add_filter', [
			rt.new_string('handle_bulk_actions-edit-shop_order'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'handle_fulfillment_bulk_actions' },
			]),
			rt.new_int(10),
			rt.new_int(3),
		])
		rt.call_function('add_action', [rt.new_string('restrict_manage_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'render_fulfillment_filters_legacy' },
			])])
		rt.call_function('add_action', [rt.new_string('restrict_manage_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'render_shipping_provider_filter_legacy' },
			])])
		rt.call_function('add_action', [rt.new_string('pre_get_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'filter_legacy_orders_list_query' },
			])])
		rt.call_function('add_action', [rt.new_string('pre_get_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'filter_legacy_orders_by_shipping_provider' },
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) add_fulfillment_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_new_columns := rt.new_array()
	mut iter_1 := var_columns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_column_info := item_1.val
		mut var_column_name := item_1.key
		var_new_columns.array_set(var_column_name, var_column_info.clone())
		if rt.is_true(rt.identical(rt.new_string('order_status'), var_column_name)) {
			var_new_columns.array_set(var_column_name, 'Order Status')
			var_new_columns.array_set('fulfillment_status', rt.call_function('__', [
				rt.new_string('Fulfillment Status'),
				rt.new_string('woocommerce'),
			]))
			var_new_columns.array_set('shipment_tracking', rt.call_function('__', [
				rt.new_string('Shipment Tracking'),
				rt.new_string('woocommerce'),
			]))
			var_new_columns.array_set('shipment_provider', rt.call_function('__', [
				rt.new_string('Shipment Provider'),
				rt.new_string('woocommerce'),
			]))
		}
	}
	return var_new_columns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_column_row_data_legacy(column_name string) rt.PhpVal {
	mut var_the_order := rt.new_null()
	this.render_fulfillment_column_row_data(column_name, mut
		rt.cast_object_ptr[Class_WC_Order](var_the_order))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_column_row_data(column_name string, mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_fulfillments := this.maybe_read_fulfillments(mut var_order_mutated)
	mut switch_val_1 := rt.new_string(column_name)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('fulfillment_status'))) {
		this.render_order_fulfillment_status_column_row_data(mut var_order_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipment_tracking'))) {
		this.render_shipment_tracking_column_row_data(mut var_order_mutated, mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_fulfillments))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipment_provider'))) {
		this.render_shipment_provider_column_row_data(mut var_order_mutated, mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_fulfillments))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_order_fulfillment_status_column_row_data(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_2 := iife_temp_2.get_order_fulfillment_status(rt.new_object('WC_Order',
		[]string{}, var_order_mutated))
	mut var_order_fulfillment_status := iife_result_2
	print("<div class='fulfillment-status-wrapper'>")
	this.render_order_fulfillment_status_badge(rt.new_object('WC_Order', []string{},
		var_order_mutated), var_order_fulfillment_status.str())
	print('</div>')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_order_fulfillment_status_badge(var_order rt.PhpVal, order_fulfillment_status string) {
	mut var_order_mutated := var_order
	mut order_fulfillment_status_mutated := order_fulfillment_status
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_3 := iife_temp_3.get_order_fulfillment_statuses()
	mut var_status_props := iife_result_3.array_get(rt.new_string(order_fulfillment_status_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_status_props)))) {
		var_status_props = rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Unknown'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'background_color', val: '#f0f0f0' },
			rt.ArrayItem{ key: 'text_color', val: '#000' },
		])
	}
	print('<mark class="fulfillment-status fulfillments-trigger" style="background-color:' +
		(rt.call_function('esc_attr', [var_status_props.array_get(rt.new_string('background_color'))])).str() +
		'; color: ' +
		(rt.call_function('esc_attr', [var_status_props.array_get(rt.new_string('text_color'))])).str() +
		';" role="button" tabindex="0" data-order-id="' +
		(rt.call_function('esc_attr', [rt.new_string((rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str())])).str() +
		'"><span>' +
		(rt.call_function('esc_html', [var_status_props.array_get(rt.new_string('label'))])).str() +
		'</span></mark>')
	print("<a href='#' class='fulfillments-trigger' data-order-id='" +
		(rt.call_function('esc_attr', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])).str() +
		"' title='" +
		(rt.call_function('esc_attr__', [rt.new_string('View Fulfillments'), rt.new_string('woocommerce')])).str() +
		"'>\n\t\t\t<svg width='16' height='16' viewBox='0 0 12 14' xmlns='http://www.w3.org/2000/svg'>\n\t\t\t\t<path d='M11.8333 2.83301L9.33329 0.333008L2.24996 7.41634L1.41663 10.7497L4.74996 9.91634L11.8333 2.83301ZM5.99996 12.4163H0.166626V13.6663H5.99996V12.4163Z' />\n\t\t\t</svg>\n\t\t</a>")
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipment_provider_column_row_data(mut var_order Class_WC_Order, mut var_fulfillments Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array) {
	mut var_order_mutated := var_order
	mut var_fulfillments_mutated := var_fulfillments
	mut var_providers := rt.new_array()
	mut iter_2 := var_fulfillments_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_fulfillment := item_2.val
		mut var_provider := rt.call_method(var_fulfillment, 'get_shipment_provider', []rt.PhpVal{})
		if !(!rt.is_true(var_provider)) {
			mut var_provider_name := rt.call_method(var_fulfillment, 'get_meta', [
				rt.new_string('_provider_name'),
			])
			mut var_key := if rt.is_true(rt.identical(rt.new_string('other'), var_provider))
				&& !(!rt.is_true(var_provider_name)) {
				var_provider.str() + '::' + var_provider_name.str()
			} else {
				var_provider
			}
			var_providers.array_set(var_key, var_fulfillment.clone())
		}
	}
	if var_providers.clone().array_count() > 1 {
		print('<span>' +
			(rt.call_function('esc_html__', [rt.new_string('Multiple providers'), rt.new_string('woocommerce')])).str() +
			'</span>')
	} else if 1 == var_providers.clone().array_count() {
		mut var_provider_fulfillment := rt.call_function('reset', [
			var_providers.clone()])
		mut var_provider_slug := rt.call_method(var_provider_fulfillment, 'get_shipment_provider',
			[]rt.PhpVal{})
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_4 := iife_temp_4.get_shipping_providers()
		mut var_known_providers := iife_result_4
		mut var_provider_name_meta := rt.call_method(var_provider_fulfillment, 'get_meta', [
			rt.new_string('_provider_name'),
		])
		mut var_provider_display_label := if var_known_providers.array_isset(var_provider_slug) {
			rt.call_method(var_known_providers.array_get(var_provider_slug), 'get_name',
				[]rt.PhpVal{})
		} else {
			if !(!rt.is_true(var_provider_name_meta)) {
				var_provider_name_meta
			} else {
				var_provider_slug
			}
		}
		print('<span>' +
			(rt.call_function('esc_html', [var_provider_display_label.clone()])).str() + '</span>')
	} else {
		print('<span>--</span>')
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipment_tracking_column_row_data(mut var_order Class_WC_Order, mut var_fulfillments Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array) {
	mut var_order_mutated := var_order
	mut var_fulfillments_mutated := var_fulfillments
	mut var_tracking := rt.new_array()
	mut iter_3 := var_fulfillments_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_fulfillment := item_3.val
		mut var_number := rt.call_method(var_fulfillment, 'get_tracking_number', []rt.PhpVal{})
		if !(!rt.is_true(var_number)) {
			var_tracking.array_push(rt.create_array([
				rt.ArrayItem{ key: 'number', val: var_number },
				rt.ArrayItem{ key: 'url', val: rt.call_method(var_fulfillment, 'get_tracking_url',
					[]rt.PhpVal{}) },
			]))
		}
	}
	if var_tracking.clone().array_count() > 1 {
		print('<span>' +
			(rt.call_function('esc_html__', [rt.new_string('Multiple trackings'), rt.new_string('woocommerce')])).str() +
			'</span>')
	} else if 1 == var_tracking.clone().array_count() {
		mut var_entry := var_tracking.array_get(rt.new_int(0))
		if !(!rt.is_true(var_entry.array_get(rt.new_string('url')))) {
			print('<a href="' +
				(rt.call_function('esc_url', [var_entry.array_get(rt.new_string('url'))])).str() +
				'" target="_blank" rel="noopener noreferrer" style="text-decoration: underline; color: #2f2f2f;">' +
				(rt.call_function('esc_html', [var_entry.array_get(rt.new_string('number'))])).str() +
				'</a>')
		} else {
			print('<span>' +
				(rt.call_function('esc_html', [var_entry.array_get(rt.new_string('number'))])).str() +
				'</span>')
		}
	} else {
		print('<span>--</span>')
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_drawer_slot() {
	if !(this.should_render_fulfillment_drawer()) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) define_fulfillment_bulk_actions(var_actions rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	var_actions_mutated.array_set('fulfill', rt.call_function('__', [
		rt.new_string('Mark as fulfilled'),
		rt.new_string('woocommerce'),
	]))
	return var_actions_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) handle_fulfillment_bulk_actions(var_redirect_to rt.PhpVal, var_action rt.PhpVal, var_post_ids rt.PhpVal) rt.PhpVal {
	mut var_redirect_to_mutated := var_redirect_to
	if rt.is_true(rt.identical(rt.new_string('fulfill'), var_action)) {
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
		mut iife_result_5 := iife_temp_5.track_fulfillment_bulk_action_used(rt.new_string('fulfill_orders'),
			rt.new_int(var_post_ids.clone().array_count()))
		mut iter_4 := var_post_ids.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_post_id := item_4.val
			mut var_order := rt.call_function('wc_get_order', [
				var_post_id.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
				continue
			}
			mut var_fulfillments :=
				this.maybe_read_fulfillments(mut rt.cast_object_ptr[Class_WC_Order](var_order))
			mut iter_5 := var_fulfillments.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_fulfillment := item_5.val
				rt.call_method(var_fulfillment, 'set_status', [
					rt.new_string('fulfilled'),
				])
				rt.call_method(var_fulfillment, 'save', []rt.PhpVal{})
			}
			closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.create_array([
					rt.ArrayItem{ key: 'item_id', val: var_item.array_get(rt.new_string('item_id')) },
					rt.ArrayItem{ key: 'qty', val: var_item.array_get(rt.new_string('qty')) },
				])
			}
			mut iife_temp_7 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
			mut iife_result_7 := iife_temp_7.get_pending_items(var_order.clone(),
				var_fulfillments.clone())
			closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.create_array([
					rt.ArrayItem{ key: 'item_id', val: var_item.array_get(rt.new_string('item_id')) },
					rt.ArrayItem{ key: 'qty', val: var_item.array_get(rt.new_string('qty')) },
				])
			}
			mut var_remaining_items := rt.call_function('array_map', [
				rt.new_closure(closure_7_fn),
				iife_result_7,
			])
			if 0 < var_remaining_items.clone().array_count() {
				mut var_fulfillment :=
					create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
				var_fulfillment.set_entity_type(Class_WC_Order.class())
				var_fulfillment.set_entity_id(rt.new_string((rt.call_method(var_order, 'get_id',
					[]rt.PhpVal{})).str()))
				var_fulfillment.set_status(rt.new_string('fulfilled'))
				var_fulfillment.set_items(var_remaining_items.clone())
				var_fulfillment.save()
			}
		}
		var_redirect_to_mutated = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'bulk_action', val: var_action }]),
			var_redirect_to_mutated.clone(),
		])
	}
	return var_redirect_to_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_status_text(order_status string, mut var_order Class_WC_Order) string {
	mut order_status_mutated := order_status
	mut var_order_mutated := var_order
	mut var_fulfillments := this.maybe_read_fulfillments(mut var_order_mutated)
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_9 := iife_temp_9.get_order_fulfillment_status_text(rt.new_object('WC_Order',
		[]string{}, var_order_mutated), var_fulfillments.clone())
	mut var_fulfillment_status := iife_result_9
	return (rt.call_function('sprintf', [rt.new_string('%s %s'),
		rt.new_string(order_status_mutated).clone(), var_fulfillment_status.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_customer_details(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_fulfillments := this.maybe_read_fulfillments(mut var_order_mutated)
	if !(!rt.is_true(var_fulfillments)) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_6 := var_fulfillments.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_fulfillment := item_6.val
			mut var_index := item_6.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_fulfillment,
				'get_is_fulfilled', []rt.PhpVal{})))))
			{
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('wp_kses', [
					rt.call_function('__', [
						rt.new_string('<b>Shipment %1$s</b> was shipped on <b>%2$s</b>'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('b'),
				]),
				rt.new_int(var_index.clone().to_i64() + 1),
				rt.call_function('esc_html', [
					rt.call_function('gmdate', [
						rt.new_string('F j, Y'),
						rt.call_function('strtotime', [if !(rt.call_method(var_fulfillment,
							'get_date_fulfilled', []rt.PhpVal{})).is_null() {
							rt.call_method(var_fulfillment, 'get_date_fulfilled', []rt.PhpVal{})
						} else {
							rt.call_method(var_fulfillment, 'get_date_updated', []rt.PhpVal{})
						}]),
					]),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_10 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
			mut iife_result_10 := iife_temp_10.get_tracking_info_html(var_fulfillment.clone())
			mut iife_temp_11 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
			mut iife_result_11 := iife_temp_11.get_tracking_info_html(var_fulfillment.clone())
			rt.echo_val(rt.call_function('wp_kses', [iife_result_10, rt.new_string('a')]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_order_details_badges(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	print('<div class="wc-order-fulfillment-badges">')
	mut var_fulfillments := this.maybe_read_fulfillments(mut var_order_mutated)
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_12 := iife_temp_12.calculate_order_fulfillment_status(rt.new_object('WC_Order',
		[]string{}, var_order_mutated), var_fulfillments.clone())
	mut var_order_fulfillment_status := iife_result_12
	mut var_order_status := rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})
	print('<mark class="order-status status-' +
		(rt.call_function('esc_attr', [var_order_status.clone()])).str() + '"><span>' +
		(rt.call_function('esc_html', [rt.call_function('wc_get_order_status_name', [var_order_status.clone()])])).str() +
		'</span></mark>')
	this.render_order_fulfillment_status_badge(rt.new_object('WC_Order', []string{},
		var_order_mutated), var_order_fulfillment_status.str())
	print('</div>')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) load_components() {
	if !(this.should_render_fulfillment_drawer()) {
		return
	}
	this.register_fulfillments_assets()
	this.load_fulfillments_js_settings()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) register_fulfillments_assets() {
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_13 := iife_temp_13.register_style(rt.new_string('fulfillments'),
		rt.new_string('style'), rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-components' },
	]))
	mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_14 := iife_temp_14.register_script(rt.new_string('wp-admin-scripts'),
		rt.new_string('fulfillments'), rt.new_bool(true))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) load_fulfillments_js_settings() {
	mut var_providers_for_js := rt.new_array()
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_15 := iife_temp_15.get_shipping_providers()
	mut iter_7 := iife_result_15.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_provider := item_7.val
		var_providers_for_js.array_set(rt.call_method(var_provider, 'get_key', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_method(var_provider, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'icon', val: rt.call_method(var_provider, 'get_icon', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_provider, 'get_key', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'url'
				val: if !(rt.call_method(var_provider, 'get_tracking_url', [
					rt.new_string('__PLACEHOLDER__'),
				])).is_null() { rt.call_method(var_provider, 'get_tracking_url', [
						rt.new_string('__PLACEHOLDER__'),
					]) } else { rt.new_string('') }
			},
		]))
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_16 := iife_temp_16.get_fulfillment_statuses()
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_17 := iife_temp_17.get_order_fulfillment_statuses()
	mut var_fulfillment_settings := rt.create_array([
		rt.ArrayItem{ key: 'providers', val: var_providers_for_js },
		rt.ArrayItem{ key: 'currency_symbols', val: rt.call_function('get_woocommerce_currency_symbols',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fulfillment_statuses', val: iife_result_16 },
		rt.ArrayItem{ key: 'order_fulfillment_statuses', val: iife_result_17 },
	])
	rt.call_function('wp_localize_script', [rt.new_string('wc-admin-fulfillments'),
		rt.new_string('wcFulfillmentSettings'), var_fulfillment_settings.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_filters() {
	mut iife_temp_18 :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer{}
	mut iife_result_18 := iife_temp_18.should_render_fulfillment_drawer()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_18)))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	mut var_selected_status := if rt.get_superglobal('_GET').array_isset(rt.new_string('fulfillment_status')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('fulfillment_status')),
			]),
		]) } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_selected_status.clone(),
		rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by fulfillment'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_19 := iife_temp_19.get_order_fulfillment_statuses()
	mut iter_8 := iife_result_19.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_props := item_8.val
		mut var_status := item_8.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_status.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_selected_status.clone(),
			var_status.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [if !(var_props.array_get(rt.new_string('label'))).is_null() {
			var_props.array_get(rt.new_string('label'))
		} else {
			rt.new_string('')
		}]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_fulfillment_filters_legacy() {
	mut var_typenow := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), var_typenow)))) {
		return
	}
	this.render_fulfillment_filters()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_orders_list_table_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.get_superglobal('_GET').array_isset(rt.new_string('fulfillment_status'))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('fulfillment_status')))) {
		mut var_fulfillment_status := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('fulfillment_status')),
			]),
		])
		mut iife_temp_20 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_20 :=
			iife_temp_20.is_valid_order_fulfillment_status(var_fulfillment_status.clone())
		if rt.is_true(iife_result_20) {
			if rt.get_superglobal('_GET').array_isset(rt.new_string('filter_action')) {
				mut iife_temp_21 :=
					Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
				mut iife_result_21 := iife_temp_21.track_fulfillment_filter_used(rt.new_string('fulfillment_status'),
					var_fulfillment_status.clone())
			}
			mut iife_temp_22 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
			mut iife_result_22 :=
				iife_temp_22.get_order_fulfillment_status_meta_query(var_fulfillment_status.clone())
			mut var_meta_query := iife_result_22
			if !(!rt.is_true(var_meta_query)) {
				if !(var_args_mutated.array_isset(rt.new_string('meta_query'))) {
					var_args_mutated.array_set('meta_query', rt.new_array())
				}
				var_args_mutated.array_get_mut('meta_query').array_push(var_meta_query.clone())
			}
		}
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_legacy_orders_list_query(var_query rt.PhpVal) {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_query, 'is_main_query', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.call_method(var_query, 'get', [rt.new_string('post_type')]), rt.new_string('shop_order')))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('fulfillment_status'))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('fulfillment_status')))) {
		mut var_status := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('fulfillment_status')),
			]),
		])
		mut iife_temp_23 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_23 := iife_temp_23.is_valid_order_fulfillment_status(var_status.clone())
		if rt.is_true(iife_result_23) {
			if rt.get_superglobal('_GET').array_isset(rt.new_string('filter_action')) {
				mut iife_temp_24 :=
					Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
				mut iife_result_24 := iife_temp_24.track_fulfillment_filter_used(rt.new_string('fulfillment_status'),
					var_status.clone())
			}
			rt.call_method(var_query, 'set', [rt.new_string('meta_query'), if rt.is_true(rt.identical(rt.new_string('no_fulfillments'), var_status)) { rt.create_array([
					rt.ArrayItem{ key: 'relation', val: 'OR' },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'key', val: '_fulfillment_status' },
						rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' },
					]) },
				]) } else { rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'key', val: '_fulfillment_status' },
						rt.ArrayItem{ key: 'value', val: var_status },
						rt.ArrayItem{ key: 'compare', val: '=' },
					]) },
				]) }])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipping_provider_filter() {
	mut iife_temp_25 :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer{}
	mut iife_result_25 := iife_temp_25.should_render_fulfillment_drawer()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_25)))) {
		return
	}
	mut iife_temp_26 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_26 := iife_temp_26.get_shipping_providers()
	mut var_providers := iife_result_26
	mut var_selected_provider := if rt.get_superglobal('_GET').array_isset(rt.new_string('shipping_provider')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('shipping_provider')),
			]),
		]) } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_selected_provider.clone(),
		rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by shipping provider'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_9 := var_providers.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_provider := item_9.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_provider, 'get_key', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_selected_provider.clone(),
			rt.call_method(var_provider, 'get_key', []rt.PhpVal{})])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_method(var_provider, 'get_name', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_selected_provider.clone(),
		rt.new_string('__other__')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Other'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) render_shipping_provider_filter_legacy() {
	mut var_typenow := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), var_typenow)))) {
		return
	}
	this.render_shipping_provider_filter()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_orders_by_shipping_provider(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('shipping_provider')))
		|| !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('shipping_provider'))) {
		return var_args_mutated.clone()
	}
	mut var_shipping_provider := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_GET').array_get(rt.new_string('shipping_provider'))]),
	])
	mut var_order_ids := this.get_order_ids_by_shipping_provider(var_shipping_provider.str())
	if !rt.is_true(var_order_ids) {
		var_args_mutated.array_set('post__in', rt.create_array([
			rt.ArrayItem{ key: none, val: 0 },
		]))
	} else if var_args_mutated.array_isset(rt.new_string('post__in'))
		&& var_args_mutated.array_get(rt.new_string('post__in')).is_array() {
		var_args_mutated.array_set('post__in', rt.call_function('array_intersect', [
			var_args_mutated.array_get(rt.new_string('post__in')),
			var_order_ids.clone(),
		]))
		if !rt.is_true(var_args_mutated.array_get(rt.new_string('post__in'))) {
			var_args_mutated.array_set('post__in', rt.create_array([
				rt.ArrayItem{ key: none, val: 0 },
			]))
		}
	} else {
		var_args_mutated.array_set('post__in', var_order_ids.clone())
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) filter_legacy_orders_by_shipping_provider(var_query rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'is_main_query', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), rt.call_method(var_query, 'get', [rt.new_string('post_type')])))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('shipping_provider')))
		|| !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('shipping_provider'))) {
		return
	}
	mut var_shipping_provider := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_GET').array_get(rt.new_string('shipping_provider'))]),
	])
	mut var_order_ids := this.get_order_ids_by_shipping_provider(var_shipping_provider.str())
	if !rt.is_true(var_order_ids) {
		rt.call_method(var_query, 'set', [rt.new_string('post__in'),
			rt.create_array([rt.ArrayItem{ key: none, val: 0 }])])
	} else {
		mut var_existing := rt.call_method(var_query, 'get', [
			rt.new_string('post__in')])
		if !(!rt.is_true(var_existing)) && var_existing.clone().is_array() {
			var_order_ids = rt.call_function('array_intersect', [
				var_existing.clone(), var_order_ids.clone()])
			if !rt.is_true(var_order_ids) {
				var_order_ids = rt.create_array([rt.ArrayItem{ key: none, val: 0 }])
			}
		}
		rt.call_method(var_query, 'set', [rt.new_string('post__in'),
			var_order_ids.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) get_order_ids_by_shipping_provider(shipping_provider string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut shipping_provider_mutated := shipping_provider
	mut var_fulfillments_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_fulfillments')
	mut var_meta_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_fulfillment_meta')
	if rt.is_true(rt.identical(rt.new_string('__other__'), rt.new_string(shipping_provider_mutated))) {
		mut iife_temp_27 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_27 := iife_temp_27.get_shipping_providers()
		mut var_known_providers := iife_result_27
		mut var_known_keys := rt.func_array_keys(var_known_providers.clone())
		if !rt.is_true(var_known_keys) {
			mut var_results := rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.new_string("SELECT DISTINCT f.entity_id\n\t\t\t\t\t\tFROM ${var_fulfillments_table.to_string()} f\n\t\t\t\t\t\tINNER JOIN ${var_meta_table.to_string()} m ON f.fulfillment_id = m.fulfillment_id\n\t\t\t\t\t\tWHERE m.meta_key = %s\n\t\t\t\t\t\tAND m.meta_value IS NOT NULL\n\t\t\t\t\t\tAND m.meta_value != ''\n\t\t\t\t\t\tAND f.date_deleted IS NULL\n\t\t\t\t\t\tAND m.date_deleted IS NULL"),
					rt.new_string('_shipment_provider'),
				]),
			])
		} else {
			mut var_placeholders := rt.call_function('implode', [
				rt.new_string(','),
				rt.call_function('array_fill', [
					rt.new_int(0), rt.new_int(var_known_keys.clone().array_count()),
					rt.new_string('%s')])])
			var_results = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.new_string("SELECT DISTINCT f.entity_id\n\t\t\t\t\t\tFROM ${var_fulfillments_table.to_string()} f\n\t\t\t\t\t\tINNER JOIN ${var_meta_table.to_string()} m ON f.fulfillment_id = m.fulfillment_id\n\t\t\t\t\t\tWHERE m.meta_key = '_shipment_provider'\n\t\t\t\t\t\tAND m.meta_value NOT IN (${var_placeholders.to_string()})\n\t\t\t\t\t\tAND m.meta_value IS NOT NULL\n\t\t\t\t\t\tAND m.meta_value != ''\n\t\t\t\t\t\tAND f.date_deleted IS NULL\n\t\t\t\t\t\tAND m.date_deleted IS NULL"),
					rt.call_function('array_map', [rt.new_string('wp_json_encode'),
						var_known_keys.clone()]),
				]),
			])
		}
	} else {
		var_results = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string("SELECT DISTINCT f.entity_id\n\t\t\t\t\tFROM ${var_fulfillments_table.to_string()} f\n\t\t\t\t\tINNER JOIN ${var_meta_table.to_string()} m ON f.fulfillment_id = m.fulfillment_id\n\t\t\t\t\tWHERE m.meta_key = '_shipment_provider'\n\t\t\t\t\tAND m.meta_value = %s\n\t\t\t\t\tAND f.date_deleted IS NULL\n\t\t\t\t\tAND m.date_deleted IS NULL"),
				rt.call_function('wp_json_encode',
					[rt.new_string(shipping_provider_mutated).clone()]),
			]),
		])
	}
	return rt.call_function('array_map', [rt.new_string('absint'),
		var_results.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) should_render_fulfillment_drawer() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_current_screen'),
	])))))
	{
		return false
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_screen))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_current_screen, 'id'))))) {
		return false
	}
	return
		rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-orders'), rt.get_property(var_current_screen, 'id')))
		|| rt.is_true(rt.identical(rt.new_string('edit-shop_order'), rt.get_property(var_current_screen, 'id')))
		|| rt.is_true(rt.identical(rt.new_string('shop_order'), rt.get_property(var_current_screen, 'id')))
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer) maybe_read_fulfillments(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	if this.fulfillments_cache.array_isset(rt.call_method(var_order_mutated, 'get_id',
		[]rt.PhpVal{}))
	{
		return this.fulfillments_cache.array_get(rt.call_method(var_order_mutated, 'get_id',
			[]rt.PhpVal{}))
	}
	mut iife_temp_28 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}
	mut iife_result_28 := iife_temp_28.load(rt.new_string('order-fulfillment'))
	mut var_data_store := iife_result_28
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_fulfillments := rt.call_method(var_data_store, 'read_fulfillments', [
		Class_WC_Order.class(),
		rt.new_string('' + (rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str()),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.call_function('sprintf', [
				rt.new_string('Failed to load fulfillments for order %d: %s'),
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'fulfillments' },
			]),
		])
		var_fulfillments = rt.new_array()
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
	this.fulfillments_cache.array_set(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
		var_fulfillments.clone())
	return var_fulfillments.clone()
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

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentsrenderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsRenderer{
		PhpObjectBase:      rt.PhpObjectBase{}
		fulfillments_cache: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentstracker(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{
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
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.render_fulfillment_column_row_data(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'render_order_fulfillment_status_column_row_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.render_shipment_provider_column_row_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'render_shipment_tracking_column_row_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
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
			return this.handle_fulfillment_bulk_actions(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'render_fulfillment_status_text' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_fulfillment_status_text(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'render_fulfillment_customer_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_fulfillment_customer_details(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_details_badges' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.maybe_read_fulfillments(mut dispatch_arg_0)
		}
		else {
			return none
		}
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
		'fulfillments_cache' {
			this.fulfillments_cache = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
