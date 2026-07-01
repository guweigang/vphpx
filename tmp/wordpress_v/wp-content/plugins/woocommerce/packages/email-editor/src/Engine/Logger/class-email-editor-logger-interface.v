import rt

interface Email_Editor_Logger_Interface {
	emergency(rt.PhpVal, rt.PhpVal) rt.PhpVal
	alert(rt.PhpVal, rt.PhpVal) rt.PhpVal
	critical(rt.PhpVal, rt.PhpVal) rt.PhpVal
	error(rt.PhpVal, rt.PhpVal) rt.PhpVal
	warning(rt.PhpVal, rt.PhpVal) rt.PhpVal
	notice(rt.PhpVal, rt.PhpVal) rt.PhpVal
	info(rt.PhpVal, rt.PhpVal) rt.PhpVal
	debug(rt.PhpVal, rt.PhpVal) rt.PhpVal
	log(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_logger_class_email_editor_logger_interface_php() {
	mut var_message := rt.new_null()
	mut var_context := rt.new_null()
	mut var_level := rt.new_null()
	// unsupported statement: Stmt_Declare
}
