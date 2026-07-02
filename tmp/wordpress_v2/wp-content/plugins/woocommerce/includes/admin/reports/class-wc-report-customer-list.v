import rt

struct Class_WC_Report_Customer_List {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Report_Customer_List) construct() {
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'singular', val: 'customer' },
		rt.ArrayItem{ key: 'plural', val: 'customers' },
		rt.ArrayItem{ key: 'ajax', val: false },
	]))
}

fn (mut this Class_WC_Report_Customer_List) no_items() {
	rt.call_function('esc_html_e', [rt.new_string('No customers found.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Report_Customer_List) output_report() {
	this.prepare_items()
	print('<div id="poststuff" class="woocommerce-reports-wide">')
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('link_orders'))))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')), rt.new_string('link_orders')])) {
		mut var_linked := rt.call_function('wc_update_new_customer_past_orders', [
			rt.call_function('absint',
				[rt.get_superglobal('_GET').array_get(rt.new_string('link_orders'))]),
		])
		print('<div class="updated"><p>' +
			(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s previous order linked'), rt.new_string('%s previous orders linked'), var_linked.clone(), rt.new_string('woocommerce')]), var_linked.clone()])])).str() +
			'</p></div>')
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('refresh'))))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')), rt.new_string('refresh')])) {
		mut var_user_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('refresh')),
		])
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'),
			var_user_id.clone()])
		rt.call_function('delete_user_meta', [var_user_id.clone(),
			rt.new_string('_money_spent')])
		rt.call_function('delete_user_meta', [var_user_id.clone(),
			rt.new_string('_order_count')])
		rt.call_function('delete_user_meta', [var_user_id.clone(),
			rt.new_string('_last_order')])
		print('<div class="updated"><p>' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Refreshed stats for %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.get_property(var_user, 'display_name')])])).str() +
			'</p></div>')
	}
	print('<form method="post" id="woocommerce_customers">')
	this.search_box(rt.call_function('__', [rt.new_string('Search customers'),
		rt.new_string('woocommerce')]), rt.new_string('customer_search'))
	this.display()
	print('</form>')
	print('</div>')
}

