import rt

struct Class_WC_Admin_List_Table_Orders {
	rt.PhpObjectBase
pub mut:
		list_table_type rt.PhpVal = rt.new_string('shop_order')
		orders_list_table rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Orders) construct()  {
	this.Class_WC_Admin_List_Table.construct()
	this.orders_list_table = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable.class()])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'bulk_admin_notices' }])])
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'order_preview_template' }])])
	rt.call_function('add_filter', [rt.new_string('get_search_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'search_label' }])])
	rt.call_function('add_filter', [rt.new_string('query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'add_custom_query_var' }])])
	rt.call_function('add_action', [rt.new_string('parse_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'search_custom_fields' }])])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_blank_state()  {
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
	return rt.create_array([rt.ArrayItem{ key: none, val: 'shipping_address' }, rt.ArrayItem{ key: none, val: 'billing_address' }, rt.ArrayItem{ key: none, val: 'wc_actions' }])
}

fn (mut this Class_WC_Admin_List_Table_Orders) define_sortable_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	mut var_custom := { 'order_number': 'ID', 'order_total': 'order_total', 'order_date': 'date' }
	var_columns_mutated.array_unset(rt.new_string('comments'))
	return rt.call_function('wp_parse_args', [var_custom.dup(), var_columns_mutated.dup()])
}

fn (mut this Class_WC_Admin_List_Table_Orders) define_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	mut var_show_columns := rt.new_array()
	var_show_columns['cb'] = var_columns_mutated.array_get('cb')
	var_show_columns['order_number'] = rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')])
	var_show_columns['order_date'] = rt.call_function('__', [rt.new_string('Date'), rt.new_string('woocommerce')])
	var_show_columns['order_status'] = rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')])
	var_show_columns['billing_address'] = rt.call_function('__', [rt.new_string('Billing'), rt.new_string('woocommerce')])
	var_show_columns['shipping_address'] = rt.call_function('__', [rt.new_string('Ship to'), rt.new_string('woocommerce')])
	var_show_columns['order_total'] = rt.call_function('__', [rt.new_string('Total'), rt.new_string('woocommerce')])
	var_show_columns['wc_actions'] = rt.call_function('__', [rt.new_string('Actions'), rt.new_string('woocommerce')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-orders')])
	return var_show_columns.dup()
}

fn (mut this Class_WC_Admin_List_Table_Orders) define_bulk_actions(var_actions rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	if var_actions_mutated.array_isset(rt.new_string('edit')) {
		var_actions_mutated.array_unset(rt.new_string('edit'))
	}
	var_actions_mutated.array_set('mark_processing', rt.call_function('__', [rt.new_string('Change status to processing'), rt.new_string('woocommerce')]))
	var_actions_mutated.array_set('mark_on-hold', rt.call_function('__', [rt.new_string('Change status to on-hold'), rt.new_string('woocommerce')]))
	var_actions_mutated.array_set('mark_completed', rt.call_function('__', [rt.new_string('Change status to completed'), rt.new_string('woocommerce')]))
	var_actions_mutated.array_set('mark_cancelled', rt.call_function('__', [rt.new_string('Change status to cancelled'), rt.new_string('woocommerce')]))
	if rt.is_true(rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_allow_bulk_remove_personal_data'), rt.new_string('no')])])) {
		var_actions_mutated.array_set('remove_personal_data', rt.call_function('__', [rt.new_string('Remove personal data'), rt.new_string('woocommerce')]))
	}
	return var_actions_mutated.dup()
}

fn (mut this Class_WC_Admin_List_Table_Orders) prepare_row_data(var_post_id rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.dispatch_set_prop('object', rt.call_function('wc_get_order', [var_post_id.dup()]))
		mut var_the_order := rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')
	}
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_number_column()  {
	rt.call_method(this.orders_list_table, 'render_order_number_column', [rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_status_column()  {
	rt.call_method(this.orders_list_table, 'render_order_status_column', [rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_date_column()  {
	rt.call_method(this.orders_list_table, 'render_order_date_column', [rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_order_total_column()  {
	rt.call_method(this.orders_list_table, 'render_order_total_column', [rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_wc_actions_column()  {
	rt.call_method(this.orders_list_table, 'render_wc_actions_column', [rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_billing_address_column()  {
	rt.call_method(this.orders_list_table, 'render_billing_address_column', [rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')])
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_shipping_address_column()  {
	rt.call_method(this.orders_list_table, 'render_shipping_address_column', [rt.get_property(rt.new_object('WC_Admin_List_Table_Orders', ['WC_Admin_List_Table'], &this), 'object')])
}

fn (mut this Class_WC_Admin_List_Table_Orders) order_preview_template()  {
	rt.echo_val(rt.call_method(this.orders_list_table, 'get_order_preview_template', []rt.PhpVal{}))
}

fn Class_WC_Admin_List_Table_Orders.get_order_preview_item_html(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_hidden_order_itemmeta := rt.call_function('apply_filters', [rt.new_string('woocommerce_hidden_order_itemmeta'), rt.create_array([rt.ArrayItem{ key: none, val: '_qty' }, rt.ArrayItem{ key: none, val: '_tax_class' }, rt.ArrayItem{ key: none, val: '_product_id' }, rt.ArrayItem{ key: none, val: '_variation_id' }, rt.ArrayItem{ key: none, val: '_line_subtotal' }, rt.ArrayItem{ key: none, val: '_line_subtotal_tax' }, rt.ArrayItem{ key: none, val: '_line_total' }, rt.ArrayItem{ key: none, val: '_line_tax' }, rt.ArrayItem{ key: none, val: 'method_id' }, rt.ArrayItem{ key: none, val: 'cost' }, rt.ArrayItem{ key: none, val: '_reduced_stock' }, rt.ArrayItem{ key: none, val: '_restock_refunded_items' }])])
	mut var_line_items := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_order_preview_line_items'), rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}), var_order_mutated.dup()])
	mut var_columns := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_order_preview_line_item_columns'), rt.create_array([rt.ArrayItem{ key: 'product', val: rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'quantity', val: rt.call_function('__', [rt.new_string('Quantity'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'tax', val: rt.call_function('__', [rt.new_string('Tax'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'total', val: rt.call_function('__', [rt.new_string('Total'), rt.new_string('woocommerce')]) }]), var_order_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))))) {
		var_columns.array_unset(rt.new_string('tax'))
	}
	mut var_html := rt.new_string(rt.new_string('\n\t\t<div class="wc-order-preview-table-wrapper">\n\t\t\t<table cellspacing="0" class="wc-order-preview-table">\n\t\t\t\t<thead>\n\t\t\t\t\t<tr>'))
	{
		mut iter_1 := var_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_column := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	mut var_refunds := rt.new_array()
	{
		mut iter_1 := rt.call_method(var_order_mutated, 'get_refunds', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_refund := item_1.val
			{
				mut iter_2 := rt.call_method(var_refund, 'get_items', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_item := item_2.val
					mut var_product_id := rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
					if rt.is_true(rt.new_bool(var_refunds.dup().array_isset(var_product_id.dup()))) {
						// unsupported expression: Expr_AssignOp_Plus
						// unsupported expression: Expr_AssignOp_Plus
					} else {
						var_refunds.array_set(var_product_id, rt.create_array([rt.ArrayItem{ key: 'quantity', val: rt.call_function('absint', [rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'total', val: rt.call_function('abs', [// unsupported expression: Expr_Cast_Double]) }]))
					}
				}
			}
		}
	}
	mut var_price_args := { 'currency': rt.call_method(var_order_mutated, 'get_currency', []rt.PhpVal{}) }
	{
		mut iter_1 := var_line_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			mut var_product_object := if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item }, rt.ArrayItem{ key: none, val: 'get_product' }])])) { rt.call_method(var_item, 'get_product', []rt.PhpVal{}) } else { rt.new_null() }
			mut var_row_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_html_order_preview_item_class'), rt.new_string(''), var_item.dup(), var_order_mutated.dup()])
			mut var_refund := if !(var_refunds.array_get(rt.call_method(var_item, 'get_product_id', []rt.PhpVal{}))).is_null() { var_refunds.array_get(rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})) } else { rt.new_null() }
			// unsupported expression: Expr_AssignOp_Concat
			{
				mut iter_2 := var_columns.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_label := item_2.val
					mut var_column := item_2.key
					// unsupported expression: Expr_AssignOp_Concat
					mut switch_val_1 := var_column
					if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
						// unsupported expression: Expr_AssignOp_Concat
						if rt.is_true(var_product_object) {
							// unsupported expression: Expr_AssignOp_Concat
						}
						mut var_meta_data := rt.call_method(var_item, 'get_all_formatted_meta_data', [rt.new_string('')])
						if rt.is_true(var_meta_data) {
							// unsupported expression: Expr_AssignOp_Concat
							{
								mut iter_3 := var_meta_data.iterator()
								for {
									item_3 := iter_3.next() or { break }
									mut var_meta := item_3.val
									mut var_meta_id := item_3.key
									if rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'key'), var_hidden_order_itemmeta.dup(), rt.new_bool(true)])) {
										continue
									}
									// unsupported expression: Expr_AssignOp_Concat
								}
							}
							// unsupported expression: Expr_AssignOp_Concat
						}
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('quantity'))) {
						// unsupported expression: Expr_AssignOp_Concat
						if rt.is_true(var_refund) {
							// unsupported expression: Expr_AssignOp_Concat
						}
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax'))) {
						// unsupported expression: Expr_AssignOp_Concat
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('total'))) {
						// unsupported expression: Expr_AssignOp_Concat
						if rt.is_true(var_refund) {
							// unsupported expression: Expr_AssignOp_Concat
						}
					} else {
						// unsupported expression: Expr_AssignOp_Concat
					}
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	return var_html.dup()
}

fn Class_WC_Admin_List_Table_Orders.get_order_preview_actions_html(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	mut var_actions := rt.new_array()
	mut var_status_actions := rt.new_array()
	mut var_wp_post_type := if !(rt.call_function('get_post_type_object', [rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{})])).is_null() { rt.call_function('get_post_type_object', [rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{})]) } else { rt.call_function('get_post_type_object', [rt.new_string('shop_order')]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_wp_post_type, 'cap'), 'edit_post'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})]))))) {
		return ''
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }])])) {
		var_status_actions['on-hold'] = rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('wp_nonce_url', [, ]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [, ]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [, ]) }, rt.ArrayItem{ key: 'action', val: 'on-hold' }])
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() }])])) {
		var_status_actions['processing'] = rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }])])) {
		[] = 
	}
	if rt.is_true(var_status_actions) {
		
	}
	return ().str()
}

