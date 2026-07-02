import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper.bool_string(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_bool())) {
		return if rt.is_true(var_value_mutated) { 'true' } else { 'false' }
	}
	if rt.is_true(rt.call_function('is_scalar', [var_value_mutated.clone()]))
		|| rt.is_true(rt.identical(rt.new_null(), var_value_mutated)) {
		var_value_mutated = rt.new_string(var_value_mutated.str().to_lower())
	} else {
		var_value_mutated = rt.new_string('')
	}
	return if rt.is_true(rt.identical(rt.new_string('true'), var_value_mutated))
		|| rt.is_true(rt.identical(rt.new_string('1'), var_value_mutated))
		|| rt.is_true(rt.identical(rt.new_string('yes'), var_value_mutated)) {
		'true'
	} else {
		'false'
	}
}

fn Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper.truncate(text string, max_length i64) string {
	if rt.is_true(rt.greater(rt.call_function('mb_strlen', [rt.new_string(text)]),
		rt.new_int(max_length)))
	{
		return (rt.call_function('mb_substr', [rt.new_string(text),
			rt.new_int(0), rt.new_int(max_length)])).str()
	}
	return text
}

fn create_automattic_woocommerce_internal_productfeed_utils_stringhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'bool_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper.bool_string(dispatch_arg_0))
		}
		'truncate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper.truncate(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_StringHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
