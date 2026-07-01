import rt

struct Class_WP_Date_Query {
	rt.PhpObjectBase
pub mut:
		queries rt.PhpVal = rt.new_array()
		relation rt.PhpVal = rt.new_string('AND')
		column rt.PhpVal = rt.new_string('post_date')
		compare rt.PhpVal = rt.new_string('=')
		time_keys rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Date_Query) construct(var_date_query rt.PhpVal, default_column string)  {
	mut var_date_query_mutated := var_date_query
	if rt.is_true(rt.new_bool(!rt.is_true(var_date_query_mutated) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_date_query_mutated.dup().is_array()))))))) {
		return
	}
	if var_date_query_mutated.array_isset(rt.new_string('relation')) {
		this.relation = this.sanitize_relation(var_date_query_mutated.array_get('relation'))
	} else {
		this.relation = rt.new_string('AND')
	}
	if !(var_date_query_mutated.array_isset(rt.new_int(0))) {
		var_date_query_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_date_query_mutated }])
	}
	if !(!rt.is_true(var_date_query_mutated.array_get('column'))) {
		var_date_query_mutated.array_set('column', rt.call_function('esc_sql', [var_date_query_mutated.array_get('column')]))
	} else {
		var_date_query_mutated.array_set('column', rt.call_function('esc_sql', [rt.new_string(default_column)]))
	}
	this.column = this.validate_column(this.column)
	this.compare = this.get_compare(var_date_query_mutated.dup())
	this.queries = this.sanitize_query(var_date_query_mutated.dup(), rt.new_null())
}

fn (mut this Class_WP_Date_Query) sanitize_query(var_queries rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_cleaned_query := rt.new_array()
	mut var_defaults := { 'column': 'post_date', 'compare': '=', 'relation': 'AND' }
	{
		mut iter_1 := var_queries_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_qvalue := item_1.val
			mut var_qkey := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_qkey.dup().is_long() || var_qkey.dup().is_double())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_qvalue.dup().is_array()))))))) {
				var_queries_mutated.array_unset(var_qkey)
			}
		}
	}
	for var_dkey, var_dvalue in var_defaults {
		if var_queries_mutated.array_isset(rt.new_string(dkey)) {
			continue
		}
		var_queries_mutated.array_set(dkey, if !(var_parent_query.array_get(dkey)).is_null() { var_parent_query.array_get(dkey) } else { rt.new_string(dvalue) })
	}
	if this.is_first_order_clause(var_queries_mutated.dup()) {
		this.validate_date_values(var_queries_mutated.dup())
	}
	var_queries_mutated.array_set('relation', this.sanitize_relation(var_queries_mutated.array_get('relation')))
	{
		mut iter_1 := var_queries_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_q := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_q.dup().is_array()))))) || rt.is_true(rt.call_function('in_array', [var_key.dup(), this.time_keys, rt.new_bool(true)])))) {
				var_cleaned_query.array_set(var_key, var_q.dup())
			} else {
				var_cleaned_query.array_push(this.sanitize_query(var_q.dup(), var_queries_mutated.dup()))
			}
		}
	}
	return var_cleaned_query.dup()
}

fn (mut this Class_WP_Date_Query) is_first_order_clause(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
	mut var_time_keys := rt.call_function('array_intersect', [this.time_keys, rt.func_array_keys(var_query_mutated.dup())])
	return !(!rt.is_true(var_time_keys))
}

fn (mut this Class_WP_Date_Query) get_compare(var_query rt.PhpVal) string {
	mut var_query_mutated := var_query
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_query_mutated.array_get('compare'))) && rt.is_true(rt.call_function('in_array', [var_query_mutated.array_get('compare'), rt.create_array([rt.ArrayItem{ key: none, val: '=' }, rt.ArrayItem{ key: none, val: '!=' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: 'IN' }, rt.ArrayItem{ key: none, val: 'NOT IN' }, rt.ArrayItem{ key: none, val: 'BETWEEN' }, rt.ArrayItem{ key: none, val: 'NOT BETWEEN' }]), rt.new_bool(true)])))) {
		return var_query_mutated.array_get('compare').to_string().to_upper()
	}
	return (this.compare).str()
}

