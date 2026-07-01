import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_blocks_shared_context_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '621353d8a3a7c8d44b41' },
	])
}
