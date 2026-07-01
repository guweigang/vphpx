import rt

pub fn Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.after_id() string {
	return 'wc_api_after_id'
}
pub fn Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.before_id() string {
	return 'wc_api_before_id'
}
struct Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	rt.PhpObjectBase
pub mut:
		registered rt.PhpVal = rt.new_bool(false)
}

fn Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.ensure_registered()  {
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Api_Pagination_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.class() }, rt.ArrayItem{ key: none, val: 'apply' }]), rt.new_int(10), rt.new_int(2)])
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.apply(where string, mut var_query Class_Automattic_WooCommerce_Api_Pagination_WP_Query) string {
	mut var_wpdb := rt.new_null()
	mut var_after := // unsupported expression: Expr_Cast_Int
	mut var_before := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_after, rt.new_int(0))) && rt.is_true(rt.less_equal(var_before, rt.new_int(0))))) {
		return where
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.greater(var_after, rt.new_int(0))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.greater(var_before, rt.new_int(0))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return where
}

fn Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.decode_id_cursor(cursor string, name string) i64 {
	mut var_raw := rt.call_function('base64_decode', [rt.new_string(cursor), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_raw)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_digit', [var_raw.dup()]))))))) || rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.call_function('sprintf', [rt.new_string('Invalid `%s` cursor.'), rt.new_string(name)]), rt.new_string('INVALID_ARGUMENT'), rt.new_int(400))))
		// unsupported statement: Stmt_Nop
	}
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_pagination_idcursorfilter() &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{
		PhpObjectBase: rt.PhpObjectBase{}
		registered: rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_api_apiexception() &Class_Automattic_WooCommerce_Api_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Api_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'ensure_registered' {
			Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.ensure_registered()
			return rt.new_null()
		}
		'apply' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_WP_Query](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.apply(dispatch_arg_0, mut dispatch_arg_1))
		}
		'decode_id_cursor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_int(Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.decode_id_cursor(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered' { return this.registered }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered' { this.registered = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_api_pagination_idcursorfilter_php() {
	// unsupported statement: Stmt_Declare
}
