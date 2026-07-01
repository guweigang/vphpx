import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_order_coupon_lookup')
		cache_key rt.PhpVal = rt.new_string('coupons')
		column_types rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('coupons')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) assign_report_columns()  {
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}; return temp.get_db_table_name() }()
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'coupon_id', val: 'coupon_id' }, rt.ArrayItem{ key: 'amount', val: 'SUM(discount_amount) as amount' }, rt.ArrayItem{ key: 'orders_count', val: "COUNT(DISTINCT ${var_table_name.to_string()}.order_id) as orders_count" }]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_analytics_delete_order_stats'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'sync_on_order_delete' }]), rt.new_int(5)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) get_included_coupons_array(var_query_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_query_args.array_isset(rt.new_string('coupons')) && rt.is_true(rt.new_bool(var_query_args.array_get('coupons').is_array())))) && var_query_args.array_get('coupons').array_count() > 0)) {
		return var_query_args.array_get('coupons')
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) add_sql_query_params(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_coupon_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}; return temp.get_db_table_name() }()
	this.add_time_period_sql_params(var_query_args.dup(), var_order_coupon_lookup_table.dup())
	this.get_limit_sql_params(var_query_args.dup())
	mut var_included_coupons := this.get_included_coupons(var_query_args.dup(), rt.new_string('coupons'))
	if rt.is_true(var_included_coupons) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ${var_order_coupon_lookup_table.to_string()}.coupon_id IN (${var_included_coupons.to_string()})")])
		this.add_order_by_params(var_query_args.dup(), rt.new_string('outer'), rt.new_string('default_results.coupon_id'))
	} else {
		this.add_order_by_params(var_query_args.dup(), rt.new_string('inner'), rt.new_string("${var_order_coupon_lookup_table.to_string()}.coupon_id"))
	}
	this.add_order_status_clause(var_query_args.dup(), var_order_coupon_lookup_table.dup(), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) add_order_by_params(var_query_args rt.PhpVal, var_from_arg rt.PhpVal, var_id_cell rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_id_cell_segments := rt.call_function('explode', [rt.new_string('.'), rt.call_function('str_replace', [rt.new_string('`'), rt.new_string(''), var_id_cell.dup()])])
	mut var_id_cell_identifier := rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`.`'), var_id_cell_segments.dup()])).str() + '`')
	mut var_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}; return temp.get_db_table_name() }()
	mut var_order_by_clause := this.add_order_by_clause(var_query_args.dup(), rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', []string{}, this))
	mut var_join := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS _coupons ON ')), var_id_cell_identifier), rt.new_string(' = _coupons.ID')))
	this.add_orderby_order_clause(var_query_args.dup(), rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', []string{}, this))
	if rt.is_true(rt.identical(rt.new_string('inner'), var_from_arg)) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('join')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), var_join.dup()])
		}
	} else {
		this.clear_sql_clause(rt.new_string('join'))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			this.add_sql_clause(rt.new_string('join'), var_join.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		return 'time_interval'
	}
	if rt.is_true(rt.identical(rt.new_string('code'), var_order_by)) {
		return '_coupons.post_title'
	}
	return (var_order_by).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) include_extended_info(var_coupon_data rt.PhpVal, var_query_args rt.PhpVal)  {
	mut var_coupon_data_mutated := var_coupon_data
	{
		mut iter_1 := var_coupon_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_coupon_datum := item_1.val
			mut var_idx := item_1.key
			mut var_extended_info := create_automattic_woocommerce_admin_api_reports_coupons_arrayobject()
			if rt.is_true(var_query_args.array_get('extended_info')) {
				mut var_coupon_id := var_coupon_datum.array_get('coupon_id')
				mut var_coupon := create_automattic_woocommerce_admin_api_reports_coupons_wc_coupon(var_coupon_id.dup())
				if rt.is_true(rt.identical(rt.new_int(0), var_coupon.get_id())) {
					var_extended_info = rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_function('__', [rt.new_string('(Deleted)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'date_created', val: '' }, rt.ArrayItem{ key: 'date_created_gmt', val: '' }, rt.ArrayItem{ key: 'date_expires', val: '' }, rt.ArrayItem{ key: 'date_expires_gmt', val: '' }, rt.ArrayItem{ key: 'discount_type', val: rt.call_function('__', [rt.new_string('N/A'), rt.new_string('woocommerce')]) }])
				} else {
					mut var_gmt_timzone := create_automattic_woocommerce_admin_api_reports_coupons_datetimezone(rt.new_string('UTC'))
					mut var_date_expires := var_coupon.get_date_expires()
					if rt.is_true(rt.call_function('is_a', [var_date_expires.dup(), rt.new_string('DateTime')])) {
						var_date_expires = rt.call_method(var_date_expires, 'format', [// unsupported expression: Expr_StaticPropertyFetch])
						mut var_date_expires_gmt := create_automattic_woocommerce_admin_api_reports_coupons_datetime(var_date_expires.dup())
						rt.call_method(var_date_expires_gmt, 'setTimezone', [var_gmt_timzone])
						var_date_expires_gmt = rt.call_method(var_date_expires_gmt, 'format', [// unsupported expression: Expr_StaticPropertyFetch])
					} else {
						var_date_expires = rt.new_string(rt.new_string(''))
						var_date_expires_gmt = rt.new_string(rt.new_string(''))
					}
					mut var_date_created := var_coupon.get_date_created()
					if rt.is_true(rt.call_function('is_a', [var_date_created.dup(), rt.new_string('DateTime')])) {
						var_date_created = rt.call_method(var_date_created, 'format', [// unsupported expression: Expr_StaticPropertyFetch])
						mut var_date_created_gmt := create_automattic_woocommerce_admin_api_reports_coupons_datetime(var_date_created.dup())
						rt.call_method(var_date_created_gmt, 'setTimezone', [var_gmt_timzone])
						var_date_created_gmt = rt.call_method(var_date_created_gmt, 'format', [// unsupported expression: Expr_StaticPropertyFetch])
					} else {
						var_date_created = rt.new_string(rt.new_string(''))
						var_date_created_gmt = rt.new_string(rt.new_string(''))
					}
					var_extended_info = rt.create_array([rt.ArrayItem{ key: 'code', val: var_coupon.get_code() }, rt.ArrayItem{ key: 'date_created', val: var_date_created }, rt.ArrayItem{ key: 'date_created_gmt', val: var_date_created_gmt }, rt.ArrayItem{ key: 'date_expires', val: var_date_expires }, rt.ArrayItem{ key: 'date_expires_gmt', val: var_date_expires_gmt }, rt.ArrayItem{ key: 'discount_type', val: var_coupon.get_discount_type() }])
				}
			}
			var_coupon_data_mutated.array_get_mut(var_idx).array_set('extended_info', var_extended_info.dup())
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.get_coupon_id(mut var_coupon_item Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Order_Item_Coupon) rt.PhpVal {
	mut var_coupon_info := var_coupon_item.get_meta(rt.new_string('coupon_info'), rt.new_bool(true))
	if rt.is_true(var_coupon_info) {
		return rt.call_function('json_decode', [var_coupon_info.dup(), rt.new_bool(true)]).array_get(0)
	}
	mut var_coupon_data := var_coupon_item.get_meta(rt.new_string('coupon_data'), rt.new_bool(true))
	if var_coupon_data.array_isset(rt.new_string('id')) {
		return var_coupon_data.array_get('id')
	}
	return rt.call_function('wc_get_coupon_id_by_code', [var_coupon_item.get_code()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('orderby', 'coupon_id')
	var_defaults.array_set('coupons', rt.new_array())
	var_defaults.array_set('extended_info', false)
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}; return temp.get_db_table_name() }()
	this.initialize_queries()
	mut var_data := // unsupported expression: Expr_Cast_Object
	mut var_selections := this.selected_columns(var_query_args.dup())
	mut var_included_coupons := this.get_included_coupons_array(var_query_args.dup())
	mut var_limit_params := this.get_limit_params(var_query_args.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), var_selections.dup()])
	this.add_sql_query_params(var_query_args.dup())
	if var_included_coupons.dup().array_count() > 0 {
		mut var_total_results := rt.new_int(rt.new_int(var_included_coupons.dup().array_count()))
		mut var_total_pages := // unsupported expression: Expr_Cast_Int
		mut var_fields := this.get_fields(var_query_args.dup())
		mut var_ids_table := this.get_ids_table(var_included_coupons.dup(), rt.new_string('coupon_id'))
		this.add_sql_clause(rt.new_string('select'), this.format_join_selections(var_fields.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'coupon_id' }])))
		this.add_sql_clause(rt.new_string('from'), rt.new_string('('))
		this.add_sql_clause(rt.new_string('from'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}))
		this.add_sql_clause(rt.new_string('from'), rt.new_string(") AS ${var_table_name.to_string()}"))
		this.add_sql_clause(rt.new_string('right_join'), rt.new_string("RIGHT JOIN ( ${var_ids_table.to_string()} ) AS default_results\n\t\t\t\tON default_results.coupon_id = ${var_table_name.to_string()}.coupon_id"))
		mut var_coupons_query := this.get_query_statement()
	} else {
		if rt.is_true(rt.call_function('in_array', [var_query_args.array_get('orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'amount' }, rt.ArrayItem{ key: none, val: 'orders_count' }]), rt.new_bool(true)])) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'), (this.get_sql_clause(rt.new_string('order_by'))).str() + ', coupon_id'])
		} else {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'), this.get_sql_clause(rt.new_string('order_by'))])
		}
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'), this.get_sql_clause(rt.new_string('limit'))])
		var_coupons_query = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'clear_sql_clause', [rt.create_array([rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'order_by' }, rt.ArrayItem{ key: none, val: 'limit' }])])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), rt.new_string('coupon_id')])
		mut var_coupon_subquery := rt.new_string(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM (\n\t\t\t\t'), rt.call_method(rt.get_property(, 'subquery'), 'get_query_statement', []rt.PhpVal{})), rt.new_string('\n\t\t\t) AS tt')))
		mut var_db_records_count := // unsupported expression: Expr_Cast_Int
		var_total_results = var_db_records_count.dup()
		var_total_pages = 
		if rt.is_true() {
		}
	}
	mut var_coupon_data := 
	if rt.is_true() {
	}
	
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.sync_order_coupons(var_order_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.sync_on_order_delete(var_order_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) get_coupons(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) initialize_queries()  {
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_ArrayObject {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_order_coupon_lookup')
		cache_key: rt.new_string('coupons')
		column_types: rt.new_array()
		context: rt.new_string('coupons')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_arrayobject() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_ArrayObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_wc_coupon() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datetimezone() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datetime() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.init()
			return rt.new_null()
		}
		'get_included_coupons_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_coupons_array(dispatch_arg_0)
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
		'include_extended_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.include_extended_info(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_coupon_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Order_Item_Coupon](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.get_coupon_id(mut dispatch_arg_0)
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'sync_order_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.sync_order_coupons(dispatch_arg_0))
		}
		'sync_on_order_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.sync_on_order_delete(dispatch_arg_0)
			return rt.new_null()
		}
		'get_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupons(dispatch_arg_0)
		}
		'initialize_queries' {
			this.initialize_queries()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'table_name' { this.table_name = val; return true }
		'cache_key' { this.cache_key = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_ArrayObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_ArrayObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_ArrayObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_coupons_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
