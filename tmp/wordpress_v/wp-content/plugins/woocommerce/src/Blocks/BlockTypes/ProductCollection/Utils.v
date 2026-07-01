import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.prepare_and_execute_query(var_block rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_page_key := rt.new_string(if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) { 'query-' + (rt.get_property(var_block, 'context').array_get('queryId')).str() + '-page' } else { rt.new_string('query-page') })
	mut var_page := if !rt.is_true(rt.get_superglobal('_GET').array_get(var_page_key)) { rt.new_int(1) } else { // unsupported expression: Expr_Cast_Int }
	mut var_use_global_query := rt.new_bool(rt.new_bool(rt.get_property(var_block, 'context').array_get('query').array_isset(rt.new_string('inherit')) && rt.is_true(rt.get_property(var_block, 'context').array_get('query').array_get('inherit'))))
	if rt.is_true(var_use_global_query) {
		// unsupported statement: Stmt_Global
		mut var_query := // unsupported expression: Expr_Clone
	} else {
		mut var_query_args := rt.call_function('build_query_vars_from_query_block', [var_block.dup(), var_page.dup()])
		var_query = create_wp_query(var_query_args.dup())
	}
	return var_query.dup()
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.get_query_vars(var_block rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_page_mutated := var_page
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_block, 'context').array_get('query'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block, 'context').array_get('query').array_get('inherit'))))))) {
		return rt.call_function('build_query_vars_from_query_block', [var_block.dup(), var_page_mutated.dup()])
	}
	// unsupported statement: Stmt_Global
	return rt.call_function('array_filter', [rt.get_property(var_wp_query, 'query_vars')])
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.remove_query_array(var_queries rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_queries_mutated.dup().is_array()))))) || !rt.is_true(var_queries_mutated))) {
		return var_queries_mutated.dup()
	}
	{
		mut iter_1 := var_queries_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query := item_1.val
			mut var_query_key := item_1.key
			if rt.is_true(rt.new_bool(var_query.array_isset(var_key) && rt.is_true(rt.identical(var_query.array_get(var_key), var_value)))) {
				var_queries_mutated.array_unset(var_query_key)
			}
			if var_query.array_isset(rt.new_string('relation')) || !(var_query.array_isset(var_key)) {
				var_queries_mutated.array_set(var_query_key, Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.remove_query_array(var_query.dup(), var_key.dup(), var_value.dup()))
			}
		}
	}
	return Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.remove_empty_array_recursive(var_queries_mutated.dup())
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.parse_frontend_location_context() rt.PhpVal {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_type := rt.new_string(rt.new_string('site'))
	mut var_source_data := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_query, 'WP_Query')))))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'sourceData', val: var_source_data }])
	}
	if rt.is_true(rt.call_function('is_order_received_page', []rt.PhpVal{})) {
		var_type = rt.new_string(rt.new_string('order'))
		var_source_data = rt.create_array([rt.ArrayItem{ key: 'orderId', val: rt.call_function('absint', [rt.get_property(var_wp_query, 'query_vars').array_get('order-received')]) }])
	} else {
		mut var_current_page := rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
		mut var_has_cart_block := rt.new_bool(rt.new_bool(rt.is_true(var_current_page) && rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils{}; return temp.has_block_in_page(arg_0, arg_1) }(var_current_page.dup(), rt.new_string('woocommerce/cart')))))
		mut var_has_checkout_block := rt.new_bool(rt.new_bool(rt.is_true(var_current_page) && rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils{}; return temp.has_block_in_page(arg_0, arg_1) }(var_current_page.dup(), rt.new_string('woocommerce/checkout')))))
		mut var_is_cart_available := rt.new_bool(rt.new_bool(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null() && rt.is_true(rt.call_function('is_a', [rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), rt.new_string('WC_Cart')]))))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_cart_block) || rt.is_true(var_has_checkout_block))) || rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))) && rt.is_true(var_is_cart_available))) {
			var_type = rt.new_string(rt.new_string('cart'))
			mut var_items := rt.new_array()
			{
				mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart', []rt.PhpVal{}).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_cart_item := item_1.val
					if !(var_cart_item.array_isset(rt.new_string('product_id'))) {
						continue
					}
					var_items.array_push(rt.call_function('absint', [var_cart_item.array_get('product_id')]))
				}
			}
			var_items = rt.call_function('array_unique', [rt.call_function('array_filter', [var_items.dup()])])
			var_source_data = rt.create_array([rt.ArrayItem{ key: 'productIds', val: var_items }])
		} else if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
			mut var_source := rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
			mut var_is_valid := rt.call_function('is_a', [var_source.dup(), rt.new_string('WP_Term')])
			mut var_taxonomy := if rt.is_true(var_is_valid) { rt.get_property(var_source, 'taxonomy') } else { rt.new_string('') }
			mut var_term_id := if rt.is_true(var_is_valid) { rt.get_property(var_source, 'term_id') } else { rt.new_string('') }
			var_type = rt.new_string(rt.new_string('archive'))
			var_source_data = rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.call_function('wc_clean', [var_taxonomy.dup()]) }, rt.ArrayItem{ key: 'termId', val: rt.call_function('absint', [var_term_id.dup()]) }])
		} else if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
			var_source = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
			mut var_product_id := if rt.is_true(rt.call_function('is_a', [var_source.dup(), rt.new_string('WP_Post')])) { rt.call_function('absint', [rt.get_property(var_source, 'ID')]) } else { rt.new_int(0) }
			var_type = rt.new_string(rt.new_string('product'))
			var_source_data = rt.create_array([rt.ArrayItem{ key: 'productId', val: var_product_id }])
		}
	}
	mut var_context := rt.create_array([rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'sourceData', val: var_source_data }])
	return var_context.dup()
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.remove_empty_array_recursive(var_array rt.PhpVal) rt.PhpVal {
	mut var_array_mutated := var_array
	var_array_mutated = rt.call_function('array_filter', [var_array_mutated.dup()])
	{
		mut iter_1 := var_array_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_item.dup().is_array())) {
				var_array_mutated.array_set(var_key, Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.remove_empty_array_recursive(var_item.dup()))
			}
		}
	}
	return var_array_mutated.dup()
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_wc_blocks_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_and_execute_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.prepare_and_execute_query(dispatch_arg_0)
		}
		'get_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.get_query_vars(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_query_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.remove_query_array(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'parse_frontend_location_context' {
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.parse_frontend_location_context()
		}
		'remove_empty_array_recursive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils.remove_empty_array_recursive(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WC_Blocks_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productcollection_utils_php() {
	// unsupported statement: Stmt_Declare
}
