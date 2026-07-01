import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_order_product_lookup')
		cache_key rt.PhpVal = rt.new_string('categories')
		order_by rt.PhpVal = rt.new_string('')
		order rt.PhpVal = rt.new_string('')
		column_types rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('categories')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) assign_report_columns()  {
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore{}; return temp.get_db_table_name() }()
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'items_sold', val: 'SUM(product_qty) as items_sold' }, rt.ArrayItem{ key: 'net_revenue', val: 'SUM(product_net_revenue) AS net_revenue' }, rt.ArrayItem{ key: 'orders_count', val: "COUNT(DISTINCT ${var_table_name.to_string()}.order_id) as orders_count" }, rt.ArrayItem{ key: 'products_count', val: "COUNT(DISTINCT ${var_table_name.to_string()}.product_id) as products_count" }]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) add_sql_query_params(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_product_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore{}; return temp.get_db_table_name() }()
	this.add_time_period_sql_params(var_query_args.dup(), var_order_product_lookup_table.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('left_join'), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' ON ')), var_order_product_lookup_table), rt.new_string('.product_id = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.object_id'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('left_join'), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string('.term_taxonomy_id = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.term_taxonomy_id'))])
	mut var_included_categories := this.get_included_categories(var_query_args.dup())
	if rt.is_true(var_included_categories) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('AND '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.term_taxonomy_id IN (')), var_included_categories), rt.new_string(')'))])
		this.add_order_by_params(var_query_args.dup(), rt.new_string('outer'), rt.new_string('default_results.category_id'))
	} else {
		this.add_order_by_params(var_query_args.dup(), rt.new_string('inner'), rt.new_string(rt.concat(rt.get_property(var_wpdb, 'term_relationships'), rt.new_string('.term_taxonomy_id'))))
	}
	this.add_order_status_clause(var_query_args.dup(), var_order_product_lookup_table.dup(), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.concat(rt.concat(rt.new_string('AND '), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string('.taxonomy = \'product_cat\''))])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) add_order_by_params(var_query_args rt.PhpVal, var_from_arg rt.PhpVal, var_id_cell rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_id_cell_segments := rt.call_function('explode', [rt.new_string('.'), rt.call_function('str_replace', [rt.new_string('`'), rt.new_string(''), var_id_cell.dup()])])
	mut var_id_cell_identifier := rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`.`'), var_id_cell_segments.dup()])).str() + '`')
	mut var_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore{}; return temp.get_db_table_name() }()
	mut var_order_by_clause := this.add_order_by_clause(var_query_args.dup(), rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', []string{}, this))
	this.add_orderby_order_clause(var_query_args.dup(), rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', []string{}, this))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_join := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS _terms ON ')), var_id_cell_identifier), rt.new_string(' = _terms.term_id')))
		if rt.is_true(rt.identical(rt.new_string('inner'), var_from_arg)) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('left_join'), var_join.dup()])
		} else {
			this.add_sql_clause(rt.new_string('join'), var_join.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		return 'time_interval'
	}
	if rt.is_true(rt.identical(rt.new_string('category'), var_order_by)) {
		return '_terms.name'
	}
	return (var_order_by).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) get_included_categories_array(var_query_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_query_args.array_isset(rt.new_string('category_includes')) && rt.is_true(rt.new_bool(var_query_args.array_get('category_includes').is_array())))) && var_query_args.array_get('category_includes').array_count() > 0)) {
		return var_query_args.array_get('category_includes')
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) page_records(var_data rt.PhpVal, var_page_no rt.PhpVal, var_items_per_page rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_offset := rt.mul(rt.sub(var_page_no, rt.new_int(1)), var_items_per_page)
	return rt.call_function('array_slice', [var_data_mutated.dup(), var_offset.dup(), var_items_per_page.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) include_extended_info(var_categories_data rt.PhpVal, var_query_args rt.PhpVal)  {
	mut var_categories_data_mutated := var_categories_data
	{
		mut iter_1 := var_categories_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category_data := item_1.val
			mut var_key := item_1.key
			mut var_extended_info := create_automattic_woocommerce_admin_api_reports_categories_arrayobject()
			if rt.is_true(var_query_args.array_get('extended_info')) {
				var_extended_info.array_set('name', rt.call_function('get_the_category_by_ID', [var_category_data.array_get('category_id')]))
			}
			var_categories_data_mutated.array_get_mut(var_key).array_set('extended_info', var_extended_info.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('category_includes', rt.new_array())
	var_defaults.array_set('extended_info', false)
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore{}; return temp.get_db_table_name() }()
	this.initialize_queries()
	mut var_data := // unsupported expression: Expr_Cast_Object
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), this.selected_columns(var_query_args.dup())])
	mut var_included_categories := this.get_included_categories_array(var_query_args.dup())
	this.add_sql_query_params(var_query_args.dup())
	if var_included_categories.dup().array_count() > 0 {
		mut var_fields := this.get_fields(var_query_args.dup())
		mut var_ids_table := this.get_ids_table(var_included_categories.dup(), rt.new_string('category_id'))
		this.add_sql_clause(rt.new_string('select'), this.format_join_selections(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'category_id' }]), var_fields.dup()]), rt.create_array([rt.ArrayItem{ key: none, val: 'category_id' }])))
		this.add_sql_clause(rt.new_string('from'), rt.new_string('('))
		this.add_sql_clause(rt.new_string('from'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}))
		this.add_sql_clause(rt.new_string('from'), rt.new_string(") AS ${var_table_name.to_string()}"))
		this.add_sql_clause(rt.new_string('right_join'), rt.new_string("RIGHT JOIN ( ${var_ids_table.to_string()} ) AS default_results\n\t\t\t\tON default_results.category_id = ${var_table_name.to_string()}.category_id"))
		mut var_categories_query := this.get_query_statement()
	} else {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'), this.get_sql_clause(rt.new_string('order_by'))])
		var_categories_query = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})
	}
	mut var_categories_data := rt.call_method(var_wpdb, 'get_results', [var_categories_query.dup(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_categories_data)) {
		return create_automattic_woocommerce_admin_api_reports_categories_wp_error(rt.new_string('woocommerce_analytics_categories_result_failed'), rt.call_function('__', [rt.new_string('Sorry, fetching revenue data failed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_record_count := rt.new_int(rt.new_int(var_categories_data.dup().array_count()))
	mut var_total_pages := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_query_args.array_get('page'), rt.new_int(1))) || rt.is_true(rt.greater(var_query_args.array_get('page'), var_total_pages)))) {
		return var_data.dup()
	}
	var_categories_data = this.page_records(var_categories_data.dup(), var_query_args.array_get('page'), var_query_args.array_get('per_page'))
	this.include_extended_info(var_categories_data.dup(), var_query_args.dup())
	var_categories_data = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this) }, rt.ArrayItem{ key: none, val: 'cast_numbers' }]), var_categories_data.dup()])
	var_data = // unsupported expression: Expr_Cast_Object
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) initialize_queries()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery((this.context).str() + '_subquery'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), rt.concat(rt.get_property(var_wpdb, 'term_taxonomy'), rt.new_string('.term_id as category_id,'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore{}; return temp.get_db_table_name() }()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'), rt.concat(rt.get_property(var_wpdb, 'term_taxonomy'), rt.new_string('.term_id'))])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Categories_ArrayObject {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Categories_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_categories_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_order_product_lookup')
		cache_key: rt.new_string('categories')
		order_by: rt.new_string('')
		order: rt.new_string('')
		column_types: rt.new_array()
		context: rt.new_string('categories')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_categories_arrayobject() &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_ArrayObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_categories_wp_error() &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_sqlquery() &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'add_sql_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_sql_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'add_order_by_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_order_by_params(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'normalize_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.normalize_order_by(dispatch_arg_0))
		}
		'get_included_categories_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_categories_array(dispatch_arg_0)
		}
		'page_records' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.page_records(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'include_extended_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.include_extended_info(dispatch_arg_0, dispatch_arg_1)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'order_by' { return this.order_by }
		'order' { return this.order }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'table_name' { this.table_name = val; return true }
		'cache_key' { this.cache_key = val; return true }
		'order_by' { this.order_by = val; return true }
		'order' { this.order = val; return true }
		'column_types' { this.column_types = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_ArrayObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_ArrayObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_ArrayObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Categories_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Categories_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_categories_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
