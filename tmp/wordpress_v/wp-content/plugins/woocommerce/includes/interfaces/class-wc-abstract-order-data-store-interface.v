import rt

interface WC_Abstract_Order_Data_Store_Interface {
	read_items(rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_items(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_payment_token_ids(rt.PhpVal) rt.PhpVal
	update_payment_token_ids(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_abstract_order_data_store_interface_php() {
	mut var_order := rt.new_null()
	mut var_type := rt.new_null()
	mut var_token_ids := rt.new_null()
}
