import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) isthenable(var_value rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(var_value, 'Amp_Promise'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) convertthenable(var_thenable rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_thenable.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) then(mut var_promise Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise, mut var_onFulfilled Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable, mut var_onRejected Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable) rt.PhpVal {
	mut var_promise_mutated := var_promise
	mut var_deferred := create_amp_deferred()
	closure_1_fn := fn [var_onFulfilled, var_onRejected, var_deferred] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_reason := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_value := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_reason, rt.new_null())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter.resolvewithcallable(mut rt.new_object('Amp_Deferred', []string{}, var_deferred), mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable', []string{}, var_onFulfilled), var_value.dup())
	} else if rt.is_true(rt.identical(var_reason, rt.new_null())) {
		var_deferred.resolve(var_value.dup())
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter.resolvewithcallable(mut rt.new_object('Amp_Deferred', []string{}, var_deferred), mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable', []string{}, var_onRejected), var_reason.dup())
	} else {
		var_deferred.fail(var_reason.dup())
	}
	return rt.new_null()
	}
	mut var_onResolve := rt.new_closure(closure_1_fn)
	mut var_ampPromise := rt.get_property(var_promise_mutated, 'adoptedPromise')
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_ampPromise, 'Amp_Promise'))])
	rt.call_method(var_ampPromise, 'onResolve', [var_onResolve.dup()])
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_deferred.promise(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) create(mut var_resolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable) rt.PhpVal {
	mut var_deferred := create_amp_deferred()
	closure_3_fn := fn [var_deferred] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_deferred] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_deferred.resolve(var_value.dup())
	return rt.new_null()
	}
	mut var_exception := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_deferred.fail(var_exception.dup())
	return rt.new_null()
	}
	rt.call_callable(var_resolver, [rt.new_closure(closure_2_fn), rt.new_closure(closure_3_fn)])
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_deferred.promise(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) createfulfilled(var_value rt.PhpVal) rt.PhpVal {
	mut var_promise := create_amp_success(var_value.dup())
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_promise.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) createrejected(mut var_reason Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable) rt.PhpVal {
	mut var_promise := create_amp_failure(var_reason.dup())
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_promise.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter', ['PromiseAdapter'], &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) all(mut var_promisesOrValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_iterable) rt.PhpVal {
	mut var_promises := rt.new_array()
	{
		mut iter_1 := var_promisesOrValues.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
				mut var_ampPromise := rt.get_property(var_item, 'adoptedPromise')
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_ampPromise, 'Amp_Promise'))])
				var_promises.array_set(var_key, var_ampPromise.dup())
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Amp_Promise'))) {
				var_promises.array_set(var_key, var_item.dup())
			}
		}
	}
	mut var_deferred := create_amp_deferred()
	closure_4_fn := fn [var_promisesOrValues, var_deferred] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_reason := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_values := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.identical(var_reason, rt.new_null())) {
		rt.call_function('assert', [rt.new_bool(var_values.dup().is_array()), rt.new_string('Either $reason or $values must be passed')])
		mut var_promisesOrValuesArray := if rt.is_true(rt.new_bool(var_promisesOrValues.is_array())) { var_promisesOrValues } else { rt.call_function('iterator_to_array', [var_promisesOrValues]) }
		mut var_resolvedValues := rt.call_function('array_replace', [var_promisesOrValuesArray.dup(), var_values.dup()])
		var_deferred.resolve(var_resolvedValues.dup())
		return rt.new_null()
	}
	var_deferred.fail(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable', []string{}, var_reason))
	return rt.new_null()
	}
	rt.call_method(rt.call_function('all', [var_promises.dup()]), 'onResolve', [rt.new_closure(closure_4_fn)])
	return create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_deferred.promise(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter', ['PromiseAdapter'], &this).dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter.resolvewithcallable(mut var_deferred Class_Amp_Deferred, mut var_callback Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable, var_argument rt.PhpVal)  {
	mut var_deferred_mutated := var_deferred
	mut var_result := rt.call_callable(var_callback, [var_argument.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable') {
		mut var_exception := var_e_1.dup()
		var_deferred_mutated.fail(var_exception.dup())
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(rt.new_bool(rt.instance_of(var_result, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		var_result = rt.get_property(var_result, 'adoptedPromise')
	}
	var_deferred_mutated.resolve(var_result.dup())
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	rt.PhpObjectBase
}

struct Class_Amp_Deferred {
	rt.PhpObjectBase
}

struct Class_Amp_Success {
	rt.PhpObjectBase
}

struct Class_Amp_Failure {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_amppromiseadapter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter{
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

fn create_amp_deferred() &Class_Amp_Deferred {
	mut obj := &Class_Amp_Deferred{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_amp_success() &Class_Amp_Success {
	mut obj := &Class_Amp_Success{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_amp_failure() &Class_Amp_Failure {
	mut obj := &Class_Amp_Failure{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'resolveWithCallable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Amp_Deferred](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter.resolvewithcallable(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_AmpPromiseAdapter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Amp_Deferred) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Amp_Deferred) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Amp_Deferred) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Amp_Success) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Amp_Success) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Amp_Success) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Amp_Failure) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Amp_Failure) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Amp_Failure) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_promise_adapter_amppromiseadapter_php() {
	// unsupported statement: Stmt_Declare
}
