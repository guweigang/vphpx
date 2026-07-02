import rt

struct Class_WP_Date_Query {
	rt.PhpObjectBase
pub mut:
	queries   rt.PhpVal = rt.new_array()
	relation  rt.PhpVal = rt.new_string('AND')
	column    rt.PhpVal = rt.new_string('post_date')
	compare   rt.PhpVal = rt.new_string('=')
	time_keys rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Date_Query) construct(var_date_query rt.PhpVal, default_column string) {
	mut var_date_query_mutated := var_date_query
	if !rt.is_true(var_date_query_mutated) || !(var_date_query_mutated.clone().is_array()) {
		return
	}
	if var_date_query_mutated.array_isset(rt.new_string('relation')) {
		this.relation =
			this.sanitize_relation(var_date_query_mutated.array_get(rt.new_string('relation')))
	} else {
		this.relation = rt.new_string('AND')
	}
	if !(var_date_query_mutated.array_isset(rt.new_int(0))) {
		var_date_query_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_date_query_mutated },
		])
	}
	if !(!rt.is_true(var_date_query_mutated.array_get(rt.new_string('column')))) {
		var_date_query_mutated.array_set('column', rt.call_function('esc_sql', [
			var_date_query_mutated.array_get(rt.new_string('column')),
		]))
	} else {
		var_date_query_mutated.array_set('column', rt.call_function('esc_sql', [
			rt.new_string(default_column),
		]))
	}
	this.column = this.validate_column(this.column)
	this.compare = this.get_compare(var_date_query_mutated.clone())
	this.queries = this.sanitize_query(var_date_query_mutated.clone(), rt.new_null())
}

fn (mut this Class_WP_Date_Query) sanitize_query(var_queries rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_cleaned_query := rt.new_array()
	mut var_defaults := {
		'column':   'post_date'
		'compare':  '='
		'relation': 'AND'
	}
	mut iter_1 := var_queries_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_qvalue := item_1.val
		mut var_qkey := item_1.key
		if var_qkey.clone().is_long() || var_qkey.clone().is_double()
			&& !(var_qvalue.clone().is_array()) {
			var_queries_mutated.array_unset(var_qkey)
		}
	}
	for var_dkey, var_dvalue in var_defaults {
		if var_queries_mutated.array_isset(rt.new_string(dkey)) {
			continue
		}
		var_queries_mutated.array_set(dkey, if !(var_parent_query.array_get(rt.new_string(dkey))).is_null() {
			var_parent_query.array_get(rt.new_string(dkey))
		} else {
			rt.new_string(dvalue)
		})
	}
	if this.is_first_order_clause(var_queries_mutated.clone()) {
		this.validate_date_values(var_queries_mutated.clone())
	}
	var_queries_mutated.array_set('relation',
		this.sanitize_relation(var_queries_mutated.array_get(rt.new_string('relation'))))
	mut iter_2 := var_queries_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_q := item_2.val
		mut var_key := item_2.key
		if !(var_q.clone().is_array())
			|| rt.is_true(rt.call_function('in_array', [var_key.clone(), this.time_keys, rt.new_bool(true)])) {
			var_cleaned_query.array_set(var_key, var_q.clone())
		} else {
			var_cleaned_query.array_push(this.sanitize_query(var_q.clone(),
				var_queries_mutated.clone()))
		}
	}
	return var_cleaned_query.clone()
}

fn (mut this Class_WP_Date_Query) is_first_order_clause(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
	mut var_time_keys := rt.call_function('array_intersect', [this.time_keys,
		rt.func_array_keys(var_query_mutated.clone())])
	return !(!rt.is_true(var_time_keys))
}

