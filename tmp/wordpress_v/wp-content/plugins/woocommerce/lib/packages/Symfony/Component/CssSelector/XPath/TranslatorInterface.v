import rt

interface TranslatorInterface {
	csstoxpath(rt.PhpVal, rt.PhpVal) rt.PhpVal
	selectortoxpath(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_xpath_translatorinterface_php() {
	mut var_cssExpr := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_selector := rt.new_null()
}
