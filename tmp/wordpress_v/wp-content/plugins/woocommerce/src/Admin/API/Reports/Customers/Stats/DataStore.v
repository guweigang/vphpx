import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore {
	rt.PhpObjectBase
pub mut:
		column_types rt.PhpVal = rt.new_array()
		cache_key rt.PhpVal = rt.new_string('customers_stats')
		context rt.PhpVal = rt.new_string('customers_stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore) assign_report_columns()  {
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'customers_count', val: 'COUNT( * ) as customers_count' }, rt.ArrayItem{ key: 'avg_orders_count', val: 'AVG( orders_count ) as avg_orders_count' }, rt.ArrayItem{ key: 'avg_total_spend', val: 'AVG( total_spend ) as avg_total_spend' }, rt.ArrayItem{ key: 'avg_avg_order_value', val: 'AVG( avg_order_value ) as avg_avg_order_value' }]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{}; return temp.get_default_query_vars() }()
	var_defaults.array_set('orderby', 'date_registered')
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.initialize_queries()
	mut var_data := // unsupported expression: Expr_Cast_Object
	mut var_selections := this.selected_columns(var_query_args.dup())
	this.add_sql_query_params(var_query_args.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), rt.new_string('SUM( total_sales ) AS total_spend,')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), rt.new_string('SUM( CASE WHEN parent_id = 0 THEN 1 END ) as orders_count,')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), rt.new_string('CASE WHEN SUM( CASE WHEN parent_id = 0 THEN 1 ELSE 0 END ) = 0 THEN NULL ELSE SUM( total_sales ) / SUM( CASE WHEN parent_id = 0 THEN 1 ELSE 0 END ) END AS avg_order_value')])
	this.clear_sql_clause(rt.create_array([rt.ArrayItem{ key: none, val: 'order_by' }, rt.ArrayItem{ key: none, val: 'limit' }]))
	this.add_sql_clause(rt.new_string('select'), var_selections.dup())
	this.add_sql_clause(rt.new_string('from'), rt.new_string(rt.concat(rt.concat(rt.new_string('('), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})), rt.new_string(') AS tt'))))
	mut var_report_data := rt.call_method(var_wpdb, 'get_results', [this.get_query_statement(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_report_data)) {
		return var_data.dup()
	}
	var_data = // unsupported expression: Expr_Cast_Object
	return var_data.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_customers_stats_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		column_types: rt.new_array()
		cache_key: rt.new_string('customers_stats')
		context: rt.new_string('customers_stats')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'column_types' { return this.column_types }
		'cache_key' { return this.cache_key }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'column_types' { this.column_types = val; return true }
		'cache_key' { this.cache_key = val; return true }
		'context' { this.context = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_customers_stats_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
