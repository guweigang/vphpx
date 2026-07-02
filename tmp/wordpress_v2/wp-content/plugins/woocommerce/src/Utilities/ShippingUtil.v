import rt

struct Class_Automattic_WooCommerce_Utilities_ShippingUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_ShippingUtil.get_selected_shipping_rates_from_packages(var_packages rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_package := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_selected_rate_id := rt.call_function('wc_get_chosen_shipping_method_for_package', [
			var_package_id.clone(),
			var_package.clone(),
		])
		mut var_selected_rate := if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate_id))))
			&& var_package.array_get(rt.new_string('rates')).array_isset(var_selected_rate_id) {
			var_package.array_get(rt.new_string('rates')).array_get(var_selected_rate_id)
		} else {
			rt.new_null()
		}
		return if rt.is_true(rt.new_bool(rt.instance_of(var_selected_rate,
			'Automattic_WooCommerce_Utilities_WC_Shipping_Rate')))
		{
			var_selected_rate
		} else {
			rt.new_null()
		}
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_package := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_selected_rate_id := rt.call_function('wc_get_chosen_shipping_method_for_package', [
			var_package_id.clone(),
			var_package.clone(),
		])
		mut var_selected_rate := if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate_id))))
			&& var_package.array_get(rt.new_string('rates')).array_isset(var_selected_rate_id) {
			var_package.array_get(rt.new_string('rates')).array_get(var_selected_rate_id)
		} else {
			rt.new_null()
		}
		return if rt.is_true(rt.new_bool(rt.instance_of(var_selected_rate,
			'Automattic_WooCommerce_Utilities_WC_Shipping_Rate')))
		{
			var_selected_rate
		} else {
			rt.new_null()
		}
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_package := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_selected_rate_id := rt.call_function('wc_get_chosen_shipping_method_for_package', [
			var_package_id.clone(),
			var_package.clone(),
		])
		mut var_selected_rate := if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate_id))))
			&& var_package.array_get(rt.new_string('rates')).array_isset(var_selected_rate_id) {
			var_package.array_get(rt.new_string('rates')).array_get(var_selected_rate_id)
		} else {
			rt.new_null()
		}
		return if rt.is_true(rt.new_bool(rt.instance_of(var_selected_rate,
			'Automattic_WooCommerce_Utilities_WC_Shipping_Rate')))
		{
			var_selected_rate
		} else {
			rt.new_null()
		}
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_package := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_selected_rate_id := rt.call_function('wc_get_chosen_shipping_method_for_package', [
			var_package_id.clone(),
			var_package.clone(),
		])
		mut var_selected_rate := if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate_id))))
			&& var_package.array_get(rt.new_string('rates')).array_isset(var_selected_rate_id) {
			var_package.array_get(rt.new_string('rates')).array_get(var_selected_rate_id)
		} else {
			rt.new_null()
		}
		return if rt.is_true(rt.new_bool(rt.instance_of(var_selected_rate,
			'Automattic_WooCommerce_Utilities_WC_Shipping_Rate')))
		{
			var_selected_rate
		} else {
			rt.new_null()
		}
	}
	return rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_closure(closure_1_fn),
			rt.func_array_keys(var_packages.clone()),
			rt.call_function('array_values', [
				var_packages.clone(),
			])]),
	])
}

fn create_automattic_woocommerce_utilities_shippingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ShippingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ShippingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_selected_shipping_rates_from_packages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_ShippingUtil.get_selected_shipping_rates_from_packages(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
