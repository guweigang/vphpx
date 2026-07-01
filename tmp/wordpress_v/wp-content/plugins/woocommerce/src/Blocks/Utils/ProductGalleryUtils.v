import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_all_image_ids(var_product rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Blocks_Utils_WC_Product'))))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [rt.new_string('Invalid product object.'),
				rt.new_string('woocommerce')]),
			rt.new_string('9.8.0')])
		return rt.new_array()
	}
	mut var_gallery_image_ids :=
		Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_gallery_image_ids(var_product.dup())
	mut var_product_variation_image_ids :=
		Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_variation_image_ids(var_product.dup())
	mut var_all_image_ids := rt.call_function('array_values', [
		rt.call_function('array_map', [rt.new_string('intval'),
			rt.call_function('array_unique', [
				rt.call_function('array_merge', [var_gallery_image_ids.dup(),
					var_product_variation_image_ids.dup()]),
			])]),
	])
	if !rt.is_true(var_all_image_ids) {
		return rt.new_array()
	}
	return var_all_image_ids.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_gallery_image_data(var_product rt.PhpVal, var_size rt.PhpVal) rt.PhpVal {
	mut var_all_image_ids :=
		Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_all_image_ids(var_product.dup())
	return Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_image_src_data(var_all_image_ids.str(),
		var_size.dup(), rt.call_method(var_product, 'get_title', []rt.PhpVal{}))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_gallery_image_count(var_product rt.PhpVal) i64 {
	mut var_all_image_ids :=
		Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_all_image_ids(var_product.dup())
	return var_all_image_ids.dup().array_count()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_image_src_data(var_image_ids rt.PhpVal, var_size rt.PhpVal, product_title string) rt.PhpVal {
	mut var_image_src_data := rt.new_array()
	{
		mut iter_1 := var_image_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_image_id := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.identical(rt.new_int(0), var_image_id)) {
				var_image_src_data.array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: 0 },
					rt.ArrayItem{ key: 'src', val: rt.call_function('wc_placeholder_img_src',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'srcset', val: '' },
					rt.ArrayItem{ key: 'sizes', val: '' },
					rt.ArrayItem{ key: 'alt', val: '' },
				]))
				continue
			}
			mut var_full_src := rt.call_function('wp_get_attachment_image_src', [
				var_image_id.dup(),
				var_size.dup(),
			])
			mut var_srcset := rt.call_function('wp_get_attachment_image_srcset', [
				var_image_id.dup(),
				var_size.dup(),
			])
			mut var_sizes := rt.call_function('wp_get_attachment_image_sizes', [
				var_image_id.dup(), var_size.dup()])
			mut var_alt := rt.call_function('get_post_meta', [
				var_image_id.dup(), rt.new_string('_wp_attachment_image_alt'),
				rt.new_bool(true)])
			var_image_src_data.array_push(rt.create_array([
				rt.ArrayItem{ key: 'id', val: var_image_id },
				rt.ArrayItem{
					key: 'src'
					val: if rt.is_true(var_full_src) {
						var_full_src.array_get(0)
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{
					key: 'srcset'
					val: if rt.is_true(var_srcset) { var_srcset } else { rt.new_string('') }
				},
				rt.ArrayItem{
					key: 'sizes'
					val: if rt.is_true(var_sizes) { var_sizes } else { rt.new_string('') }
				},
				rt.ArrayItem{
					key: 'alt'
					val: if rt.is_true(var_alt) { var_alt } else { rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('%1$s - Image %2$d'),
								rt.new_string('woocommerce')]),
							rt.new_string(product_title),
							rt.add(var_index, rt.new_int(1)),
						]) }
				},
			]))
		}
	}
	return var_image_src_data.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_variation_image_ids(var_product rt.PhpVal) rt.PhpVal {
	mut var_variation_image_ids := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Blocks_Utils_WC_Product'))))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [rt.new_string('Invalid product object.'),
				rt.new_string('woocommerce')]),
			rt.new_string('9.8.0')])
		return var_variation_image_ids.dup()
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('variable')])) {
		mut var_variations := rt.call_method(var_product, 'get_children', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if !(!rt.is_true(var_variations)) {
			rt.call_function('_prime_post_caches', [var_variations.dup()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		{
			mut iter_1 := var_variations.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_variation_id := item_1.val
				mut var_variation := rt.call_function('wc_get_product', [
					var_variation_id.dup()])
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				if rt.is_true(var_variation) {
					mut var_variation_image_id := rt.call_method(var_variation, 'get_image_id',
						[]rt.PhpVal{})
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_variation_image_id))
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_variation_image_id.dup().to_string()), var_variation_image_ids.dup(), rt.new_bool(true)])))))))
					{
						var_variation_image_ids.array_push(var_variation_image_id.dup().to_string())
						if rt.has_exception() {
							unsafe {
								goto catch_label_1
							}
						}
					}
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blocks_Utils_Exception') {
		mut var_e := var_e_1.dup()
		rt.call_function('error_log', [
			'Error getting product variation image IDs: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(),
		])
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return var_variation_image_ids.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_gallery_image_ids(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_image_ids := rt.new_array()
	mut var_featured_image_id := rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})
	if rt.is_true(var_featured_image_id) {
		var_product_image_ids.array_push(var_featured_image_id.dup())
	}
	mut var_product_gallery_image_ids := rt.call_method(var_product, 'get_gallery_image_ids',
		[]rt.PhpVal{})
	if !(!rt.is_true(var_product_gallery_image_ids)) {
		var_product_image_ids = rt.call_function('array_unique', [
			rt.call_function('array_merge', [var_product_image_ids.dup(),
				var_product_gallery_image_ids.dup()]),
		])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_featured_image_id))))
		&& !rt.is_true(var_product_gallery_image_ids)))
	{
		var_product_image_ids.array_push('0')
	}
	{
		mut iter_1 := var_product_image_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_image_id := item_1.val
			mut var_key := item_1.key
			var_product_image_ids.array_set(var_key, var_image_id.dup().to_string())
		}
	}
	var_product_image_ids = rt.call_function('array_values', [
		var_product_image_ids.dup()])
	return var_product_image_ids.dup()
}

fn create_automattic_woocommerce_blocks_utils_productgalleryutils() &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all_image_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_all_image_ids(dispatch_arg_0)
		}
		'get_product_gallery_image_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_gallery_image_data(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_product_gallery_image_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_gallery_image_count(dispatch_arg_0))
		}
		'get_image_src_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_image_src_data(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'get_product_variation_image_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_variation_image_ids(dispatch_arg_0)
		}
		'get_product_gallery_image_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils.get_product_gallery_image_ids(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_productgalleryutils_php() {
}
