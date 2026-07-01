import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_date_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'lodash' },
			rt.ArrayItem{ key: none, val: 'moment' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
		]) },
		rt.ArrayItem{ key: 'version', val: '1fc38fd6a1364b6df1d1' },
	])
}
