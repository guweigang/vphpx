import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_Query {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_Query) get_data() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('report-stock-stats'))
	mut var_data_store := iife_result_0
	mut var_results := rt.call_method(var_data_store, 'get_data', []rt.PhpVal{})
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_stock_stats_query'),
		var_results.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Object_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_stock_stats_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_stock_stats_wc_object_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Object_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Object_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_stock_stats_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_data' {
			return this.get_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Object_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Object_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Object_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Stats_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
