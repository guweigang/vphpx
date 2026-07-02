import rt

struct Class_WC_SmoothGenerator_Generator_Product {
	rt.PhpObjectBase
}

fn init_static_wc_smoothgenerator_generator_product() {
	rt.init_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids', rt.new_array())
	rt.init_static_prop('WC_SmoothGenerator_Generator_Product', 'global_attributes', rt.create_array([
		rt.ArrayItem{ key: 'Color', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'Green' },
			rt.ArrayItem{ key: none, val: 'Blue' },
			rt.ArrayItem{ key: none, val: 'Red' },
			rt.ArrayItem{ key: none, val: 'Yellow' },
			rt.ArrayItem{ key: none, val: 'Indigo' },
			rt.ArrayItem{ key: none, val: 'Violet' },
			rt.ArrayItem{ key: none, val: 'Black' },
			rt.ArrayItem{ key: none, val: 'White' },
			rt.ArrayItem{ key: none, val: 'Orange' },
			rt.ArrayItem{ key: none, val: 'Pink' },
			rt.ArrayItem{ key: none, val: 'Purple' },
		]) },
		rt.ArrayItem{ key: 'Size', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'Small' },
			rt.ArrayItem{ key: none, val: 'Medium' },
			rt.ArrayItem{ key: none, val: 'Large' },
			rt.ArrayItem{ key: none, val: 'XL' },
			rt.ArrayItem{ key: none, val: 'XXL' },
			rt.ArrayItem{ key: none, val: 'XXXL' },
		]) },
		rt.ArrayItem{ key: 'Numeric Size', val: rt.create_array([
			rt.ArrayItem{ key: none, val: '6' },
			rt.ArrayItem{ key: none, val: '7' },
			rt.ArrayItem{ key: none, val: '8' },
			rt.ArrayItem{ key: none, val: '9' },
			rt.ArrayItem{ key: none, val: '10' },
			rt.ArrayItem{ key: none, val: '11' },
			rt.ArrayItem{ key: none, val: '12' },
			rt.ArrayItem{ key: none, val: '13' },
			rt.ArrayItem{ key: none, val: '14' },
			rt.ArrayItem{ key: none, val: '15' },
			rt.ArrayItem{ key: none, val: '16' },
			rt.ArrayItem{ key: none, val: '17' },
			rt.ArrayItem{ key: none, val: '18' },
			rt.ArrayItem{ key: none, val: '19' },
			rt.ArrayItem{ key: none, val: '20' },
		]) },
	]))
}

fn Class_WC_SmoothGenerator_Generator_Product.generate(save bool, var_assoc_args rt.PhpVal) rt.PhpVal {
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	mut var_type :=
		Class_WC_SmoothGenerator_Generator_Product.get_product_type(mut rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](var_assoc_args))
	mut switch_val_1 := var_type
	if true {
		mut var_product := Class_WC_SmoothGenerator_Generator_Product.generate_simple_product()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variable'))) {
		var_product = Class_WC_SmoothGenerator_Generator_Product.generate_variable_product()
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_product.clone()])) {
		return var_product.clone()
	}
	if rt.is_true(var_product) {
		rt.call_method(var_product, 'save', []rt.PhpVal{})
		if rt.is_true(rt.call_function('taxonomy_exists', [
			rt.new_string('product_brand'),
		]))
		{
			mut var_brand_ids := Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_brand', (rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [rt.new_int(1), rt.new_int(3)])).to_i64())
			if !(!rt.is_true(var_brand_ids)) {
				mut var_brand_result := rt.call_function('wp_set_object_terms', [
					rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
					var_brand_ids.clone(),
					rt.new_string('product_brand'),
				])
				if rt.is_true(rt.call_function('is_wp_error', [
					var_brand_result.clone()]))
				{
					return var_brand_result.clone()
				}
			}
		}
	}
	if 100 < rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids').array_count() {
		rt.call_function('shuffle', [
			rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids'),
		])
		rt.set_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids', rt.call_function('array_slice', [
			rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids'),
			rt.new_int(0),
			rt.new_int(50),
		]))
	}
	rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids').array_push(rt.call_method(var_product,
		'get_id', []rt.PhpVal{}))
	rt.call_function('do_action', [rt.new_string('smoothgenerator_product_generated'),
		var_product.clone()])
	return var_product.clone()
}

