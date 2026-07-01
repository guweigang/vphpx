import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_reviews_frontend_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks-frontend-vendors' },
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-components' },
			rt.ArrayItem{ key: none, val: 'wc-sanitize' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-is-shallow-equal' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '542730ed63392f22bfe9' },
	])
}
