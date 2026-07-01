import rt

struct Class_Automattic_WooCommerce_Internal_Api_Utils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Api_Utils.check_current_user_can(capability string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string(capability),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error',
			[]string{}, create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('You do not have permission to perform this action.'), rt.create_array([
			rt.ArrayItem{ key: 'code', val: 'UNAUTHORIZED' },
		]))))
	}
}

fn Class_Automattic_WooCommerce_Internal_Api_Utils.complexity_from_pagination(child_complexity i64, mut var_args Class_Automattic_WooCommerce_Internal_Api_array) i64 {
	mut var_requested := if !(var_args.array_get('first')).is_null() {
		var_args.array_get('first')
	} else {
		if !(var_args.array_get('last')).is_null() {
			var_args.array_get('last')
		} else {
			fn () rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams{}
				return temp.get_default_page_size()
			}()
		}
	}
	mut var_page_size := if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_requested.dup().is_long()))
		&& rt.is_true(rt.greater_equal(var_requested, rt.new_int(0)))))
		&& rt.is_true(rt.less_equal(var_requested, Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams.max_page_size()))))
	{
		var_requested
	} else {
		Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams.max_page_size()
	}
	return (rt.mul(var_page_size, child_complexity + 1)).to_i64()
}

fn Class_Automattic_WooCommerce_Internal_Api_Utils.create_pagination_params(mut var_args Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return create_automattic_woocommerce_internal_api_automattic_woocommerce_api_pagination_paginationparams(if !(var_args.array_get('first')).is_null() {
			var_args.array_get('first')
		} else {
			rt.new_null()
		}, if !(var_args.array_get('last')).is_null() {
			var_args.array_get('last')
		} else {
			rt.new_null()
		}, if !(var_args.array_get('after')).is_null() {
			var_args.array_get('after')
		} else {
			rt.new_null()
		}, if !(var_args.array_get('before')).is_null() {
			var_args.array_get('before')
		} else {
			rt.new_null()
		})
	}
	return Class_Automattic_WooCommerce_Internal_Api_Utils.create_input(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_callable](rt.new_closure(closure_1_fn)))
}

fn Class_Automattic_WooCommerce_Internal_Api_Utils.create_input(mut var_factory Class_Automattic_WooCommerce_Internal_Api_callable) rt.PhpVal {
	return rt.call_callable(var_factory, []rt.PhpVal{})
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Api_InvalidArgumentException') {
		mut var_e := var_e_1.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error',
			[]string{}, create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_error_error(rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'code', val: 'INVALID_ARGUMENT' },
		]))))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Api_Utils.execute_command(mut var_command Class_Automattic_WooCommerce_Internal_Api_object, mut var_execute_args Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	closure_2_fn := fn [var_command, var_execute_args] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return var_command.execute(rt.new_object('Automattic_WooCommerce_Internal_Api_array',
			[]string{}, var_execute_args))
	}
	return Class_Automattic_WooCommerce_Internal_Api_Utils.translate_exceptions(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_callable](rt.new_closure(closure_2_fn)))
}

fn Class_Automattic_WooCommerce_Internal_Api_Utils.authorize_command(mut var_command Class_Automattic_WooCommerce_Internal_Api_object, mut var_authorize_args Class_Automattic_WooCommerce_Internal_Api_array) bool {
	closure_3_fn := fn [var_command, var_authorize_args] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return var_command.authorize(rt.new_object('Automattic_WooCommerce_Internal_Api_array',
			[]string{}, var_authorize_args))
	}
	return (Class_Automattic_WooCommerce_Internal_Api_Utils.translate_exceptions(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_callable](rt.new_closure(closure_3_fn)))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Api_Utils.translate_exceptions(mut var_operation Class_Automattic_WooCommerce_Internal_Api_callable) rt.PhpVal {
	return rt.call_callable(var_operation, []rt.PhpVal{})
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_ApiException')
	{
		mut var_e := var_e_2.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error',
			[]string{}, create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_error_error(rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.call_function('array_merge', [
			rt.call_method(var_e, 'getExtensions', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'code', val: rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}) },
			]),
		]))))
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_Internal_Api_InvalidArgumentException')
	{
		mut var_e := var_e_2.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error',
			[]string{}, create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_error_error(rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'code', val: 'INVALID_ARGUMENT' },
		]))))
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Api_Throwable') {
		mut var_e := var_e_2.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error',
			[]string{}, create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('An unexpected error occurred.'),
			var_e.dup(), rt.create_array([
			rt.ArrayItem{ key: 'code', val: 'INTERNAL_ERROR' },
		]))))
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_utils() &Class_Automattic_WooCommerce_Internal_Api_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_automattic_woocommerce_api_pagination_paginationparams() &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'check_current_user_can' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Internal_Api_Utils.check_current_user_can(dispatch_arg_0)
			return rt.new_null()
		}
		'complexity_from_pagination' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_int(Class_Automattic_WooCommerce_Internal_Api_Utils.complexity_from_pagination(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'create_pagination_params' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_Api_Utils.create_pagination_params(mut dispatch_arg_0)
		}
		'create_input' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_callable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_Api_Utils.create_input(mut dispatch_arg_0)
		}
		'execute_command' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_Api_Utils.execute_command(mut dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'authorize_command' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Api_Utils.authorize_command(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'translate_exceptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_callable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_Api_Utils.translate_exceptions(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_src_internal_api_utils_php() {
	// unsupported statement: Stmt_Declare
}
