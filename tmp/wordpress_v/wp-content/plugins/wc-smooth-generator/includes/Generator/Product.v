import rt

struct Class_WC_SmoothGenerator_Generator_Product {
	rt.PhpObjectBase
pub mut:
		product_ids rt.PhpVal = rt.new_array()
		global_attributes rt.PhpVal = rt.new_array()
}

fn Class_WC_SmoothGenerator_Generator_Product.generate(save bool, var_assoc_args rt.PhpVal) rt.PhpVal {
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	mut var_type := Class_WC_SmoothGenerator_Generator_Product.get_product_type(mut rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](var_assoc_args))
	mut switch_val_1 := var_type
	if true {
		mut var_product := Class_WC_SmoothGenerator_Generator_Product.generate_simple_product()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variable'))) {
		var_product = Class_WC_SmoothGenerator_Generator_Product.generate_variable_product()
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_product.dup()])) {
		return var_product.dup()
	}
	if rt.is_true(var_product) {
		rt.call_method(var_product, 'save', []rt.PhpVal{})
		if rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string('product_brand')])) {
			mut var_brand_ids := Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_brand', (rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(1), rt.new_int(3)])).to_i64())
			if !(!rt.is_true(var_brand_ids)) {
				mut var_brand_result := rt.call_function('wp_set_object_terms', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_brand_ids.dup(), rt.new_string('product_brand')])
				if rt.is_true(rt.call_function('is_wp_error', [var_brand_result.dup()])) {
					return var_brand_result.dup()
				}
			}
		}
	}
	if 100 < // unsupported expression: Expr_StaticPropertyFetch.array_count() {
		rt.call_function('shuffle', [// unsupported expression: Expr_StaticPropertyFetch])
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_push(rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
	rt.call_function('do_action', [rt.new_string('smoothgenerator_product_generated'), var_product.dup()])
	return var_product.dup()
}

fn Class_WC_SmoothGenerator_Generator_Product.batch(var_amount rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	mut var_args_mutated := var_args
	var_amount_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Product{}; return temp.validate_batch_amount(arg_0) }(var_amount_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.dup()])) {
		return var_amount_mutated.dup()
	}
	mut var_use_existing_terms := rt.new_bool(rt.new_bool(!(!rt.is_true(var_args_mutated.array_get('use-existing-terms')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_use_existing_terms)))) {
		Class_WC_SmoothGenerator_Generator_Product.maybe_generate_terms((var_amount_mutated).to_i64())
	}
	mut var_product_ids := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_amount_mutated))) { break }
			mut var_product := Class_WC_SmoothGenerator_Generator_Product.generate(true, rt.new_object('WC_SmoothGenerator_Generator_array', []string{}, var_args_mutated))
			if rt.is_true(rt.call_function('is_wp_error', [var_product.dup()])) {
				continue
			}
			var_product_ids.array_push(rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
			rt.post_inc(var_i)
		}
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}; return temp.clear(arg_0) }(rt.new_string('product_cat'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}; return temp.clear(arg_0) }(rt.new_string('product_tag'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Util_RandomRuntimeCache{}; return temp.clear(arg_0) }(rt.new_string('product_brand'))
	return var_product_ids.dup()
}

fn Class_WC_SmoothGenerator_Generator_Product.create_global_attribute(var_raw_name rt.PhpVal) rt.PhpVal {
	mut var_raw_name_mutated := var_raw_name
	mut var_slug := rt.call_function('wc_sanitize_taxonomy_name', [var_raw_name_mutated.dup()])
	mut var_attribute_id := rt.call_function('wc_create_attribute', [rt.create_array([rt.ArrayItem{ key: 'name', val: var_raw_name_mutated }, rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'order_by', val: 'menu_order' }, rt.ArrayItem{ key: 'has_archives', val: false }])])
	mut var_taxonomy_name := rt.call_function('wc_attribute_taxonomy_name', [var_slug.dup()])
	rt.call_function('register_taxonomy', [var_taxonomy_name.dup(), rt.call_function('apply_filters', ['woocommerce_taxonomy_objects_' + (var_taxonomy_name).str(), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }])]), rt.call_function('apply_filters', ['woocommerce_taxonomy_args_' + (var_taxonomy_name).str(), rt.create_array([rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: var_raw_name_mutated }]) }, rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: 'query_var', val: true }, rt.ArrayItem{ key: 'rewrite', val: false }])])])
	// unsupported expression: Expr_StaticPropertyFetch.array_set(var_raw_name_mutated, if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_raw_name_mutated) { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_raw_name_mutated) } else { rt.new_array() })
	rt.call_function('delete_transient', [rt.new_string('wc_attribute_taxonomies')])
	return var_attribute_id.dup()
}