fn Class_WC_SmoothGenerator_Generator_Product.batch(var_amount rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	mut var_args_mutated := var_args
	mut iife_temp_0 := Class_WC_SmoothGenerator_Generator_Product{}
	mut iife_result_0 := iife_temp_0.validate_batch_amount(var_amount_mutated.clone())
	var_amount_mutated = iife_result_0
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.clone()])) {
		return var_amount_mutated.clone()
	}
	mut var_use_existing_terms :=
		rt.new_bool(!(!rt.is_true(var_args_mutated.array_get(rt.new_string('use-existing-terms')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_use_existing_terms)))) {
		Class_WC_SmoothGenerator_Generator_Product.maybe_generate_terms(var_amount_mutated.to_i64())
	}
	mut var_product_ids := rt.new_array()
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, var_amount_mutated))) { break
		 }
		mut var_product := Class_WC_SmoothGenerator_Generator_Product.generate(true, rt.new_object('WC_SmoothGenerator_Generator_array',
			[]string{}, var_args_mutated))
		if rt.is_true(rt.call_function('is_wp_error', [var_product.clone()])) {
			continue
		}
		var_product_ids.array_push(rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
		rt.post_inc(var_i)
	}
	mut iife_temp_1 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
	mut iife_result_1 := iife_temp_1.clear(rt.new_string('product_cat'))
	mut iife_temp_2 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
	mut iife_result_2 := iife_temp_2.clear(rt.new_string('product_tag'))
	mut iife_temp_3 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
	mut iife_result_3 := iife_temp_3.clear(rt.new_string('product_brand'))
	return var_product_ids.clone()
}

fn Class_WC_SmoothGenerator_Generator_Product.create_global_attribute(var_raw_name rt.PhpVal) rt.PhpVal {
	mut var_raw_name_mutated := var_raw_name
	mut var_slug := rt.call_function('wc_sanitize_taxonomy_name', [
		var_raw_name_mutated.clone()])
	mut var_attribute_id := rt.call_function('wc_create_attribute', [
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_raw_name_mutated },
			rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'order_by', val: 'menu_order' },
			rt.ArrayItem{ key: 'has_archives', val: false }]),
	])
	mut var_taxonomy_name := rt.call_function('wc_attribute_taxonomy_name', [
		var_slug.clone()])
	rt.call_function('register_taxonomy', [var_taxonomy_name.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_' + var_taxonomy_name.str()),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_' + var_taxonomy_name.str()),
			rt.create_array([rt.ArrayItem{ key: 'labels', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_raw_name_mutated },
			]) }, rt.ArrayItem{ key: 'hierarchical', val: true },
				rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{
					key: 'query_var'
					val: true
				}, rt.ArrayItem{ key: 'rewrite', val: false }]),
		])])
	rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'global_attributes').array_set(var_raw_name_mutated, if rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'global_attributes').array_isset(var_raw_name_mutated)
	{
		rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'global_attributes').array_get(var_raw_name_mutated)
	} else {
		rt.new_array()
	})
	rt.call_function('delete_transient', [rt.new_string('wc_attribute_taxonomies')])
	return var_attribute_id.clone()
}

