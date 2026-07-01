import rt

interface ProductFormTemplateInterface {
	add_group(rt.PhpVal) rt.PhpVal
	get_group_by_id(rt.PhpVal) rt.PhpVal
	get_section_by_id(rt.PhpVal) rt.PhpVal
	get_subsection_by_id(rt.PhpVal) rt.PhpVal
	get_block_by_id(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_productblockeditor_producttemplates_productformtemplateinterface_php() {
	mut var_block_config := rt.new_null()
	mut var_group_id := rt.new_null()
	mut var_section_id := rt.new_null()
	mut var_subsection_id := rt.new_null()
	mut var_block_id := rt.new_null()
}
