import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('products/low-in-stock'),
		rt.create_array([rt.ArrayItem{ key: 'args', val: rt.new_array() },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) }])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('products/count-low-in-stock'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.new_array() },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_low_in_stock_count' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_low_in_stock_count_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_low_in_stock_count_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_count(var_request rt.PhpVal) rt.PhpVal {
	mut var_status := rt.call_method(var_request, 'get_param', [
		rt.new_string('status')])
	mut var_low_stock_threshold := rt.call_function('absint', [
		rt.call_function('max', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_notify_low_stock_amount'),
			]),
			rt.new_int(1),
		]),
	])
	mut var_sidewide_stock_threshold_only :=
		rt.new_bool(this.is_using_sitewide_stock_threshold_only(var_low_stock_threshold.clone()))
	mut var_total_results := rt.new_int(this.get_count(var_sidewide_stock_threshold_only.clone(),
		var_status.clone(), var_low_stock_threshold.clone()))
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'total', val: var_total_results }]),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		var_total_results.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(0)])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_results := this.get_low_in_stock_products((rt.call_method(var_request,
		'get_param', [rt.new_string('page')])).to_i64(), (rt.call_method(var_request, 'get_param', [
		rt.new_string('per_page'),
	])).to_i64(), rt.call_method(var_request, 'get_param', [rt.new_string('status')]))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_query_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_product := rt.call_function('wc_get_product', [
			var_query_result.clone()])
		rt.set_property(var_query_result, 'images', this.get_images(var_product.clone()))
		rt.set_property(var_query_result, 'attributes', this.get_attributes(var_product.clone()))
		return var_query_result.clone()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_query_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_product := rt.call_function('wc_get_product', [
			var_query_result.clone()])
		rt.set_property(var_query_result, 'images', this.get_images(var_product.clone()))
		rt.set_property(var_query_result, 'attributes', this.get_attributes(var_product.clone()))
		return var_query_result.clone()
	}
	var_query_results.array_set('results', rt.call_function('array_map', [
		rt.new_closure(closure_1_fn),
		var_query_results.array_get(rt.new_string('results')),
	]))
	var_query_results.array_set('results',
		this.set_last_order_date(var_query_results.array_get(rt.new_string('results'))))
	var_query_results.array_set('results', rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductsLowInStock', [
				'Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'transform_post_to_api_response' },
		]),
		var_query_results.array_get(rt.new_string('results')),
	]))
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.call_function('array_values', [var_query_results.array_get(rt.new_string('results'))]),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		var_query_results.array_get(rt.new_string('total'))])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		var_query_results.array_get(rt.new_string('pages'))])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) set_last_order_date(var_results rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if 0 == var_results.clone().array_count() {
		return var_results.clone()
	}
	mut var_wheres := rt.new_array()
	mut iter_1 := var_results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_result := item_1.val
		if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_result,
			'post_type')))
		{
			var_wheres.clone().array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('(product_id='), rt.get_property(var_result,
				'post_parent')), rt.new_string(' and variation_id=')), rt.get_property(var_result,
				'ID')), rt.new_string(')')))
		} else {
			var_wheres.clone().array_push(rt.concat(rt.new_string('product_id='), rt.get_property(var_result,
				'ID')))
		}
	}
	mut var_where_clause := rt.call_function('implode', [rt.new_string(' or '),
		var_wheres.clone()])
	var_where_clause = var_wheres.array_get(rt.new_int(0))
	if rt.is_true(rt.new_int(var_wheres.clone().array_count())) {
		var_where_clause
	} else {
		var_where_clause
	}
	mut var_product_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_product_lookup')
	mut var_query_string :=
		rt.new_string('\n\t\t\tselect\n\t\t\t\tproduct_id,\n\t\t\t\tvariation_id,\n\t\t\t\tMAX( wc_order_product_lookup.date_created ) AS last_order_date\n\t\t\tfrom ${var_product_lookup_table.to_string()} wc_order_product_lookup\n\t\t\twhere ${var_where_clause.to_string()}\n\t\t\tgroup by product_id\n\t\t\torder by date_created desc\n\t\t')
	mut var_last_order_dates := rt.call_method(var_wpdb, 'get_results', [
		var_query_string.clone()])
	mut var_last_order_dates_index := rt.new_array()
	mut iter_2 := var_last_order_dates.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_last_order_date := item_2.val
		var_last_order_dates_index.array_set(
			(rt.get_property(var_last_order_date, 'product_id')).str() + '_' +
			(rt.get_property(var_last_order_date, 'variation_id')).str(),
			var_last_order_date.clone())
	}
	mut iter_3 := var_results.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_result := item_3.val
		mut var_index_key := rt.new_string((rt.get_property(var_result, 'post_parent')).str() +
			'_' + (rt.get_property(var_result, 'ID')).str())
		var_index_key = rt.new_string((rt.get_property(var_result, 'ID')).str() + '_' +
			(rt.get_property(var_result, 'post_parent')).str())
		if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_result,
			'post_type')))
		{
			var_index_key
		} else {
			var_index_key
		}
		if var_last_order_dates_index.array_isset(var_index_key) {
			rt.set_property(var_result, 'last_order_date', rt.get_property(var_last_order_dates_index.array_get(var_index_key),
				'last_order_date'))
		}
	}
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_products(page i64, per_page i64, var_status rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	mut var_offset := rt.new_int(page - 1 * per_page)
	mut var_low_stock_threshold := rt.call_function('absint', [
		rt.call_function('max', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_notify_low_stock_amount'),
			]),
			rt.new_int(1),
		]),
	])
	mut var_sidewide_stock_threshold_only :=
		rt.new_bool(this.is_using_sitewide_stock_threshold_only(var_low_stock_threshold.clone()))
	mut var_query_string := this.get_query(var_sidewide_stock_threshold_only.to_bool())
	mut var_query_results := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [var_query_string.clone(),
			var_status_mutated.clone(), var_low_stock_threshold.clone(),
			var_offset.clone(), rt.new_int(per_page)]),
		rt.get_constant('OBJECT_K'),
	])
	mut var_total_results := rt.new_int(this.get_count(var_sidewide_stock_threshold_only.clone(),
		var_status_mutated.clone(), var_low_stock_threshold.clone()))
	return rt.create_array([rt.ArrayItem{ key: 'results', val: var_query_results },
		rt.ArrayItem{ key: 'total', val: rt.new_int(var_total_results.to_i64()) },
		rt.ArrayItem{ key: 'pages', val: rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_results, per_page),
		])).to_i64()) }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_count(var_sidewide_stock_threshold_only rt.PhpVal, var_status rt.PhpVal, var_low_stock_threshold rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_sidewide_stock_threshold_only_mutated := var_sidewide_stock_threshold_only
	mut var_status_mutated := var_status
	mut var_low_stock_threshold_mutated := var_low_stock_threshold
	if rt.is_true(var_sidewide_stock_threshold_only_mutated) {
		mut var_count_query_string :=
			this.get_count_query(var_sidewide_stock_threshold_only_mutated.to_bool())
		mut var_count_query_results := rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [var_count_query_string.clone(),
				var_status_mutated.clone(), var_low_stock_threshold_mutated.clone()]),
		])
		return rt.new_int((rt.get_property(var_count_query_results.array_get(rt.new_int(0)),
			'total')).to_i64())
	}
	mut var_count_query_with_custom_stock_threshold_string :=
		this.get_products_with_custom_stock_threshold_count_query_str()
	mut var_count_query_without_custom_stock_threshold_string :=
		this.get_products_without_custom_stock_threshold_count_query_str()
	mut var_count_query_with_custom_stock_threshold_results := rt.call_method(var_wpdb,
		'get_results', [
		rt.call_method(var_wpdb, 'prepare', [var_count_query_with_custom_stock_threshold_string.clone(),
			var_status_mutated.clone()]),
	])
	mut var_count_query_without_custom_stock_threshold_results := rt.call_method(var_wpdb,
		'get_results', [
		rt.call_method(var_wpdb, 'prepare', [var_count_query_without_custom_stock_threshold_string.clone(),
			var_status_mutated.clone(), var_low_stock_threshold_mutated.clone()]),
	])
	return
		rt.new_int((rt.get_property(var_count_query_with_custom_stock_threshold_results.array_get(rt.new_int(0)), 'total')).to_i64()) +
		rt.new_int((rt.get_property(var_count_query_without_custom_stock_threshold_results.array_get(rt.new_int(0)), 'total')).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) is_using_sitewide_stock_threshold_only(var_low_stock_threshold rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_low_stock_threshold_mutated := var_low_stock_threshold
	mut var_query_string := rt.new_string((rt.concat(rt.concat(rt.new_string('\n\t\t\tselect count(*) as total\n\t\t\tfrom '), rt.get_property(var_wpdb,
		'postmeta')),
		rt.new_string("\n\t\t\twhere \n\t\t\t  meta_key='_low_stock_amount'\n\t\t\t  AND meta_value > ''\n\t\t"))).str())
	mut var_args := rt.new_array()
	if rt.is_true(var_low_stock_threshold_mutated) {
		var_query_string = rt.concat(var_query_string, rt.new_string(' AND meta_value != %d'))
		var_args.array_push(var_low_stock_threshold_mutated.clone())
	}
	mut var_count := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [var_query_string.clone(),
			var_args.clone()]),
	])
	return rt.new_bool(0 == rt.new_int(var_count.to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) transform_post_to_api_response(var_query_result rt.PhpVal) rt.PhpVal {
	mut var_query_result_mutated := var_query_result
	mut var_low_stock_amount := rt.new_null()
	if !(rt.get_property(var_query_result_mutated, 'low_stock_amount')).is_null() {
		var_low_stock_amount = rt.new_int((rt.get_property(var_query_result_mutated,
			'low_stock_amount')).to_i64())
	}
	if !(!(rt.get_property(var_query_result_mutated, 'last_order_date')).is_null()) {
		rt.set_property(var_query_result_mutated, 'last_order_date', rt.new_null())
	}
	mut var_product_id := rt.new_int((rt.get_property(var_query_result_mutated, 'ID')).to_i64())
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory{}
	mut iife_result_2 := iife_temp_2.get_product_type(var_product_id.clone())
	mut var_product_type := iife_result_2
	return rt.create_array([rt.ArrayItem{ key: 'id', val: var_product_id },
		rt.ArrayItem{ key: 'images', val: rt.get_property(var_query_result_mutated, 'images') },
		rt.ArrayItem{ key: 'attributes', val: rt.get_property(var_query_result_mutated,
			'attributes') }, rt.ArrayItem{ key: 'low_stock_amount', val: var_low_stock_amount },
		rt.ArrayItem{ key: 'last_order_date', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_query_result_mutated, 'last_order_date'),
		]) }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_query_result_mutated,
			'post_title') }, rt.ArrayItem{ key: 'parent_id', val: rt.new_int((rt.get_property(var_query_result_mutated,
			'post_parent')).to_i64()) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.new_int((rt.get_property(var_query_result_mutated,
			'stock_quantity')).to_i64()) }, rt.ArrayItem{
			key: 'type'
			val: if rt.is_true(var_product_type) {
				var_product_type
			} else {
				Class_Automattic_WooCommerce_Enums_ProductType.simple()
			}
		}])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_base_query(var_replacements rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT\n\t\t\t\t:selects\n\t\t\tFROM\n\t\t\t  '), rt.get_property(var_wpdb,
		'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup\n\t\t\t  LEFT JOIN ')), rt.get_property(var_wpdb,
		'posts')),
		rt.new_string(" wp_posts ON wp_posts.ID = wc_product_meta_lookup.product_id\n\t\t\t  :postmeta_join\n\t\t\tWHERE\n\t\t\t  wp_posts.post_type IN ('product', 'product_variation')\n\t\t\t  AND wp_posts.post_status = %s\n\t\t\t  AND wc_product_meta_lookup.stock_quantity IS NOT NULL\n\t\t\t  AND wc_product_meta_lookup.stock_status IN('instock', 'outofstock')\n\t\t\t  :postmeta_wheres\n\t\t\t  :orderAndLimit\n\t\t"))).str())
	return rt.call_function('strtr', [var_query.clone(), var_replacements.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) add_sitewide_stock_query_str(var_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	mut var_postmeta := rt.create_array([
		rt.ArrayItem{ key: 'select', val: 'meta.meta_value AS low_stock_amount,' },
		rt.ArrayItem{
			key: 'join'
			val: rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" AS meta ON wp_posts.ID = meta.post_id\n\t\t\t  AND meta.meta_key = '_low_stock_amount'"))
		},
		rt.ArrayItem{
			key: 'wheres'
			val: "AND (\n\t\t\t    (\n\t\t\t      meta.meta_value > ''\n\t\t\t      AND wc_product_meta_lookup.stock_quantity <= CAST(\n\t\t\t        meta.meta_value AS SIGNED\n\t\t\t      )\n\t\t\t    )\n\t\t\t    OR (\n\t\t\t      (\n\t\t\t        meta.meta_value IS NULL\n\t\t\t        OR meta.meta_value <= ''\n\t\t\t      )\n\t\t\t      AND wc_product_meta_lookup.stock_quantity <= %d\n\t\t\t    )\n\t\t    )"
		},
	])
	return rt.call_function('strtr', [var_query_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: ':postmeta_select'
				val: var_postmeta.array_get(rt.new_string('select'))
			},
			rt.ArrayItem{ key: ':postmeta_join', val: var_postmeta.array_get(rt.new_string('join')) },
			rt.ArrayItem{
				key: ':postmeta_wheres'
				val: var_postmeta.array_get(rt.new_string('wheres'))
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_products_with_custom_stock_threshold_count_query_str() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := this.get_base_query(rt.create_array([
		rt.ArrayItem{ key: ':selects', val: 'count(*) as total' },
		rt.ArrayItem{ key: ':orderAndLimit', val: '' },
	]))
	mut var_postmeta := rt.create_array([
		rt.ArrayItem{ key: 'select', val: 'meta.meta_value AS low_stock_amount,' },
		rt.ArrayItem{
			key: 'join'
			val: rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'postmeta')),
				rt.new_string(" AS meta ON wp_posts.ID = meta.post_id AND meta.meta_key = '_low_stock_amount' AND meta.meta_value > ''"))
		},
		rt.ArrayItem{
			key: 'wheres'
			val: 'AND wc_product_meta_lookup.stock_quantity <= CAST(meta.meta_value AS SIGNED)'
		},
	])
	return rt.call_function('strtr', [var_query.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: ':postmeta_select'
				val: var_postmeta.array_get(rt.new_string('select'))
			},
			rt.ArrayItem{ key: ':postmeta_join', val: var_postmeta.array_get(rt.new_string('join')) },
			rt.ArrayItem{
				key: ':postmeta_wheres'
				val: var_postmeta.array_get(rt.new_string('wheres'))
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_products_without_custom_stock_threshold_count_query_str() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := this.get_base_query(rt.create_array([
		rt.ArrayItem{ key: ':selects', val: 'count(*) as total' },
		rt.ArrayItem{ key: ':orderAndLimit', val: '' },
	]))
	mut var_postmeta := rt.create_array([
		rt.ArrayItem{ key: 'select', val: 'meta.meta_value AS low_stock_amount,' },
		rt.ArrayItem{
			key: 'join'
			val: rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" AS meta ON wp_posts.ID = meta.post_id AND meta.meta_key = '_low_stock_amount' AND meta.meta_value > ''"))
		},
		rt.ArrayItem{
			key: 'wheres'
			val: 'AND meta.post_id IS NULL AND wc_product_meta_lookup.stock_quantity <= %d'
		},
	])
	return rt.call_function('strtr', [var_query.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: ':postmeta_select'
				val: var_postmeta.array_get(rt.new_string('select'))
			},
			rt.ArrayItem{ key: ':postmeta_join', val: var_postmeta.array_get(rt.new_string('join')) },
			rt.ArrayItem{
				key: ':postmeta_wheres'
				val: var_postmeta.array_get(rt.new_string('wheres'))
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_query(sitewide_only bool) rt.PhpVal {
	mut var_query := this.get_base_query(rt.create_array([
		rt.ArrayItem{
			key: ':selects'
			val: 'wp_posts.*, :postmeta_select wc_product_meta_lookup.stock_quantity'
		},
		rt.ArrayItem{
			key: ':orderAndLimit'
			val: 'order by wc_product_meta_lookup.product_id DESC limit %d, %d'
		},
	]))
	if !var_sitewide_only {
		return this.add_sitewide_stock_query_str(var_query.clone())
	}
	return rt.call_function('strtr', [var_query.clone(),
		rt.create_array([rt.ArrayItem{ key: ':postmeta_select', val: '' },
			rt.ArrayItem{ key: ':postmeta_join', val: '' }, rt.ArrayItem{
				key: ':postmeta_wheres'
				val: 'AND wc_product_meta_lookup.stock_quantity <= %d'
			}])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_count_query(sitewide_only bool) rt.PhpVal {
	mut var_query := this.get_base_query(rt.create_array([
		rt.ArrayItem{ key: ':selects', val: 'count(*) as total' },
		rt.ArrayItem{ key: ':orderAndLimit', val: '' },
	]))
	if !var_sitewide_only {
		return this.add_sitewide_stock_query_str(var_query.clone())
	}
	return rt.call_function('strtr', [var_query.clone(),
		rt.create_array([rt.ArrayItem{ key: ':postmeta_select', val: '' },
			rt.ArrayItem{ key: ':postmeta_join', val: '' }, rt.ArrayItem{
				key: ':postmeta_wheres'
				val: 'AND wc_product_meta_lookup.stock_quantity <= %d'
			}])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param())
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Current page of the collection.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 1 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_params.array_set('per_page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Maximum number of items to be returned in result set.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 10 },
		rt.ArrayItem{ key: 'minimum', val: 1 },
		rt.ArrayItem{ key: 'maximum', val: 100 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'publish' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products assigned a specific status.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [
			rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{})),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_ProductStatus.future()
				},
			]),
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_count_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param())
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'publish' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products assigned a specific status.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [
			rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{})),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_ProductStatus.future()
				},
			]),
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock) get_low_in_stock_count_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'Count Low in Stock Items' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'total', val: 'integer' },
			]) },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productslowinstock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductsLowInStock{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_products_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_product_factory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_Product_Factory {
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
			return rt.new_int(this.get_count(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'is_using_sitewide_stock_threshold_only' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_using_sitewide_stock_threshold_only(dispatch_arg_0))
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
		else {
			return none
		}
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
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
