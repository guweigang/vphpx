import rt

struct Class_WC_Meta_Box_Product_Data {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Product_Data.output(var_post rt.PhpVal) {
	mut var_thepostid := rt.get_superglobal('thepostid')
	mut var_product_object := rt.get_superglobal('product_object')
	var_thepostid = rt.get_property(var_post, 'ID')
	var_product_object = if rt.is_true(var_thepostid) { rt.call_function('wc_get_product', [
			var_thepostid.clone(),
		]) } else { create_wc_product() }
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_save_data'),
		rt.new_string('woocommerce_meta_nonce')])
	rt.include_file(@DIR + '/views/html-product-data-panel.php', '1')
}

fn Class_WC_Meta_Box_Product_Data.output_tabs() {
	mut var_post := rt.new_null()
	mut var_thepostid := rt.new_null()
	mut var_product_object := rt.new_null()
	rt.include_file(@DIR + '/views/html-product-data-general.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-inventory.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-shipping.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-linked-products.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-attributes.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-advanced.php', '1')
}

fn Class_WC_Meta_Box_Product_Data.get_product_type_options() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('product_type_options'),
		rt.call_function('wc_get_default_product_type_options', []rt.PhpVal{})])
	return rt.new_null()
}

fn Class_WC_Meta_Box_Product_Data.get_product_data_tabs() rt.PhpVal {
	mut var_tabs := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_data_tabs'),
		rt.create_array([
			rt.ArrayItem{ key: 'general', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('General'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'target', val: 'general_product_data' },
				rt.ArrayItem{ key: 'class', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'hide_if_grouped' },
				]) },
				rt.ArrayItem{ key: 'priority', val: 10 },
			]) },
			rt.ArrayItem{ key: 'inventory', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Inventory'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'target', val: 'inventory_product_data' },
				rt.ArrayItem{ key: 'class', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'show_if_simple' },
					rt.ArrayItem{ key: none, val: 'show_if_variable' },
					rt.ArrayItem{ key: none, val: 'show_if_grouped' },
					rt.ArrayItem{ key: none, val: 'show_if_external' },
				]) },
				rt.ArrayItem{ key: 'priority', val: 20 },
			]) },
			rt.ArrayItem{ key: 'shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Shipping'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'target', val: 'shipping_product_data' },
				rt.ArrayItem{ key: 'class', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'hide_if_virtual' },
					rt.ArrayItem{ key: none, val: 'hide_if_grouped' },
					rt.ArrayItem{ key: none, val: 'hide_if_external' },
				]) },
				rt.ArrayItem{ key: 'priority', val: 30 },
			]) },
			rt.ArrayItem{ key: 'linked_product', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Linked Products'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'target', val: 'linked_product_data' },
				rt.ArrayItem{ key: 'class', val: rt.new_array() },
				rt.ArrayItem{ key: 'priority', val: 40 },
			]) },
			rt.ArrayItem{ key: 'attribute', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Attributes'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'target', val: 'product_attributes' },
				rt.ArrayItem{ key: 'class', val: rt.new_array() },
				rt.ArrayItem{ key: 'priority', val: 50 },
			]) },
			rt.ArrayItem{ key: 'variations', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Variations'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'target', val: 'variable_product_options' },
				rt.ArrayItem{ key: 'class', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'show_if_variable' },
				]) },
				rt.ArrayItem{ key: 'priority', val: 60 },
			]) },
			rt.ArrayItem{ key: 'advanced', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Advanced'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'target', val: 'advanced_product_data' },
				rt.ArrayItem{ key: 'class', val: rt.new_array() },
				rt.ArrayItem{ key: 'priority', val: 70 },
			]) },
		]),
	])
	rt.call_function('uasort', [var_tabs.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'product_data_tabs_sort' }])])
	return var_tabs.clone()
}

fn Class_WC_Meta_Box_Product_Data.product_data_tabs_sort(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if !(var_a.array_isset(rt.new_string('priority'))
		&& var_b.array_isset(rt.new_string('priority'))) {
		return -1
	}
	if rt.is_true(rt.identical(var_a.array_get(rt.new_string('priority')),
		var_b.array_get(rt.new_string('priority'))))
	{
		return 0
	}
	return if rt.is_true(rt.less(var_a.array_get(rt.new_string('priority')),
		var_b.array_get(rt.new_string('priority'))))
	{
		-1
	} else {
		1
	}
}

