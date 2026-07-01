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
pub mut:
		enableWarnings rt.PhpVal = rt.new_null()
		warned rt.PhpVal = rt.new_array()
		warningHandler rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.setwarninghandler(mut var_warningHandler Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?callable)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.suppress(suppress bool)  {
	if rt.is_true(rt.identical(rt.new_bool(suppress), rt.new_bool(true))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	} else if rt.is_true(rt.identical(rt.new_bool(suppress), rt.new_bool(false))) {
		// unsupported assign target: Expr_StaticPropertyFetch
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(rt.new_bool(suppress).is_long())) {
		// unsupported expression: Expr_AssignOp_BitwiseAnd
	} else {
		mut var_type := rt.call_function('gettype', [rt.new_bool(suppress)])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException', []string{}, create_automattic_woocommerce_vendor_graphql_error_invalidargumentexception(rt.new_string("Expected type bool|int, got ${var_type.to_string()}."))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.enable(enable bool)  {
	if rt.is_true(rt.identical(rt.new_bool(enable), rt.new_bool(true))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	} else if rt.is_true(rt.identical(rt.new_bool(enable), rt.new_bool(false))) {
		// unsupported assign target: Expr_StaticPropertyFetch
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(rt.new_bool(enable).is_long())) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else {
		mut var_type := rt.call_function('gettype', [rt.new_bool(enable)])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException', []string{}, create_automattic_woocommerce_vendor_graphql_error_invalidargumentexception(rt.new_string("Expected type bool|int, got ${var_type.to_string()}."))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warnonce(errorMessage string, warningId i64, mut var_messageLevel Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?int)  {
	// unsupported expression: Expr_AssignOp_Coalesce
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_callable(// unsupported expression: Expr_StaticPropertyFetch, [rt.new_string(errorMessage), rt.new_int(warningId), var_messageLevel])
	} else if rt.bitwise_and(// unsupported expression: Expr_StaticPropertyFetch, rt.new_int(warningId)) > 0 && !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_int(warningId))) {
		// unsupported expression: Expr_StaticPropertyFetch.array_set(warningId, true)
		rt.call_function('trigger_error', [rt.new_string(errorMessage), var_messageLevel])
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warn(errorMessage string, warningId i64, mut var_messageLevel Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?int)  {
	// unsupported expression: Expr_AssignOp_Coalesce
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_callable(// unsupported expression: Expr_StaticPropertyFetch, [rt.new_string(errorMessage), rt.new_int(warningId), var_messageLevel])
	} else if rt.bitwise_and(// unsupported expression: Expr_StaticPropertyFetch, rt.new_int(warningId)) > 0 {
		rt.call_function('trigger_error', [rt.new_string(errorMessage), var_messageLevel])
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_error_warning() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning{
		PhpObjectBase: rt.PhpObjectBase{}
		enableWarnings: rt.new_null()
		warned: rt.new_array()
		warningHandler: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invalidargumentexception() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvalidArgumentException {
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
	match prop_name {
		'enableWarnings' { return this.enableWarnings }
		'warned' { return this.warned }
		'warningHandler' { return this.warningHandler }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'enableWarnings' { this.enableWarnings = val; return true }
		'warned' { this.warned = val; return true }
		'warningHandler' { this.warningHandler = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_error_warning_php() {
	// unsupported statement: Stmt_Declare
}
