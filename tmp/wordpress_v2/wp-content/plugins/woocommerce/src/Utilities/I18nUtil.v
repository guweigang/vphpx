import rt

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_utilities_i18nutil() {
	rt.init_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units', rt.new_null())
}

fn Class_Automattic_WooCommerce_Utilities_I18nUtil.get_weight_unit_label(var_weight_unit rt.PhpVal) rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units')) {
		rt.set_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units', rt.include_file(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/i18n/units.php', '1'))
	}
	mut var_label := var_weight_unit
	if !(!rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units').array_get(rt.new_string('weight')).array_get(var_weight_unit))) {
		var_label =
			rt.get_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units').array_get(rt.new_string('weight')).array_get(var_weight_unit)
	}
	return var_label.clone()
}

fn Class_Automattic_WooCommerce_Utilities_I18nUtil.get_dimensions_unit_label(var_dimensions_unit rt.PhpVal) rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units')) {
		rt.set_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units', rt.include_file(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/i18n/units.php', '1'))
	}
	mut var_label := var_dimensions_unit
	if !(!rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units').array_get(rt.new_string('dimensions')).array_get(var_dimensions_unit))) {
		var_label =
			rt.get_static_prop('Automattic_WooCommerce_Utilities_I18nUtil', 'units').array_get(rt.new_string('dimensions')).array_get(var_dimensions_unit)
	}
	return var_label.clone()
}

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_weight_unit_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_I18nUtil.get_weight_unit_label(dispatch_arg_0)
		}
		'get_dimensions_unit_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_I18nUtil.get_dimensions_unit_label(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
