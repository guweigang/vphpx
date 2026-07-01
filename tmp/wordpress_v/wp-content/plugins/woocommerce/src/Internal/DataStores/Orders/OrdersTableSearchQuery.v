import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.products_join_alias() string {
	return 'fts_items'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.customers_join_alias() string {
	return 'fts_addresses'
}
struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery {
	rt.PhpObjectBase
pub mut:
		query rt.PhpVal = rt.new_null()
		search_term rt.PhpVal = rt.new_null()
		search_filters rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) construct(mut var_query Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery)  {
	this.query = var_query.dup()
	this.search_term = var_query.get(rt.new_string('s'))
	this.search_filters = this.sanitize_search_filters((if !(var_query.get(rt.new_string('search_filter'))).is_null() { var_query.get(rt.new_string('search_filter')) } else { rt.new_string('') }).str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) sanitize_search_filters(search_filter string) rt.PhpVal {
	mut var_core_filters := rt.create_array([rt.ArrayItem{ key: none, val: 'order_id' }, rt.ArrayItem{ key: none, val: 'transaction_id' }, rt.ArrayItem{ key: none, val: 'customer_email' }, rt.ArrayItem{ key: none, val: 'customers' }, rt.ArrayItem{ key: none, val: 'products' }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('all'), rt.new_string(search_filter))) || rt.is_true(rt.identical(rt.new_string(''), rt.new_string(search_filter))))) {
		return var_core_filters.dup()
	} else {
		return rt.create_array([rt.ArrayItem{ key: none, val: search_filter }])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) get_sql_clauses() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'join', val: rt.create_array([rt.ArrayItem{ key: none, val: this.generate_join() }]) }, rt.ArrayItem{ key: 'where', val: rt.create_array([rt.ArrayItem{ key: none, val: this.generate_where() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) generate_join() string {
	mut var_join := rt.new_array()
	{
		mut iter_1 := this.search_filters.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_search_filter := item_1.val
			var_join.array_push(this.generate_join_for_search_filter(var_search_filter.dup()))
		}
	}
	return (rt.call_function('implode', [rt.new_string(' '), var_join.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) generate_join_for_search_filter(var_search_filter rt.PhpVal) string {
	mut var_join := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.identical(rt.new_string('products'), var_search_filter)) {
		var_join = rt.new_string(this.maybe_get_join_for_products())
	}
	if rt.is_true(rt.identical(rt.new_string('customers'), var_search_filter)) {
		var_join = rt.new_string(this.maybe_get_join_for_customers())
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_hpos_generate_join_for_search_filter'), var_join.dup(), this.search_term, var_search_filter.dup(), this.query])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) maybe_get_join_for_products() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_db_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()])
	mut var_items_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('items')])
	mut var_orders_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('orders')])
	mut var_fts_enabled := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option()]), rt.new_string('yes'))) && rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_order_item_index_created_option()]), rt.new_string('yes')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fts_enabled)))) {
		return ''
	}
	mut var_search_pattern := rt.call_method(var_wpdb, 'esc_like', [rt.call_method(var_db_util, 'sanitise_boolean_fts_search_term', [this.search_term])])
	return (rt.call_method(var_wpdb, 'prepare', ["LEFT JOIN (\n\t\t\t\tSELECT DISTINCT order_id\n\t\t\t\tFROM ${var_items_table.to_string()}\n\t\t\t\tWHERE MATCH ( order_item_name ) AGAINST ( %s IN BOOLEAN MODE )\n\t\t\t) AS " + (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.products_join_alias()).str() + ' ON ' + (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.products_join_alias()).str() + ".order_id = ${var_orders_table.to_string()}.id", var_search_pattern.dup()])).str()
	// unsupported statement: Stmt_Nop
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) maybe_get_join_for_customers() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_db_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()])
	mut var_address_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('addresses')])
	mut var_orders_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('orders')])
	mut var_fts_enabled := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option()]), rt.new_string('yes'))) && rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option()]), rt.new_string('yes')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fts_enabled)))) {
		return ''
	}
	mut var_search_pattern := rt.call_method(var_wpdb, 'esc_like', [rt.call_method(var_db_util, 'sanitise_boolean_fts_search_term', [this.search_term])])
	mut var_maybe_phone_field := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('get_option', [rt.new_string('woocommerce_db_version')]), rt.new_string('9.4.0'), rt.new_string('>=')])) {
		var_maybe_phone_field = rt.new_string(rt.new_string(', phone'))
	}
	return (rt.call_method(var_wpdb, 'prepare', ["LEFT JOIN (\n\t\t\t\tSELECT DISTINCT order_id\n\t\t\t\tFROM ${var_address_table.to_string()}\n\t\t\t\tWHERE MATCH (\n\t\t\t\t\tfirst_name, last_name, company,\n\t\t\t\t\taddress_1,  address_2, city,  state,\n\t\t\t\t\tpostcode,   country,   email  ${var_maybe_phone_field.to_string()}\n\t\t\t\t) AGAINST ( %s IN BOOLEAN MODE )\n\t\t\t) AS " + (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.customers_join_alias()).str() + ' ON ' + (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.customers_join_alias()).str() + ".order_id = ${var_orders_table.to_string()}.id", var_search_pattern.dup()])).str()
	// unsupported statement: Stmt_Nop
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) generate_where() string {
	mut var_where := rt.new_array()
	mut var_possible_order_id := // unsupported expression: Expr_Cast_String
	mut var_order_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('orders')])
	if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_String, var_possible_order_id)) {
		var_where.array_push("`${var_order_table.to_string()}`.id = ${var_possible_order_id.to_string()}")
	}
	{
		mut iter_1 := this.search_filters.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_search_filter := item_1.val
			mut var_search_where := rt.new_string(rt.new_string(this.generate_where_for_search_filter((var_search_filter).str()).trim_space()))
			if var_search_where.dup().to_string().len > 0 {
				var_where.array_push(var_search_where.dup())
			}
		}
	}
	mut var_where_statement := rt.call_function('implode', [rt.new_string(' OR '), var_where.dup()])
	return if var_where_statement.dup().to_string().len > 0 { " ( ${var_where_statement.to_string()} ) " } else { '' }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) generate_where_for_search_filter(search_filter string) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('orders')])
	if rt.is_true(rt.identical(rt.new_string('customer_email'), rt.new_string(search_filter))) {
		return (rt.call_method(var_wpdb, 'prepare', [rt.new_string("`${var_order_table.to_string()}`.billing_email LIKE %s"), (rt.call_method(var_wpdb, 'esc_like', [this.search_term])).str() + '%'])).str()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('order_id'), rt.new_string(search_filter))) && rt.is_true(rt.new_bool(this.search_term.is_long() || this.search_term.is_double())))) {
		return (rt.call_method(var_wpdb, 'prepare', [rt.new_string("`${var_order_table.to_string()}`.id = %d"), rt.call_function('absint', [this.search_term])])).str()
	}
	if rt.is_true(rt.identical(rt.new_string('transaction_id'), rt.new_string(search_filter))) {
		return (rt.call_method(var_wpdb, 'prepare', [rt.new_string("`${var_order_table.to_string()}`.transaction_id LIKE %s"), '%' + (rt.call_method(var_wpdb, 'esc_like', [this.search_term])).str() + '%'])).str()
	}
	if rt.is_true(rt.identical(rt.new_string('products'), rt.new_string(search_filter))) {
		return this.get_where_for_products()
	}
	if rt.is_true(rt.identical(rt.new_string('customers'), rt.new_string(search_filter))) {
		return this.get_where_for_customers()
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_hpos_generate_where_for_search_filter'), rt.new_string(''), this.search_term, rt.new_string(search_filter), this.query])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) get_where_for_products() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_db_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()])
	mut var_items_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('items')])
	mut var_orders_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('orders')])
	mut var_fts_enabled := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option()]), rt.new_string('yes'))) && rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_order_item_index_created_option()]), rt.new_string('yes')))))
	if rt.is_true(var_fts_enabled) {
		return (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.products_join_alias()).str() + '.order_id IS NOT NULL'
	}
	return (rt.call_method(var_wpdb, 'prepare', [rt.new_string("\n${var_orders_table.to_string()}.id in (\n\tSELECT order_id FROM ${var_items_table.to_string()} search_query_items WHERE\n\tsearch_query_items.order_item_name LIKE %s\n)\n"), '%' + (rt.call_method(var_wpdb, 'esc_like', [this.search_term])).str() + '%'])).str()
	// unsupported statement: Stmt_Nop
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) get_where_for_customers() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('orders')])
	mut var_address_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('addresses')])
	mut var_db_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()])
	mut var_fts_enabled := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option()]), rt.new_string('yes'))) && rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option()]), rt.new_string('yes')))))
	if rt.is_true(var_fts_enabled) {
		return (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery.customers_join_alias()).str() + '.order_id IS NOT NULL'
	}
	mut var_meta_sub_query := rt.new_string(this.generate_where_for_meta_table())
	return "`${var_order_table.to_string()}`.id IN ( ${var_meta_sub_query.to_string()} ) "
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) generate_where_for_meta_table() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_meta_table := rt.call_method(this.query, 'get_table_name', [rt.new_string('meta')])
	mut var_meta_fields := rt.new_string(this.get_meta_fields_to_be_searched())
	if rt.is_true(rt.identical(rt.new_string(''), var_meta_fields)) {
		return '-1'
	}
	return (rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nSELECT search_query_meta.order_id\nFROM ${var_meta_table.to_string()} as search_query_meta\nWHERE search_query_meta.meta_key IN ( ${var_meta_fields.to_string()} )\nAND search_query_meta.meta_value LIKE %s\nGROUP BY search_query_meta.order_id\n"), '%' + (rt.call_method(var_wpdb, 'esc_like', [this.search_term])).str() + '%'])).str()
	// unsupported statement: Stmt_Nop
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) get_meta_fields_to_be_searched() string {
	mut var_meta_fields_to_search := rt.create_array([rt.ArrayItem{ key: none, val: '_billing_address_index' }, rt.ArrayItem{ key: none, val: '_shipping_address_index' }])
	mut var_meta_keys := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_table_search_query_meta_keys'), var_meta_fields_to_search.dup()])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_meta_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return '\'' + (rt.call_function('esc_sql', [rt.call_function('wc_clean', [var_meta_key.dup()])])).str() + '\''
	}
	mut var_meta_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return '\'' + (rt.call_function('esc_sql', [rt.call_function('wc_clean', [var_meta_key.dup()])])).str() + '\''
	}
	var_meta_keys = rt.cast_array(rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_meta_keys.dup()]))
	return (rt.call_function('implode', [rt.new_string(','), var_meta_keys.dup()])).str()
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablesearchquery(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery{
		PhpObjectBase: rt.PhpObjectBase{}
		query: rt.new_null()
		search_term: rt.new_null()
		search_filters: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize_search_filters' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.sanitize_search_filters(dispatch_arg_0)
		}
		'get_sql_clauses' {
			return this.get_sql_clauses()
		}
		'generate_join' {
			return rt.new_string(this.generate_join())
		}
		'generate_join_for_search_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.generate_join_for_search_filter(dispatch_arg_0))
		}
		'maybe_get_join_for_products' {
			return rt.new_string(this.maybe_get_join_for_products())
		}
		'maybe_get_join_for_customers' {
			return rt.new_string(this.maybe_get_join_for_customers())
		}
		'generate_where' {
			return rt.new_string(this.generate_where())
		}
		'generate_where_for_search_filter' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.generate_where_for_search_filter(dispatch_arg_0))
		}
		'get_where_for_products' {
			return rt.new_string(this.get_where_for_products())
		}
		'get_where_for_customers' {
			return rt.new_string(this.get_where_for_customers())
		}
		'generate_where_for_meta_table' {
			return rt.new_string(this.generate_where_for_meta_table())
		}
		'get_meta_fields_to_be_searched' {
			return rt.new_string(this.get_meta_fields_to_be_searched())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query' { return this.query }
		'search_term' { return this.search_term }
		'search_filters' { return this.search_filters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query' { this.query = val; return true }
		'search_term' { this.search_term = val; return true }
		'search_filters' { this.search_filters = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_datastores_orders_orderstablesearchquery_php() {
}
