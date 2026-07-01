import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_wc_addons_tour_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'wc-components' },
			rt.ArrayItem{ key: none, val: 'wc-store-data' },
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
		]) },
		rt.ArrayItem{ key: 'version', val: '482ccd3ce621d1b1eec7' },
	])
}
