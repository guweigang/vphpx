import rt

fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_InlineHTML
	rt.call_function('post_class', [rt.new_string('wp-embed')])
	// unsupported statement: Stmt_InlineHTML
	mut var_thumbnail_id := rt.new_int(0)
	if rt.is_true(rt.call_function('has_post_thumbnail', []rt.PhpVal{})) {
		var_thumbnail_id = rt.call_function('get_post_thumbnail_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string('attachment'), rt.call_function('get_post_type', []rt.PhpVal{})))
		&& rt.is_true(rt.call_function('wp_attachment_is_image', []rt.PhpVal{})) {
		var_thumbnail_id = rt.call_function('get_the_ID', []rt.PhpVal{})
	}
	var_thumbnail_id = rt.call_function('apply_filters', [
		rt.new_string('embed_thumbnail_id'),
		var_thumbnail_id.clone(),
	])
	if rt.is_true(var_thumbnail_id) {
		mut var_aspect_ratio := rt.new_int(1)
		mut var_measurements := [rt.new_int(1), rt.new_int(1)]
		mut var_image_size := rt.new_string('full')
		mut var_meta := rt.call_function('wp_get_attachment_metadata', [
			var_thumbnail_id.clone()])
		if !(!rt.is_true(var_meta.array_get(rt.new_string('sizes')))) {
			mut iter_1 := var_meta.array_get(rt.new_string('sizes')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_data := item_1.val
				mut var_size := item_1.key
				if rt.is_true(rt.greater(var_data.array_get(rt.new_string('height')), rt.new_int(0)))
					&& rt.is_true(rt.greater(rt.div(var_data.array_get(rt.new_string('width')), var_data.array_get(rt.new_string('height'))), var_aspect_ratio)) {
					var_aspect_ratio = rt.div(var_data.array_get(rt.new_string('width')),
						var_data.array_get(rt.new_string('height')))
					var_measurements = [var_data.array_get(rt.new_string('width')),
						var_data.array_get(rt.new_string('height'))]
					var_image_size = var_size
				}
			}
		}
		var_image_size = rt.call_function('apply_filters', [
			rt.new_string('embed_thumbnail_image_size'),
			var_image_size.clone(),
			var_thumbnail_id.clone(),
		])
		mut var_shape := rt.new_string((if rt.is_true(rt.greater_equal(rt.div(var_measurements[0],
			var_measurements[1]), rt.new_float(1.75)))
		{
			'rectangular'
		} else {
			'square'
		}).str())
		var_shape = rt.call_function('apply_filters', [
			rt.new_string('embed_thumbnail_image_shape'),
			var_shape.clone(),
			var_thumbnail_id.clone(),
		])
	}
	if rt.is_true(var_thumbnail_id)
		&& rt.is_true(rt.identical(rt.new_string('rectangular'), var_shape)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_get_attachment_image', [
			var_thumbnail_id.clone(), var_image_size.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_permalink', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_title', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_thumbnail_id) && rt.is_true(rt.identical(rt.new_string('square'), var_shape)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_get_attachment_image', [
			var_thumbnail_id.clone(), var_image_size.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_excerpt_embed', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('embed_content')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_embed_site_title', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('embed_content_meta')])
	// unsupported statement: Stmt_InlineHTML
}
