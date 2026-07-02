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

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) construct(var_args rt.PhpVal) {
	this.order_datastore = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class()])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"}{}
	mut iife_result_0 := iife_temp_0.get_all_table_names_with_id()
	this.tables = iife_result_0
	this.mappings = rt.call_method(this.order_datastore, 'get_all_order_column_mappings', []rt.PhpVal{})
	this.suppress_filters = if rt.is_true(rt.new_bool(var_args.clone().array_isset(rt.new_string('suppress_filters')))) { (var_args.array_get(rt.new_string('suppress_filters'))).to_bool() } else { false }
	var_args.array_unset(rt.new_string('suppress_filters'))
	this.args = var_args.clone()
	this.query_args = var_args.clone()
	this.args.array_unset(rt.new_string('customer_note'))
	this.args.array_unset(rt.new_string('name'))
	this.build_query()
	if !(this.maybe_override_query()) {
		this.run_query()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) maybe_override_query() bool {
	mut var_pre_query := rt.call_function('apply_filters', [rt.new_string('woocommerce_hpos_pre_query'), rt.new_null(), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this), this.sql])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pre_query)))) || !(var_pre_query.array_isset(rt.new_int(0))) || !(var_pre_query.array_get(rt.new_int(0)).is_array()) {
		return false
	}
	mut list_tmp_1 := var_pre_query
	if !(this.found_orders.is_long()) || rt.is_true(rt.less(this.found_orders, rt.new_int(1))) {
		this.found_orders = rt.new_int(this.orders.array_count())
	}
	if !(this.max_num_pages.is_long()) || rt.is_true(rt.less(this.max_num_pages, rt.new_int(1))) {
		if !(this.arg_isset('limit')) || !(this.args.array_get(rt.new_string('limit')).is_long()) || rt.is_true(rt.less(this.args.array_get(rt.new_string('limit')), rt.new_int(1))) {
			this.args.array_set('limit', 10)
		}
		this.max_num_pages = rt.new_int((rt.call_function('ceil', [rt.div(this.found_orders, this.args.array_get(rt.new_string('limit')))])).to_i64())
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) maybe_remap_args() {
	mut var_mapping := rt.create_array([rt.ArrayItem{ key: 'post_date', val: 'date_created' }, rt.ArrayItem{ key: 'post_date_gmt', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'post_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'post_modified_gmt', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'post_status', val: 'status' }, rt.ArrayItem{ key: '_date_completed', val: 'date_completed' }, rt.ArrayItem{ key: '_date_paid', val: 'date_paid' }, rt.ArrayItem{ key: 'paged', val: 'page' }, rt.ArrayItem{ key: 'post_parent', val: 'parent_order_id' }, rt.ArrayItem{ key: 'post_parent__in', val: 'parent_order_id' }, rt.ArrayItem{ key: 'post_parent__not_in', val: 'parent_exclude' }, rt.ArrayItem{ key: 'post__not_in', val: 'exclude' }, rt.ArrayItem{ key: 'posts_per_page', val: 'limit' }, rt.ArrayItem{ key: 'p', val: 'id' }, rt.ArrayItem{ key: 'post__in', val: 'id' }, rt.ArrayItem{ key: 'post_type', val: 'type' }, rt.ArrayItem{ key: 'fields', val: 'return' }, rt.ArrayItem{ key: 'customer_user', val: 'customer_id' }, rt.ArrayItem{ key: 'order_currency', val: 'currency' }, rt.ArrayItem{ key: 'order_version', val: 'woocommerce_version' }, rt.ArrayItem{ key: 'cart_discount', val: 'discount_total_amount' }, rt.ArrayItem{ key: 'cart_discount_tax', val: 'discount_tax_amount' }, rt.ArrayItem{ key: 'order_shipping', val: 'shipping_total_amount' }, rt.ArrayItem{ key: 'order_shipping_tax', val: 'shipping_tax_amount' }, rt.ArrayItem{ key: 'order_tax', val: 'tax_amount' }, rt.ArrayItem{ key: 'version', val: 'woocommerce_version' }, rt.ArrayItem{ key: 'date_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'date_modified_gmt', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'discount_total', val: 'discount_total_amount' }, rt.ArrayItem{ key: 'discount_tax', val: 'discount_tax_amount' }, rt.ArrayItem{ key: 'shipping_total', val: 'shipping_total_amount' }, rt.ArrayItem{ key: 'shipping_tax', val: 'shipping_tax_amount' }, rt.ArrayItem{ key: 'cart_tax', val: 'tax_amount' }, rt.ArrayItem{ key: 'total', val: 'total_amount' }, rt.ArrayItem{ key: 'customer_ip_address', val: 'ip_address' }, rt.ArrayItem{ key: 'customer_user_agent', val: 'user_agent' }, rt.ArrayItem{ key: 'parent', val: 'parent_order_id' }])
	mut iter_1 := var_mapping.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_table_field := item_1.val
		mut var_query_key := item_1.key
		if this.args.array_isset(var_query_key) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.args.array_get(var_query_key))))) {
			this.args.array_set(var_table_field, this.args.array_get(var_query_key))
			this.args.array_unset(var_query_key)
		}
	}
	this.args.array_set('meta_query', if this.arg_isset('meta_query') && this.args.array_get(rt.new_string('meta_query')).is_array() { this.args.array_get(rt.new_string('meta_query')) } else { rt.new_array() })
	mut var_shortcut_meta_query := rt.new_array()
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'key' }, rt.ArrayItem{ key: none, val: 'value' }, rt.ArrayItem{ key: none, val: 'compare' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'compare_key' }, rt.ArrayItem{ key: none, val: 'type_key' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		if this.arg_isset("meta_${var_key.to_string()}") {
			var_shortcut_meta_query.array_set(var_key, this.args.array_get(rt.new_string("meta_${var_key.to_string()}")))
		}
	}
	if !(!rt.is_true(var_shortcut_meta_query)) {
		if !(!rt.is_true(this.args.array_get(rt.new_string('meta_query')))) {
			this.args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: var_shortcut_meta_query }, rt.ArrayItem{ key: none, val: this.args.array_get(rt.new_string('meta_query')) }]))
		} else {
			this.args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: var_shortcut_meta_query }]))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) date_to_date_query_arg(var_date rt.PhpVal) rt.PhpVal {
	mut var_date_mutated := var_date
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'year', val: '' }, rt.ArrayItem{ key: 'month', val: '' }, rt.ArrayItem{ key: 'day', val: '' }])
	mut var_precision := rt.new_null()
	if rt.is_true(rt.new_bool(var_date_mutated.clone().is_long() || var_date_mutated.clone().is_double())) {
	var_date_mutated = create_automattic_woocommerce_internal_datastores_orders_wc_datetime(rt.new_string("@${var_date.to_string()}"), create_automattic_woocommerce_internal_datastores_orders_datetimezone(rt.new_string('UTC')))
	var_precision = rt.new_string('second')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_date_mutated.clone(), rt.new_string('WC_DateTime')]))))) {
	var_date_mutated = rt.call_function('wc_string_to_datetime', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_date_mutated.clone()])])])
	var_precision = rt.new_string('day')
	}
	var_result.array_set('year', rt.call_method(var_date_mutated, 'date', [rt.new_string('Y')]))
	var_result.array_set('month', rt.call_method(var_date_mutated, 'date', [rt.new_string('m')]))
	var_result.array_set('day', rt.call_method(var_date_mutated, 'date', [rt.new_string('d')]))
	if rt.is_true(rt.identical(rt.new_string('second'), var_precision)) {
		var_result.array_set('hour', rt.call_method(var_date_mutated, 'date', [rt.new_string('H')]))
		var_result.array_set('minute', rt.call_method(var_date_mutated, 'date', [rt.new_string('i')]))
		var_result.array_set('second', rt.call_method(var_date_mutated, 'date', [rt.new_string('s')]))
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) local_time_to_gmt_date_query(var_dates_raw rt.PhpVal, var_operator rt.PhpVal) rt.PhpVal {
	mut var_dates_raw_mutated := var_dates_raw
	mut var_operator_mutated := var_operator
	mut var_result := rt.new_array()
	mut iter_3 := var_dates_raw_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_raw_date := item_3.val
	var_raw_date = if var_raw_date.clone().is_long() || var_raw_date.clone().is_double() { var_raw_date } else { rt.call_function('strtotime', [rt.call_function('get_gmt_from_date', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_raw_date.clone()])])])]) }
	}
	mut var_date1 := rt.call_function('end', [var_dates_raw_mutated.clone()])
	mut switch_val_1 := var_operator_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('>'))) {
	var_result = rt.create_array([rt.ArrayItem{ key: 'after', val: this.date_to_date_query_arg(rt.add(var_date1, rt.get_constant('DAY_IN_SECONDS'))) }, rt.ArrayItem{ key: 'inclusive', val: true }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('>='))) {
	var_result = rt.create_array([rt.ArrayItem{ key: 'after', val: this.date_to_date_query_arg(var_date1.clone()) }, rt.ArrayItem{ key: 'inclusive', val: true }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('='))) {
	var_result = rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'after', val: this.date_to_date_query_arg(var_date1.clone()) }, rt.ArrayItem{ key: 'inclusive', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'before', val: this.date_to_date_query_arg(rt.add(var_date1, rt.get_constant('DAY_IN_SECONDS'))) }, rt.ArrayItem{ key: 'inclusive', val: false }]) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<='))) {
	var_result = rt.create_array([rt.ArrayItem{ key: 'before', val: this.date_to_date_query_arg(rt.add(var_date1, rt.get_constant('DAY_IN_SECONDS'))) }, rt.ArrayItem{ key: 'inclusive', val: false }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<'))) {
	var_result = rt.create_array([rt.ArrayItem{ key: 'before', val: this.date_to_date_query_arg(var_date1.clone()) }, rt.ArrayItem{ key: 'inclusive', val: false }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('...'))) {
	var_result = rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: this.local_time_to_gmt_date_query(rt.create_array([rt.ArrayItem{ key: none, val: var_dates_raw_mutated.array_get(rt.new_int(1)) }]), rt.new_string('<=')) }, rt.ArrayItem{ key: none, val: this.local_time_to_gmt_date_query(rt.create_array([rt.ArrayItem{ key: none, val: var_dates_raw_mutated.array_get(rt.new_int(0)) }]), rt.new_string('>=')) }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('Please specify a valid date shorthand operator.'))))
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_date_args() {
	mut var_matches := rt.new_null()
	if this.arg_isset('date_query') {
		this.args.array_set('date_query', this.map_gmt_and_post_keys_to_hpos_keys(this.args.array_get(rt.new_string('date_query'))))
	}
	mut var_valid_operators := rt.create_array([rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '=' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '...' }])
	mut var_date_queries := rt.new_array()
	mut var_local_to_gmt_date_keys := rt.create_array([rt.ArrayItem{ key: 'date_created', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'date_updated', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'date_paid', val: 'date_paid_gmt' }, rt.ArrayItem{ key: 'date_completed', val: 'date_completed_gmt' }])
	mut var_gmt_date_keys := rt.call_function('array_values', [var_local_to_gmt_date_keys.clone()])
	mut var_local_date_keys := rt.func_array_keys(var_local_to_gmt_date_keys.clone())
	mut var_valid_date_keys := rt.call_function('array_merge', [var_gmt_date_keys.clone(), var_local_date_keys.clone()])
	mut var_date_keys := rt.call_function('array_filter', [var_valid_date_keys.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'arg_isset' }])])
	mut iter_4 := var_date_keys.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_date_key := item_4.val
		mut var_is_local := rt.call_function('in_array', [var_date_key.clone(), var_local_date_keys.clone(), rt.new_bool(true)])
		mut var_date_value := this.args.array_get(var_date_key)
		mut var_operator := rt.new_string('=')
		mut var_dates_raw := rt.new_array()
		mut var_dates := rt.new_array()
		if var_date_value.clone().is_string() && rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery.regex_shorthand_dates(), var_date_value.clone(), var_matches.clone()])) {
			var_operator = if rt.is_true(rt.call_function('in_array', [var_matches.array_get(rt.new_int(2)), var_valid_operators.clone(), rt.new_bool(true)])) { var_matches.array_get(rt.new_int(2)) } else { rt.new_string('') }
			if !(!rt.is_true(var_matches.array_get(rt.new_int(1)))) {
				var_dates_raw.array_push(var_matches.array_get(rt.new_int(1)))
			}
			var_dates_raw.array_push(var_matches.array_get(rt.new_int(3)))
		} else {
			var_dates_raw.array_push(var_date_value.clone())
		}
		if !rt.is_true(var_dates_raw) || rt.is_true(rt.new_bool(!(rt.is_true(var_operator)))) || (rt.is_true(rt.identical(rt.new_string('...'), var_operator)) && var_dates_raw.clone().array_count() < 2) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('Invalid date_query'))))
		}
		if rt.is_true(var_is_local) {
			var_date_key = var_local_to_gmt_date_keys.array_get(var_date_key)
			if !(var_dates_raw.array_get(rt.new_int(0)).is_long() || var_dates_raw.array_get(rt.new_int(0)).is_double()) && !(var_dates_raw.array_isset(rt.new_int(1))) || !(var_dates_raw.array_get(rt.new_int(1)).is_long() || var_dates_raw.array_get(rt.new_int(1)).is_double()) {
				var_date_queries.array_push(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'column', val: var_date_key }]), this.local_time_to_gmt_date_query(var_dates_raw.clone(), var_operator.clone())]))
				continue
			}
		}
		mut var_operator_to_keys := rt.new_array()
		if rt.is_true(rt.call_function('in_array', [var_operator.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '...' }]), rt.new_bool(true)])) {
			var_operator_to_keys.array_push('after')
		}
		if rt.is_true(rt.call_function('in_array', [var_operator.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: '...' }]), rt.new_bool(true)])) {
			var_operator_to_keys.array_push('before')
		}
		var_dates = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'date_to_date_query_arg' }]), var_dates_raw.clone()])
		var_date_queries.array_push(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'column', val: var_date_key }, rt.ArrayItem{ key: 'inclusive', val: !(rt.is_true(rt.call_function('in_array', [var_operator.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '>' }]), rt.new_bool(true)]))) }]), if rt.is_true(rt.identical(rt.new_string('='), var_operator)) { rt.call_function('end', [var_dates.clone()]) } else { rt.call_function('array_combine', [var_operator_to_keys.clone(), var_dates.clone()]) }]))
	}
	mut var_tl_query := rt.new_array()
	mut iter_5 := rt.create_array([rt.ArrayItem{ key: none, val: 'hour' }, rt.ArrayItem{ key: none, val: 'minute' }, rt.ArrayItem{ key: none, val: 'second' }, rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'monthnum' }, rt.ArrayItem{ key: none, val: 'week' }, rt.ArrayItem{ key: none, val: 'day' }, rt.ArrayItem{ key: none, val: 'year' }]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_tl_key := item_5.val
		if this.arg_isset((var_tl_key).str()) {
			var_tl_query.array_set(var_tl_key, this.args.array_get(var_tl_key))
			this.args.array_unset(var_tl_key)
		}
	}
	if rt.is_true(var_tl_query) {
		var_tl_query.array_set('column', 'date_created_gmt')
		var_date_queries.array_push(var_tl_query.clone())
	}
	if rt.is_true(var_date_queries) {
		if !(this.arg_isset('date_query')) {
			this.args.array_set('date_query', rt.new_array())
		}
		this.args.array_set('date_query', rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }]), var_date_queries.clone(), this.args.array_get(rt.new_string('date_query'))]))
	}
	this.process_date_query_columns()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) map_gmt_and_post_keys_to_hpos_keys(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	if !(var_query_mutated.clone().is_array()) {
		return var_query_mutated.clone()
	}
	mut var_post_to_hpos_mappings := rt.create_array([rt.ArrayItem{ key: 'post_date', val: 'date_created' }, rt.ArrayItem{ key: 'post_date_gmt', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'post_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'post_modified_gmt', val: 'date_updated_gmt' }, rt.ArrayItem{ key: '_date_completed', val: 'date_completed' }, rt.ArrayItem{ key: '_date_paid', val: 'date_paid' }, rt.ArrayItem{ key: 'date_modified', val: 'date_updated' }, rt.ArrayItem{ key: 'date_modified_gmt', val: 'date_updated_gmt' }])
	mut var_local_to_gmt_date_keys := rt.create_array([rt.ArrayItem{ key: 'date_created', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'date_updated', val: 'date_updated_gmt' }, rt.ArrayItem{ key: 'date_paid', val: 'date_paid_gmt' }, rt.ArrayItem{ key: 'date_completed', val: 'date_completed_gmt' }])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sub_query := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_sub_query = this.map_gmt_and_post_keys_to_hpos_keys(var_sub_query.clone())
		return rt.new_null()
		}
	rt.call_function('array_walk', [var_query_mutated.clone(), rt.new_closure(closure_2_fn)])
	if !(var_query_mutated.array_isset(rt.new_string('column'))) {
		return var_query_mutated.clone()
	}
	if var_post_to_hpos_mappings.array_isset(var_query_mutated.array_get(rt.new_string('column'))) {
		var_query_mutated.array_set('column', var_post_to_hpos_mappings.array_get(var_query_mutated.array_get(rt.new_string('column'))))
	}
	if var_local_to_gmt_date_keys.array_isset(var_query_mutated.array_get(rt.new_string('column'))) {
		var_query_mutated.array_set('column', var_local_to_gmt_date_keys.array_get(var_query_mutated.array_get(rt.new_string('column'))))
		mut var_op := rt.new_string((if var_query_mutated.array_isset(rt.new_string('after')) { 'after' } else { 'before' }).str())
		mut var_date_value_local := var_query_mutated.array_get(var_op)
		mut var_date_value_gmt := rt.call_function('wc_string_to_timestamp', [rt.call_function('get_gmt_from_date', [rt.call_function('wc_string_to_datetime', [var_date_value_local.clone()])])])
		var_query_mutated.array_set(var_op, this.date_to_date_query_arg(var_date_value_gmt.clone()))
	}
	return var_query_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_date_query_columns() {
	mut var_wpdb := rt.new_null()
	mut var_legacy_columns := rt.create_array([rt.ArrayItem{ key: 'post_date', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'post_date_gmt', val: 'date_created_gmt' }, rt.ArrayItem{ key: 'post_modified', val: 'date_modified_gmt' }, rt.ArrayItem{ key: 'post_modified_gmt', val: 'date_updated_gmt' }])
	mut var_table_mapping := rt.create_array([rt.ArrayItem{ key: 'date_created_gmt', val: this.tables.array_get(rt.new_string('orders')) }, rt.ArrayItem{ key: 'date_updated_gmt', val: this.tables.array_get(rt.new_string('orders')) }, rt.ArrayItem{ key: 'date_paid_gmt', val: this.tables.array_get(rt.new_string('operational_data')) }, rt.ArrayItem{ key: 'date_completed_gmt', val: this.tables.array_get(rt.new_string('operational_data')) }])
	if !rt.is_true(this.args.array_get(rt.new_string('date_query'))) {
		return
	}
	closure_3_fn := fn [var_legacy_columns, var_table_mapping, var_wpdb] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_key := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('column'), var_key)))) {
			return
		}
		var_value = if var_legacy_columns.array_isset(var_value) || var_legacy_columns.array_isset(rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.')), var_value)) { var_legacy_columns.array_get(var_value) } else { var_value }
		mut var_table := if !(var_table_mapping.array_get(var_value)).is_null() { var_table_mapping.array_get(var_value) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
			return
		}
		var_value = rt.new_string("${var_table.to_string()}.${var_value.to_string()}")
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_table, this.tables.array_get(rt.new_string('orders')))))) {
			this.join((var_table).str(), '', '', 'inner', true)
		}
		return rt.new_null()
		}
	rt.call_function('array_walk_recursive', [this.args.array_get(rt.new_string('date_query')), rt.new_closure(closure_3_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) sanitize_status() {
	mut var_valid_statuses := rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{}))
	if !rt.is_true(this.args.array_get(rt.new_string('status'))) {
		this.args.array_set('status', rt.new_array())
	}
	if !(this.args.array_get(rt.new_string('status')).is_array()) {
		this.args.array_set('status', rt.create_array([rt.ArrayItem{ key: none, val: this.args.array_get(rt.new_string('status')) }]))
	}
	if !rt.is_true(this.args.array_get(rt.new_string('status'))) || rt.is_true(rt.call_function('in_array', [rt.new_string('any'), this.args.array_get(rt.new_string('status')), rt.new_bool(true)])) {
		mut var_exclude := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'exclude_from_search', val: true }])])
		this.args.array_set('status', rt.call_function('array_diff', [var_valid_statuses.clone(), var_exclude.clone()]))
	} else if rt.is_true(rt.call_function('in_array', [rt.new_string('all'), this.args.array_get(rt.new_string('status')), rt.new_bool(true)])) {
		this.args.array_set('status', rt.new_array())
	}
	mut iter_6 := this.args.array_get(rt.new_string('status')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_status := item_6.val
	var_status = if rt.is_true(rt.call_function('in_array', [rt.new_string('wc-' + (var_status).str()), var_valid_statuses.clone(), rt.new_bool(true)])) { 'wc-' + (var_status).str() } else { var_status }
	}
	this.args.array_set('status', rt.call_function('array_unique', [rt.call_function('array_filter', [this.args.array_get(rt.new_string('status'))])]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) sanitize_order_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_orderby_mutated := var_orderby
	if rt.is_true(rt.identical(rt.new_string('include'), var_orderby_mutated)) || rt.is_true(rt.identical(rt.new_string('post__in'), var_orderby_mutated)) || rt.is_true(rt.identical(rt.new_string('none'), var_orderby_mutated)) {
		return var_orderby_mutated.clone()
	}
	mut var_mapping := rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.id')) }, rt.ArrayItem{ key: 'id', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.id')) }, rt.ArrayItem{ key: 'type', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.type')) }, rt.ArrayItem{ key: 'date', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.date_created_gmt')) }, rt.ArrayItem{ key: 'date_created', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.date_created_gmt')) }, rt.ArrayItem{ key: 'modified', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.date_updated_gmt')) }, rt.ArrayItem{ key: 'date_modified', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.date_updated_gmt')) }, rt.ArrayItem{ key: 'parent', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.parent_order_id')) }, rt.ArrayItem{ key: 'total', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.total_amount')) }, rt.ArrayItem{ key: 'order_total', val: rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.total_amount')) }])
	mut var_order := rt.new_string(this.sanitize_order((if !(this.args.array_get(rt.new_string('order'))).is_null() { this.args.array_get(rt.new_string('order')) } else { rt.new_string('') }).str()))
	mut var_allowed_orderby := rt.call_function('array_merge', [rt.func_array_keys(var_mapping.clone()), rt.call_function('array_values', [var_mapping.clone()]), if rt.is_true(this.meta_query) { rt.call_method(this.meta_query, 'get_orderby_keys', []rt.PhpVal{}) } else { rt.new_array() }])
	if rt.is_true(rt.new_bool(var_orderby_mutated.clone().is_string())) {
		mut var_orderby_fields := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(' '), var_orderby_mutated.clone()])])
		var_orderby_mutated = rt.new_array()
		mut iter_7 := var_orderby_fields.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_field := item_7.val
			var_orderby_mutated.array_set(var_field, var_order.clone())
		}
	}
	mut var_sanitized_orderby := rt.new_array()
	mut iter_8 := var_orderby_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_order_shadow := item_8.val
		mut var_order_key := item_8.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_order_key.clone(), var_allowed_orderby.clone(), rt.new_bool(true)]))))) {
			continue
		}
		if var_mapping.array_isset(var_order_key) {
		var_order_key = var_mapping.array_get(var_order_key)
		}
		var_sanitized_orderby.array_set(var_order_key, this.sanitize_order((var_order_shadow).str()))
	}
	return var_sanitized_orderby.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) sanitize_order(order string) string {
	mut order_mutated := order
	order_mutated = order_mutated.to_upper()
	return if rt.is_true(rt.call_function('in_array', [rt.new_string(order_mutated).clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'ASC' }, rt.ArrayItem{ key: none, val: 'DESC' }]), rt.new_bool(true)])) { order_mutated } else { 'DESC' }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) build_query() {
	mut var_offset := rt.new_null()
	this.maybe_remap_args()
	if !(!rt.is_true(this.args.array_get(rt.new_string('field_query')))) {
		this.field_query = create_automattic_woocommerce_internal_datastores_orders_orderstablefieldquery(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this))
		mut var_sql := rt.call_method(this.field_query, 'get_sql_clauses', []rt.PhpVal{})
		this.join = if rt.is_true(var_sql.array_get(rt.new_string('join'))) { rt.call_function('array_merge', [this.join, var_sql.array_get(rt.new_string('join'))]) } else { this.join }
		this.where = if rt.is_true(var_sql.array_get(rt.new_string('where'))) { rt.call_function('array_merge', [this.where, var_sql.array_get(rt.new_string('where'))]) } else { this.where }
	}
	this.process_date_args()
	this.process_orders_table_query_args()
	this.process_operational_data_table_query_args()
	this.process_addresses_table_query_args()
	if !(!rt.is_true(this.args.array_get(rt.new_string('s')))) {
		this.search_query = create_automattic_woocommerce_internal_datastores_orders_orderstablesearchquery(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this))
		var_sql = rt.call_method(this.search_query, 'get_sql_clauses', []rt.PhpVal{})
		this.join = if rt.is_true(var_sql.array_get(rt.new_string('join'))) { rt.call_function('array_merge', [this.join, var_sql.array_get(rt.new_string('join'))]) } else { this.join }
		this.where = if rt.is_true(var_sql.array_get(rt.new_string('where'))) { rt.call_function('array_merge', [this.where, var_sql.array_get(rt.new_string('where'))]) } else { this.where }
	}
	if !(!rt.is_true(this.args.array_get(rt.new_string('meta_query')))) {
		this.meta_query = create_automattic_woocommerce_internal_datastores_orders_orderstablemetaquery(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this))
		var_sql = rt.call_method(this.meta_query, 'get_sql_clauses', []rt.PhpVal{})
		this.join = if rt.is_true(var_sql.array_get(rt.new_string('join'))) { rt.call_function('array_merge', [this.join, var_sql.array_get(rt.new_string('join'))]) } else { this.join }
		this.where = if rt.is_true(var_sql.array_get(rt.new_string('where'))) { rt.call_function('array_merge', [this.where, rt.create_array([rt.ArrayItem{ key: none, val: var_sql.array_get(rt.new_string('where')) }])]) } else { this.where }
	}
	if !(!rt.is_true(this.args.array_get(rt.new_string('date_query')))) {
		this.date_query = create_automattic_woocommerce_internal_datastores_orders_wp_date_query(this.args.array_get(rt.new_string('date_query')), rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.date_created_gmt')))
		this.where.array_push(rt.call_function('substr', [rt.new_string(rt.call_method(this.date_query, 'get_sql', []rt.PhpVal{}).to_string().trim_space()), rt.new_int(3)]))
	}
	this.process_orderby()
	this.process_limit()
	mut var_orders_table := this.tables.array_get(rt.new_string('orders'))
	this.groupby.array_push(rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.id')))
	this.fields = "${var_orders_table.to_string()}.id"
	mut var_fields := rt.new_string(this.fields)
	mut var_join := rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_unique', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), this.join])])])])
	mut var_where := rt.new_string('1=1')
	mut iter_9 := this.where.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var__where := item_9.val
		if var__where.clone().to_string().len > 0 {
			var_where = rt.concat(var_where, rt.new_string(" AND (${var__where.to_string()})"))
		}
	}
	mut var_orderby := if rt.is_true(this.orderby) { rt.call_function('implode', [rt.new_string(', '), this.orderby]) } else { rt.new_string('') }
	mut var_limits := rt.new_string('')
	if !(!rt.is_true(this.limits)) && this.limits.array_count() == 2 {
		mut list_tmp_2 := this.limits
		var_offset = (list_tmp_2).array_get(0)
		mut var_row_count := (list_tmp_2).array_get(1)
	var_row_count = if rt.is_true(rt.identical(-1, var_row_count)) { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery.mysql_max_unsigned_bigint() } else { rt.new_int((var_row_count).to_i64()) }
	var_limits = rt.new_string('LIMIT ' + rt.new_int((var_offset).to_i64()).str() + ', ' + (var_row_count).str())
	}
	mut var_groupby := if rt.is_true(this.groupby) { rt.call_function('implode', [rt.new_string(', '), rt.cast_array(this.groupby)]) } else { rt.new_string('') }
	mut var_pieces := rt.call_function('compact', [rt.new_string('fields'), rt.new_string('join'), rt.new_string('where'), rt.new_string('groupby'), rt.new_string('orderby'), rt.new_string('limits')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.suppress_filters)))) {
	mut var_clauses := rt.cast_array(rt.call_function('apply_filters_ref_array', [rt.new_string('woocommerce_orders_table_query_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: var_pieces }, rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: this.args }])]))
	var_fields = if !(var_clauses.array_get(rt.new_string('fields'))).is_null() { var_clauses.array_get(rt.new_string('fields')) } else { rt.new_string('') }
	var_join = if !(var_clauses.array_get(rt.new_string('join'))).is_null() { var_clauses.array_get(rt.new_string('join')) } else { rt.new_string('') }
	var_where = if !(var_clauses.array_get(rt.new_string('where'))).is_null() { var_clauses.array_get(rt.new_string('where')) } else { rt.new_string('') }
	var_groupby = if !(var_clauses.array_get(rt.new_string('groupby'))).is_null() { var_clauses.array_get(rt.new_string('groupby')) } else { rt.new_string('') }
	var_orderby = if !(var_clauses.array_get(rt.new_string('orderby'))).is_null() { var_clauses.array_get(rt.new_string('orderby')) } else { rt.new_string('') }
	var_limits = if !(var_clauses.array_get(rt.new_string('limits'))).is_null() { var_clauses.array_get(rt.new_string('limits')) } else { rt.new_string('') }
	}
	var_groupby = rt.new_string((if rt.is_true(var_groupby) { 'GROUP BY ' + (var_groupby).str() } else { '' }).str())
	var_orderby = rt.new_string((if rt.is_true(var_orderby) { 'ORDER BY ' + (var_orderby).str() } else { '' }).str())
	this.sql = rt.new_string("SELECT ${var_fields.to_string()} FROM ${var_orders_table.to_string()} ${var_join.to_string()} WHERE ${var_where.to_string()} ${var_groupby.to_string()} ${var_orderby.to_string()} ${var_limits.to_string()}")
	if rt.is_true(rt.new_bool(!(rt.is_true(this.suppress_filters)))) {
		this.sql = rt.call_function('apply_filters_ref_array', [rt.new_string('woocommerce_orders_table_query_sql'), rt.create_array([rt.ArrayItem{ key: none, val: this.sql }, rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: this.args }])])
	}
	this.build_count_query(var_fields.clone(), var_join.clone(), var_where.clone(), var_groupby.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) build_count_query(var_fields rt.PhpVal, var_join rt.PhpVal, var_where rt.PhpVal, var_groupby rt.PhpVal) {
	mut var_fields_mutated := var_fields
	mut var_join_mutated := var_join
	mut var_where_mutated := var_where
	mut var_groupby_mutated := var_groupby
	if !(!(this.sql).is_null()) || rt.is_true(rt.identical(rt.new_string(''), this.sql)) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.new_string('Count query can only be build after main query is built.'), rt.new_string('7.3.0')])
	}
	mut var_orders_table := this.tables.array_get(rt.new_string('orders'))
	mut var_count_fields := rt.new_string("COUNT(DISTINCT ${var_fields.to_string()})")
	if rt.is_true(rt.identical(rt.new_string("${var_orders_table.to_string()}.id"), var_fields_mutated)) && rt.is_true(rt.identical(rt.new_string(''), var_join_mutated)) {
	var_count_fields = rt.new_string('COUNT(*)')
	}
	this.count_sql = rt.new_string("SELECT ${var_count_fields.to_string()} FROM ${var_orders_table.to_string()} ${var_join.to_string()} WHERE ${var_where.to_string()}")
	if rt.is_true(rt.new_bool(!(rt.is_true(this.suppress_filters)))) {
		this.count_sql = rt.call_function('apply_filters_ref_array', [rt.new_string('woocommerce_orders_table_query_count_sql'), rt.create_array([rt.ArrayItem{ key: none, val: this.count_sql }, rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: this.args }, rt.ArrayItem{ key: none, val: var_fields_mutated }, rt.ArrayItem{ key: none, val: var_join_mutated }, rt.ArrayItem{ key: none, val: var_where_mutated }, rt.ArrayItem{ key: none, val: var_groupby_mutated }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_core_mapping_alias(mapping_id string) string {
	return (if rt.is_true(rt.call_function('in_array', [rt.new_string(mapping_id), rt.create_array([rt.ArrayItem{ key: none, val: 'billing_address' }, rt.ArrayItem{ key: none, val: 'shipping_address' }]), rt.new_bool(true)])) { rt.new_string(mapping_id) } else { this.tables.array_get(rt.new_string(mapping_id)) }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_core_mapping_join(mapping_id string) string {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('orders'), rt.new_string(mapping_id))) {
		return ''
	}
	mut var_is_address_mapping := rt.call_function('in_array', [rt.new_string(mapping_id), rt.create_array([rt.ArrayItem{ key: none, val: 'billing_address' }, rt.ArrayItem{ key: none, val: 'shipping_address' }]), rt.new_bool(true)])
	mut var_alias := rt.new_string(this.get_core_mapping_alias(mapping_id))
	mut var_table := if rt.is_true(var_is_address_mapping) { this.tables.array_get(rt.new_string('addresses')) } else { this.tables.array_get(rt.new_string(mapping_id)) }
	mut var_join := rt.new_string('')
	mut var_join_on := rt.new_string('')
	var_join = rt.concat(var_join, rt.new_string("INNER JOIN `${var_table.to_string()}`" + if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_alias, var_table)))) { " AS `${var_alias.to_string()}`" } else { '' }))
	if this.mappings.array_get(rt.new_string(mapping_id)).array_isset(rt.new_string('order_id')) {
		var_join_on = rt.concat(var_join_on, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'), this.tables.array_get(rt.new_string('orders'))), rt.new_string('`.id = `')), var_alias), rt.new_string('`.order_id')))
	}
	if rt.is_true(var_is_address_mapping) {
		var_join_on = rt.concat(var_join_on, rt.call_method(var_wpdb, 'prepare', [rt.new_string(" AND `${var_alias.to_string()}`.address_type = %s"), rt.call_function('substr', [rt.new_string(mapping_id), rt.new_int(0), rt.new_int(-8)])]))
	}
	return (var_join).str() + if rt.is_true(var_join_on) { " ON ( ${var_join_on.to_string()} )" } else { '' }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) join(table string, alias string, on string, join_type string, alias_once bool) {
	mut table_mutated := table
	mut alias_mutated := alias
	mut on_mutated := on
	mut join_type_mutated := join_type
	alias_mutated = if alias_mutated == '' { table_mutated } else { alias_mutated }
	join_type_mutated = join_type_mutated.trim_space().to_upper()
	if rt.is_true(rt.identical(this.tables.array_get(rt.new_string('orders')), rt.new_string(alias_mutated))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s can not be used as a table alias in OrdersTableQuery'), rt.new_string('woocommerce')]), rt.new_string(alias_mutated).clone()]))))
	}
	if on_mutated == '' {
		if rt.is_true(rt.identical(this.tables.array_get(rt.new_string('orders')), rt.new_string(table_mutated))) {
		on_mutated = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'), this.tables.array_get(rt.new_string('orders'))), rt.new_string('`.id = `')), rt.new_string(alias_mutated)), rt.new_string('`.id'))
		} else {
		on_mutated = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'), this.tables.array_get(rt.new_string('orders'))), rt.new_string('`.id = `')), rt.new_string(alias_mutated)), rt.new_string('`.order_id'))
		}
	}
	if this.join.array_isset(rt.new_string(alias_mutated)) {
		if !(var_alias_once) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Can not re-use table alias "%s" in OrdersTableQuery.'), rt.new_string('woocommerce')]), rt.new_string(alias_mutated).clone()]))))
		}
		return
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(join_type_mutated))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(join_type_mutated).clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'LEFT' }, rt.ArrayItem{ key: none, val: 'RIGHT' }, rt.ArrayItem{ key: none, val: 'INNER' }]), rt.new_bool(true)]))))) {
	join_type_mutated = 'INNER'
	}
	mut var_sql_join := rt.new_string('')
	var_sql_join = rt.concat(var_sql_join, rt.new_string("${var_join_type.to_string()} JOIN `${var_table.to_string()}` "))
	var_sql_join = rt.concat(var_sql_join, if rt.is_true(rt.new_bool(alias_mutated != table_mutated)) { "AS `${var_alias.to_string()}` " } else { '' })
	var_sql_join = rt.concat(var_sql_join, rt.new_string("ON ( ${var_on.to_string()} )"))
	this.join.array_set(alias_mutated, var_sql_join.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) where(table string, field string, operator string, var_value rt.PhpVal, type string) string {
	mut var_wpdb := rt.new_null()
	mut table_mutated := table
	mut operator_mutated := operator
	mut var_value_mutated := var_value
	mut var_db_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()])
	operator_mutated = if rt.is_true(rt.new_bool('' != operator_mutated)) { operator_mutated } else { '=' }.to_upper()
	mut var_format := rt.call_method(var_db_util, 'get_wpdb_format_for_type', [rt.new_string(type)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_DataStores_Orders_Exception') {
		mut var_e := var_e_1.clone()
		var_format = rt.new_string('%s')
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if var_value_mutated.clone().is_array() && rt.is_true(rt.identical(rt.new_string('='), rt.new_string(operator_mutated))) {
	operator_mutated = 'IN'
	} else if var_value_mutated.clone().is_array() && rt.is_true(rt.identical(rt.new_string('!='), rt.new_string(operator_mutated))) {
	operator_mutated = 'NOT IN'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(operator_mutated).clone(), rt.create_array([rt.ArrayItem{ key: none, val: '=' }, rt.ArrayItem{ key: none, val: '!=' }, rt.ArrayItem{ key: none, val: 'IN' }, rt.ArrayItem{ key: none, val: 'NOT IN' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }]), rt.new_bool(true)]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_array())) {
	var_value_mutated = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: var_db_util }, rt.ArrayItem{ key: none, val: 'format_object_value_for_db' }]), var_value_mutated.clone(), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_value_mutated.clone().array_count()), rt.new_string(type)])])
	} else {
	var_value_mutated = rt.call_method(var_db_util, 'format_object_value_for_db', [var_value_mutated.clone(), rt.new_string(type)])
	}
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_array())) {
	mut var_placeholder := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_value_mutated.clone().array_count()), var_format.clone()])
	var_placeholder = rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), var_placeholder.clone()])).str() + ')')
	} else {
	var_placeholder = var_format.clone()
	}
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [rt.new_string("${var_table.to_string()}.${var_field} ${var_operator.to_string()} ${var_placeholder.to_string()}"), var_value_mutated.clone()])
	return (var_sql).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_orders_table_query_args() {
	this.sanitize_status()
	mut var_fields := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'currency' }, rt.ArrayItem{ key: none, val: 'tax_amount' }, rt.ArrayItem{ key: none, val: 'customer_id' }, rt.ArrayItem{ key: none, val: 'billing_email' }, rt.ArrayItem{ key: none, val: 'parent_order_id' }, rt.ArrayItem{ key: none, val: 'payment_method' }, rt.ArrayItem{ key: none, val: 'payment_method_title' }, rt.ArrayItem{ key: none, val: 'transaction_id' }, rt.ArrayItem{ key: none, val: 'ip_address' }, rt.ArrayItem{ key: none, val: 'user_agent' }]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'arg_isset' }])])
	mut iter_10 := var_fields.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_arg_key := item_10.val
		this.where.array_push(this.where((this.tables.array_get(rt.new_string('orders'))).str(), (var_arg_key).str(), '=', this.args.array_get(var_arg_key), (this.mappings.array_get(rt.new_string('orders')).array_get(var_arg_key).array_get(rt.new_string('type'))).str()))
	}
	if this.args.array_isset(rt.new_string('customer_note')) {
		this.where.array_push(this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'customer_note', '=', this.args.array_get(rt.new_string('customer_note')), (this.mappings.array_get(rt.new_string('orders')).array_get(rt.new_string('customer_note')).array_get(rt.new_string('type'))).str()))
	}
	if this.arg_isset('parent_exclude') {
		this.where.array_push(this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'parent_order_id', '!=', this.args.array_get(rt.new_string('parent_exclude')), 'int'))
	}
	if this.arg_isset('exclude') {
		this.where.array_push(this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'id', '!=', this.args.array_get(rt.new_string('exclude')), 'int'))
	}
	if this.arg_isset('customer') {
		mut var_customer_query := rt.new_string(this.generate_customer_query(this.args.array_get(rt.new_string('customer')), ''))
		if rt.is_true(var_customer_query) {
			this.where.array_push(var_customer_query.clone())
		}
	}
	if this.arg_isset('total_amount') {
		mut var_total_param := this.args.array_get(rt.new_string('total_amount'))
		if rt.is_true(rt.new_bool(var_total_param.clone().is_long() || var_total_param.clone().is_double())) {
		var_total_param = rt.create_array([rt.ArrayItem{ key: 'value', val: var_total_param }, rt.ArrayItem{ key: 'operator', val: '=' }])
		}
		mut var_total_query := rt.new_string(this.generate_total_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.cast_array(var_total_param))))
		if rt.is_true(var_total_query) {
			this.where.array_push(var_total_query.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) generate_customer_query(var_values rt.PhpVal, relation string) string {
	mut var_values_mutated := var_values
	var_values_mutated = if var_values_mutated.clone().is_array() { var_values_mutated } else { rt.create_array([rt.ArrayItem{ key: none, val: var_values_mutated }]) }
	mut var_ids := rt.new_array()
	mut var_emails := rt.new_array()
	mut var_pieces := rt.new_array()
	mut iter_11 := var_values_mutated.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_value := item_11.val
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			mut var_sql := rt.new_string(this.generate_customer_query(var_value.clone(), 'AND'))
			var_pieces.array_push(if rt.is_true(var_sql) { '(' + (var_sql).str() + ')' } else { '' })
		} else if rt.is_true(rt.new_bool(var_value.clone().is_long() || var_value.clone().is_double())) {
			var_ids.array_push(rt.call_function('absint', [var_value.clone()]))
		} else if var_value.clone().is_string() && rt.is_true(rt.call_function('is_email', [var_value.clone()])) {
			var_emails.array_push(rt.call_function('sanitize_email', [var_value.clone()]))
		} else {
			var_pieces.array_push('1=0')
		}
	}
	if rt.is_true(var_ids) {
		var_pieces.array_push(this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'customer_id', '=', var_ids.clone(), 'int'))
	}
	if rt.is_true(var_emails) {
		var_pieces.array_push(this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'billing_email', '=', var_emails.clone(), 'string'))
	}
	return (if rt.is_true(var_pieces) { rt.call_function('implode', [rt.new_string(" ${var_relation} "), var_pieces.clone()]) } else { rt.new_string('') }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) generate_total_query(mut var_total_params Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) string {
	if !(var_total_params.array_isset(rt.new_string('value'))) {
		return ''
	}
	mut var_operator := if !(var_total_params.array_get(rt.new_string('operator'))).is_null() { var_total_params.array_get(rt.new_string('operator')) } else { rt.new_string('=') }
	mut var_value := var_total_params.array_get(rt.new_string('value'))
	mut var_supported_operators := rt.create_array([rt.ArrayItem{ key: none, val: '=' }, rt.ArrayItem{ key: none, val: '!=' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: 'BETWEEN' }, rt.ArrayItem{ key: none, val: 'NOT BETWEEN' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_operator.clone(), var_supported_operators.clone(), rt.new_bool(true)]))))) {
		return ''
	}
	if rt.is_true(rt.identical(rt.new_string('BETWEEN'), var_operator)) || rt.is_true(rt.identical(rt.new_string('NOT BETWEEN'), var_operator)) {
		if !(var_value.clone().is_array()) || rt.is_true(rt.new_bool(var_value.clone().array_count() != 2)) {
			return ''
		}
		mut var_value1 := rt.call_function('wc_format_decimal', [var_value.array_get(rt.new_int(0)), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
		mut var_value2 := rt.call_function('wc_format_decimal', [var_value.array_get(rt.new_int(1)), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
		if rt.is_true(rt.identical(rt.new_string('BETWEEN'), var_operator)) {
			return this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'total_amount', '>=', var_value1.clone(), 'decimal') + ' AND ' + this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'total_amount', '<=', var_value2.clone(), 'decimal')
		} else {
			return '(' + this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'total_amount', '<', var_value1.clone(), 'decimal') + ' OR ' + this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'total_amount', '>', var_value2.clone(), 'decimal') + ')'
		}
	}
	if !(var_value.clone().is_long() || var_value.clone().is_double()) {
		return ''
	}
	return this.where((this.tables.array_get(rt.new_string('orders'))).str(), 'total_amount', (var_operator).str(), rt.call_function('wc_format_decimal', [var_value.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'decimal')
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_operational_data_table_query_args() {
	mut var_fields := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: 'created_via' }, rt.ArrayItem{ key: none, val: 'woocommerce_version' }, rt.ArrayItem{ key: none, val: 'prices_include_tax' }, rt.ArrayItem{ key: none, val: 'order_key' }, rt.ArrayItem{ key: none, val: 'discount_total_amount' }, rt.ArrayItem{ key: none, val: 'discount_tax_amount' }, rt.ArrayItem{ key: none, val: 'shipping_total_amount' }, rt.ArrayItem{ key: none, val: 'shipping_tax_amount' }]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'arg_isset' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields)))) {
		return
	}
	this.join((this.tables.array_get(rt.new_string('operational_data'))).str(), '', '', 'inner', true)
	mut iter_12 := var_fields.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_arg_key := item_12.val
		this.where.array_push(this.where((this.tables.array_get(rt.new_string('operational_data'))).str(), (var_arg_key).str(), '=', this.args.array_get(var_arg_key), (this.mappings.array_get(rt.new_string('operational_data')).array_get(var_arg_key).array_get(rt.new_string('type'))).str()))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_addresses_table_query_args() {
	mut var_wpdb := rt.new_null()
	mut iter_13 := rt.create_array([rt.ArrayItem{ key: none, val: 'billing' }, rt.ArrayItem{ key: none, val: 'shipping' }]).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_address_type := item_13.val
		mut var_fields := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: (var_address_type).str() + '_first_name' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_last_name' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_company' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_address_1' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_address_2' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_city' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_state' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_postcode' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_country' }, rt.ArrayItem{ key: none, val: (var_address_type).str() + '_phone' }]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'arg_isset' }])])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_fields)))) {
			continue
		}
		this.join((this.tables.array_get(rt.new_string('addresses'))).str(), (var_address_type).str(), (rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.tables.array_get(rt.new_string('orders')), rt.new_string('.id = ')), var_address_type), rt.new_string('.order_id AND ')), var_address_type), rt.new_string('.address_type = %s')), var_address_type.clone()])).str(), 'inner', false)
		mut iter_14 := var_fields.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_arg_key := item_14.val
			mut var_column_name := rt.call_function('str_replace', [rt.new_string("${var_address_type.to_string()}_"), rt.new_string(''), var_arg_key.clone()])
			this.where.array_push(this.where((var_address_type).str(), (var_column_name).str(), '=', this.args.array_get(var_arg_key), (this.mappings.array_get(rt.new_string("${var_address_type.to_string()}_address")).array_get(var_column_name).array_get(rt.new_string('type'))).str()))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_orderby() {
	mut var_order := rt.new_string(this.sanitize_order((if !(this.args.array_get(rt.new_string('order'))).is_null() { this.args.array_get(rt.new_string('order')) } else { rt.new_string('') }).str()))
	mut var_orderby := this.sanitize_order_orderby(if !(this.args.array_get(rt.new_string('orderby'))).is_null() { this.args.array_get(rt.new_string('orderby')) } else { rt.new_string('none') })
	this.orderby = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('include'), var_orderby)) || rt.is_true(rt.identical(rt.new_string('post__in'), var_orderby)) {
		mut var_ids := if !(this.args.array_get(rt.new_string('id'))).is_null() { this.args.array_get(rt.new_string('id')) } else { this.args.array_get(rt.new_string('includes')) }
		if !rt.is_true(var_ids) {
			return
		}
		var_ids = rt.call_function('array_map', [rt.new_string('absint'), var_ids.clone()])
		this.orderby = rt.create_array([rt.ArrayItem{ key: none, val: rt.concat(rt.concat(rt.new_string('FIELD( '), this.tables.array_get(rt.new_string('orders'))), rt.new_string('.id, ')) + (rt.call_function('implode', [rt.new_string(','), var_ids.clone()])).str() + ' )' }])
		return
	}
	if rt.is_true(rt.new_bool(var_orderby.clone().is_array())) {
		mut var_meta_orderby_keys := if rt.is_true(this.meta_query) { rt.call_method(this.meta_query, 'get_orderby_keys', []rt.PhpVal{}) } else { rt.new_array() }
		mut var_orderby_array := rt.new_array()
		mut iter_15 := var_orderby.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_order_shadow := item_15.val
			mut var__orderby := item_15.key
			if rt.is_true(rt.call_function('in_array', [var__orderby.clone(), var_meta_orderby_keys.clone(), rt.new_bool(true)])) {
			var__orderby = rt.call_method(this.meta_query, 'get_orderby_clause_for_key', [var__orderby.clone()])
			}
			var_orderby_array.array_push("${var__orderby.to_string()} ${var_order.to_string()}")
		}
		this.orderby = var_orderby_array.clone()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) process_limit() {
	mut var_row_count := if this.arg_isset('limit') { rt.new_int((this.args.array_get(rt.new_string('limit'))).to_i64()) } else { rt.new_bool(false) }
	mut var_page := if this.arg_isset('page') { rt.call_function('absint', [this.args.array_get(rt.new_string('page'))]) } else { rt.new_int(1) }
	mut var_offset := if this.arg_isset('offset') { rt.call_function('absint', [this.args.array_get(rt.new_string('offset'))]) } else { rt.new_bool(false) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_row_count)) || rt.is_true(rt.less(var_row_count, -1)) {
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_offset)) && rt.is_true(rt.greater(var_row_count, -1)) {
	var_offset = rt.new_int((rt.mul(rt.sub(var_page, rt.new_int(1)), var_row_count)).to_i64())
	}
	this.limits = rt.create_array([rt.ArrayItem{ key: none, val: var_offset }, rt.ArrayItem{ key: none, val: var_row_count }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) arg_isset(arg_key string) bool {
	return this.args.array_isset(rt.new_string(arg_key)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.args.array_get(rt.new_string(arg_key)), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery.skipped_values(), rt.new_bool(true)])))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) run_query() {
	mut var_wpdb := rt.new_null()
	this.orders = rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_wpdb, 'get_col', [this.sql])])
	if (this.arg_isset('no_found_rows') && rt.is_true(this.args.array_get(rt.new_string('no_found_rows')))) || !rt.is_true(this.orders) {
		return
	}
	if rt.is_true(this.limits) {
		this.found_orders = rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [this.count_sql])])
		this.max_num_pages = rt.new_int((rt.call_function('ceil', [rt.div(this.found_orders, this.args.array_get(rt.new_string('limit')))])).to_i64())
	} else {
		this.found_orders = rt.new_int(this.orders.array_count())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) magic_get(name string) rt.PhpVal {
	mut switch_val_2 := rt.new_string(name)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('found_orders'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('found_posts'))) {
		return this.found_orders
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('max_num_pages'))) {
		return this.max_num_pages
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('posts'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('orders'))) {
		return this.orders
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('request'))) {
		return this.sql
	} else {
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get(arg_name string) rt.PhpVal {
	return if !(this.args.array_get(rt.new_string(arg_name))).is_null() { this.args.array_get(rt.new_string(arg_name)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_table_name(table_id string) string {
	if !(this.tables.array_isset(rt.new_string(table_id))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid table id: %s.'), rt.new_string('woocommerce')]), rt.new_string(table_id)]))))
	}
	return (this.tables.array_get(rt.new_string(table_id))).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_field_mapping_info(var_field rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'table', val: '' }, rt.ArrayItem{ key: 'mapping_id', val: '' }, rt.ArrayItem{ key: 'field_name', val: '' }, rt.ArrayItem{ key: 'column', val: '' }, rt.ArrayItem{ key: 'column_type', val: '' }])
	mut var_mappings_to_search := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strstr', [var_field.clone(), rt.new_string('.')]))))) {
		mut list_tmp_3 := rt.call_function('explode', [rt.new_string('.'), var_field.clone()])
		mut var_mapping_or_table := (list_tmp_3).array_get(0)
		mut var_field_name_or_col := (list_tmp_3).array_get(1)
		var_mapping_or_table = if rt.is_true(rt.identical(rt.call_function('substr', [var_mapping_or_table.clone(), rt.new_int(0), rt.new_int(rt.get_property(var_wpdb, 'prefix').to_string().len)]), rt.get_property(var_wpdb, 'prefix'))) { rt.call_function('substr', [var_mapping_or_table.clone(), rt.new_int(rt.get_property(var_wpdb, 'prefix').to_string().len)]) } else { var_mapping_or_table }
		var_mapping_or_table = if rt.is_true(rt.identical(rt.new_string('wc_'), rt.call_function('substr', [var_mapping_or_table.clone(), rt.new_int(0), rt.new_int(3)]))) { rt.call_function('substr', [var_mapping_or_table.clone(), rt.new_int(3)]) } else { var_mapping_or_table }
		if this.mappings.array_isset(var_mapping_or_table) {
			if this.mappings.array_get(var_mapping_or_table).array_isset(var_field_name_or_col) {
				var_result.array_set('mapping_id', var_mapping_or_table.clone())
				var_result.array_set('column', var_field_name_or_col.clone())
			} else {
			var_mappings_to_search = rt.create_array([rt.ArrayItem{ key: none, val: var_mapping_or_table }])
			}
		}
	} else {
	var_field_name_or_col = var_field
	var_mappings_to_search = rt.func_array_keys(this.mappings)
	}
	mut iter_16 := var_mappings_to_search.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_mapping_id := item_16.val
		mut iter_17 := this.mappings.array_get(var_mapping_id).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_column_data := item_17.val
			mut var_column_name := item_17.key
			if var_column_data.array_isset(rt.new_string('name')) && rt.is_true(rt.identical(var_column_data.array_get(rt.new_string('name')), var_field_name_or_col)) {
				var_result.array_set('mapping_id', var_mapping_id.clone())
				var_result.array_set('column', var_column_name.clone())
				break
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result.array_get(rt.new_string('mapping_id')))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_result.array_get(rt.new_string('column')))))) {
		return false
	}
	mut var_field_info := this.mappings.array_get(var_result.array_get(rt.new_string('mapping_id'))).array_get(var_result.array_get(rt.new_string('column')))
	var_result.array_set('field_name', var_field_info.array_get(rt.new_string('name')))
	var_result.array_set('column_type', var_field_info.array_get(rt.new_string('type')))
	var_result.array_set('table', if rt.is_true(rt.call_function('in_array', [var_result.array_get(rt.new_string('mapping_id')), rt.create_array([rt.ArrayItem{ key: none, val: 'billing_address' }, rt.ArrayItem{ key: none, val: 'shipping_address' }]), rt.new_bool(true)])) { this.tables.array_get(rt.new_string('addresses')) } else { this.tables.array_get(var_result.array_get(rt.new_string('mapping_id'))) })
	return (var_result).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) get_query_args() rt.PhpVal {
	return this.query_args
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

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WP_Date_Query {
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

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_propertyfetch","line":197,"var":{"nodetype":"expr_variable","line":197,"name":"this"},"name":"order_datastore"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":197,"var":{"nodeType":"Expr_Variable","line":197,"name":"this"},"name":"order_datastore"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablefieldquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablesearchquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablemetaquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wp_date_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WP_Date_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WP_Date_Query{
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
			return this.magic_get(dispatch_arg_0)
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableSearchQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WP_Date_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WP_Date_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WP_Date_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
