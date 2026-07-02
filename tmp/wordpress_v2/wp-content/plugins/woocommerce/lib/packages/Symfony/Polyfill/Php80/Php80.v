import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80 {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.fdiv(dividend f64, divisor f64) f64 {
	return (dividend / divisor).to_f64()
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.get_debug_type(var_value rt.PhpVal) string {
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.identical(rt.new_null(), var_value))) {
		return 'null'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(var_value.clone().is_bool()))) {
		return 'bool'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(var_value.clone().is_string()))) {
		return 'string'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(var_value.clone().is_array()))) {
		return 'array'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(var_value.clone().is_long()))) {
		return 'int'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(var_value.clone().is_double()))) {
		return 'float'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(var_value.clone().is_object()))) {
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_value,
		'Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80___PHP_Incomplete_Class'))))
	{
		return '__PHP_Incomplete_Class'
	} else {
		mut var_type := rt.call_function('get_resource_type', [
			var_value.clone()])
		if rt.is_true(rt.identical(rt.new_null(), var_type)) {
			return 'unknown'
		}
		if rt.is_true(rt.identical(rt.new_string('Unknown'), var_type)) {
			var_type = rt.new_string('closed')
		}
		return 'resource (${var_type.to_string()})'
	}
	mut var_class := rt.call_function('get_class', [var_value.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		var_class.clone(),
		rt.new_string('@'),
	])))
	{
		return var_class.str()
	}
	return (if rt.is_true(if rt.is_true(rt.call_function('get_parent_class', [var_class.clone()])) { rt.call_function('get_parent_class', [var_class.clone()]) } else { rt.call_function('key', [rt.call_function('class_implements', [var_class.clone()])]) }) {
		if rt.is_true(rt.call_function('get_parent_class', [var_class.clone()])) {
			rt.call_function('get_parent_class', [var_class.clone()])
		} else {
			rt.call_function('key', [rt.call_function('class_implements', [var_class.clone()])])
		}
	} else {
		rt.new_string('class')
	}).str() + '@anonymous'
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.get_resource_id(var_res rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_res.clone()])))))
		&& rt.is_true(rt.identical(rt.new_null(), rt.call_function('get_resource_type', [var_res.clone()]))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_TypeError',
			[]string{}, create_automattic_woocommerce_vendor_symfony_polyfill_php80_typeerror(rt.call_function('sprintf', [
			rt.new_string('Argument 1 passed to get_resource_id() must be of the type resource, %s given'),
			rt.call_function('get_debug_type', [var_res.clone()]),
		]))))
	}
	return rt.new_int(var_res.to_i64())
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.preg_last_error_msg() string {
	mut switch_val_2 := rt.call_function('preg_last_error', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_2, rt.get_constant('PREG_INTERNAL_ERROR'))) {
		return 'Internal error'
	} else if rt.is_true(rt.equal(switch_val_2, rt.get_constant('PREG_BAD_UTF8_ERROR'))) {
		return 'Malformed UTF-8 characters, possibly incorrectly encoded'
	} else if rt.is_true(rt.equal(switch_val_2, rt.get_constant('PREG_BAD_UTF8_OFFSET_ERROR'))) {
		return 'The offset did not correspond to the beginning of a valid UTF-8 code point'
	} else if rt.is_true(rt.equal(switch_val_2, rt.get_constant('PREG_BACKTRACK_LIMIT_ERROR'))) {
		return 'Backtrack limit exhausted'
	} else if rt.is_true(rt.equal(switch_val_2, rt.get_constant('PREG_RECURSION_LIMIT_ERROR'))) {
		return 'Recursion limit exhausted'
	} else if rt.is_true(rt.equal(switch_val_2, rt.get_constant('PREG_JIT_STACKLIMIT_ERROR'))) {
		return 'JIT stack limit exhausted'
	} else if rt.is_true(rt.equal(switch_val_2, rt.get_constant('PREG_NO_ERROR'))) {
		return 'No error'
	} else {
		return 'Unknown error'
	}
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.str_contains(haystack string, needle string) bool {
	return rt.is_true(rt.identical(rt.new_string(''), rt.new_string(needle)))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(haystack), rt.new_string(needle)])))))
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.str_starts_with(haystack string, needle string) bool {
	return (rt.identical(rt.new_int(0), rt.call_function('strncmp', [
		rt.new_string(haystack),
		rt.new_string(needle),
		rt.new_int(needle.len),
	]))).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.str_ends_with(haystack string, needle string) bool {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(needle)))
		|| rt.is_true(rt.identical(rt.new_string(needle), rt.new_string(haystack))) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(haystack))) {
		return false
	}
	mut var_needleLength := rt.new_int(needle.len)
	return rt.is_true(rt.less_equal(var_needleLength, rt.new_int(haystack.len)))
		&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(haystack), rt.new_string(needle), rt.sub(rt.new_int(0), var_needleLength)])))
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_TypeError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_polyfill_php80_php80(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80 {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_polyfill_php80_typeerror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_TypeError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fdiv' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			return rt.new_float(Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.fdiv(dispatch_arg_0,
				dispatch_arg_1))
		}
		'get_debug_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.get_debug_type(dispatch_arg_0))
		}
		'get_resource_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.get_resource_id(dispatch_arg_0))
		}
		'preg_last_error_msg' {
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.preg_last_error_msg())
		}
		'str_contains' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.str_contains(dispatch_arg_0,
				dispatch_arg_1))
		}
		'str_starts_with' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.str_starts_with(dispatch_arg_0,
				dispatch_arg_1))
		}
		'str_ends_with' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80.str_ends_with(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_Php80) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
