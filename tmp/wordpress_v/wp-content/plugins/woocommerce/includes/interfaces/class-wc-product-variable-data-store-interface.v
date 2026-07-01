import rt

interface WC_Product_Variable_Data_Store_Interface {
	child_has_weight(rt.PhpVal) rt.PhpVal
	child_has_dimensions(rt.PhpVal) rt.PhpVal
	child_is_in_stock(rt.PhpVal) rt.PhpVal
	sync_variation_names(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	sync_managed_variation_stock_status(rt.PhpVal) rt.PhpVal
	sync_price(rt.PhpVal) rt.PhpVal
	delete_variations(rt.PhpVal, rt.PhpVal) rt.PhpVal
	untrash_variations(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_product_variable_data_store_interface_php() {
	mut var_product := rt.new_null()
	mut var_previous_name := rt.new_null()
	mut var_new_name := rt.new_null()
	mut var_product_id := rt.new_null()
	mut var_force_delete := rt.new_null()
}
