import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_category_tracking_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
		]) },
		rt.ArrayItem{ key: 'version', val: '3e12f134c4e90bc495ce' },
	])
}