fn Class_WC_Admin_List_Table_Orders.order_preview_get_order_details(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Admin_List_Table_Orders) handle_bulk_actions(var_redirect_to rt.PhpVal, var_action rt.PhpVal, var_ids rt.PhpVal) rt.PhpVal {
	mut var_redirect_to_mutated := var_redirect_to
	mut var_ids_mutated := var_ids
}

fn (mut this Class_WC_Admin_List_Table_Orders) bulk_admin_notices()  {
	mut var_post_type := rt.new_null()
	mut var_pagenow := rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Orders) restrict_manage_posts()  {
	mut var_typenow := rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Orders) render_filters()  {
}

fn (mut this Class_WC_Admin_List_Table_Orders) request_query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_typenow := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Admin_List_Table_Orders) query_filters(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wp_post_statuses := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Admin_List_Table_Orders) search_label(var_query rt.PhpVal) rt.PhpVal {
	mut var_pagenow := rt.new_null()
	mut var_typenow := rt.new_null()
	return rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Orders) add_custom_query_var(var_public_query_vars rt.PhpVal) rt.PhpVal {
	mut var_public_query_vars_mutated := var_public_query_vars
}

fn (mut this Class_WC_Admin_List_Table_Orders) search_custom_fields(var_wp rt.PhpVal)  {
	mut var_pagenow := rt.new_null()
}

struct Class_WC_Admin_List_Table {
	rt.PhpObjectBase
}

fn create_wc_admin_list_table_orders() &Class_WC_Admin_List_Table_Orders {
	mut obj := &Class_WC_Admin_List_Table_Orders{
		PhpObjectBase: rt.PhpObjectBase{}
		list_table_type: rt.new_string('shop_order')
		orders_list_table: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_admin_list_table() &Class_WC_Admin_List_Table {
	mut obj := &Class_WC_Admin_List_Table{
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
		else { return none }
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
		'list_table_type' { this.list_table_type = val; return true }
		'orders_list_table' { this.orders_list_table = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_list_tables_class_wc_admin_list_table_orders_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_List_Table_Orders'), rt.new_bool(false)])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_List_Table'), rt.new_bool(false)]))))) {
		rt.include_file(@DIR + '/abstract-class-wc-admin-list-table.php', '2')
	}
}