fn (mut this Class_WP_Date_Query) get_compare(var_query rt.PhpVal) string {
	mut var_query_mutated := var_query
	if !(!rt.is_true(var_query_mutated.array_get(rt.new_string('compare'))))
		&& rt.is_true(rt.call_function('in_array', [var_query_mutated.array_get(rt.new_string('compare')), rt.create_array([rt.ArrayItem{
		key: none
		val: '='
	}, rt.ArrayItem{ key: none, val: '!=' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{
		key: none
		val: '>='
	}, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{
		key: none
		val: 'IN'
	}, rt.ArrayItem{ key: none, val: 'NOT IN' }, rt.ArrayItem{ key: none, val: 'BETWEEN' }, rt.ArrayItem{
		key: none
		val: 'NOT BETWEEN'
	}]), rt.new_bool(true)])) {
		return var_query_mutated.array_get(rt.new_string('compare')).to_string().to_upper()
	}
	return (this.compare).str()
}

fn (mut this Class_WP_Date_Query) validate_date_values(var_date_query rt.PhpVal) bool {
	mut var_date_query_mutated := var_date_query
	if !rt.is_true(var_date_query_mutated) {
		return false
	}
	mut var_valid := rt.new_bool(true)
	if rt.is_true(rt.new_bool(var_date_query_mutated.clone().array_isset(rt.new_string('before'))))
		&& var_date_query_mutated.array_get(rt.new_string('before')).is_array() {
		var_valid =
			rt.new_bool(this.validate_date_values(var_date_query_mutated.array_get(rt.new_string('before'))))
	}
	if rt.is_true(rt.new_bool(var_date_query_mutated.clone().array_isset(rt.new_string('after'))))
		&& var_date_query_mutated.array_get(rt.new_string('after')).is_array() {
		var_valid =
			rt.new_bool(this.validate_date_values(var_date_query_mutated.array_get(rt.new_string('after'))))
	}
	mut var_min_max_checks := rt.new_array()
	if rt.is_true(rt.new_bool(var_date_query_mutated.clone().array_isset(rt.new_string('year')))) {
		if rt.is_true(rt.new_bool(var_date_query_mutated.array_get(rt.new_string('year')).is_array())) {
			mut var__year := rt.call_function('reset', [
				var_date_query_mutated.array_get(rt.new_string('year')),
			])
		} else {
			var__year = var_date_query_mutated.array_get(rt.new_string('year'))
		}
		mut var_max_days_of_year :=
			rt.new_int((rt.call_function('gmdate', [rt.new_string('z'), rt.call_function('mktime', [rt.new_int(0), rt.new_int(0), rt.new_int(0), rt.new_int(12), rt.new_int(31), var__year.clone()])])).to_i64()) +
			1
	} else {
		var_max_days_of_year = rt.new_int(366)
	}
	var_min_max_checks['dayofyear'] = rt.create_array([
		rt.ArrayItem{ key: 'min', val: 1 },
		rt.ArrayItem{ key: 'max', val: var_max_days_of_year },
	])
	var_min_max_checks['dayofweek'] = rt.create_array([
		rt.ArrayItem{ key: 'min', val: 1 },
		rt.ArrayItem{ key: 'max', val: 7 },
	])
	var_min_max_checks['dayofweek_iso'] = rt.create_array([
		rt.ArrayItem{ key: 'min', val: 1 },
		rt.ArrayItem{ key: 'max', val: 7 },
	])
	var_min_max_checks['month'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 },
		rt.ArrayItem{ key: 'max', val: 12 }])
	if !var__year.is_null() {
		mut var_week_count := rt.call_function('gmdate', [rt.new_string('W'),
			rt.call_function('mktime', [rt.new_int(0), rt.new_int(0),
				rt.new_int(0), rt.new_int(12), rt.new_int(28),
				var__year.clone()])])
	} else {
		var_week_count = rt.new_int(53)
	}
	var_min_max_checks['week'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 },
		rt.ArrayItem{ key: 'max', val: var_week_count }])
	var_min_max_checks['day'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 1 },
		rt.ArrayItem{ key: 'max', val: 31 }])
	var_min_max_checks['hour'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 0 },
		rt.ArrayItem{ key: 'max', val: 23 }])
	var_min_max_checks['minute'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 0 },
		rt.ArrayItem{ key: 'max', val: 59 }])
	var_min_max_checks['second'] = rt.create_array([rt.ArrayItem{ key: 'min', val: 0 },
		rt.ArrayItem{ key: 'max', val: 59 }])
	for var_key, var_check in var_min_max_checks {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_date_query_mutated.clone().array_isset(rt.new_string(key))))))) {
			continue
		}
		mut iter_3 := rt.cast_array(var_date_query_mutated.array_get(rt.new_string(key))).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var__value := item_3.val
			mut var_is_between := rt.new_bool(
				rt.is_true(rt.greater_equal(var__value, var_check.array_get(rt.new_string('min'))))
				&& rt.is_true(rt.less_equal(var__value, var_check.array_get(rt.new_string('max')))))
			if !(var__value.clone().is_long() || var__value.clone().is_double())
				|| rt.is_true(rt.new_bool(!(rt.is_true(var_is_between)))) {
				mut var_error := rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Invalid value %1$s for %2$s. Expected value should be between %3$s and %4$s.'),
					]),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [var__value.clone()])).str() + '</code>'),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [rt.new_string(key)])).str() + '</code>'),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [var_check.array_get(rt.new_string('min'))])).str() +
						'</code>'),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [var_check.array_get(rt.new_string('max'))])).str() +
						'</code>'),
				])
				rt.call_function('_doing_it_wrong', [rt.new_string(@STRUCT),
					var_error.clone(), rt.new_string('4.1.0')])
				var_valid = rt.new_bool(false)
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
		return var_valid.to_bool()
	}
	mut var_day_month_year_error_msg := rt.new_string('')
	mut var_day_exists := rt.new_bool(
		rt.is_true(rt.new_bool(var_date_query_mutated.clone().array_isset(rt.new_string('day'))))
		&& var_date_query_mutated.array_get(rt.new_string('day')).is_long()
		|| var_date_query_mutated.array_get(rt.new_string('day')).is_double())
	mut var_month_exists := rt.new_bool(
		rt.is_true(rt.new_bool(var_date_query_mutated.clone().array_isset(rt.new_string('month'))))
		&& var_date_query_mutated.array_get(rt.new_string('month')).is_long()
		|| var_date_query_mutated.array_get(rt.new_string('month')).is_double())
	mut var_year_exists := rt.new_bool(
		rt.is_true(rt.new_bool(var_date_query_mutated.clone().array_isset(rt.new_string('year'))))
		&& var_date_query_mutated.array_get(rt.new_string('year')).is_long()
		|| var_date_query_mutated.array_get(rt.new_string('year')).is_double())
	if rt.is_true(var_day_exists) && rt.is_true(var_month_exists) && rt.is_true(var_year_exists) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_checkdate', [
			var_date_query_mutated.array_get(rt.new_string('month')),
			var_date_query_mutated.array_get(rt.new_string('day')),
			var_date_query_mutated.array_get(rt.new_string('year')),
			rt.call_function('sprintf', [rt.new_string('%s-%s-%s'),
				var_date_query_mutated.array_get(rt.new_string('year')),
				var_date_query_mutated.array_get(rt.new_string('month')),
				var_date_query_mutated.array_get(rt.new_string('day'))]),
		])))))
		{
			var_day_month_year_error_msg = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The following values do not describe a valid date: year %1$s, month %2$s, day %3$s.'),
				]),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_date_query_mutated.array_get(rt.new_string('year'))])).str() +
					'</code>'),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_date_query_mutated.array_get(rt.new_string('month'))])).str() +
					'</code>'),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_date_query_mutated.array_get(rt.new_string('day'))])).str() +
					'</code>'),
			])
			var_valid = rt.new_bool(false)
		}
	} else if rt.is_true(var_day_exists) && rt.is_true(var_month_exists) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_checkdate', [
			var_date_query_mutated.array_get(rt.new_string('month')),
			var_date_query_mutated.array_get(rt.new_string('day')),
			rt.new_int(2012),
			rt.call_function('sprintf', [rt.new_string('2012-%s-%s'),
				var_date_query_mutated.array_get(rt.new_string('month')),
				var_date_query_mutated.array_get(rt.new_string('day'))]),
		])))))
		{
			var_day_month_year_error_msg = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The following values do not describe a valid date: month %1$s, day %2$s.'),
				]),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_date_query_mutated.array_get(rt.new_string('month'))])).str() +
					'</code>'),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_date_query_mutated.array_get(rt.new_string('day'))])).str() +
					'</code>'),
			])
			var_valid = rt.new_bool(false)
		}
	}
	if !(!rt.is_true(var_day_month_year_error_msg)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@STRUCT),
			var_day_month_year_error_msg.clone(), rt.new_string('4.1.0')])
	}
	return var_valid.to_bool()
}

