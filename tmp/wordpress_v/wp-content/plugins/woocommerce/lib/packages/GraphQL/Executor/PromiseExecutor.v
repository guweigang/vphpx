import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor {
	rt.PhpObjectBase
pub mut:
	result rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) construct(mut var_result Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) {
	this.result = var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) doexecute() rt.PhpVal {
	return this.result
}

fn create_automattic_woocommerce_vendor_graphql_executor_promiseexecutor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor{
		PhpObjectBase: rt.PhpObjectBase{}
		result:        rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'doExecute' {
			return this.doexecute()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'result' { return this.result }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'result' {
			this.result = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_promiseexecutor_php() {
	// unsupported statement: Stmt_Declare
}
