import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_remote_logging_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
		]) },
		rt.ArrayItem{ key: 'version', val: '1f640a4a5db95defc5a9' },
	])
}
