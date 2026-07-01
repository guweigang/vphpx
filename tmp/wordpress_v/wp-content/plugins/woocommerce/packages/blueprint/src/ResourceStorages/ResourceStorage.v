import rt

interface ResourceStorage {
	get_supported_resource() rt.PhpVal
	download(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_resourcestorages_resourcestorage_php() {
	mut var_slug := rt.new_null()
}
