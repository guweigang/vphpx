import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils.get_product_availability(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_availability := rt.create_array([
		rt.ArrayItem{ key: 'availability', val: '' },
		rt.ArrayItem{ key: 'class', val: '' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return var_product_availability.clone()
	}
	var_product_availability = rt.call_method(var_product, 'get_availability', []rt.PhpVal{})
	if var_product_availability.array_isset(rt.new_string('class'))
		&& rt.is_true(rt.identical(rt.new_string('in-stock'), var_product_availability.array_get(rt.new_string('class'))))
		|| rt.is_true(rt.identical(rt.new_string('available-on-backorder'), var_product_availability.array_get(rt.new_string('class'))))
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product,
			'has_purchasable_variations', []rt.PhpVal{})))))
		{
			var_product_availability.array_set('availability', rt.call_function('__', [
				rt.new_string('Out of stock'),
				rt.new_string('woocommerce'),
			]))
			var_product_availability.array_set('class', 'out-of-stock')
		}
	}
	return var_product_availability.clone()
}

fn create_automattic_woocommerce_blocks_utils_productavailabilityutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_product_availability' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils.get_product_availability(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
