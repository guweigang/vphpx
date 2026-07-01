import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('products/low-in-stock'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.new_array() }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', ['Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', ['Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', ['Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('products/count-low-in-stock'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.new_array() }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', ['Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_low_in_stock_count' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', ['Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_low_in_stock_count_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', ['Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_low_in_stock_count_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_count(var_request rt.PhpVal) rt.PhpVal {
	mut var_status := rt.call_method(var_request, 'get_param', [rt.new_string('status')])
	mut var_low_stock_threshold := rt.call_function('absint', [rt.call_function('max', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_low_stock_amount')]), rt.new_int(1)])])
	mut var_sidewide_stock_threshold_only := this.is_using_sitewide_stock_threshold_only(var_low_stock_threshold.dup())
	mut var_total_results := this.get_count(var_sidewide_stock_threshold_only.dup(), var_status.dup(), var_low_stock_threshold.dup())
	mut var_response := rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'total', val: var_total_results }])])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total_results.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), rt.new_int(0)])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_results := this.get_low_in_stock_products((rt.call_method(var_request, 'get_param', [rt.new_string('page')])).to_i64(), (rt.call_method(var_request, 'get_param', [rt.new_string('per_page')])).to_i64(), rt.call_method(var_request, 'get_param', [rt.new_string('status')]))
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_query_result := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_product := rt.call_function('wc_get_product', [var_query_result.dup()])
	rt.set_property(var_query_result, 'images', this.get_images(var_product.dup()))
	rt.set_property(var_query_result, 'attributes', this.get_attributes(var_product.dup()))
	return var_query_result.dup()
	}
	mut var_query_result := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_product := rt.call_function('wc_get_product', [var_query_result.dup()])
	rt.set_property(var_query_result, 'images', this.get_images(var_product.dup()))
	rt.set_property(var_query_result, 'attributes', this.get_attributes(var_product.dup()))
	return var_query_result.dup()
	}
	var_query_results.array_set('results', rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_query_results.array_get('results')]))
	var_query_results.array_set('results', this.set_last_order_date(var_query_results.array_get('results')))
	var_query_results.array_set('results', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', ['Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'transform_post_to_api_response' }]), var_query_results.array_get('results')]))
	mut var_response := rt.call_function('rest_ensure_response', [rt.call_function('array_values', [var_query_results.array_get('results')])])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_query_results.array_get('total')])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), var_query_results.array_get('pages')])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) set_last_order_date(var_results rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if 0 == var_results.dup().array_count() {
		return var_results.dup()
	}
	mut var_wheres := rt.new_array()
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result := item_1.val
			if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_result, 'post_type'))) { var_wheres.dup().array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('(product_id='), rt.get_property(var_result, 'post_parent')), rt.new_string(' and variation_id=')), rt.get_property(var_result, 'ID')), rt.new_string(')'))) } else { var_wheres.dup().array_push(rt.concat(rt.new_string('product_id='), rt.get_property(var_result, 'ID'))) }
		}
	}
	if rt.is_true(rt.new_int(var_wheres.dup().array_count())) { mut var_where_clause := rt.call_function('implode', [rt.new_string(' or '), var_wheres.dup()]) } else { var_where_clause = var_wheres.array_get(0) }
	mut var_product_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_product_lookup')
	mut var_query_string := rt.new_string(rt.new_string("\n\t\t\tselect\n\t\t\t\tproduct_id,\n\t\t\t\tvariation_id,\n\t\t\t\tMAX( wc_order_product_lookup.date_created ) AS last_order_date\n\t\t\tfrom ${var_product_lookup_table.to_string()} wc_order_product_lookup\n\t\t\twhere ${var_where_clause.to_string()}\n\t\t\tgroup by product_id\n\t\t\torder by date_created desc\n\t\t"))
	mut var_last_order_dates := rt.call_method(var_wpdb, 'get_results', [var_query_string.dup()])
	mut var_last_order_dates_index := rt.new_array()
	{
		mut iter_1 := var_last_order_dates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_last_order_date := item_1.val
			var_last_order_dates_index.array_set((rt.get_property(var_last_order_date, 'product_id')).str() + '_' + (rt.get_property(var_last_order_date, 'variation_id')).str(), var_last_order_date.dup())
		}
	}
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result := item_1.val
			if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_result, 'post_type'))) { mut var_index_key := rt.new_string((rt.get_property(var_result, 'post_parent')).str() + '_' + (rt.get_property(var_result, 'ID')).str()) } else { var_index_key = rt.new_string((rt.get_property(var_result, 'ID')).str() + '_' + (rt.get_property(var_result, 'post_parent')).str()) }
			if var_last_order_dates_index.array_isset(var_index_key) {
				rt.set_property(var_result, 'last_order_date', rt.get_property(var_last_order_dates_index.array_get(var_index_key), 'last_order_date'))
			}
		}
	}
	return var_results.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_products(page i64, per_page i64, var_status rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	// unsupported statement: Stmt_Global
	mut var_offset := rt.new_int(page - 1 * per_page)
	mut var_low_stock_threshold := rt.call_function('absint', [rt.call_function('max', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_low_stock_amount')]), rt.new_int(1)])])
	mut var_sidewide_stock_threshold_only := this.is_using_sitewide_stock_threshold_only(var_low_stock_threshold.dup())
	mut var_query_string := this.get_query((var_sidewide_stock_threshold_only).to_bool())
	mut var_query_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [var_query_string.dup(), var_status_mutated.dup(), var_low_stock_threshold.dup(), var_offset.dup(), rt.new_int(per_page)]), rt.get_constant('OBJECT_K')])
	mut var_total_results := this.get_count(var_sidewide_stock_threshold_only.dup(), var_status_mutated.dup(), var_low_stock_threshold.dup())
	return rt.create_array([rt.ArrayItem{ key: 'results', val: var_query_results }, rt.ArrayItem{ key: 'total', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'pages', val: // unsupported expression: Expr_Cast_Int }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_count(var_sidewide_stock_threshold_only rt.PhpVal, var_status rt.PhpVal, var_low_stock_threshold rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_sidewide_stock_threshold_only_mutated := var_sidewide_stock_threshold_only
	mut var_status_mutated := var_status
	mut var_low_stock_threshold_mutated := var_low_stock_threshold
	// unsupported statement: Stmt_Global
	if rt.is_true(var_sidewide_stock_threshold_only_mutated) {
		mut var_count_query_string := this.get_count_query((var_sidewide_stock_threshold_only_mutated).to_bool())
		mut var_count_query_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [var_count_query_string.dup(), var_status_mutated.dup(), var_low_stock_threshold_mutated.dup()])])
		return // unsupported expression: Expr_Cast_Int
	}
	mut var_count_query_with_custom_stock_threshold_string := this.get_products_with_custom_stock_threshold_count_query_str()
	mut var_count_query_without_custom_stock_threshold_string := this.get_products_without_custom_stock_threshold_count_query_str()
	mut var_count_query_with_custom_stock_threshold_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [var_count_query_with_custom_stock_threshold_string.dup(), var_status_mutated.dup()])])
	mut var_count_query_without_custom_stock_threshold_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [var_count_query_without_custom_stock_threshold_string.dup(), var_status_mutated.dup(), var_low_stock_threshold_mutated.dup()])])
	return rt.add(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) is_using_sitewide_stock_threshold_only(var_low_stock_threshold rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_low_stock_threshold_mutated := var_low_stock_threshold
	// unsupported statement: Stmt_Global
	mut var_query_string := rt.new_string(rt.concat(rt.concat(rt.new_string('\n\t\t\tselect count(*) as total\n\t\t\tfrom '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\twhere \n\t\t\t  meta_key=\'_low_stock_amount\'\n\t\t\t  AND meta_value > \'\'\n\t\t')))
	mut var_args := rt.new_array()
	if rt.is_true(var_low_stock_threshold_mutated) {
		// unsupported expression: Expr_AssignOp_Concat
		var_args.array_push(var_low_stock_threshold_mutated.dup())
	}
	mut var_count := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [var_query_string.dup(), var_args.dup()])])
	return rt.identical(rt.new_int(0), // unsupported expression: Expr_Cast_Int)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) transform_post_to_api_response(var_query_result rt.PhpVal) rt.PhpVal {
	mut var_query_result_mutated := var_query_result
	mut var_low_stock_amount := rt.new_null()
	if !(rt.get_property(var_query_result_mutated, 'low_stock_amount')).is_null() {
		var_low_stock_amount = // unsupported expression: Expr_Cast_Int
	}
	if !(!(rt.get_property(var_query_result_mutated, 'last_order_date')).is_null()) {
		rt.set_property(var_query_result_mutated, 'last_order_date', rt.new_null())
	}
	mut var_product_id := // unsupported expression: Expr_Cast_Int
	mut var_product_type := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory{}; return temp.get_product_type(arg_0) }(var_product_id.dup())
	return rt.create_array([rt.ArrayItem{ key: 'id', val: var_product_id }, rt.ArrayItem{ key: 'images', val: rt.get_property(var_query_result_mutated, 'images') }, rt.ArrayItem{ key: 'attributes', val: rt.get_property(var_query_result_mutated, 'attributes') }, rt.ArrayItem{ key: 'low_stock_amount', val: var_low_stock_amount }, rt.ArrayItem{ key: 'last_order_date', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_query_result_mutated, 'last_order_date')]) }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_query_result_mutated, 'post_title') }, rt.ArrayItem{ key: 'parent_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'stock_quantity', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'type', val: if rt.is_true(var_product_type) { var_product_type } else { Class_Automattic_WooCommerce_Enums_ProductType.simple() } }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_base_query(var_replacements rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_query := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT\n\t\t\t\t:selects\n\t\t\tFROM\n\t\t\t  '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup\n\t\t\t  LEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' wp_posts ON wp_posts.ID = wc_product_meta_lookup.product_id\n\t\t\t  :postmeta_join\n\t\t\tWHERE\n\t\t\t  wp_posts.post_type IN (\'product\', \'product_variation\')\n\t\t\t  AND wp_posts.post_status = %s\n\t\t\t  AND wc_product_meta_lookup.stock_quantity IS NOT NULL\n\t\t\t  AND wc_product_meta_lookup.stock_status IN(\'instock\', \'outofstock\')\n\t\t\t  :postmeta_wheres\n\t\t\t  :orderAndLimit\n\t\t')))
	return rt.call_function('strtr', [var_query.dup(), var_replacements.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) add_sitewide_stock_query_str(var_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	// unsupported statement: Stmt_Global
	mut var_postmeta := rt.create_array([rt.ArrayItem{ key: 'select', val: 'meta.meta_value AS low_stock_amount,' }, rt.ArrayItem{ key: 'join', val: rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta ON wp_posts.ID = meta.post_id\n\t\t\t  AND meta.meta_key = \'_low_stock_amount\'')) }, rt.ArrayItem{ key: 'wheres', val: 'AND (\n\t\t\t    (\n\t\t\t      meta.meta_value > \'\'\n\t\t\t      AND wc_product_meta_lookup.stock_quantity <= CAST(\n\t\t\t        meta.meta_value AS SIGNED\n\t\t\t      )\n\t\t\t    )\n\t\t\t    OR (\n\t\t\t      (\n\t\t\t        meta.meta_value IS NULL\n\t\t\t        OR meta.meta_value <= \'\'\n\t\t\t      )\n\t\t\t      AND wc_product_meta_lookup.stock_quantity <= %d\n\t\t\t    )\n\t\t    )' }])
	return rt.call_function('strtr', [var_query_mutated.dup(), rt.create_array([rt.ArrayItem{ key: ':postmeta_select', val: var_postmeta.array_get('select') }, rt.ArrayItem{ key: ':postmeta_join', val: var_postmeta.array_get('join') }, rt.ArrayItem{ key: ':postmeta_wheres', val: var_postmeta.array_get('wheres') }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_products_with_custom_stock_threshold_count_query_str() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_query := this.get_base_query(rt.create_array([rt.ArrayItem{ key: ':selects', val: 'count(*) as total' }, rt.ArrayItem{ key: ':orderAndLimit', val: '' }]))
	mut var_postmeta := rt.create_array([rt.ArrayItem{ key: 'select', val: 'meta.meta_value AS low_stock_amount,' }, rt.ArrayItem{ key: 'join', val: rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta ON wp_posts.ID = meta.post_id AND meta.meta_key = \'_low_stock_amount\' AND meta.meta_value > \'\'')) }, rt.ArrayItem{ key: 'wheres', val: 'AND wc_product_meta_lookup.stock_quantity <= CAST(meta.meta_value AS SIGNED)' }])
	return rt.call_function('strtr', [var_query.dup(), rt.create_array([rt.ArrayItem{ key: ':postmeta_select', val: var_postmeta.array_get('select') }, rt.ArrayItem{ key: ':postmeta_join', val: var_postmeta.array_get('join') }, rt.ArrayItem{ key: ':postmeta_wheres', val: var_postmeta.array_get('wheres') }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_products_without_custom_stock_threshold_count_query_str() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_query := this.get_base_query(rt.create_array([rt.ArrayItem{ key: ':selects', val: 'count(*) as total' }, rt.ArrayItem{ key: ':orderAndLimit', val: '' }]))
	mut var_postmeta := rt.create_array([rt.ArrayItem{ key: 'select', val: 'meta.meta_value AS low_stock_amount,' }, rt.ArrayItem{ key: 'join', val: rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta ON wp_posts.ID = meta.post_id AND meta.meta_key = \'_low_stock_amount\' AND meta.meta_value > \'\'')) }, rt.ArrayItem{ key: 'wheres', val: 'AND meta.post_id IS NULL AND wc_product_meta_lookup.stock_quantity <= %d' }])
	return rt.call_function('strtr', [var_query.dup(), rt.create_array([rt.ArrayItem{ key: ':postmeta_select', val: var_postmeta.array_get('select') }, rt.ArrayItem{ key: ':postmeta_join', val: var_postmeta.array_get('join') }, rt.ArrayItem{ key: ':postmeta_wheres', val: var_postmeta.array_get('wheres') }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_query(sitewide_only bool) rt.PhpVal {
	mut var_query := this.get_base_query(rt.create_array([rt.ArrayItem{ key: ':selects', val: 'wp_posts.*, :postmeta_select wc_product_meta_lookup.stock_quantity' }, rt.ArrayItem{ key: ':orderAndLimit', val: 'order by wc_product_meta_lookup.product_id DESC limit %d, %d' }]))
	if !(var_sitewide_only) {
		return this.add_sitewide_stock_query_str(var_query.dup())
	}
	return rt.call_function('strtr', [var_query.dup(), rt.create_array([rt.ArrayItem{ key: ':postmeta_select', val: '' }, rt.ArrayItem{ key: ':postmeta_join', val: '' }, rt.ArrayItem{ key: ':postmeta_wheres', val: 'AND wc_product_meta_lookup.stock_quantity <= %d' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_count_query(sitewide_only bool) rt.PhpVal {
	mut var_query := this.get_base_query(rt.create_array([rt.ArrayItem{ key: ':selects', val: 'count(*) as total' }, rt.ArrayItem{ key: ':orderAndLimit', val: '' }]))
	if !(var_sitewide_only) {
		return this.add_sitewide_stock_query_str(var_query.dup())
	}
	return rt.call_function('strtr', [var_query.dup(), rt.create_array([rt.ArrayItem{ key: ':postmeta_select', val: '' }, rt.ArrayItem{ key: ':postmeta_join', val: '' }, rt.ArrayItem{ key: ':postmeta_wheres', val: 'AND wc_product_meta_lookup.stock_quantity <= %d' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	.array_set(, )
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_count_params() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_count_schema() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productslowinstock() &Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_products_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_product_factory() &Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_low_in_stock_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_low_in_stock_count(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'set_last_order_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_last_order_date(dispatch_arg_0)
		}
		'get_low_in_stock_products' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_low_in_stock_products(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_count(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'is_using_sitewide_stock_threshold_only' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_using_sitewide_stock_threshold_only(dispatch_arg_0)
		}
		'transform_post_to_api_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.transform_post_to_api_response(dispatch_arg_0)
		}
		'get_base_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_base_query(dispatch_arg_0)
		}
		'add_sitewide_stock_query_str' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_sitewide_stock_query_str(dispatch_arg_0)
		}
		'get_products_with_custom_stock_threshold_count_query_str' {
			return this.get_products_with_custom_stock_threshold_count_query_str()
		}
		'get_products_without_custom_stock_threshold_count_query_str' {
			return this.get_products_without_custom_stock_threshold_count_query_str()
		}
		'get_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_query(dispatch_arg_0)
		}
		'get_count_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_count_query(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_low_in_stock_count_params' {
			return this.get_low_in_stock_count_params()
		}
		'get_low_in_stock_count_schema' {
			return this.get_low_in_stock_count_schema()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_productslowinstock_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