fn Class_WC_Meta_Box_Product_Data.filter_variation_attributes(var_attribute rt.PhpVal) rt.PhpVal {
	mut var_attribute_mutated := var_attribute
	return rt.identical(rt.new_bool(true), var_attribute_mutated.get_variation())
}

fn Class_WC_Meta_Box_Product_Data.filter_non_variation_attributes(var_attribute rt.PhpVal) rt.PhpVal {
	mut var_attribute_mutated := var_attribute
	return rt.identical(rt.new_bool(false), var_attribute_mutated.get_variation())
}

fn Class_WC_Meta_Box_Product_Data.output_variations() {
	mut var_post := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_product_object := rt.new_null()
	mut var_variation_attributes := rt.call_function('array_filter', [
		rt.call_method(var_product_object, 'get_attributes', []rt.PhpVal{}),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'filter_variation_attributes' }]),
	])
	mut var_default_attributes := rt.call_method(var_product_object, 'get_default_attributes',
		[]rt.PhpVal{})
	mut var_variations_count := rt.call_function('absint', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_meta_boxes_variations_count'),
			rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT COUNT(ID) FROM '), rt.get_property(var_wpdb,
						'posts')),
						rt.new_string(" WHERE post_parent = %d AND post_type = 'product_variation' AND post_status IN ('publish', 'private')")),
					rt.get_property(var_post, 'ID'),
				]),
			]),
			rt.get_property(var_post, 'ID'),
		]),
	])
	mut var_variations_per_page := rt.call_function('absint', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_meta_boxes_variations_per_page'),
			rt.new_int(15),
		]),
	])
	mut var_variations_total_pages := rt.call_function('ceil', [
		rt.div(var_variations_count, var_variations_per_page),
	])
	mut var_modal_title := rt.new_string(
		(rt.call_function('get_bloginfo', [rt.new_string('name')])).str() +
		(rt.call_function('__', [rt.new_string(' says'), rt.new_string('woocommerce')])).str())
	rt.include_file(@DIR + '/views/html-product-data-variations.php', '1')
}

fn Class_WC_Meta_Box_Product_Data.prepare_downloads(var_file_names rt.PhpVal, var_file_urls rt.PhpVal, var_file_hashes rt.PhpVal) rt.PhpVal {
	mut var_downloads := rt.new_array()
	if !(!rt.is_true(var_file_urls)) {
		mut var_file_url_size := rt.new_int(var_file_urls.clone().array_count())
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_file_url_size))) { break
			 }
			if !(!rt.is_true(var_file_urls.array_get(var_i))) {
				var_downloads << rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('wc_clean', [
						var_file_names.array_get(var_i),
					]) },
					rt.ArrayItem{ key: 'file', val: rt.call_function('wp_unslash', [
						rt.new_string(var_file_urls.array_get(var_i).to_string().trim_space()),
					]) },
					rt.ArrayItem{ key: 'download_id', val: rt.call_function('wc_clean', [
						var_file_hashes.array_get(var_i),
					]) },
				])
			}
			rt.post_inc(var_i)
		}
	}
	return var_downloads.clone()
}

fn Class_WC_Meta_Box_Product_Data.prepare_children() rt.PhpVal {
	return if rt.get_superglobal('_POST').array_isset(rt.new_string('grouped_products')) { rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('intval'),
				rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('grouped_products')))]),
		]) } else { rt.new_array() }
	return rt.new_null()
}