fn (mut this Class_WP_Date_Query) validate_date_values(var_date_query rt.PhpVal) bool {
	mut var_date_query_mutated := var_date_query
	if !rt.is_true(var_date_query_mutated) {
		return false
	}
	mut var_valid := rt.new_bool(rt.new_bool(true))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_date_query_mutated.dup().array_isset(rt.new_string('before')))) && rt.is_true(rt.new_bool(var_date_query_mutated.array_get('before').is_array())))) {
		var_valid = rt.new_bool(this.validate_date_values(var_date_query_mutated.array_get('before')))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_date_query_mutated.dup().array_isset(rt.new_string('after')))) && rt.is_true(rt.new_bool(var_date_query_mutated.array_get('after').is_array())))) {
		var_valid = rt.new_bool(this.validate_date_values(var_date_query_mutated.array_get('after')))
	}
	mut var_min_max_checks := rt.new_array()
	if rt.is_true(rt.new_bool(var_date_query_mutated.dup().array_isset(rt.new_string('year')))) {
		if rt.is_true(rt.new_bool(var_date_query_mutated.array_get('year').is_array())) {
			mut var__year := rt.call_function('reset', [var_date_query_mutated.array_get('year')])
		} else {
			var__year = var_date_query_mutated.array_get('year')
		}
		mut var_max_days_of_year := rt.add(// unsupported expression: Expr_Cast_Int, rt.new_int(1))
	} else {
		var_max_days_of_year = rt.new_int(rt.new_int(366))
	}
	var_min_max_checks['dayofyear'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: var_max_days_of_year }])
	var_min_max_checks['dayofweek'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: 7 }])
	var_min_max_checks['dayofweek_iso'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: 7 }])
	var_min_max_checks['month'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: 12 }])
	if !(var__year).is_null() {
		mut var_week_count := rt.call_function('gmdate', [rt.new_string('W'), rt.call_function('mktime', [rt.new_int(0), rt.new_int(0), rt.new_int(0), rt.new_int(12), rt.new_int(28), var__year.dup()])])
	} else {
		var_week_count = rt.new_int(rt.new_int(53))
	}
	var_min_max_checks['week'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: var_week_count }])
	var_min_max_checks['day'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: 31 }])
	var_min_max_checks['hour'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 0 }, rt.ArrayItem{ key: 'max', val: 23 }])
	var_min_max_checks['minute'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 0 }, rt.ArrayItem{ key: 'max', val: 59 }])
	var_min_max_checks['second'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 0 }, rt.ArrayItem{ key: 'max', val: 59 }])
	for var_key, var_check in var_min_max_checks {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_date_query_mutated.dup().array_isset(rt.new_string(key))))))) {
			continue
		}
		{
			mut iter_1 := rt.cast_array(var_date_query_mutated.array_get(key)).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__value := item_1.val
				mut var_is_between := rt.new_bool(rt.new_bool(rt.is_true(rt.greater_equal(var__value, var_check.array_get('min'))) && rt.is_true(rt.less_equal(var__value, var_check.array_get('max')))))
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var__value.dup().is_long() || var__value.dup().is_double()))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_is_between)))))) {
					mut var_error := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid value %1$s for %2$s. Expected value should be between %3$s and %4$s.')]), '<code>' + (rt.call_function('esc_html', [var__value.dup()])).str() + '</code>', '<code>' + (rt.call_function('esc_html', [rt.new_string(key)])).str() + '</code>', '<code>' + (rt.call_function('esc_html', [var_check.array_get('min')])).str() + '</code>', '<code>' + (rt.call_function('esc_html', [var_check.array_get('max')])).str() + '</code>'])
					rt.call_function('_doing_it_wrong', [rt.new_string(@STRUCT), var_error.dup(), rt.new_string('4.1.0')])
					var_valid = rt.new_bool(rt.new_bool(false))
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
		return (var_valid).to_bool()
	}
	mut var_day_month_year_error_msg := rt.new_string(rt.new_string(''))
	mut var_day_exists := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_date_query_mutated.dup().array_isset(rt.new_string('day')))) && rt.is_true(rt.new_bool(var_date_query_mutated.array_get('day').is_long() || var_date_query_mutated.array_get('day').is_double()))))
	mut var_month_exists := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_date_query_mutated.dup().array_isset(rt.new_string('month')))) && rt.is_true(rt.new_bool(var_date_query_mutated.array_get('month').is_long() || var_date_query_mutated.array_get('month').is_double()))))
	mut var_year_exists := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_date_query_mutated.dup().array_isset(rt.new_string('year')))) && rt.is_true(rt.new_bool(var_date_query_mutated.array_get('year').is_long() || var_date_query_mutated.array_get('year').is_double()))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_day_exists) && rt.is_true(var_month_exists))) && rt.is_true(var_year_exists))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_checkdate', [var_date_query_mutated.array_get('month'), var_date_query_mutated.array_get('day'), var_date_query_mutated.array_get('year'), rt.call_function('sprintf', [rt.new_string('%s-%s-%s'), var_date_query_mutated.array_get('year'), var_date_query_mutated.array_get('month'), var_date_query_mutated.array_get('day')])]))))) {
			var_day_month_year_error_msg = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The following values do not describe a valid date: year %1$s, month %2$s, day %3$s.')]), '<code>' + (rt.call_function('esc_html', [var_date_query_mutated.array_get('year')])).str() + '</code>', '<code>' + (rt.call_function('esc_html', [var_date_query_mutated.array_get('month')])).str() + '</code>', '<code>' + (rt.call_function('esc_html', [var_date_query_mutated.array_get('day')])).str() + '</code>'])
			var_valid = rt.new_bool(rt.new_bool(false))
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(var_day_exists) && rt.is_true(var_month_exists))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_checkdate', [var_date_query_mutated.array_get('month'), var_date_query_mutated.array_get('day'), rt.new_int(2012), rt.call_function('sprintf', [rt.new_string('2012-%s-%s'), var_date_query_mutated.array_get('month'), var_date_query_mutated.array_get('day')])]))))) {
			var_day_month_year_error_msg = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The following values do not describe a valid date: month %1$s, day %2$s.')]), '<code>' + (rt.call_function('esc_html', [var_date_query_mutated.array_get('month')])).str() + '</code>', '<code>' + (rt.call_function('esc_html', [var_date_query_mutated.array_get('day')])).str() + '</code>'])
			var_valid = rt.new_bool(rt.new_bool(false))
		}
	}
	if !(!rt.is_true(var_day_month_year_error_msg)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@STRUCT), var_day_month_year_error_msg.dup(), rt.new_string('4.1.0')])
	}
	return (var_valid).to_bool()
}

