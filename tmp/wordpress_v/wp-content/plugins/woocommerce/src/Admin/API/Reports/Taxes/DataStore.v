import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_order_tax_lookup')
		cache_key rt.PhpVal = rt.new_string('taxes')
		column_types rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('taxes')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) assign_report_columns()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }()
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'tax_rate_id', val: "${var_table_name.to_string()}.tax_rate_id" }, rt.ArrayItem{ key: 'name', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX(SUBSTRING_INDEX('), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_name,\'-\',-2), \'-\', 1) as name')) }, rt.ArrayItem{ key: 'tax_rate', val: 'CAST(itemmeta_rate_percent.meta_value AS DECIMAL(7,4)) as tax_rate' }, rt.ArrayItem{ key: 'country', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX('), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_name,\'-\',1) as country')) }, rt.ArrayItem{ key: 'state', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX(SUBSTRING_INDEX('), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_name,\'-\',-3), \'-\', 1) as state')) }, rt.ArrayItem{ key: 'priority', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX('), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_name,\'-\',-1) as priority')) }, rt.ArrayItem{ key: 'total_tax', val: 'SUM(total_tax) as total_tax' }, rt.ArrayItem{ key: 'order_tax', val: 'SUM(order_tax) as order_tax' }, rt.ArrayItem{ key: 'shipping_tax', val: 'SUM(shipping_tax) as shipping_tax' }, rt.ArrayItem{ key: 'orders_count', val: "COUNT( DISTINCT ( CASE WHEN parent_id = 0 THEN ${var_table_name.to_string()}.order_id END ) ) as orders_count" }]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_analytics_delete_order_stats'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'sync_on_order_delete' }]), rt.new_int(15)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) add_from_sql_params(var_query_args rt.PhpVal, var_order_status_filter rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_status_filter_mutated := var_order_status_filter
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }()
	if rt.is_true(var_order_status_filter_mutated) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats ON ')), var_table_name), rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats.order_id'))])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items ON ')), var_table_name), rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_id AND ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_type = \'tax\''))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta itemmeta_rate_id ON itemmeta_rate_id.order_item_id = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_id AND itemmeta_rate_id.meta_key = \'rate_id\''))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta itemmeta_rate_percent ON itemmeta_rate_percent.order_item_id = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_id AND itemmeta_rate_percent.meta_key = \'rate_percent\''))])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) add_sql_query_params(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_tax_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }()
	this.add_time_period_sql_params(var_query_args.dup(), var_order_tax_lookup_table.dup())
	this.get_limit_sql_params(var_query_args.dup())
	this.add_order_by_sql_params(var_query_args.dup())
	mut var_order_status_filter := this.get_status_subquery(var_query_args.dup())
	this.add_from_sql_params(var_query_args.dup(), var_order_status_filter.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND itemmeta_rate_id.meta_value = ${var_order_tax_lookup_table.to_string()}.tax_rate_id")])
	if var_query_args.array_isset(rt.new_string('taxes')) && !(!rt.is_true(var_query_args.array_get('taxes'))) {
		mut var_allowed_taxes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_filtered_ids(arg_0, arg_1) }(var_query_args.dup(), rt.new_string('taxes'))
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ${var_order_tax_lookup_table.to_string()}.tax_rate_id IN (${var_allowed_taxes.to_string()})")])
	}
	if rt.is_true(var_order_status_filter) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ( ${var_order_status_filter.to_string()} )")])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('orderby', 'tax_rate_id')
	var_defaults.array_set('taxes', rt.new_array())
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.initialize_queries()
	mut var_data := // unsupported expression: Expr_Cast_Object
	this.add_sql_query_params(var_query_args.dup())
	mut var_params := this.get_limit_params(var_query_args.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_query_args.array_isset(rt.new_string('taxes')) && rt.is_true(rt.new_bool(var_query_args.array_get('taxes').is_array())))) && !(!rt.is_true(var_query_args.array_get('taxes'))))) {
		mut var_total_results := rt.new_int(rt.new_int(var_query_args.array_get('taxes').array_count()))
		mut var_total_pages := // unsupported expression: Expr_Cast_Int
	} else {
		mut var_db_records_count := // unsupported expression: Expr_Cast_Int
		var_total_results = var_db_records_count.dup()
		var_total_pages = // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_query_args.array_get('page'), rt.new_int(1))) || rt.is_true(rt.greater(var_query_args.array_get('page'), var_total_pages)))) {
			return var_data.dup()
		}
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), this.selected_columns(var_query_args.dup())])
	if rt.is_true(rt.call_function('in_array', [var_query_args.array_get('orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'total_tax' }, rt.ArrayItem{ key: none, val: 'order_tax' }, rt.ArrayItem{ key: none, val: 'shipping_tax' }, rt.ArrayItem{ key: none, val: 'orders_count' }]), rt.new_bool(true)])) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'), (this.get_sql_clause(rt.new_string('order_by'))).str() + ', tax_rate_id'])
	} else {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'), this.get_sql_clause(rt.new_string('order_by'))])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'), this.get_sql_clause(rt.new_string('limit'))])
	mut var_taxes_query := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})
	mut var_tax_data := rt.call_method(var_wpdb, 'get_results', [var_taxes_query.dup(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_tax_data)) {
		return var_data.dup()
	}
	var_tax_data = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this) }, rt.ArrayItem{ key: none, val: 'cast_numbers' }]), var_tax_data.dup()])
	var_data = // unsupported expression: Expr_Cast_Object
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string('tax_code'), var_order_by)) {
		return rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_order_items.order_item_name'))
	} else if rt.is_true(rt.identical(rt.new_string('rate'), var_order_by)) {
		return 'tax_rate'
	}
	return (var_order_by).str()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_order_taxes(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return // unsupported expression: Expr_UnaryMinus
	}
	mut var_tax_items := rt.call_method(var_order, 'get_items', [Class_Automattic_WooCommerce_Enums_OrderItemType.tax()])
	mut var_num_updated := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_tax_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_item := item_1.val
			mut var_result := rt.call_method(var_wpdb, 'replace', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }(), rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_method(rt.call_method(var_order, 'get_date_created', [rt.new_string('edit')]), 'date', [// unsupported expression: Expr_StaticPropertyFetch]) }, rt.ArrayItem{ key: 'tax_rate_id', val: rt.call_method(var_tax_item, 'get_rate_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_tax', val: rt.call_method(var_tax_item, 'get_shipping_tax_total', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_tax', val: rt.call_method(var_tax_item, 'get_tax_total', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'total_tax', val: rt.add(// unsupported expression: Expr_Cast_Double, // unsupported expression: Expr_Cast_Double) }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%f' }, rt.ArrayItem{ key: none, val: '%f' }, rt.ArrayItem{ key: none, val: '%f' }])])
			rt.call_function('do_action', [rt.new_string('woocommerce_analytics_update_tax'), rt.call_method(var_tax_item, 'get_rate_id', []rt.PhpVal{}), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	return rt.identical(rt.new_int(var_tax_items.dup().array_count()), var_num_updated)
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_on_order_delete(var_order_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'delete', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }(), rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_analytics_delete_tax'), rt.new_int(0), var_order_id.dup()])
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}; return temp.invalidate() }()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) initialize_queries()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.clear_all_clauses()
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery((this.context).str() + '_subquery'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), (fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }()).str() + '.tax_rate_id'])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'), (fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.get_db_table_name() }()).str() + '.tax_rate_id'])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'), rt.concat(rt.concat(rt.new_string(', '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items.order_item_name, itemmeta_rate_percent.meta_value'))])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_taxes_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_order_tax_lookup')
		cache_key: rt.new_string('taxes')
		column_types: rt.new_array()
		context: rt.new_string('taxes')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache() &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_sqlquery() &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.init()
			return rt.new_null()
		}
		'add_from_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_from_sql_params(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_sql_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_sql_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'normalize_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.normalize_order_by(dispatch_arg_0))
		}
		'sync_order_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_order_taxes(dispatch_arg_0)
		}
		'sync_on_order_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_on_order_delete(dispatch_arg_0)
			return rt.new_null()
		}
		'initialize_queries' {
			this.initialize_queries()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'table_name' { this.table_name = val; return true }
		'cache_key' { this.cache_key = val; return true }
		'column_types' { this.column_types = val; return true }
		'context' { this.context = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_taxes_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
