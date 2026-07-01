import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_cart_checkout_base_frontend_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '5eecc58b7a7b61cb8ff3' },
	])
}