fn (mut this Class_WC_Report_Customer_List) column_default(var_user rt.PhpVal, var_column_name rt.PhpVal) string {
	mut var_user_mutated := var_user
	mut switch_val_1 := var_column_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_name'))) {
		if rt.is_true(rt.get_property(var_user_mutated, 'last_name'))
			&& rt.is_true(rt.get_property(var_user_mutated, 'first_name')) {
			return (rt.get_property(var_user_mutated, 'last_name')).str() + ', ' +
				(rt.get_property(var_user_mutated, 'first_name')).str()
		} else {
			return '-'
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('username'))) {
		return (rt.get_property(var_user_mutated, 'user_login')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('location'))) {
		mut var_state_code := rt.call_function('get_user_meta', [
			rt.get_property(var_user_mutated, 'ID'),
			rt.new_string('billing_state'),
			rt.new_bool(true),
		])
		mut var_country_code := rt.call_function('get_user_meta', [
			rt.get_property(var_user_mutated, 'ID'),
			rt.new_string('billing_country'),
			rt.new_bool(true),
		])
		mut var_state := if rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'states').array_get(var_country_code).array_isset(var_state_code)
		{
			rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
				'states').array_get(var_country_code).array_get(var_state_code)
		} else {
			var_state_code
		}
		mut var_country := if rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'countries').array_isset(var_country_code)
		{
			rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
				'countries').array_get(var_country_code)
		} else {
			var_country_code
		}
		mut var_value := rt.new_string('')
		if rt.is_true(var_state) {
			var_value = rt.concat(var_value, rt.new_string(var_state.str() + ', '))
		}
		var_value = rt.concat(var_value, var_country)
		if rt.is_true(var_value) {
			return var_value.str()
		} else {
			return '-'
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email'))) {
		return '<a href="mailto:' + (rt.get_property(var_user_mutated, 'user_email')).str() + '">' +
			(rt.get_property(var_user_mutated, 'user_email')).str() + '</a>'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('spent'))) {
		return (rt.call_function('wc_price', [
			rt.call_function('wc_get_customer_total_spent', [
				rt.get_property(var_user_mutated, 'ID'),
			]),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('orders'))) {
		return (rt.call_function('wc_get_customer_order_count', [
			rt.get_property(var_user_mutated, 'ID'),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('last_order'))) {
		mut var_orders := rt.call_function('wc_get_orders', [
			rt.create_array([rt.ArrayItem{ key: 'limit', val: 1 },
				rt.ArrayItem{ key: 'status', val: rt.call_function('array_map', [
					rt.new_string('wc_get_order_status_name'),
					rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{}),
				]) }, rt.ArrayItem{ key: 'customer', val: rt.get_property(var_user_mutated, 'ID') }]),
		])
		if !(!rt.is_true(var_orders)) {
			mut var_order := var_orders.array_get(rt.new_int(0))
			return '<a href="' +
				(rt.call_function('admin_url', [rt.new_string('post.php?post=' + (rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() +
				'&action=edit')])).str() + '">' +
				(rt.call_function('_x', [rt.new_string('#'), rt.new_string('hash before order number'), rt.new_string('woocommerce')])).str() +
				(rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str() +
				'</a> &ndash; ' +(rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])).str()
		} else {
			return '-'
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc_actions'))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_admin_user_actions_start'),
			var_user_mutated.clone(),
		])
		mut var_actions := rt.new_array()
		var_actions.array_set('refresh', rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('wp_nonce_url', [
				rt.call_function('add_query_arg', [rt.new_string('refresh'),
					rt.get_property(var_user_mutated, 'ID')]),
				rt.new_string('refresh'),
			]) },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Refresh stats'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'refresh' },
		]))
		var_actions.array_set('edit', rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('admin_url', [
				rt.new_string('user-edit.php?user_id=' +
					(rt.get_property(var_user_mutated, 'ID')).str()),
			]) },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Edit'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'edit' },
		]))
		var_actions.array_set('view', rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('admin_url', [
				rt.new_string('edit.php?post_type=shop_order&_customer_user=' +
					(rt.get_property(var_user_mutated, 'ID')).str()),
			]) },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('View orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'view' },
		]))
		var_orders = rt.call_function('wc_get_orders', [
			rt.create_array([rt.ArrayItem{ key: 'limit', val: 1 },
				rt.ArrayItem{ key: 'status', val: rt.call_function('array_map', [
					rt.new_string('wc_get_order_status_name'),
					rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{}),
				]) }, rt.ArrayItem{ key: 'customer', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: none, val: 0 },
						rt.ArrayItem{ key: none, val: rt.get_property(var_user_mutated,
							'user_email') },
					]) },
				]) }]),
		])
		if rt.is_true(var_orders) {
			var_actions.array_set('link', rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [rt.new_string('link_orders'),
						rt.get_property(var_user_mutated, 'ID')]),
					rt.new_string('link_orders'),
				]) },
				rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
					rt.new_string('Link previous orders'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'action', val: 'link' },
			]))
		}
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_user_actions'),
			var_actions.clone(),
			var_user_mutated.clone(),
		])
		mut iter_1 := var_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			rt.call_function('printf', [
				rt.new_string('<a class="button tips %s" href="%s" data-tip="%s">%s</a>'),
				rt.call_function('esc_attr', [var_action.array_get(rt.new_string('action'))]),
				rt.call_function('esc_url', [var_action.array_get(rt.new_string('url'))]),
				rt.call_function('esc_attr', [var_action.array_get(rt.new_string('name'))]),
				rt.call_function('esc_attr', [var_action.array_get(rt.new_string('name'))]),
			])
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_admin_user_actions_end'),
			var_user_mutated.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		mut var_user_actions := rt.call_function('ob_get_contents', []rt.PhpVal{})
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		return var_user_actions.str()
	}
	return ''
}

fn (mut this Class_WC_Report_Customer_List) get_columns() rt.PhpVal {
	mut var_columns := {
		'customer_name': rt.call_function('__', [rt.new_string('Name (Last, First)'),
			rt.new_string('woocommerce')])
		'username':      rt.call_function('__', [rt.new_string('Username'),
			rt.new_string('woocommerce')])
		'email':         rt.call_function('__', [rt.new_string('Email'),
			rt.new_string('woocommerce')])
		'location':      rt.call_function('__', [rt.new_string('Location'),
			rt.new_string('woocommerce')])
		'orders':        rt.call_function('__', [rt.new_string('Orders'),
			rt.new_string('woocommerce')])
		'spent':         rt.call_function('__', [rt.new_string('Money spent'),
			rt.new_string('woocommerce')])
		'last_order':    rt.call_function('__', [rt.new_string('Last order'),
			rt.new_string('woocommerce')])
		'wc_actions':    rt.call_function('__', [rt.new_string('Actions'),
			rt.new_string('woocommerce')])
	}
	return var_columns.clone()
}

