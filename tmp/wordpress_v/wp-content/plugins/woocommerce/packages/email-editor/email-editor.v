import rt

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_email_editor_php() {
	mut var_autoload_entry_point := rt.new_string(@DIR + '/vendor/autoload.php')
	if rt.is_true(rt.call_function('file_exists', [var_autoload_entry_point.dup()])) {
		rt.include_file(var_autoload_entry_point.to_string(), '4')
	}
	// unsupported statement: Stmt_Nop
}
