import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery.skipped_values() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: rt.new_null() }])
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery.regex_shorthand_dates() string {
	return '/([^.<>]*)(>=|<=|>|<|\\.\\.\\.)([^.<>]+)/'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery.mysql_max_unsigned_bigint() string {
	return '18446744073709551615'
}
struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery {
	rt.PhpObjectBase
pub mut:
		tables rt.PhpVal = rt.new_array()
		mappings rt.PhpVal = rt.new_array()
		args rt.PhpVal = rt.new_array()
		query_args rt.PhpVal = rt.new_array()
		fields string
		join rt.PhpVal = rt.new_array()
		where rt.PhpVal = rt.new_array()
		groupby rt.PhpVal = rt.new_array()
		orderby rt.PhpVal = rt.new_array()
		limits rt.PhpVal = rt.new_array()
		orders rt.PhpVal = rt.new_array()
		sql rt.PhpVal = rt.new_string('')
		count_sql rt.PhpVal = rt.new_string('')
		max_num_pages rt.PhpVal = rt.new_int(0)
		found_orders rt.PhpVal = rt.new_int(0)
		field_query rt.PhpVal = rt.new_null()
		meta_query rt.PhpVal = rt.new_null()
		search_query rt.PhpVal = rt.new_null()
		date_query rt.PhpVal = rt.new_null()
		order_datastore rt.PhpVal = rt.new_null()
		suppress_filters rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) construct(var_args rt.PhpVal)  {
	this.order_datastore = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class()])
	this.tables = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"}{}; return temp.get_all_table_names_with_id() }()
	this.mappings = rt.call_method(this.order_datastore, 'get_all_order_column_mappings', []rt.PhpVal{})
	this.suppress_filters = if rt.is_true(rt.new_bool(var_args.dup().array_isset(rt.new_string('suppress_filters')))) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	var_args.array_unset(rt.new_string('suppress_filters'))
	this.args = var_args.dup()
	this.query_args = var_args.dup()
	this.args.array_unset(rt.new_string('customer_note'))
	this.args.array_unset(rt.new_string('name'))
	this.build_query()
	if !(this.maybe_override_query()) {
		this.run_query()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) maybe_override_query() bool {
	mut var_pre_query := rt.call_function('apply_filters', [rt.new_string('woocommerce_hpos_pre_query'), rt.new_null(), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this), this.sql])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_pre_query)))) || !(var_pre_query.array_isset(rt.new_int(0))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pre_query.array_get(0).is_array()))))))) {
		return false
	}
	// unsupported assign target: Expr_List
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.found_orders.is_long()))))) || rt.is_true(rt.less(this.found_orders, rt.new_int(1))))) {
		this.found_orders = rt.new_int(this.orders.array_count())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.max_num_pages.is_long()))))) || rt.is_true(rt.less(this.max_num_pages, rt.new_int(1))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(this.arg_isset('limit')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.args.array_get('limit').is_long()))))))) || rt.is_true(rt.less(this.args.array_get('limit'), rt.new_int(1))))) {
			this.args.array_set('limit', 10)
		}
		this.max_num_pages = // unsupported expression: Expr_Cast_Int
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) maybe_remap_args()  {
	mut var_mapping := rt.create_array([rt.ArrayItem{ key: 'post_date', val: 'date_created' }, rt.ArrayItem{ key: 'post_date_gmt', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'post_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'post_modified_gmt', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'post_status', val: 'status' }, rt.ArrayItem{ key: '_date_completed', val: 'date_completed' }, rt.ArrayItem{ key: '_date_paid', val: 'date_paid' }, rt.ArrayItem{ key: 'paged', val: 'page' }, rt.ArrayItem{ key: 'post_parent', val: 'parent_order_id' }, rt.ArrayItem{ key: 'post_parent__in', val: 'parent_order_id' }, rt.ArrayItem{ key: 'post_parent__not_in', val: 'parent_exclude' }, rt.ArrayItem{ key: 'post__not_in', val: 'exclude' }, rt.ArrayItem{ key: 'posts_per_page', val: 'limit' }, rt.ArrayItem{ key: 'p', val: 'id' }, rt.ArrayItem{ key: 'post__in', val: 'id' }, rt.ArrayItem{ key: 'post_type', val: 'type' }, rt.ArrayItem{ key: 'fields', val: 'return' }, rt.ArrayItem{ key: 'customer_user', val: 'customer_id' }, rt.ArrayItem{ key: 'order_currency', val: 'currency' }, rt.ArrayItem{ key: 'order_version', val: 'woocommerce_version' }, rt.ArrayItem{ key: 'cart_discount', val: 'discount_total_amount' }, rt.ArrayItem{ key: 'cart_discount_tax', val: 'discount_tax_amount' }, rt.ArrayItem{ key: 'order_shipping', val: 'shipping_total_amount' }, rt.ArrayItem{ key: 'order_shipping_tax', val: 'shipping_tax_amount' }, rt.ArrayItem{ key: 'order_tax', val: 'tax_amount' }, rt.ArrayItem{ key: 'version', val: 'woocommerce_version' }, rt.ArrayItem{ key: 'date_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'date_modified_gmt', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'discount_total', val: 'discount_total_amount' }, rt.ArrayItem{ key: 'discount_tax', val: 'discount_tax_amount' }, rt.ArrayItem{ key: 'shipping_total', val: 'shipping_total_amount' }, rt.ArrayItem{ key: 'shipping_tax', val: 'shipping_tax_amount' }, rt.ArrayItem{ key: 'cart_tax', val: 'tax_amount' }, rt.ArrayItem{ key: 'total', val: 'total_amount' }, rt.ArrayItem{ key: 'customer_ip_address', val: 'ip_address' }, rt.ArrayItem{ key: 'customer_user_agent', val: 'user_agent' }, rt.ArrayItem{ key: 'parent', val: 'parent_order_id' }])
	{
		mut iter_1 := var_mapping.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table_field := item_1.val
			mut var_query_key := item_1.key
			if rt.is_true(rt.new_bool(this.args.array_isset(var_query_key) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				this.args.array_set(var_table_field, this.args.array_get(var_query_key))
				this.args.array_unset(var_query_key)
			}
		}
	}
	this.args.array_set('meta_query', if rt.is_true(rt.new_bool(this.arg_isset('meta_query') && rt.is_true(rt.new_bool(this.args.array_get('meta_query').is_array())))) { this.args.array_get('meta_query') } else { rt.new_array() })
	mut var_shortcut_meta_query := rt.new_array()
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'key' }, rt.ArrayItem{ key: none, val: 'value' }, rt.ArrayItem{ key: none, val: 'compare' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'compare_key' }, rt.ArrayItem{ key: none, val: 'type_key' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if this.arg_isset("meta_${var_key.to_string()}") {
				var_shortcut_meta_query.array_set(var_key, this.args.array_get("meta_${var_key.to_string()}"))
			}
		}
	}
	if !(!rt.is_true(var_shortcut_meta_query)) {
		if !(!rt.is_true(this.args.array_get('meta_query'))) {
			this.args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: var_shortcut_meta_query }, rt.ArrayItem{ key: none, val: this.args.array_get('meta_query') }]))
		} else {
			this.args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: var_shortcut_meta_query }]))
			// unsupported statement: Stmt_Nop
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) date_to_date_query_arg(var_date rt.PhpVal) rt.PhpVal {
	mut var_date_mutated := var_date
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'year', val: '' }, rt.ArrayItem{ key: 'month', val: '' }, rt.ArrayItem{ key: 'day', val: '' }])
	mut var_precision := rt.new_null()
	if rt.is_true(rt.new_bool(var_date_mutated.dup().is_long() || var_date_mutated.dup().is_double())) {
		var_date_mutated = create_automattic_woocommerce_internal_datastores_orders_wc_datetime(rt.new_string("@${var_date.to_string()}"), create_automattic_woocommerce_internal_datastores_orders_datetimezone(rt.new_string('UTC')))
		var_precision = rt.new_string(rt.new_string('second'))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_date_mutated.dup(), rt.new_string('WC_DateTime')]))))) {
		var_date_mutated = rt.call_function('wc_string_to_datetime', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_date_mutated.dup()])])])
		var_precision = rt.new_string(rt.new_string('day'))
	}
	var_result.array_set('year', rt.call_method(var_date_mutated, 'date', [rt.new_string('Y')]))
	var_result.array_set('month', rt.call_method(var_date_mutated, 'date', [rt.new_string('m')]))
	var_result.array_set('day', rt.call_method(var_date_mutated, 'date', [rt.new_string('d')]))
	if rt.is_true(rt.identical(rt.new_string('second'), var_precision)) {
		var_result.array_set('hour', rt.call_method(var_date_mutated, 'date', [rt.new_string('H')]))
		var_result.array_set('minute', rt.call_method(var_date_mutated, 'date', [rt.new_string('i')]))
		var_result.array_set('second', rt.call_method(var_date_mutated, 'date', [rt.new_string('s')]))
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) local_time_to_gmt_date_query(var_dates_raw rt.PhpVal, var_operator rt.PhpVal) rt.PhpVal {
	mut var_dates_raw_mutated := var_dates_raw
	mut var_operator_mutated := var_operator
	mut var_result := rt.new_array()
	{
		mut iter_1 := var_dates_raw_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_raw_date := item_1.val
			var_raw_date = if rt.is_true(rt.new_bool(var_raw_date.dup().is_long() || var_raw_date.dup().is_double())) { var_raw_date } else { rt.call_function('strtotime', [rt.call_function('get_gmt_from_date', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_raw_date.dup()])])])]) }
		}
	}
	mut var_date1 := rt.call_function('end', [var_dates_raw_mutated.dup()])
	mut switch_val_1 := var_operator_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('>'))) {
		var_result = rt.create_array([rt.ArrayItem{ key: 'after', val: this.date_to_date_query_arg(rt.add(var_date1, rt.get_constant('DAY_IN_SECONDS'))) }, rt.ArrayItem{ key: 'inclusive', val: true }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('>='))) {
		var_result = rt.create_array([rt.ArrayItem{ key: 'after', val: this.date_to_date_query_arg(var_date1.dup()) }, rt.ArrayItem{ key: 'inclusive', val: true }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('='))) {
		var_result = rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'after', val: this.date_to_date_query_arg(var_date1.dup()) }, rt.ArrayItem{ key: 'inclusive', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'before', val: this.date_to_date_query_arg(rt.add(var_date1, rt.get_constant('DAY_IN_SECONDS'))) }, rt.ArrayItem{ key: 'inclusive', val: false }]) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<='))) {
		var_result = rt.create_array([rt.ArrayItem{ key: 'before', val: this.date_to_date_query_arg(rt.add(var_date1, rt.get_constant('DAY_IN_SECONDS'))) }, rt.ArrayItem{ key: 'inclusive', val: false }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<'))) {
		var_result = rt.create_array([rt.ArrayItem{ key: 'before', val: this.date_to_date_query_arg(var_date1.dup()) }, rt.ArrayItem{ key: 'inclusive', val: false }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('...'))) {
		var_result = rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: this.local_time_to_gmt_date_query(rt.create_array([rt.ArrayItem{ key: none, val: var_dates_raw_mutated.array_get(1) }]), rt.new_string('<=')) }, rt.ArrayItem{ key: none, val: this.local_time_to_gmt_date_query(rt.create_array([rt.ArrayItem{ key: none, val: var_dates_raw_mutated.array_get(0) }]), rt.new_string('>=')) }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('Please specify a valid date shorthand operator.'))))
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_date_args()  {
	mut var_matches := rt.new_null()
	if this.arg_isset('date_query') {
		this.args.array_set('date_query', this.map_gmt_and_post_keys_to_hpos_keys(this.args.array_get('date_query')))
	}
	mut var_valid_operators := rt.create_array([rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '=' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '...' }])
	mut var_date_queries := rt.new_array()
	mut var_local_to_gmt_date_keys := rt.create_array([rt.ArrayItem{ key: 'date_created', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'date_updated', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'date_paid', val: 'date_paid_gmt' }, rt.ArrayItem{ key: 'date_completed', val: 'date_completed_gmt' }])
	mut var_gmt_date_keys := rt.call_function('array_values', [var_local_to_gmt_date_keys.dup()])
	mut var_local_date_keys := rt.func_array_keys(var_local_to_gmt_date_keys.dup())
	mut var_valid_date_keys := rt.call_function('array_merge', [var_gmt_date_keys.dup(), var_local_date_keys.dup()])
	mut var_date_keys := rt.call_function('array_filter', [var_valid_date_keys.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'arg_isset' }])])
	{
		mut iter_1 := var_date_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_date_key := item_1.val
			mut var_is_local := rt.call_function('in_array', [var_date_key.dup(), var_local_date_keys.dup(), rt.new_bool(true)])
			mut var_date_value := this.args.array_get(var_date_key)
			mut var_operator := rt.new_string(rt.new_string('='))
			mut var_dates_raw := rt.new_array()
			mut var_dates := rt.new_array()
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_date_value.dup().is_string())) && rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery.regex_shorthand_dates(), var_date_value.dup(), var_matches.dup()])))) {
				var_operator = if rt.is_true(rt.call_function('in_array', [var_matches.array_get(2), var_valid_operators.dup(), rt.new_bool(true)])) { var_matches.array_get(2) } else { rt.new_string('') }
				if !(!rt.is_true(var_matches.array_get(1))) {
					var_dates_raw.array_push(var_matches.array_get(1))
				}
				var_dates_raw.array_push(var_matches.array_get(3))
			} else {
				var_dates_raw.array_push(var_date_value.dup())
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_dates_raw) || rt.is_true(rt.new_bool(!(rt.is_true(var_operator)))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('...'), var_operator)) && var_dates_raw.dup().array_count() < 2)))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('Invalid date_query'))))
			}
			if rt.is_true(var_is_local) {
				var_date_key = var_local_to_gmt_date_keys.array_get(var_date_key)
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dates_raw.array_get(0).is_long() || var_dates_raw.array_get(0).is_double()))))) && rt.is_true(rt.new_bool(!(var_dates_raw.array_isset(rt.new_int(1))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dates_raw.array_get(1).is_long() || var_dates_raw.array_get(1).is_double()))))))))) {
					var_date_queries.array_push(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'column', val: var_date_key }]), this.local_time_to_gmt_date_query(var_dates_raw.dup(), var_operator.dup())]))
					continue
				}
			}
			mut var_operator_to_keys := rt.new_array()
			if rt.is_true(rt.call_function('in_array', [var_operator.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '...' }]), rt.new_bool(true)])) {
				var_operator_to_keys.array_push('after')
			}
			if rt.is_true(rt.call_function('in_array', [var_operator.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: '...' }]), rt.new_bool(true)])) {
				var_operator_to_keys.array_push('before')
			}
			var_dates = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'date_to_date_query_arg' }]), var_dates_raw.dup()])
			var_date_queries.array_push(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'column', val: var_date_key }, rt.ArrayItem{ key: 'inclusive', val: !(rt.is_true(rt.call_function('in_array', [var_operator.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '>' }]), rt.new_bool(true)]))) }]), if rt.is_true(rt.identical(rt.new_string('='), var_operator)) { rt.call_function('end', [var_dates.dup()]) } else { rt.call_function('array_combine', [var_operator_to_keys.dup(), var_dates.dup()]) }]))
		}
	}
	mut var_tl_query := rt.new_array()
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'hour' }, rt.ArrayItem{ key: none, val: 'minute' }, rt.ArrayItem{ key: none, val: 'second' }, rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'monthnum' }, rt.ArrayItem{ key: none, val: 'week' }, rt.ArrayItem{ key: none, val: 'day' }, rt.ArrayItem{ key: none, val: 'year' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tl_key := item_1.val
			if this.arg_isset((var_tl_key).str()) {
				var_tl_query.array_set(var_tl_key, this.args.array_get(var_tl_key))
				this.args.array_unset(var_tl_key)
			}
		}
	}
	if rt.is_true(var_tl_query) {
		var_tl_query.array_set('column', 'date_created_gmt')
		var_date_queries.array_push(var_tl_query.dup())
	}
	if rt.is_true(var_date_queries) {
		if !(this.arg_isset('date_query')) {
			this.args.array_set('date_query', rt.new_array())
		}
		this.args.array_set('date_query', rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }]), var_date_queries.dup(), this.args.array_get('date_query')]))
	}
	this.process_date_query_columns()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) map_gmt_and_post_keys_to_hpos_keys(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_query_mutated.dup().is_array()))))) {
		return var_query_mutated.dup()
	}
	mut var_post_to_hpos_mappings := rt.create_array([rt.ArrayItem{ key: 'post_date', val: 'date_created' }, rt.ArrayItem{ key: 'post_date_gmt', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'post_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'post_modified_gmt', val: 'date_updated_gmt' }, rt.ArrayItem{ key: '_date_completed', val: 'date_completed' }, rt.ArrayItem{ key: '_date_paid', val: 'date_paid' }, rt.ArrayItem{ key: 'date_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'date_modified_gmt', val: 'date_updated_gmt' }])
	mut var_local_to_gmt_date_keys := rt.create_array([rt.ArrayItem{ key: 'date_created', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'date_updated', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'date_paid', val: 'date_paid_gmt' }, rt.ArrayItem{ key: 'date_completed', val: 'date_completed_gmt' }])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_sub_query := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_null()
	}
	rt.call_function('array_walk', [var_query_mutated.dup(), rt.new_closure(closure_1_fn)])
	if !(var_query_mutated.array_isset(rt.new_string('column'))) {
		return .dup()
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_date_query_columns()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) sanitize_status()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) sanitize_order_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_orderby_mutated := var_orderby
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) sanitize_order(order string) string {
	mut order_mutated := order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) build_query()  {
	mut var_offset := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) build_count_query(var_fields rt.PhpVal, var_join rt.PhpVal, var_where rt.PhpVal, var_groupby rt.PhpVal)  {
	mut var_fields_mutated := var_fields
	mut var_join_mutated := var_join
	mut var_where_mutated := var_where
	mut var_groupby_mutated := var_groupby
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_core_mapping_alias(mapping_id string) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_core_mapping_join(mapping_id string) string {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) join(table string, alias string, on string, join_type string, alias_once bool)  {
	mut table_mutated := table
	mut alias_mutated := alias
	mut on_mutated := on
	mut join_type_mutated := join_type
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) where(table string, field string, operator string, var_value rt.PhpVal, type string) string {
	mut var_wpdb := rt.new_null()
	mut table_mutated := table
	mut operator_mutated := operator
	mut var_value_mutated := var_value
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_orders_table_query_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) generate_customer_query(var_values rt.PhpVal, relation string) string {
	mut var_values_mutated := var_values
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) generate_total_query(mut var_total_params Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_operational_data_table_query_args()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_addresses_table_query_args()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_orderby()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_limit()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) arg_isset(arg_key string) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) run_query()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) magic_get(name string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get(arg_name string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_table_name(table_id string) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_field_mapping_info(var_field rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_query_args() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablequery(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery{
		PhpObjectBase: rt.PhpObjectBase{}
		tables: rt.new_array()
		mappings: rt.new_array()
		args: rt.new_array()
		query_args: rt.new_array()
		fields: ''
		join: rt.new_array()
		where: rt.new_array()
		groupby: rt.new_array()
		orderby: rt.new_array()
		limits: rt.new_array()
		orders: rt.new_array()
		sql: rt.new_string('')
		count_sql: rt.new_string('')
		max_num_pages: rt.new_int(0)
		found_orders: rt.new_int(0)
		field_query: rt.new_null()
		meta_query: rt.new_null()
		search_query: rt.new_null()
		date_query: rt.new_null()
		order_datastore: rt.new_null()
		suppress_filters: rt.new_bool(false)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_propertyfetch","line":197,"var":{"nodetype":"expr_variable","line":197,"name":"this"},"name":"order_datastore"}() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_datetime() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_datetimezone() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_override_query' {
			return rt.new_bool(this.maybe_override_query())
		}
		'maybe_remap_args' {
			this.maybe_remap_args()
			return rt.new_null()
		}
		'date_to_date_query_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.date_to_date_query_arg(dispatch_arg_0)
		}
		'local_time_to_gmt_date_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.local_time_to_gmt_date_query(dispatch_arg_0, dispatch_arg_1)
		}
		'process_date_args' {
			this.process_date_args()
			return rt.new_null()
		}
		'map_gmt_and_post_keys_to_hpos_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.map_gmt_and_post_keys_to_hpos_keys(dispatch_arg_0)
		}
		'process_date_query_columns' {
			this.process_date_query_columns()
			return rt.new_null()
		}
		'sanitize_status' {
			this.sanitize_status()
			return rt.new_null()
		}
		'sanitize_order_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_order_orderby(dispatch_arg_0)
		}
		'sanitize_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.sanitize_order(dispatch_arg_0))
		}
		'build_query' {
			this.build_query()
			return rt.new_null()
		}
		'build_count_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.build_count_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_core_mapping_alias' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_core_mapping_alias(dispatch_arg_0))
		}
		'get_core_mapping_join' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_core_mapping_join(dispatch_arg_0))
		}
		'join' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			this.join(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'where' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_string(this.where(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'process_orders_table_query_args' {
			this.process_orders_table_query_args()
			return rt.new_null()
		}
		'generate_customer_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.generate_customer_query(dispatch_arg_0, dispatch_arg_1))
		}
		'generate_total_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_total_query(mut dispatch_arg_0))
		}
		'process_operational_data_table_query_args' {
			this.process_operational_data_table_query_args()
			return rt.new_null()
		}
		'process_addresses_table_query_args' {
			this.process_addresses_table_query_args()
			return rt.new_null()
		}
		'process_orderby' {
			this.process_orderby()
			return rt.new_null()
		}
		'process_limit' {
			this.process_limit()
			return rt.new_null()
		}
		'arg_isset' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.arg_isset(dispatch_arg_0))
		}
		'run_query' {
			this.run_query()
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.magic_get(dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0)
		}
		'get_table_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_table_name(dispatch_arg_0))
		}
		'get_field_mapping_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_field_mapping_info(dispatch_arg_0))
		}
		'get_query_args' {
			return this.get_query_args()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tables' { return this.tables }
		'mappings' { return this.mappings }
		'args' { return this.args }
		'query_args' { return this.query_args }
		'fields' { return rt.new_string(this.fields) }
		'join' { return this.join }
		'where' { return this.where }
		'groupby' { return this.groupby }
		'orderby' { return this.orderby }
		'limits' { return this.limits }
		'orders' { return this.orders }
		'sql' { return this.sql }
		'count_sql' { return this.count_sql }
		'max_num_pages' { return this.max_num_pages }
		'found_orders' { return this.found_orders }
		'field_query' { return this.field_query }
		'meta_query' { return this.meta_query }
		'search_query' { return this.search_query }
		'date_query' { return this.date_query }
		'order_datastore' { return this.order_datastore }
		'suppress_filters' { return this.suppress_filters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tables' { this.tables = val; return true }
		'mappings' { this.mappings = val; return true }
		'args' { this.args = val; return true }
		'query_args' { this.query_args = val; return true }
		'fields' { this.fields = (val).str(); return true }
		'join' { this.join = val; return true }
		'where' { this.where = val; return true }
		'groupby' { this.groupby = val; return true }
		'orderby' { this.orderby = val; return true }
		'limits' { this.limits = val; return true }
		'orders' { this.orders = val; return true }
		'sql' { this.sql = val; return true }
		'count_sql' { this.count_sql = val; return true }
		'max_num_pages' { this.max_num_pages = val; return true }
		'found_orders' { this.found_orders = val; return true }
		'field_query' { this.field_query = val; return true }
		'meta_query' { this.meta_query = val; return true }
		'search_query' { this.search_query = val; return true }
		'date_query' { this.date_query = val; return true }
		'order_datastore' { this.order_datastore = val; return true }
		'suppress_filters' { this.suppress_filters = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_datastores_orders_orderstablequery_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