fn (mut this Class_WC_Report_Customer_List) order_by_last_name(var_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	mut var_s := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')),
		]) } else { rt.new_string('') }
	rt.get_property(var_query_mutated, 'query_from') = rt.concat(rt.get_property(var_query_mutated,
		'query_from'), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
		'usermeta')), rt.new_string(' as meta2 ON (')), rt.get_property(var_wpdb, 'users')),
		rt.new_string('.ID = meta2.user_id) ')))
	rt.get_property(var_query_mutated, 'query_where') = rt.concat(rt.get_property(var_query_mutated,
		'query_where'), rt.new_string(" AND meta2.meta_key = 'last_name' "))
	rt.set_property(var_query_mutated, 'query_orderby',
		rt.new_string(' ORDER BY meta2.meta_value, user_login ASC '))
	if rt.is_true(var_s) {
		rt.get_property(var_query_mutated, 'query_from') = rt.concat(rt.get_property(var_query_mutated,
			'query_from'), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'usermeta')), rt.new_string(' as meta3 ON (')), rt.get_property(var_wpdb, 'users')),
			rt.new_string('.ID = meta3.user_id)')))
		rt.get_property(var_query_mutated, 'query_where') = rt.concat(rt.get_property(var_query_mutated,
			'query_where'), rt.new_string(
			" AND ( user_login LIKE '%" + (rt.call_function('esc_sql', [rt.call_function('str_replace', [rt.new_string('*'), rt.new_string(''), var_s.clone()])])).str() +
			"%' OR user_nicename LIKE '%" +
			(rt.call_function('esc_sql', [rt.call_function('str_replace', [rt.new_string('*'), rt.new_string(''), var_s.clone()])])).str() +
			"%' OR meta3.meta_value LIKE '%" +
			(rt.call_function('esc_sql', [rt.call_function('str_replace', [rt.new_string('*'), rt.new_string(''), var_s.clone()])])).str() +
			"%' ) "))
		rt.set_property(var_query_mutated, 'query_orderby', ' GROUP BY ID ' +
			(rt.get_property(var_query_mutated, 'query_orderby')).str())
	}
	return var_query_mutated.clone()
}

fn (mut this Class_WC_Report_Customer_List) prepare_items() {
	mut var_current_page := rt.call_function('absint', [this.get_pagenum()])
	mut var_per_page := rt.new_int(20)
	this.dispatch_set_prop('_column_headers', rt.create_array([
		rt.ArrayItem{ key: none, val: this.get_columns() },
		rt.ArrayItem{ key: none, val: rt.new_array() },
		rt.ArrayItem{ key: none, val: this.get_sortable_columns() },
	]))
	rt.call_function('add_action', [rt.new_string('pre_user_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Customer_List', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_last_name' },
		])])
	mut var_privileged_users := create_wp_user_query(rt.create_array([
		rt.ArrayItem{ key: 'fields', val: 'ID' },
		rt.ArrayItem{ key: 'role__in', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'administrator' },
			rt.ArrayItem{ key: none, val: 'shop_manager' },
		]) },
	]))
	mut var_query := create_wp_user_query(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_report_customer_list_user_query_args'),
		rt.create_array([
			rt.ArrayItem{ key: 'exclude', val: var_privileged_users.get_results() },
			rt.ArrayItem{ key: 'number', val: var_per_page },
			rt.ArrayItem{ key: 'offset', val: rt.mul(rt.sub(var_current_page, rt.new_int(1)),
				var_per_page) },
		]),
	]))
	this.dispatch_set_prop('items', var_query.get_results())
	rt.call_function('remove_action', [rt.new_string('pre_user_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Customer_List', [
				'WP_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_last_name' },
		])])
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: rt.get_property(var_query, 'total_users') },
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [
			rt.div(rt.get_property(var_query, 'total_users'), var_per_page),
		]) },
	]))
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

fn create_wc_report_customer_list() &Class_WC_Report_Customer_List {
	mut obj := &Class_WC_Report_Customer_List{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Customer_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'output_report' {
			this.output_report()
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.column_default(dispatch_arg_0, dispatch_arg_1))
		}
		'get_columns' {
			return this.get_columns()
		}
		'order_by_last_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_last_name(dispatch_arg_0)
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Report_Customer_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Report_Customer_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_List_Table'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
