import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_wp_admin_scripts_product_tracking_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-customer-effort-score' },
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'bce78d288c7cfafeaf78' },
	])
}
