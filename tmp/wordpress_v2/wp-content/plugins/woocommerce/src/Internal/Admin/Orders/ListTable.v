import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable {
	rt.PhpObjectBase
pub mut:
	order_type         rt.PhpVal = rt.new_null()
	wp_post_type       rt.PhpVal = rt.new_null()
	request            rt.PhpVal = rt.new_array()
	order_query_args   rt.PhpVal = rt.new_array()
	has_filter         bool
	page_controller    rt.PhpVal = rt.new_null()
	is_trash           bool
	status_count_cache rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) construct() {
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'singular', val: 'order' },
		rt.ArrayItem{ key: 'plural', val: 'orders' },
		rt.ArrayItem{ key: 'ajax', val: false },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) init(mut var_page_controller Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) {
	this.page_controller = var_page_controller
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) setup(var_args rt.PhpVal) {
	this.order_type = if !(var_args.array_get(rt.new_string('order_type'))).is_null() {
		var_args.array_get(rt.new_string('order_type'))
	} else {
		rt.new_string('shop_order')
	}
	this.wp_post_type = rt.call_function('get_post_type_object', [this.order_type])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'bulk_action_notices' },
		])])
	rt.call_function('add_filter', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
			'WP_List_Table',
		], &this), 'screen'), 'id')), rt.new_string('_columns')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_columns' },
		]),
		rt.new_int(0),
	])
	rt.call_function('add_filter', [
		rt.new_string('set_screen_option_edit_' + (this.order_type).str() + '_per_page'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_items_per_page' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [rt.new_string('default_hidden_columns'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'default_hidden_columns' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_scripts' },
		])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_list_table_restrict_manage_orders'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'created_via_filter' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_list_table_restrict_manage_orders'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'customers_filter' },
		]),
	])
	this.items_per_page()
	rt.call_function('set_screen_options', []rt.PhpVal{})
	rt.call_function('add_action', [
		rt.new_string('manage_' +
			(rt.call_function('wc_get_page_screen_id', [this.order_type])).str() + '_custom_column'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'render_column' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) single_row(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_css_classes := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_order_css_classes'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'order-' +
				(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str() },
			rt.ArrayItem{ key: none, val: 'type-' +
				(rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{})).str() },
			rt.ArrayItem{ key: none, val: 'status-' +
				(rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})).str() },
		]),
		var_order_mutated.clone(),
	])
	var_css_classes = rt.call_function('array_unique', [
		rt.call_function('array_map', [rt.new_string('trim'),
			var_css_classes.clone()]),
	])
	mut var_edit_lock := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.class(),
	])
	if rt.is_true(rt.call_method(var_edit_lock, 'is_locked_by_another_user', [
		var_order_mutated.clone()]))
	{
		var_css_classes.array_push('wp-locked')
	}
	print('<tr id="order-' +
		(rt.call_function('esc_attr', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])).str() +
		'" class="' +
		(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_css_classes.clone()])])).str() +
		'">')
	this.single_row_columns(var_order_mutated.clone())
	print('</tr>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_column(var_column_id rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) {
		return
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'render_' + var_column_id.str() + '_column' },
		]),
	]))
	{
		rt.call_function('call_user_func', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
					'WP_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'render_' + var_column_id.str() + '_column' },
			]),
			var_order_mutated.clone(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) column_default(var_order rt.PhpVal, var_column_name rt.PhpVal) {
	mut var_order_mutated := var_order
	rt.call_function('do_action', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_custom_column'),
		var_column_name.clone(),
		var_order_mutated.clone(),
	])
	rt.call_function('do_action', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
			'WP_List_Table',
		], &this), 'screen'), 'id')), rt.new_string('_custom_column')),
		var_column_name.clone(),
		var_order_mutated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) items_per_page() {
	rt.call_function('add_screen_option', [rt.new_string('per_page'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 20 },
			rt.ArrayItem{ key: 'option', val: 'edit_' + (this.order_type).str() + '_per_page' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_items_per_page(var_default rt.PhpVal, option string, value i64) rt.PhpVal {
	mut option_mutated := option
	return if rt.is_true(rt.identical('edit_' + (this.order_type).str() + '_per_page', rt.new_string(option_mutated))) { rt.call_function('absint', [
			rt.new_int(value),
		]) } else { var_default }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) display() {
	mut var_post_type := rt.call_function('get_post_type_object', [this.order_type])
	mut var_title := rt.call_function('esc_html', [
		rt.get_property(rt.get_property(var_post_type, 'labels'), 'name'),
	])
	mut var_add_new := rt.call_function('esc_html', [
		rt.get_property(rt.get_property(var_post_type, 'labels'), 'add_new'),
	])
	mut var_new_page_link := rt.call_method(this.page_controller, 'get_new_page_url', [
		this.order_type,
	])
	mut var_search_label := rt.new_string('')
	if !(!rt.is_true(this.order_query_args.array_get(rt.new_string('s')))) {
		var_search_label = rt.new_string('<span class="subtitle">')
		var_search_label = rt.concat(var_search_label, rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Search results for: %s'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('esc_html', [this.order_query_args.array_get(rt.new_string('s'))])).str() +
				'</strong>'),
		]))
		var_search_label = rt.concat(var_search_label, rt.new_string('</span>'))
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.new_string(
			"\n\t\t\t<div class='wrap'>\n\t\t\t\t<h1 class='wp-heading-inline'>${var_title.to_string()}</h1>\n\t\t\t\t<a href='" +
			(rt.call_function('esc_url', [var_new_page_link.clone()])).str() +
			"' class='page-title-action'>${var_add_new.to_string()}</a>\n\t\t\t\t${var_search_label.to_string()}\n\t\t\t\t<hr class='wp-header-end'>"),
	]))
	if this.should_render_blank_state() {
		this.render_blank_state()
		return
	}
	this.views()
	print('<form id="wc-orders-filter" method="get" action="' +
		(rt.call_function('esc_url', [rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('admin.php')])])).str() +
		'">')
	this.print_hidden_form_fields()
	this.search_box(rt.call_function('esc_html__', [rt.new_string('Search orders'),
		rt.new_string('woocommerce')]), rt.new_string('orders-search-input'))
	this.Class_WP_List_Table.display()
	print('</form> </div>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_blank_state() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('When you receive a new order, it will appear here.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more about orders'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('wc_marketplace_suggestions_orders_empty_state'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_bulk_actions() rt.PhpVal {
	mut var_selected_status := if !(this.order_query_args.array_get(rt.new_string('status'))).is_null() {
		this.order_query_args.array_get(rt.new_string('status'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(this.wp_post_type, 'cap'), 'edit_others_posts'),
	])))))
	{
		return rt.new_array()
	}
	if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'trash' }]),
		var_selected_status))
	{
		mut var_actions := rt.create_array([
			rt.ArrayItem{ key: 'untrash', val: rt.call_function('__', [
				rt.new_string('Restore'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'delete', val: rt.call_function('__', [
				rt.new_string('Delete permanently'),
				rt.new_string('woocommerce'),
			]) },
		])
	} else {
		var_actions = rt.create_array([
			rt.ArrayItem{ key: 'mark_processing', val: rt.call_function('__', [
				rt.new_string('Change status to processing'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'mark_on-hold', val: rt.call_function('__', [
				rt.new_string('Change status to on-hold'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'mark_completed', val: rt.call_function('__', [
				rt.new_string('Change status to completed'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'mark_cancelled', val: rt.call_function('__', [
				rt.new_string('Change status to cancelled'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'trash', val: rt.call_function('__', [
				rt.new_string('Move to Trash'),
				rt.new_string('woocommerce'),
			]) },
		])
	}
	if rt.is_true(rt.call_function('wc_string_to_bool', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_allow_bulk_remove_personal_data'),
			rt.new_string('no'),
		]),
	]))
	{
		var_actions.array_set('remove_personal_data', rt.call_function('__', [
			rt.new_string('Remove personal data'),
			rt.new_string('woocommerce'),
		]))
	}
	return var_actions.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_table_classes() rt.PhpVal {
	mut var_css_classes := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_css_classes'),
		rt.call_function('array_merge', [this.Class_WP_List_Table.get_table_classes(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wc-orders-list-table' },
				rt.ArrayItem{ key: none, val: 'wc-orders-list-table-' + (this.order_type).str() }])]),
		this.order_type,
	])
	return rt.call_function('array_unique', [
		rt.call_function('array_map', [rt.new_string('trim'),
			var_css_classes.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) prepare_items() {
	mut var_limit := this.get_items_per_page(rt.new_string('edit_' +
		(this.order_type).str() + '_per_page'))
	this.order_query_args = rt.create_array([
		rt.ArrayItem{ key: 'limit', val: var_limit },
		rt.ArrayItem{ key: 'page', val: this.get_pagenum() },
		rt.ArrayItem{ key: 'paginate', val: true },
		rt.ArrayItem{ key: 'type', val: this.order_type },
	])
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'status' },
		rt.ArrayItem{ key: none, val: 's' }, rt.ArrayItem{ key: none, val: 'm' },
		rt.ArrayItem{ key: none, val: '_customer_user' }, rt.ArrayItem{
			key: none
			val: 'search-filter'
		}]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_query_var := item_1.val
		this.request.array_set(var_query_var, rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(var_query_var)).is_null() {
				rt.get_superglobal('_REQUEST').array_get(var_query_var)
			} else {
				rt.new_string('')
			}]),
		]))
	}
	this.request = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_request'),
		this.request,
	])
	this.set_status_args()
	this.set_order_args()
	this.set_date_args()
	this.set_customer_args()
	this.set_search_args()
	this.set_created_via_args()
	mut var_order_query_args := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_list_table_prepare_items_query_args'),
		this.order_query_args,
	]))
	var_order_query_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' +
			(this.order_type).str() + '_list_table_prepare_items_query_args'),
		var_order_query_args.clone(),
	])
	var_order_query_args.array_set('paginate', true)
	if !rt.is_true(rt.call_function('array_diff', [
		rt.func_array_keys(this.order_query_args),
		rt.create_array([rt.ArrayItem{ key: none, val: 'limit' },
			rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'paginate' },
			rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'status' },
			rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'order' }]),
	])) {
		this.order_query_args.array_set('no_found_rows', true)
		var_order_query_args.array_set('no_found_rows', true)
	}
	mut var_orders := rt.call_function('wc_get_orders', [var_order_query_args.clone()])
	this.dispatch_set_prop('items', rt.get_property(var_orders, 'orders'))
	mut var_max_num_pages := this.get_max_num_pages(var_orders.clone())
	if rt.is_true(rt.identical(rt.new_int(0), var_max_num_pages))
		&& rt.is_true(rt.greater(this.order_query_args.array_get(rt.new_string('page')), rt.new_int(1))) {
		mut var_count_query_args := var_order_query_args.clone()
		var_count_query_args.array_set('page', 1)
		var_count_query_args.array_set('limit', 1)
		mut var_order_count := rt.call_function('wc_get_orders', [
			var_count_query_args.clone()])
		var_max_num_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(rt.get_property(var_order_count, 'total'),
				var_order_query_args.array_get(rt.new_string('limit'))),
		])).to_i64())
	}
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{
			key: 'total_items'
			val: if !(rt.get_property(var_orders, 'total')).is_null() {
				rt.get_property(var_orders, 'total')
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{ key: 'per_page', val: var_limit },
		rt.ArrayItem{ key: 'total_pages', val: var_max_num_pages },
	]))
	this.is_trash = rt.identical(rt.new_string('trash'),
		this.request.array_get(rt.new_string('status')))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_max_num_pages(var_orders rt.PhpVal) rt.PhpVal {
	mut var_orders_mutated := var_orders
	if !(this.order_query_args.array_isset(rt.new_string('no_found_rows')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(this.order_query_args.array_get(rt.new_string('no_found_rows')))))) {
		return rt.get_property(var_orders_mutated, 'max_num_pages')
	}
	mut var_count :=
		rt.new_int(this.count_orders_by_status(this.order_query_args.array_get(rt.new_string('status'))))
	mut var_limit := this.get_items_per_page(rt.new_string('edit_' +
		(this.order_type).str() + '_per_page'))
	rt.set_property(var_orders_mutated, 'total', var_count.clone())
	return rt.call_function('ceil', [rt.div(var_count, var_limit)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_order_args() {
	mut var_sortable := this.get_sortable_columns()
	mut var_field := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))).is_null() {
			rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))
		} else {
			rt.new_string('')
		}]),
	])
	mut var_direction := rt.new_string(rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('order'))).is_null() {
			rt.get_superglobal('_GET').array_get(rt.new_string('order'))
		} else {
			rt.new_string('')
		}]),
	]).to_string().to_upper())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_field.clone(), var_sortable.clone(), rt.new_bool(true)])))))
	{
		this.order_query_args.array_set('orderby', 'date')
		this.order_query_args.array_set('order', 'DESC')
		return
	}
	this.order_query_args.array_set('orderby', var_field.clone())
	this.order_query_args.array_set('order', if rt.is_true(rt.call_function('in_array', [
		var_direction.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'ASC' },
			rt.ArrayItem{ key: none, val: 'DESC' }]),
		rt.new_bool(true),
	]))
	{ var_direction } else { rt.new_string('ASC') })
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_date_args() {
	mut var_year_month := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('m'))).is_null() {
			rt.get_superglobal('_GET').array_get(rt.new_string('m'))
		} else {
			rt.new_string('')
		}]),
	])
	if !rt.is_true(var_year_month)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]{6}$/'), var_year_month.clone()]))))) {
		return
	}
	mut var_year := rt.new_int((rt.call_function('substr', [var_year_month.clone(),
		rt.new_int(0), rt.new_int(4)])).to_i64())
	mut var_month := rt.new_int((rt.call_function('substr', [
		var_year_month.clone(), rt.new_int(4), rt.new_int(2)])).to_i64())
	if rt.is_true(rt.less(var_month, rt.new_int(0)))
		|| rt.is_true(rt.greater(var_month, rt.new_int(12))) {
		return
	}
	mut var_last_day_of_month := rt.call_method(rt.call_function('date_create', [
		rt.new_string('${var_year.to_string()}-${var_month.to_string()}'),
	]), 'format', [rt.new_string('Y-m-t')])
	this.order_query_args.array_set('date_created',

		'${var_year.to_string()}-${var_month.to_string()}-01...' + var_last_day_of_month.str())
	this.has_filter = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_customer_args() {
	mut var_customer := rt.new_int((rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('_customer_user'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('_customer_user'))
	} else {
		rt.new_string('')
	}])).to_i64())
	if rt.is_true(rt.less(var_customer, rt.new_int(1))) {
		return
	}
	this.order_query_args.array_set('customer', var_customer.clone())
	this.has_filter = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_status_args() {
	mut var_status := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('trim'),
			rt.cast_array(this.request.array_get(rt.new_string('status')))]),
	])
	if !rt.is_true(var_status)
		|| rt.is_true(rt.call_function('in_array', [rt.new_string('all'), var_status.clone(), rt.new_bool(true)])) {
		var_status = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_default_statuses'),
			rt.call_function('array_intersect', [
				rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})),
				rt.call_function('get_post_stati', [
					rt.create_array([
						rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
					]),
					rt.new_string('names'),
				]),
			]),
		])
	} else {
		this.has_filter = true
	}
	this.order_query_args.array_set('status', var_status.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_search_args() {
	mut var_search_term := rt.new_string(rt.call_function('sanitize_text_field', [
		this.request.array_get(rt.new_string('s')),
	]).to_string().trim_space())
	if !(!rt.is_true(var_search_term)) {
		this.order_query_args.array_set('s', var_search_term.clone())
		this.has_filter = true
	}
	mut var_filter := rt.new_string(rt.call_function('sanitize_text_field', [
		this.request.array_get(rt.new_string('search-filter')),
	]).to_string().trim_space())
	if !(!rt.is_true(var_filter)) {
		this.order_query_args.array_set('search_filter', var_filter.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_created_via_args() {
	mut var_created_via := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('_created_via'))).is_null() {
			rt.get_superglobal('_GET').array_get(rt.new_string('_created_via'))
		} else {
			rt.new_string('')
		}]),
	])
	if !rt.is_true(var_created_via) {
		return
	}
	this.order_query_args.array_set('created_via', rt.call_function('array_map', [
		rt.new_string('trim'),
		rt.call_function('explode', [rt.new_string(','), var_created_via.clone()]),
	]))
	this.has_filter = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) created_via_filter() {
	mut var_current_created_via := if rt.get_superglobal('_GET').array_isset(rt.new_string('_created_via')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_created_via'))]),
		]) } else { rt.new_string('') }
	mut var_created_via_options := rt.create_array([
		rt.ArrayItem{ key: '', val: rt.call_function('__', [
			rt.new_string('All sales channels'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'admin', val: rt.call_function('__', [
			rt.new_string('Admin'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'checkout,store-api', val: rt.call_function('__', [
			rt.new_string('Checkout'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'pos-rest-api', val: rt.call_function('__', [
			rt.new_string('Point of Sale'),
			rt.new_string('woocommerce'),
		]) },
	])
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := var_created_via_options.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_label := item_2.val
		mut var_value := item_2.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_value.clone(), var_current_created_via.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_views() rt.PhpVal {
	mut var_view_links := rt.new_array()
	var_view_links = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_before_' + (this.order_type).str() + '_list_table_view_links'),
		var_view_links.clone(),
	])
	if !(!rt.is_true(var_view_links)) {
		return var_view_links.clone()
	}
	mut var_view_counts := rt.new_array()
	mut var_statuses := this.get_visible_statuses()
	mut var_current := if !(!rt.is_true(this.request.array_get(rt.new_string('status')))) { rt.call_function('sanitize_text_field', [
			this.request.array_get(rt.new_string('status')),
		]) } else { rt.new_string('all') }
	mut var_all_count := rt.new_int(0)
	mut iter_3 := rt.func_array_keys(var_statuses.clone()).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_slug := item_3.val
		mut var_total_in_status := rt.new_int(this.count_orders_by_status(var_slug.clone()))
		if rt.is_true(rt.greater(var_total_in_status, rt.new_int(0))) {
			var_view_counts.array_set(var_slug, var_total_in_status.clone())
		}
		if rt.is_true(rt.get_property(rt.call_function('get_post_status_object', [var_slug.clone()]), 'show_in_admin_all_list'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), var_slug)))) {
			var_all_count = rt.add(var_all_count, var_total_in_status)
		}
	}
	var_view_links.array_set('all', this.get_view_link('all', (rt.call_function('__', [
		rt.new_string('All'),
		rt.new_string('woocommerce'),
	])).str(), var_all_count.to_i64(), rt.is_true(rt.identical(rt.new_string(''), var_current))
		|| rt.is_true(rt.identical(rt.new_string('all'), var_current))))
	mut iter_4 := var_view_counts.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_count := item_4.val
		mut var_slug := item_4.key
		var_view_links.array_set(var_slug, this.get_view_link(var_slug.str(),
			(var_statuses.array_get(var_slug)).str(), var_count.to_i64(), (rt.identical(var_slug,
			var_current)).to_bool()))
	}
	return var_view_links.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) count_orders_by_status(var_status rt.PhpVal) i64 {
	mut var_status_mutated := var_status
	var_status_mutated = rt.cast_array(var_status_mutated)
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.get_count_for_type(this.order_type)
	mut var_counts := iife_result_0
	mut var_count := rt.call_function('array_sum', [
		rt.call_function('array_intersect_key', [var_counts.clone(),
			rt.call_function('array_flip', [var_status_mutated.clone()])]),
	])
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_order_count'),
		var_count.clone(),
		var_status_mutated.clone(),
	])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) should_render_blank_state() bool {
	mut var_should_render_blank_state := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' +
			(this.order_type).str() + '_list_table_should_render_blank_state'),
		rt.new_null(),
		rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', [
			'WP_List_Table',
		], &this),
	])
	if rt.is_true(rt.new_bool(var_should_render_blank_state.clone().is_bool())) {
		return var_should_render_blank_state.to_bool()
	}
	return !(this.has_filter)
		&& 0 == this.count_orders_by_status(rt.func_array_keys(this.get_visible_statuses()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_visible_statuses() rt.PhpVal {
	return rt.call_function('array_intersect_key', [
		rt.call_function('array_merge', [
			rt.call_function('wc_get_order_statuses', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'trash', val: rt.get_property(rt.call_function('get_post_status_object', [
					rt.new_string('trash'),
				]), 'label') },
				rt.ArrayItem{ key: 'draft', val: rt.get_property(rt.call_function('get_post_status_object', [
					rt.new_string('draft'),
				]), 'label') },
				rt.ArrayItem{ key: 'auto-draft', val: rt.get_property(rt.call_function('get_post_status_object', [
					rt.new_string('auto-draft'),
				]), 'label') },
			]),
		]),
		rt.call_function('array_flip', [
			rt.call_function('get_post_stati', [
				rt.create_array([
					rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				]),
			]),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_view_link(slug string, name string, count i64, current bool) string {
	mut name_mutated := name
	mut count_mutated := count
	mut current_mutated := current
	mut var_base_url := rt.call_function('get_admin_url', [rt.new_null(),
		rt.new_string('admin.php?page=wc-orders' +
			if rt.is_true(rt.identical(rt.new_string('shop_order'), this.order_type)) { '' } else { '--' +
			(this.order_type).str() })])
	mut var_url := rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [rt.new_string('status'),
			rt.new_string(slug), var_base_url.clone()]),
	])
	name_mutated = (rt.call_function('esc_html', [rt.new_string(name_mutated).clone()])).str()
	count_mutated = (rt.call_function('number_format_i18n', [
		rt.new_int(count_mutated).clone()])).to_i64()
	mut var_class := rt.new_string((if rt.is_true(rt.new_bool(current_mutated)) {
		'class="current"'
	} else {
		''
	}).str())
	return "<a href='${var_url.to_string()}' ${var_class.to_string()}>${var_name.to_string()} <span class='count'>(${var_count.to_string()})</span></a>"
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) extra_tablenav(var_which rt.PhpVal) {
	print('<div class="alignleft actions">')
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		this.months_filter()
		rt.call_function('do_action', [
			rt.new_string('woocommerce_order_list_table_restrict_manage_orders'),
			this.order_type,
			var_which.clone(),
		])
		mut var_output := rt.call_function('ob_get_clean', []rt.PhpVal{})
		if !(!rt.is_true(var_output)) {
			rt.echo_val(var_output)
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Filter'),
					rt.new_string('woocommerce')]),
				rt.new_string(''),
				rt.new_string('filter_action'),
				rt.new_bool(false),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'order-query-submit' }]),
			])
		}
	}
	if this.is_trash && rt.is_true(this.has_items())
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_shop_orders')])) {
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Empty Trash'),
				rt.new_string('woocommerce')]),
			rt.new_string('apply'),
			rt.new_string('delete_all'),
			rt.new_bool(false),
		])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_list_table_extra_tablenav'),
		this.order_type,
		var_which.clone(),
	])
	print('</div>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) months_filter() {
	mut var_wp_locale := rt.new_null()
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_disable_months_filter'),
		rt.new_bool(false),
	]))
	{
		return
	}
	mut var_m := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('m')) {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('m'))).to_i64())
	} else {
		0
	})
	print('<select name="m" id="filter-by-date">')
	print('<option ' +
		(rt.call_function('selected', [var_m.clone(), rt.new_int(0), rt.new_bool(false)])).str() +
		' value="0">' +
		(rt.call_function('esc_html__', [rt.new_string('All dates'), rt.new_string('woocommerce')])).str() +
		'</option>')
	mut var_order_dates := this.get_months_filter_options()
	mut iter_5 := var_order_dates.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_date := item_5.val
		mut var_month := rt.call_function('zeroise', [rt.get_property(var_date, 'month'),
			rt.new_int(2)])
		mut var_month_year_text := rt.call_function('sprintf', [
			rt.call_function('esc_html_x', [rt.new_string('%1$s %2$d'),
				rt.new_string('order dates dropdown'), rt.new_string('woocommerce')]),
			rt.call_method(var_wp_locale, 'get_month', [var_month.clone()]),
			rt.get_property(var_date, 'year'),
		])
		rt.call_function('printf', [
			rt.new_string('<option %1$s value="%2$s">%3$s</option>\\n'),
			rt.call_function('selected', [var_m.clone(),
				rt.new_string((rt.get_property(var_date, 'year')).str() + var_month.str()),
				rt.new_bool(false)]),
			rt.call_function('esc_attr', [
				rt.new_string((rt.get_property(var_date, 'year')).str() + var_month.str()),
			]),
			rt.call_function('esc_html', [
				var_month_year_text.clone(),
			]),
		])
	}
	print('</select>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_months_filter_options() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_1 := iife_temp_1.get_orders_table_name()
	mut var_table_name := iife_result_1
	mut var_min_max_months := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT MIN(date_created_gmt) as min_date_gmt, MAX(date_created_gmt) as max_date_gmt\n\t\t\t\t FROM (\n\t\t\t\t\t( SELECT date_created_gmt FROM %i WHERE type = %s AND status != 'trash' ORDER BY date_created_gmt DESC LIMIT 1 )\n\t\t\t\t\tUNION ALL\n\t\t\t\t\t( SELECT date_created_gmt FROM %i WHERE type = %s AND status != 'trash' ORDER BY date_created_gmt ASC LIMIT 1 )\n\t\t\t\t ) d"),
			var_table_name.clone(),
			this.order_type,
			var_table_name.clone(),
			this.order_type,
		]),
	])
	mut var_this_month := create_automattic_woocommerce_internal_admin_orders_wc_datetime(rt.new_string('now'),
		create_automattic_woocommerce_internal_admin_orders_datetimezone(rt.new_string('UTC')))
	var_this_month.settimezone(rt.call_function('wp_timezone', []rt.PhpVal{}))
	var_this_month.setdate(var_this_month.format(rt.new_string('Y')),
		var_this_month.format(rt.new_string('m')), rt.new_int(1))
	var_this_month.settime(rt.new_int(0), rt.new_int(0))
	mut var_options := rt.new_array()
	if !var_min_max_months.is_null()
		&& !(rt.get_property(var_min_max_months, 'min_date_gmt').is_null()) {
		mut var_start := create_automattic_woocommerce_internal_admin_orders_wc_datetime(rt.get_property(var_min_max_months,
			'min_date_gmt'),
			create_automattic_woocommerce_internal_admin_orders_datetimezone(rt.new_string('UTC')))
		rt.call_method(var_start, 'setTimezone', [
			rt.call_function('wp_timezone', []rt.PhpVal{}),
		])
		rt.call_method(var_start, 'setDate', [
			rt.call_method(var_start, 'format', [rt.new_string('Y')]),
			rt.call_method(var_start, 'format', [rt.new_string('m')]),
			rt.new_int(1),
		])
		rt.call_method(var_start, 'setTime', [rt.new_int(0), rt.new_int(0)])
		mut var_end := create_automattic_woocommerce_internal_admin_orders_wc_datetime(rt.get_property(var_min_max_months,
			'max_date_gmt'),
			create_automattic_woocommerce_internal_admin_orders_datetimezone(rt.new_string('UTC')))
		rt.call_method(var_end, 'setTimezone', [
			rt.call_function('wp_timezone', []rt.PhpVal{}),
		])
		rt.call_method(var_end, 'setDate', [
			rt.call_method(var_end, 'format', [rt.new_string('Y')]),
			rt.call_method(var_end, 'format', [rt.new_string('m')]),
			rt.new_int(1),
		])
		rt.call_method(var_end, 'setTime', [rt.new_int(0), rt.new_int(0)])
		if rt.is_true(rt.greater(var_start, var_this_month)) {
			var_start = var_this_month
		}
		if rt.is_true(rt.less(var_end, var_this_month)) {
			var_end = var_this_month
		}
		mut var_intervals := create_automattic_woocommerce_internal_admin_orders_dateperiod(var_start.clone(),
			create_automattic_woocommerce_internal_admin_orders_dateinterval(rt.new_string('P1M')),
			var_end.clone())
		mut iter_6 := var_intervals.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_interval := item_6.val
			mut var_option := create_automattic_woocommerce_internal_admin_orders_stdclass()
			rt.set_property(var_option, 'year', rt.call_method(var_interval, 'format', [
				rt.new_string('Y'),
			]))
			rt.set_property(var_option, 'month', rt.call_method(var_interval, 'format', [
				rt.new_string('n'),
			]))
			var_options.array_push(var_option)
		}
		mut var_option := create_automattic_woocommerce_internal_admin_orders_stdclass()
		rt.set_property(var_option, 'year', rt.call_method(var_end, 'format', [
			rt.new_string('Y'),
		]))
		rt.set_property(var_option, 'month', rt.call_method(var_end, 'format', [
			rt.new_string('n'),
		]))
		var_options.array_push(var_option)
	}
	if var_options.clone().array_count() < 1 {
		var_option = create_automattic_woocommerce_internal_admin_orders_stdclass()
		rt.set_property(var_option, 'year', var_this_month.format(rt.new_string('Y')))
		rt.set_property(var_option, 'month', var_this_month.format(rt.new_string('n')))
		var_options.array_push(var_option)
	}
	return rt.call_function('array_reverse', [var_options.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_and_maybe_update_months_filter_cache() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('9.9.0'), rt.new_string('get_months_filter_options')])
	return this.get_months_filter_options()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) customers_filter() {
	mut var_user_string := rt.new_string('')
	mut var_user_id := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_customer_user')))) {
		var_user_id = rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('_customer_user')),
		])
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'),
			var_user_id.clone()])
		var_user_string = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [rt.new_string('%1$s (#%2$s &ndash; %3$s)'),
				rt.new_string('woocommerce')]),
			rt.get_property(var_user, 'display_name'),
			rt.call_function('absint', [rt.get_property(var_user, 'ID')]),
			rt.get_property(var_user, 'user_email'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Filter by registered customer'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('htmlspecialchars', [
		rt.call_function('wp_kses_post', [var_user_string.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_columns() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_columns'),
		rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' },
			rt.ArrayItem{ key: 'order_number', val: rt.call_function('esc_html__', [
				rt.new_string('Order'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'order_date', val: rt.call_function('esc_html__', [
				rt.new_string('Date'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'order_status', val: rt.call_function('esc_html__', [
				rt.new_string('Status'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'billing_address', val: rt.call_function('esc_html__', [
				rt.new_string('Billing'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'shipping_address', val: rt.call_function('esc_html__', [
				rt.new_string('Ship to'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'order_total', val: rt.call_function('esc_html__', [
				rt.new_string('Total'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'wc_actions', val: rt.call_function('esc_html__', [
				rt.new_string('Actions'),
				rt.new_string('woocommerce'),
			]) }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_sortable_columns() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + (this.order_type).str() + '_list_table_sortable_columns'),
		rt.create_array([rt.ArrayItem{ key: 'order_number', val: 'ID' },
			rt.ArrayItem{ key: 'order_date', val: 'date' }, rt.ArrayItem{
				key: 'order_total'
				val: 'order_total'
			}]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) default_hidden_columns(mut var_hidden Class_Automattic_WooCommerce_Internal_Admin_Orders_array, mut var_screen Class_WP_Screen) rt.PhpVal {
	mut var_hidden_mutated := var_hidden
	mut var_screen_mutated := var_screen
	if !(rt.get_property(var_screen_mutated, 'id')).is_null()
		&& rt.is_true(rt.identical(rt.call_function('wc_get_page_screen_id', [rt.new_string('shop-order')]), rt.get_property(var_screen_mutated, 'id'))) {
		var_hidden_mutated = rt.call_function('array_merge', [var_hidden_mutated,
			rt.create_array([rt.ArrayItem{ key: none, val: 'billing_address' },
				rt.ArrayItem{ key: none, val: 'shipping_address' },
				rt.ArrayItem{ key: none, val: 'wc_actions' }])])
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_array', []string{},
		var_hidden_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) column_cb(var_item rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.wp_post_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(this.wp_post_type, 'cap'), 'edit_post'), rt.call_method(var_item, 'get_id', []rt.PhpVal{})]))))) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Order %s is locked.'),
				rt.new_string('woocommerce')]),
			rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_number_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_buyer := rt.new_string('')
	if rt.is_true(rt.call_method(var_order_mutated, 'get_billing_first_name', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(var_order_mutated, 'get_billing_last_name', []rt.PhpVal{})) {
		var_buyer = rt.new_string(rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('%1$s %2$s'),
				rt.new_string('full name'), rt.new_string('woocommerce')]),
			rt.call_method(var_order_mutated, 'get_billing_first_name', []rt.PhpVal{}),
			rt.call_method(var_order_mutated, 'get_billing_last_name', []rt.PhpVal{}),
		]).to_string().trim_space())
	} else if rt.is_true(rt.call_method(var_order_mutated, 'get_billing_company', []rt.PhpVal{})) {
		var_buyer = rt.new_string(rt.call_method(var_order_mutated, 'get_billing_company',
			[]rt.PhpVal{}).to_string().trim_space())
	} else if rt.is_true(rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})) {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'),
			rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})])
		var_buyer = rt.call_function('ucwords', [
			rt.get_property(var_user, 'display_name'),
		])
	}
	var_buyer = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_buyer_name'),
		var_buyer.clone(),
		var_order_mutated,
	])
	if rt.is_true(rt.identical(rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}),
		rt.new_string('trash')))
	{
		print('<strong>#' +
			(rt.call_function('esc_attr', [rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{})])).str() +
			' ' + (rt.call_function('esc_html', [var_buyer.clone()])).str() + '</strong>')
	} else {
		print('<a href="#" class="order-preview" data-order-id="' +
			(rt.call_function('absint', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])).str() +
			'" title="' +
			(rt.call_function('esc_attr', [rt.call_function('__', [rt.new_string('Preview'), rt.new_string('woocommerce')])])).str() +
			'">' +
			(rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Preview'), rt.new_string('woocommerce')])])).str() +
			'</a>')
		print('<a href="' +
			(rt.call_function('esc_url', [rt.new_string(this.get_order_edit_link(mut var_order_mutated))])).str() +
			'" class="order-view"><strong>#' +
			(rt.call_function('esc_attr', [rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{})])).str() +
			' ' + (rt.call_function('esc_html', [var_buyer.clone()])).str() + '</strong></a>')
	}
	print('<div class="order_date small-screen-only">')
	this.render_order_date_column(mut var_order_mutated)
	print('</div>')
	print('<div class="order_status small-screen-only">')
	this.render_order_status_column(mut var_order_mutated)
	print('</div>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_order_edit_link(mut var_order Class_WC_Order) string {
	mut var_order_mutated := var_order
	return (rt.call_method(this.page_controller, 'get_edit_url', [
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_date_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_order_timestamp := if rt.is_true(rt.call_method(var_order_mutated, 'get_date_created',
		[]rt.PhpVal{}))
	{
		rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}),
			'getTimestamp', []rt.PhpVal{})
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_timestamp)))) {
		print('&ndash;')
		return
	}
	if rt.is_true(rt.greater(var_order_timestamp, rt.call_function('strtotime', [rt.new_string('-1 day'), rt.call_function('time', []rt.PhpVal{})])))
		&& rt.is_true(rt.less_equal(var_order_timestamp, rt.call_function('time', []rt.PhpVal{}))) {
		mut var_show_date := rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('%s ago'),
				rt.new_string('%s = human-readable time difference'),
				rt.new_string('woocommerce')]),
			rt.call_function('human_time_diff', [
				rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}),
					'getTimestamp', []rt.PhpVal{}),
				rt.call_function('time', []rt.PhpVal{}),
			]),
		])
	} else {
		var_show_date = rt.call_method(rt.call_method(var_order_mutated, 'get_date_created',
			[]rt.PhpVal{}), 'date_i18n', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_admin_order_date_format'),
				rt.call_function('__', [rt.new_string('M j, Y'),
					rt.new_string('woocommerce')]),
			]),
		])
	}
	rt.call_function('printf', [
		rt.new_string('<time datetime="%1$s" title="%2$s">%3$s</time>'),
		rt.call_function('esc_attr', [
			rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}),
				'date', [rt.new_string('c')]),
		]),
		rt.call_function('esc_html', [
			rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}),
				'date_i18n', [
				rt.new_string(
					(rt.call_function('get_option', [rt.new_string('date_format')])).str() + ' ' +
					(rt.call_function('get_option', [rt.new_string('time_format')])).str()),
			]),
		]),
		rt.call_function('esc_html', [
			var_show_date.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_status_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_tooltip := rt.call_function('wc_sanitize_tooltip', [
		rt.new_string(this.get_order_status_label(mut var_order_mutated)),
	])
	if rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}),
		rt.create_array([rt.ArrayItem{ key: none, val: 'trash' },
			rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'auto-draft' }]),
		rt.new_bool(true),
	]))
	{
		mut var_status_name := rt.get_property(rt.call_function('get_post_status_object', [
			rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}),
		]), 'label')
	} else {
		var_status_name = rt.call_function('wc_get_order_status_name', [
			rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}),
		])
	}
	if rt.is_true(var_tooltip) {
		rt.call_function('printf', [
			rt.new_string('<mark class="order-status %s tips" data-tip="%s"><span>%s</span></mark>'),
			rt.call_function('esc_attr', [
				rt.call_function('sanitize_html_class', [
					rt.new_string('status-' +
						(rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})).str()),
				]),
			]),
			rt.call_function('wp_kses_post', [
				var_tooltip.clone(),
			]),
			rt.call_function('esc_html', [
				var_status_name.clone(),
			]),
		])
	} else {
		rt.call_function('printf', [
			rt.new_string('<mark class="order-status %s"><span>%s</span></mark>'),
			rt.call_function('esc_attr', [
				rt.call_function('sanitize_html_class', [
					rt.new_string('status-' +
						(rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})).str()),
				]),
			]),
			rt.call_function('esc_html', [
				var_status_name.clone(),
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_order_status_label(mut var_order Class_WC_Order) string {
	mut var_order_mutated := var_order
	mut var_status_names := rt.create_array([
		rt.ArrayItem{ key: 'pending', val: rt.call_function('__', [
			rt.new_string('The order has been received, but no payment has been made. Pending payment orders are generally awaiting customer action.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'on-hold', val: rt.call_function('__', [
			rt.new_string('The order is awaiting payment confirmation. Stock is reduced, but you need to confirm payment.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'processing', val: rt.call_function('__', [
			rt.new_string('Payment has been received (paid), and the stock has been reduced. The order is awaiting fulfillment.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'completed', val: rt.call_function('__', [
			rt.new_string('Order fulfilled and complete.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'failed', val: rt.call_function('__', [
			rt.new_string('The customer’s payment failed or was declined, and no payment has been successfully made.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'checkout-draft', val: rt.call_function('__', [
			rt.new_string('Draft orders are created when customers start the checkout process while the block version of the checkout is in place.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'cancelled', val: rt.call_function('__', [
			rt.new_string('The order was canceled by an admin or the customer.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'refunded', val: rt.call_function('__', [
			rt.new_string('Orders are automatically put in the Refunded status when an admin or shop manager has fully refunded the order’s value after payment.'),
			rt.new_string('woocommerce'),
		]) },
	])
	var_status_names = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_order_status_labels'),
		var_status_names.clone(),
		var_order_mutated,
	])
	mut var_status_name := rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})
	return (if var_status_names.array_isset(var_status_name) {
		var_status_names.array_get(var_status_name)
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_billing_address_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_address := rt.call_method(var_order_mutated, 'get_formatted_billing_address',
		[]rt.PhpVal{})
	if rt.is_true(var_address) {
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('preg_replace', [rt.new_string('#<br\\s*/?>#i'),
				rt.new_string(', '), var_address.clone()]),
		]))
		if rt.is_true(rt.call_method(var_order_mutated, 'get_payment_method', []rt.PhpVal{})) {
			print('<span class="description">' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('via %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_order_mutated, 'get_payment_method_title', []rt.PhpVal{})])])).str() +
				'</span>')
		}
	} else {
		print('&ndash;')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_shipping_address_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_address := rt.call_method(var_order_mutated, 'get_formatted_shipping_address',
		[]rt.PhpVal{})
	if rt.is_true(var_address) {
		print('<a target="_blank" href="' +
			(rt.call_function('esc_url', [rt.call_method(var_order_mutated, 'get_shipping_address_map_url', []rt.PhpVal{})])).str() +
			'">' +
			(rt.call_function('esc_html', [rt.call_function('preg_replace', [rt.new_string('#<br\\s*/?>#i'), rt.new_string(', '), var_address.clone()])])).str() +
			'</a>')
		if rt.is_true(rt.call_method(var_order_mutated, 'get_shipping_method', []rt.PhpVal{})) {
			print('<span class="description">' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('via %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_order_mutated, 'get_shipping_method', []rt.PhpVal{})])])).str() +
				'</span>')
		}
	} else {
		print('&ndash;')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_total_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.call_method(var_order_mutated, 'get_payment_method_title', []rt.PhpVal{})) {
		print('<span class="tips" data-tip="' +
			(rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('via %s'), rt.new_string('woocommerce')]), rt.call_method(var_order_mutated, 'get_payment_method_title', []rt.PhpVal{})])])).str() +
			'">' +
			(rt.call_function('wp_kses_post', [rt.call_method(var_order_mutated, 'get_formatted_order_total', []rt.PhpVal{})])).str() +
			'</span>')
	} else {
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_method(var_order_mutated, 'get_formatted_order_total', []rt.PhpVal{}),
		]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_wc_actions_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	print('<p>')
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_actions_start'),
		var_order_mutated,
	])
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'on-hold' }]),
	]))
	{
		var_actions.array_set('processing', rt.create_array([
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
			rt.ArrayItem{ key: 'action', val: 'processing' },
		]))
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'on-hold' }, rt.ArrayItem{ key: none, val: 'processing' }]),
	]))
	{
		var_actions.array_set('complete', rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('wp_nonce_url', [
				rt.call_function('admin_url', [
					rt.new_string(
						'admin-ajax.php?action=woocommerce_mark_order_status&status=completed&order_id=' +
						(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str()),
				]),
				rt.new_string('woocommerce-mark-order-status'),
			]) },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Complete'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'complete' },
		]))
	}
	var_actions = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_actions'),
		var_actions.clone(),
		var_order_mutated,
	])
	rt.echo_val(rt.call_function('wc_render_action_buttons', [
		var_actions.clone()]))
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_actions_end'),
		var_order_mutated])
	print('</p>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) print_hidden_form_fields() {
	print('<input type="hidden" name="page" value="wc-orders' +
		if rt.is_true(rt.identical(rt.new_string('shop_order'), this.order_type)) { '' } else { '--' +
		(this.order_type).str() } + '" >')
	mut var_state_params := rt.create_array([rt.ArrayItem{ key: none, val: 'paged' },
		rt.ArrayItem{ key: none, val: 'status' }])
	mut iter_7 := var_state_params.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_param := item_7.val
		if !(rt.get_superglobal('_GET').array_isset(var_param)) {
			continue
		}
		print('<input type="hidden" name="' +
			(rt.call_function('esc_attr', [var_param.clone()])).str() + '" value="' +
			(rt.call_function('esc_attr', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(var_param)])])])).str() +
			'" >')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) current_action() string {
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('delete_all')))) {
		return 'delete_all'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) handle_bulk_actions() {
	mut var_action := rt.new_string(this.current_action())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(this.wp_post_type, 'cap'), 'edit_others_posts')]))))) {
		return
	}
	rt.call_function('check_admin_referer', [rt.new_string('bulk-orders')])
	mut var_redirect_to := rt.call_function('remove_query_arg', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'deleted' },
			rt.ArrayItem{ key: none, val: 'ids' }]),
		rt.call_function('wp_get_referer', []rt.PhpVal{}),
	])
	var_redirect_to = rt.call_function('add_query_arg', [rt.new_string('paged'),
		this.get_pagenum(), var_redirect_to.clone()])
	if rt.is_true(rt.identical(rt.new_string('delete_all'), var_action)) {
		mut var_ids := rt.call_function('wc_get_orders', [
			rt.create_array([rt.ArrayItem{ key: 'type', val: this.order_type },
				rt.ArrayItem{ key: 'status', val: 'trash' }, rt.ArrayItem{ key: 'limit', val: -1 },
				rt.ArrayItem{ key: 'return', val: 'ids' }]),
		])
		var_action = rt.new_string('delete')
	} else {
		var_ids = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) { rt.call_function('array_reverse', [
				rt.call_function('array_map', [rt.new_string('absint'),
					rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('id')))]),
			]) } else { rt.new_array() }
	}
	var_ids = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_bulk_action_ids'),
		var_ids.clone(),
		var_action.clone(),
		rt.new_string('order'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ids)))) {
		rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
		exit(0)
	}
	mut var_report_action := rt.new_string('')
	mut var_changed := rt.new_int(0)
	mut var_action_handled := rt.new_bool(true)
	if rt.is_true(rt.identical(rt.new_string('remove_personal_data'), var_action)) {
		var_report_action = rt.new_string('removed_personal_data')
		var_changed = rt.new_int(this.do_bulk_action_remove_personal_data(var_ids.clone()))
	} else if rt.is_true(rt.identical(rt.new_string('trash'), var_action)) {
		var_changed = rt.new_int(this.do_delete(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](var_ids),
			false))
		var_report_action = rt.new_string('trashed')
	} else if rt.is_true(rt.identical(rt.new_string('delete'), var_action)) {
		var_changed =
			rt.new_int(this.do_delete(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](var_ids), true))
		var_report_action = rt.new_string('deleted')
	} else if rt.is_true(rt.identical(rt.new_string('untrash'), var_action)) {
		var_changed =
			rt.new_int(this.do_untrash(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](var_ids)))
		var_report_action = rt.new_string('untrashed')
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
			var_changed = rt.new_int(this.do_bulk_action_mark_orders(var_ids.clone(),
				var_new_status.clone()))
		} else {
			var_action_handled = rt.new_bool(false)
		}
	} else {
		var_action_handled = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action_handled)))) {
		mut var_screen :=
			rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
		mut var_custom_sendback := rt.call_function('apply_filters', [
			rt.new_string('handle_bulk_actions-${var_screen.to_string()}'),
			var_redirect_to.clone(),
			var_action.clone(),
			var_ids.clone(),
		])
	}
	if !(!rt.is_true(var_custom_sendback)) {
		var_redirect_to = var_custom_sendback.clone()
	} else if rt.is_true(var_changed) {
		var_redirect_to = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'bulk_action', val: var_report_action },
				rt.ArrayItem{ key: 'changed', val: var_changed },
				rt.ArrayItem{ key: 'ids', val: rt.call_function('implode', [
					rt.new_string(','),
					var_ids.clone(),
				]) }]),
			var_redirect_to.clone(),
		])
	}
	rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_bulk_action_remove_personal_data(var_order_ids rt.PhpVal) i64 {
	mut var_changed := rt.new_int(0)
	mut iter_8 := var_order_ids.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_id := item_8.val
		mut var_order := rt.call_function('wc_get_order', [var_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			continue
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_remove_order_personal_data'),
			var_order.clone(),
		])
		rt.pre_inc(var_changed)
	}
	return var_changed.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_bulk_action_mark_orders(var_order_ids rt.PhpVal, var_new_status rt.PhpVal) i64 {
	mut var_new_status_mutated := var_new_status
	mut var_changed := rt.new_int(0)
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	mut iter_9 := var_order_ids.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_id := item_9.val
		mut var_order := rt.call_function('wc_get_order', [var_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			continue
		}
		rt.call_method(var_order, 'update_status', [var_new_status_mutated.clone(),
			rt.call_function('__', [rt.new_string('Order status changed by bulk edit.'),
				rt.new_string('woocommerce')]),
			rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_order_edit_status'),
			var_id.clone(), var_new_status_mutated.clone()])
		rt.pre_inc(var_changed)
	}
	return var_changed.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_delete(mut var_ids Class_Automattic_WooCommerce_Internal_Admin_Orders_array, force_delete bool) i64 {
	mut var_ids_mutated := var_ids
	mut var_changed := rt.new_int(0)
	mut iter_10 := var_ids_mutated.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_id := item_10.val
		mut var_order := rt.call_function('wc_get_order', [var_id.clone()])
		rt.call_method(var_order, 'delete', [rt.new_bool(force_delete)])
		mut var_updated_order := rt.call_function('wc_get_order', [
			var_id.clone()])
		if (var_force_delete && rt.is_true(rt.identical(rt.new_bool(false), var_updated_order)))
			|| (!var_force_delete
			&& rt.is_true(rt.identical(rt.call_method(var_updated_order, 'get_status', []rt.PhpVal{}), rt.new_string('trash')))) {
			rt.pre_inc(var_changed)
		}
	}
	return var_changed.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_untrash(mut var_ids Class_Automattic_WooCommerce_Internal_Admin_Orders_array) i64 {
	mut var_ids_mutated := var_ids
	mut var_orders_store := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class(),
	])
	mut var_changed := rt.new_int(0)
	mut iter_11 := var_ids_mutated.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_id := item_11.val
		if rt.is_true(rt.call_method(var_orders_store, 'untrash_order', [
			rt.call_function('wc_get_order', [var_id.clone()]),
		]))
		{
			rt.pre_inc(var_changed)
		}
	}
	return var_changed.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) bulk_action_notices() {
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('bulk_action'))) {
		return
	}
	mut var_order_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut var_number := rt.call_function('absint', [if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('changed'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('changed'))
	} else {
		rt.new_int(0)
	}])
	mut var_bulk_action := rt.call_function('wc_clean', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('bulk_action'))]),
	])
	mut var_message := rt.new_string('')
	mut iter_12 := var_order_statuses.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_name := item_12.val
		mut var_slug := item_12.key
		if rt.is_true(rt.identical('marked_' +(rt.call_function('str_replace', [rt.new_string('wc-'), rt.new_string(''), var_slug.clone()])).str(),
			var_bulk_action))
		{
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s order status changed.'),
					rt.new_string('%s order statuses changed.'),
					var_number.clone(), rt.new_string('woocommerce')]),
				rt.call_function('number_format_i18n', [var_number.clone()]),
			])
			break
		}
	}
	mut switch_val_1 := var_bulk_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('removed_personal_data'))) {
		var_message = rt.call_function('sprintf', [
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
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trashed'))) {
		var_message = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s order moved to the Trash.'),
				rt.new_string('%s orders moved to the Trash.'),
				var_number.clone(), rt.new_string('woocommerce')]),
			rt.call_function('number_format_i18n', [var_number.clone()]),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('untrashed'))) {
		var_message = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s order restored from the Trash.'),
				rt.new_string('%s orders restored from the Trash.'),
				var_number.clone(), rt.new_string('woocommerce')]),
			rt.call_function('number_format_i18n', [var_number.clone()]),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('deleted'))) {
		var_message = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s order permanently deleted.'),
				rt.new_string('%s orders permanently deleted.'),
				var_number.clone(), rt.new_string('woocommerce')]),
			rt.call_function('number_format_i18n', [var_number.clone()]),
		])
	}
	if !(!rt.is_true(var_message)) {
		print('<div class="updated"><p>' +
			(rt.call_function('esc_html', [var_message.clone()])).str() + '</p></div>')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) enqueue_scripts() {
	print(this.get_order_preview_template())
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-orders')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_order_preview_template() string {
	mut var_order_edit_url_placeholder := rt.new_string((if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))
	{
			(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-orders&action=edit')])])).str() +
			'&id={{ data.data.id }}'
	} else {
			(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('post.php?action=edit')])])).str() +
			'&post={{ data.data.id }}'
	}).str())
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Order #%s'),
				rt.new_string('woocommerce')]),
			rt.new_string('{{ data.order_number }}'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Close modal panel'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_preview_start'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Billing details'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Email'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Phone'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Payment via'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping details'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Phone'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping method'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Note'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_preview_end')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Edit this order'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_order_edit_url_placeholder)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return var_html.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal) {
	mut var_input_id_mutated := var_input_id
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.has_items())))) {
		return
	}
	var_input_id_mutated = rt.new_string(var_input_id_mutated.str() + '-search-input')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))) {
		print('<input type="hidden" name="orderby" value="' +
			(rt.call_function('esc_attr', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))])])])).str() +
			'" />')
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))) {
		print('<input type="hidden" name="order" value="' +
			(rt.call_function('esc_attr', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))])])])).str() +
			'" />')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_admin_search_query', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	this.search_filter()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [var_text.clone(), rt.new_string(''),
		rt.new_string(''), rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'search-submit' },
		])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) search_filter() {
	mut var_options := rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.call_function('__', [
			rt.new_string('Order ID'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'customer_email', val: rt.call_function('__', [
			rt.new_string('Customer Email'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'customers', val: rt.call_function('__', [
			rt.new_string('Customers'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'products', val: rt.call_function('__', [
			rt.new_string('Products'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'all', val: rt.call_function('__', [
			rt.new_string('All'),
			rt.new_string('woocommerce'),
		]) },
	])
	var_options = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_hpos_admin_search_filters'),
		var_options.clone(),
	])
	mut var_saved_setting := rt.call_function('get_user_setting', [
		rt.new_string('wc-search-filter-hpos-admin'),
		rt.new_string('all'),
	])
	mut var_selected := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('search-filter'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('search-filter'))
		} else {
			var_saved_setting
		}]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_saved_setting, var_selected)))) {
		rt.call_function('set_user_setting', [
			rt.new_string('wc-search-filter-hpos-admin'),
			var_selected.clone(),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_13 := var_options.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_label := item_13.val
		mut var_value := item_13.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wp_unslash', [
				rt.call_function('sanitize_text_field', [var_value.clone()]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_value.clone(),
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [var_selected.clone()]),
			])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_DatePeriod {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_DateInterval {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_stdClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_orders_listtable() &Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable{
		PhpObjectBase:      rt.PhpObjectBase{}
		order_type:         rt.new_null()
		wp_post_type:       rt.new_null()
		request:            rt.new_array()
		order_query_args:   rt.new_array()
		has_filter:         false
		page_controller:    rt.new_null()
		is_trash:           false
		status_count_cache: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
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

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_wc_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_dateperiod(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_DatePeriod {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_DatePeriod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_dateinterval(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_DateInterval {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_DateInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_stdclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'setup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setup(dispatch_arg_0)
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row(dispatch_arg_0)
			return rt.new_null()
		}
		'render_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.render_column(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'items_per_page' {
			this.items_per_page()
			return rt.new_null()
		}
		'set_items_per_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.set_items_per_page(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'display' {
			this.display()
			return rt.new_null()
		}
		'render_blank_state' {
			this.render_blank_state()
			return rt.new_null()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'get_table_classes' {
			return this.get_table_classes()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'get_max_num_pages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_max_num_pages(dispatch_arg_0)
		}
		'set_order_args' {
			this.set_order_args()
			return rt.new_null()
		}
		'set_date_args' {
			this.set_date_args()
			return rt.new_null()
		}
		'set_customer_args' {
			this.set_customer_args()
			return rt.new_null()
		}
		'set_status_args' {
			this.set_status_args()
			return rt.new_null()
		}
		'set_search_args' {
			this.set_search_args()
			return rt.new_null()
		}
		'set_created_via_args' {
			this.set_created_via_args()
			return rt.new_null()
		}
		'created_via_filter' {
			this.created_via_filter()
			return rt.new_null()
		}
		'get_views' {
			return this.get_views()
		}
		'count_orders_by_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.count_orders_by_status(dispatch_arg_0))
		}
		'should_render_blank_state' {
			return rt.new_bool(this.should_render_blank_state())
		}
		'get_visible_statuses' {
			return this.get_visible_statuses()
		}
		'get_view_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_view_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'months_filter' {
			this.months_filter()
			return rt.new_null()
		}
		'get_months_filter_options' {
			return this.get_months_filter_options()
		}
		'get_and_maybe_update_months_filter_cache' {
			return this.get_and_maybe_update_months_filter_cache()
		}
		'customers_filter' {
			this.customers_filter()
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'default_hidden_columns' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Screen](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.default_hidden_columns(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_cb(dispatch_arg_0)
		}
		'render_order_number_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_order_number_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_edit_link' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_order_edit_link(mut dispatch_arg_0))
		}
		'render_order_date_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_order_date_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_status_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_order_status_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_status_label' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_order_status_label(mut dispatch_arg_0))
		}
		'render_billing_address_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_billing_address_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_shipping_address_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_shipping_address_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_total_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_order_total_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_wc_actions_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.render_wc_actions_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'print_hidden_form_fields' {
			this.print_hidden_form_fields()
			return rt.new_null()
		}
		'current_action' {
			return rt.new_string(this.current_action())
		}
		'handle_bulk_actions' {
			this.handle_bulk_actions()
			return rt.new_null()
		}
		'do_bulk_action_remove_personal_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.do_bulk_action_remove_personal_data(dispatch_arg_0))
		}
		'do_bulk_action_mark_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.do_bulk_action_mark_orders(dispatch_arg_0, dispatch_arg_1))
		}
		'do_delete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.do_delete(mut dispatch_arg_0, dispatch_arg_1))
		}
		'do_untrash' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_int(this.do_untrash(mut dispatch_arg_0))
		}
		'bulk_action_notices' {
			this.bulk_action_notices()
			return rt.new_null()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'get_order_preview_template' {
			return rt.new_string(this.get_order_preview_template())
		}
		'search_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.search_box(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'search_filter' {
			this.search_filter()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_type' { return this.order_type }
		'wp_post_type' { return this.wp_post_type }
		'request' { return this.request }
		'order_query_args' { return this.order_query_args }
		'has_filter' { return rt.new_bool(this.has_filter) }
		'page_controller' { return this.page_controller }
		'is_trash' { return rt.new_bool(this.is_trash) }
		'status_count_cache' { return this.status_count_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_type' {
			this.order_type = val
			return true
		}
		'wp_post_type' {
			this.wp_post_type = val
			return true
		}
		'request' {
			this.request = val
			return true
		}
		'order_query_args' {
			this.order_query_args = val
			return true
		}
		'has_filter' {
			this.has_filter = val.to_bool()
			return true
		}
		'page_controller' {
			this.page_controller = val
			return true
		}
		'is_trash' {
			this.is_trash = val.to_bool()
			return true
		}
		'status_count_cache' {
			this.status_count_cache = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_DatePeriod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_DatePeriod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_DatePeriod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_DateInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_DateInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_DateInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
