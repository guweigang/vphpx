import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore {
	rt.PhpObjectBase
pub mut:
	cache_key           rt.PhpVal = rt.new_string('variations')
	column_types        rt.PhpVal = rt.new_array()
	extended_attributes rt.PhpVal = rt.new_array()
	context             rt.PhpVal = rt.new_string('variations')
}

fn init_static_automattic_woocommerce_admin_api_reports_variations_datastore() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore',
		'table_name', rt.new_string('wc_order_product_lookup'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) assign_report_columns() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{ key: 'product_id', val: 'product_id' },
		rt.ArrayItem{ key: 'variation_id', val: 'variation_id' },
		rt.ArrayItem{ key: 'items_sold', val: 'SUM(product_qty) as items_sold' },
		rt.ArrayItem{ key: 'net_revenue', val: 'SUM(product_net_revenue) AS net_revenue' },
		rt.ArrayItem{
			key: 'orders_count'
			val: 'COUNT(DISTINCT ${var_table_name.to_string()}.order_id) as orders_count'
		},
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) add_from_sql_params(var_query_args rt.PhpVal, var_arg_name rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('sku'),
		var_query_args.array_get(rt.new_string('orderby'))))))
	{
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{}
	mut iife_result_1 := iife_temp_1.get_db_table_name()
	mut var_table_name := iife_result_1
	mut var_join := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb,
		'postmeta')), rt.new_string(' AS postmeta ON ')), var_table_name),
		rt.new_string(".variation_id = postmeta.post_id AND postmeta.meta_key = '_sku'"))).str())
	if rt.is_true(rt.identical(rt.new_string('inner'), var_arg_name)) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			var_join.clone()])
	} else {
		this.add_sql_clause(rt.new_string('join'), var_join.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) get_order_item_by_attribute_subquery(var_query_args rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{}
	mut iife_result_2 := iife_temp_2.get_db_table_name()
	mut var_order_product_lookup_table := iife_result_2
	mut var_attribute_subqueries := this.get_attribute_subqueries(var_query_args.clone())
	if rt.is_true(var_attribute_subqueries.array_get(rt.new_string('join')))
		&& rt.is_true(var_attribute_subqueries.array_get(rt.new_string('where'))) {
		mut var_attr_subquery := create_automattic_woocommerce_admin_api_reports_sqlquery(
			(this.context).str() + '_attribute_subquery')
		var_attr_subquery.add_sql_clause(rt.new_string('select'),
			rt.new_string('DISTINCT ${var_order_product_lookup_table.to_string()}.order_item_id'))
		var_attr_subquery.add_sql_clause(rt.new_string('from'),
			var_order_product_lookup_table.clone())
		if rt.is_true(this.should_exclude_simple_products(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_API_Reports_Variations_array](var_query_args))) {
			var_attr_subquery.add_sql_clause(rt.new_string('where'),
				rt.new_string('AND ${var_order_product_lookup_table.to_string()}.variation_id != 0'))
		}
		mut iter_1 := var_attribute_subqueries.array_get(rt.new_string('join')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute_join := item_1.val
			var_attr_subquery.add_sql_clause(rt.new_string('join'), var_attribute_join.clone())
		}
		mut var_operator := this.get_match_operator(var_query_args.clone())
		var_attr_subquery.add_sql_clause(rt.new_string('where'), rt.new_string(
			'AND (' + (rt.call_function('implode', [rt.new_string(' ${var_operator.to_string()} '), var_attribute_subqueries.array_get(rt.new_string('where'))])).str() +
			')'))
		return rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('AND '),
			var_order_product_lookup_table), rt.new_string('.order_item_id IN (')),
			var_attr_subquery.get_query_statement()), rt.new_string(')'))).str())
	}
	return rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) add_sql_query_params(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{}
	mut iife_result_3 := iife_temp_3.get_db_table_name()
	mut var_order_product_lookup_table := iife_result_3
	mut var_order_stats_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_stats')
	mut var_order_item_meta_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'woocommerce_order_itemmeta')
	mut var_where_subquery := rt.new_array()
	this.add_time_period_sql_params(var_query_args.clone(), var_order_product_lookup_table.clone())
	this.get_limit_sql_params(var_query_args.clone())
	this.add_order_by_sql_params(var_query_args.clone())
	mut var_included_variations := this.get_included_variations(var_query_args.clone())
	if rt.is_true(rt.greater(var_included_variations, rt.new_int(0))) {
		this.add_from_sql_params(var_query_args.clone(), rt.new_string('outer'))
	} else {
		this.add_from_sql_params(var_query_args.clone(), rt.new_string('inner'))
	}
	mut var_included_products := this.get_included_products(var_query_args.clone())
	if rt.is_true(var_included_products) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ${var_order_product_lookup_table.to_string()}.product_id IN (${var_included_products.to_string()})')])
	}
	mut var_excluded_products := this.get_excluded_products(var_query_args.clone())
	if rt.is_true(var_excluded_products) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ${var_order_product_lookup_table.to_string()}.product_id NOT IN (${var_excluded_products.to_string()})')])
	}
	if rt.is_true(var_included_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ${var_order_product_lookup_table.to_string()}.variation_id IN (${var_included_variations.to_string()})')])
	} else if rt.is_true(this.should_exclude_simple_products(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_API_Reports_Variations_array](var_query_args))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ${var_order_product_lookup_table.to_string()}.variation_id != 0')])
	}
	mut var_order_status_filter := this.get_status_subquery(var_query_args.clone())
	if rt.is_true(var_order_status_filter) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('JOIN ${var_order_stats_lookup_table.to_string()} ON ${var_order_product_lookup_table.to_string()}.order_id = ${var_order_stats_lookup_table.to_string()}.order_id')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ( ${var_order_status_filter.to_string()} )')])
	}
	mut var_attribute_order_items_subquery :=
		this.get_order_item_by_attribute_subquery(var_query_args.clone())
	if rt.is_true(var_attribute_order_items_subquery) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order_status_filter)))) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
				rt.new_string('JOIN ${var_order_product_lookup_table.to_string()} ON ${var_order_stats_lookup_table.to_string()}.order_id = ${var_order_product_lookup_table.to_string()}.order_id')])
		}
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			var_attribute_order_items_subquery.clone()])
	}
	if 0 < var_where_subquery.clone().array_count() {
		mut var_operator := this.get_match_operator(var_query_args.clone())
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string(
				'AND (' + (rt.call_function('implode', [rt.new_string(' ${var_operator.to_string()} '), var_where_subquery.clone()])).str() +
				')')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{}
		mut iife_result_4 := iife_temp_4.get_db_table_name()
		return iife_result_4.str() + '.date_created'
	}
	if rt.is_true(rt.identical(rt.new_string('sku'), var_order_by)) {
		return 'meta_value'
	}
	return var_order_by.str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) include_extended_info(var_products_data rt.PhpVal, var_query_args rt.PhpVal) {
	mut iter_2 := var_products_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product_data := item_2.val
		mut var_key := item_2.key
		mut var_extended_info :=
			create_automattic_woocommerce_admin_api_reports_variations_arrayobject()
		if rt.is_true(var_query_args.array_get(rt.new_string('extended_info'))) {
			mut var_extended_attributes := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_rest_reports_variations_extended_attributes'),
				this.extended_attributes,
				var_product_data.clone(),
			])
			mut var_parent_product := rt.call_function('wc_get_product', [
				var_product_data.array_get(rt.new_string('product_id')),
			])
			mut var_attributes := rt.new_array()
			mut var_variation_id :=
				rt.new_int((var_product_data.array_get(rt.new_string('variation_id'))).to_i64())
			mut var_variation_product := if rt.is_true(rt.identical(rt.new_int(0), var_variation_id)) { var_parent_product } else { rt.call_function('wc_get_product', [
					var_variation_id.clone(),
				]) }
			mut var_extended_attributes_product := if rt.is_true(rt.call_function('is_a', [
				var_variation_product.clone(),
				rt.new_string('WC_Product'),
			]))
			{ var_variation_product } else { var_parent_product }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_extended_attributes_product)))) {
				var_extended_info.array_set('deleted', true)
			}
			mut iter_3 := var_extended_attributes.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_extended_attribute := item_3.val
				mut var_function := rt.new_string('get_' + var_extended_attribute.str())
				if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_extended_attributes_product },
						rt.ArrayItem{ key: none, val: var_function },
					]),
				]))
				{
					mut var_value := rt.call_method(var_extended_attributes_product, var_function,
						[]rt.PhpVal{})
					var_extended_info.array_set(var_extended_attribute, var_value.clone())
				}
			}
			if rt.is_true(rt.less(rt.new_int(0), var_variation_id))
				&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: var_variation_product
			}, rt.ArrayItem{ key: none, val: 'get_variation_attributes' }])]) {
				mut var_variation_attributes := rt.call_method(var_variation_product,
					'get_variation_attributes', []rt.PhpVal{})
				mut iter_4 := var_variation_attributes.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_attribute := item_4.val
					mut var_attribute_name := item_4.key
					mut var_name := rt.call_function('str_replace', [
						rt.new_string('attribute_'),
						rt.new_string(''),
						var_attribute_name.clone(),
					])
					mut var_option_term := rt.call_function('get_term_by', [
						rt.new_string('slug'),
						var_attribute.clone(),
						var_name.clone(),
					])
					var_attributes.array_push(rt.create_array([
						rt.ArrayItem{ key: 'id', val: rt.call_function('wc_attribute_taxonomy_id_by_name', [
							var_name.clone(),
						]) },
						rt.ArrayItem{ key: 'name', val: rt.call_function('str_replace', [
							rt.new_string('pa_'),
							rt.new_string(''),
							var_name.clone(),
						]) },
						rt.ArrayItem{
							key: 'option'
							val: if rt.is_true(var_option_term)
								&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_option_term.clone()]))))) {
								rt.get_property(var_option_term, 'name')
							} else {
								var_attribute
							}
						},
					]))
				}
			}
			var_extended_info.array_set('attributes', var_attributes.clone())
			if rt.is_true(rt.identical(rt.new_string(''),
				var_extended_info.array_get(rt.new_string('low_stock_amount'))))
			{
				var_extended_info.array_set('low_stock_amount', rt.call_function('absint', [
					rt.call_function('max', [
						rt.call_function('get_option', [
							rt.new_string('woocommerce_notify_low_stock_amount'),
						]),
						rt.new_int(1),
					]),
				]))
			}
			var_extended_info = this.cast_numbers(var_extended_info.clone())
		}
		var_products_data.array_get_mut(var_key).array_set('extended_info',
			var_extended_info.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) should_exclude_simple_products(mut var_query_args Class_Automattic_WooCommerce_Admin_API_Reports_Variations_array) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('experimental_woocommerce_analytics_variations_should_exclude_simple_products'),
		rt.new_bool(true),
		var_query_args,
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) fill_deleted_product_name(mut var_products Class_Automattic_WooCommerce_Admin_API_Reports_Variations_array) {
	mut var_wpdb := rt.new_null()
	mut var_product_variation_ids := rt.new_array()
	mut iter_5 := var_products.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_product := item_5.val
		mut var_key := item_5.key
		if !(var_product.array_get(rt.new_string('extended_info')).array_isset(rt.new_string('name'))) {
			var_product_variation_ids.array_set(var_key, rt.create_array([
				rt.ArrayItem{
					key: 'product_id'
					val: var_product.array_get(rt.new_string('product_id'))
				},
				rt.ArrayItem{
					key: 'variation_id'
					val: var_product.array_get(rt.new_string('variation_id'))
				},
			]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_product_variation_ids.clone().array_count()))))) {
		return
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_ids := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_ids := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_where_clauses := rt.call_function('implode', [rt.new_string(' or '),
		rt.call_function('array_map', [rt.new_closure(closure_6_fn),
			var_product_variation_ids.clone()])])
	mut var_query := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tselect\n\t\t\t\tproduct_lookup.product_id,\n\t\t\t\tproduct_lookup.variation_id,\n\t\t\t\torder_items.order_item_name\n\t\t\tfrom\n\t\t\t\t'), rt.get_property(var_wpdb,
		'prefix')), rt.new_string('wc_order_product_lookup as product_lookup\n\t\t\t\tleft join ')), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string('woocommerce_order_items as order_items\n\t\t\t\ton product_lookup.order_item_id = order_items.order_item_id\n\t\t\twhere\n\t\t\t\t')),
		var_where_clauses),
		rt.new_string('\n\t\t\tgroup by\n\t\t\t\tproduct_lookup.product_id,\n\t\t\t\tproduct_lookup.variation_id,\n\t\t\t\torder_items.order_item_name\n\t\t'))).str())
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		var_query.clone()])
	mut var_index := rt.new_array()
	mut iter_6 := var_results.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_result := item_6.val
		var_index.array_set((rt.get_property(var_result, 'product_id')).str() + '_' +
			(rt.get_property(var_result, 'variation_id')).str(), rt.get_property(var_result,
			'order_item_name'))
	}
	mut iter_7 := var_product_variation_ids.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_ids := item_7.val
		mut var_product_key := item_7.key
		mut var_product := var_products.array_get(var_product_key)
		mut var_index_key := rt.new_string(
			(var_product.array_get(rt.new_string('product_id'))).str() + '_' +
			(var_product.array_get(rt.new_string('variation_id'))).str())
		if var_index.array_isset(var_index_key) {
			var_products.array_get_mut(var_product_key).array_get_mut('extended_info').array_set('name',
				var_index.array_get(var_index_key))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('product_includes', rt.new_array())
	var_defaults.array_set('variation_includes', rt.new_array())
	var_defaults.array_set('extended_info', false)
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{}
	mut iife_result_7 := iife_temp_7.get_db_table_name()
	mut var_table_name := iife_result_7
	this.initialize_queries()
	mut var_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.new_array() },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'pages', val: 0 },
		rt.ArrayItem{ key: 'page_no', val: 0 },
	]))
	mut var_selections := this.selected_columns(var_query_args.clone())
	mut var_included_variations := if
		var_query_args.array_isset(rt.new_string('variation_includes'))
		&& var_query_args.array_get(rt.new_string('variation_includes')).is_array() {
		var_query_args.array_get(rt.new_string('variation_includes'))
	} else {
		rt.new_array()
	}
	mut var_params := this.get_limit_params(var_query_args.clone())
	this.add_sql_query_params(var_query_args.clone())
	if var_included_variations.clone().array_count() > 0 {
		mut var_total_results := rt.new_int(var_included_variations.clone().array_count())
		mut var_total_pages := rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_results, var_params.array_get(rt.new_string('per_page'))),
		])).to_i64())
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
			var_selections.clone()])
		if rt.is_true(rt.identical(rt.new_string('date'),
			var_query_args.array_get(rt.new_string('orderby'))))
		{
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
				rt.new_string(', ${var_table_name.to_string()}.date_created')])
		}
		mut var_fields := this.get_fields(var_query_args.clone())
		mut var_join_selections := this.format_join_selections(var_fields.clone(), rt.create_array([
			rt.ArrayItem{ key: none, val: 'variation_id' },
		]))
		mut var_ids_table := this.get_ids_table(var_included_variations.clone(),
			rt.new_string('variation_id'))
		this.add_sql_clause(rt.new_string('select'), var_join_selections.clone())
		this.add_sql_clause(rt.new_string('from'), rt.new_string('('))
		this.add_sql_clause(rt.new_string('from'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}))
		this.add_sql_clause(rt.new_string('from'),
			rt.new_string(') AS ${var_table_name.to_string()}'))
		this.add_sql_clause(rt.new_string('right_join'),
			rt.new_string('RIGHT JOIN ( ${var_ids_table.to_string()} ) AS default_results\n\t\t\t\tON default_results.variation_id = ${var_table_name.to_string()}.variation_id'))
		mut var_variations_query := this.get_query_statement()
	} else {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
			var_selections.clone()])
		rt.call_function('apply_filters', [
			rt.new_string('experimental_woocommerce_analytics_variations_additional_clauses'),
			var_query_args.clone(),
			rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'),
		])
		mut var_db_records_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM (\n\t\t\t\t\t'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})),
				rt.new_string('\n\t\t\t\t) AS tt')),
		])).to_i64())
		var_total_results = var_db_records_count.clone()
		var_total_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(var_db_records_count, var_params.array_get(rt.new_string('per_page'))),
		])).to_i64())
		if rt.is_true(rt.less(var_query_args.array_get(rt.new_string('page')), rt.new_int(1)))
			|| rt.is_true(rt.greater(var_query_args.array_get(rt.new_string('page')), var_total_pages)) {
			return var_data.clone()
		}
		if rt.is_true(rt.call_function('in_array', [
			var_query_args.array_get(rt.new_string('orderby')),
			rt.create_array([rt.ArrayItem{ key: none, val: 'items_sold' },
				rt.ArrayItem{ key: none, val: 'net_revenue' },
				rt.ArrayItem{ key: none, val: 'orders_count' }]),
			rt.new_bool(true),
		]))
		{
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
				rt.new_string(
					(this.get_sql_clause(rt.new_string('order_by'))).str() + ', product_id, variation_id')])
		} else {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
				this.get_sql_clause(rt.new_string('order_by'))])
		}
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'),
			this.get_sql_clause(rt.new_string('limit'))])
		var_variations_query = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})
	}
	mut var_product_data := rt.call_method(var_wpdb, 'get_results', [
		var_variations_query.clone(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_product_data)) {
		return var_data.clone()
	}
	this.include_extended_info(var_product_data.clone(), var_query_args.clone())
	if rt.is_true(var_query_args.array_get(rt.new_string('extended_info'))) {
		this.fill_deleted_product_name(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_API_Reports_Variations_array](var_product_data))
	}
	var_product_data = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'cast_numbers' },
		]),
		var_product_data.clone(),
	])
	var_data = rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_product_data },
		rt.ArrayItem{ key: 'total', val: var_total_results },
		rt.ArrayItem{ key: 'pages', val: var_total_pages },
		rt.ArrayItem{
			key: 'page_no'
			val: rt.new_int((var_query_args.array_get(rt.new_string('page'))).to_i64())
		},
	]))
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) initialize_queries() {
	this.clear_all_clauses()
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery(
		(this.context).str() + '_subquery'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string('product_id')])
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{}
	mut iife_result_8 := iife_temp_8.get_db_table_name()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'), iife_result_8])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'),
		rt.new_string('product_id, variation_id')])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Variations_ArrayObject {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_variations_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore{
		PhpObjectBase:       rt.PhpObjectBase{}
		cache_key:           rt.new_string('variations')
		column_types:        rt.new_array()
		extended_attributes: rt.new_array()
		context:             rt.new_string('variations')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_sqlquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_variations_arrayobject(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_ArrayObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'add_from_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_from_sql_params(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_order_item_by_attribute_subquery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_item_by_attribute_subquery(dispatch_arg_0)
		}
		'add_sql_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_sql_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'normalize_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.normalize_order_by(dispatch_arg_0))
		}
		'include_extended_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.include_extended_info(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'should_exclude_simple_products' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_API_Reports_Variations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.should_exclude_simple_products(mut dispatch_arg_0)
		}
		'fill_deleted_product_name' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_API_Reports_Variations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.fill_deleted_product_name(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'initialize_queries' {
			this.initialize_queries()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'extended_attributes' { return this.extended_attributes }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache_key' {
			this.cache_key = val
			return true
		}
		'column_types' {
			this.column_types = val
			return true
		}
		'extended_attributes' {
			this.extended_attributes = val
			return true
		}
		'context' {
			this.context = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_ArrayObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_ArrayObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_ArrayObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
