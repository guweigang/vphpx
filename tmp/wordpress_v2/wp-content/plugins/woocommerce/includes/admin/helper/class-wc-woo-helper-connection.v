import rt

struct Class_WC_Woo_Helper_Connection {
	rt.PhpObjectBase
}

fn Class_WC_Woo_Helper_Connection.get_connection_url_notice() string {
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.get_cached_connection_data()
	mut var_connection_data := iife_result_0
	if rt.is_true(rt.identical(rt.new_bool(false), var_connection_data))
		|| !(!rt.is_true(var_connection_data.array_get(rt.new_string('maybe_deleted_connection'))))
		|| rt.is_true(rt.identical(rt.new_bool(false), if !(var_connection_data.array_get(rt.new_string('alert_url_mismatch'))).is_null() { var_connection_data.array_get(rt.new_string('alert_url_mismatch')) } else { rt.new_bool(false) })) {
		return ''
	}
	mut iife_temp_1 := Class_WC_Helper_Options{}
	mut iife_result_1 := iife_temp_1.get(rt.new_string('auth'))
	mut var_auth := iife_result_1
	mut var_url_raw := if var_auth.clone().is_array() {
		if !(var_auth.array_get(rt.new_string('url'))).is_null() {
			var_auth.array_get(rt.new_string('url'))
		} else {
			rt.new_string('')
		}
	} else {
		rt.new_string('')
	}
	mut var_url := rt.call_function('esc_html', [
		rt.new_string(var_url_raw.clone().to_string().trim_right(' \t\n\r')),
	])
	mut var_home_url := rt.call_function('esc_html', [
		rt.new_string(rt.call_function('home_url', []rt.PhpVal{}).to_string().trim_right(' \t\n\r')),
	])
	if !rt.is_true(var_url) || rt.is_true(rt.identical(var_home_url, var_url)) {
		return ''
	}
	return (rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Your site is currently connected to WooCommerce.com using <b>%1$s</b>, but your actual site URL is <b>%2$s</b>. To fix this, please reconnect your site to <b>WooCommerce.com</b> to ensure everything works correctly.'),
			rt.new_string('woocommerce'),
		]),
		var_url.clone(),
		var_home_url.clone(),
	])).str()
}

fn Class_WC_Woo_Helper_Connection.get_deleted_connection_notice() string {
	mut iife_temp_2 := Class_WC_Helper{}
	mut iife_result_2 := iife_temp_2.get_cached_connection_data()
	mut var_connection_data := iife_result_2
	if rt.is_true(rt.identical(rt.new_bool(false), var_connection_data))
		|| !rt.is_true(var_connection_data.array_get(rt.new_string('maybe_deleted_connection'))) {
		return ''
	}
	mut var_home_url := rt.call_function('esc_html', [
		rt.new_string(rt.call_function('home_url', []rt.PhpVal{}).to_string().trim_right(' \t\n\r')),
	])
	return (rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('There is no connection for <b>%1$s</b> on WooCommerce.com. The connection may have been deleted. To fix this, please reconnect your site to <b>WooCommerce.com</b> to ensure everything works correctly.'),
			rt.new_string('woocommerce'),
		]),
		var_home_url.clone(),
	])).str()
}

fn Class_WC_Woo_Helper_Connection.has_host_plan_orders() bool {
	mut iife_temp_3 := Class_WC_Helper{}
	mut iife_result_3 := iife_temp_3.get_subscriptions()
	mut var_subscriptions := iife_result_3
	mut iter_1 := var_subscriptions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_subscription := item_1.val
		if var_subscription.array_isset(rt.new_string('included_in_host_plan'))
			&& rt.is_true(rt.identical(rt.new_bool(true), (var_subscription.array_get(rt.new_string('included_in_host_plan'))).to_bool())) {
			return true
		}
	}
	return false
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

fn create_wc_woo_helper_connection(_args ...rt.PhpVal) &Class_WC_Woo_Helper_Connection {
	mut obj := &Class_WC_Woo_Helper_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_options(_args ...rt.PhpVal) &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Woo_Helper_Connection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_connection_url_notice' {
			return rt.new_string(Class_WC_Woo_Helper_Connection.get_connection_url_notice())
		}
		'get_deleted_connection_notice' {
			return rt.new_string(Class_WC_Woo_Helper_Connection.get_deleted_connection_notice())
		}
		'has_host_plan_orders' {
			return rt.new_bool(Class_WC_Woo_Helper_Connection.has_host_plan_orders())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Woo_Helper_Connection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Woo_Helper_Connection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
