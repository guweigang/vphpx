import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_order_tracking_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-customer-effort-score' },
		]) },
		rt.ArrayItem{ key: 'version', val: '9faf1c8a5a7facc6f9ed' },
	])
}
