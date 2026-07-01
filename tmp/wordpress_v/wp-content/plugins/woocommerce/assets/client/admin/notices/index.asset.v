import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_notices_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'lodash' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-notices' },
		]) },
		rt.ArrayItem{ key: 'version', val: '57e66e5733b07d125bb7' },
	])
}
