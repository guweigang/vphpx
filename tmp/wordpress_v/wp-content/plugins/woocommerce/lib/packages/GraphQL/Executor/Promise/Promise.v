import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	rt.PhpObjectBase
pub mut:
		adoptedPromise rt.PhpVal = rt.new_null()
		adapter rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) construct(var_adoptedPromise rt.PhpVal, mut var_adapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter)  {
	if rt.is_true(rt.new_bool(rt.instance_of(var_adoptedPromise, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_self'))) {
		mut var_selfClass := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise.class()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Expected promise from adapted system, got ${var_selfClass.to_string()}."))))
	}
	this.adoptedPromise = var_adoptedPromise.dup()
	this.adapter = var_adapter.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) then(mut var_onFulfilled Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_?callable, mut var_onRejected Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_?callable) rt.PhpVal {
	return rt.call_method(this.adapter, 'then', [rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, &this), var_onFulfilled, var_onRejected])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_promise(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise{
		PhpObjectBase: rt.PhpObjectBase{}
		adoptedPromise: rt.new_null()
		adapter: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'then' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_?callable](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.then(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'adoptedPromise' { return this.adoptedPromise }
		'adapter' { return this.adapter }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'adoptedPromise' { this.adoptedPromise = val; return true }
		'adapter' { this.adapter = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_promise_promise_php() {
	// unsupported statement: Stmt_Declare
}
