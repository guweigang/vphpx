import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_order_product_lookup')
		cache_key rt.PhpVal = rt.new_string('products')
		column_types rt.PhpVal = rt.new_array()
		extended_attributes rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('products')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) assign_report_columns()  {
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}; return temp.get_db_table_name() }()
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'product_id', val: 'product_id' }, rt.ArrayItem{ key: 'items_sold', val: 'SUM(product_qty) as items_sold' }, rt.ArrayItem{ key: 'net_revenue', val: 'SUM(product_net_revenue) AS net_revenue' }, rt.ArrayItem{ key: 'orders_count', val: "COUNT( DISTINCT ( CASE WHEN product_gross_revenue >= 0 THEN ${var_table_name.to_string()}.order_id END ) ) as orders_count" }]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_analytics_delete_order_stats'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'sync_on_order_delete' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_partially_refunded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_partial_refund_type_meta' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_fully_refunded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_full_refund_type_meta' }]), rt.new_int(10), rt.new_int(2)])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_partial_refund_type_meta(var_order_id rt.PhpVal, var_refund_id rt.PhpVal)  {
	Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(var_refund_id.dup(), rt.new_string('partial'))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_full_refund_type_meta(var_order_id rt.PhpVal, var_refund_id rt.PhpVal)  {
	Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(var_refund_id.dup(), rt.new_string('full'))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(var_refund_id rt.PhpVal, var_type rt.PhpVal)  {
	mut var_type_mutated := var_type
	mut var_order := rt.call_function('wc_get_order', [var_refund_id.dup()])
	rt.call_method(var_order, 'update_meta_data', [rt.new_string('_refund_type'), var_type_mutated.dup()])
	rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) add_from_sql_params(var_query_args rt.PhpVal, var_arg_name rt.PhpVal, var_id_cell rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	// unsupported statement: Stmt_Global
	mut var_type := rt.new_string(rt.new_string('join'))
	mut switch_val_1 := var_query_args_mutated.array_get('orderby')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_name'))) {
		mut var_join := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' JOIN '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS _products ON ')), var_id_cell), rt.new_string(' = _products.ID')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sku'))) {
		var_join = rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta ON ')), var_id_cell), rt.new_string(' = postmeta.post_id AND postmeta.meta_key = \'_sku\'')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variations'))) {
		var_type = rt.new_string(rt.new_string('left_join'))
		var_join = rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN ( SELECT post_parent, COUNT(*) AS variations FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'product_variation\' GROUP BY post_parent ) AS _variations ON ')), var_id_cell), rt.new_string(' = _variations.post_parent')))
	} else {
		var_join = rt.new_string(rt.new_string(''))
	}
	if rt.is_true(var_join) {
		if rt.is_true(rt.identical(rt.new_string('inner'), var_arg_name)) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [var_type.dup(), var_join.dup()])
		} else {
			this.add_sql_clause(var_type.dup(), var_join.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) add_sql_query_params(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	// unsupported statement: Stmt_Global
	mut var_order_product_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}; return temp.get_db_table_name() }()
	this.add_time_period_sql_params(var_query_args_mutated.dup(), var_order_product_lookup_table.dup())
	this.get_limit_sql_params(var_query_args_mutated.dup())
	this.add_order_by_sql_params(var_query_args_mutated.dup())
	mut var_included_products := this.get_included_products(var_query_args_mutated.dup())
	if rt.is_true(var_included_products) {
		this.add_from_sql_params(var_query_args_mutated.dup(), rt.new_string('outer'), rt.new_string('default_results.product_id'))
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ${var_order_product_lookup_table.to_string()}.product_id IN (${var_included_products.to_string()})")])
	} else {
		this.add_from_sql_params(var_query_args_mutated.dup(), rt.new_string('inner'), rt.new_string("${var_order_product_lookup_table.to_string()}.product_id"))
	}
	mut var_included_variations := this.get_included_variations(var_query_args_mutated.dup())
	if rt.is_true(var_included_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ${var_order_product_lookup_table.to_string()}.variation_id IN (${var_included_variations.to_string()})")])
	}
	mut var_order_status_filter := this.get_status_subquery(var_query_args_mutated.dup())
	if rt.is_true(var_order_status_filter) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats ON ')), var_order_product_lookup_table), rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats.order_id'))])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ( ${var_order_status_filter.to_string()} )")])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		return (fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}; return temp.get_db_table_name() }()).str() + '.date_created'
	}
	if rt.is_true(rt.identical(rt.new_string('product_name'), var_order_by)) {
		return 'post_title'
	}
	if rt.is_true(rt.identical(rt.new_string('sku'), var_order_by)) {
		return 'meta_value'
	}
	return (var_order_by).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) include_extended_info(var_products_data rt.PhpVal, var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	// unsupported statement: Stmt_Global
	mut var_product_names := rt.new_array()
	{
		mut iter_1 := var_products_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_data := item_1.val
			mut var_key := item_1.key
			mut var_extended_info := create_automattic_woocommerce_admin_api_reports_products_arrayobject()
			if rt.is_true(var_query_args_mutated.array_get('extended_info')) {
				mut var_product_id := var_product_data.array_get('product_id')
				mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
					if !(var_product_names.array_isset(var_product_id)) {
						var_product_names.array_set(var_product_id, rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT i.order_item_name\n\t\t\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_product_lookup l\n\t\t\t\t\t\t\t\tJOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items i ON i.order_item_id = l.order_item_id\n\t\t\t\t\t\t\t\tWHERE l.product_id = %d\n\t\t\t\t\t\t\t\tORDER BY l.order_item_id DESC\n\t\t\t\t\t\t\t\tLIMIT 1')), var_product_id.dup()])]))
					}
					var_products_data.array_get_mut(var_key).array_get_mut('extended_info').array_set('name', if rt.is_true(var_product_names.array_get(var_product_id)) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s (Deleted)'), rt.new_string('woocommerce')]), var_product_names.array_get(var_product_id)]) } else { rt.call_function('__', [rt.new_string('(Deleted)'), rt.new_string('woocommerce')]) })
					continue
				}
				mut var_extended_attributes := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_reports_products_extended_attributes'), this.extended_attributes, var_product_data.dup()])
				{
					mut iter_2 := var_extended_attributes.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_extended_attribute := item_2.val
						if rt.is_true(rt.identical(rt.new_string('variations'), var_extended_attribute)) {
							if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()]))))) {
								continue
							}
							mut var_function := rt.new_string(rt.new_string('get_children'))
						} else {
							var_function = rt.new_string('get_' + (var_extended_attribute).str())
						}
						if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product }, rt.ArrayItem{ key: none, val: var_function }])])) {
							mut var_value := rt.call_method(var_product, var_function, []rt.PhpVal{})
							var_extended_info.array_set(var_extended_attribute, var_value.dup())
						}
					}
				}
				if rt.is_true(rt.identical(rt.new_string(''), var_extended_info.array_get('low_stock_amount'))) {
					var_extended_info.array_set('low_stock_amount', rt.call_function('absint', [rt.call_function('max', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_low_stock_amount')]), rt.new_int(1)])]))
				}
				var_extended_info = this.cast_numbers(var_extended_info.dup())
			}
			var_products_data.array_get_mut(var_key).array_set('extended_info', var_extended_info.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) get_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_data := this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_data(var_query_args_mutated.dup())
	mut var_defaults := this.get_default_query_vars()
	var_query_args_mutated = rt.call_function('wp_parse_args', [var_query_args_mutated.dup(), var_defaults.dup()])
	this.include_extended_info(rt.get_property(var_data, 'data'), var_query_args_mutated.dup())
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('category_includes', rt.new_array())
	var_defaults.array_set('product_includes', rt.new_array())
	var_defaults.array_set('extended_info', false)
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}; return temp.get_db_table_name() }()
	this.initialize_queries()
	mut var_data := // unsupported expression: Expr_Cast_Object
	mut var_selections := this.selected_columns(var_query_args_mutated.dup())
	mut var_included_products := this.get_included_products_array(var_query_args_mutated.dup())
	mut var_params := this.get_limit_params(var_query_args_mutated.dup())
	this.add_sql_query_params(var_query_args_mutated.dup())
	if var_included_products.dup().array_count() > 0 {
		mut var_filtered_products := rt.call_function('array_diff', [var_included_products.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '-1' }])])
		mut var_total_results := rt.new_int(rt.new_int(var_filtered_products.dup().array_count()))
		mut var_total_pages := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.identical(rt.new_string('date'), var_query_args_mutated.array_get('orderby'))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		mut var_fields := this.get_fields(var_query_args_mutated.dup())
		mut var_join_selections := this.format_join_selections(var_fields.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'product_id' }]))
		mut var_ids_table := this.get_ids_table(var_included_products.dup(), rt.new_string('product_id'))
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), var_selections.dup()])
		this.add_sql_clause(rt.new_string('select'), var_join_selections.dup())
		this.add_sql_clause(rt.new_string('from'), rt.new_string('('))
		this.add_sql_clause(rt.new_string('from'), rt.call_method(, 'get_query_statement', []rt.PhpVal{}))
		this.add_sql_clause(rt.new_string(), rt.new_string())
		
	} else {
	}
	
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.sync_order_products(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.sync_on_order_delete(var_order_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) initialize_queries()  {
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_products_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_order_product_lookup')
		cache_key: rt.new_string('products')
		column_types: rt.new_array()
		extended_attributes: rt.new_array()
		context: rt.new_string('products')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_products_arrayobject() &Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_ArrayObject{
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
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_partial_refund_type_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_full_refund_type_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_full_refund_type_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_refund_type_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.add_refund_type_meta(dispatch_arg_0, dispatch_arg_1)
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
			return Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore.sync_order_products(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'extended_attributes' { return this.extended_attributes }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'table_name' { this.table_name = val; return true }
		'cache_key' { this.cache_key = val; return true }
		'column_types' { this.column_types = val; return true }
		'extended_attributes' { this.extended_attributes = val; return true }
		'context' { this.context = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_products_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