fn (mut this Class_WP_Date_Query) validate_column(var_column rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_column_mutated := var_column
	mut var_valid_columns := rt.create_array([
		rt.ArrayItem{ key: none, val: 'post_date' },
		rt.ArrayItem{ key: none, val: 'post_date_gmt' },
		rt.ArrayItem{ key: none, val: 'post_modified' },
		rt.ArrayItem{ key: none, val: 'post_modified_gmt' },
		rt.ArrayItem{ key: none, val: 'comment_date' },
		rt.ArrayItem{ key: none, val: 'comment_date_gmt' },
		rt.ArrayItem{ key: none, val: 'user_registered' },
	])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_valid_columns = rt.call_function('array_merge', [
			var_valid_columns.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'registered' },
				rt.ArrayItem{ key: none, val: 'last_updated' },
			])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_column_mutated.clone(), rt.new_string('.')])))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_column_mutated.clone(),
			rt.call_function('apply_filters', [
				rt.new_string('date_query_valid_columns'),
				var_valid_columns.clone(),
			]),
			rt.new_bool(true)])))))
		{
			var_column_mutated = rt.new_string('post_date')
		}
		mut var_known_columns := rt.create_array([
			rt.ArrayItem{ key: rt.get_property(var_wpdb, 'posts'), val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'post_date' },
				rt.ArrayItem{ key: none, val: 'post_date_gmt' },
				rt.ArrayItem{ key: none, val: 'post_modified' },
				rt.ArrayItem{ key: none, val: 'post_modified_gmt' },
			]) },
			rt.ArrayItem{ key: rt.get_property(var_wpdb, 'comments'), val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'comment_date' },
				rt.ArrayItem{ key: none, val: 'comment_date_gmt' },
			]) },
			rt.ArrayItem{ key: rt.get_property(var_wpdb, 'users'), val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'user_registered' },
			]) },
		])
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_known_columns.array_set(rt.get_property(var_wpdb, 'blogs'), rt.create_array([
				rt.ArrayItem{ key: none, val: 'registered' },
				rt.ArrayItem{ key: none, val: 'last_updated' },
			]))
		}
		mut iter_4 := var_known_columns.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_table_columns := item_4.val
			mut var_table_name := item_4.key
			if rt.is_true(rt.call_function('in_array', [var_column_mutated.clone(),
				var_table_columns.clone(), rt.new_bool(true)]))
			{
				var_column_mutated = rt.new_string(var_table_name.str() + '.' +
					var_column_mutated.str())
				break
			}
		}
	}
	return rt.call_function('preg_replace', [rt.new_string('/[^a-zA-Z0-9_$\\.]/'),
		rt.new_string(''), var_column_mutated.clone()])
}

