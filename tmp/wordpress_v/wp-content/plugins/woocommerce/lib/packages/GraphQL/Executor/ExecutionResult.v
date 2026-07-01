import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_null()
		errors rt.PhpVal = rt.new_array()
		extensions rt.PhpVal = rt.new_null()
		errorFormatter rt.PhpVal = rt.new_null()
		errorsHandler rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) construct(mut var_data Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_errors Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_extensions Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array)  {
	this.data = var_data.dup()
	this.errors = var_errors.dup()
	this.extensions = var_extensions.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) seterrorformatter(mut var_errorFormatter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable) rt.PhpVal {
	this.errorFormatter = var_errorFormatter.dup()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) seterrorshandler(mut var_errorsHandler Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable) rt.PhpVal {
	mut var_errorsHandler_mutated := var_errorsHandler
	this.errorsHandler = var_errorsHandler_mutated.dup()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) jsonserialize() rt.PhpVal {
	return this.toarray(0)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) toarray(debug i64) rt.PhpVal {
	mut var_formatter := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_result := rt.new_array()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_errors := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_formatter := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return rt.call_function('array_map', [var_formatter.dup(), var_errors])
	}
		mut var_errorsHandler := if !(this.errorsHandler).is_null() { this.errorsHandler } else { rt.new_closure(closure_1_fn) }
		mut var_handledErrors := rt.call_callable(var_errorsHandler, [this.errors, fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{}; return temp.prepareformatter(arg_0, arg_1) }(this.errorFormatter, rt.new_int(debug))])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_result.array_set('errors', var_handledErrors.dup())
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_result.array_set('data', this.data)
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_result.array_set('extensions', this.extensions)
	}
	return var_result.dup()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_executionresult(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_null()
		errors: rt.new_array()
		extensions: rt.new_null()
		errorFormatter: rt.new_null()
		errorsHandler: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_formattederror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'setErrorFormatter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.seterrorformatter(mut dispatch_arg_0)
		}
		'setErrorsHandler' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.seterrorshandler(mut dispatch_arg_0)
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		'toArray' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.toarray(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'errors' { return this.errors }
		'extensions' { return this.extensions }
		'errorFormatter' { return this.errorFormatter }
		'errorsHandler' { return this.errorsHandler }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'errors' { this.errors = val; return true }
		'extensions' { this.extensions = val; return true }
		'errorFormatter' { this.errorFormatter = val; return true }
		'errorsHandler' { this.errorsHandler = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_executionresult_php() {
	// unsupported statement: Stmt_Declare
}
