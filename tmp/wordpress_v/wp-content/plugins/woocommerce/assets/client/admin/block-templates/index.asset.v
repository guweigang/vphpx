import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_admin_block_templates_index_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-block-editor' },
			rt.ArrayItem{ key: none, val: 'wp-blocks' },
			rt.ArrayItem{ key: none, val: 'wp-core-data' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
		]) },
		rt.ArrayItem{ key: 'version', val: '0e50fb0a66700d70feaa' },
	])
}