fn (mut this Class_WP_Date_Query) get_sql() rt.PhpVal {
	mut var_sql := this.get_sql_clauses()
	mut var_where := var_sql.array_get(rt.new_string('where'))
	return rt.call_function('apply_filters', [rt.new_string('get_date_sql'),
		var_where.clone(), rt.new_object('WP_Date_Query', []string{}, &this)])
}

fn (mut this Class_WP_Date_Query) get_sql_clauses() rt.PhpVal {
	mut var_sql := this.get_sql_for_query(this.queries, 0)
	if !(!rt.is_true(var_sql.array_get(rt.new_string('where')))) {
		var_sql.array_set('where', ' AND ' + (var_sql.array_get(rt.new_string('where'))).str())
	}
	return var_sql.clone()
}

fn (mut this Class_WP_Date_Query) get_sql_for_query(var_query rt.PhpVal, depth i64) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_sql_chunks := {
		'join':  rt.new_array()
		'where': rt.new_array()
	}
	mut var_sql := rt.create_array([rt.ArrayItem{ key: 'join', val: '' },
		rt.ArrayItem{ key: 'where', val: '' }])
	mut var_indent := rt.new_string('')
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(depth)))) { break
		 }
		var_indent = rt.concat(var_indent, rt.new_string('  '))
		rt.post_inc(var_i)
	}
	mut iter_5 := var_query_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_clause := item_5.val
		mut var_key := item_5.key
		if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
			mut var_relation := var_query_mutated.array_get(rt.new_string('relation'))
		} else if rt.is_true(rt.new_bool(var_clause.clone().is_array())) {
			if this.is_first_order_clause(var_clause.clone()) {
				mut var_clause_sql := this.get_sql_for_clause(var_clause.clone(),
					var_query_mutated.clone())
				mut var_where_count :=
					rt.new_int(var_clause_sql.array_get(rt.new_string('where')).array_count())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_where_count)))) {
					var_sql_chunks.array_get_mut('where').array_push('')
				} else if rt.is_true(rt.identical(rt.new_int(1), var_where_count)) {
					var_sql_chunks.array_get_mut('where').array_push(var_clause_sql.array_get(rt.new_string('where')).array_get(rt.new_int(0)))
				} else {
					var_sql_chunks.array_get_mut('where').array_push('( ' +
						(rt.call_function('implode', [rt.new_string(' AND '), var_clause_sql.array_get(rt.new_string('where'))])).str() +
						' )')
				}
				var_sql_chunks['join'] = rt.call_function('array_merge', [var_sql_chunks['join'],
					var_clause_sql.array_get(rt.new_string('join'))])
			} else {
				var_clause_sql = this.get_sql_for_query(var_clause.clone(), depth + 1)
				var_sql_chunks.array_get_mut('where').array_push(var_clause_sql.array_get(rt.new_string('where')))
				var_sql_chunks.array_get_mut('join').array_push(var_clause_sql.array_get(rt.new_string('join')))
			}
		}
	}
	var_sql_chunks['join'] = rt.call_function('array_filter', [var_sql_chunks['join']])
	var_sql_chunks['where'] = rt.call_function('array_filter', [var_sql_chunks['where']])
	if !rt.is_true(var_relation) {
		mut var_relation := rt.new_string('AND')
	}
	if !(!rt.is_true(var_sql_chunks['join'])) {
		var_sql.array_set('join', rt.call_function('implode', [
			rt.new_string(' '), rt.call_function('array_unique', [var_sql_chunks['join']])]))
	}
	if !(!rt.is_true(var_sql_chunks['where'])) {
		var_sql.array_set('where', '( ' + '\n  ' + var_indent.str() +
			(rt.call_function('implode', [rt.new_string(' ' + '\n  ' + var_indent.str() +
			var_relation.str() + ' ' + '\n  ' +
			var_indent.str()), var_sql_chunks['where']])).str() + '\n' + var_indent.str() + ')')
	}
	return var_sql.clone()
}