fn Class_WC_SmoothGenerator_Generator_Product.generate_attributes(qty i64, maximum_terms i64) rt.PhpVal {
	mut var_used_names := rt.new_array()
	mut var_attributes := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(qty)))) { break }
			mut var_attribute := create_wc_smoothgenerator_generator_wc_product_attribute()
			var_attribute.set_id(rt.new_int(0))
			var_attribute.set_position(var_i.dup())
			var_attribute.set_visible(rt.new_bool(true))
			var_attribute.set_variation(rt.new_bool(true))
			if rt.is_true(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', []rt.PhpVal{})) {
				mut var_raw_name := rt.call_function('array_rand', [// unsupported expression: Expr_StaticPropertyFetch])
				if rt.is_true(rt.call_function('in_array', [var_raw_name.dup(), var_used_names.dup(), rt.new_bool(true)])) {
					var_raw_name = rt.call_function('ucfirst', [rt.call_function('substr', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'word', []rt.PhpVal{}), rt.new_int(0), rt.new_int(28)])])
				}
				mut var_attribute_labels := rt.call_function('wp_list_pluck', [rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}), rt.new_string('attribute_label'), rt.new_string('attribute_name')])
				mut var_attribute_name := rt.call_function('array_search', [var_raw_name.dup(), var_attribute_labels.dup(), rt.new_bool(true)])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_name)))) {
					var_attribute_name = rt.call_function('wc_sanitize_taxonomy_name', [var_raw_name.dup()])
				}
				mut var_attribute_id := rt.call_function('wc_attribute_taxonomy_id_by_name', [var_attribute_name.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) {
					var_attribute_id = Class_WC_SmoothGenerator_Generator_Product.create_global_attribute(var_raw_name.dup())
					if rt.is_true(rt.call_function('is_wp_error', [var_attribute_id.dup()])) {
						return var_attribute_id.dup()
					}
				}
				mut var_slug := rt.call_function('wc_sanitize_taxonomy_name', [var_raw_name.dup()])
				mut var_taxonomy_name := rt.call_function('wc_attribute_taxonomy_name', [var_slug.dup()])
				var_attribute.set_name(var_taxonomy_name.dup())
				var_attribute.set_id(var_attribute_id.dup())
				var_used_names.array_push(var_raw_name.dup())
				mut var_num_values := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(1), rt.new_int(maximum_terms)])
				mut var_values := rt.new_array()
				mut var_existing_values := if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_raw_name) { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_raw_name) } else { rt.new_array() }
				{
					mut var_j := rt.new_int(rt.new_int(0))
					for {
						if !(rt.is_true(rt.less(var_j, var_num_values))) { break }
						mut var_value := rt.new_string(rt.new_string(''))
						if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', [rt.new_int(80)])) && !(!rt.is_true(var_existing_values)))) {
							rt.call_function('shuffle', [var_existing_values.dup()])
							var_value = rt.call_function('array_pop', [var_existing_values.dup()])
						}
						if rt.is_true(rt.new_bool(!rt.is_true(var_value) || rt.is_true(rt.call_function('in_array', [var_value.dup(), var_values.dup(), rt.new_bool(true)])))) {
							var_value = rt.call_function('ucfirst', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'words', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(1), rt.new_int(2)]), rt.new_bool(true)])])
						}
						// unsupported expression: Expr_StaticPropertyFetch.array_get_mut(var_raw_name).array_push(var_value.dup())
						var_values.array_push(var_value.dup())
						rt.post_inc(var_j)
					}
				}
				var_attribute.set_options(var_values.dup())
			} else {
				var_attribute.set_name(rt.call_function('ucfirst', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'words', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(1), rt.new_int(3)]), rt.new_bool(true)])]))
				var_attribute.set_options(rt.call_function('array_filter', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'words', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(2), rt.new_int(4)]), rt.new_bool(false)])]), rt.new_string('ucfirst'))
			}
			var_attributes.array_push(var_attribute.dup())
			rt.post_inc(var_i)
		}
	}
	return var_attributes.dup()
}