fn Class_WC_Meta_Box_Product_Data.prepare_attributes(data bool) rt.PhpVal {
	mut data_mutated := data
	mut var_attributes := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(data_mutated))))) {
		data_mutated = (rt.call_function('stripslashes_deep', [
			rt.get_superglobal('_POST').clone()])).to_bool()
	}
	if rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_names'))
		&& rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_values')) {
		mut var_attribute_names :=
			rt.new_bool(data_mutated).array_get(rt.new_string('attribute_names'))
		mut var_attribute_values :=
			rt.new_bool(data_mutated).array_get(rt.new_string('attribute_values'))
		mut var_attribute_visibility := if rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_visibility')) {
			rt.new_bool(data_mutated).array_get(rt.new_string('attribute_visibility'))
		} else {
			rt.new_array()
		}
		mut var_attribute_variation := if rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_variation')) {
			rt.new_bool(data_mutated).array_get(rt.new_string('attribute_variation'))
		} else {
			rt.new_array()
		}
		mut var_attribute_position :=
			rt.new_bool(data_mutated).array_get(rt.new_string('attribute_position'))
		mut var_attribute_names_max_key := rt.call_function('max', [
			rt.func_array_keys(var_attribute_names.clone()),
		])
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_attribute_names_max_key))) { break
			 }
			if !rt.is_true(var_attribute_names.array_get(var_i))
				|| !(var_attribute_values.array_isset(var_i)) {
				continue
			}
			mut var_attribute_id := rt.new_int(0)
			mut var_attribute_name := rt.call_function('wc_clean', [
				rt.call_function('esc_html', [var_attribute_names.array_get(var_i)]),
			])
			if rt.is_true(rt.identical(rt.new_string('pa_'), rt.call_function('substr', [
				var_attribute_name.clone(),
				rt.new_int(0),
				rt.new_int(3),
			])))
			{
				var_attribute_id = rt.call_function('wc_attribute_taxonomy_id_by_name', [
					var_attribute_name.clone(),
				])
			}
			mut var_options := if var_attribute_values.array_isset(var_i) {
				var_attribute_values.array_get(var_i)
			} else {
				rt.new_string('')
			}
			if rt.is_true(rt.new_bool(var_options.clone().is_array())) {
				var_options = rt.call_function('wp_parse_id_list', [
					var_options.clone()])
			} else {
				var_options = if rt.is_true(rt.less(rt.new_int(0), var_attribute_id)) { rt.call_function('wc_sanitize_textarea', [
						rt.call_function('esc_html', [
							rt.call_function('wc_sanitize_term_text_based', [
								var_options.clone()]),
						]),
					]) } else { rt.call_function('wc_sanitize_textarea', [
						rt.call_function('esc_html', [var_options.clone()]),
					]) }
				var_options = rt.call_function('wc_get_text_attributes', [
					var_options.clone()])
			}
			if !rt.is_true(var_options) {
				continue
			}
			mut var_attribute := create_wc_product_attribute()
			var_attribute.set_id(var_attribute_id.clone())
			var_attribute.set_name(var_attribute_name.clone())
			var_attribute.set_options(var_options.clone())
			var_attribute.set_position(var_attribute_position.array_get(var_i))
			var_attribute.set_visible(rt.new_bool(var_attribute_visibility.array_isset(var_i)))
			var_attribute.set_variation(rt.new_bool(var_attribute_variation.array_isset(var_i)))
			var_attributes.array_push(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_admin_meta_boxes_prepare_attribute'),
				var_attribute,
				rt.new_bool(data_mutated).clone(),
				var_i.clone(),
			]))
			rt.post_inc(var_i)
		}
	}
	return var_attributes.clone()
}

fn Class_WC_Meta_Box_Product_Data.prepare_set_attributes(var_all_attributes rt.PhpVal, key_prefix string, var_index rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.new_array()
	if rt.is_true(var_all_attributes) {
		mut iter_1 := var_all_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute := item_1.val
			if rt.is_true(rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{})) {
				mut var_attribute_key := rt.call_function('sanitize_title', [
					rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
				])
				if !(var_index.clone().is_null()) {
					mut var_value := if rt.get_superglobal('_POST').array_get(rt.new_string(key_prefix + var_attribute_key.str())).array_isset(var_index) { rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string(key_prefix + var_attribute_key.str())).array_get(var_index),
						]) } else { rt.new_string('') }
				} else {
					var_value = if rt.get_superglobal('_POST').array_isset(key_prefix + var_attribute_key.str()) { rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string(key_prefix + var_attribute_key.str())),
						]) } else { rt.new_string('') }
				}
				if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
					var_value = rt.call_function('sanitize_title', [
						var_value.clone()])
				} else {
					var_value = rt.call_function('html_entity_decode', [
						rt.call_function('wc_clean', [var_value.clone()]),
						rt.get_constant('ENT_QUOTES'),
						rt.call_function('get_bloginfo', [rt.new_string('charset')]),
					])
				}
				var_attributes.array_set(var_attribute_key, var_value.clone())
			}
		}
	}
	return var_attributes.clone()
}

