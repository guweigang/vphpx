import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_settings_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '5cdaba16c87338181b77' },
	])
}
