import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	rt.PhpObjectBase
pub mut:
	cache_key           rt.PhpVal = rt.new_string('products')
	column_types        rt.PhpVal = rt.new_array()
	extended_attributes rt.PhpVal = rt.new_array()
	context             rt.PhpVal = rt.new_string('products')
}

fn init_static_automattic_woocommerce_admin_api_reports_products_datastore() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore',
		'table_name', rt.new_string('wc_order_product_lookup'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) assign_report_columns() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{ key: 'product_id', val: 'product_id' },
		rt.ArrayItem{ key: 'items_sold', val: 'SUM(product_qty) as items_sold' },
		rt.ArrayItem{ key: 'net_revenue', val: 'SUM(product_net_revenue) AS net_revenue' },
		rt.ArrayItem{
			key: 'orders_count'
			val: 'COUNT( DISTINCT ( CASE WHEN product_gross_revenue >= 0 THEN ${var_table_name.to_string()}.order_id END ) ) as orders_count'
		},
	]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_analytics_delete_order_stats'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'sync_on_order_delete' }]),
		rt.new_int(10),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_partially_refunded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_partial_refund_type_meta' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_fully_refunded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_full_refund_type_meta' }]),
		rt.new_int(10), rt.new_int(2)])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_partial_refund_type_meta(var_order_id rt.PhpVal, var_refund_id rt.PhpVal) {
	Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(var_refund_id.clone(),
		rt.new_string('partial'))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_full_refund_type_meta(var_order_id rt.PhpVal, var_refund_id rt.PhpVal) {
	Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(var_refund_id.clone(),
		rt.new_string('full'))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(var_refund_id rt.PhpVal, var_type rt.PhpVal) {
	mut var_type_mutated := var_type
	mut var_order := rt.call_function('wc_get_order', [var_refund_id.clone()])
	rt.call_method(var_order, 'update_meta_data', [rt.new_string('_refund_type'),
		var_type_mutated.clone()])
	rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) add_from_sql_params(var_query_args rt.PhpVal, var_arg_name rt.PhpVal, var_id_cell rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	mut var_type := rt.new_string('join')
	mut switch_val_1 := var_query_args_mutated.array_get(rt.new_string('orderby'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_name'))) {
		mut var_join := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' JOIN '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' AS _products ON ')), var_id_cell),
			rt.new_string(' = _products.ID'))).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sku'))) {
		var_join = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string(' AS postmeta ON ')), var_id_cell),
			rt.new_string(" = postmeta.post_id AND postmeta.meta_key = '_sku'"))).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variations'))) {
		var_type = rt.new_string('left_join')
		var_join = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN ( SELECT post_parent, COUNT(*) AS variations FROM '), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string(" WHERE post_type = 'product_variation' GROUP BY post_parent ) AS _variations ON ")),
			var_id_cell), rt.new_string(' = _variations.post_parent'))).str())
	} else {
		var_join = rt.new_string('')
	}
	if rt.is_true(var_join) {
		if rt.is_true(rt.identical(rt.new_string('inner'), var_arg_name)) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [var_type.clone(),
				var_join.clone()])
		} else {
			this.add_sql_clause(var_type.clone(), var_join.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) add_sql_query_params(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_1 := iife_temp_1.get_db_table_name()
	mut var_order_product_lookup_table := iife_result_1
	this.add_time_period_sql_params(var_query_args_mutated.clone(),
		var_order_product_lookup_table.clone())
	this.get_limit_sql_params(var_query_args_mutated.clone())
	this.add_order_by_sql_params(var_query_args_mutated.clone())
	mut var_included_products := this.get_included_products(var_query_args_mutated.clone())
	if rt.is_true(var_included_products) {
		this.add_from_sql_params(var_query_args_mutated.clone(), rt.new_string('outer'),
			rt.new_string('default_results.product_id'))
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ${var_order_product_lookup_table.to_string()}.product_id IN (${var_included_products.to_string()})')])
	} else {
		this.add_from_sql_params(var_query_args_mutated.clone(), rt.new_string('inner'),
			rt.new_string('${var_order_product_lookup_table.to_string()}.product_id'))
	}
	mut var_included_variations := this.get_included_variations(var_query_args_mutated.clone())
	if rt.is_true(var_included_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ${var_order_product_lookup_table.to_string()}.variation_id IN (${var_included_variations.to_string()})')])
	}
	mut var_order_status_filter := this.get_status_subquery(var_query_args_mutated.clone())
	if rt.is_true(var_order_status_filter) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_order_stats ON ')), var_order_product_lookup_table),
				rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('wc_order_stats.order_id'))])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ( ${var_order_status_filter.to_string()} )')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
		mut iife_result_2 := iife_temp_2.get_db_table_name()
		return iife_result_2.str() + '.date_created'
	}
	if rt.is_true(rt.identical(rt.new_string('product_name'), var_order_by)) {
		return 'post_title'
	}
	if rt.is_true(rt.identical(rt.new_string('sku'), var_order_by)) {
		return 'meta_value'
	}
	return var_order_by.str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) include_extended_info(var_products_data rt.PhpVal, var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	mut var_product_names := rt.new_array()
	mut iter_1 := var_products_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_data := item_1.val
		mut var_key := item_1.key
		mut var_extended_info :=
			create_automattic_woocommerce_admin_api_reports_products_arrayobject()
		if rt.is_true(var_query_args_mutated.array_get(rt.new_string('extended_info'))) {
			mut var_product_id := var_product_data.array_get(rt.new_string('product_id'))
			mut var_product := rt.call_function('wc_get_product', [
				var_product_id.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
				if !(var_product_names.array_isset(var_product_id)) {
					var_product_names.array_set(var_product_id, rt.call_method(var_wpdb, 'get_var', [
						rt.call_method(var_wpdb, 'prepare', [
							rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT i.order_item_name\n\t\t\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
								'prefix')),
								rt.new_string('wc_order_product_lookup l\n\t\t\t\t\t\t\t\tJOIN ')), rt.get_property(var_wpdb,
								'prefix')),
								rt.new_string('woocommerce_order_items i ON i.order_item_id = l.order_item_id\n\t\t\t\t\t\t\t\tWHERE l.product_id = %d\n\t\t\t\t\t\t\t\tORDER BY l.order_item_id DESC\n\t\t\t\t\t\t\t\tLIMIT 1')),
							var_product_id.clone(),
						]),
					]))
				}
				var_products_data.array_get_mut(var_key).array_get_mut('extended_info').array_set('name', if rt.is_true(var_product_names.array_get(var_product_id)) { rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('%s (Deleted)'),
							rt.new_string('woocommerce')]),
						var_product_names.array_get(var_product_id),
					]) } else { rt.call_function('__', [rt.new_string('(Deleted)'),
						rt.new_string('woocommerce')]) })
				continue
			}
			mut var_extended_attributes := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_rest_reports_products_extended_attributes'),
				this.extended_attributes,
				var_product_data.clone(),
			])
			mut iter_2 := var_extended_attributes.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_extended_attribute := item_2.val
				if rt.is_true(rt.identical(rt.new_string('variations'), var_extended_attribute)) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [
						Class_Automattic_WooCommerce_Enums_ProductType.variable(),
					])))))
					{
						continue
					}
					mut var_function := rt.new_string('get_children')
				} else {
					var_function = rt.new_string('get_' + var_extended_attribute.str())
				}
				if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_product },
						rt.ArrayItem{ key: none, val: var_function }]),
				]))
				{
					mut var_value := rt.call_method(var_product, var_function, []rt.PhpVal{})
					var_extended_info.array_set(var_extended_attribute, var_value.clone())
				}
			}
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) get_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_data :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_data(var_query_args_mutated.clone())
	mut var_defaults := this.get_default_query_vars()
	var_query_args_mutated = rt.call_function('wp_parse_args', [
		var_query_args_mutated.clone(), var_defaults.clone()])
	this.include_extended_info(rt.get_property(var_data, 'data'), var_query_args_mutated.clone())
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('category_includes', rt.new_array())
	var_defaults.array_set('product_includes', rt.new_array())
	var_defaults.array_set('extended_info', false)
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_3 := iife_temp_3.get_db_table_name()
	mut var_table_name := iife_result_3
	this.initialize_queries()
	mut var_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.new_array() },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'pages', val: 0 },
		rt.ArrayItem{ key: 'page_no', val: 0 },
	]))
	mut var_selections := this.selected_columns(var_query_args_mutated.clone())
	mut var_included_products := this.get_included_products_array(var_query_args_mutated.clone())
	mut var_params := this.get_limit_params(var_query_args_mutated.clone())
	this.add_sql_query_params(var_query_args_mutated.clone())
	if var_included_products.clone().array_count() > 0 {
		mut var_filtered_products := rt.call_function('array_diff', [
			var_included_products.clone(), rt.create_array([
				rt.ArrayItem{ key: none, val: '-1' },
			])])
		mut var_total_results := rt.new_int(var_filtered_products.clone().array_count())
		mut var_total_pages := rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_results, var_params.array_get(rt.new_string('per_page'))),
		])).to_i64())
		if rt.is_true(rt.identical(rt.new_string('date'),
			var_query_args_mutated.array_get(rt.new_string('orderby'))))
		{
			var_selections = rt.concat(var_selections,
				rt.new_string(', ${var_table_name.to_string()}.date_created'))
		}
		mut var_fields := this.get_fields(var_query_args_mutated.clone())
		mut var_join_selections := this.format_join_selections(var_fields.clone(), rt.create_array([
			rt.ArrayItem{ key: none, val: 'product_id' },
		]))
		mut var_ids_table := this.get_ids_table(var_included_products.clone(),
			rt.new_string('product_id'))
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
			var_selections.clone()])
		this.add_sql_clause(rt.new_string('select'), var_join_selections.clone())
		this.add_sql_clause(rt.new_string('from'), rt.new_string('('))
		this.add_sql_clause(rt.new_string('from'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}))
		this.add_sql_clause(rt.new_string('from'),
			rt.new_string(') AS ${var_table_name.to_string()}'))
		this.add_sql_clause(rt.new_string('right_join'),
			rt.new_string('RIGHT JOIN ( ${var_ids_table.to_string()} ) AS default_results\n\t\t\t\tON default_results.product_id = ${var_table_name.to_string()}.product_id'))
		this.add_sql_clause(rt.new_string('where'),
			rt.new_string('AND default_results.product_id != -1'))
		mut var_products_query := this.get_query_statement()
	} else {
		mut var_count_query := rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM (\n\t\t\t\t\t'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})),
			rt.new_string('\n\t\t\t\t) AS tt'))).str())
		mut var_db_records_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			var_count_query.clone(),
		])).to_i64())
		var_total_results = var_db_records_count.clone()
		var_total_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(var_db_records_count, var_params.array_get(rt.new_string('per_page'))),
		])).to_i64())
		if rt.is_true(rt.less(var_query_args_mutated.array_get(rt.new_string('page')), rt.new_int(1)))
			|| rt.is_true(rt.greater(var_query_args_mutated.array_get(rt.new_string('page')), var_total_pages)) {
			return var_data.clone()
		}
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
			var_selections.clone()])
		if rt.is_true(rt.call_function('in_array', [
			var_query_args_mutated.array_get(rt.new_string('orderby')),
			rt.create_array([rt.ArrayItem{ key: none, val: 'items_sold' },
				rt.ArrayItem{ key: none, val: 'net_revenue' },
				rt.ArrayItem{ key: none, val: 'orders_count' },
				rt.ArrayItem{ key: none, val: 'variations' }]),
			rt.new_bool(true),
		]))
		{
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
				rt.new_string(
					(this.get_sql_clause(rt.new_string('order_by'))).str() + ', product_id')])
		} else {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
				this.get_sql_clause(rt.new_string('order_by'))])
		}
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'),
			this.get_sql_clause(rt.new_string('limit'))])
		var_products_query = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})
	}
	mut var_product_data := rt.call_method(var_wpdb, 'get_results', [
		var_products_query.clone(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_product_data)) {
		return var_data.clone()
	}
	var_product_data = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
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
			val: rt.new_int((var_query_args_mutated.array_get(rt.new_string('page'))).to_i64())
		},
	]))
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.sync_order_products(var_order_id rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return -1
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_4 := iife_temp_4.get_db_table_name()
	mut var_table_name := iife_result_4
	mut var_existing_items := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT order_item_id FROM ${var_table_name.to_string()} WHERE order_id = %d'),
			var_order_id.clone(),
		]),
	])
	var_existing_items = rt.call_function('array_flip', [var_existing_items.clone()])
	mut var_order_items := rt.call_method(var_order, 'get_items', []rt.PhpVal{})
	mut var_num_updated := rt.new_int(0)
	mut var_decimals := rt.call_function('wc_get_price_decimals', []rt.PhpVal{})
	mut var_round_tax := rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_round_at_subtotal'),
	]))
	mut var_is_full_refund_without_line_items := rt.new_bool(false)
	mut var_partial_refund_product_revenue := rt.new_array()
	mut var_refund_type := rt.call_method(var_order, 'get_meta', [
		rt.new_string('_refund_type'),
	])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_5 := iife_temp_5.uses_new_full_refund_data()
	mut var_uses_new_full_refund_data := iife_result_5
	mut var_parent_order := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('shop_order_refund'), rt.call_method(var_order, 'get_type', []rt.PhpVal{})))
		&& rt.is_true(rt.identical(rt.new_string('full'), var_refund_type))
		&& !rt.is_true(var_order_items) && rt.is_true(var_uses_new_full_refund_data) {
		var_is_full_refund_without_line_items = rt.new_bool(true)
		mut var_parent_order_id := rt.call_method(var_order, 'get_parent_id', []rt.PhpVal{})
		var_parent_order = rt.call_function('wc_get_order', [
			var_parent_order_id.clone()])
		var_order_items = rt.call_method(var_parent_order, 'get_items', []rt.PhpVal{})
		mut var_partial_refund_products := rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\t\tSELECT\n\t\t\t\t\t\t\tproduct_lookup.product_id,\n\t\t\t\t\t\t\tproduct_lookup.variation_id,\n\t\t\t\t\t\t\tSUM( product_lookup.product_net_revenue ) AS product_net_revenue\n\t\t\t\t\t\tFROM %i AS product_lookup\n\t\t\t\t\t\tINNER JOIN '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('wc_order_stats AS order_stats\n\t\t\t\t\t\t\tON order_stats.order_id = product_lookup.order_id\n\t\t\t\t\t\tWHERE 1 = 1\n\t\t\t\t\t\t\tAND order_stats.parent_id = %d\n\t\t\t\t\t\t\tAND product_lookup.product_net_revenue < 0\n\t\t\t\t\t\tGROUP BY product_lookup.product_id, product_lookup.variation_id\n\t\t\t\t\t')),
				var_table_name.clone(),
				var_parent_order_id.clone(),
			]),
		])
		mut iter_3 := var_partial_refund_products.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_product := item_3.val
			mut var_id := if rt.is_true(rt.get_property(var_product, 'variation_id')) {
				rt.get_property(var_product, 'variation_id')
			} else {
				rt.get_property(var_product, 'product_id')
			}
			var_partial_refund_product_revenue.array_set(var_id, rt.new_float((rt.get_property(var_product,
				'product_net_revenue')).to_f64()))
		}
	}
	mut iter_4 := var_order_items.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_order_item := item_4.val
		mut var_order_item_id := rt.call_method(var_order_item, 'get_id', []rt.PhpVal{})
		var_existing_items.array_unset(var_order_item_id)
		mut var_product_qty := rt.call_method(var_order_item, 'get_quantity', [
			rt.new_string('edit'),
		])
		mut var_product_id := rt.call_method(var_order_item, 'get_product_id', [
			rt.new_string('edit'),
		])
		mut var_variation_id := rt.call_method(var_order_item, 'get_variation_id', [
			rt.new_string('edit'),
		])
		mut var_shipping_amount := rt.call_method(var_order, 'get_item_shipping_amount', [
			var_order_item.clone(),
		])
		mut var_shipping_tax_amount := rt.call_method(var_order, 'get_item_shipping_tax_amount', [
			var_order_item.clone(),
		])
		mut var_coupon_amount := rt.call_method(var_order, 'get_item_coupon_amount', [
			var_order_item.clone(),
		])
		mut var_tax_amount := rt.call_method(var_order, 'get_item_cart_tax_amount', [
			var_order_item.clone(),
		])
		mut var_net_revenue := rt.call_function('round', [
			rt.call_method(var_order_item, 'get_total', [rt.new_string('edit')]),
			var_decimals.clone(),
		])
		if rt.is_true(var_is_full_refund_without_line_items) {
			mut var_id := if rt.is_true(var_variation_id) {
				var_variation_id
			} else {
				var_product_id
			}
			mut var_partial_refund := if !(var_partial_refund_product_revenue.array_get(var_id)).is_null() {
				var_partial_refund_product_revenue.array_get(var_id)
			} else {
				rt.new_int(0)
			}
			var_net_revenue = rt.sub(rt.new_int(0), rt.call_function('abs', [
				rt.add(var_net_revenue, var_partial_refund),
			]))
			if rt.is_true(rt.identical(rt.new_float(0), var_net_revenue)) {
				continue
			}
			var_product_qty = rt.sub(rt.new_int(0), rt.call_function('abs', [
				var_product_qty.clone()]))
			var_coupon_amount = rt.new_int(0)
			if rt.is_true(var_parent_order) {
				mut var_remaining_refund_items := rt.call_method(var_parent_order,
					'get_remaining_refund_items', []rt.PhpVal{})
				mut var_total_shipping_refunded := rt.call_method(var_parent_order,
					'get_total_shipping_refunded', []rt.PhpVal{})
				mut var_shipping_total := rt.new_float((rt.call_method(var_parent_order,
					'get_shipping_total', []rt.PhpVal{})).to_f64())
				mut var_total_shipping_to_refund := rt.sub(var_shipping_total,
					var_total_shipping_refunded)
				if rt.is_true(rt.greater(var_total_shipping_to_refund, rt.new_int(0))) {
					var_shipping_amount = rt.sub(rt.new_int(0), rt.call_function('abs', [
						rt.call_method(var_parent_order, 'get_item_shipping_amount', [
							var_order_item.clone(),
							var_remaining_refund_items.clone(),
							var_total_shipping_to_refund.clone(),
						]),
					]))
				}
				mut var_shipping_tax := rt.new_float((rt.call_method(var_parent_order,
					'get_shipping_tax', []rt.PhpVal{})).to_f64())
				mut var_total_shipping_tax_refunded := rt.call_method(var_parent_order,
					'get_total_shipping_tax_refunded', []rt.PhpVal{})
				mut var_total_shipping_tax_to_refund := rt.sub(var_shipping_tax,
					var_total_shipping_tax_refunded)
				if rt.is_true(rt.greater(var_total_shipping_tax_to_refund, rt.new_int(0))) {
					var_shipping_tax_amount = rt.sub(rt.new_int(0), rt.call_function('abs', [
						rt.call_method(var_parent_order, 'get_item_shipping_tax_amount', [
							var_order_item.clone(),
							var_remaining_refund_items.clone(),
							var_total_shipping_tax_to_refund.clone(),
						]),
					]))
				}
				var_tax_amount = rt.sub(rt.new_int(0), rt.call_function('abs', [
					rt.call_method(var_parent_order, 'get_item_cart_tax_amount', [
						var_order_item.clone(),
					]),
				]))
			}
		}
		mut var_is_refund := rt.less(var_net_revenue, rt.new_int(0))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product_qty))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_refund)))) {
			rt.pre_inc(var_num_updated)
			continue
		}
		if rt.is_true(var_round_tax) {
			var_tax_amount = rt.call_function('round', [var_tax_amount.clone(),
				var_decimals.clone()])
		}
		mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
		mut iife_result_6 := iife_temp_6.get_db_table_name()
		mut var_result := rt.call_method(var_wpdb, 'replace', [iife_result_6,
			rt.create_array([
				rt.ArrayItem{ key: 'order_item_id', val: var_order_item_id },
				rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'product_id', val: var_product_id },
				rt.ArrayItem{ key: 'variation_id', val: var_variation_id },
				rt.ArrayItem{ key: 'customer_id', val: rt.call_method(var_order,
					'get_report_customer_id', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'product_qty', val: var_product_qty },
				rt.ArrayItem{ key: 'product_net_revenue', val: var_net_revenue },
				rt.ArrayItem{
					key: 'date_created'
					val: rt.call_method(rt.call_method(var_order, 'get_date_created', [
						rt.new_string('edit')]), 'date', [
						rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
							'sql_datetime_format'),
					])
				},
				rt.ArrayItem{ key: 'coupon_amount', val: var_coupon_amount },
				rt.ArrayItem{ key: 'tax_amount', val: var_tax_amount },
				rt.ArrayItem{ key: 'shipping_amount', val: var_shipping_amount },
				rt.ArrayItem{ key: 'shipping_tax_amount', val: var_shipping_tax_amount },
				rt.ArrayItem{ key: 'product_gross_revenue', val: rt.add(rt.add(rt.add(var_net_revenue,
					var_tax_amount), var_shipping_amount), var_shipping_tax_amount) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%f' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%f' },
				rt.ArrayItem{ key: none, val: '%f' },
				rt.ArrayItem{ key: none, val: '%f' },
				rt.ArrayItem{ key: none, val: '%f' },
				rt.ArrayItem{ key: none, val: '%f' },
			])])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_analytics_update_product'),
			var_order_item_id.clone(),
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		])
		var_num_updated = rt.add(var_num_updated, if 2 == var_result.clone().to_i64() {
			1
		} else {
			var_result.clone().to_i64()
		})
	}
	if !(!rt.is_true(var_existing_items)) {
		var_existing_items = rt.call_function('array_flip', [
			var_existing_items.clone()])
		mut var_format := rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_existing_items.clone().array_count()),
			rt.new_string('%d')])
		var_format = rt.call_function('implode', [rt.new_string(','),
			var_format.clone()])
		rt.call_function('array_unshift', [var_existing_items.clone(),
			var_order_id.clone()])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('DELETE FROM ${var_table_name.to_string()} WHERE order_id = %d AND order_item_id in (${var_format.to_string()})'),
				var_existing_items.clone(),
			]),
		])
	}
	return (rt.identical(rt.new_int(var_order_items.clone().array_count()), var_num_updated)).to_i64()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.sync_on_order_delete(var_order_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_7 := iife_temp_7.get_db_table_name()
	rt.call_method(var_wpdb, 'delete', [iife_result_7,
		rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_analytics_delete_product'),
		rt.new_int(0), var_order_id.clone()])
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
	mut iife_result_8 := iife_temp_8.invalidate()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) initialize_queries() {
	this.clear_all_clauses()
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery(
		(this.context).str() + '_subquery'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string('product_id')])
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_9 := iife_temp_9.get_db_table_name()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'), iife_result_9])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'),
		rt.new_string('product_id')])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_products_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{
		PhpObjectBase:       rt.PhpObjectBase{}
		cache_key:           rt.new_string('products')
		column_types:        rt.new_array()
		extended_attributes: rt.new_array()
		context:             rt.new_string('products')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_products_arrayobject(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.init()
			return rt.new_null()
		}
		'add_partial_refund_type_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_partial_refund_type_meta(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'add_full_refund_type_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_full_refund_type_meta(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'add_refund_type_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'add_from_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_from_sql_params(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
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
		'get_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_data(dispatch_arg_0)
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'sync_order_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.sync_order_products(dispatch_arg_0))
		}
		'sync_on_order_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.sync_on_order_delete(dispatch_arg_0)
			return rt.new_null()
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

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'extended_attributes' { return this.extended_attributes }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
