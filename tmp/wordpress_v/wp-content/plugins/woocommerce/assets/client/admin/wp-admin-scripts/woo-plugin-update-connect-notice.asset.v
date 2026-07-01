import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_woo_plugin_update_connect_notice_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
			rt.ArrayItem{ key: none, val: 'wp-dom-ready' },
		]) },
		rt.ArrayItem{ key: 'version', val: '9d21a8f4170b3fe96628' },
	])
}
