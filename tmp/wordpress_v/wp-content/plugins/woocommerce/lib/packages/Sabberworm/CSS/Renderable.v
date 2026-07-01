import rt

interface Renderable {
	magic_tostring() rt.PhpVal
	render(rt.PhpVal) rt.PhpVal
	getlineno() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_renderable_php() {
	mut var_oOutputFormat := rt.new_null()
}
