import rt

struct Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct) authorize(id i64, _preauthorized bool) bool {
	if id <= 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_AuthorizationException', []string{}, create_automattic_woocommerce_api_authorizationexception(rt.new_string('Product not found.'))))
	}
	mut var_post := rt.call_function('get_post', [rt.new_int(id)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_AuthorizationException', []string{}, create_automattic_woocommerce_api_authorizationexception(rt.new_string('Product not found.'))))
	}
	if var__preauthorized {
		return true
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) {
		return true
	}
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_current_user_id)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_AuthorizationException', []string{}, create_automattic_woocommerce_api_authorizationexception(rt.new_string('Product not found.'))))
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct) execute(id i64, mut var__query_info Class_Automattic_WooCommerce_Api_Queries_Products_?array) rt.PhpVal {
	if id <= 0 {
		return rt.new_null()
	}
	mut var_wc_product := rt.call_function('wc_get_product', [rt.new_int(id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wc_product, 'Automattic_WooCommerce_Api_Queries_Products_WC_Product')))))) {
		return rt.new_null()
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{}; return temp.from_wc_product(arg_0, arg_1) }(var_wc_product.dup(), rt.new_object('Automattic_WooCommerce_Api_Queries_Products_?array', []string{}, var__query_info))
}

struct Class_Automattic_WooCommerce_Api_AuthorizationException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_queries_products_getproduct() &Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_authorizationexception() &Class_Automattic_WooCommerce_Api_AuthorizationException {
	mut obj := &Class_Automattic_WooCommerce_Api_AuthorizationException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_utils_products_productmapper() &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'authorize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.authorize(dispatch_arg_0, dispatch_arg_1))
		}
		'execute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Queries_Products_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.execute(dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_GetProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_AuthorizationException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_AuthorizationException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_AuthorizationException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_api_queries_products_getproduct_php() {
	// unsupported statement: Stmt_Declare
}
