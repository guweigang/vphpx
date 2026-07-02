import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.none() i64 {
	return 0
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warning_assign() i64 {
	return 2
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warning_config() i64 {
	return 4
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warning_full_schema_scan() i64 {
	return 8
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warning_config_deprecation() i64 {
	return 16
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warning_not_a_type() i64 {
	return 32
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.all() i64 {
	return 63
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_vendor_graphql_error_warning() {
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'enableWarnings', Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.all())
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warned', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warningHandler', rt.new_null())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.setwarninghandler(mut var_warningHandler Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?callable) {
	rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warningHandler', var_warningHandler)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.suppress(suppress bool) {
	if rt.is_true(rt.identical(rt.new_bool(suppress), rt.new_bool(true))) {
		rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'enableWarnings', rt.new_int(0))
	} else if rt.is_true(rt.identical(rt.new_bool(suppress), rt.new_bool(false))) {
		rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'enableWarnings', Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.all())
	} else if rt.is_true(rt.new_bool(rt.new_bool(suppress).is_long())) {
		rt.new_null()
	} else {
		mut var_type := rt.call_function('gettype', [rt.new_bool(suppress)])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException', []string{}, create_automattic_woocommerce_vendor_graphql_error_invalidargumentexception(rt.new_string("Expected type bool|int, got ${var_type.to_string()}."))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.enable(enable bool) {
	if rt.is_true(rt.identical(rt.new_bool(enable), rt.new_bool(true))) {
		rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'enableWarnings', Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.all())
	} else if rt.is_true(rt.identical(rt.new_bool(enable), rt.new_bool(false))) {
		rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'enableWarnings', rt.new_int(0))
	} else if rt.is_true(rt.new_bool(rt.new_bool(enable).is_long())) {
		rt.new_null()
	} else {
		mut var_type := rt.call_function('gettype', [rt.new_bool(enable)])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException', []string{}, create_automattic_woocommerce_vendor_graphql_error_invalidargumentexception(rt.new_string("Expected type bool|int, got ${var_type.to_string()}."))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warnonce(errorMessage string, warningId i64, mut var_messageLevel Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?int) {
	rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warningHandler'), rt.new_null())))) {
		rt.call_callable(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warningHandler'), [rt.new_string(errorMessage), rt.new_int(warningId), var_messageLevel])
	} else if rt.bitwise_and(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'enableWarnings'), rt.new_int(warningId)) > 0 && !(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warned').array_isset(rt.new_int(warningId))) {
		rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warned').array_set(warningId, true)
		rt.call_function('trigger_error', [rt.new_string(errorMessage), var_messageLevel])
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warn(errorMessage string, warningId i64, mut var_messageLevel Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?int) {
	rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warningHandler'), rt.new_null())))) {
		rt.call_callable(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'warningHandler'), [rt.new_string(errorMessage), rt.new_int(warningId), var_messageLevel])
	} else if rt.bitwise_and(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Error_Warning', 'enableWarnings'), rt.new_int(warningId)) > 0 {
		rt.call_function('trigger_error', [rt.new_string(errorMessage), var_messageLevel])
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_error_warning(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'setWarningHandler' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.setwarninghandler(mut dispatch_arg_0)
			return rt.new_null()
		}
		'suppress' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.suppress(dispatch_arg_0)
			return rt.new_null()
		}
		'enable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.enable(dispatch_arg_0)
			return rt.new_null()
		}
		'warnOnce' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warnonce(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'warn' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warn(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
