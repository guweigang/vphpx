import rt

struct Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.from_wc_product(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product, mut var_query_info Class_Automattic_WooCommerce_Api_Utils_Products_?array) rt.PhpVal {
	mut match_val_1 := var_wc_product.get_type()
	mut var_product := if rt.is_true(rt.equal(match_val_1, rt.new_string('external'))) { Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_external_product(mut var_wc_product) } else if rt.is_true(rt.equal(match_val_1, rt.new_string('variable'))) { Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_variable_product(mut var_wc_product, mut var_query_info) } else if rt.is_true(rt.equal(match_val_1, rt.new_string('variation'))) { Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_product_variation(mut var_wc_product) } else { create_automattic_woocommerce_api_types_products_simpleproduct() }
	Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.populate_common_fields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_object](var_product), mut var_wc_product, mut var_query_info)
	return var_product.clone()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_external_product(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
	mut var_product := create_automattic_woocommerce_api_types_products_externalproduct()
	mut var_url := var_wc_product.get_product_url()
	rt.set_property(var_product, 'product_url', if !(!rt.is_true(var_url)) { var_url } else { rt.new_null() })
	mut var_text := var_wc_product.get_button_text()
	rt.set_property(var_product, 'button_text', if !(!rt.is_true(var_text)) { var_text } else { rt.new_null() })
	return var_product.clone()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_variable_product(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product, mut var_query_info Class_Automattic_WooCommerce_Api_Utils_Products_?array) rt.PhpVal {
	mut var_product := create_automattic_woocommerce_api_types_products_variableproduct()
	mut var_child_ids := var_wc_product.get_children()
	mut var_total_count := rt.new_int(var_child_ids.clone().array_count())
	mut var_variations_info := if !(var_query_info.array_get(rt.new_string('...VariableProduct')).array_get(rt.new_string('variations'))).is_null() { var_query_info.array_get(rt.new_string('...VariableProduct')).array_get(rt.new_string('variations')) } else { if !(var_query_info.array_get(rt.new_string('variations'))).is_null() { var_query_info.array_get(rt.new_string('variations')) } else { rt.new_null() } }
	mut var_variation_query_info := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.connection_node_info(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](var_variations_info))
	mut var_pagination_args := if !(var_variations_info.array_get(rt.new_string('__args'))).is_null() { var_variations_info.array_get(rt.new_string('__args')) } else { rt.new_array() }
	mut iife_temp_0 := Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{}
	mut iife_result_0 := iife_temp_0.validate_args(var_pagination_args.clone())
	mut var_page := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.slice_variation_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_array](var_child_ids), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_array](var_pagination_args))
	if !(!rt.is_true(var_page.array_get(rt.new_string('ids')))) {
		rt.call_function('_prime_post_caches', [var_page.array_get(rt.new_string('ids'))])
	}
	mut var_edges := rt.new_array()
	mut var_nodes := rt.new_array()
	mut iter_1 := var_page.array_get(rt.new_string('ids')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_child_id := item_1.val
		mut var_child_product := rt.call_function('wc_get_product', [var_child_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_child_product)))) {
			continue
		}
		mut var_variation := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.from_wc_product(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](var_child_product), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](var_variation_query_info))
		mut var_edge := create_automattic_woocommerce_api_pagination_edge()
		rt.set_property(var_edge, 'cursor', rt.call_function('base64_encode', [rt.new_string((var_child_id).str())]))
		rt.set_property(var_edge, 'node', var_variation.clone())
		var_edges.array_push(var_edge.clone())
		var_nodes.array_push(var_variation.clone())
	}
	mut var_page_info := create_automattic_woocommerce_api_pagination_pageinfo()
	rt.set_property(var_page_info, 'has_next_page', var_page.array_get(rt.new_string('has_next_page')))
	rt.set_property(var_page_info, 'has_previous_page', var_page.array_get(rt.new_string('has_previous_page')))
	rt.set_property(var_page_info, 'start_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(rt.new_int(0)), 'cursor') } else { rt.new_null() })
	rt.set_property(var_page_info, 'end_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(rt.new_int(var_edges.clone().array_count() - 1)), 'cursor') } else { rt.new_null() })
	mut iife_temp_1 := Class_Automattic_WooCommerce_Api_Pagination_Connection{}
	mut iife_result_1 := iife_temp_1.pre_sliced(var_edges.clone(), rt.new_object('Automattic_WooCommerce_Api_Pagination_PageInfo', []string{}, var_page_info), var_total_count.clone())
	rt.set_property(var_product, 'variations', iife_result_1)
	return var_product.clone()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.slice_variation_ids(mut var_child_ids Class_Automattic_WooCommerce_Api_Utils_Products_array, mut var_args Class_Automattic_WooCommerce_Api_Utils_Products_array) rt.PhpVal {
	mut var_child_ids_mutated := var_child_ids
	mut var_first := if !(var_args.array_get(rt.new_string('first'))).is_null() { var_args.array_get(rt.new_string('first')) } else { rt.new_null() }
	mut var_last := if !(var_args.array_get(rt.new_string('last'))).is_null() { var_args.array_get(rt.new_string('last')) } else { rt.new_null() }
	mut var_after := if !(var_args.array_get(rt.new_string('after'))).is_null() { var_args.array_get(rt.new_string('after')) } else { rt.new_null() }
	mut var_before := if !(var_args.array_get(rt.new_string('before'))).is_null() { var_args.array_get(rt.new_string('before')) } else { rt.new_null() }
	if rt.is_true(rt.identical(rt.new_null(), var_first)) && rt.is_true(rt.identical(rt.new_null(), var_last)) && rt.is_true(rt.identical(rt.new_null(), var_after)) && rt.is_true(rt.identical(rt.new_null(), var_before)) {
		return rt.create_array([rt.ArrayItem{ key: 'ids', val: rt.call_function('array_values', [var_child_ids_mutated]) }, rt.ArrayItem{ key: 'has_next_page', val: false }, rt.ArrayItem{ key: 'has_previous_page', val: false }])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_after)))) {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}
	mut iife_result_2 := iife_temp_2.decode_id_cursor(var_after.clone(), rt.new_string('after'))
	mut var_after_id := iife_result_2
	mut var_idx := rt.call_function('array_search', [var_after_id.clone(), var_child_ids_mutated, rt.new_bool(true)])
	var_child_ids_mutated = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_idx)))) { rt.call_function('array_slice', [var_child_ids_mutated, rt.add(var_idx, rt.new_int(1))]) } else { rt.new_array() }
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_before)))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}
		mut iife_result_3 := iife_temp_3.decode_id_cursor(var_before.clone(), rt.new_string('before'))
		mut var_before_id := iife_result_3
		var_idx = rt.call_function('array_search', [var_before_id.clone(), var_child_ids_mutated, rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_idx)))) {
		var_child_ids_mutated = rt.call_function('array_slice', [var_child_ids_mutated, rt.new_int(0), var_idx.clone()])
		}
	}
	mut var_total_after_cursors := rt.new_int(var_child_ids_mutated.array_count())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_first)))) && rt.is_true(rt.greater_equal(var_first, rt.new_int(0))) {
	var_child_ids_mutated = rt.call_function('array_slice', [var_child_ids_mutated, rt.new_int(0), var_first.clone()])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last)))) && rt.is_true(rt.greater_equal(var_last, rt.new_int(0))) {
	var_child_ids_mutated = rt.call_function('array_slice', [var_child_ids_mutated, rt.call_function('max', [rt.new_int(0), rt.sub(rt.new_int(var_child_ids_mutated.array_count()), var_last)])])
	}
	return rt.create_array([rt.ArrayItem{ key: 'ids', val: rt.call_function('array_values', [var_child_ids_mutated]) }, rt.ArrayItem{ key: 'has_next_page', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_first)))) { rt.less(rt.new_int(var_child_ids_mutated.array_count()), var_total_after_cursors) } else { rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_before))) } }, rt.ArrayItem{ key: 'has_previous_page', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last)))) { rt.less(rt.new_int(var_child_ids_mutated.array_count()), var_total_after_cursors) } else { rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_after))) } }])
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_product_variation(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
	mut var_product := create_automattic_woocommerce_api_types_products_productvariation()
	rt.set_property(var_product, 'parent_id', var_wc_product.get_parent_id())
	mut var_selected_attributes := rt.new_array()
	mut iter_2 := var_wc_product.get_attributes().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_taxonomy := item_2.key
		mut var_attr := create_automattic_woocommerce_api_types_products_selectedattribute()
		rt.set_property(var_attr, 'name', var_taxonomy.clone())
		if rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.clone()])) && !(!rt.is_true(var_value)) {
			mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_value.clone(), var_taxonomy.clone()])
			if rt.is_true(var_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
				rt.set_property(var_attr, 'value', rt.get_property(var_term, 'name'))
			} else {
				rt.set_property(var_attr, 'value', var_value.clone())
			}
		} else {
			rt.set_property(var_attr, 'value', var_value.clone())
		}
		var_selected_attributes.array_push(var_attr.clone())
	}
	rt.set_property(var_product, 'selected_attributes', var_selected_attributes.clone())
	return var_product.clone()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.populate_common_fields(mut var_product Class_Automattic_WooCommerce_Api_Utils_Products_object, mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product, mut var_query_info Class_Automattic_WooCommerce_Api_Utils_Products_?array) {
	mut var_product_mutated := var_product
	mut var_raw_status := rt.new_string((var_wc_product.get_status()).str())
	mut var_raw_product_type := rt.new_string((var_wc_product.get_type()).str())
	rt.set_property(var_product_mutated, 'id', var_wc_product.get_id())
	rt.set_property(var_product_mutated, 'name', var_wc_product.get_name())
	rt.set_property(var_product_mutated, 'slug', var_wc_product.get_slug())
	mut var_sku := var_wc_product.get_sku()
	rt.set_property(var_product_mutated, 'sku', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_sku)))) { var_sku } else { rt.new_null() })
	rt.set_property(var_product_mutated, 'description', var_wc_product.get_description())
	rt.set_property(var_product_mutated, 'short_description', var_wc_product.get_short_description())
	mut iife_temp_4 := Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus{}
	mut iife_result_4 := iife_temp_4.tryfrom(var_raw_status.clone())
	rt.set_property(var_product_mutated, 'status', if !(iife_result_4).is_null() { iife_result_4 } else { Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus.other() })
	rt.set_property(var_product_mutated, 'raw_status', var_raw_status.clone())
	mut iife_temp_5 := Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{}
	mut iife_result_5 := iife_temp_5.tryfrom(var_raw_product_type.clone())
	rt.set_property(var_product_mutated, 'product_type', if !(iife_result_5).is_null() { iife_result_5 } else { Class_Automattic_WooCommerce_Api_Enums_Products_ProductType.other() })
	rt.set_property(var_product_mutated, 'raw_product_type', var_raw_product_type.clone())
	mut var_format_regular := if !(var_query_info.array_get(rt.new_string('regular_price')).array_get(rt.new_string('__args')).array_get(rt.new_string('formatted'))).is_null() { var_query_info.array_get(rt.new_string('regular_price')).array_get(rt.new_string('__args')).array_get(rt.new_string('formatted')) } else { rt.new_bool(true) }
	mut var_raw_regular := var_wc_product.get_regular_price()
	if rt.is_true(rt.identical(rt.new_string(''), var_raw_regular)) {
		rt.set_property(var_product_mutated, 'regular_price', rt.new_null())
	} else {
		rt.set_property(var_product_mutated, 'regular_price', if rt.is_true(var_format_regular) { rt.call_function('wc_price', [rt.new_float((var_raw_regular).to_f64())]) } else { var_raw_regular })
	}
	mut var_format_sale := if !(var_query_info.array_get(rt.new_string('sale_price')).array_get(rt.new_string('__args')).array_get(rt.new_string('formatted'))).is_null() { var_query_info.array_get(rt.new_string('sale_price')).array_get(rt.new_string('__args')).array_get(rt.new_string('formatted')) } else { rt.new_bool(true) }
	mut var_raw_sale := var_wc_product.get_sale_price()
	if rt.is_true(rt.identical(rt.new_string(''), var_raw_sale)) {
		rt.set_property(var_product_mutated, 'sale_price', rt.new_null())
	} else {
		rt.set_property(var_product_mutated, 'sale_price', if rt.is_true(var_format_sale) { rt.call_function('wc_price', [rt.new_float((var_raw_sale).to_f64())]) } else { var_raw_sale })
	}
	mut var_raw_stock_status := rt.new_string((var_wc_product.get_stock_status()).str())
	rt.set_property(var_product_mutated, 'stock_status', Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.map_stock_status((var_raw_stock_status).str()))
	rt.set_property(var_product_mutated, 'raw_stock_status', var_raw_stock_status.clone())
	rt.set_property(var_product_mutated, 'stock_quantity', var_wc_product.get_stock_quantity())
	rt.set_property(var_product_mutated, 'dimensions', Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_dimensions(mut var_wc_product))
	rt.set_property(var_product_mutated, 'images', Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_images(mut var_wc_product))
	rt.set_property(var_product_mutated, 'attributes', Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_attributes(mut var_wc_product))
	if rt.is_true(rt.identical(rt.new_null(), var_query_info)) || rt.is_true(rt.new_bool(var_query_info.array_isset(rt.new_string('reviews')))) {
		rt.set_property(var_product_mutated, 'reviews', Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_reviews((var_wc_product.get_id()).to_i64()))
	} else {
		rt.set_property(var_product_mutated, 'reviews', Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.empty_connection())
	}
	rt.set_property(var_product_mutated, 'date_created', rt.new_null())
	rt.set_property(var_product_mutated, 'date_modified', rt.new_null())
	rt.set_property(var_product_mutated, 'internal_notes', rt.new_null())
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.map_stock_status(wc_status string) rt.PhpVal {
	mut match_val_2 := rt.new_string(wc_status)
	return if rt.is_true(rt.equal(match_val_2, rt.new_string('instock'))) { Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.instock() } else if rt.is_true(rt.equal(match_val_2, rt.new_string('outofstock'))) { Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.outofstock() } else if rt.is_true(rt.equal(match_val_2, rt.new_string('onbackorder'))) { Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.onbackorder() } else { Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.other() }
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_dimensions(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
	mut var_length := var_wc_product.get_length()
	mut var_width := var_wc_product.get_width()
	mut var_height := var_wc_product.get_height()
	mut var_weight := var_wc_product.get_weight()
	if rt.is_true(rt.identical(rt.new_string(''), var_length)) && rt.is_true(rt.identical(rt.new_string(''), var_width)) && rt.is_true(rt.identical(rt.new_string(''), var_height)) && rt.is_true(rt.identical(rt.new_string(''), var_weight)) {
		return rt.new_null()
	}
	mut var_dims := create_automattic_woocommerce_api_types_products_productdimensions()
	rt.set_property(var_dims, 'length', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_length)))) { rt.new_float((var_length).to_f64()) } else { rt.new_null() })
	rt.set_property(var_dims, 'width', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_width)))) { rt.new_float((var_width).to_f64()) } else { rt.new_null() })
	rt.set_property(var_dims, 'height', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_height)))) { rt.new_float((var_height).to_f64()) } else { rt.new_null() })
	rt.set_property(var_dims, 'weight', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_weight)))) { rt.new_float((var_weight).to_f64()) } else { rt.new_null() })
	return rt.new_object('Automattic_WooCommerce_Api_Types_Products_ProductDimensions', []string{}, var_dims)
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_images(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
	mut var_images := rt.new_array()
	mut var_position := rt.new_int(0)
	mut var_featured_id := var_wc_product.get_image_id()
	if rt.is_true(var_featured_id) {
		mut var_image := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_image(rt.new_int((var_featured_id).to_i64()), (var_position).to_i64())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_image)))) {
			var_images.array_push(var_image.clone())
			rt.pre_inc(var_position)
		}
	}
	mut iter_3 := var_wc_product.get_gallery_image_ids().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_image_id := item_3.val
		var_image = Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_image(rt.new_int((var_image_id).to_i64()), (var_position).to_i64())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_image)))) {
			var_images.array_push(var_image.clone())
			rt.pre_inc(var_position)
		}
	}
	return var_images.clone()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_attributes(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('variation'), var_wc_product.get_type())) {
		return rt.new_array()
	}
	mut var_attributes := rt.new_array()
	mut iter_4 := var_wc_product.get_attributes().iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_wc_attr := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wc_attr, 'Automattic_WooCommerce_Api_Utils_Products_WC_Product_Attribute')))))) {
			continue
		}
		mut var_attr := create_automattic_woocommerce_api_types_products_productattribute()
		rt.set_property(var_attr, 'slug', rt.call_method(var_wc_attr, 'get_name', []rt.PhpVal{}))
		if rt.is_true(rt.call_method(var_wc_attr, 'is_taxonomy', []rt.PhpVal{})) {
			rt.set_property(var_attr, 'name', rt.call_function('wc_attribute_label', [rt.call_method(var_wc_attr, 'get_name', []rt.PhpVal{})]))
			closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_term, 'name')
				}
			closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_term, 'name')
				}
			rt.set_property(var_attr, 'options', rt.call_function('array_map', [rt.new_closure(closure_7_fn), if rt.is_true(rt.call_method(var_wc_attr, 'get_terms', []rt.PhpVal{})) { rt.call_method(var_wc_attr, 'get_terms', []rt.PhpVal{}) } else { rt.new_array() }]))
		} else {
			rt.set_property(var_attr, 'name', rt.call_method(var_wc_attr, 'get_name', []rt.PhpVal{}))
			rt.set_property(var_attr, 'options', rt.call_method(var_wc_attr, 'get_options', []rt.PhpVal{}))
		}
		rt.set_property(var_attr, 'position', rt.call_method(var_wc_attr, 'get_position', []rt.PhpVal{}))
		rt.set_property(var_attr, 'visible', rt.call_method(var_wc_attr, 'get_visible', []rt.PhpVal{}))
		rt.set_property(var_attr, 'variation', rt.call_method(var_wc_attr, 'get_variation', []rt.PhpVal{}))
		rt.set_property(var_attr, 'is_taxonomy', rt.call_method(var_wc_attr, 'is_taxonomy', []rt.PhpVal{}))
		var_attributes.array_push(var_attr.clone())
	}
	return var_attributes.clone()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_image(attachment_id i64, position i64) rt.PhpVal {
	mut position_mutated := position
	mut var_url := rt.call_function('wp_get_attachment_url', [rt.new_int(attachment_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
		return rt.new_null()
	}
	mut var_image := create_automattic_woocommerce_api_types_products_productimage()
	rt.set_property(var_image, 'id', rt.new_int(attachment_id))
	rt.set_property(var_image, 'url', var_url.clone())
	mut var_alt := rt.call_function('get_post_meta', [rt.new_int(attachment_id), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])
	rt.set_property(var_image, 'alt', if !(!rt.is_true(var_alt)) { var_alt } else { rt.new_string('') })
	rt.set_property(var_image, 'position', rt.new_int(position_mutated).clone())
	return var_image.clone()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_reviews(product_id i64) rt.PhpVal {
	mut var_base_args := rt.create_array([rt.ArrayItem{ key: 'post_id', val: product_id }, rt.ArrayItem{ key: 'type', val: 'review' }, rt.ArrayItem{ key: 'status', val: 'approve' }])
	mut var_total_count := rt.new_int((rt.call_function('get_comments', [rt.add(var_base_args, rt.create_array([rt.ArrayItem{ key: 'count', val: true }]))])).to_i64())
	mut var_comments := rt.call_function('get_comments', [rt.add(var_base_args, rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'comment_date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'number', val: 10 }]))])
	mut var_edges := rt.new_array()
	mut var_nodes := rt.new_array()
	mut iter_5 := var_comments.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_comment := item_5.val
		mut var_review := create_automattic_woocommerce_api_types_products_productreview()
		rt.set_property(var_review, 'id', rt.new_int((rt.get_property(var_comment, 'comment_ID')).to_i64()))
		rt.set_property(var_review, 'product_id', rt.new_int(product_id))
		rt.set_property(var_review, 'reviewer', rt.get_property(var_comment, 'comment_author'))
		rt.set_property(var_review, 'review', rt.get_property(var_comment, 'comment_content'))
		rt.set_property(var_review, 'rating', rt.new_int((rt.call_function('get_comment_meta', [rt.get_property(var_comment, 'comment_ID'), rt.new_string('rating'), rt.new_bool(true)])).to_i64()))
		rt.set_property(var_review, 'date_created', if rt.is_true(rt.get_property(var_comment, 'comment_date_gmt')) { rt.call_method(create_automattic_woocommerce_api_utils_products_datetimeimmutable(rt.get_property(var_comment, 'comment_date_gmt'), create_automattic_woocommerce_api_utils_products_datetimezone(rt.new_string('UTC'))), 'format', [Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeInterface.atom()]) } else { rt.new_null() })
		mut var_edge := create_automattic_woocommerce_api_pagination_edge()
		rt.set_property(var_edge, 'cursor', rt.call_function('base64_encode', [rt.new_string((rt.get_property(var_review, 'id')).str())]))
		rt.set_property(var_edge, 'node', var_review)
		var_edges.array_push(var_edge.clone())
		var_nodes.array_push(var_review)
	}
	mut var_page_info := create_automattic_woocommerce_api_pagination_pageinfo()
	rt.set_property(var_page_info, 'has_next_page', rt.greater(var_total_count, rt.new_int(var_comments.clone().array_count())))
	rt.set_property(var_page_info, 'has_previous_page', rt.new_bool(false))
	rt.set_property(var_page_info, 'start_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(rt.new_int(0)), 'cursor') } else { rt.new_null() })
	rt.set_property(var_page_info, 'end_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(rt.new_int(var_edges.clone().array_count() - 1)), 'cursor') } else { rt.new_null() })
	mut var_connection := create_automattic_woocommerce_api_pagination_connection()
	rt.set_property(var_connection, 'edges', var_edges.clone())
	rt.set_property(var_connection, 'nodes', var_nodes.clone())
	rt.set_property(var_connection, 'page_info', var_page_info)
	rt.set_property(var_connection, 'total_count', var_total_count.clone())
	return mut var_connection
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.connection_node_info(mut var_connection_info Class_Automattic_WooCommerce_Api_Utils_Products_?array) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), var_connection_info)) {
		return rt.new_null()
	}
	mut var_nodes := if if !(var_connection_info.array_get(rt.new_string('nodes'))).is_null() { var_connection_info.array_get(rt.new_string('nodes')) } else { rt.new_null() }.is_array() { var_connection_info.array_get(rt.new_string('nodes')) } else { rt.new_array() }
	mut var_edge := if if !(var_connection_info.array_get(rt.new_string('edges')).array_get(rt.new_string('node'))).is_null() { var_connection_info.array_get(rt.new_string('edges')).array_get(rt.new_string('node')) } else { rt.new_null() }.is_array() { var_connection_info.array_get(rt.new_string('edges')).array_get(rt.new_string('node')) } else { rt.new_array() }
	if !rt.is_true(var_nodes) && !rt.is_true(var_edge) {
		return rt.new_null()
	}
	return rt.call_function('array_merge', [var_edge.clone(), var_nodes.clone()])
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.empty_connection() rt.PhpVal {
	mut var_page_info := create_automattic_woocommerce_api_pagination_pageinfo()
	rt.set_property(var_page_info, 'has_next_page', rt.new_bool(false))
	rt.set_property(var_page_info, 'has_previous_page', rt.new_bool(false))
	rt.set_property(var_page_info, 'start_cursor', rt.new_null())
	rt.set_property(var_page_info, 'end_cursor', rt.new_null())
	mut var_connection := create_automattic_woocommerce_api_pagination_connection()
	rt.set_property(var_connection, 'edges', rt.new_array())
	rt.set_property(var_connection, 'nodes', rt.new_array())
	rt.set_property(var_connection, 'page_info', var_page_info)
	rt.set_property(var_connection, 'total_count', rt.new_int(0))
	return mut var_connection
}

struct Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_Edge {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_Connection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Enums_Products_ProductType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductImage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductReview {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeImmutable {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeZone {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_utils_products_productmapper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_simpleproduct(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_externalproduct(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_variableproduct(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_paginationparams(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_edge(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_Edge {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Edge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_pageinfo(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PageInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_connection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_Connection {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_idcursorfilter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_productvariation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_selectedattribute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_enums_products_productstatus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus {
	mut obj := &Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_enums_products_producttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType {
	mut obj := &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_productdimensions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_productattribute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_productimage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductImage {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductImage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_productreview(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductReview {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductReview{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_utils_products_datetimeimmutable(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeImmutable {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeImmutable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_utils_products_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'from_wc_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.from_wc_product(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'build_external_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_external_product(mut dispatch_arg_0)
		}
		'build_variable_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_variable_product(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'slice_variation_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.slice_variation_ids(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'build_product_variation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_product_variation(mut dispatch_arg_0)
		}
		'populate_common_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_object](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.populate_common_fields(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'map_stock_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.map_stock_status(dispatch_arg_0)
		}
		'build_dimensions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_dimensions(mut dispatch_arg_0)
		}
		'build_images' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_images(mut dispatch_arg_0)
		}
		'build_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_attributes(mut dispatch_arg_0)
		}
		'build_image' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_image(dispatch_arg_0, dispatch_arg_1)
		}
		'build_reviews' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_reviews(dispatch_arg_0)
		}
		'connection_node_info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.connection_node_info(mut dispatch_arg_0)
		}
		'empty_connection' {
			return Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.empty_connection()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Enums_Products_ProductType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Enums_Products_ProductType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductImage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductImage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductImage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductReview) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductReview) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductReview) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeImmutable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeImmutable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeImmutable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
