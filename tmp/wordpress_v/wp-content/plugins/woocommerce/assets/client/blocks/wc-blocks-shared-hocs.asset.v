import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_blocks_shared_hocs_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-data-store' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-shared-context' },
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-is-shallow-equal' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '81d21446ddb1d5f22bf3' },
	])
}
