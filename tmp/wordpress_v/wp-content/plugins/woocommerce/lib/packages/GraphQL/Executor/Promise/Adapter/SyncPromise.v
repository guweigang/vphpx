import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.pending() i64 {
	return 0
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.fulfilled() i64 {
	return 1
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.rejected() i64 {
	return 2
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise {
	rt.PhpObjectBase
pub mut:
		state rt.PhpVal = rt.new_null()
		result rt.PhpVal = rt.new_null()
		waiting rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.runqueue()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{}; return temp.run() }()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.getqueue() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{}; return temp.queue() }()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) resolve(var_value rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := this.state
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.pending())) {
		if rt.is_true(rt.identical(var_value, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise', []string{}, &this))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_exception(rt.new_string('Cannot resolve promise with self.'))))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_value.dup(), rt.new_string('then')])))) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_resolvedValue := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.resolve(var_resolvedValue.dup())
	return rt.new_null()
	}
	mut var_reason := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.reject(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable](var_reason))
	return rt.new_null()
	}
			rt.call_method(var_value, 'then', [rt.new_closure(closure_1_fn), rt.new_closure(closure_2_fn)])
			return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise', []string{}, this)
		}
		this.state = Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.fulfilled()
		this.result = var_value.dup()
		this.enqueuewaitingpromises()
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.fulfilled())) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_exception(rt.new_string('Cannot change value of fulfilled promise.'))))
		}
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.rejected())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_exception(rt.new_string('Cannot resolve rejected promise.'))))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) reject(mut var_reason Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable) rt.PhpVal {
	mut switch_val_2 := this.state
	if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.pending())) {
		this.state = Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.rejected()
		this.result = var_reason.dup()
		this.enqueuewaitingpromises()
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.rejected())) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_exception(rt.new_string('Cannot change rejection reason.'))))
		}
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.fulfilled())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_exception(rt.new_string('Cannot reject fulfilled promise.'))))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) then(mut var_onFulfilled Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable, mut var_onRejected Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.state, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.rejected())) && rt.is_true(rt.identical(var_onRejected, rt.new_null())))) {
		return mut this
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.state, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.fulfilled())) && rt.is_true(rt.identical(var_onFulfilled, rt.new_null())))) {
		return mut this
	}
	mut var_child := create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_self()
	this.waiting.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_child }, rt.ArrayItem{ key: none, val: var_onFulfilled }, rt.ArrayItem{ key: none, val: var_onRejected }]))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.enqueuewaitingpromises()
	}
	return mut var_child
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) enqueuewaitingpromises()  {
	if rt.is_true(rt.identical(this.state, Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.pending())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Cannot enqueue derived promises when parent is still pending.'))))
	}
	mut var_waiting := this.waiting
	if rt.is_true(rt.identical(var_waiting, rt.new_array())) {
		return rt.new_null()
	}
	this.waiting = rt.new_array()
	mut var_result := this.result
	closure_3_fn := fn [var_waiting, var_result] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_onRejected := rt.new_null()
	mut var_child := rt.new_null()
	mut var_onFulfilled := rt.new_null()
	{
		mut iter_1 := var_waiting.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_ := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_result, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable'))) {
				if rt.is_true(rt.identical(var_onRejected, rt.new_null())) {
					var_child.reject(var_result.dup())
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				} else {
					var_child.resolve(rt.call_callable(var_onRejected, [var_result.dup()]))
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			} else {
				var_child.resolve(if rt.is_true(rt.identical(var_onFulfilled, rt.new_null())) { var_result } else { rt.call_callable(var_onFulfilled, [var_result.dup()]) })
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
				mut var_e := var_e_1.dup()
				var_child.reject(var_e.dup())
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	return rt.new_null()
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{}; return temp.enqueue(arg_0) }(rt.new_closure(closure_3_fn))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromise() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise{
		PhpObjectBase: rt.PhpObjectBase{}
		state: rt.new_null()
		result: rt.new_null()
		waiting: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromisequeue() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_exception() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_self() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'runQueue' {
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.runqueue()
			return rt.new_null()
		}
		'getQueue' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.getqueue()
		}
		'resolve' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.resolve(dispatch_arg_0)
		}
		'reject' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.reject(mut dispatch_arg_0)
		}
		'then' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.then(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'enqueueWaitingPromises' {
			this.enqueuewaitingpromises()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'state' { return this.state }
		'result' { return this.result }
		'waiting' { return this.waiting }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'state' { this.state = val; return true }
		'result' { this.result = val; return true }
		'waiting' { this.waiting = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_promise_adapter_syncpromise_php() {
	// unsupported statement: Stmt_Declare
}
