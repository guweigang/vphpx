import rt

interface WC_Webhook_Data_Store_Interface {
	get_api_version_number(rt.PhpVal) rt.PhpVal
	get_webhooks_ids(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_webhooks_data_store_interface_php() {
	mut var_api_version := rt.new_null()
	mut var_status := rt.new_null()
}
