import rt

struct Class_WC_Admin_List_Table_Orders {
	rt.PhpObjectBase
pub mut:
	list_table_type   rt.PhpVal = rt.new_string('shop_order')
	orders_list_table rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Orders) construct() {
	this.Class_WC_Admin_List_Table.construct()
	this.orders_list_table = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable.class()])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'bulk_admin_notices' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_preview_template' },
		])])
	rt.call_function('add_filter', [rt.new_string('get_search_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'search_label' },
		])])
	rt.call_function('add_filter', [rt.new_string('query_vars'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_custom_query_var' },
		])])
	rt.call_function('add_action', [rt.new_string('parse_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'search_custom_fields' },
		])])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_blank_state() {
	rt.call_method(this.orders_list_table, 'render_blank_state', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_List_Table_Orders) get_primary_column() string {
	return 'order_number'
}

fn (mut this Class_WC_Admin_List_Table_Orders) get_row_actions(var_actions rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	return rt.new_array()
}

fn (mut this Class_WC_Admin_List_Table_Orders) define_hidden_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'shipping_address' },
		rt.ArrayItem{ key: none, val: 'billing_address' }, rt.ArrayItem{
			key: none
			val: 'wc_actions'
		}])
}

fn (mut this Class_WC_Admin_List_Table_Orders) define_sortable_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	mut var_custom := {
		'order_number': 'ID'
		'order_total':  'order_total'
		'order_date':   'date'
	}
	var_columns_mutated.array_unset(rt.new_string('comments'))
	return rt.call_function('wp_parse_args', [
		rt.create_array_from_native_map(var_custom),
		var_columns_mutated.clone(),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) define_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	mut var_show_columns := rt.new_array()
	var_show_columns['cb'] = var_columns_mutated.array_get(rt.new_string('cb'))
	var_show_columns['order_number'] = rt.call_function('__', [
		rt.new_string('Order'), rt.new_string('woocommerce')])
	var_show_columns['order_date'] = rt.call_function('__', [
		rt.new_string('Date'), rt.new_string('woocommerce')])
	var_show_columns['order_status'] = rt.call_function('__', [
		rt.new_string('Status'), rt.new_string('woocommerce')])
	var_show_columns['billing_address'] = rt.call_function('__', [
		rt.new_string('Billing'),
		rt.new_string('woocommerce'),
	])
	var_show_columns['shipping_address'] = rt.call_function('__', [
		rt.new_string('Ship to'),
		rt.new_string('woocommerce'),
	])
	var_show_columns['order_total'] = rt.call_function('__', [
		rt.new_string('Total'), rt.new_string('woocommerce')])
	var_show_columns['wc_actions'] = rt.call_function('__', [
		rt.new_string('Actions'), rt.new_string('woocommerce')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-orders')])
	return var_show_columns.clone()
}

fn (mut this Class_WC_Admin_List_Table_Orders) define_bulk_actions(var_actions rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	if var_actions_mutated.array_isset(rt.new_string('edit')) {
		var_actions_mutated.array_unset(rt.new_string('edit'))
	}
	var_actions_mutated.array_set('mark_processing', rt.call_function('__', [
		rt.new_string('Change status to processing'),
		rt.new_string('woocommerce'),
	]))
	var_actions_mutated.array_set('mark_on-hold', rt.call_function('__', [
		rt.new_string('Change status to on-hold'),
		rt.new_string('woocommerce'),
	]))
	var_actions_mutated.array_set('mark_completed', rt.call_function('__', [
		rt.new_string('Change status to completed'),
		rt.new_string('woocommerce'),
	]))
	var_actions_mutated.array_set('mark_cancelled', rt.call_function('__', [
		rt.new_string('Change status to cancelled'),
		rt.new_string('woocommerce'),
	]))
	if rt.is_true(rt.call_function('wc_string_to_bool', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_allow_bulk_remove_personal_data'),
			rt.new_string('no'),
		]),
	]))
	{
		var_actions_mutated.array_set('remove_personal_data', rt.call_function('__', [
			rt.new_string('Remove personal data'),
			rt.new_string('woocommerce'),
		]))
	}
	return var_actions_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Orders) prepare_row_data(var_post_id rt.PhpVal) {
	mut var_the_order := rt.get_superglobal('the_order')
	if !rt.is_true(rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{}), var_post_id)))) {
		this.dispatch_set_prop('object', rt.call_function('wc_get_order', [
			var_post_id.clone()]))
		var_the_order = rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object')
	}
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_number_column() {
	rt.call_method(this.orders_list_table, 'render_order_number_column', [
		rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object'),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_status_column() {
	rt.call_method(this.orders_list_table, 'render_order_status_column', [
		rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object'),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_date_column() {
	rt.call_method(this.orders_list_table, 'render_order_date_column', [
		rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object'),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_total_column() {
	rt.call_method(this.orders_list_table, 'render_order_total_column', [
		rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object'),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_wc_actions_column() {
	rt.call_method(this.orders_list_table, 'render_wc_actions_column', [
		rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object'),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_billing_address_column() {
	rt.call_method(this.orders_list_table, 'render_billing_address_column', [
		rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object'),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_shipping_address_column() {
	rt.call_method(this.orders_list_table, 'render_shipping_address_column', [
		rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', [
			'WC_Admin_List_Table',
		], &this), 'object'),
	])
}

fn (mut this Class_WC_Admin_List_Table_Orders) order_preview_template() {
	rt.echo_val(rt.call_method(this.orders_list_table, 'get_order_preview_template', []rt.PhpVal{}))
}

fn Class_WC_Admin_List_Table_Orders.get_order_preview_item_html(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_hidden_order_itemmeta := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_hidden_order_itemmeta'),
		rt.create_array([rt.ArrayItem{ key: none, val: '_qty' },
			rt.ArrayItem{ key: none, val: '_tax_class' }, rt.ArrayItem{
				key: none
				val: '_product_id'
			}, rt.ArrayItem{ key: none, val: '_variation_id' },
			rt.ArrayItem{ key: none, val: '_line_subtotal' },
			rt.ArrayItem{ key: none, val: '_line_subtotal_tax' },
			rt.ArrayItem{ key: none, val: '_line_total' }, rt.ArrayItem{ key: none, val: '_line_tax' },
			rt.ArrayItem{ key: none, val: 'method_id' }, rt.ArrayItem{ key: none, val: 'cost' },
			rt.ArrayItem{ key: none, val: '_reduced_stock' },
			rt.ArrayItem{ key: none, val: '_restock_refunded_items' }]),
	])
	mut var_line_items := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_preview_line_items'),
		rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}),
		var_order_mutated.clone(),
	])
	mut var_columns := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_preview_line_item_columns'),
		rt.create_array([
			rt.ArrayItem{ key: 'product', val: rt.call_function('__', [
				rt.new_string('Product'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'quantity', val: rt.call_function('__', [
				rt.new_string('Quantity'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'tax', val: rt.call_function('__', [
				rt.new_string('Tax'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'total', val: rt.call_function('__', [
				rt.new_string('Total'),
				rt.new_string('woocommerce'),
			]) },
		]),
		var_order_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))))) {
		var_columns.array_unset(rt.new_string('tax'))
	}
	mut var_html :=
		rt.new_string('\n\t\t<div class="wc-order-preview-table-wrapper">\n\t\t\t<table cellspacing="0" class="wc-order-preview-table">\n\t\t\t\t<thead>\n\t\t\t\t\t<tr>')
	mut iter_1 := var_columns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_label := item_1.val
		mut var_column := item_1.key
		var_html = rt.concat(var_html, rt.new_string(
			'<th class="wc-order-preview-table__column--' +
			(rt.call_function('esc_attr', [var_column.clone()])).str() + '">' +
			(rt.call_function('esc_html', [var_label.clone()])).str() + '</th>'))
	}
	var_html = rt.concat(var_html,
		rt.new_string('\n\t\t\t\t\t</tr>\n\t\t\t\t</thead>\n\t\t\t\t<tbody>'))
	mut var_refunds := rt.new_array()
	mut iter_2 := rt.call_method(var_order_mutated, 'get_refunds', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_refund := item_2.val
		mut iter_3 := rt.call_method(var_refund, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_item := item_3.val
			mut var_product_id := rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(var_refunds.clone().array_isset(var_product_id.clone()))) {
				var_refunds.array_get(var_product_id).array_get(rt.new_string('quantity')) = rt.add(var_refunds.array_get(var_product_id).array_get(rt.new_string('quantity')), rt.call_function('absint', [
					rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
				]))
				var_refunds.array_get(var_product_id).array_get(rt.new_string('total')) = rt.add(var_refunds.array_get(var_product_id).array_get(rt.new_string('total')), rt.call_function('abs', [
					rt.new_float((rt.call_method(var_item, 'get_total', []rt.PhpVal{})).to_f64()),
				]))
			} else {
				var_refunds.array_set(var_product_id, rt.create_array([
					rt.ArrayItem{ key: 'quantity', val: rt.call_function('absint', [
						rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
					]) },
					rt.ArrayItem{ key: 'total', val: rt.call_function('abs', [
						rt.new_float((rt.call_method(var_item, 'get_total', []rt.PhpVal{})).to_f64()),
					]) },
				]))
			}
		}
	}
	mut var_price_args := {
		'currency': rt.call_method(var_order_mutated, 'get_currency', []rt.PhpVal{})
	}
	mut iter_4 := var_line_items.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_item := item_4.val
		mut var_item_id := item_4.key
		mut var_product_object := if rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_item },
				rt.ArrayItem{ key: none, val: 'get_product' }]),
		])
		{ rt.call_method(var_item, 'get_product', []rt.PhpVal{}) } else { rt.new_null() }
		mut var_row_class := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_html_order_preview_item_class'),
			rt.new_string(''),
			var_item.clone(),
			var_order_mutated.clone(),
		])
		mut var_refund := if !(var_refunds.array_get(rt.call_method(var_item, 'get_product_id',
			[]rt.PhpVal{}))).is_null() {
			var_refunds.array_get(rt.call_method(var_item, 'get_product_id', []rt.PhpVal{}))
		} else {
			rt.new_null()
		}
		var_html = rt.concat(var_html, rt.new_string(
			'<tr class="wc-order-preview-table__item wc-order-preview-table__item--' +
			(rt.call_function('esc_attr', [var_item_id.clone()])).str() +
			if rt.is_true(var_row_class) { ' ' +
			(rt.call_function('esc_attr', [var_row_class.clone()])).str() } else { '' } + '">'))
		mut iter_5 := var_columns.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_label := item_5.val
			mut var_column := item_5.key
			var_html = rt.concat(var_html, rt.new_string(
				'<td class="wc-order-preview-table__column--' +
				(rt.call_function('esc_attr', [var_column.clone()])).str() + '">'))
			mut switch_val_1 := var_column
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
				var_html = rt.concat(var_html, rt.call_function('wp_kses_post', [
					rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
				]))
				if rt.is_true(var_product_object) {
					var_html = rt.concat(var_html, rt.new_string(
						'<div class="wc-order-item-sku">' +
						(rt.call_function('esc_html', [rt.call_method(var_product_object, 'get_sku', []rt.PhpVal{})])).str() +
						'</div>'))
				}
				mut var_meta_data := rt.call_method(var_item, 'get_all_formatted_meta_data', [
					rt.new_string(''),
				])
				if rt.is_true(var_meta_data) {
					var_html = rt.concat(var_html,
						rt.new_string('<table cellspacing="0" class="wc-order-item-meta">'))
					mut iter_6 := var_meta_data.iterator()
					for {
						item_6 := iter_6.next() or { break }
						mut var_meta := item_6.val
						mut var_meta_id := item_6.key
						if rt.is_true(rt.call_function('in_array', [
							rt.get_property(var_meta, 'key'),
							var_hidden_order_itemmeta.clone(),
							rt.new_bool(true),
						]))
						{
							continue
						}
						var_html = rt.concat(var_html, rt.new_string('<tr><th>' +
							(rt.call_function('wp_kses_post', [rt.get_property(var_meta, 'display_key')])).str() +
							':</th><td>' +
							(rt.call_function('wp_kses_post', [rt.call_function('force_balance_tags', [rt.get_property(var_meta, 'display_value')])])).str() +
							'</td></tr>'))
					}
					var_html = rt.concat(var_html, rt.new_string('</table>'))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('quantity'))) {
				var_html = rt.concat(var_html, rt.call_function('esc_html', [
					rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
				]))
				if rt.is_true(var_refund) {
					var_html = rt.concat(var_html, rt.new_string("<div><small class='refunded'>-" +
						(var_refund.array_get(rt.new_string('quantity'))).str() + '</small></div><br/>'))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax'))) {
				var_html = rt.concat(var_html, rt.call_function('wc_price', [
					rt.call_method(var_item, 'get_total_tax', []rt.PhpVal{}),
					rt.create_array_from_native_map(var_price_args),
				]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('total'))) {
				var_html = rt.concat(var_html, rt.call_function('wc_price', [
					rt.call_method(var_item, 'get_total', []rt.PhpVal{}),
					rt.create_array_from_native_map(var_price_args),
				]))
				if rt.is_true(var_refund) {
					var_html = rt.concat(var_html, rt.new_string("<div><small class='refunded'>-" +
						(rt.call_function('wc_price', [var_refund.array_get(rt.new_string('total')), rt.create_array_from_native_map(var_price_args)])).str() +
						'</small></div><br/>'))
				}
			} else {
				var_html = rt.concat(var_html, rt.call_function('apply_filters', [
					rt.new_string('woocommerce_admin_order_preview_line_item_column_' +
						(rt.call_function('sanitize_key', [var_column.clone()])).str()),
					rt.new_string(''),
					var_item.clone(),
					var_item_id.clone(),
					var_order_mutated.clone(),
				]))
			}
			var_html = rt.concat(var_html, rt.new_string('</td>'))
		}
		var_html = rt.concat(var_html, rt.new_string('</tr>'))
	}
	var_html = rt.concat(var_html, rt.new_string('\n\t\t\t\t</tbody>\n\t\t\t</table>\n\t\t</div>'))
	return var_html.clone()
}

