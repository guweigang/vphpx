import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_admin_layout_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-components' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
		]) },
		rt.ArrayItem{ key: 'version', val: '70ee5a6ed50d37f62db2' },
	])
}
