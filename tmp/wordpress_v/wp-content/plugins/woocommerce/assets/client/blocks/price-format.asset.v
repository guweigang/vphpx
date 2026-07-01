import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_price_format_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '0df720e448f7ab3c5d0d' },
	])
}
