import rt

interface PluginsInstallLogger {
	install_requested(rt.PhpVal) rt.PhpVal
	installed(rt.PhpVal, rt.PhpVal) rt.PhpVal
	activated(rt.PhpVal) rt.PhpVal
	add_error(rt.PhpVal, rt.PhpVal) rt.PhpVal
	complete(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_admin_pluginsinstallloggers_pluginsinstalllogger_php() {
	mut var_plugin_name := rt.new_null()
	mut var_duration := rt.new_null()
	mut var_error_message := rt.new_null()
	mut var_data := rt.new_null()
}