fn Class_WC_SmoothGenerator_Generator_Product.generate_attributes(qty i64, maximum_terms i64) rt.PhpVal {
	mut var_used_names := rt.new_array()
	mut var_attributes := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(qty)))) { break
		 }
		mut var_attribute := create_wc_smoothgenerator_generator_wc_product_attribute()
		var_attribute.set_id(rt.new_int(0))
		var_attribute.set_position(var_i.clone())
		var_attribute.set_visible(rt.new_bool(true))
		var_attribute.set_variation(rt.new_bool(true))
		if rt.is_true(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
			'faker'), 'boolean', []rt.PhpVal{}))
		{
			mut var_raw_name := rt.call_function('array_rand', [
				rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'global_attributes'),
			])
			if rt.is_true(rt.call_function('in_array', [var_raw_name.clone(),
				var_used_names.clone(), rt.new_bool(true)]))
			{
				var_raw_name = rt.call_function('ucfirst', [
					rt.call_function('substr', [
						rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
							'faker'), 'word', []rt.PhpVal{}),
						rt.new_int(0),
						rt.new_int(28),
					]),
				])
			}
			mut var_attribute_labels := rt.call_function('wp_list_pluck', [
				rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}),
				rt.new_string('attribute_label'),
				rt.new_string('attribute_name'),
			])
			mut var_attribute_name := rt.call_function('array_search', [
				var_raw_name.clone(), var_attribute_labels.clone(),
				rt.new_bool(true)])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_name)))) {
				var_attribute_name = rt.call_function('wc_sanitize_taxonomy_name', [
					var_raw_name.clone(),
				])
			}
			mut var_attribute_id := rt.call_function('wc_attribute_taxonomy_id_by_name', [
				var_attribute_name.clone(),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) {
				var_attribute_id =
					Class_WC_SmoothGenerator_Generator_Product.create_global_attribute(var_raw_name.clone())
				if rt.is_true(rt.call_function('is_wp_error', [
					var_attribute_id.clone()]))
				{
					return var_attribute_id.clone()
				}
			}
			mut var_slug := rt.call_function('wc_sanitize_taxonomy_name', [
				var_raw_name.clone()])
			mut var_taxonomy_name := rt.call_function('wc_attribute_taxonomy_name', [
				var_slug.clone(),
			])
			var_attribute.set_name(var_taxonomy_name.clone())
			var_attribute.set_id(var_attribute_id.clone())
			var_used_names.array_push(var_raw_name.clone())
			mut var_num_values := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [rt.new_int(1), rt.new_int(maximum_terms)])
			mut var_values := rt.new_array()
			mut var_existing_values := if rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'global_attributes').array_isset(var_raw_name)
			{
				rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'global_attributes').array_get(var_raw_name)
			} else {
				rt.new_array()
			}
			mut var_j := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_j, var_num_values))) { break
				 }
				mut var_value := rt.new_string('')
				if rt.is_true(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'boolean', [rt.new_int(80)]))
					&& !(!rt.is_true(var_existing_values)) {
					rt.call_function('shuffle', [var_existing_values.clone()])
					var_value = rt.call_function('array_pop', [
						var_existing_values.clone()])
				}
				if !rt.is_true(var_value)
					|| rt.is_true(rt.call_function('in_array', [var_value.clone(), var_values.clone(), rt.new_bool(true)])) {
					var_value = rt.call_function('ucfirst', [
						rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
							'faker'), 'words', [
							rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
								'faker'), 'numberBetween', [rt.new_int(1),
								rt.new_int(2)]),
							rt.new_bool(true),
						]),
					])
				}
				rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'global_attributes').array_get_mut(var_raw_name).array_push(var_value.clone())
				var_values.array_push(var_value.clone())
				rt.post_inc(var_j)
			}
			var_attribute.set_options(var_values.clone())
		} else {
			var_attribute.set_name(rt.call_function('ucfirst', [
				rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'),
					'words', [
					rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'numberBetween', [rt.new_int(1),
						rt.new_int(3)]),
					rt.new_bool(true),
				]),
			]))
			var_attribute.set_options(rt.call_function('array_filter', [
				rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'),
					'words', [
					rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'numberBetween', [rt.new_int(2),
						rt.new_int(4)]),
					rt.new_bool(false),
				]),
			]), rt.new_string('ucfirst'))
		}
		var_attributes.array_push(var_attribute)
		rt.post_inc(var_i)
	}
	return var_attributes.clone()
}

fn Class_WC_SmoothGenerator_Generator_Product.get_product_type(mut var_assoc_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_type := if !(var_assoc_args.array_get(rt.new_string('type'))).is_null() {
		var_assoc_args.array_get(rt.new_string('type'))
	} else {
		rt.new_null()
	}
	mut var_types := rt.create_array([rt.ArrayItem{ key: none, val: 'simple' },
		rt.ArrayItem{ key: none, val: 'variable' }])
	if !(var_type.clone().is_null())
		&& rt.is_true(rt.call_function('in_array', [var_type.clone(), var_types.clone(), rt.new_bool(true)])) {
		return var_type.clone()
	} else {
		mut iife_temp_4 := Class_WC_SmoothGenerator_Generator_Product{}
		mut iife_result_4 := iife_temp_4.random_weighted_element(rt.create_array([
			rt.ArrayItem{ key: 'simple', val: 80 },
			rt.ArrayItem{ key: 'variable', val: 20 },
		]))
		return iife_result_4
	}
	return rt.new_null()
}