fn (mut this Class_WP_Date_Query) get_sql_for_subquery(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	return this.get_sql_for_clause(var_query_mutated.clone(), rt.new_string(''))
}

fn (mut this Class_WP_Date_Query) get_sql_for_clause(var_query rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	mut var_where_parts := rt.new_array()
	mut var_column := if !(!rt.is_true(var_query_mutated.array_get(rt.new_string('column')))) { rt.call_function('esc_sql', [
			var_query_mutated.array_get(rt.new_string('column')),
		]) } else { this.column }
	var_column = this.validate_column(var_column.clone())
	mut var_compare := rt.new_string(this.get_compare(var_query_mutated.clone()))
	mut var_inclusive :=
		rt.new_bool(!(!rt.is_true(var_query_mutated.array_get(rt.new_string('inclusive')))))
	mut var_lt := rt.new_string('<')
	mut var_gt := rt.new_string('>')
	if rt.is_true(var_inclusive) {
		var_lt = rt.concat(var_lt, rt.new_string('='))
		var_gt = rt.concat(var_gt, rt.new_string('='))
	}
	if !(!rt.is_true(var_query_mutated.array_get(rt.new_string('after')))) {
		var_where_parts << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('${var_column.to_string()} ${var_gt.to_string()} %s'),
			this.build_mysql_datetime(var_query_mutated.array_get(rt.new_string('after')),
				!(rt.is_true(var_inclusive))),
		])
	}
	if !(!rt.is_true(var_query_mutated.array_get(rt.new_string('before')))) {
		var_where_parts << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('${var_column.to_string()} ${var_lt.to_string()} %s'),
			this.build_mysql_datetime(var_query_mutated.array_get(rt.new_string('before')),
				var_inclusive.to_bool()),
		])
	}
	mut var_date_units := {
		'YEAR':           map[string]rt.PhpVal{}
		'MONTH':          map[string]rt.PhpVal{}
		'_wp_mysql_week': map[string]rt.PhpVal{}
		'DAYOFYEAR':      map[string]rt.PhpVal{}
		'DAYOFMONTH':     map[string]rt.PhpVal{}
		'DAYOFWEEK':      map[string]rt.PhpVal{}
		'WEEKDAY':        map[string]rt.PhpVal{}
	}
	for var_sql_part, var_query_parts in var_date_units {
		mut iter_6 := var_query_parts.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_query_part := item_6.val
			if var_query_mutated.array_isset(var_query_part) {
				mut var_value := this.build_value(var_compare.clone(),
					var_query_mutated.array_get(var_query_part))
				if rt.is_true(var_value) {
					mut switch_val_1 := rt.new_string(sql_part)
					if rt.is_true(rt.equal(switch_val_1, rt.new_string('_wp_mysql_week'))) {
						var_where_parts <<
							(rt.call_function('_wp_mysql_week', [var_column.clone()])).str() +
							' ${var_compare.to_string()} ${var_value.to_string()}'
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('WEEKDAY'))) {
						var_where_parts << rt.new_string('${var_sql_part}( ${var_column.to_string()} ) + 1 ${var_compare.to_string()} ${var_value.to_string()}')
					} else {
						var_where_parts << rt.new_string('${var_sql_part}( ${var_column.to_string()} ) ${var_compare.to_string()} ${var_value.to_string()}')
					}
					break
				}
			}
		}
	}
	if var_query_mutated.array_isset(rt.new_string('hour'))
		|| var_query_mutated.array_isset(rt.new_string('minute'))
		|| var_query_mutated.array_isset(rt.new_string('second')) {
		mut iter_7 := rt.create_array([rt.ArrayItem{ key: none, val: 'hour' },
			rt.ArrayItem{ key: none, val: 'minute' }, rt.ArrayItem{ key: none, val: 'second' }]).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_unit := item_7.val
			if !(var_query_mutated.array_isset(var_unit)) {
				var_query_mutated.array_set(var_unit, rt.new_null())
			}
		}
		mut var_time_query := this.build_time_query(var_column.clone(), var_compare.clone(),
			var_query_mutated.array_get(rt.new_string('hour')),
			var_query_mutated.array_get(rt.new_string('minute')),
			var_query_mutated.array_get(rt.new_string('second')))
		if rt.is_true(var_time_query) {
			var_where_parts << var_time_query.clone()
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'where', val: var_where_parts },
		rt.ArrayItem{ key: 'join', val: rt.new_array() }])
}