fn Class_WC_Admin_List_Table_Orders.get_order_preview_actions_html(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	mut var_actions := rt.new_array()
	mut var_status_actions := rt.new_array()
	mut var_wp_post_type := if !(rt.call_function('get_post_type_object', [
		rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{}),
	])).is_null() { rt.call_function('get_post_type_object', [
			rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{}),
		]) } else { rt.call_function('get_post_type_object', [
			rt.new_string('shop_order'),
		]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_wp_post_type, 'cap'), 'edit_post'),
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
	])))))
	{
		return ''
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() },
		]),
	]))
	{
		var_status_actions['on-hold'] = rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('wp_nonce_url', [
				rt.call_function('admin_url', [
					rt.new_string(
						'admin-ajax.php?action=woocommerce_mark_order_status&status=on-hold&order_id=' +
						(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str()),
				]),
				rt.new_string('woocommerce-mark-order-status'),
			]) },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('On-hold'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Change order status to on-hold'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'on-hold' },
		])
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
		]),
	]))
	{
		var_status_actions['processing'] = rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('wp_nonce_url', [
				rt.call_function('admin_url', [
					rt.new_string(
						'admin-ajax.php?action=woocommerce_mark_order_status&status=processing&order_id=' +
						(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str()),
				]),
				rt.new_string('woocommerce-mark-order-status'),
			]) },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Processing'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Change order status to processing'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'processing' },
		])
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
		]),
	]))
	{
		var_status_actions['complete'] = rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('wp_nonce_url', [
				rt.call_function('admin_url', [
					rt.new_string(
						'admin-ajax.php?action=woocommerce_mark_order_status&status=completed&order_id=' +
						(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str()),
				]),
				rt.new_string('woocommerce-mark-order-status'),
			]) },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Completed'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Change order status to completed'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'complete' },
		])
	}
	if rt.is_true(var_status_actions) {
		var_actions['status'] = rt.create_array([
			rt.ArrayItem{ key: 'group', val: rt.call_function('__', [
				rt.new_string('Change status: '),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'actions', val: var_status_actions },
		])
	}
	return (rt.call_function('wc_render_action_buttons', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_order_preview_actions'),
			rt.create_array_from_native_map(var_actions),
			var_order_mutated.clone(),
		]),
	])).str()
}

