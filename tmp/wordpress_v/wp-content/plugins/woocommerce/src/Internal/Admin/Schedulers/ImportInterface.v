import rt

interface ImportInterface {
	get_items(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_total_imported() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_internal_admin_schedulers_importinterface_php() {
	mut var_limit := rt.new_null()
	mut var_page := rt.new_null()
	mut var_days := rt.new_null()
	mut var_skip_existing := rt.new_null()
}
