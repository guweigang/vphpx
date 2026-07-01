import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_onboarding_homepage_notice_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-dom-ready' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'b9cda97915c24ace1826' },
	])
}
