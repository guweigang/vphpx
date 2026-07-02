import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) isthenable(var_value rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(var_value, 'React_Promise_PromiseInterface'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) convertthenable(var_thenable rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_thenable.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) then(mut var_promise Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise, mut var_onFulfilled Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable, mut var_onRejected Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_?callable) rt.PhpVal {
	mut var_reactPromise := rt.get_property(var_promise, 'adoptedPromise')
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_reactPromise, 'React_Promise_PromiseInterface'))])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(rt.call_method(var_reactPromise, 'then', [var_onFulfilled, var_onRejected]), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) create(mut var_resolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_callable) rt.PhpVal {
	mut var_reactPromise := create_react_promise_promise(var_resolver)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_reactPromise.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) createfulfilled(var_value rt.PhpVal) rt.PhpVal {
	mut var_reactPromise := rt.call_function('resolve', [var_value.clone()])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_reactPromise.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) createrejected(mut var_reason Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_Throwable) rt.PhpVal {
	mut var_reactPromise := rt.call_function('reject', [var_reason])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_reactPromise.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter', ['PromiseAdapter'], &this)))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) all(mut var_promisesOrValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_iterable) rt.PhpVal {
	mut var_values := rt.new_null()
	mut var_key := rt.new_null()
	mut iter_1 := var_promisesOrValues.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_promiseOrValue := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_promiseOrValue, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		var_promiseOrValue = rt.get_property(var_promiseOrValue, 'adoptedPromise')
		}
	}
	mut var_promisesOrValuesArray := if var_promisesOrValues.is_array() { var_promisesOrValues } else { rt.call_function('iterator_to_array', [var_promisesOrValues]) }
	closure_3_fn := fn [var_key, var_promisesOrValuesArray] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_values := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		closure_2_fn := fn [var_values] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_values.array_get(var_key)
			}
		closure_3_fn := fn [var_values] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_values.array_get(var_key)
			}
		return rt.call_function('array_map', [rt.new_closure(closure_2_fn), rt.func_array_keys(var_promisesOrValuesArray.clone())])
		}
	mut var_reactPromise := rt.call_method(rt.call_function('all', [var_promisesOrValuesArray.clone()]), 'then', [rt.new_closure(closure_3_fn)])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promise_promise(var_reactPromise.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter', ['PromiseAdapter'], &this)))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise {
	rt.PhpObjectBase
}

struct Class_React_Promise_Promise {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_reactpromiseadapter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter{
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

fn create_react_promise_promise(_args ...rt.PhpVal) &Class_React_Promise_Promise {
	mut obj := &Class_React_Promise_Promise{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_ReactPromiseAdapter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_React_Promise_Promise) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_React_Promise_Promise) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_React_Promise_Promise) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
