import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_is() string {
	return 'is'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_is_not() string {
	return 'isNot'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_less_than() string {
	return 'lessThan'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_greater_than() string {
	return 'greaterThan'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_less_than_or_equal() string {
	return 'lessThanOrEqual'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_greater_than_or_equal() string {
	return 'greaterThanOrEqual'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_between() string {
	return 'between'
}

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operators() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_is()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_is_not()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_less_than()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_greater_than()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_less_than_or_equal()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_greater_than_or_equal()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery.operator_between()
		},
	])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) get_query_schema() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) get_query_args(mut var_request Class_WP_REST_Request) {
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) get_query_results(mut var_query_args Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array, mut var_request Class_WP_REST_Request) {
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcollectionquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_query_schema' {
			this.get_query_schema()
			return rt.new_null()
		}
		'get_query_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.get_query_args(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_query_results' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.get_query_results(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
