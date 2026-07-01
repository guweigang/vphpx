import rt

fn wc_get_brand_thumbnail_url(var_brand_id rt.PhpVal, size string) rt.PhpVal {
	mut var_thumbnail_id := rt.call_function('get_term_meta', [
		var_brand_id.dup(), rt.new_string('thumbnail_id'), rt.new_bool(true)])
	if rt.is_true(var_thumbnail_id) {
		mut var_thumb_src := rt.call_function('wp_get_attachment_image_src', [
			var_thumbnail_id.dup(), rt.new_string(size)])
	}
	return if !(!rt.is_true(var_thumb_src)) { rt.call_function('current', [
			var_thumb_src.dup()]) } else { rt.new_string('') }
}

fn wc_get_brand_thumbnail_image(var_brand rt.PhpVal, size string) rt.PhpVal {
	mut var_thumbnail_id := rt.call_function('get_term_meta', [
		rt.get_property(var_brand, 'term_id'),
		rt.new_string('thumbnail_id'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), rt.new_string(size)))
		|| rt.is_true(rt.identical(rt.new_string('brand-thumb'), rt.new_string(size)))))
	{
		size = (rt.call_function('apply_filters', [
			rt.new_string('woocommerce_brand_thumbnail_size'),
			rt.new_string('shop_catalog'),
		])).str()
	}
	if rt.is_true(var_thumbnail_id) {
		mut var_image_src := rt.call_function('wp_get_attachment_image_src', [
			var_thumbnail_id.dup(), rt.new_string(size)])
		var_image_src = var_image_src.array_get(0)
		mut var_dimensions := rt.call_function('wc_get_image_size', [
			rt.new_string(size)])
		mut var_image_srcset := if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_get_attachment_image_srcset'),
		]))
		{ rt.call_function('wp_get_attachment_image_srcset', [
				var_thumbnail_id.dup(), rt.new_string(size)]) } else { rt.new_bool(false) }
		mut var_image_sizes := if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_get_attachment_image_sizes'),
		]))
		{ rt.call_function('wp_get_attachment_image_sizes', [
				var_thumbnail_id.dup(), rt.new_string(size)]) } else { rt.new_bool(false) }
	} else {
		var_image_src = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
		var_dimensions = rt.call_function('wc_get_image_size', [
			rt.new_string(size)])
		var_image_srcset = rt.new_bool(rt.new_bool(false))
		var_image_sizes = rt.new_bool(rt.new_bool(false))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_image_srcset) && rt.is_true(var_image_sizes))) {
		mut var_image := rt.new_string('<img src="' +
			(rt.call_function('esc_url', [var_image_src.dup()])).str() + '" alt="' +
			(rt.call_function('esc_attr', [rt.get_property(var_brand, 'name')])).str() +
			'" class="brand-thumbnail" width="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get('width')])).str() +
			'" height="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get('height')])).str() +
			'" srcset="' + (rt.call_function('esc_attr', [var_image_srcset.dup()])).str() +
			'" sizes="' + (rt.call_function('esc_attr', [var_image_sizes.dup()])).str() + '" />')
	} else {
		var_image = rt.new_string('<img src="' +
			(rt.call_function('esc_url', [var_image_src.dup()])).str() + '" alt="' +
			(rt.call_function('esc_attr', [rt.get_property(var_brand, 'name')])).str() +
			'" class="brand-thumbnail" width="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get('width')])).str() +
			'" height="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get('height')])).str() + '" />')
	}
	return var_image.dup()
}

fn wc_get_brands(post_id i64, sep string, before string, after string) rt.PhpVal {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(var_post_id != 0) {
		post_id = (rt.get_property(var_post, 'ID')).to_i64()
	}
	return rt.call_function('get_the_term_list', [rt.new_int(post_id),
		rt.new_string('product_brand'), rt.new_string(before),
		rt.new_string(sep), rt.new_string(after)])
}

fn get_brand_thumbnail_url(var_brand_id rt.PhpVal, size string) rt.PhpVal {
	return wc_get_brand_thumbnail_url(var_brand_id.dup(), size)
}

fn get_brand_thumbnail_image(var_brand rt.PhpVal, size string) rt.PhpVal {
	return wc_get_brand_thumbnail_image(var_brand.dup(), size)
}

fn get_brands(post_id i64, sep string, before string, after string) rt.PhpVal {
	return wc_get_brands(post_id, sep, before, after)
}

pub fn init_wp_content_plugins_woocommerce_includes_wc_brands_functions_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_brand_thumbnail_url'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_brand_thumbnail_image'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_brands'),
	])))))
	{
	}
}
