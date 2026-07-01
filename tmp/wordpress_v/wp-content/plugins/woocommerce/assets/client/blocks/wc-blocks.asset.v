import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_blocks_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-blocks' },
			rt.ArrayItem{ key: none, val: 'wp-compose' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '888fc7fc921d3d5b4e0e' },
	])
}
