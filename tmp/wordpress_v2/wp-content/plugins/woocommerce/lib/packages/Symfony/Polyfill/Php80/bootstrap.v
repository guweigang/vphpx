import rt

fn fdiv(num1 f64, num2 f64) f64 {
	mut var_num1 := num1
	mut var_num2 := num2
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{}
	mut iife_result_0 := iife_temp_0.fdiv(rt.new_float(num1), rt.new_float(num2))
	return iife_result_0.to_f64()
}

fn preg_last_error_msg() string {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{}
	mut iife_result_1 := iife_temp_1.preg_last_error_msg()
	return iife_result_1.str()
}

fn str_contains(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{}
	mut iife_result_2 := iife_temp_2.str_contains(if !var_haystack.is_null() {
		var_haystack
	} else {
		rt.new_string('')
	}, if !var_needle.is_null() { var_needle } else { rt.new_string('') })
	return iife_result_2.to_bool()
}

fn str_starts_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{}
	mut iife_result_3 := iife_temp_3.str_starts_with(if !var_haystack.is_null() {
		var_haystack
	} else {
		rt.new_string('')
	}, if !var_needle.is_null() { var_needle } else { rt.new_string('') })
	return iife_result_3.to_bool()
}

fn str_ends_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{}
	mut iife_result_4 := iife_temp_4.str_ends_with(if !var_haystack.is_null() {
		var_haystack
	} else {
		rt.new_string('')
	}, if !var_needle.is_null() { var_needle } else { rt.new_string('') })
	return iife_result_4.to_bool()
}

fn get_debug_type(var_value rt.PhpVal) string {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{}
	mut iife_result_5 := iife_temp_5.get_debug_type(var_value.clone())
	return iife_result_5.str()
}

fn get_resource_id(var_resource rt.PhpVal) i64 {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{}
	mut iife_result_6 := iife_temp_6.get_resource_id(var_resource.clone())
	return iife_result_6.to_i64()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80 {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_polyfill_php80_php80(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80 {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FILTER_VALIDATE_BOOL')])))))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('FILTER_VALIDATE_BOOLEAN')])) {
		rt.call_function('define', [rt.new_string('FILTER_VALIDATE_BOOL'),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('fdiv'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('preg_last_error_msg'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('str_contains'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('str_starts_with'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('str_ends_with'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_debug_type'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_resource_id'),
	])))))
	{
	}
}
