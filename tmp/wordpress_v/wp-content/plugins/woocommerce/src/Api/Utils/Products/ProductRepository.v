import rt

struct Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository) find(id i64) rt.PhpVal {
	mut var_product := rt.call_function('wc_get_product', [rt.new_int(id)])
	return if rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Api_Utils_Products_WC_Product')))
	{
		var_product
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository) save(mut var_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) {
	mut var_product_mutated := var_product
	rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
}

fn create_automattic_woocommerce_api_utils_products_productrepository() &Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'find' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.find(dispatch_arg_0)
		}
		'save' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.save(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_api_utils_products_productrepository_php() {
	// unsupported statement: Stmt_Declare
}
