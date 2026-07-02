import rt

struct Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_abilitiesapi_abilitiesclient() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient', 'enabled',
		rt.new_bool(false))
}

fn Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient.enable() bool {
	if rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient',
		'enabled'))
	{
		return true
	}
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'enqueue_for_admin' }])])
	rt.set_static_prop('Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient', 'enabled',
		rt.new_bool(true))
	return true
}

fn Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient.enqueue_for_admin() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.call_function('wp_script_is', [rt.new_string('wp-abilities'),
		rt.new_string('registered')]))
	{
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-abilities')])
	}
}

fn create_automattic_woocommerce_internal_abilitiesapi_abilitiesclient(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient {
	mut obj := &Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enable' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient.enable())
		}
		'enqueue_for_admin' {
			Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient.enqueue_for_admin()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_AbilitiesApi_AbilitiesClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
