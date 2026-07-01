import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_explat_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'ed17599085ff789f2e76' },
	])
}
