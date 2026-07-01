import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable {
	rt.PhpObjectBase
pub mut:
		order_type rt.PhpVal = rt.new_null()
		wp_post_type rt.PhpVal = rt.new_null()
		request rt.PhpVal = rt.new_array()
		order_query_args rt.PhpVal = rt.new_array()
		has_filter bool
		page_controller rt.PhpVal = rt.new_null()
		is_trash bool
		status_count_cache rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) construct()  {
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'order' }, rt.ArrayItem{ key: 'plural', val: 'orders' }, rt.ArrayItem{ key: 'ajax', val: false }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) init(mut var_page_controller Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController)  {
	this.page_controller = var_page_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) setup(var_args rt.PhpVal)  {
	this.order_type = if !(var_args.array_get('order_type')).is_null() { var_args.array_get('order_type') } else { rt.new_string('shop_order') }
	this.wp_post_type = rt.call_function('get_post_type_object', [this.order_type])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'bulk_action_notices' }])])
	rt.call_function('add_filter', [rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this), 'screen'), 'id')), rt.new_string('_columns')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'get_columns' }]), rt.new_int(0)])
	rt.call_function('add_filter', ['set_screen_option_edit_' + (this.order_type).str() + '_per_page', rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'set_items_per_page' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('default_hidden_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'default_hidden_columns' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_list_table_restrict_manage_orders'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'created_via_filter' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_list_table_restrict_manage_orders'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'customers_filter' }])])
	this.items_per_page()
	rt.call_function('set_screen_options', []rt.PhpVal{})
	rt.call_function('add_action', ['manage_' + (rt.call_function('wc_get_page_screen_id', [this.order_type])).str() + '_custom_column', rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'render_column' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) single_row(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_css_classes := rt.call_function('apply_filters', ['woocommerce_' + (this.order_type).str() + '_list_table_order_css_classes', rt.create_array([rt.ArrayItem{ key: none, val: 'order-' + (rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: none, val: 'type-' + (rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: none, val: 'status-' + (rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})).str() }]), var_order_mutated.dup()])
	var_css_classes = rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('trim'), var_css_classes.dup()])])
	mut var_edit_lock := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.class()])
	if rt.is_true(rt.call_method(var_edit_lock, 'is_locked_by_another_user', [var_order_mutated.dup()])) {
		var_css_classes.array_push('wp-locked')
	}
	print('<tr id="order-' + (rt.call_function('esc_attr', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])).str() + '" class="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_css_classes.dup()])])).str() + '">')
	this.single_row_columns(var_order_mutated.dup())
	print('</tr>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_column(var_column_id rt.PhpVal, var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'render_' + (var_column_id).str() + '_column' }])])) {
		rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'render_' + (var_column_id).str() + '_column' }]), var_order_mutated.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) column_default(var_order rt.PhpVal, var_column_name rt.PhpVal)  {
	mut var_order_mutated := var_order
	rt.call_function('do_action', ['woocommerce_' + (this.order_type).str() + '_list_table_custom_column', var_column_name.dup(), var_order_mutated.dup()])
	rt.call_function('do_action', [rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_ListTable', ['WP_List_Table'], &this), 'screen'), 'id')), rt.new_string('_custom_column')), var_column_name.dup(), var_order_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) items_per_page()  {
	rt.call_function('add_screen_option', [rt.new_string('per_page'), rt.create_array([rt.ArrayItem{ key: 'default', val: 20 }, rt.ArrayItem{ key: 'option', val: 'edit_' + (this.order_type).str() + '_per_page' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_items_per_page(var_default rt.PhpVal, option string, value i64) rt.PhpVal {
	mut option_mutated := option
	return if rt.is_true(rt.identical('edit_' + (this.order_type).str() + '_per_page', rt.new_string(option_mutated))) { rt.call_function('absint', [rt.new_int(value)]) } else { var_default }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) display()  {
	mut var_post_type := rt.call_function('get_post_type_object', [this.order_type])
	mut var_title := rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type, 'labels'), 'name')])
	mut var_add_new := rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type, 'labels'), 'add_new')])
	mut var_new_page_link := rt.call_method(this.page_controller, 'get_new_page_url', [this.order_type])
	mut var_search_label := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(this.order_query_args.array_get('s'))) {
		var_search_label = rt.new_string(rt.new_string('<span class="subtitle">'))
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.echo_val(rt.call_function('wp_kses_post', ["\n\t\t\t<div class='wrap'>\n\t\t\t\t<h1 class='wp-heading-inline'>${var_title.to_string()}</h1>\n\t\t\t\t<a href='" + (rt.call_function('esc_url', [var_new_page_link.dup()])).str() + "' class='page-title-action'>${var_add_new.to_string()}</a>\n\t\t\t\t${var_search_label.to_string()}\n\t\t\t\t<hr class='wp-header-end'>"]))
	if this.should_render_blank_state() {
		this.render_blank_state()
		return rt.new_null()
	}
	this.views()
	print('<form id="wc-orders-filter" method="get" action="' + (rt.call_function('esc_url', [rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('admin.php')])])).str() + '">')
	this.print_hidden_form_fields()
	this.search_box(rt.call_function('esc_html__', [rt.new_string('Search orders'), rt.new_string('woocommerce')]), rt.new_string('orders-search-input'))
	this.Class_WP_List_Table.display()
	print('</form> </div>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_blank_state()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('When you receive a new order, it will appear here.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more about orders'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('wc_marketplace_suggestions_orders_empty_state')])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_bulk_actions() rt.PhpVal {
	mut var_selected_status := if !(this.order_query_args.array_get('status')).is_null() { this.order_query_args.array_get('status') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(this.wp_post_type, 'cap'), 'edit_others_posts')]))))) {
		return rt.new_array()
	}
	if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'trash' }]), var_selected_status)) {
		mut var_actions := rt.create_array([rt.ArrayItem{ key: 'untrash', val: rt.call_function('__', [rt.new_string('Restore'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'delete', val: rt.call_function('__', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')]) }])
	} else {
		var_actions = rt.create_array([rt.ArrayItem{ key: 'mark_processing', val: rt.call_function('__', [rt.new_string('Change status to processing'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'mark_on-hold', val: rt.call_function('__', [rt.new_string('Change status to on-hold'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'mark_completed', val: rt.call_function('__', [rt.new_string('Change status to completed'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'mark_cancelled', val: rt.call_function('__', [rt.new_string('Change status to cancelled'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'trash', val: rt.call_function('__', [rt.new_string('Move to Trash'), rt.new_string('woocommerce')]) }])
	}
	if rt.is_true(rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_allow_bulk_remove_personal_data'), rt.new_string('no')])])) {
		var_actions.array_set('remove_personal_data', rt.call_function('__', [rt.new_string('Remove personal data'), rt.new_string('woocommerce')]))
	}
	return var_actions.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_table_classes() rt.PhpVal {
	mut var_css_classes := rt.call_function('apply_filters', ['woocommerce_' + (this.order_type).str() + '_list_table_css_classes', rt.call_function('array_merge', [this.Class_WP_List_Table.get_table_classes(), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-orders-list-table' }, rt.ArrayItem{ key: none, val: 'wc-orders-list-table-' + (this.order_type).str() }])]), this.order_type])
	return rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('trim'), var_css_classes.dup()])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) prepare_items()  {
	mut var_limit := this.get_items_per_page(rt.new_string('edit_' + (this.order_type).str() + '_per_page'))
	this.order_query_args = rt.create_array([rt.ArrayItem{ key: 'limit', val: var_limit }, rt.ArrayItem{ key: 'page', val: this.get_pagenum() }, rt.ArrayItem{ key: 'paginate', val: true }, rt.ArrayItem{ key: 'type', val: this.order_type }])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 's' }, rt.ArrayItem{ key: none, val: 'm' }, rt.ArrayItem{ key: none, val: '_customer_user' }, rt.ArrayItem{ key: none, val: 'search-filter' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query_var := item_1.val
			this.request.array_set(var_query_var, rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(var_query_var)).is_null() { rt.get_superglobal('_REQUEST').array_get(var_query_var) } else { rt.new_string('') }])]))
		}
	}
	this.request = rt.call_function('apply_filters', ['woocommerce_' + (this.order_type).str() + '_list_table_request', this.request])
	this.set_status_args()
	this.set_order_args()
	this.set_date_args()
	this.set_customer_args()
	this.set_search_args()
	this.set_created_via_args()
	mut var_order_query_args := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_list_table_prepare_items_query_args'), this.order_query_args]))
	var_order_query_args = rt.call_function('apply_filters', ['woocommerce_' + (this.order_type).str() + '_list_table_prepare_items_query_args', var_order_query_args.dup()])
	var_order_query_args.array_set('paginate', true)
	if !rt.is_true(rt.call_function('array_diff', [rt.func_array_keys(this.order_query_args), rt.create_array([rt.ArrayItem{ key: none, val: 'limit' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'paginate' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'order' }])])) {
		this.order_query_args.array_set('no_found_rows', true)
		var_order_query_args.array_set('no_found_rows', true)
	}
	mut var_orders := rt.call_function('wc_get_orders', [var_order_query_args.dup()])
	this.dispatch_set_prop('items', rt.get_property(var_orders, 'orders'))
	mut var_max_num_pages := this.get_max_num_pages(var_orders.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_max_num_pages)) && rt.is_true(rt.greater(this.order_query_args.array_get('page'), rt.new_int(1))))) {
		mut var_count_query_args := var_order_query_args.dup()
		var_count_query_args.array_set('page', 1)
		var_count_query_args.array_set('limit', 1)
		mut var_order_count := rt.call_function('wc_get_orders', [var_count_query_args.dup()])
		var_max_num_pages = // unsupported expression: Expr_Cast_Int
	}
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: if !(rt.get_property(var_orders, 'total')).is_null() { rt.get_property(var_orders, 'total') } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'per_page', val: var_limit }, rt.ArrayItem{ key: 'total_pages', val: var_max_num_pages }]))
	this.is_trash = rt.identical(rt.new_string('trash'), .array_get())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_max_num_pages(var_orders rt.PhpVal) rt.PhpVal {
	mut var_orders_mutated := var_orders
	if rt.is_true(rt.new_bool(!(this.order_query_args.array_isset(rt.new_string('no_found_rows'))) || rt.is_true(rt.new_bool(!(rt.is_true(.array_get())))))) {
		return rt.get_property(var_orders_mutated, 'max_num_pages')
	}
	mut var_count := rt.new_int(this.count_orders_by_status())
	mut var_limit := 
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_order_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_date_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_customer_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_status_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_search_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) set_created_via_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) created_via_filter()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_views() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) count_orders_by_status(var_status rt.PhpVal) i64 {
	mut var_status_mutated := var_status
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) should_render_blank_state() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_visible_statuses() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_view_link(slug string, name string, count i64, current bool) string {
	mut name_mutated := name
	mut count_mutated := count
	mut current_mutated := current
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) extra_tablenav(var_which rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) months_filter()  {
	mut var_wp_locale := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_months_filter_options() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_and_maybe_update_months_filter_cache() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) customers_filter()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_columns() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_sortable_columns() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) default_hidden_columns(mut var_hidden Class_Automattic_WooCommerce_Internal_Admin_Orders_array, mut var_screen Class_WP_Screen) rt.PhpVal {
	mut var_hidden_mutated := var_hidden
	mut var_screen_mutated := var_screen
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) column_cb(var_item rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_number_column(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_order_edit_link(mut var_order Class_WC_Order) string {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_date_column(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_status_column(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_order_status_label(mut var_order Class_WC_Order) string {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_billing_address_column(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_shipping_address_column(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_order_total_column(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) render_wc_actions_column(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) print_hidden_form_fields()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) current_action() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) handle_bulk_actions()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_bulk_action_remove_personal_data(var_order_ids rt.PhpVal) i64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_bulk_action_mark_orders(var_order_ids rt.PhpVal, var_new_status rt.PhpVal) i64 {
	mut var_new_status_mutated := var_new_status
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_delete(mut var_ids Class_Automattic_WooCommerce_Internal_Admin_Orders_array, force_delete bool) i64 {
	mut var_ids_mutated := var_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) do_untrash(mut var_ids Class_Automattic_WooCommerce_Internal_Admin_Orders_array) i64 {
	mut var_ids_mutated := var_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) bulk_action_notices()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) enqueue_scripts()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) get_order_preview_template() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal)  {
	mut var_input_id_mutated := var_input_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable) search_filter()  {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_orders_listtable() &Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable{
		PhpObjectBase: rt.PhpObjectBase{}
		order_type: rt.new_null()
		wp_post_type: rt.new_null()
		request: rt.new_array()
		order_query_args: rt.new_array()
		has_filter: false
		page_controller: rt.new_null()
		is_trash: false
		status_count_cache: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return rt.new_string(this.get_view_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Screen](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.default_hidden_columns(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_cb(dispatch_arg_0)
		}
		'render_order_number_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_order_number_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_edit_link' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_order_edit_link(mut dispatch_arg_0))
		}
		'render_order_date_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_order_date_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_status_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_order_status_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_status_label' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_order_status_label(mut dispatch_arg_0))
		}
		'render_billing_address_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_billing_address_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_shipping_address_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_shipping_address_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_order_total_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_order_total_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_wc_actions_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.do_delete(mut dispatch_arg_0, dispatch_arg_1))
		}
		'do_untrash' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'order_type' { this.order_type = val; return true }
		'wp_post_type' { this.wp_post_type = val; return true }
		'request' { this.request = val; return true }
		'order_query_args' { this.order_query_args = val; return true }
		'has_filter' { this.has_filter = (val).to_bool(); return true }
		'page_controller' { this.page_controller = val; return true }
		'is_trash' { this.is_trash = (val).to_bool(); return true }
		'status_count_cache' { this.status_count_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_orders_listtable_php() {
}
