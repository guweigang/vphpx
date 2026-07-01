import rt

struct Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.from_wc_product(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product, mut var_query_info Class_Automattic_WooCommerce_Api_Utils_Products_?array) rt.PhpVal {
	mut match_val_1 := var_wc_product.get_type()
	mut var_product := if rt.is_true(rt.equal(match_val_1, rt.new_string('external'))) { Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_external_product(mut var_wc_product) } else if rt.is_true(rt.equal(match_val_1, rt.new_string('variable'))) { Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_variable_product(mut var_wc_product, mut var_query_info) } else if rt.is_true(rt.equal(match_val_1, rt.new_string('variation'))) { Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_product_variation(mut var_wc_product) } else { create_automattic_woocommerce_api_types_products_simpleproduct() }
	Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.populate_common_fields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_object](var_product), mut var_wc_product, mut var_query_info)
	return var_product.dup()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_external_product(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
	mut var_product := create_automattic_woocommerce_api_types_products_externalproduct()
	mut var_url := var_wc_product.get_product_url()
	rt.set_property(var_product, 'product_url', if !(!rt.is_true(var_url)) { var_url } else { rt.new_null() })
	mut var_text := var_wc_product.get_button_text()
	rt.set_property(var_product, 'button_text', if !(!rt.is_true(var_text)) { var_text } else { rt.new_null() })
	return var_product.dup()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_variable_product(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product, mut var_query_info Class_Automattic_WooCommerce_Api_Utils_Products_?array) rt.PhpVal {
	mut var_product := create_automattic_woocommerce_api_types_products_variableproduct()
	mut var_child_ids := var_wc_product.get_children()
	mut var_total_count := rt.new_int(rt.new_int(var_child_ids.dup().array_count()))
	mut var_variations_info := if !(var_query_info.array_get('...VariableProduct').array_get('variations')).is_null() { var_query_info.array_get('...VariableProduct').array_get('variations') } else { if !(var_query_info.array_get('variations')).is_null() { var_query_info.array_get('variations') } else { rt.new_null() } }
	mut var_variation_query_info := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.connection_node_info(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](var_variations_info))
	mut var_pagination_args := if !(var_variations_info.array_get('__args')).is_null() { var_variations_info.array_get('__args') } else { rt.new_array() }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{}; return temp.validate_args(arg_0) }(var_pagination_args.dup())
	mut var_page := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.slice_variation_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_array](var_child_ids), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_array](var_pagination_args))
	if !(!rt.is_true(var_page.array_get('ids'))) {
		rt.call_function('_prime_post_caches', [var_page.array_get('ids')])
	}
	mut var_edges := rt.new_array()
	mut var_nodes := rt.new_array()
	{
		mut iter_1 := var_page.array_get('ids').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child_id := item_1.val
			mut var_child_product := rt.call_function('wc_get_product', [var_child_id.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_child_product)))) {
				continue
			}
			mut var_variation := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.from_wc_product(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product](var_child_product), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_?array](var_variation_query_info))
			mut var_edge := create_automattic_woocommerce_api_pagination_edge()
			rt.set_property(var_edge, 'cursor', rt.call_function('base64_encode', [// unsupported expression: Expr_Cast_String]))
			rt.set_property(var_edge, 'node', var_variation.dup())
			var_edges.array_push(var_edge.dup())
			var_nodes.array_push(var_variation.dup())
		}
	}
	mut var_page_info := create_automattic_woocommerce_api_pagination_pageinfo()
	rt.set_property(var_page_info, 'has_next_page', var_page.array_get('has_next_page'))
	rt.set_property(var_page_info, 'has_previous_page', var_page.array_get('has_previous_page'))
	rt.set_property(var_page_info, 'start_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(0), 'cursor') } else { rt.new_null() })
	rt.set_property(var_page_info, 'end_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(var_edges.dup().array_count() - 1), 'cursor') } else { rt.new_null() })
	rt.set_property(var_product, 'variations', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_Connection{}; return temp.pre_sliced(arg_0, arg_1, arg_2) }(var_edges.dup(), rt.new_object('Automattic_WooCommerce_Api_Pagination_PageInfo', []string{}, var_page_info), var_total_count.dup()))
	return var_product.dup()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.slice_variation_ids(mut var_child_ids Class_Automattic_WooCommerce_Api_Utils_Products_array, mut var_args Class_Automattic_WooCommerce_Api_Utils_Products_array) rt.PhpVal {
	mut var_child_ids_mutated := var_child_ids
	mut var_first := if !(var_args.array_get('first')).is_null() { var_args.array_get('first') } else { rt.new_null() }
	mut var_last := if !(var_args.array_get('last')).is_null() { var_args.array_get('last') } else { rt.new_null() }
	mut var_after := if !(var_args.array_get('after')).is_null() { var_args.array_get('after') } else { rt.new_null() }
	mut var_before := if !(var_args.array_get('before')).is_null() { var_args.array_get('before') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_first)) && rt.is_true(rt.identical(rt.new_null(), var_last)))) && rt.is_true(rt.identical(rt.new_null(), var_after)))) && rt.is_true(rt.identical(rt.new_null(), var_before)))) {
		return rt.create_array([rt.ArrayItem{ key: 'ids', val: rt.call_function('array_values', [var_child_ids_mutated.dup()]) }, rt.ArrayItem{ key: 'has_next_page', val: false }, rt.ArrayItem{ key: 'has_previous_page', val: false }])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_after_id := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}; return temp.decode_id_cursor(arg_0, arg_1) }(var_after.dup(), rt.new_string('after'))
		mut var_idx := rt.call_function('array_search', [var_after_id.dup(), var_child_ids_mutated.dup(), rt.new_bool(true)])
		var_child_ids_mutated = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('array_slice', [var_child_ids_mutated.dup(), rt.add(var_idx, rt.new_int(1))]) } else { rt.new_array() }
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_before_id := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}; return temp.decode_id_cursor(arg_0, arg_1) }(var_before.dup(), rt.new_string('before'))
		var_idx = rt.call_function('array_search', [var_before_id.dup(), var_child_ids_mutated.dup(), rt.new_bool(true)])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_child_ids_mutated = rt.call_function('array_slice', [var_child_ids_mutated.dup(), rt.new_int(0), var_idx.dup()])
		}
	}
	mut var_total_after_cursors := rt.new_int(rt.new_int(var_child_ids_mutated.dup().array_count()))
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.greater_equal(var_first, rt.new_int(0))))) {
		var_child_ids_mutated = rt.call_function('array_slice', [var_child_ids_mutated.dup(), rt.new_int(0), var_first.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.greater_equal(var_last, rt.new_int(0))))) {
		var_child_ids_mutated = rt.call_function('array_slice', [var_child_ids_mutated.dup(), rt.call_function('max', [rt.new_int(0), rt.sub(rt.new_int(var_child_ids_mutated.dup().array_count()), var_last)])])
	}
	return rt.create_array([rt.ArrayItem{ key: 'ids', val: rt.call_function('array_values', [var_child_ids_mutated.dup()]) }, rt.ArrayItem{ key: 'has_next_page', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.less(rt.new_int(var_child_ids_mutated.dup().array_count()), var_total_after_cursors) } else { // unsupported expression: Expr_BinaryOp_NotIdentical } }, rt.ArrayItem{ key: 'has_previous_page', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.less(rt.new_int(var_child_ids_mutated.dup().array_count()), var_total_after_cursors) } else { // unsupported expression: Expr_BinaryOp_NotIdentical } }])
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_product_variation(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
	mut var_product := create_automattic_woocommerce_api_types_products_productvariation()
	rt.set_property(var_product, 'parent_id', var_wc_product.get_parent_id())
	mut var_selected_attributes := rt.new_array()
	{
		mut iter_1 := var_wc_product.get_attributes().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_taxonomy := item_1.key
			mut var_attr := create_automattic_woocommerce_api_types_products_selectedattribute()
			rt.set_property(var_attr, 'name', var_taxonomy.dup())
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.dup()])) && !(!rt.is_true(var_value)))) {
				mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_value.dup(), var_taxonomy.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(var_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))))) {
					rt.set_property(var_attr, 'value', rt.get_property(var_term, 'name'))
				} else {
					rt.set_property(var_attr, 'value', var_value.dup())
				}
			} else {
				rt.set_property(var_attr, 'value', var_value.dup())
			}
			var_selected_attributes.array_push(var_attr.dup())
		}
	}
	rt.set_property(var_product, 'selected_attributes', var_selected_attributes.dup())
	return var_product.dup()
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.populate_common_fields(mut var_product Class_Automattic_WooCommerce_Api_Utils_Products_object, mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product, mut var_query_info Class_Automattic_WooCommerce_Api_Utils_Products_?array)  {
	mut var_product_mutated := var_product
	mut var_raw_status := // unsupported expression: Expr_Cast_String
	mut var_raw_product_type := // unsupported expression: Expr_Cast_String
	rt.set_property(var_product_mutated, 'id', var_wc_product.get_id())
	rt.set_property(var_product_mutated, 'name', var_wc_product.get_name())
	rt.set_property(var_product_mutated, 'slug', var_wc_product.get_slug())
	mut var_sku := var_wc_product.get_sku()
	rt.set_property(var_product_mutated, 'sku', if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_sku } else { rt.new_null() })
	rt.set_property(var_product_mutated, 'description', var_wc_product.get_description())
	rt.set_property(var_product_mutated, 'short_description', var_wc_product.get_short_description())
	rt.set_property(var_product_mutated, 'status', if !(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus{}; return temp.tryfrom(arg_0) }(var_raw_status.dup())).is_null() { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus{}; return temp.tryfrom(arg_0) }(var_raw_status.dup()) } else { Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus.other() })
	rt.set_property(var_product_mutated, 'raw_status', var_raw_status.dup())
	rt.set_property(var_product_mutated, 'product_type', if !(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{}; return temp.tryfrom(arg_0) }(var_raw_product_type.dup())).is_null() { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{}; return temp.tryfrom(arg_0) }(var_raw_product_type.dup()) } else { Class_Automattic_WooCommerce_Api_Enums_Products_ProductType.other() })
	rt.set_property(var_product_mutated, 'raw_product_type', var_raw_product_type.dup())
	mut var_format_regular := if !().is_null() {  } else {  }
	mut var_raw_regular := 
	if rt.is_true() {
	} else {
	}
	
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.map_stock_status(wc_status string) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_dimensions(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_images(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_attributes(mut var_wc_product Class_Automattic_WooCommerce_Api_Utils_Products_WC_Product) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_image(attachment_id i64, position i64) rt.PhpVal {
	mut position_mutated := position
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.build_reviews(product_id i64) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.connection_node_info(mut var_connection_info Class_Automattic_WooCommerce_Api_Utils_Products_?array) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper.empty_connection() rt.PhpVal {
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

fn create_automattic_woocommerce_api_utils_products_productmapper() &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_simpleproduct() &Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_SimpleProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_externalproduct() &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_variableproduct() &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_paginationparams() &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_edge() &Class_Automattic_WooCommerce_Api_Pagination_Edge {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Edge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_pageinfo() &Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PageInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_connection() &Class_Automattic_WooCommerce_Api_Pagination_Connection {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_idcursorfilter() &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_productvariation() &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_products_selectedattribute() &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_enums_products_productstatus() &Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus {
	mut obj := &Class_Automattic_WooCommerce_Api_Enums_Products_ProductStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_enums_products_producttype() &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType {
	mut obj := &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{
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




pub fn init_wp_content_plugins_woocommerce_src_api_utils_products_productmapper_php() {
	// unsupported statement: Stmt_Declare
}
