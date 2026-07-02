import rt

fn wc_get_brand_thumbnail_url(var_brand_id rt.PhpVal, size string) rt.PhpVal {
	mut var_size := size
	mut var_thumbnail_id := rt.new_null()
	mut var_thumb_src := rt.new_null()
	var_thumbnail_id = rt.call_function('get_term_meta', [var_brand_id.clone(),
		rt.new_string('thumbnail_id'), rt.new_bool(true)])
	if rt.is_true(var_thumbnail_id) {
		var_thumb_src = rt.call_function('wp_get_attachment_image_src', [
			var_thumbnail_id.clone(), rt.new_string(size)])
	}
	return if !(!rt.is_true(var_thumb_src)) { rt.call_function('current', [
			var_thumb_src.clone()]) } else { rt.new_string('') }
}

fn wc_get_brand_thumbnail_image(var_brand rt.PhpVal, size string) rt.PhpVal {
	mut var_size := size
	mut var_thumbnail_id := rt.new_null()
	mut var_image_src := rt.new_null()
	mut var_dimensions := rt.new_null()
	mut var_image_srcset := rt.new_null()
	mut var_image_sizes := rt.new_null()
	mut var_image := rt.new_null()
	var_thumbnail_id = rt.call_function('get_term_meta', [
		rt.get_property(var_brand, 'term_id'),
		rt.new_string('thumbnail_id'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_size.str())))
		|| rt.is_true(rt.identical(rt.new_string('brand-thumb'), rt.new_string(var_size.str()))) {
		var_size = (rt.call_function('apply_filters', [
			rt.new_string('woocommerce_brand_thumbnail_size'),
			rt.new_string('shop_catalog'),
		])).str()
	}
	if rt.is_true(var_thumbnail_id) {
		var_image_src = rt.call_function('wp_get_attachment_image_src', [
			var_thumbnail_id.clone(), rt.new_string(var_size.str())])
		var_image_src = var_image_src.array_get(rt.new_int(0))
		var_dimensions = rt.call_function('wc_get_image_size', [
			rt.new_string(var_size.str()),
		])
		var_image_srcset = if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_get_attachment_image_srcset'),
		]))
		{
			rt.call_function('wp_get_attachment_image_srcset', [
				var_thumbnail_id.clone(), rt.new_string(var_size.str())])
		} else {
			rt.new_bool(false)
		}
		var_image_sizes = if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_get_attachment_image_sizes'),
		]))
		{
			rt.call_function('wp_get_attachment_image_sizes', [
				var_thumbnail_id.clone(), rt.new_string(var_size.str())])
		} else {
			rt.new_bool(false)
		}
	} else {
		var_image_src = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
		var_dimensions = rt.call_function('wc_get_image_size', [
			rt.new_string(var_size.str()),
		])
		var_image_srcset = rt.new_bool(false)
		var_image_sizes = rt.new_bool(false)
	}
	if rt.is_true(var_image_srcset) && rt.is_true(var_image_sizes) {
		var_image = rt.new_string('<img src="' +
			(rt.call_function('esc_url', [var_image_src.clone()])).str() + '" alt="' +
			(rt.call_function('esc_attr', [rt.get_property(var_brand, 'name')])).str() +
			'" class="brand-thumbnail" width="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('width'))])).str() +
			'" height="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('height'))])).str() +
			'" srcset="' + (rt.call_function('esc_attr', [var_image_srcset.clone()])).str() +
			'" sizes="' + (rt.call_function('esc_attr', [var_image_sizes.clone()])).str() + '" />')
	} else {
		var_image = rt.new_string('<img src="' +
			(rt.call_function('esc_url', [var_image_src.clone()])).str() + '" alt="' +
			(rt.call_function('esc_attr', [rt.get_property(var_brand, 'name')])).str() +
			'" class="brand-thumbnail" width="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('width'))])).str() +
			'" height="' +
			(rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('height'))])).str() +
			'" />')
	}
	return var_image.clone()
}

fn wc_get_brands(post_id i64, sep string, before string, after string) rt.PhpVal {
	mut var_post_id := post_id
	mut var_sep := sep
	mut var_before := before
	mut var_after := after
	mut var_post := rt.new_null()
	if !(var_post_id != 0) {
		var_post_id = (rt.get_property(var_post, 'ID')).to_i64()
	}
	return rt.call_function('get_the_term_list', [rt.new_int(var_post_id),
		rt.new_string('product_brand'), rt.new_string(before),
		rt.new_string(sep), rt.new_string(after)])
}

fn get_brand_thumbnail_url(var_brand_id rt.PhpVal, size string) rt.PhpVal {
	mut var_size := size
	return wc_get_brand_thumbnail_url(var_brand_id.clone(), var_size)
}

fn get_brand_thumbnail_image(var_brand rt.PhpVal, size string) rt.PhpVal {
	mut var_size := size
	return wc_get_brand_thumbnail_image(var_brand.clone(), var_size)
}

fn get_brands(post_id i64, sep string, before string, after string) rt.PhpVal {
	mut var_post_id := post_id
	mut var_sep := sep
	mut var_before := before
	mut var_after := after
	return wc_get_brands(var_post_id, sep, before, after)
}

fn main() {
	defer {
		rt.shutdown()
	}

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
