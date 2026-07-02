import rt

pub fn Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.max_page_size() i64 {
	return 100
}
pub fn Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.default_page_size() i64 {
	return 100
}
struct Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) construct(mut var_first Class_Automattic_WooCommerce_Api_Pagination_?int, mut var_last Class_Automattic_WooCommerce_Api_Pagination_?int, mut var_after Class_Automattic_WooCommerce_Api_Pagination_?string, mut var_before Class_Automattic_WooCommerce_Api_Pagination_?string) {
	Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_limit('first', mut var_first)
	Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_limit('last', mut var_last)
}

fn Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.get_default_page_size() i64 {
	return (Class_Automattic_WooCommerce_Api_Pagination_Automattic_WooCommerce_Api_Pagination_PaginationParams.default_page_size()).to_i64()
}

fn Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_args(mut var_args Class_Automattic_WooCommerce_Api_Pagination_array) {
	Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_limit('first', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_?int](if !(var_args.array_get(rt.new_string('first'))).is_null() { var_args.array_get(rt.new_string('first')) } else { rt.new_null() }))
	Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_limit('last', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_?int](if !(var_args.array_get(rt.new_string('last'))).is_null() { var_args.array_get(rt.new_string('last')) } else { rt.new_null() }))
}

fn Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_limit(name string, mut var_value Class_Automattic_WooCommerce_Api_Pagination_?int) {
	if rt.is_true(rt.identical(rt.new_null(), var_value)) {
		return
	}
	if rt.is_true(rt.less(var_value, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_Pagination_InvalidArgumentException', []string{}, create_automattic_woocommerce_api_pagination_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Argument `%s` must be zero or greater.'), rt.new_string(name)]))))
	}
	if rt.is_true(rt.greater(var_value, Class_Automattic_WooCommerce_Api_Pagination_Automattic_WooCommerce_Api_Pagination_PaginationParams.max_page_size())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_Pagination_InvalidArgumentException', []string{}, create_automattic_woocommerce_api_pagination_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Argument `%s` exceeds the maximum page size of %d.'), rt.new_string(name), Class_Automattic_WooCommerce_Api_Pagination_Automattic_WooCommerce_Api_Pagination_PaginationParams.max_page_size()]))))
	}
}

struct Class_Automattic_WooCommerce_Api_Pagination_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_pagination_paginationparams(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_automattic_woocommerce_api_pagination_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'get_default_page_size' {
			return rt.new_int(Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.get_default_page_size())
		}
		'validate_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_array](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_args(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Api_Pagination_PaginationParams.validate_limit(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