fn (mut this Class_WP_Date_Query) build_value(var_compare rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_compare_mutated := var_compare
	mut var_value_mutated := var_value
	if !(!var_value_mutated.is_null()) {
		return rt.new_bool(false)
	}
	mut switch_val_2 := var_compare_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('IN')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('NOT IN'))) {
		var_value_mutated = rt.cast_array(var_value_mutated)
		var_value_mutated = rt.call_function('array_filter', [
			var_value_mutated.clone(), rt.new_string('is_numeric')])
		if !rt.is_true(var_value_mutated) {
			return rt.new_bool(false)
		}
		return rt.new_string('(' +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('intval'), var_value_mutated.clone()])])).str() +
			')')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('BETWEEN')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('NOT BETWEEN'))) {
		if !(var_value_mutated.clone().is_array())
			|| rt.is_true(rt.new_bool(2 != var_value_mutated.clone().array_count())) {
			var_value_mutated = rt.create_array([
				rt.ArrayItem{ key: none, val: var_value_mutated },
				rt.ArrayItem{ key: none, val: var_value_mutated },
			])
		} else {
			var_value_mutated = rt.call_function('array_values', [
				var_value_mutated.clone()])
		}
		mut iter_8 := var_value_mutated.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_v := item_8.val
			if !(var_v.clone().is_long() || var_v.clone().is_double()) {
				return rt.new_bool(false)
			}
		}
		var_value_mutated = rt.call_function('array_map', [rt.new_string('intval'),
			var_value_mutated.clone()])
		return rt.new_string((var_value_mutated.array_get(rt.new_int(0))).str() + ' AND ' +
			(var_value_mutated.array_get(rt.new_int(1))).str())
	} else {
		if !(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double()) {
			return rt.new_bool(false)
		}
		return rt.new_int(var_value_mutated.to_i64())
	}
	return rt.new_null()
}

