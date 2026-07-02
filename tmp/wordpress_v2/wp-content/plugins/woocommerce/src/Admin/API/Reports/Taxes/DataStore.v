import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore {
	rt.PhpObjectBase
pub mut:
	cache_key    rt.PhpVal = rt.new_string('taxes')
	column_types rt.PhpVal = rt.new_array()
	context      rt.PhpVal = rt.new_string('taxes')
}

fn init_static_automattic_woocommerce_admin_api_reports_taxes_datastore() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', 'table_name',
		rt.new_string('wc_order_tax_lookup'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) assign_report_columns() {
	mut var_wpdb := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{ key: 'tax_rate_id', val: '${var_table_name.to_string()}.tax_rate_id' },
		rt.ArrayItem{ key: 'name', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX(SUBSTRING_INDEX('), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("woocommerce_order_items.order_item_name,'-',-2), '-', 1) as name")) },
		rt.ArrayItem{
			key: 'tax_rate'
			val: 'CAST(itemmeta_rate_percent.meta_value AS DECIMAL(7,4)) as tax_rate'
		},
		rt.ArrayItem{ key: 'country', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX('), rt.get_property(var_wpdb,
			'prefix')), rt.new_string("woocommerce_order_items.order_item_name,'-',1) as country")) },
		rt.ArrayItem{ key: 'state', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX(SUBSTRING_INDEX('), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("woocommerce_order_items.order_item_name,'-',-3), '-', 1) as state")) },
		rt.ArrayItem{ key: 'priority', val: rt.concat(rt.concat(rt.new_string('SUBSTRING_INDEX('), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("woocommerce_order_items.order_item_name,'-',-1) as priority")) },
		rt.ArrayItem{ key: 'total_tax', val: 'SUM(total_tax) as total_tax' },
		rt.ArrayItem{ key: 'order_tax', val: 'SUM(order_tax) as order_tax' },
		rt.ArrayItem{ key: 'shipping_tax', val: 'SUM(shipping_tax) as shipping_tax' },
		rt.ArrayItem{
			key: 'orders_count'
			val: 'COUNT( DISTINCT ( CASE WHEN parent_id = 0 THEN ${var_table_name.to_string()}.order_id END ) ) as orders_count'
		},
	]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_analytics_delete_order_stats'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'sync_on_order_delete' }]),
		rt.new_int(15),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) add_from_sql_params(var_query_args rt.PhpVal, var_order_status_filter rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_status_filter_mutated := var_order_status_filter
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_1 := iife_temp_1.get_db_table_name()
	mut var_table_name := iife_result_1
	if rt.is_true(var_order_status_filter_mutated) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_order_stats ON ')), var_table_name),
				rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('wc_order_stats.order_id'))])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('woocommerce_order_items ON ')), var_table_name),
			rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('woocommerce_order_items.order_id AND ')), rt.get_property(var_wpdb,
			'prefix')), rt.new_string("woocommerce_order_items.order_item_type = 'tax'"))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string('woocommerce_order_itemmeta itemmeta_rate_id ON itemmeta_rate_id.order_item_id = ')), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("woocommerce_order_items.order_item_id AND itemmeta_rate_id.meta_key = 'rate_id'"))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string('woocommerce_order_itemmeta itemmeta_rate_percent ON itemmeta_rate_percent.order_item_id = ')), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("woocommerce_order_items.order_item_id AND itemmeta_rate_percent.meta_key = 'rate_percent'"))])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) add_sql_query_params(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_2 := iife_temp_2.get_db_table_name()
	mut var_order_tax_lookup_table := iife_result_2
	this.add_time_period_sql_params(var_query_args.clone(), var_order_tax_lookup_table.clone())
	this.get_limit_sql_params(var_query_args.clone())
	this.add_order_by_sql_params(var_query_args.clone())
	mut var_order_status_filter := this.get_status_subquery(var_query_args.clone())
	this.add_from_sql_params(var_query_args.clone(), var_order_status_filter.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
		rt.new_string('AND itemmeta_rate_id.meta_value = ${var_order_tax_lookup_table.to_string()}.tax_rate_id')])
	if var_query_args.array_isset(rt.new_string('taxes'))
		&& !(!rt.is_true(var_query_args.array_get(rt.new_string('taxes')))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
		mut iife_result_3 := iife_temp_3.get_filtered_ids(var_query_args.clone(),
			rt.new_string('taxes'))
		mut var_allowed_taxes := iife_result_3
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ${var_order_tax_lookup_table.to_string()}.tax_rate_id IN (${var_allowed_taxes.to_string()})')])
	}
	if rt.is_true(var_order_status_filter) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ( ${var_order_status_filter.to_string()} )')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('orderby', 'tax_rate_id')
	var_defaults.array_set('taxes', rt.new_array())
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	this.initialize_queries()
	mut var_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.new_array() },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'pages', val: 0 },
		rt.ArrayItem{ key: 'page_no', val: 0 },
	]))
	this.add_sql_query_params(var_query_args.clone())
	mut var_params := this.get_limit_params(var_query_args.clone())
	if var_query_args.array_isset(rt.new_string('taxes'))
		&& var_query_args.array_get(rt.new_string('taxes')).is_array()
		&& !(!rt.is_true(var_query_args.array_get(rt.new_string('taxes')))) {
		mut var_total_results :=
			rt.new_int(var_query_args.array_get(rt.new_string('taxes')).array_count())
		mut var_total_pages := rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_results, var_params.array_get(rt.new_string('per_page'))),
		])).to_i64())
	} else {
		mut var_db_records_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM ( '), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})),
				rt.new_string(' ) AS tt')),
		])).to_i64())
		var_total_results = var_db_records_count.clone()
		var_total_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(var_db_records_count, var_params.array_get(rt.new_string('per_page'))),
		])).to_i64())
		if rt.is_true(rt.less(var_query_args.array_get(rt.new_string('page')), rt.new_int(1)))
			|| rt.is_true(rt.greater(var_query_args.array_get(rt.new_string('page')), var_total_pages)) {
			return var_data.clone()
		}
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		this.selected_columns(var_query_args.clone())])
	if rt.is_true(rt.call_function('in_array', [var_query_args.array_get(rt.new_string('orderby')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'total_tax' },
			rt.ArrayItem{ key: none, val: 'order_tax' }, rt.ArrayItem{
				key: none
				val: 'shipping_tax'
			}, rt.ArrayItem{ key: none, val: 'orders_count' }]),
		rt.new_bool(true)]))
	{
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
			rt.new_string((this.get_sql_clause(rt.new_string('order_by'))).str() + ', tax_rate_id')])
	} else {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
			this.get_sql_clause(rt.new_string('order_by'))])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'),
		this.get_sql_clause(rt.new_string('limit'))])
	mut var_taxes_query := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})
	mut var_tax_data := rt.call_method(var_wpdb, 'get_results', [
		var_taxes_query.clone(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_tax_data)) {
		return var_data.clone()
	}
	var_tax_data = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'cast_numbers' },
		]),
		var_tax_data.clone(),
	])
	var_data = rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_tax_data },
		rt.ArrayItem{ key: 'total', val: var_total_results },
		rt.ArrayItem{ key: 'pages', val: var_total_pages },
		rt.ArrayItem{
			key: 'page_no'
			val: rt.new_int((var_query_args.array_get(rt.new_string('page'))).to_i64())
		},
	]))
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('tax_code'), var_order_by)) {
		return rt.concat(rt.get_property(var_wpdb, 'prefix'),
			rt.new_string('woocommerce_order_items.order_item_name'))
	} else if rt.is_true(rt.identical(rt.new_string('rate'), var_order_by)) {
		return 'tax_rate'
	}
	return var_order_by.str()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_order_taxes(var_order_id rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return -1
	}
	mut var_tax_items := rt.call_method(var_order, 'get_items', [
		Class_Automattic_WooCommerce_Enums_OrderItemType.tax(),
	])
	mut var_num_updated := rt.new_int(0)
	mut iter_1 := var_tax_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tax_item := item_1.val
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
		mut iife_result_4 := iife_temp_4.get_db_table_name()
		mut var_result := rt.call_method(var_wpdb, 'replace', [iife_result_4,
			rt.create_array([
				rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id',
					[]rt.PhpVal{}) },
				rt.ArrayItem{
					key: 'date_created'
					val: rt.call_method(rt.call_method(var_order, 'get_date_created', [
						rt.new_string('edit')]), 'date', [
						rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
							'sql_datetime_format'),
					])
				},
				rt.ArrayItem{ key: 'tax_rate_id', val: rt.call_method(var_tax_item, 'get_rate_id',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'shipping_tax', val: rt.call_method(var_tax_item,
					'get_shipping_tax_total', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'order_tax', val: rt.call_method(var_tax_item, 'get_tax_total',
					[]rt.PhpVal{}) },
				rt.ArrayItem{
					key: 'total_tax'
					val:
						rt.new_float((rt.call_method(var_tax_item, 'get_tax_total', []rt.PhpVal{})).to_f64()) +
						rt.new_float((rt.call_method(var_tax_item, 'get_shipping_tax_total', []rt.PhpVal{})).to_f64())
				},
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%f' },
				rt.ArrayItem{ key: none, val: '%f' },
				rt.ArrayItem{ key: none, val: '%f' },
			])])
		rt.call_function('do_action', [rt.new_string('woocommerce_analytics_update_tax'),
			rt.call_method(var_tax_item, 'get_rate_id', []rt.PhpVal{}),
			rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		var_num_updated = rt.add(var_num_updated, if 2 == var_result.clone().to_i64() {
			1
		} else {
			var_result.clone().to_i64()
		})
	}
	return (rt.identical(rt.new_int(var_tax_items.clone().array_count()), var_num_updated)).to_i64()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_on_order_delete(var_order_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_5 := iife_temp_5.get_db_table_name()
	rt.call_method(var_wpdb, 'delete', [iife_result_5,
		rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_analytics_delete_tax'),
		rt.new_int(0), var_order_id.clone()])
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
	mut iife_result_6 := iife_temp_6.invalidate()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) initialize_queries() {
	mut var_wpdb := rt.new_null()
	this.clear_all_clauses()
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery(
		(this.context).str() + '_subquery'))
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_7 := iife_temp_7.get_db_table_name()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string(iife_result_7.str() + '.tax_rate_id')])
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_8 := iife_temp_8.get_db_table_name()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'), iife_result_8])
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_9 := iife_temp_9.get_db_table_name()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'),
		rt.new_string(iife_result_9.str() + '.tax_rate_id')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'),
		rt.concat(rt.concat(rt.new_string(', '), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('woocommerce_order_items.order_item_name, itemmeta_rate_percent.meta_value'))])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_taxes_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		cache_key:     rt.new_string('taxes')
		column_types:  rt.new_array()
		context:       rt.new_string('taxes')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.init()
			return rt.new_null()
		}
		'add_from_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_from_sql_params(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_sql_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_sql_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'normalize_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.normalize_order_by(dispatch_arg_0))
		}
		'sync_order_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_order_taxes(dispatch_arg_0))
		}
		'sync_on_order_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore.sync_on_order_delete(dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache_key' {
			this.cache_key = val
			return true
		}
		'column_types' {
			this.column_types = val
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
