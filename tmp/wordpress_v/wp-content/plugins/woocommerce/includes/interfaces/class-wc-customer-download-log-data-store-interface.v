import rt

interface WC_Customer_Download_Log_Data_Store_Interface {
	get_download_logs(rt.PhpVal) rt.PhpVal
	get_download_logs_for_permission(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_customer_download_log_data_store_interface_php() {
	mut var_args := rt.new_null()
	mut var_permission_id := rt.new_null()
}