fn Class_WC_SmoothGenerator_Generator_Product.get_product_type(mut var_assoc_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_type := if !(var_assoc_args.array_get('type')).is_null() { var_assoc_args.array_get('type') } else { rt.new_null() }
	mut var_types := rt.create_array([rt.ArrayItem{ key: none, val: 'simple' }, rt.ArrayItem{ key: none, val: 'variable' }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_type.dup().is_null()))))) && rt.is_true(rt.call_function('in_array', [var_type.dup(), var_types.dup(), rt.new_bool(true)])))) {
		return var_type.dup()
	} else {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Product{}; return temp.random_weighted_element(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'simple', val: 80 }, rt.ArrayItem{ key: 'variable', val: 20 }]))
	}
	return rt.new_null()
}

fn Class_WC_SmoothGenerator_Generator_Product.generate_variable_product() rt.PhpVal {
	mut var_name := rt.call_function('ucwords', [rt.get_property(// unsupported expression: Expr_StaticPropertyFetch, 'productName')])
	mut var_will_manage_stock := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', []rt.PhpVal{})
	mut var_product := create_wc_smoothgenerator_generator_wc_product_variable()
	mut var_gallery := Class_WC_SmoothGenerator_Generator_Product.maybe_get_gallery_image_ids()
	mut var_attributes := Class_WC_SmoothGenerator_Generator_Product.generate_attributes((rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(1), rt.new_int(3)])).to_i64(), 5)
	if rt.is_true(rt.call_function('is_wp_error', [var_attributes.dup()])) {
		return var_attributes.dup()
	}
	rt.call_method(var_product, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'featured', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', [rt.new_int(10)]) }, rt.ArrayItem{ key: 'sku', val: (rt.call_function('sanitize_title', [var_name.dup()])).str() + '-' + (rt.get_property(// unsupported expression: Expr_StaticPropertyFetch, 'ean8')).str() }, rt.ArrayItem{ key: 'global_unique_id', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomElement', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(// unsupported expression: Expr_StaticPropertyFetch, 'ean13') }, rt.ArrayItem{ key: none, val: rt.get_property(// unsupported expression: Expr_StaticPropertyFetch, 'isbn10') }])]) }, rt.ArrayItem{ key: 'attributes', val: var_attributes }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomElement', [rt.create_array([rt.ArrayItem{ key: none, val: 'taxable' }, rt.ArrayItem{ key: none, val: 'shipping' }, rt.ArrayItem{ key: none, val: 'none' }])]) }, rt.ArrayItem{ key: 'tax_class', val: '' }, rt.ArrayItem{ key: 'manage_stock', val: var_will_manage_stock }, rt.ArrayItem{ key: 'stock_quantity', val: if rt.is_true(var_will_manage_stock) { rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [// unsupported expression: Expr_UnaryMinus, rt.new_int(100)]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'stock_status', val: 'instock' }, rt.ArrayItem{ key: 'backorders', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomElement', [rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }, rt.ArrayItem{ key: none, val: 'no' }, rt.ArrayItem{ key: none, val: 'notify' }])]) }, rt.ArrayItem{ key: 'sold_individually', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', [rt.new_int(20)]) }, rt.ArrayItem{ key: 'upsell_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids() }, rt.ArrayItem{ key: 'cross_sell_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids() }, rt.ArrayItem{ key: 'image_id', val: fn () rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Product{}; return temp.get_image() }() }, rt.ArrayItem{ key: 'category_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_cat', (rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(0), rt.new_int(3)])).to_i64()) }, rt.ArrayItem{ key: 'tag_ids', val: Class_WC_SmoothGenerator_Generator_Product.get_term_ids('product_tag', (rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(0), rt.new_int(5)])).to_i64()) }, rt.ArrayItem{ key: 'gallery_image_ids', val: var_gallery }, rt.ArrayItem{ key: 'reviews_allowed', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchase_note', val: if rt.is_true(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', []rt.PhpVal{})) { rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'text', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(0), rt.new_int(10000)]) }])])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
	mut var_variation_attributes := rt.call_function('wc_list_pluck', [rt.call_function('array_filter', [rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}), rt.new_string('wc_attributes_array_filter_variation')]), rt.new_string('get_slugs')])
	mut var_possible_attributes := rt.call_function('array_reverse', [rt.call_function('wc_array_cartesian', [var_variation_attributes.dup()])])
	{
		mut iter_1 := var_possible_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_possible_attribute := item_1.val
			mut var_price := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomFloat', [rt.new_int(2), rt.new_int(1), rt.new_int(1000)])
			mut var_is_on_sale := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', [rt.new_int(35)])
			mut var_has_sale_schedule := rt.new_bool(rt.new_bool(rt.is_true(var_is_on_sale) && rt.is_true(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', [rt.new_int(40)]))))
			mut var_sale_price := if rt.is_true(var_is_on_sale) { rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomFloat', [rt.new_int(2), rt.new_int(0), var_price.dup()]) } else { rt.new_string('') }
			mut var_date_on_sale_from := if rt.is_true(var_has_sale_schedule) { rt.call_method(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'dateTimeBetween', [rt.new_string('-3 days'), rt.new_string('+3 days')]), 'format', [rt.get_constant('DATE_ATOM')]) } else { rt.new_string('') }
			mut var_date_on_sale_to := if rt.is_true(var_has_sale_schedule) { rt.call_method(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'dateTimeBetween', [rt.new_string('+4 days'), rt.new_string('+4 months')]), 'format', [rt.get_constant('DATE_ATOM')]) } else { rt.new_string('') }
			mut var_is_virtual := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'boolean', [rt.new_int(20)])
			mut var_variation := create_wc_smoothgenerator_generator_wc_product_variation()
			var_variation.set_props(rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]))
			if rt.is_true(rt.call_method(, 'feature_is_enabled', []rt.PhpVal{})) {
				
			}
			
		}
	}
}