fn (mut this Class_WP_Date_Query) build_mysql_datetime(var_datetime rt.PhpVal, default_to_max bool) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_datetime_mutated := var_datetime
	if !(var_datetime_mutated.clone().is_array()) {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(\\d{4})$/'),
			var_datetime_mutated.clone(), rt.create_array_from_list(var_matches)]))
		{
			var_datetime_mutated = rt.create_array([
				rt.ArrayItem{
					key: 'year'
					val: rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64())
				},
			])
		} else if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^(\\d{4})\\-(\\d{2})$/'),
			var_datetime_mutated.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			var_datetime_mutated = rt.create_array([
				rt.ArrayItem{
					key: 'year'
					val: rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64())
				},
				rt.ArrayItem{
					key: 'month'
					val: rt.new_int((var_matches.array_get(rt.new_int(2))).to_i64())
				},
			])
		} else if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^(\\d{4})\\-(\\d{2})\\-(\\d{2})$/'),
			var_datetime_mutated.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			var_datetime_mutated = rt.create_array([
				rt.ArrayItem{
					key: 'year'
					val: rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64())
				},
				rt.ArrayItem{
					key: 'month'
					val: rt.new_int((var_matches.array_get(rt.new_int(2))).to_i64())
				},
				rt.ArrayItem{
					key: 'day'
					val: rt.new_int((var_matches.array_get(rt.new_int(3))).to_i64())
				},
			])
		} else if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^(\\d{4})\\-(\\d{2})\\-(\\d{2}) (\\d{2}):(\\d{2})$/'),
			var_datetime_mutated.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			var_datetime_mutated = rt.create_array([
				rt.ArrayItem{
					key: 'year'
					val: rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64())
				},
				rt.ArrayItem{
					key: 'month'
					val: rt.new_int((var_matches.array_get(rt.new_int(2))).to_i64())
				},
				rt.ArrayItem{
					key: 'day'
					val: rt.new_int((var_matches.array_get(rt.new_int(3))).to_i64())
				},
				rt.ArrayItem{
					key: 'hour'
					val: rt.new_int((var_matches.array_get(rt.new_int(4))).to_i64())
				},
				rt.ArrayItem{
					key: 'minute'
					val: rt.new_int((var_matches.array_get(rt.new_int(5))).to_i64())
				},
			])
		}
		if !(var_datetime_mutated.clone().is_array()) {
			mut var_wp_timezone := rt.call_function('wp_timezone', []rt.PhpVal{})
			mut var_dt := rt.call_function('date_create', [var_datetime_mutated.clone(),
				var_wp_timezone.clone()])
			if rt.is_true(rt.identical(rt.new_bool(false), var_dt)) {
				return rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
					rt.new_bool(false)])
			}
			return rt.call_method(rt.call_method(var_dt, 'setTimezone', [
				var_wp_timezone.clone()]), 'format', [rt.new_string('Y-m-d H:i:s')])
		}
	}
	var_datetime_mutated = rt.call_function('array_map', [rt.new_string('absint'),
		var_datetime_mutated.clone()])
	if !(var_datetime_mutated.array_isset(rt.new_string('year'))) {
		var_datetime_mutated.array_set('year', rt.call_function('current_time', [
			rt.new_string('Y'),
		]))
	}
	if !(var_datetime_mutated.array_isset(rt.new_string('month'))) {
		var_datetime_mutated.array_set('month', if var_default_to_max { 12 } else { 1 })
	}
	if !(var_datetime_mutated.array_isset(rt.new_string('day'))) {
		var_datetime_mutated.array_set('day', if var_default_to_max { rt.new_int((rt.call_function('gmdate', [
				rt.new_string('t'),
				rt.call_function('mktime', [rt.new_int(0), rt.new_int(0),
					rt.new_int(0), var_datetime_mutated.array_get(rt.new_string('month')),
					rt.new_int(1), var_datetime_mutated.array_get(rt.new_string('year'))]),
			])).to_i64()) } else { 1 })
	}
	if !(var_datetime_mutated.array_isset(rt.new_string('hour'))) {
		var_datetime_mutated.array_set('hour', if var_default_to_max { 23 } else { 0 })
	}
	if !(var_datetime_mutated.array_isset(rt.new_string('minute'))) {
		var_datetime_mutated.array_set('minute', if var_default_to_max { 59 } else { 0 })
	}
	if !(var_datetime_mutated.array_isset(rt.new_string('second'))) {
		var_datetime_mutated.array_set('second', if var_default_to_max { 59 } else { 0 })
	}
	return rt.call_function('sprintf', [rt.new_string('%04d-%02d-%02d %02d:%02d:%02d'),
		var_datetime_mutated.array_get(rt.new_string('year')),
		var_datetime_mutated.array_get(rt.new_string('month')),
		var_datetime_mutated.array_get(rt.new_string('day')),
		var_datetime_mutated.array_get(rt.new_string('hour')),
		var_datetime_mutated.array_get(rt.new_string('minute')),
		var_datetime_mutated.array_get(rt.new_string('second'))])
}

