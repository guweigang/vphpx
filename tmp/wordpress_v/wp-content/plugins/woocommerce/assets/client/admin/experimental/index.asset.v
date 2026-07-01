import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_experimental_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'moment' },
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-dom' },
			rt.ArrayItem{ key: none, val: 'wc-components' },
			rt.ArrayItem{ key: none, val: 'wc-sanitize' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-keycodes' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
		]) },
		rt.ArrayItem{ key: 'version', val: '1a388f9691c9c73bd9e9' },
	])
}
