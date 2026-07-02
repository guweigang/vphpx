import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.enqueue(mut var_task Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable) {
	mut var_task_mutated := var_task
	rt.call_method(Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.queue(),
		'enqueue', [var_task_mutated])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.run() {
	mut var_queue :=
		Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.queue()
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_queue, 'isEmpty', []rt.PhpVal{}))))) {
		mut var_task := rt.call_method(var_queue, 'dequeue', []rt.PhpVal{})
		rt.call_callable(var_task, []rt.PhpVal{})
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.isempty() bool {
	return (rt.call_method(Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.queue(),
		'isEmpty', []rt.PhpVal{})).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.count() i64 {
	return (rt.call_method(Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.queue(),
		'count', []rt.PhpVal{})).to_i64()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.queue() rt.PhpVal {
	mut var_queue := rt.new_null()
	return rt.new_null()
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromisequeue(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enqueue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.enqueue(mut dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.run()
			return rt.new_null()
		}
		'isEmpty' {
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.isempty())
		}
		'count' {
			return rt.new_int(Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.count())
		}
		'queue' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue.queue()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
