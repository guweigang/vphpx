import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_get_gallery_image_html'),
	])))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return rt.new_string('')
	}
	mut var_attachment_ids := rt.call_method(var_product, 'get_gallery_image_ids', []rt.PhpVal{})
	if rt.is_true(var_attachment_ids)
		&& rt.is_true(rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})) {
		mut iter_1 := var_attachment_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attachment_id := item_1.val
			mut var_key := item_1.key
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_single_product_image_thumbnail_html'),
				rt.call_function('wc_get_gallery_image_html', [
					var_attachment_id.clone(), rt.new_bool(false),
					var_key.clone()]),
				var_attachment_id.clone(),
			]))
		}
	}
}
