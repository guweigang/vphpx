import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query) get_default_query_vars() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('9.3.0'), rt.new_string('`Reports\\Customers\\Query` with a custom name, `GenericQuery`, `\\WC_Object_Query`, or direct `DataStore` use')])
	return rt.create_array([rt.ArrayItem{ key: 'per_page', val: rt.call_function('get_option', [rt.new_string('posts_per_page')]) }, rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'orderby', val: 'date_registered' }, rt.ArrayItem{ key: 'fields', val: '*' }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query) get_data() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('x.x.x'), rt.new_string('`Reports\\Customers\\Query` with a custom name, `GenericQuery`, `\\WC_Object_Query`, or direct `DataStore` use')])
	mut var_args := rt.call_function('apply_filters', [rt.new_string('woocommerce_analytics_customers_stats_query_args'), this.get_query_vars()])
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('report-customers-stats'))
	mut var_results := rt.call_method(var_data_store, 'get_data', [var_args.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_analytics_customers_stats_select_query'), var_results.dup(), var_args.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_customers_stats_query() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_query() &Class_Automattic_WooCommerce_Admin_API_Reports_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_stats_wc_data_store() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_data' {
			return this.get_data()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Stats_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_customers_stats_query_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