fn Class_WC_SmoothGenerator_Generator_Product.generate_variable_product() rt.PhpVal {
	mut var_name := rt.call_function('ucwords', [
		rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'),
			'productName'),
	])
	mut var_will_manage_stock := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'faker'), 'boolean', []rt.PhpVal{})
	mut var_product := create_wc_smoothgenerator_generator_wc_product_variable()
	mut var_gallery := Class_WC_SmoothGenerator_Generator_Product.maybe_get_gallery_image_ids()
	mut var_attributes := Class_WC_SmoothGenerator_Generator_Product.generate_attributes((rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'faker'), 'numberBetween', [rt.new_int(1), rt.new_int(3)])).to_i64(), 5)
	if rt.is_true(rt.call_function('is_wp_error', [var_attributes.clone()])) {
		return var_attributes.clone()
	}
	mut iife_temp_5 := Class_WC_SmoothGenerator_Generator_Product{}
	mut iife_result_5 := iife_temp_5.get_image()
	rt.call_method(var_product, 'set_props', [
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_name },
			rt.ArrayItem{ key: 'featured', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'boolean', [rt.new_int(10)]) }, rt.ArrayItem{
				key: 'sku'
				val: (rt.call_function('sanitize_title', [var_name.clone()])).str() + '-' +(rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'ean8')).str()
			}, rt.ArrayItem{ key: 'global_unique_id', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'randomElement', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'ean13') },
					rt.ArrayItem{ key: none, val: rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'isbn10') },
				]),
			]) }, rt.ArrayItem{ key: 'attributes', val: var_attributes },
			rt.ArrayItem{ key: 'tax_status', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'randomElement', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'taxable' },
					rt.ArrayItem{ key: none, val: 'shipping' },
					rt.ArrayItem{ key: none, val: 'none' },
				]),
			]) }, rt.ArrayItem{ key: 'tax_class', val: '' }, rt.ArrayItem{
				key: 'manage_stock'
				val: var_will_manage_stock
			}, rt.ArrayItem{
				key: 'stock_quantity'
				val: if rt.is_true(var_will_manage_stock) { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(-100),
						rt.new_int(100),
					]) } else { rt.new_null() }
			}, rt.ArrayItem{ key: 'stock_status', val: 'instock' },
			rt.ArrayItem{ key: 'backorders', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'randomElement', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'yes' },
					rt.ArrayItem{ key: none, val: 'no' },
					rt.ArrayItem{ key: none, val: 'notify' },
				]),
			]) }, rt.ArrayItem{ key: 'sold_individually', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'boolean', [
				rt.new_int(20),
			]) }, rt.ArrayItem{
				key: 'upsell_ids'
				val: Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids()
			}, rt.ArrayItem{
				key: 'cross_sell_ids'
				val: Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids()
			}, rt.ArrayItem{ key: 'image_id', val: iife_result_5 },
			rt.ArrayItem{ key: 'category_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_cat', (rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [
				rt.new_int(0),
				rt.new_int(3),
			])).to_i64()) }, rt.ArrayItem{ key: 'tag_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_tag', (rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [
				rt.new_int(0),
				rt.new_int(5),
			])).to_i64()) }, rt.ArrayItem{ key: 'gallery_image_ids', val: var_gallery },
			rt.ArrayItem{ key: 'reviews_allowed', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'boolean', []rt.PhpVal{}) }, rt.ArrayItem{
				key: 'purchase_note'
				val: if rt.is_true(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
					'faker'), 'boolean', []rt.PhpVal{}))
				{
					rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'text', []rt.PhpVal{})
				} else {
					rt.new_string('')
				}
			}, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [
				rt.new_int(0),
				rt.new_int(10000),
			]) }]),
	])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
	mut var_variation_attributes := rt.call_function('wc_list_pluck', [
		rt.call_function('array_filter', [
			rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}),
			rt.new_string('wc_attributes_array_filter_variation'),
		]),
		rt.new_string('get_slugs'),
	])
	mut var_possible_attributes := rt.call_function('array_reverse', [
		rt.call_function('wc_array_cartesian', [var_variation_attributes.clone()]),
	])
	mut iter_1 := var_possible_attributes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_possible_attribute := item_1.val
		mut var_price := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
			'faker'), 'randomFloat', [rt.new_int(2), rt.new_int(1),
			rt.new_int(1000)])
		mut var_is_on_sale := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
			'faker'), 'boolean', [rt.new_int(35)])
		mut var_has_sale_schedule := rt.new_bool(rt.is_true(var_is_on_sale)
			&& rt.is_true(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'boolean', [rt.new_int(40)])))
		mut var_sale_price := if rt.is_true(var_is_on_sale) { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'randomFloat', [
				rt.new_int(2),
				rt.new_int(0),
				var_price.clone(),
			]) } else { rt.new_string('') }
		mut var_date_on_sale_from := if rt.is_true(var_has_sale_schedule) { rt.call_method(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'dateTimeBetween', [
				rt.new_string('-3 days'),
				rt.new_string('+3 days'),
			]), 'format', [rt.get_constant('DATE_ATOM')]) } else { rt.new_string('') }
		mut var_date_on_sale_to := if rt.is_true(var_has_sale_schedule) { rt.call_method(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'dateTimeBetween', [
				rt.new_string('+4 days'),
				rt.new_string('+4 months'),
			]), 'format', [rt.get_constant('DATE_ATOM')]) } else { rt.new_string('') }
		mut var_is_virtual := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
			'faker'), 'boolean', [rt.new_int(20)])
		mut var_variation := create_wc_smoothgenerator_generator_wc_product_variation()
		mut iife_temp_6 := Class_WC_SmoothGenerator_Generator_Product{}
		mut iife_result_6 := iife_temp_6.get_image()
		var_variation.set_props(rt.create_array([
			rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_product, 'get_id',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: var_possible_attribute },
			rt.ArrayItem{ key: 'regular_price', val: var_price },
			rt.ArrayItem{ key: 'sale_price', val: var_sale_price },
			rt.ArrayItem{ key: 'date_on_sale_from', val: var_date_on_sale_from },
			rt.ArrayItem{ key: 'date_on_sale_to', val: var_date_on_sale_to },
			rt.ArrayItem{ key: 'tax_status', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'randomElement', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'taxable' },
					rt.ArrayItem{ key: none, val: 'shipping' },
					rt.ArrayItem{ key: none, val: 'none' }]),
			]) },
			rt.ArrayItem{ key: 'tax_class', val: '' },
			rt.ArrayItem{ key: 'manage_stock', val: var_will_manage_stock },
			rt.ArrayItem{
				key: 'stock_quantity'
				val: if rt.is_true(var_will_manage_stock) { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(-20),
						rt.new_int(100),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{ key: 'stock_status', val: 'instock' },
			rt.ArrayItem{
				key: 'weight'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			},
			rt.ArrayItem{
				key: 'length'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			},
			rt.ArrayItem{
				key: 'width'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			},
			rt.ArrayItem{
				key: 'height'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			},
			rt.ArrayItem{ key: 'virtual', val: var_is_virtual },
			rt.ArrayItem{ key: 'downloadable', val: false },
			rt.ArrayItem{ key: 'image_id', val: iife_result_6 },
		]))
		if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			rt.new_string('Automattic\\WooCommerce\\Internal\\CostOfGoodsSold\\CostOfGoodsSoldController'),
		]), 'feature_is_enabled', []rt.PhpVal{}))
		{
			var_variation.set_props(rt.create_array([
				rt.ArrayItem{ key: 'cogs_value', val: rt.call_function('round', [
					rt.mul(var_price, rt.sub(rt.new_int(1), rt.div(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'numberBetween', [rt.new_int(15),
						rt.new_int(60)]), rt.new_int(100)))),
					rt.new_int(2),
				]) },
			]))
		}
		var_variation.save()
	}
	mut var_data_store := rt.call_method(var_product, 'get_data_store', []rt.PhpVal{})
	rt.call_method(var_data_store, 'sort_all_product_variations', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
	])
	return var_product.clone()
}

