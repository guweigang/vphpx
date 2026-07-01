import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_onboarding_load_sample_products_notice_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-dom-ready' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
		]) },
		rt.ArrayItem{ key: 'version', val: '90033cf60f1d3291120d' },
	])
}