fn Class_WC_Admin_List_Table_Orders.order_preview_get_order_details(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) {
		return rt.new_array()
	}
	mut var_payment_via := rt.call_method(var_order_mutated, 'get_payment_method_title',
		[]rt.PhpVal{})
	mut var_payment_method := rt.call_method(var_order_mutated, 'get_payment_method', []rt.PhpVal{})
	mut var_payment_gateways := if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways', []rt.PhpVal{}))
	{
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'),
			'payment_gateways', []rt.PhpVal{})
	} else {
		rt.new_array()
	}
	mut var_transaction_id := rt.call_method(var_order_mutated, 'get_transaction_id', []rt.PhpVal{})
	if rt.is_true(var_transaction_id) {
		mut var_url := if var_payment_gateways.array_isset(var_payment_method) { rt.call_method(var_payment_gateways.array_get(var_payment_method), 'get_transaction_url', [
				var_order_mutated.clone(),
			]) } else { rt.new_bool(false) }
		if rt.is_true(var_url) {
			var_payment_via = rt.concat(var_payment_via, rt.new_string(
				' (<a href="' + (rt.call_function('esc_url', [var_url.clone()])).str() +
				'" target="_blank">' +
				(rt.call_function('esc_html', [var_transaction_id.clone()])).str() + '</a>)'))
		} else {
			var_payment_via = rt.concat(var_payment_via, rt.new_string(
				' (' + (rt.call_function('esc_html', [var_transaction_id.clone()])).str() + ')'))
		}
	}
	mut var_billing_address := rt.call_method(var_order_mutated, 'get_formatted_billing_address',
		[]rt.PhpVal{})
	mut var_shipping_address := rt.call_method(var_order_mutated, 'get_formatted_shipping_address',
		[]rt.PhpVal{})
	mut var_wp_post_type := if !(rt.call_function('get_post_type_object', [
		rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{}),
	])).is_null() { rt.call_function('get_post_type_object', [
			rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{}),
		]) } else { rt.call_function('get_post_type_object', [
			rt.new_string('shop_order'),
		]) }
	mut var_is_editable := rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_wp_post_type, 'cap'), 'edit_post'),
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
	])
	mut var_order_details := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_preview_get_order_details'),
		rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.call_method(var_order_mutated, 'get_data',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'is_editable', val: var_is_editable },
			rt.ArrayItem{ key: 'order_number', val: rt.call_method(var_order_mutated,
				'get_order_number', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'item_html'
				val: Class_WC_Admin_List_Table_Orders.get_order_preview_item_html(var_order_mutated.clone())
			},
			rt.ArrayItem{
				key: 'actions_html'
				val: Class_WC_Admin_List_Table_Orders.get_order_preview_actions_html(var_order_mutated.clone())
			},
			rt.ArrayItem{ key: 'ship_to_billing', val: rt.call_function('wc_ship_to_billing_address_only',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'needs_shipping', val: rt.call_method(var_order_mutated,
				'needs_shipping_address', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'formatted_billing_address'
				val: if rt.is_true(var_billing_address) { var_billing_address } else { rt.call_function('__', [
						rt.new_string('N/A'),
						rt.new_string('woocommerce'),
					]) }
			},
			rt.ArrayItem{
				key: 'formatted_shipping_address'
				val: if rt.is_true(var_shipping_address) { var_shipping_address } else { rt.call_function('__', [
						rt.new_string('N/A'),
						rt.new_string('woocommerce'),
					]) }
			},
			rt.ArrayItem{ key: 'shipping_address_map_url', val: rt.call_method(var_order_mutated,
				'get_shipping_address_map_url', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'payment_via', val: var_payment_via },
			rt.ArrayItem{ key: 'shipping_via', val: rt.call_method(var_order_mutated,
				'get_shipping_method', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_order_mutated, 'get_status',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'status_name', val: rt.call_function('wc_get_order_status_name', [
				rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}),
			]) },
		]),
		var_order_mutated.clone(),
	])
	var_order_details.array_set('data', rt.call_function('array_intersect_key', [
		var_order_details.array_get(rt.new_string('data')),
		rt.call_function('array_flip', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
				rt.ArrayItem{ key: none, val: 'billing' }, rt.ArrayItem{ key: none, val: 'shipping' },
				rt.ArrayItem{ key: none, val: 'customer_note' }]),
		]),
	]))
	return var_order_details.clone()
}

