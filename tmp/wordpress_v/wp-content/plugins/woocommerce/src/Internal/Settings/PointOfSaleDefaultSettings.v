import rt

struct Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings.get_default_store_email() rt.PhpVal {
	return rt.call_function('get_option', [rt.new_string('admin_email')])
}

fn Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings.get_default_store_name() rt.PhpVal {
	return rt.call_function('get_bloginfo', [rt.new_string('name')])
}

fn Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings.get_default_store_address() string {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WC', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries')))))))
	{
		return ''
	}
	return (rt.call_function('wp_specialchars_decode', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_formatted_address', [
			rt.create_array([
				rt.ArrayItem{ key: 'address_1', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_address', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'address_2', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_address_2', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'city', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_city', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'state', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'postcode', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_postcode', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'country', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) },
			]),
			rt.new_string('\n'),
		]),
	])).str()
}

fn create_automattic_woocommerce_internal_settings_pointofsaledefaultsettings() &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_store_email' {
			return Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings.get_default_store_email()
		}
		'get_default_store_name' {
			return Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings.get_default_store_name()
		}
		'get_default_store_address' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings.get_default_store_address())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_settings_pointofsaledefaultsettings_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
