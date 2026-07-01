import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_blocks_middleware_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
		]) },
		rt.ArrayItem{ key: 'version', val: '2c049fe250c153b7cac8' },
	])
}
