import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_accordion_panel_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-block-editor' },
			rt.ArrayItem{ key: none, val: 'wp-blocks' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '96938667340d734e45cd' },
	])
}
