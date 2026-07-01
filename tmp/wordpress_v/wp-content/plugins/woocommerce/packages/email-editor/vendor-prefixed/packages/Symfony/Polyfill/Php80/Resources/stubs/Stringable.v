import rt

interface Stringable {
	magic_tostring() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_polyfill_php80_resources_stubs_stringable_php() {
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
	}
}
