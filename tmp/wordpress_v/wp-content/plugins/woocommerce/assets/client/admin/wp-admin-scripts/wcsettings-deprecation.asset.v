import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_wcsettings_deprecation_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'e432e9c273a3620d42f9' },
	])
}
