import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) isthenable(var_value rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(var_value, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) convertthenable(var_thenable rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_thenable, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise')))))) {
		mut var_deferredClass := Class_Automattic_WooCommerce_Vendor_GraphQL_Deferred.class()
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.printsafe(var_thenable.clone())
		mut var_safeThenable := iife_result_0
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Expected instance of ${var_deferredClass.to_string()}, got ${var_safeThenable.to_string()}."))))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_thenable.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) then(mut var_promise Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise, mut var_onFulfilled Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable, mut var_onRejected Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable) rt.PhpVal {
	mut var_syncPromise := rt.get_property(var_promise, 'adoptedPromise')
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_syncPromise, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise'))])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(rt.call_method(var_syncPromise, 'then', [var_onFulfilled, var_onRejected]), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) create(mut var_resolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable) rt.PhpVal {
	mut var_syncPromise := create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromise()
	rt.call_callable(var_resolver, [rt.create_array([rt.ArrayItem{ key: none, val: var_syncPromise }, rt.ArrayItem{ key: none, val: 'resolve' }]), rt.create_array([rt.ArrayItem{ key: none, val: var_syncPromise }, rt.ArrayItem{ key: none, val: 'reject' }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
		mut var_e := var_e_1.clone()
		rt.call_method(var_syncPromise, 'reject', [var_e.clone()])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_syncPromise.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) createfulfilled(var_value rt.PhpVal) rt.PhpVal {
	mut var_syncPromise := create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromise()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(rt.call_method(var_syncPromise, 'resolve', [var_value.clone()]), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) createrejected(mut var_reason Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable) rt.PhpVal {
	mut var_syncPromise := create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromise()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(rt.call_method(var_syncPromise, 'reject', [var_reason]), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) all(mut var_promisesOrValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_iterable) rt.PhpVal {
	mut var_all := create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromise()
	mut var_total := if var_promisesOrValues.is_array() { rt.new_int(var_promisesOrValues.array_count()) } else { rt.call_function('iterator_count', [var_promisesOrValues]) }
	mut var_count := rt.new_int(0)
	mut var_result := rt.new_array()
	closure_2_fn := fn [mut var_count, mut var_total, var_all, mut var_result] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.identical(var_count, var_total)) {
			var_all.resolve(var_result.clone())
		}
		return rt.new_null()
		}
	mut var_resolveAllWhenFinished := rt.new_closure(closure_2_fn)
	mut iter_1 := var_promisesOrValues.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_promiseOrValue := item_1.val
		mut var_index := item_1.key
		if rt.is_true(rt.new_bool(rt.instance_of(var_promiseOrValue, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
			var_result.array_set(var_index, rt.new_null())
			closure_3_fn := fn [mut var_result, var_index, mut var_count, mut var_resolveAllWhenFinished] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				var_result.array_set(var_index, var_value.clone())
				rt.pre_inc(var_count)
				rt.call_callable(var_resolveAllWhenFinished, []rt.PhpVal{})
				return rt.new_null()
				}
			rt.call_method(var_promiseOrValue, 'then', [rt.new_closure(closure_3_fn), rt.create_array([rt.ArrayItem{ key: none, val: var_all }, rt.ArrayItem{ key: none, val: 'reject' }])])
			continue
		}
		var_result.array_set(var_index, var_promiseOrValue.clone())
		rt.pre_inc(var_count)
	}
	rt.call_callable(var_resolveAllWhenFinished, []rt.PhpVal{})
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_all, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) wait(mut var_promise Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) rt.PhpVal {
	this.beforewait(mut var_promise)
	mut var_syncPromise := rt.get_property(var_promise, 'adoptedPromise')
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_syncPromise, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise'))])
	for rt.is_true(rt.identical(rt.get_property(var_syncPromise, 'state'), Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.pending())) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{}
		mut iife_result_3 := iife_temp_3.run()
		this.onwait(mut var_promise)
	}
	if rt.is_true(rt.identical(rt.get_property(var_syncPromise, 'state'), Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.fulfilled())) {
		return rt.get_property(var_syncPromise, 'result')
	}
	if rt.is_true(rt.identical(rt.get_property(var_syncPromise, 'state'), Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise.rejected())) {
		rt.throw_exception(rt.get_property(var_syncPromise, 'result'))
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Could not resolve promise.'))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) beforewait(mut var_promise Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) onwait(mut var_promise Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) {
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromiseadapter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_promise(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromise(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromise{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromisequeue(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseQueue{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isThenable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.isthenable(dispatch_arg_0))
		}
		'convertThenable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.convertthenable(dispatch_arg_0)
		}
		'then' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.then(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create(mut dispatch_arg_0)
		}
		'createFulfilled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.createfulfilled(dispatch_arg_0)
		}
		'createRejected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.createrejected(mut dispatch_arg_0)
		}
		'all' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_iterable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.all(mut dispatch_arg_0)
		}
		'wait' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.wait(mut dispatch_arg_0)
		}
		'beforeWait' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise](if args.len > 0 { args[0] } else { rt.new_null() })
			this.beforewait(mut dispatch_arg_0)
			return rt.new_null()
		}
		'onWait' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise](if args.len > 0 { args[0] } else { rt.new_null() })
			this.onwait(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
