import rt

interface Css_Inliner {
	from_html(rt.PhpVal) rt.PhpVal
	inline_css(rt.PhpVal) rt.PhpVal
	render() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_interface_css_inliner_php() {
	mut var_unprocessed_html := rt.new_null()
	mut var_css := rt.new_null()
}
