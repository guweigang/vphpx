import rt

pub fn Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts.dummy_products() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: 'Vintage Typewriter' },
			rt.ArrayItem{
				key: 'image'
				val: 'assets/images/pattern-placeholders/writing-typing-keyboard-technology-white-vintage.jpg'
			},
			rt.ArrayItem{
				key: 'description'
				val: 'A hit spy novel or a love letter? Anything you type using this vintage typewriter from the 20s is bound to make a mark.'
			},
			rt.ArrayItem{ key: 'price', val: 90 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: 'Leather-Clad Leisure Chair' },
			rt.ArrayItem{
				key: 'image'
				val: 'assets/images/pattern-placeholders/table-wood-house-chair-floor-window.jpg'
			},
			rt.ArrayItem{
				key: 'description'
				val: 'Sit back and relax in this comfy designer chair. High-grain leather and steel frame add luxury to your your leisure.'
			},
			rt.ArrayItem{ key: 'price', val: 249 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: 'Black and White' },
			rt.ArrayItem{
				key: 'image'
				val: 'assets/images/pattern-placeholders/white-black-black-and-white-photograph-monochrome-photography.jpg'
			},
			rt.ArrayItem{
				key: 'description'
				val: 'This 24" x 30" high-quality print just exudes summer. Hang it on the wall and forget about the world outside.'
			},
			rt.ArrayItem{ key: 'price', val: 115 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: '3-Speed Bike' },
			rt.ArrayItem{
				key: 'image'
				val: 'assets/images/pattern-placeholders/road-sport-vintage-wheel-retro-old.jpg'
			},
			rt.ArrayItem{
				key: 'description'
				val: 'Zoom through the streets on this premium 3-speed bike. Manufactured and assembled in Germany in the 80s.'
			},
			rt.ArrayItem{ key: 'price', val: 115 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: 'Hi-Fi Headphones' },
			rt.ArrayItem{
				key: 'image'
				val: 'assets/images/pattern-placeholders/man-person-music-black-and-white-white-photography.jpg'
			},
			rt.ArrayItem{
				key: 'description'
				val: 'Experience your favorite songs in a new way with these premium hi-fi headphones.'
			},
			rt.ArrayItem{ key: 'price', val: 125 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: 'Retro Glass Jug (330 ml)' },
			rt.ArrayItem{
				key: 'image'
				val: 'assets/images/pattern-placeholders/drinkware-liquid-tableware-dishware-bottle-fluid.jpg'
			},
			rt.ArrayItem{
				key: 'description'
				val: 'Thick glass and a classic silhouette make this jug a must-have for any retro-inspired kitchen.'
			},
			rt.ArrayItem{ key: 'price', val: 115 },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) fetch_dummy_products_to_update() rt.PhpVal {
	mut var_real_products := this.fetch_product_ids('')
	mut var_real_products_count := rt.new_int(rt.new_int(var_real_products.dup().array_count()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_real_products.dup().is_array()))
		&& rt.is_true(rt.greater(var_real_products_count, rt.new_int(6)))))
	{
		return rt.create_array([
			rt.ArrayItem{ key: 'product_content', val: rt.new_array() },
		])
	}
	mut var_dummy_products := this.fetch_product_ids('dummy')
	mut var_dummy_products_count := rt.new_int(rt.new_int(var_dummy_products.dup().array_count()))
	mut var_products_to_create := rt.call_function('max', [rt.new_int(0),
		rt.sub(rt.sub(rt.new_int(6), var_real_products_count), var_dummy_products_count)])
	for rt.is_true(rt.greater(var_products_to_create, rt.new_int(0))) {
		this.create_new_product(Class_Automattic_WooCommerce_Blocks_AIContent_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts.dummy_products().array_get(rt.sub(var_products_to_create,
			rt.new_int(1))))
		rt.pre_dec(var_products_to_create)
	}
	mut var_dummy_products_ids := this.fetch_product_ids('dummy')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dummy_products_ids.dup().is_array()))))) {
		return create_wp_error(rt.new_string('failed_to_fetch_dummy_products'), rt.call_function('__', [
			rt.new_string('Failed to fetch dummy products.'),
			rt.new_string('woocommerce'),
		]))
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_function('wc_get_product', [
				rt.get_property(var_product, 'ID'),
			])
		}
		mut var_product := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return rt.call_function('wc_get_product', [rt.get_property(var_product, 'ID')])
	}
	var_dummy_products = rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		var_dummy_products_ids.dup()])
	mut var_dummy_products_to_update := rt.new_array()
	{
		mut iter_1 := var_dummy_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dummy_product := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_dummy_product,
				'Automattic_WooCommerce_Blocks_AIContent_WC_Product'))))))
			{
				continue
			}
			mut var_should_update_dummy_product :=
				rt.new_bool(this.should_update_dummy_product(var_dummy_product.dup()))
			if rt.is_true(var_should_update_dummy_product) {
				var_dummy_products_to_update.array_push(var_dummy_product.dup())
			}
		}
	}
	return var_dummy_products_to_update.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) should_update_dummy_product(var_dummy_product rt.PhpVal) bool {
	mut var_date_created := rt.call_method(var_dummy_product, 'get_date_created', []rt.PhpVal{})
	mut var_date_modified := rt.call_method(var_dummy_product, 'get_date_modified', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_date_created, 'Automattic_WooCommerce_Blocks_AIContent_WC_DateTime'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_date_modified, 'Automattic_WooCommerce_Blocks_AIContent_WC_DateTime'))))))))
	{
		return false
	}
	mut var_formatted_date_created := rt.call_method(rt.call_method(var_dummy_product,
		'get_date_created', []rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')])
	mut var_formatted_date_modified := rt.call_method(rt.call_method(var_dummy_product,
		'get_date_modified', []rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')])
	mut var_timestamp_created := rt.call_function('strtotime', [
		var_formatted_date_created.dup()])
	mut var_timestamp_modified := rt.call_function('strtotime', [
		var_formatted_date_modified.dup()])
	mut var_timestamp_current := rt.call_function('time', []rt.PhpVal{})
	mut var_dummy_product_recently_modified := rt.less(rt.call_function('abs', [
		rt.sub(var_timestamp_current, var_timestamp_modified),
	]), rt.new_int(10))
	mut var_dummy_product_not_modified := rt.less(rt.call_function('abs', [
		rt.sub(var_timestamp_modified, var_timestamp_created),
	]), rt.new_int(60))
	if rt.is_true(rt.new_bool(rt.is_true(var_dummy_product_not_modified)
		|| rt.is_true(var_dummy_product_recently_modified)))
	{
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) create_new_product(var_product_data rt.PhpVal) rt.PhpVal {
	mut var_product := create_automattic_woocommerce_blocks_aicontent_wc_product()
	mut var_image_src := rt.call_function('plugins_url', [var_product_data.array_get('image'),
		rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(2)])])
	mut var_image_alt := var_product_data.array_get('title')
	mut var_product_image_id := this.product_image_upload(var_product.get_id(),
		var_image_src.dup(), var_image_alt.dup())
	mut var_saved_product := this.product_update(rt.new_object('Automattic_WooCommerce_Blocks_AIContent_WC_Product',
		[]string{}, var_product), var_product_image_id.dup(), var_product_data.array_get('title'),
		var_product_data.array_get('description'), var_product_data.array_get('price'))
	if rt.is_true(rt.call_function('is_wp_error', [var_saved_product.dup()])) {
		return var_saved_product.dup()
	}
	return rt.call_function('update_post_meta', [var_saved_product.dup(),
		rt.new_string('_headstart_post'), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) fetch_product_ids(type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string('user_created'), rt.new_string(type))) {
		return rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')), rt.new_string(' WHERE ID NOT IN ( SELECT p.ID FROM ')), rt.get_property(var_wpdb,
					'posts')), rt.new_string(' p JOIN ')), rt.get_property(var_wpdb, 'postmeta')),
					rt.new_string(" pm ON p.ID = pm.post_id WHERE pm.meta_key = %s AND p.post_type = 'product' AND p.post_status = 'publish' ) AND post_type = 'product' AND post_status = 'publish' LIMIT 6")),
				rt.new_string('_headstart_post'),
			]),
		])
	}
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT p.ID FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' p JOIN ')), rt.get_property(var_wpdb, 'postmeta')),
				rt.new_string(" pm ON p.ID = pm.post_id WHERE pm.meta_key = %s AND p.post_type = 'product' AND p.post_status = 'publish'")),
			rt.new_string('_headstart_post'),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) product_image_upload(var_product_id rt.PhpVal, var_image_src rt.PhpVal, var_image_alt rt.PhpVal) rt.PhpVal {
	mut var_image_src_mutated := var_image_src
	mut var_image_alt_mutated := var_image_alt
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	rt.call_function('set_time_limit', [rt.new_int(150)])
	rt.call_function('wp_raise_memory_limit', [rt.new_string('image')])
	return rt.call_function('media_sideload_image', [var_image_src_mutated.dup(),
		var_product_id.dup(), var_image_alt_mutated.dup(), rt.new_string('id')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) product_update(var_product rt.PhpVal, var_product_image_id rt.PhpVal, var_product_title rt.PhpVal, var_product_description rt.PhpVal, var_product_price rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_product_image_id_mutated := var_product_image_id
	if !(true) {
		return create_wp_error(rt.new_string('invalid_product'), rt.call_function('__', [
			rt.new_string('Invalid product.'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_product_image_id_mutated.dup()])))))
	{
		var_product_mutated.set_image_id(var_product_image_id_mutated.dup())
	} else {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The image upload failed: "%s", creating the product without image'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product_image_id_mutated, 'get_error_message', []rt.PhpVal{}),
			]),
		])
	}
	var_product_mutated.set_name(var_product_title.dup())
	var_product_mutated.set_description(var_product_description.dup())
	var_product_mutated.set_price(var_product_price.dup())
	var_product_mutated.set_regular_price(var_product_price.dup())
	var_product_mutated.set_slug(rt.call_function('sanitize_title', [
		var_product_title.dup()]))
	var_product_mutated.save()
	return var_product_mutated.get_id()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_AIContent_WC_Product {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_aicontent_updateproducts() &Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_aicontent_wc_product() &Class_Automattic_WooCommerce_Blocks_AIContent_WC_Product {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AIContent_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fetch_dummy_products_to_update' {
			return this.fetch_dummy_products_to_update()
		}
		'should_update_dummy_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.should_update_dummy_product(dispatch_arg_0))
		}
		'create_new_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_new_product(dispatch_arg_0)
		}
		'fetch_product_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.fetch_product_ids(dispatch_arg_0)
		}
		'product_image_upload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.product_image_upload(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'product_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.product_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdateProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_AIContent_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_aicontent_updateproducts_php() {
}
