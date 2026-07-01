import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) isthenable(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	return (rt.new_bool(rt.instance_of(var_value_mutated, 'Amp_Future'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) convertthenable(var_thenable rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_thenable.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) then(mut var_promise Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise, mut var_onFulfilled Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable, mut var_onRejected Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable) rt.PhpVal {
	mut var_future := rt.get_property(var_promise, 'adoptedPromise')
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_future, 'Amp_Future'))])
	closure_2_fn := fn [var_future, var_onFulfilled, var_onRejected] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_future, var_onFulfilled, var_onRejected] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := rt.call_method(var_future, 'await', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
		mut var_reason := var_e_1.dup()
		if rt.is_true(rt.identical(var_onRejected, rt.new_null())) {
			rt.throw_exception(var_reason)
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.unwrapresult(rt.call_callable(var_onRejected, [var_reason.dup()]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(rt.identical(var_onFulfilled, rt.new_null())) {
		return var_value.dup()
	}
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.unwrapresult(rt.call_callable(var_onFulfilled, [var_value.dup()]))
	}
	mut var_value := rt.call_method(var_future, 'await', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
		mut var_reason := var_e_2.dup()
		if rt.is_true(rt.identical(var_onRejected, rt.new_null())) {
			rt.throw_exception(var_reason)
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.unwrapresult(rt.call_callable(var_onRejected, [var_reason.dup()]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	if rt.is_true(rt.identical(var_onFulfilled, rt.new_null())) {
		return var_value.dup()
	}
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.unwrapresult(rt.call_callable(var_onFulfilled, [var_value.dup()]))
	}
	mut var_next := rt.call_function('async', [rt.new_closure(closure_1_fn)])
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_next.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) create(mut var_resolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable) rt.PhpVal {
	mut var_deferred := create_amp_deferredfuture()
	closure_4_fn := fn [var_deferred] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_deferred] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.resolvedeferred(mut rt.new_object('Amp_DeferredFuture', []string{}, var_deferred), var_value.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return rt.new_null()
	}
	mut var_exception := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_deferred.error(var_exception.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return rt.new_null()
	}
	rt.call_callable(var_resolver, [rt.new_closure(closure_3_fn), rt.new_closure(closure_4_fn)])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
		mut var_exception := var_e_3.dup()
		var_deferred.error(var_exception.dup())
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_deferred.getfuture(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) createfulfilled(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		return var_value_mutated.dup()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Amp_Future'))) {
		return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_value_mutated.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter', ['PromiseAdapter'], &this).dup())
	}
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Amp_Future{}; return temp.complete(arg_0) }(var_value_mutated.dup()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) createrejected(mut var_reason Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable) rt.PhpVal {
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Amp_Future{}; return temp.error(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable', []string{}, var_reason)), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) all(mut var_promisesOrValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_iterable) rt.PhpVal {
	mut var_items := if rt.is_true(rt.new_bool(var_promisesOrValues.is_array())) { var_promisesOrValues } else { rt.call_function('iterator_to_array', [var_promisesOrValues]) }
	mut var_futures := rt.new_array()
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
				var_item = rt.get_property(var_item, 'adoptedPromise')
			}
			if rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Amp_Future'))) {
				var_futures.array_set(var_key, var_item.dup())
			}
		}
	}
	closure_6_fn := fn [var_items, var_futures] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_items, var_futures] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(var_futures, rt.new_array())) {
		return var_items.dup()
	}
	mut var_resolved := rt.call_function('await', [var_futures.dup()])
	return rt.call_function('array_replace', [var_items.dup(), var_resolved.dup()])
	}
	if rt.is_true(rt.identical(var_futures, rt.new_array())) {
		return var_items.dup()
	}
	mut var_resolved := rt.call_function('await', [var_futures.dup()])
	return rt.call_function('array_replace', [var_items.dup(), var_resolved.dup()])
	}
	mut var_combined := rt.call_function('async', [rt.new_closure(closure_5_fn)])
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_combined.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter', ['PromiseAdapter'], &this).dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.resolvedeferred(mut var_deferred Class_Amp_DeferredFuture, var_value rt.PhpVal)  {
	mut var_deferred_mutated := var_deferred
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		var_value_mutated = rt.get_property(var_value_mutated, 'adoptedPromise')
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Amp_Future'))) {
		closure_8_fn := fn [var_deferred, var_value] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn [var_deferred, var_value] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	var_deferred_mutated.complete(rt.call_method(var_value_mutated, 'await', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
		mut var_exception := var_e_4.dup()
		var_deferred_mutated.error(var_exception.dup())
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return rt.new_null()
	}
	var_deferred_mutated.complete(rt.call_method(var_value_mutated, 'await', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
		mut var_exception := var_e_5.dup()
		var_deferred_mutated.error(var_exception.dup())
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return rt.new_null()
	}
		rt.call_function('async', [rt.new_closure(closure_7_fn)])
		return rt.new_null()
	}
	var_deferred_mutated.complete(var_value_mutated.dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.unwrapresult(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		var_value_mutated = rt.get_property(var_value_mutated, 'adoptedPromise')
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Amp_Future'))) {
		return rt.call_method(var_value_mutated, 'await', []rt.PhpVal{})
	}
	return var_value_mutated.dup()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	rt.PhpObjectBase
}

struct Class_Amp_DeferredFuture {
	rt.PhpObjectBase
}

struct Class_Amp_Future {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_ampfutureadapter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_promise() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_amp_deferredfuture() &Class_Amp_DeferredFuture {
	mut obj := &Class_Amp_DeferredFuture{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_amp_future() &Class_Amp_Future {
	mut obj := &Class_Amp_Future{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'resolveDeferred' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Amp_DeferredFuture](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.resolvedeferred(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'unwrapResult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter.unwrapresult(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpFutureAdapter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Amp_DeferredFuture) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Amp_DeferredFuture) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Amp_DeferredFuture) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Amp_Future) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Amp_Future) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Amp_Future) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_promise_adapter_ampfutureadapter_php() {
	// unsupported statement: Stmt_Declare
}
