import rt

interface WC_Log_Handler_Interface {
	handle(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_log_handler_interface_php() {
	mut var_timestamp := rt.new_null()
	mut var_level := rt.new_null()
	mut var_message := rt.new_null()
	mut var_context := rt.new_null()
}
