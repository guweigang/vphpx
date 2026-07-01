import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_blocks_vendors_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '5f5370c4ac22a4916f87' },
	])
}
