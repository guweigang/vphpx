import rt

interface WC_Customer_Data_Store_Interface {
	get_last_order(rt.PhpVal) rt.PhpVal
	get_order_count(rt.PhpVal) rt.PhpVal
	get_total_spent(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_customer_data_store_interface_php() {
	mut var_customer := rt.new_null()
}
