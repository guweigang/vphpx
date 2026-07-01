import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_product_image_php() {
	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_gallery_image_html')]))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	mut var_columns := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_thumbnails_columns'), rt.new_int(4)])
	mut var_post_thumbnail_id := rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})
	mut var_wrapper_classes := rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_image_gallery_classes'), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce-product-gallery' }, rt.ArrayItem{ key: none, val: 'woocommerce-product-gallery--' + if rt.is_true(var_post_thumbnail_id) { 'with-images' } else { 'without-images' } }, rt.ArrayItem{ key: none, val: 'woocommerce-product-gallery--columns-' + (rt.call_function('absint', [var_columns.dup()])).str() }, rt.ArrayItem{ key: none, val: 'images' }])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_map', [rt.new_string('sanitize_html_class'), var_wrapper_classes.dup()])])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_columns.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_post_thumbnail_id) {
		mut var_html := rt.call_function('wc_get_gallery_image_html', [var_post_thumbnail_id.dup(), rt.new_bool(true)])
	} else {
		mut var_wrapper_classname := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) && !(!rt.is_true(rt.call_method(var_product, 'get_visible_children', []rt.PhpVal{}))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { 'woocommerce-product-gallery__image woocommerce-product-gallery__image--placeholder' } else { 'woocommerce-product-gallery__image--placeholder' }
		var_html = rt.call_function('sprintf', [rt.new_string('<div class="%s">'), rt.call_function('esc_attr', [rt.new_string(var_wrapper_classname).dup()])])
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_image_thumbnail_html'), var_html.dup(), var_post_thumbnail_id.dup()]))
	rt.call_function('do_action', [rt.new_string('woocommerce_product_thumbnails')])
	// unsupported statement: Stmt_InlineHTML
}
