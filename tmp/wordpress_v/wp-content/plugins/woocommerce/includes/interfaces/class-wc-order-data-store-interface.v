import rt

interface WC_Order_Data_Store_Interface {
	get_total_refunded(rt.PhpVal) rt.PhpVal
	get_total_tax_refunded(rt.PhpVal) rt.PhpVal
	get_total_shipping_refunded(rt.PhpVal) rt.PhpVal
	get_order_id_by_order_key(rt.PhpVal) rt.PhpVal
	get_order_count(rt.PhpVal) rt.PhpVal
	get_orders(rt.PhpVal) rt.PhpVal
	get_unpaid_orders(rt.PhpVal) rt.PhpVal
	search_orders(rt.PhpVal) rt.PhpVal
	get_download_permissions_granted(rt.PhpVal) rt.PhpVal
	set_download_permissions_granted(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_recorded_sales(rt.PhpVal) rt.PhpVal
	set_recorded_sales(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_recorded_coupon_usage_counts(rt.PhpVal) rt.PhpVal
	set_recorded_coupon_usage_counts(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_order_type(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_order_data_store_interface_php() {
	mut var_order := rt.new_null()
	mut var_order_key := rt.new_null()
	mut var_status := rt.new_null()
	mut var_args := rt.new_null()
	mut var_date := rt.new_null()
	mut var_term := rt.new_null()
	mut var_set := rt.new_null()
	mut var_order_id := rt.new_null()
}