fn Class_WC_SmoothGenerator_Generator_Product.generate_simple_product() rt.PhpVal {
	mut var_name := rt.call_function('ucwords', [
		rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'),
			'productName'),
	])
	mut var_will_manage_stock := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'faker'), 'boolean', []rt.PhpVal{})
	mut var_is_virtual := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'faker'), 'boolean', []rt.PhpVal{})
	mut var_price := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'faker'), 'randomFloat', [rt.new_int(2), rt.new_int(1),
		rt.new_int(1000)])
	mut var_is_on_sale := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'faker'), 'boolean', [rt.new_int(35)])
	mut var_has_sale_schedule := rt.new_bool(rt.is_true(var_is_on_sale)
		&& rt.is_true(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'boolean', [rt.new_int(40)])))
	mut var_sale_price := if rt.is_true(var_is_on_sale) { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'randomFloat', [
			rt.new_int(2),
			rt.new_int(0),
			var_price.clone(),
		]) } else { rt.new_string('') }
	mut var_date_on_sale_from := if rt.is_true(var_has_sale_schedule) { rt.call_method(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'dateTimeBetween', [
			rt.new_string('-3 days'),
			rt.new_string('+3 days'),
		]), 'format', [rt.get_constant('DATE_ATOM')]) } else { rt.new_string('') }
	mut var_date_on_sale_to := if rt.is_true(var_has_sale_schedule) { rt.call_method(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'dateTimeBetween', [
			rt.new_string('+4 days'),
			rt.new_string('+4 months'),
		]), 'format', [rt.get_constant('DATE_ATOM')]) } else { rt.new_string('') }
	mut var_product := create_wc_smoothgenerator_generator_wc_product()
	mut iife_temp_7 := Class_WC_SmoothGenerator_Generator_Product{}
	mut iife_result_7 := iife_temp_7.get_image()
	mut var_image_id := iife_result_7
	mut var_gallery := Class_WC_SmoothGenerator_Generator_Product.maybe_get_gallery_image_ids()
	rt.call_method(var_product, 'set_props', [
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_name },
			rt.ArrayItem{ key: 'featured', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'boolean', []rt.PhpVal{}) }, rt.ArrayItem{
				key: 'catalog_visibility'
				val: 'visible'
			}, rt.ArrayItem{ key: 'description', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'paragraphs', [
				rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'),
					'numberBetween', [rt.new_int(1), rt.new_int(5)]),
				rt.new_bool(true),
			]) }, rt.ArrayItem{ key: 'short_description', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'text', []rt.PhpVal{}) }, rt.ArrayItem{
				key: 'sku'
				val: (rt.call_function('sanitize_title', [var_name.clone()])).str() + '-' +(rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'ean8')).str()
			}, rt.ArrayItem{ key: 'global_unique_id', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'randomElement', [
				rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
					'faker'), 'ean13') }, rt.ArrayItem{ key: none, val: rt.get_property(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
					'faker'), 'isbn10') }]),
			]) }, rt.ArrayItem{ key: 'regular_price', val: var_price },
			rt.ArrayItem{ key: 'sale_price', val: var_sale_price },
			rt.ArrayItem{ key: 'date_on_sale_from', val: var_date_on_sale_from },
			rt.ArrayItem{ key: 'date_on_sale_to', val: var_date_on_sale_to },
			rt.ArrayItem{ key: 'total_sales', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [
				rt.new_int(0),
				rt.new_int(10000),
			]) }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'randomElement', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'taxable' },
					rt.ArrayItem{ key: none, val: 'shipping' },
					rt.ArrayItem{ key: none, val: 'none' }]),
			]) }, rt.ArrayItem{ key: 'tax_class', val: '' }, rt.ArrayItem{
				key: 'manage_stock'
				val: var_will_manage_stock
			}, rt.ArrayItem{
				key: 'stock_quantity'
				val: if rt.is_true(var_will_manage_stock) { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(-100),
						rt.new_int(100),
					]) } else { rt.new_null() }
			}, rt.ArrayItem{ key: 'stock_status', val: 'instock' },
			rt.ArrayItem{ key: 'backorders', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'randomElement', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'yes' },
					rt.ArrayItem{ key: none, val: 'no' }, rt.ArrayItem{ key: none, val: 'notify' }]),
			]) }, rt.ArrayItem{ key: 'sold_individually', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'boolean', [
				rt.new_int(20),
			]) }, rt.ArrayItem{
				key: 'weight'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			}, rt.ArrayItem{
				key: 'length'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			}, rt.ArrayItem{
				key: 'width'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			}, rt.ArrayItem{
				key: 'height'
				val: if rt.is_true(var_is_virtual) { rt.new_string('') } else { rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'faker'), 'numberBetween', [
						rt.new_int(1),
						rt.new_int(200),
					]) }
			}, rt.ArrayItem{
				key: 'upsell_ids'
				val: Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids()
			}, rt.ArrayItem{
				key: 'cross_sell_ids'
				val: Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids()
			}, rt.ArrayItem{ key: 'parent_id', val: 0 }, rt.ArrayItem{ key: 'reviews_allowed', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'boolean', []rt.PhpVal{}) }, rt.ArrayItem{
				key: 'purchase_note'
				val: if rt.is_true(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
					'faker'), 'boolean', []rt.PhpVal{}))
				{
					rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'text', []rt.PhpVal{})
				} else {
					rt.new_string('')
				}
			}, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [
				rt.new_int(0),
				rt.new_int(10000),
			]) }, rt.ArrayItem{ key: 'virtual', val: var_is_virtual },
			rt.ArrayItem{ key: 'downloadable', val: false }, rt.ArrayItem{ key: 'category_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_cat', (rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [
				rt.new_int(0),
				rt.new_int(3),
			])).to_i64()) }, rt.ArrayItem{ key: 'tag_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_tag', (rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
				'faker'), 'numberBetween', [
				rt.new_int(0),
				rt.new_int(5),
			])).to_i64()) }, rt.ArrayItem{ key: 'shipping_class_id', val: 0 },
			rt.ArrayItem{ key: 'image_id', val: var_image_id },
			rt.ArrayItem{ key: 'gallery_image_ids', val: var_gallery }]),
	])
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		rt.new_string('Automattic\\WooCommerce\\Internal\\CostOfGoodsSold\\CostOfGoodsSoldController'),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		rt.call_method(var_product, 'set_props', [
			rt.create_array([
				rt.ArrayItem{ key: 'cogs_value', val: rt.call_function('round', [
					rt.mul(var_price, rt.sub(rt.new_int(1), rt.div(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
						'faker'), 'numberBetween', [rt.new_int(15),
						rt.new_int(60)]), rt.new_int(100)))),
					rt.new_int(2),
				]) },
			]),
		])
	}
	return var_product.clone()
}