fn Class_WC_Meta_Box_Product_Data.save(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut iife_temp_0 := Class_WC_Product_Factory{}
	mut iife_result_0 := iife_temp_0.get_product_type(var_post_id.clone())
	mut var_product_type := if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('product-type'))) { iife_result_0 } else { rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('product-type'))]),
		]) }
	mut iife_temp_1 := Class_WC_Product_Factory{}
	mut iife_result_1 := iife_temp_1.get_product_classname(var_post_id.clone(), if rt.is_true(var_product_type) {
		var_product_type
	} else {
		Class_Automattic_WooCommerce_Enums_ProductType.simple()
	})
	mut var_classname := iife_result_1
	mut var_product := rt.create_object_dynamically(var_classname, [
		var_post_id.clone()])
	mut var_attributes := Class_WC_Meta_Box_Product_Data.prepare_attributes()
	mut var_stock := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('_stock')) {
		if rt.get_superglobal('_POST').array_isset(rt.new_string('_original_stock'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_stock_amount', [rt.call_method(var_product, 'get_stock_quantity', [rt.new_string('edit')])]), rt.call_function('wc_stock_amount', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('_original_stock'))])]))))) {
			mut iife_temp_2 := Class_WC_Admin_Meta_Boxes{}
			mut iife_result_2 := iife_temp_2.add_error(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The stock has not been updated because the value has changed since editing. Product %1$d has %2$d units in stock.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				rt.call_method(var_product, 'get_stock_quantity', [
					rt.new_string('edit'),
				]),
			]))
		} else {
			var_stock = rt.call_function('wc_stock_amount', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_POST').array_get(rt.new_string('_stock'))]),
			])
		}
	}
	mut var_date_on_sale_from := rt.new_string('')
	mut var_date_on_sale_to := rt.new_string('')
	if rt.get_superglobal('_POST').array_isset(rt.new_string('_sale_price_dates_from')) {
		var_date_on_sale_from = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('_sale_price_dates_from')),
			]),
		])
		if !(!rt.is_true(var_date_on_sale_from)) {
			var_date_on_sale_from = rt.call_function('date', [
				rt.new_string('Y-m-d 00:00:00'),
				rt.call_function('strtotime', [var_date_on_sale_from.clone()]),
			])
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('_sale_price_dates_to')) {
		var_date_on_sale_to = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('_sale_price_dates_to')),
			]),
		])
		if !(!rt.is_true(var_date_on_sale_to)) {
			var_date_on_sale_to = rt.call_function('date', [
				rt.new_string('Y-m-d 23:59:59'),
				rt.call_function('strtotime', [var_date_on_sale_to.clone()]),
			])
		}
	}
	mut var_errors := rt.call_method(var_product, 'set_props', [
		rt.create_array([
			rt.ArrayItem{
				key: 'sku'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_sku')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('_sku'))]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'global_unique_id'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_global_unique_id')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_global_unique_id')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'purchase_note'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_purchase_note')) { rt.call_function('wp_kses_post', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_purchase_note')),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{
				key: 'downloadable'
				val: rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('_downloadable')))
			},
			rt.ArrayItem{
				key: 'virtual'
				val: rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('_virtual')))
			},
			rt.ArrayItem{
				key: 'featured'
				val: rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('_featured')))
			},
			rt.ArrayItem{
				key: 'catalog_visibility'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_visibility')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_visibility')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'tax_status'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_tax_status')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_tax_status')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'tax_class'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_tax_class')) { rt.call_function('sanitize_title', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_tax_class')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'weight'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_weight')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_weight')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'length'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_length')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_length')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'width'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_width')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_width')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'height'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_height')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_height')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'shipping_class_id'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('product_shipping_class')) { rt.call_function('absint', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('product_shipping_class')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'sold_individually'
				val: !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('_sold_individually'))))
			},
			rt.ArrayItem{
				key: 'upsell_ids'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('upsell_ids')) { rt.call_function('array_map', [
						rt.new_string('intval'),
						rt.cast_array(rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('upsell_ids')),
						])),
					]) } else { rt.new_array() }
			},
			rt.ArrayItem{
				key: 'cross_sell_ids'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('crosssell_ids')) { rt.call_function('array_map', [
						rt.new_string('intval'),
						rt.cast_array(rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('crosssell_ids')),
						])),
					]) } else { rt.new_array() }
			},
			rt.ArrayItem{
				key: 'regular_price'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_regular_price')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_regular_price')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'sale_price'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_sale_price')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_sale_price')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{ key: 'date_on_sale_from', val: var_date_on_sale_from },
			rt.ArrayItem{ key: 'date_on_sale_to', val: var_date_on_sale_to },
			rt.ArrayItem{
				key: 'manage_stock'
				val: !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('_manage_stock'))))
			},
			rt.ArrayItem{
				key: 'backorders'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_backorders')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_backorders')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{
				key: 'stock_status'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_stock_status')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_stock_status')),
						]),
					]) } else { rt.new_null() }
			},
			rt.ArrayItem{ key: 'stock_quantity', val: var_stock },
			rt.ArrayItem{
				key: 'low_stock_amount'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_low_stock_amount')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_POST').array_get(rt.new_string('_low_stock_amount')))))) { rt.call_function('wc_stock_amount', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_low_stock_amount')),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{
				key: 'download_limit'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_download_limit')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_POST').array_get(rt.new_string('_download_limit')))))) { rt.call_function('absint', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_download_limit')),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{
				key: 'download_expiry'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_download_expiry')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_POST').array_get(rt.new_string('_download_expiry')))))) { rt.call_function('absint', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_download_expiry')),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{ key: 'downloads', val: Class_WC_Meta_Box_Product_Data.prepare_downloads(if rt.get_superglobal('_POST').array_isset(rt.new_string('_wc_file_names')) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('_wc_file_names')),
				]) } else { rt.new_array() }, if rt.get_superglobal('_POST').array_isset(rt.new_string('_wc_file_urls')) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('_wc_file_urls')),
				]) } else { rt.new_array() }, if rt.get_superglobal('_POST').array_isset(rt.new_string('_wc_file_hashes')) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('_wc_file_hashes')),
				]) } else { rt.new_array() }) },
			rt.ArrayItem{
				key: 'product_url'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_product_url')) { rt.call_function('esc_url_raw', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_product_url')),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{
				key: 'button_text'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('_button_text')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_button_text')),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{
				key: 'children'
				val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
					var_product_type))
				{
					Class_WC_Meta_Box_Product_Data.prepare_children()
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'reviews_allowed'
				val:
					!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('comment_status'))))
					&& rt.is_true(rt.identical(rt.new_string('open'), rt.get_superglobal('_POST').array_get(rt.new_string('comment_status'))))
			},
			rt.ArrayItem{ key: 'attributes', val: var_attributes },
			rt.ArrayItem{ key: 'default_attributes', val: Class_WC_Meta_Box_Product_Data.prepare_set_attributes(var_attributes.str(),
				rt.new_string('default_attribute_')) },
		]),
	])
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		mut var_cogs_value := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('_cogs_value'))).is_null() {
				rt.get_superglobal('_POST').array_get(rt.new_string('_cogs_value'))
			} else {
				rt.new_null()
			}]),
		])
		rt.call_method(var_product, 'set_cogs_value', [if var_cogs_value.clone().is_null() { rt.new_null() } else { rt.new_float((rt.call_function('wc_format_decimal', [
				var_cogs_value.clone(),
			])).to_f64()) }])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_errors.clone()])) {
		mut iife_temp_3 := Class_WC_Admin_Meta_Boxes{}
		mut iife_result_3 := iife_temp_3.add_error(rt.call_method(var_errors, 'get_error_message',
			[]rt.PhpVal{}))
	}
	rt.call_method(var_product, 'delete_meta_data', [
		rt.new_string('_product_template_id'),
	])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_4 := iife_temp_4.feature_is_enabled(rt.new_string('point_of_sale'))
	if rt.is_true(iife_result_4) {
		mut var_visible_in_pos := rt.new_bool(
			rt.get_superglobal('_POST').array_isset(rt.new_string('_visible_in_pos'))
			&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('_visible_in_pos'))])]))))
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync.class(),
		]), 'set_product_pos_visibility', [var_post_id.clone(),
			var_visible_in_pos.clone()])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_process_product_object'),
		var_product.clone(),
	])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_product, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variable(),
	]))
	{
		mut var_original_post_title := if rt.get_superglobal('_POST').array_isset(rt.new_string('original_post_title')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('original_post_title')),
				]),
			]) } else { rt.new_string('') }
		mut var_post_title := if rt.get_superglobal('_POST').array_isset(rt.new_string('post_title')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('post_title')),
				]),
			]) } else { rt.new_string('') }
		rt.call_method(rt.call_method(var_product, 'get_data_store', []rt.PhpVal{}),
			'sync_variation_names', [var_product.clone(), var_original_post_title.clone(),
			var_post_title.clone()])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_process_product_meta_' + var_product_type.str()),
		var_post_id.clone(),
	])
}

