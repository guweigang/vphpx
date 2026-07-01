import rt

interface StepExporter {
	export() rt.PhpVal
	get_step_name() rt.PhpVal
	check_step_capabilities() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_exporters_stepexporter_php() {
}
