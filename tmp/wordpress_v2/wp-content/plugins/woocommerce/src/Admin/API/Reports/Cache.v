import rt

pub fn Class_Automattic_WooCommerce_Admin_API_Reports_Cache.version_option() string {
	return 'woocommerce_reports'
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Cache.invalidate() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_transient_version(Class_Automattic_WooCommerce_Admin_API_Reports_Automattic_WooCommerce_Admin_API_Reports_Cache.version_option(),
		rt.new_bool(true))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Cache.get_version() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper{}
	mut iife_result_1 :=
		iife_temp_1.get_transient_version(Class_Automattic_WooCommerce_Admin_API_Reports_Automattic_WooCommerce_Admin_API_Reports_Cache.version_option())
	mut var_version := iife_result_1
	return var_version.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Cache.get(var_key rt.PhpVal) bool {
	mut var_transient_version := Class_Automattic_WooCommerce_Admin_API_Reports_Cache.get_version()
	mut var_transient_value := rt.call_function('get_transient', [
		var_key.clone()])
	if var_transient_value.array_isset(rt.new_string('value'))
		&& var_transient_value.array_isset(rt.new_string('version'))
		&& rt.is_true(rt.identical(var_transient_value.array_get(rt.new_string('version')), var_transient_version)) {
		return (var_transient_value.array_get(rt.new_string('value'))).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Cache.set(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_transient_version := Class_Automattic_WooCommerce_Admin_API_Reports_Cache.get_version()
	mut var_transient_value := rt.create_array([
		rt.ArrayItem{ key: 'version', val: var_transient_version },
		rt.ArrayItem{ key: 'value', val: var_value },
	])
	mut var_result := rt.call_function('set_transient', [var_key.clone(),
		var_transient_value.clone(), rt.get_constant('WEEK_IN_SECONDS')])
	return var_result.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_cache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_cache_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'invalidate' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Cache.invalidate()
			return rt.new_null()
		}
		'get_version' {
			return Class_Automattic_WooCommerce_Admin_API_Reports_Cache.get_version()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Cache.get(dispatch_arg_0))
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Cache.set(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