fn (mut this Class_WC_Admin_List_Table_Orders) handle_bulk_actions(var_redirect_to rt.PhpVal, var_action rt.PhpVal, var_ids rt.PhpVal) rt.PhpVal {
	mut var_redirect_to_mutated := var_redirect_to
	mut var_ids_mutated := var_ids
	var_ids_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_bulk_action_ids'),
		rt.call_function('array_reverse', [
			rt.call_function('array_map', [rt.new_string('absint'),
				var_ids_mutated.clone()]),
		]),
		var_action.clone(),
		rt.new_string('order'),
	])
	mut var_changed := rt.new_int(0)
	if rt.is_true(rt.identical(rt.new_string('remove_personal_data'), var_action)) {
		mut var_report_action := rt.new_string('removed_personal_data')
		mut iter_7 := var_ids_mutated.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_id := item_7.val
			mut var_order := rt.call_function('wc_get_order', [
				var_id.clone()])
			if rt.is_true(var_order) {
				rt.call_function('do_action', [
					rt.new_string('woocommerce_remove_order_personal_data'),
					var_order.clone(),
				])
				rt.pre_inc(var_changed)
			}
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		var_action.clone(),
		rt.new_string('mark_'),
	])))))
	{
		mut var_order_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
		mut var_new_status := rt.call_function('substr', [var_action.clone(),
			rt.new_int(5)])
		var_report_action = rt.new_string('marked_' + var_new_status.str())
		if var_order_statuses.array_isset('wc-' + var_new_status.str()) {
			rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
			mut iter_8 := var_ids_mutated.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_id := item_8.val
				mut var_order := rt.call_function('wc_get_order', [
					var_id.clone()])
				rt.call_method(var_order, 'update_status', [var_new_status.clone(),
					rt.call_function('__', [
						rt.new_string('Order status changed by bulk edit:'),
						rt.new_string('woocommerce'),
					]),
					rt.new_bool(true)])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_order_edit_status'),
					var_id.clone(),
					var_new_status.clone(),
				])
				rt.pre_inc(var_changed)
			}
		}
	}
	if rt.is_true(var_changed) {
		var_redirect_to_mutated = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'post_type', val: this.list_table_type },
				rt.ArrayItem{ key: 'bulk_action', val: var_report_action },
				rt.ArrayItem{ key: 'changed', val: var_changed },
				rt.ArrayItem{ key: 'ids', val: rt.call_function('join', [
					rt.new_string(','),
					var_ids_mutated.clone(),
				]) }]),
			var_redirect_to_mutated.clone(),
		])
	}
	return rt.call_function('esc_url_raw', [var_redirect_to_mutated.clone()])
}

