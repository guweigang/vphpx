import rt

fn wc_interactivity_api_load_product(consent_statement string, product_id i64) rt.PhpVal {
	mut var_consent_statement := consent_statement
	mut var_product_id := product_id
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{}
	mut iife_result_0 := iife_temp_0.load_product(rt.new_string(consent_statement),
		rt.new_int(product_id))
	return iife_result_0
}

fn wc_interactivity_api_load_purchasable_child_products(consent_statement string, parent_id i64) rt.PhpVal {
	mut var_consent_statement := consent_statement
	mut var_parent_id := parent_id
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{}
	mut iife_result_1 := iife_temp_1.load_purchasable_child_products(rt.new_string(consent_statement),
		rt.new_int(parent_id))
	return iife_result_1
}

fn wc_interactivity_api_load_variations(consent_statement string, parent_id i64) rt.PhpVal {
	mut var_consent_statement := consent_statement
	mut var_parent_id := parent_id
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{}
	mut iife_result_2 := iife_temp_2.load_variations(rt.new_string(consent_statement),
		rt.new_int(parent_id))
	return iife_result_2
}

struct Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_sharedstores_productsstore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
