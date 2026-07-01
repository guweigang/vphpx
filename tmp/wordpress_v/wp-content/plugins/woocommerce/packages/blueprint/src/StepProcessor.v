import rt

interface StepProcessor {
	process(rt.PhpVal) rt.PhpVal
	get_step_class() rt.PhpVal
	check_step_capabilities(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_stepprocessor_php() {
	mut var_schema := rt.new_null()
}