fn (mut this Class_WC_Admin_List_Table_Orders) bulk_admin_notices() {
	mut var_post_type := rt.new_null()
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit.php'), var_pagenow))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), var_post_type))))
		|| !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('bulk_action'))) {
		return
	}
	mut var_order_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut var_number := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('changed')) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('changed')),
		]) } else { rt.new_int(0) }
	mut var_bulk_action := rt.call_function('wc_clean', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('bulk_action'))]),
	])
	mut iter_9 := var_order_statuses.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_name := item_9.val
		mut var_slug := item_9.key
		if rt.is_true(rt.identical('marked_' +(rt.call_function('str_replace', [rt.new_string('wc-'), rt.new_string(''), var_slug.clone()])).str(),
			var_bulk_action))
		{
			mut var_message := rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s order status changed.'),
					rt.new_string('%s order statuses changed.'),
					var_number.clone(), rt.new_string('woocommerce')]),
				rt.call_function('number_format_i18n', [var_number.clone()]),
			])
			print('<div class="updated"><p>' +
				(rt.call_function('esc_html', [var_message.clone()])).str() + '</p></div>')
			break
		}
	}
	if rt.is_true(rt.identical(rt.new_string('removed_personal_data'), var_bulk_action)) {
		mut var_message := rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('Removed personal data from %s order.'),
				rt.new_string('Removed personal data from %s orders.'),
				var_number.clone(),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('number_format_i18n', [
				var_number.clone(),
			]),
		])
		print('<div class="updated"><p>' +
			(rt.call_function('esc_html', [var_message.clone()])).str() + '</p></div>')
	}
}