fn (mut this Class_WP_Date_Query) validate_column(var_column rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_column_mutated := var_column
	// unsupported statement: Stmt_Global
	mut var_valid_columns := rt.create_array([rt.ArrayItem{ key: none, val: 'post_date' }, rt.ArrayItem{ key: none, val: 'post_date_gmt' }, rt.ArrayItem{ key: none, val: 'post_modified' }, rt.ArrayItem{ key: none, val: 'post_modified_gmt' }, rt.ArrayItem{ key: none, val: 'comment_date' }, rt.ArrayItem{ key: none, val: 'comment_date_gmt' }, rt.ArrayItem{ key: none, val: 'user_registered' }])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_valid_columns = rt.call_function('array_merge', [var_valid_columns.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'registered' }, rt.ArrayItem{ key: none, val: 'last_updated' }])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_column_mutated.dup(), rt.new_string('.')]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_column_mutated.dup(), rt.call_function('apply_filters', [rt.new_string('date_query_valid_columns'), var_valid_columns.dup()]), rt.new_bool(true)]))))) {
			var_column_mutated = rt.new_string(rt.new_string('post_date'))
		}
		mut var_known_columns := rt.create_array([rt.ArrayItem{ key: rt.get_property(var_wpdb, 'posts'), val: rt.create_array([rt.ArrayItem{ key: none, val: 'post_date' }, rt.ArrayItem{ key: none, val: 'post_date_gmt' }, rt.ArrayItem{ key: none, val: 'post_modified' }, rt.ArrayItem{ key: none, val: 'post_modified_gmt' }]) }, rt.ArrayItem{ key: rt.get_property(var_wpdb, 'comments'), val: rt.create_array([rt.ArrayItem{ key: none, val: 'comment_date' }, rt.ArrayItem{ key: none, val: 'comment_date_gmt' }]) }, rt.ArrayItem{ key: rt.get_property(var_wpdb, 'users'), val: rt.create_array([rt.ArrayItem{ key: none, val: 'user_registered' }]) }])
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_known_columns.array_set(rt.get_property(var_wpdb, 'blogs'), rt.create_array([rt.ArrayItem{ key: none, val: 'registered' }, rt.ArrayItem{ key: none, val: 'last_updated' }]))
		}
		{
			mut iter_1 := var_known_columns.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_table_columns := item_1.val
				mut var_table_name := item_1.key
				if rt.is_true(rt.call_function('in_array', [var_column_mutated.dup(), var_table_columns.dup(), rt.new_bool(true)])) {
					var_column_mutated = rt.new_string((var_table_name).str() + '.' + (var_column_mutated).str())
					break
				}
			}
		}
	}
	return rt.call_function('preg_replace', [rt.new_string('/[^a-zA-Z0-9_$\\.]/'), rt.new_string(''), var_column_mutated.dup()])
}

fn (mut this Class_WP_Date_Query) get_sql() rt.PhpVal {
	mut var_sql := this.get_sql_clauses()
	mut var_where := var_sql.array_get('where')
	return rt.call_function('apply_filters', [rt.new_string('get_date_sql'), var_where.dup(), rt.new_object('WP_Date_Query', []string{}, &this)])
}

fn (mut this Class_WP_Date_Query) get_sql_clauses() rt.PhpVal {
	mut var_sql := this.get_sql_for_query(this.queries, 0)
	if !(!rt.is_true(var_sql.array_get('where'))) {
		var_sql.array_set('where', ' AND ' + (var_sql.array_get('where')).str())
	}
	return var_sql.dup()
}

