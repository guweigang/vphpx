import rt

interface IntegrationInterface {
	get_name() rt.PhpVal
	initialize() rt.PhpVal
	get_script_handles() rt.PhpVal
	get_editor_script_handles() rt.PhpVal
	get_script_data() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_integrations_integrationinterface_php() {
}
