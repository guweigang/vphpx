import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query) get_default_query_vars() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.3.0'),
		rt.new_string('`GenericQuery`, `\\WC_Object_Query`, or direct `DataStore` use')])
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query) get_data() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.3.0'),
		rt.new_string('`GenericQuery`, `\\WC_Object_Query`, or direct `DataStore` use')])
	mut var_args := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_coupons_query_args'),
		this.get_query_vars(),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('report-coupons'))
	mut var_data_store := iife_result_0
	mut var_results := rt.call_method(var_data_store, 'get_data', [
		var_args.clone()])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_coupons_select_query'),
		var_results.clone(),
		var_args.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_coupons_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_data' {
			return this.get_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