fn Class_WC_SmoothGenerator_Generator_Product.maybe_generate_terms(product_amount i64) {
	if product_amount < 10 {
		mut var_cats := rt.new_int(5)
		mut var_cat_depth := rt.new_int(1)
		mut var_tags := rt.new_int(10)
		mut var_brands := rt.new_int(5)
	} else if product_amount < 50 {
		var_cats = rt.new_int(10)
		var_cat_depth = rt.new_int(2)
		var_tags = rt.new_int(20)
		var_brands = rt.new_int(10)
	} else {
		var_cats = rt.new_int(20)
		var_cat_depth = rt.new_int(3)
		var_tags = rt.new_int(40)
		var_brands = rt.new_int(10)
	}
	mut var_existing_cats := rt.new_int(Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_cat',
		var_cats.to_i64()).array_count())
	if rt.is_true(rt.less(var_existing_cats, var_cats)) {
		mut iife_temp_8 := Class_WC_SmoothGenerator_Generator_Term{}
		mut iife_result_8 := iife_temp_8.batch(rt.sub(var_cats, var_existing_cats),
			rt.new_string('product_cat'), rt.create_array([
			rt.ArrayItem{ key: 'max-depth', val: var_cat_depth },
		]))
		mut iife_temp_9 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
		mut iife_result_9 := iife_temp_9.clear(rt.new_string('product_cat'))
	}
	mut var_existing_tags := rt.new_int(Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_tag',
		var_tags.to_i64()).array_count())
	if rt.is_true(rt.less(var_existing_tags, var_tags)) {
		mut iife_temp_10 := Class_WC_SmoothGenerator_Generator_Term{}
		mut iife_result_10 := iife_temp_10.batch(rt.sub(var_tags, var_existing_tags),
			rt.new_string('product_tag'))
		mut iife_temp_11 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
		mut iife_result_11 := iife_temp_11.clear(rt.new_string('product_tag'))
	}
	mut var_existing_brands := rt.new_int(Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_brand',
		var_brands.to_i64()).array_count())
	if rt.is_true(rt.less(var_existing_brands, var_brands)) {
		mut iife_temp_12 := Class_WC_SmoothGenerator_Generator_Term{}
		mut iife_result_12 := iife_temp_12.batch(rt.sub(var_brands, var_existing_brands),
			rt.new_string('product_brand'))
		mut iife_temp_13 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
		mut iife_result_13 := iife_temp_13.clear(rt.new_string('product_brand'))
	}
}

