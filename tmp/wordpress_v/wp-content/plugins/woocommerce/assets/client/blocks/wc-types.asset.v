import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_types_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'f3ab56d2923288ac7721' },
	])
}
