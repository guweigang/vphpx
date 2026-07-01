import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_currency_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-number' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-deprecated' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'e9e72711c09c845947d5' },
	])
}