fn Class_WC_SmoothGenerator_Generator_Product.generate_simple_product() rt.PhpVal {
}

fn Class_WC_SmoothGenerator_Generator_Product.maybe_generate_terms(product_amount i64)  {
}

fn Class_WC_SmoothGenerator_Generator_Product.get_term_ids(taxonomy string, limit i64) rt.PhpVal {
}

fn Class_WC_SmoothGenerator_Generator_Product.maybe_get_gallery_image_ids() rt.PhpVal {
}

fn Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids(limit i64) rt.PhpVal {
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

fn create_wc_smoothgenerator_generator_product() &Class_WC_SmoothGenerator_Generator_Product {
	mut obj := &Class_WC_SmoothGenerator_Generator_Product{
		PhpObjectBase: rt.PhpObjectBase{}
		product_ids: rt.new_array()
		global_attributes: rt.new_array()
	}
	return obj
}

fn create_wc_smoothgenerator_generator_generator() &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_util_randomruntimecache() &Class_WC_SmoothGenerator_Util_RandomRuntimeCache {
	mut obj := &Class_WC_SmoothGenerator_Util_RandomRuntimeCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_attribute() &Class_WC_SmoothGenerator_Generator_WC_Product_Attribute {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_variable() &Class_WC_SmoothGenerator_Generator_WC_Product_Variable {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Variable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_variation() &Class_WC_SmoothGenerator_Generator_WC_Product_Variation {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Variation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Product.generate(dispatch_arg_0, dispatch_arg_1)
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Product.batch(dispatch_arg_0, mut dispatch_arg_1)
		}
		'create_global_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Product.create_global_attribute(dispatch_arg_0)
		}
		'generate_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Product.generate_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_product_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return Class_WC_SmoothGenerator_Generator_Product.get_term_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_get_gallery_image_ids' {
			return Class_WC_SmoothGenerator_Generator_Product.maybe_get_gallery_image_ids()
		}
		'get_existing_product_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Product.get_existing_product_ids(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_ids' { return this.product_ids }
		'global_attributes' { return this.global_attributes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_SmoothGenerator_Generator_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_ids' { this.product_ids = val; return true }
		'global_attributes' { this.global_attributes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_wc_smooth_generator_includes_generator_product_php() {
}
