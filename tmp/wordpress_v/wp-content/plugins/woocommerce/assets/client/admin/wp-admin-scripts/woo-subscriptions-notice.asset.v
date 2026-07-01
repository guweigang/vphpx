import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_woo_subscriptions_notice_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
		]) },
		rt.ArrayItem{ key: 'version', val: '42c79a5b5f4c6c08628e' },
	])
}
