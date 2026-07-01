import rt

struct Class_Automattic_WooCommerce_Api_Mutations_Products_DeleteProduct {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_DeleteProduct) execute(id i64, force bool) bool {
	mut var_wc_product := rt.call_function('wc_get_product', [
		rt.new_int(id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wc_product,
		'Automattic_WooCommerce_Api_Mutations_Products_WC_Product'))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.new_string('Product not found.'),
			rt.new_string('NOT_FOUND'), rt.new_int(404))))
	}
	mut var_deleted := rt.call_method(var_wc_product, 'delete', [
		rt.new_bool(force)])
	if rt.is_true(rt.new_bool(rt.instance_of(var_deleted,
		'Automattic_WooCommerce_Api_Mutations_Products_WP_Error')))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.call_method(var_deleted,
			'get_error_message', []rt.PhpVal{}), rt.new_string('INTERNAL_ERROR'), rt.new_int(500))))
	}
	return (rt.identical(rt.new_bool(true), var_deleted)).to_bool()
}

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_mutations_products_deleteproduct() &Class_Automattic_WooCommerce_Api_Mutations_Products_DeleteProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Products_DeleteProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_apiexception() &Class_Automattic_WooCommerce_Api_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Api_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_DeleteProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.execute(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Products_DeleteProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_DeleteProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_content_plugins_woocommerce_src_api_mutations_products_deleteproduct_php() {
	// unsupported statement: Stmt_Declare
}
