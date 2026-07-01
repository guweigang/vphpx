import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_product_gallery_large_image_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-block-editor' },
			rt.ArrayItem{ key: none, val: 'wp-blocks' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'be7f3c98cd6a86661b3d' },
	])
}
