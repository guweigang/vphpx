import rt

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_templates_single_email_post_template_php() {
	mut var_template_html := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_preview_post_template_html'),
		rt.call_function('get_post', []rt.PhpVal{}),
	])
	rt.echo_val(var_template_html)
}
