import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred {
	rt.PhpObjectBase
pub mut:
		executor rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred) construct(mut var_executor Class_Automattic_WooCommerce_Vendor_GraphQL_callable)  {
	this.executor = var_executor.dup()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_executor := this.executor
	rt.call_function('assert', [// unsupported expression: Expr_BinaryOp_NotIdentical, rt.new_string('Always set in constructor, this callback runs only once.')])
	this.executor = rt.new_null()
	this.resolve(rt.call_callable(var_executor, []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Throwable') {
		mut var_e := var_e_1.dup()
		this.reject(var_e.dup())
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{}; return temp.enqueue(arg_0) }(rt.new_closure(closure_1_fn))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred.create(mut var_executor Class_Automattic_WooCommerce_Vendor_GraphQL_callable) rt.PhpVal {
	return create_automattic_woocommerce_vendor_graphql_self(var_executor.dup())
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_self {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_deferred(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred{
		PhpObjectBase: rt.PhpObjectBase{}
		executor: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromise() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromisequeue() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_self() &Class_Automattic_WooCommerce_Vendor_GraphQL_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred.create(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'executor' { return this.executor }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'executor' { this.executor = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_deferred_php() {
	// unsupported statement: Stmt_Declare
}