fn Class_WC_SmoothGenerator_Generator_Product.get_term_ids(taxonomy string, limit i64) rt.PhpVal {
	if limit <= 0 {
		return rt.new_array()
	}
	mut iife_temp_14 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
	mut iife_result_14 := iife_temp_14.exists(rt.new_string(taxonomy))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_14)))) {
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy },
			rt.ArrayItem{ key: 'number', val: 50 }, rt.ArrayItem{ key: 'orderby', val: 'count' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'hide_empty', val: false },
			rt.ArrayItem{ key: 'fields', val: 'ids' }])
		if rt.is_true(rt.identical(rt.new_string('product_cat'), rt.new_string(taxonomy))) {
			mut var_uncategorized := rt.call_function('get_term_by', [
				rt.new_string('slug'),
				rt.new_string('uncategorized'),
				rt.new_string('product_cat'),
			])
			if rt.is_true(var_uncategorized) {
				var_args.array_set('exclude', rt.get_property(var_uncategorized, 'term_id'))
			}
		}
		mut var_term_ids := rt.call_function('get_terms', [var_args.clone()])
		mut iife_temp_15 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
		mut iife_result_15 := iife_temp_15.set(rt.new_string(taxonomy), var_term_ids.clone())
	}
	mut iife_temp_16 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
	mut iife_result_16 := iife_temp_16.shuffle(rt.new_string(taxonomy))
	mut iife_temp_17 := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}
	mut iife_result_17 := iife_temp_17.get(rt.new_string(taxonomy), rt.new_int(limit))
	return iife_result_17
}

