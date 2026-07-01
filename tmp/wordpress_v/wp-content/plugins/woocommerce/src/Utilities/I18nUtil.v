import rt

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
pub mut:
		units rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Utilities_I18nUtil.get_weight_unit_label(var_weight_unit rt.PhpVal) rt.PhpVal {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	mut var_label := var_weight_unit
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch.array_get('weight').array_get(var_weight_unit))) {
		var_label = // unsupported expression: Expr_StaticPropertyFetch.array_get('weight').array_get(var_weight_unit)
	}
	return var_label.dup()
}

fn Class_Automattic_WooCommerce_Utilities_I18nUtil.get_dimensions_unit_label(var_dimensions_unit rt.PhpVal) rt.PhpVal {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	mut var_label := var_dimensions_unit
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch.array_get('dimensions').array_get(var_dimensions_unit))) {
		var_label = // unsupported expression: Expr_StaticPropertyFetch.array_get('dimensions').array_get(var_dimensions_unit)
	}
	return var_label.dup()
}

fn create_automattic_woocommerce_utilities_i18nutil() &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
		units: rt.new_null()
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'units' { return this.units }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'units' { this.units = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_utilities_i18nutil_php() {
}
