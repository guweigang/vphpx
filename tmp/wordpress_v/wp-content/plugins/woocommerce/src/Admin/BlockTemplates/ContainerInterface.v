import rt

interface ContainerInterface {
	get_root_template() rt.PhpVal
	get_formatted_template() rt.PhpVal
	get_block(rt.PhpVal) rt.PhpVal
	remove_block(rt.PhpVal) rt.PhpVal
	remove_blocks() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_admin_blocktemplates_containerinterface_php() {
	mut var_block_id := rt.new_null()
}
