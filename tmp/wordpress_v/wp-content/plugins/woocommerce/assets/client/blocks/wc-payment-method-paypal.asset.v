import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_wc_payment_method_paypal_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-registry' },
			rt.ArrayItem{ key: none, val: 'wc-sanitize' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'c6baa7a53e9445b6a02e' },
	])
}
