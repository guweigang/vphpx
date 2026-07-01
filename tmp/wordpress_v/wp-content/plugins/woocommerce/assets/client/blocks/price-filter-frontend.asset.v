import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_price_filter_frontend_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks-frontend-vendors' },
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-components' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-data-store' },
			rt.ArrayItem{ key: none, val: 'wc-price-format' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-is-shallow-equal' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'e9cf4e59d1be14bbecc4' },
	])
}