fn (mut this Class_WP_Date_Query) build_time_query(var_column rt.PhpVal, var_compare rt.PhpVal, var_hour rt.PhpVal, var_minute rt.PhpVal, var_second rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_column_mutated := var_column
	mut var_compare_mutated := var_compare
	if !(!var_hour.is_null()) && !(!var_minute.is_null()) && !(!var_second.is_null()) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('in_array', [var_compare_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'IN' },
			rt.ArrayItem{ key: none, val: 'NOT IN' }, rt.ArrayItem{ key: none, val: 'BETWEEN' },
			rt.ArrayItem{ key: none, val: 'NOT BETWEEN' }]),
		rt.new_bool(true)]))
	{
		mut var_return := rt.new_array()
		mut var_value := this.build_value(var_compare_mutated.clone(), var_hour.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
			var_return << 'HOUR( ${var_column.to_string()} ) ${var_compare.to_string()} ${var_value.to_string()}'
		}
		var_value = this.build_value(var_compare_mutated.clone(), var_minute.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
			var_return << 'MINUTE( ${var_column.to_string()} ) ${var_compare.to_string()} ${var_value.to_string()}'
		}
		var_value = this.build_value(var_compare_mutated.clone(), var_second.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
			var_return << 'SECOND( ${var_column.to_string()} ) ${var_compare.to_string()} ${var_value.to_string()}'
		}
		return rt.call_function('implode', [rt.new_string(' AND '),
			rt.create_array_from_list(var_return)])
	}
	if !var_hour.is_null() && !(!var_minute.is_null()) && !(!var_second.is_null()) {
		var_value = this.build_value(var_compare_mutated.clone(), var_hour.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
			return rt.new_string('HOUR( ${var_column.to_string()} ) ${var_compare.to_string()} ${var_value.to_string()}')
		}
	} else if !(!var_hour.is_null()) && !var_minute.is_null() && !(!var_second.is_null()) {
		var_value = this.build_value(var_compare_mutated.clone(), var_minute.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
			return rt.new_string('MINUTE( ${var_column.to_string()} ) ${var_compare.to_string()} ${var_value.to_string()}')
		}
	} else if !(!var_hour.is_null()) && !(!var_minute.is_null()) && !var_second.is_null() {
		var_value = this.build_value(var_compare_mutated.clone(), var_second.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
			return rt.new_string('SECOND( ${var_column.to_string()} ) ${var_compare.to_string()} ${var_value.to_string()}')
		}
	}
	if !(!var_minute.is_null()) {
		return rt.new_bool(false)
	}
	mut var_format := rt.new_string('')
	mut var_time := rt.new_string('')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_hour)))) {
		var_format = rt.concat(var_format, rt.new_string('%H.'))
		var_time = rt.concat(var_time, rt.new_string(
			(rt.call_function('sprintf', [rt.new_string('%02d'), var_hour.clone()])).str() + '.'))
	} else {
		var_format = rt.concat(var_format, rt.new_string('0.'))
		var_time = rt.concat(var_time, rt.new_string('0.'))
	}
	var_format = rt.concat(var_format, rt.new_string('%i'))
	var_time = rt.concat(var_time, rt.call_function('sprintf', [
		rt.new_string('%02d'), var_minute.clone()]))
	if !var_second.is_null() {
		var_format = rt.concat(var_format, rt.new_string('%s'))
		var_time = rt.concat(var_time, rt.call_function('sprintf', [
			rt.new_string('%02d'),
			var_second.clone(),
		]))
	}
	return rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('DATE_FORMAT( ${var_column.to_string()}, %s ) ${var_compare.to_string()} %f'),
		var_format.clone(),
		var_time.clone(),
	])
}

fn (mut this Class_WP_Date_Query) sanitize_relation(var_relation rt.PhpVal) string {
	mut var_relation_mutated := var_relation
	if rt.is_true(rt.identical(rt.new_string('OR'),
		rt.new_string(var_relation_mutated.clone().to_string().to_upper())))
	{
		return 'OR'
	} else {
		return 'AND'
	}
	return ''
}

fn create_wp_date_query(default_column string, arg_1 rt.PhpVal) &Class_WP_Date_Query {
	mut obj := &Class_WP_Date_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		queries:       rt.new_array()
		relation:      rt.new_string('AND')
		column:        rt.new_string('post_date')
		compare:       rt.new_string('=')
		time_keys:     rt.new_array()
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
			return this.build_value(dispatch_arg_0, dispatch_arg_1)
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
			return this.build_time_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'sanitize_relation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.sanitize_relation(dispatch_arg_0))
		}
		else {
			return none
		}
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
		'queries' {
			this.queries = val
			return true
		}
		'relation' {
			this.relation = val
			return true
		}
		'column' {
			this.column = val
			return true
		}
		'compare' {
			this.compare = val
			return true
		}
		'time_keys' {
			this.time_keys = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