fn (mut this Class_WC_Admin_List_Table_Orders) restrict_manage_posts() {
	mut var_typenow := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [var_typenow.clone(),
		rt.call_function('wc_get_order_types', [rt.new_string('order-meta-boxes')]),
		rt.new_bool(true)]))
	{
		this.render_filters()
	}
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_filters() {
	rt.call_method(this.orders_list_table, 'created_via_filter', []rt.PhpVal{})
	rt.call_method(this.orders_list_table, 'customers_filter', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_List_Table_Orders) request_query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_typenow := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	if rt.is_true(rt.call_function('in_array', [var_typenow.clone(),
		rt.call_function('wc_get_order_types', [rt.new_string('order-meta-boxes')]),
		rt.new_bool(true)]))
	{
		return this.query_filters(var_query_vars_mutated.clone())
	}
	return var_query_vars_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Orders) query_filters(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wp_post_statuses := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_customer_user')))) {
		var_query_vars_mutated.array_set('meta_query', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_customer_user' },
				rt.ArrayItem{
					key: 'value'
					val: rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('_customer_user'))).to_i64())
				},
				rt.ArrayItem{ key: 'compare', val: '=' },
			]) },
		]))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_created_via')))) {
		mut var_created_via := rt.call_function('explode', [rt.new_string(','),
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('_created_via')),
				]),
			])])
		var_query_vars_mutated.array_set('meta_query', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_created_via' },
				rt.ArrayItem{ key: 'value', val: var_created_via },
				rt.ArrayItem{ key: 'compare', val: 'IN' },
			]) },
		]))
	}
	if var_query_vars_mutated.array_isset(rt.new_string('orderby')) {
		if rt.is_true(rt.identical(rt.new_string('order_total'),
			var_query_vars_mutated.array_get(rt.new_string('orderby'))))
		{
			var_query_vars_mutated = rt.call_function('array_merge', [
				var_query_vars_mutated.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'meta_key', val: '_order_total' },
					rt.ArrayItem{ key: 'orderby', val: 'meta_value_num' },
				])])
		}
	}
	if !rt.is_true(var_query_vars_mutated.array_get(rt.new_string('post_status'))) {
		mut var_post_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
		mut iter_10 := var_post_statuses.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_value := item_10.val
			mut var_status := item_10.key
			if var_wp_post_statuses.array_isset(var_status)
				&& rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(var_wp_post_statuses.array_get(var_status), 'show_in_admin_all_list'))) {
				var_post_statuses.array_unset(var_status)
			}
		}
		var_query_vars_mutated.array_set('post_status',
			rt.func_array_keys(var_post_statuses.clone()))
	}
	return var_query_vars_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Orders) search_label(var_query rt.PhpVal) rt.PhpVal {
	mut var_pagenow := rt.new_null()
	mut var_typenow := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit.php'), var_pagenow))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), var_typenow))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_query_var', [rt.new_string('shop_order_search')])))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('s'))) {
		return var_query.clone()
	}
	return rt.call_function('wc_clean', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('s'))]),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Orders) add_custom_query_var(var_public_query_vars rt.PhpVal) rt.PhpVal {
	mut var_public_query_vars_mutated := var_public_query_vars
	var_public_query_vars_mutated.array_push('shop_order_search')
	return var_public_query_vars_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Orders) search_custom_fields(var_wp rt.PhpVal) {
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit.php'), var_pagenow))))
		|| !(rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('post_type')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('post_type')))))) {
		return
	}
	mut var_post_ids := if rt.get_superglobal('_GET').array_isset(rt.new_string('s')) && !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('s')))) { rt.call_function('wc_order_search', [
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('s'))]),
			]),
		]) } else { rt.new_array() }
	if !(!rt.is_true(var_post_ids)) {
		rt.get_property(var_wp, 'query_vars').array_unset(rt.new_string('s'))
		rt.get_property(var_wp, 'query_vars').array_set('shop_order_search', true)
		rt.get_property(var_wp, 'query_vars').array_set('post__in', rt.call_function('array_merge', [
			var_post_ids.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 0 }]),
		]))
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('order_date_type'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('m')) {
		mut var_date_type := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('order_date_type')),
			]),
		])
		mut var_date_query := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('m'))]),
		])
		if rt.is_true(rt.identical(rt.new_string('date_paid'), var_date_type))
			|| rt.is_true(rt.identical(rt.new_string('date_completed'), var_date_type)) {
			mut iife_temp_0 := Class_DateTime{}
			mut iife_result_0 := iife_temp_0.createfromformat(rt.new_string('Ymd H:i:s'),
				rt.new_string('${var_date_query.to_string()} 00:00:00'))
			mut var_date_start := iife_result_0
			mut iife_temp_1 := Class_DateTime{}
			mut iife_result_1 := iife_temp_1.createfromformat(rt.new_string('Ymd H:i:s'),
				rt.new_string('${var_date_query.to_string()} 23:59:59'))
			mut var_date_end := iife_result_1
			rt.get_property(var_wp, 'query_vars').array_unset(rt.new_string('m'))
			if rt.is_true(var_date_start) && rt.is_true(var_date_end) {
				rt.get_property(var_wp, 'query_vars').array_set('meta_key',
					'_${var_date_type.to_string()}')
				rt.get_property(var_wp, 'query_vars').array_set('meta_value', rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_method(var_date_start, 'getTimestamp',
						[]rt.PhpVal{}).to_string() },
					rt.ArrayItem{ key: none, val: rt.call_method(var_date_end, 'getTimestamp',
						[]rt.PhpVal{}).to_string() },
				]))
				rt.get_property(var_wp, 'query_vars').array_set('meta_compare', 'BETWEEN')
			}
		}
	}
}