fn Class_WC_Meta_Box_Product_Data.save_variations(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('variable_post_id')) {
		mut var_parent := rt.call_function('wc_get_product', [
			var_post_id.clone()])
		rt.call_method(var_parent, 'set_default_attributes', [
			Class_WC_Meta_Box_Product_Data.prepare_set_attributes((rt.call_method(var_parent,
				'get_attributes', []rt.PhpVal{})).str(), rt.new_string('default_attribute_')),
		])
		rt.call_method(var_parent, 'save', []rt.PhpVal{})
		mut var_max_loop := rt.call_function('max', [
			rt.func_array_keys(rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('variable_post_id')),
			])),
		])
		mut var_data_store := rt.call_method(var_parent, 'get_data_store', []rt.PhpVal{})
		rt.call_method(var_data_store, 'sort_all_product_variations', [
			rt.call_method(var_parent, 'get_id', []rt.PhpVal{}),
		])
		mut var_new_variation_menu_order_id := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('new_variation_menu_order_id')))) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('new_variation_menu_order_id')),
				]),
			]) } else { rt.new_bool(false) }
		mut var_new_variation_menu_order_value := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('new_variation_menu_order_value')))) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('new_variation_menu_order_value')),
				]),
			]) } else { rt.new_bool(false) }
		if rt.is_true(var_new_variation_menu_order_id)
			&& rt.is_true(var_new_variation_menu_order_value) {
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('UPDATE '),
						rt.get_property(var_wpdb, 'posts')),
						rt.new_string(" SET menu_order = menu_order + 1 WHERE post_type = 'product_variation' AND post_parent = %d AND post_status = 'publish' AND menu_order >= %d AND ID != %d")),
					var_post_id.clone(),
					var_new_variation_menu_order_value.clone(),
					var_new_variation_menu_order_id.clone(),
				]),
			])
		}
		mut var_cogs_is_enabled := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
		]), 'feature_is_enabled', []rt.PhpVal{})
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_max_loop))) { break
			 }
			if !(rt.get_superglobal('_POST').array_get(rt.new_string('variable_post_id')).array_isset(var_i)) {
				continue
			}
			mut var_variation_id := rt.call_function('absint', [
				rt.get_superglobal('_POST').array_get(rt.new_string('variable_post_id')).array_get(var_i)])
			mut var_variation := rt.call_function('wc_get_product_object', [
				Class_Automattic_WooCommerce_Enums_ProductType.variation(),
				var_variation_id.clone(),
			])
			mut var_stock := rt.new_null()
			if rt.get_superglobal('_POST').array_isset(rt.new_string('variable_stock'))
				&& rt.get_superglobal('_POST').array_get(rt.new_string('variable_stock')).array_isset(var_i) {
				if rt.get_superglobal('_POST').array_isset(rt.new_string('variable_original_stock'))
					&& rt.get_superglobal('_POST').array_get(rt.new_string('variable_original_stock')).array_isset(var_i)
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_stock_amount', [rt.call_method(var_variation, 'get_stock_quantity', [rt.new_string('edit')])]), rt.call_function('wc_stock_amount', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('variable_original_stock')).array_get(var_i)])]))))) {
					mut iife_temp_5 := Class_WC_Admin_Meta_Boxes{}
					mut iife_result_5 := iife_temp_5.add_error(rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('The stock has not been updated because the value has changed since editing. Product %1$d has %2$d units in stock.'),
							rt.new_string('woocommerce'),
						]),
						rt.call_method(var_variation, 'get_id', []rt.PhpVal{}),
						rt.call_method(var_variation, 'get_stock_quantity', [
							rt.new_string('edit'),
						]),
					]))
				} else {
					var_stock = rt.call_function('wc_stock_amount', [
						rt.call_function('wp_unslash',
							[rt.get_superglobal('_POST').array_get(rt.new_string('variable_stock')).array_get(var_i)]),
					])
				}
			}
			mut var_date_on_sale_from := rt.new_string('')
			mut var_date_on_sale_to := rt.new_string('')
			if rt.get_superglobal('_POST').array_get(rt.new_string('variable_sale_price_dates_from')).array_isset(var_i) {
				var_date_on_sale_from = rt.call_function('wc_clean', [
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_POST').array_get(rt.new_string('variable_sale_price_dates_from')).array_get(var_i)]),
				])
				if !(!rt.is_true(var_date_on_sale_from)) {
					var_date_on_sale_from = rt.call_function('date', [
						rt.new_string('Y-m-d 00:00:00'),
						rt.call_function('strtotime', [var_date_on_sale_from.clone()]),
					])
				}
			}
			if rt.get_superglobal('_POST').array_get(rt.new_string('variable_sale_price_dates_to')).array_isset(var_i) {
				var_date_on_sale_to = rt.call_function('wc_clean', [
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_POST').array_get(rt.new_string('variable_sale_price_dates_to')).array_get(var_i)]),
				])
				if !(!rt.is_true(var_date_on_sale_to)) {
					var_date_on_sale_to = rt.call_function('date', [
						rt.new_string('Y-m-d 23:59:59'),
						rt.call_function('strtotime', [var_date_on_sale_to.clone()]),
					])
				}
			}
			mut var_errors := rt.call_method(var_variation, 'set_props', [
				rt.create_array([
					rt.ArrayItem{
						key: 'status'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_enabled')).array_isset(var_i) {
							Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
						} else {
							Class_Automattic_WooCommerce_Enums_ProductStatus.private()
						}
					},
					rt.ArrayItem{
						key: 'menu_order'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variation_menu_order')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variation_menu_order')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'regular_price'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_regular_price')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_regular_price')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'sale_price'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_sale_price')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_sale_price')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'virtual'
						val: rt.new_bool(rt.get_superglobal('_POST').array_get(rt.new_string('variable_is_virtual')).array_isset(var_i))
					},
					rt.ArrayItem{
						key: 'downloadable'
						val: rt.new_bool(rt.get_superglobal('_POST').array_get(rt.new_string('variable_is_downloadable')).array_isset(var_i))
					},
					rt.ArrayItem{ key: 'date_on_sale_from', val: var_date_on_sale_from },
					rt.ArrayItem{ key: 'date_on_sale_to', val: var_date_on_sale_to },
					rt.ArrayItem{
						key: 'description'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_description')).array_isset(var_i) { rt.call_function('wp_kses_post', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_description')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'download_limit'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_download_limit')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_download_limit')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'download_expiry'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_download_expiry')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_download_expiry')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{ key: 'downloads', val: Class_WC_Meta_Box_Product_Data.prepare_downloads(if rt.get_superglobal('_POST').array_get(rt.new_string('_wc_variation_file_names')).array_isset(var_variation_id) { rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_wc_variation_file_names')).array_get(var_variation_id),
						]) } else { rt.new_array() }, if rt.get_superglobal('_POST').array_get(rt.new_string('_wc_variation_file_urls')).array_isset(var_variation_id) { rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_wc_variation_file_urls')).array_get(var_variation_id),
						]) } else { rt.new_array() }, if rt.get_superglobal('_POST').array_get(rt.new_string('_wc_variation_file_hashes')).array_isset(var_variation_id) { rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('_wc_variation_file_hashes')).array_get(var_variation_id),
						]) } else { rt.new_array() }) },
					rt.ArrayItem{
						key: 'manage_stock'
						val: rt.new_bool(rt.get_superglobal('_POST').array_get(rt.new_string('variable_manage_stock')).array_isset(var_i))
					},
					rt.ArrayItem{ key: 'stock_quantity', val: var_stock },
					rt.ArrayItem{
						key: 'low_stock_amount'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_low_stock_amount')).array_isset(var_i) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_POST').array_get(rt.new_string('variable_low_stock_amount')).array_get(var_i))))) { rt.call_function('wc_stock_amount', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_low_stock_amount')).array_get(var_i)]),
							]) } else { rt.new_string('') }
					},
					rt.ArrayItem{
						key: 'backorders'
						val: if rt.get_superglobal('_POST').array_isset(rt.new_string('variable_backorders')) && rt.get_superglobal('_POST').array_get(rt.new_string('variable_backorders')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_backorders')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'stock_status'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_stock_status')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_stock_status')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'image_id'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('upload_image_id')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('upload_image_id')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{ key: 'attributes', val: Class_WC_Meta_Box_Product_Data.prepare_set_attributes((rt.call_method(var_parent,
						'get_attributes', []rt.PhpVal{})).str(), rt.new_string('attribute_'),
						var_i.clone()) },
					rt.ArrayItem{
						key: 'sku'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_sku')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_sku')).array_get(var_i)]),
							]) } else { rt.new_string('') }
					},
					rt.ArrayItem{
						key: 'global_unique_id'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_global_unique_id')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_global_unique_id')).array_get(var_i)]),
							]) } else { rt.new_string('') }
					},
					rt.ArrayItem{
						key: 'weight'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_weight')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_weight')).array_get(var_i)]),
							]) } else { rt.new_string('') }
					},
					rt.ArrayItem{
						key: 'length'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_length')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_length')).array_get(var_i)]),
							]) } else { rt.new_string('') }
					},
					rt.ArrayItem{
						key: 'width'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_width')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_width')).array_get(var_i)]),
							]) } else { rt.new_string('') }
					},
					rt.ArrayItem{
						key: 'height'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_height')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_height')).array_get(var_i)]),
							]) } else { rt.new_string('') }
					},
					rt.ArrayItem{
						key: 'shipping_class_id'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_shipping_class')).array_isset(var_i) { rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_shipping_class')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
					rt.ArrayItem{
						key: 'tax_class'
						val: if rt.get_superglobal('_POST').array_get(rt.new_string('variable_tax_class')).array_isset(var_i) { rt.call_function('sanitize_title', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_POST').array_get(rt.new_string('variable_tax_class')).array_get(var_i)]),
							]) } else { rt.new_null() }
					},
				]),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_errors.clone()])) {
				mut iife_temp_6 := Class_WC_Admin_Meta_Boxes{}
				mut iife_result_6 := iife_temp_6.add_error(rt.call_method(var_errors,
					'get_error_message', []rt.PhpVal{}))
			}
			if rt.is_true(var_cogs_is_enabled) {
				mut var_cogs_value := rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('variable_cost_value')).array_get(var_i)).is_null() {
						rt.get_superglobal('_POST').array_get(rt.new_string('variable_cost_value')).array_get(var_i)
					} else {
						rt.new_string('')
					}]),
				])
				if rt.is_true(rt.identical(rt.new_string(''), var_cogs_value)) {
					var_cogs_value = rt.new_null()
				}
				rt.call_method(var_variation, 'set_cogs_value', [if var_cogs_value.clone().is_null() { rt.new_null() } else { rt.new_float((rt.call_function('wc_format_decimal', [
						var_cogs_value.clone(),
					])).to_f64()) }])
			}
			rt.call_function('do_action', [
				rt.new_string('woocommerce_admin_process_variation_object'),
				var_variation.clone(),
				var_i.clone(),
			])
			rt.call_method(var_variation, 'save', []rt.PhpVal{})
			rt.call_function('do_action', [
				rt.new_string('woocommerce_save_product_variation'),
				var_variation_id.clone(),
				var_i.clone(),
			])
			rt.post_inc(var_i)
		}
	}
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Meta_Boxes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_meta_box_product_data(_args ...rt.PhpVal) &Class_WC_Meta_Box_Product_Data {
	mut obj := &Class_WC_Meta_Box_Product_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product(_args ...rt.PhpVal) &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_attribute(_args ...rt.PhpVal) &Class_WC_Product_Attribute {
	mut obj := &Class_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_factory(_args ...rt.PhpVal) &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_meta_boxes(_args ...rt.PhpVal) &Class_WC_Admin_Meta_Boxes {
	mut obj := &Class_WC_Admin_Meta_Boxes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Product_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Data.output(dispatch_arg_0)
			return rt.new_null()
		}
		'output_tabs' {
			Class_WC_Meta_Box_Product_Data.output_tabs()
			return rt.new_null()
		}
		'get_product_type_options' {
			return Class_WC_Meta_Box_Product_Data.get_product_type_options()
		}
		'get_product_data_tabs' {
			return Class_WC_Meta_Box_Product_Data.get_product_data_tabs()
		}
		'product_data_tabs_sort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_WC_Meta_Box_Product_Data.product_data_tabs_sort(dispatch_arg_0,
				dispatch_arg_1))
		}
		'filter_variation_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.filter_variation_attributes(dispatch_arg_0)
		}
		'filter_non_variation_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.filter_non_variation_attributes(dispatch_arg_0)
		}
		'output_variations' {
			Class_WC_Meta_Box_Product_Data.output_variations()
			return rt.new_null()
		}
		'prepare_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.prepare_downloads(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'prepare_children' {
			return Class_WC_Meta_Box_Product_Data.prepare_children()
		}
		'prepare_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_WC_Meta_Box_Product_Data.prepare_attributes(dispatch_arg_0)
		}
		'prepare_set_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.prepare_set_attributes(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Data.save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Data.save_variations(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Product_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Product_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Meta_Boxes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Meta_Boxes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Meta_Boxes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Meta_Box_Product_Data', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_meta_box_product_data()
		return rt.new_object('WC_Meta_Box_Product_Data', []string{}, obj)
	})
	rt.register_class_factory('WC_Product', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product()
		return rt.new_object('WC_Product', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Attribute', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_attribute()
		return rt.new_object('WC_Product_Attribute', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Meta_Boxes', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_meta_boxes()
		return rt.new_object('WC_Admin_Meta_Boxes', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_FeaturesUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_featuresutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_FeaturesUtil', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
