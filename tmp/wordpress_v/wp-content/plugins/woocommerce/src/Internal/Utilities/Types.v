import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_Types {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Utilities_Types.ensure_instance_of(var_thing rt.PhpVal, desired_type string, mut var_on_failure Class_Automattic_WooCommerce_Internal_Utilities_?callable) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_thing, 'Automattic_WooCommerce_Internal_Utilities_{"nodeType":"Expr_Variable","line":35,"name":"desired_type"}'))) {
		return var_thing.dup()
	}
	mut var_summary := rt.call_function('sprintf', [rt.new_string('Object was not of expected type %1$s.'), rt.new_string(desired_type)])
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.is_true(var_logger) {
		rt.call_method(var_logger, 'error', [var_summary.dup(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-type-check-utility' }, rt.ArrayItem{ key: 'backtrace', val: true }])])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.call_callable(var_on_failure, [var_thing.dup(), rt.new_string(desired_type)])
	}
	rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('esc_html', [var_summary.dup()]))))
	return rt.new_null()
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_types() &Class_Automattic_WooCommerce_Internal_Utilities_Types {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Types{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Types) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'ensure_instance_of' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_?callable](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Utilities_Types.ensure_instance_of(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Types) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Types) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_types_php() {
	// unsupported statement: Stmt_Declare
}