fn Class_WC_SmoothGenerator_Generator_Product.maybe_get_gallery_image_ids() rt.PhpVal {
	mut var_gallery := rt.new_array()
	mut var_create_gallery := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'faker'), 'boolean', [rt.new_int(10)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_create_gallery)))) {
		return rt.new_null()
	}
	mut var_image_count := rt.call_function('wp_rand', [rt.new_int(0),
		rt.new_int(3)])
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_image_count))) { break
		 }
		mut iife_temp_18 := Class_WC_SmoothGenerator_Generator_Product{}
		mut iife_result_18 := iife_temp_18.get_image()
		var_gallery.array_push(iife_result_18)
		rt.post_inc(var_i)
	}
	return var_gallery.clone()
}

fn Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids(limit i64) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('WC_SmoothGenerator_Generator_Product',
		'product_ids')))))
	{
		rt.set_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids', rt.call_function('wc_get_products', [
			rt.create_array([rt.ArrayItem{ key: 'limit', val: limit },
				rt.ArrayItem{ key: 'return', val: 'ids' }, rt.ArrayItem{
					key: 'status'
					val: 'publish'
				}, rt.ArrayItem{ key: 'orderby', val: 'rand' }]),
		]))
	}
	mut var_random_limit := rt.call_function('wp_rand', [rt.new_int(0),
		rt.new_int(limit)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_random_limit)))) {
		return rt.new_array()
	}
	rt.call_function('shuffle', [
		rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids'),
	])
	return rt.call_function('array_slice', [
		rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids'),
		rt.new_int(0),
		rt.call_function('min', [
			rt.new_int(rt.get_static_prop('WC_SmoothGenerator_Generator_Product', 'product_ids').array_count()),
			var_random_limit.clone(),
		]),
	])
}

struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Util_RandomRuntimeCache {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Product_Variable {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Product_Variation {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Term {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_product(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Product {
	mut obj := &Class_WC_SmoothGenerator_Generator_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_generator(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_util_randomruntimecache(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Util_RandomRuntimeCache {
	mut obj := &Class_WC_SmoothGenerator_Util_RandomRuntimeCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_attribute(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Product_Attribute {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_variable(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Product_Variable {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Variable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_variation(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Product_Variation {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Variation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Product {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_term(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Term {
	mut obj := &Class_WC_SmoothGenerator_Generator_Term{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Product.generate(dispatch_arg_0,
				dispatch_arg_1)
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WC_SmoothGenerator_Generator_Product.batch(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'create_global_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Product.create_global_attribute(dispatch_arg_0)
		}
		'generate_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Product.generate_attributes(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_product_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WC_SmoothGenerator_Generator_Product.get_product_type(mut dispatch_arg_0)
		}
		'generate_variable_product' {
			return Class_WC_SmoothGenerator_Generator_Product.generate_variable_product()
		}
		'generate_simple_product' {
			return Class_WC_SmoothGenerator_Generator_Product.generate_simple_product()
		}
		'maybe_generate_terms' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			Class_WC_SmoothGenerator_Generator_Product.maybe_generate_terms(dispatch_arg_0)
			return rt.new_null()
		}
		'get_term_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Product.get_term_ids(dispatch_arg_0,
				dispatch_arg_1)
		}
		'maybe_get_gallery_image_ids' {
			return Class_WC_SmoothGenerator_Generator_Product.maybe_get_gallery_image_ids()
		}
		'get_existing_product_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Util_RandomRuntimeCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Util_RandomRuntimeCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Util_RandomRuntimeCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Product_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Variable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Product_Variable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Variable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Variation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Product_Variation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Variation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Term) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Term) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Term) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
