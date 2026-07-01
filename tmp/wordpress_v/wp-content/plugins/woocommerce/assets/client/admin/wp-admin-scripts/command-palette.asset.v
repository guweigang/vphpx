import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_command_palette_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
			rt.ArrayItem{ key: none, val: 'wp-commands' },
			rt.ArrayItem{ key: none, val: 'wp-core-data' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-dom-ready' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'b3da20477a4b2fb1534f' },
	])
}
