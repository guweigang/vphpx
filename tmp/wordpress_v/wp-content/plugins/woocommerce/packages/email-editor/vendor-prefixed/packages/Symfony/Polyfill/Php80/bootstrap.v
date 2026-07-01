import rt

fn fdiv(num1 f64, num2 f64) f64 {
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{}
		return temp.fdiv(arg_0, arg_1)
	}(rt.new_float(num1), rt.new_float(num2))).to_f64()
}

fn preg_last_error_msg() string {
	return (fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{}
		return temp.preg_last_error_msg()
	}()).str()
}

fn str_contains(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{}
		return temp.str_contains(arg_0, arg_1)
	}(if !var_haystack.is_null() { var_haystack } else { rt.new_string('') }, if !var_needle.is_null() {
		var_needle
	} else {
		rt.new_string('')
	})).to_bool()
}

fn str_starts_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{}
		return temp.str_starts_with(arg_0, arg_1)
	}(if !var_haystack.is_null() { var_haystack } else { rt.new_string('') }, if !var_needle.is_null() {
		var_needle
	} else {
		rt.new_string('')
	})).to_bool()
}

fn str_ends_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{}
		return temp.str_ends_with(arg_0, arg_1)
	}(if !var_haystack.is_null() { var_haystack } else { rt.new_string('') }, if !var_needle.is_null() {
		var_needle
	} else {
		rt.new_string('')
	})).to_bool()
}

fn get_debug_type(var_value rt.PhpVal) string {
	return (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{}
		return temp.get_debug_type(arg_0)
	}(var_value.dup())).str()
}

fn get_resource_id(var_resource rt.PhpVal) i64 {
	return (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{}
		return temp.get_resource_id(arg_0)
	}(var_resource.dup())).to_i64()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80 {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_polyfill_php80_php80() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80 {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Polyfill_Php80_Php80) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_polyfill_php80_bootstrap_php() {
	if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FILTER_VALIDATE_BOOL')])))))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('FILTER_VALIDATE_BOOLEAN')]))))
	{
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
