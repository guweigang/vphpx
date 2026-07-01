import rt

fn wc_interactivity_api_load_product(consent_statement string, product_id i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{}
		return temp.load_product(arg_0, arg_1)
	}(rt.new_string(consent_statement), rt.new_int(product_id))
}

fn wc_interactivity_api_load_purchasable_child_products(consent_statement string, parent_id i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{}
		return temp.load_purchasable_child_products(arg_0, arg_1)
	}(rt.new_string(consent_statement), rt.new_int(parent_id))
}

fn wc_interactivity_api_load_variations(consent_statement string, parent_id i64) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{}
		return temp.load_variations(arg_0, arg_1)
	}(rt.new_string(consent_statement), rt.new_int(parent_id))
}

struct Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_sharedstores_productsstore() &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
	mut obj := &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_wc_interactivity_api_functions_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
