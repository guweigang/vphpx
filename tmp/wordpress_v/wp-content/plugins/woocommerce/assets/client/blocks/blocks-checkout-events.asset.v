import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_blocks_checkout_events_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '1cd9ffa6e3cff96ad1b2' },
	])
}