struct Class_WC_Admin_List_Table {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wc_admin_list_table_orders() &Class_WC_Admin_List_Table_Orders {
	mut obj := &Class_WC_Admin_List_Table_Orders{
		PhpObjectBase:     rt.PhpObjectBase{}
		list_table_type:   rt.new_string('shop_order')
		orders_list_table: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_admin_list_table(_args ...rt.PhpVal) &Class_WC_Admin_List_Table {
	mut obj := &Class_WC_Admin_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_List_Table_Orders) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'render_blank_state' {
			this.render_blank_state()
			return rt.new_null()
		}
		'get_primary_column' {
			return rt.new_string(this.get_primary_column())
		}
		'get_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_row_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'define_hidden_columns' {
			return this.define_hidden_columns()
		}
		'define_sortable_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_sortable_columns(dispatch_arg_0)
		}
		'define_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_columns(dispatch_arg_0)
		}
		'define_bulk_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_bulk_actions(dispatch_arg_0)
		}
		'prepare_row_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepare_row_data(dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_number_column' {
			this.render_order_number_column()
			return rt.new_null()
		}
		'render_order_status_column' {
			this.render_order_status_column()
			return rt.new_null()
		}
		'render_order_date_column' {
			this.render_order_date_column()
			return rt.new_null()
		}
		'render_order_total_column' {
			this.render_order_total_column()
			return rt.new_null()
		}
		'render_wc_actions_column' {
			this.render_wc_actions_column()
			return rt.new_null()
		}
		'render_billing_address_column' {
			this.render_billing_address_column()
			return rt.new_null()
		}
		'render_shipping_address_column' {
			this.render_shipping_address_column()
			return rt.new_null()
		}
		'order_preview_template' {
			this.order_preview_template()
			return rt.new_null()
		}
		'get_order_preview_item_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_List_Table_Orders.get_order_preview_item_html(dispatch_arg_0)
		}
		'get_order_preview_actions_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Admin_List_Table_Orders.get_order_preview_actions_html(dispatch_arg_0))
		}
		'order_preview_get_order_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_List_Table_Orders.order_preview_get_order_details(dispatch_arg_0)
		}
		'handle_bulk_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.handle_bulk_actions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'bulk_admin_notices' {
			this.bulk_admin_notices()
			return rt.new_null()
		}
		'restrict_manage_posts' {
			this.restrict_manage_posts()
			return rt.new_null()
		}
		'render_filters' {
			this.render_filters()
			return rt.new_null()
		}
		'request_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.request_query(dispatch_arg_0)
		}
		'query_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query_filters(dispatch_arg_0)
		}
		'search_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.search_label(dispatch_arg_0)
		}
		'add_custom_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_custom_query_var(dispatch_arg_0)
		}
		'search_custom_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.search_custom_fields(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_List_Table_Orders) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'list_table_type' { return this.list_table_type }
		'orders_list_table' { return this.orders_list_table }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_List_Table_Orders) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'list_table_type' {
			this.list_table_type = val
			return true
		}
		'orders_list_table' {
			this.orders_list_table = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Admin_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_List_Table_Orders'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_List_Table'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(@DIR + '/abstract-class-wc-admin-list-table.php', '2')
	}
}
