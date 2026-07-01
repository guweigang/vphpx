import rt

interface WC_Logger_Interface {
	add(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	log(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	emergency(rt.PhpVal, rt.PhpVal) rt.PhpVal
	alert(rt.PhpVal, rt.PhpVal) rt.PhpVal
	critical(rt.PhpVal, rt.PhpVal) rt.PhpVal
	error(rt.PhpVal, rt.PhpVal) rt.PhpVal
	warning(rt.PhpVal, rt.PhpVal) rt.PhpVal
	notice(rt.PhpVal, rt.PhpVal) rt.PhpVal
	info(rt.PhpVal, rt.PhpVal) rt.PhpVal
	debug(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_includes_interfaces_class_wc_logger_interface_php() {
	mut var_handle := rt.new_null()
	mut var_message := rt.new_null()
	mut var_level := rt.new_null()
	mut var_context := rt.new_null()
}