fn (mut this Class_WP_Date_Query) get_sql_for_query(var_query rt.PhpVal, depth i64) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_sql_chunks := { 'join': rt.new_array(), 'where': rt.new_array() }
	mut var_sql := rt.create_array([rt.ArrayItem{ key: 'join', val: '' }, rt.ArrayItem{ key: 'where', val: '' }])
	mut var_indent := rt.new_string(rt.new_string(''))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(depth)))) { break }
			// unsupported expression: Expr_AssignOp_Concat
			rt.post_inc(var_i)
		}
	}
	{
		mut iter_1 := var_query_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_clause := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
				mut var_relation := var_query_mutated.array_get('relation')
			} else if rt.is_true(rt.new_bool(var_clause.dup().is_array())) {
				if this.is_first_order_clause(var_clause.dup()) {
					mut var_clause_sql := this.get_sql_for_clause(var_clause.dup(), var_query_mutated.dup())
					mut var_where_count := rt.new_int(rt.new_int(var_clause_sql.array_get('where').array_count()))
					if rt.is_true(rt.new_bool(!(rt.is_true(var_where_count)))) {
						var_sql_chunks.array_get_mut('where').array_push('')
					} else if rt.is_true(rt.identical(rt.new_int(1), var_where_count)) {
						var_sql_chunks.array_get_mut('where').array_push(var_clause_sql.array_get('where').array_get(0))
					} else {
						var_sql_chunks.array_get_mut('where').array_push('( ' + (rt.call_function('implode', [, ])).str() + ' )')
					}
					var_sql_chunks['join'] = rt.call_function('array_merge', [var_sql_chunks.array_get('join'), var_clause_sql.array_get('join')])
					// unsupported statement: Stmt_Nop
				} else {
					var_clause_sql = this.get_sql_for_query(.dup(), )
					.array_get_mut().array_push()
					
				}
			}
		}
	}
	[] = 
	
}

fn (mut this Class_WP_Date_Query) get_sql_for_subquery(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_WP_Date_Query) get_sql_for_clause(var_query rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
}

fn (mut this Class_WP_Date_Query) build_value(var_compare rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_compare_mutated := var_compare
	mut var_value_mutated := var_value
	return false
}

fn (mut this Class_WP_Date_Query) build_mysql_datetime(var_datetime rt.PhpVal, default_to_max bool) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_datetime_mutated := var_datetime
}

fn (mut this Class_WP_Date_Query) build_time_query(var_column rt.PhpVal, var_compare rt.PhpVal, var_hour rt.PhpVal, var_minute rt.PhpVal, var_second rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_column_mutated := var_column
	mut var_compare_mutated := var_compare
}

fn (mut this Class_WP_Date_Query) sanitize_relation(var_relation rt.PhpVal) string {
	mut var_relation_mutated := var_relation
	return ''
}

fn create_wp_date_query(default_column string, arg_1 rt.PhpVal) &Class_WP_Date_Query {
	mut obj := &Class_WP_Date_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		queries: rt.new_array()
		relation: rt.new_string('AND')
		column: rt.new_string('post_date')
		compare: rt.new_string('=')
		time_keys: rt.new_array()
	}
	obj.construct(default_column, arg_1)
	return obj
}

fn (mut this Class_WP_Date_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'sanitize_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sanitize_query(dispatch_arg_0, dispatch_arg_1)
		}
		'is_first_order_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_first_order_clause(dispatch_arg_0))
		}
		'get_compare' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_compare(dispatch_arg_0))
		}
		'validate_date_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_date_values(dispatch_arg_0))
		}
		'validate_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_column(dispatch_arg_0)
		}
		'get_sql' {
			return this.get_sql()
		}
		'get_sql_clauses' {
			return this.get_sql_clauses()
		}
		'get_sql_for_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_sql_for_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_sql_for_subquery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_sql_for_subquery(dispatch_arg_0)
		}
		'get_sql_for_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_sql_for_clause(dispatch_arg_0, dispatch_arg_1)
		}
		'build_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.build_value(dispatch_arg_0, dispatch_arg_1))
		}
		'build_mysql_datetime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.build_mysql_datetime(dispatch_arg_0, dispatch_arg_1)
		}
		'build_time_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.build_time_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'sanitize_relation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.sanitize_relation(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Date_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queries' { return this.queries }
		'relation' { return this.relation }
		'column' { return this.column }
		'compare' { return this.compare }
		'time_keys' { return this.time_keys }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Date_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queries' { this.queries = val; return true }
		'relation' { this.relation = val; return true }
		'column' { this.column = val; return true }
		'compare' { this.compare = val; return true }
		'time_keys' { this.time_keys = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_date_query_php() {
}
