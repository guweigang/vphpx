import rt

struct Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController {
	rt.PhpObjectBase
pub mut:
	query_clauses rt.PhpVal = rt.new_null()
	params        rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController) init(mut var_query_clauses Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses, mut var_params Class_Automattic_WooCommerce_Internal_ProductFilters_Params) {
	this.query_clauses = var_query_clauses
	this.params = var_params
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController) register() {
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.query_clauses },
			rt.ArrayItem{ key: none, val: 'add_query_clauses_for_main_query' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('query_vars'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_MainQueryController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_query_vars' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController) add_query_vars(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	return rt.call_function('array_merge', [var_query_vars,
		rt.call_method(this.params, 'get_param_keys', []rt.PhpVal{})])
}

fn create_automattic_woocommerce_internal_productfilters_mainquerycontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController{
		PhpObjectBase: rt.PhpObjectBase{}
		query_clauses: rt.new_null()
		params:        rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_Params](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'add_query_vars' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_query_vars(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query_clauses' { return this.query_clauses }
		'params' { return this.params }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_MainQueryController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query_clauses' {
			this.query_clauses = val
			return true
		}
		'params' {
			this.params = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
