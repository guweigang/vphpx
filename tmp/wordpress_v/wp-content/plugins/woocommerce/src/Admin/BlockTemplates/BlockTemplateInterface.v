import rt

interface BlockTemplateInterface {
	get_id() rt.PhpVal
	get_title() rt.PhpVal
	get_description() rt.PhpVal
	get_area() rt.PhpVal
	generate_block_id(rt.PhpVal) rt.PhpVal
	to_json() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_admin_blocktemplates_blocktemplateinterface_php() {
	mut var_id_base := rt.new_null()
}
