import rt

struct Class_WP_Tax_Query {
	rt.PhpObjectBase
pub mut:
	queries           rt.PhpVal = rt.new_array()
	relation          rt.PhpVal = rt.new_null()
	table_aliases     rt.PhpVal = rt.new_array()
	queried_terms     rt.PhpVal = rt.new_array()
	primary_table     rt.PhpVal = rt.new_null()
	primary_id_column rt.PhpVal = rt.new_null()
}

fn init_static_wp_tax_query() {
	rt.init_static_prop('WP_Tax_Query', 'no_results', rt.create_array([
		rt.ArrayItem{ key: 'join', val: rt.create_array([
			rt.ArrayItem{ key: none, val: '' },
		]) },
		rt.ArrayItem{ key: 'where', val: rt.create_array([
			rt.ArrayItem{ key: none, val: '0 = 1' },
		]) },
	]))
}

fn (mut this Class_WP_Tax_Query) construct(var_tax_query rt.PhpVal) {
	if var_tax_query.array_isset(rt.new_string('relation')) {
		this.relation = this.sanitize_relation(var_tax_query.array_get(rt.new_string('relation')))
	} else {
		this.relation = rt.new_string('AND')
	}
	this.queries = this.sanitize_query(var_tax_query.clone())
}

fn (mut this Class_WP_Tax_Query) sanitize_query(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_cleaned_query := rt.new_array()
	mut var_defaults := {
		'taxonomy':         rt.new_string('')
		'terms':            rt.new_array()
		'field':            rt.new_string('term_id')
		'operator':         rt.new_string('IN')
		'include_children': rt.new_bool(true)
	}
	mut iter_1 := var_queries_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_query := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
			var_cleaned_query.array_set('relation', this.sanitize_relation(var_query.clone()))
		} else if rt.is_true(Class_WP_Tax_Query.is_first_order_clause(var_query.clone())) {
			mut var_cleaned_clause := rt.call_function('array_merge', [
				rt.create_array_from_native_map(var_defaults),
				var_query.clone(),
			])
			var_cleaned_clause.array_set('terms',
				rt.cast_array(var_cleaned_clause.array_get(rt.new_string('terms'))))
			var_cleaned_query.array_push(var_cleaned_clause.clone())
			if !(!rt.is_true(var_cleaned_clause.array_get(rt.new_string('taxonomy'))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('NOT IN'), var_cleaned_clause.array_get(rt.new_string('operator')))))) {
				mut var_taxonomy := var_cleaned_clause.array_get(rt.new_string('taxonomy'))
				if !(this.queried_terms.array_isset(var_taxonomy)) {
					this.queried_terms.array_set(var_taxonomy, rt.new_array())
				}
				if !(!rt.is_true(var_cleaned_clause.array_get(rt.new_string('terms'))))
					&& !(this.queried_terms.array_get(var_taxonomy).array_isset(rt.new_string('terms'))) {
					this.queried_terms.array_get_mut(var_taxonomy).array_set('terms',
						var_cleaned_clause.array_get(rt.new_string('terms')))
				}
				if !(!rt.is_true(var_cleaned_clause.array_get(rt.new_string('field'))))
					&& !(this.queried_terms.array_get(var_taxonomy).array_isset(rt.new_string('field'))) {
					this.queried_terms.array_get_mut(var_taxonomy).array_set('field',
						var_cleaned_clause.array_get(rt.new_string('field')))
				}
			}
		} else if rt.is_true(rt.new_bool(var_query.clone().is_array())) {
			mut var_cleaned_subquery := this.sanitize_query(var_query.clone())
			if !(!rt.is_true(var_cleaned_subquery)) {
				if !(var_cleaned_subquery.array_isset(rt.new_string('relation'))) {
					var_cleaned_subquery.array_set('relation', 'AND')
				}
				var_cleaned_query.array_push(var_cleaned_subquery.clone())
			}
		}
	}
	return var_cleaned_query.clone()
}

fn (mut this Class_WP_Tax_Query) sanitize_relation(var_relation rt.PhpVal) string {
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

fn Class_WP_Tax_Query.is_first_order_clause(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
	return var_query_mutated.clone().is_array() && !rt.is_true(var_query_mutated)
		|| rt.is_true(rt.new_bool(var_query_mutated.clone().array_isset(rt.new_string('terms'))))
		|| rt.is_true(rt.new_bool(var_query_mutated.clone().array_isset(rt.new_string('taxonomy'))))
		|| rt.is_true(rt.new_bool(var_query_mutated.clone().array_isset(rt.new_string('include_children'))))
		|| rt.is_true(rt.new_bool(var_query_mutated.clone().array_isset(rt.new_string('field'))))
		|| rt.is_true(rt.new_bool(var_query_mutated.clone().array_isset(rt.new_string('operator'))))
}

fn (mut this Class_WP_Tax_Query) get_sql(var_primary_table rt.PhpVal, var_primary_id_column rt.PhpVal) rt.PhpVal {
	this.primary_table = var_primary_table.clone()
	this.primary_id_column = var_primary_id_column.clone()
	return this.get_sql_clauses()
}

fn (mut this Class_WP_Tax_Query) get_sql_clauses() rt.PhpVal {
	mut var_queries := this.queries
	mut var_sql := this.get_sql_for_query(var_queries.clone(), 0)
	if !(!rt.is_true(var_sql.array_get(rt.new_string('where')))) {
		var_sql.array_set('where', ' AND ' + (var_sql.array_get(rt.new_string('where'))).str())
	}
	return var_sql.clone()
}

fn (mut this Class_WP_Tax_Query) get_sql_for_query(var_query rt.PhpVal, depth i64) rt.PhpVal {
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
	mut iter_2 := var_query_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_clause := item_2.val
		mut var_key := item_2.key
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

fn (mut this Class_WP_Tax_Query) get_sql_for_clause(var_clause rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_clause_mutated := var_clause
	mut var_sql := rt.create_array([rt.ArrayItem{ key: 'where', val: rt.new_array() },
		rt.ArrayItem{ key: 'join', val: rt.new_array() }])
	mut var_join := rt.new_string('')
	mut var_where := rt.new_string('')
	this.clean_query(var_clause_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_clause_mutated.clone()])) {
		return rt.get_static_prop('WP_Tax_Query', 'no_results')
	}
	mut var_terms := var_clause_mutated.array_get(rt.new_string('terms'))
	mut var_operator :=
		rt.new_string(var_clause_mutated.array_get(rt.new_string('operator')).to_string().to_upper())
	if rt.is_true(rt.identical(rt.new_string('IN'), var_operator)) {
		if !rt.is_true(var_terms) {
			return rt.get_static_prop('WP_Tax_Query', 'no_results')
		}
		var_terms = rt.call_function('implode', [rt.new_string(','),
			var_terms.clone()])
		mut var_alias := this.find_compatible_table_alias(var_clause_mutated.clone(),
			var_parent_query.clone())
		if rt.is_true(rt.identical(rt.new_bool(false), var_alias)) {
			mut var_i := rt.new_int(this.table_aliases.array_count())
			var_alias = if rt.is_true(var_i) {
				'tt' + var_i.str()
			} else {
				rt.get_property(var_wpdb, 'term_relationships')
			}
			this.table_aliases.array_push(var_alias.clone())
			var_clause_mutated.array_set('alias', var_alias.clone())
			var_join = rt.concat(var_join, rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
				'term_relationships')))
			var_join = rt.concat(var_join, if rt.is_true(var_i) {
				' AS ${var_alias.to_string()}'
			} else {
				''
			})
			var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' ON ('),
				this.primary_table), rt.new_string('.')), this.primary_id_column),
				rt.new_string(' = ')), var_alias), rt.new_string('.object_id)')))
		}
		var_where =
			rt.new_string('${var_alias.to_string()}.term_taxonomy_id ${var_operator.to_string()} (${var_terms.to_string()})')
	} else if rt.is_true(rt.identical(rt.new_string('NOT IN'), var_operator)) {
		if !rt.is_true(var_terms) {
			return var_sql.clone()
		}
		var_terms = rt.call_function('implode', [rt.new_string(','),
			var_terms.clone()])
		var_where = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.primary_table,
			rt.new_string('.')), this.primary_id_column),
			rt.new_string(' NOT IN (\n\t\t\t\tSELECT object_id\n\t\t\t\tFROM ')), rt.get_property(var_wpdb,
			'term_relationships')), rt.new_string('\n\t\t\t\tWHERE term_taxonomy_id IN (')),
			var_terms), rt.new_string(')\n\t\t\t)'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('AND'), var_operator)) {
		if !rt.is_true(var_terms) {
			return var_sql.clone()
		}
		mut var_num_terms := rt.new_int(var_terms.clone().array_count())
		var_terms = rt.call_function('implode', [rt.new_string(','),
			var_terms.clone()])
		var_where = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('(\n\t\t\t\tSELECT COUNT(1)\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'term_relationships')), rt.new_string('\n\t\t\t\tWHERE term_taxonomy_id IN (')),
			var_terms), rt.new_string(')\n\t\t\t\tAND object_id = ')), this.primary_table),
			rt.new_string('.')), this.primary_id_column), rt.new_string('\n\t\t\t) = ')),
			var_num_terms)).str())
	} else if rt.is_true(rt.identical(rt.new_string('NOT EXISTS'), var_operator))
		|| rt.is_true(rt.identical(rt.new_string('EXISTS'), var_operator)) {
		var_where = rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_operator,
				rt.new_string(' (\n\t\t\t\t\tSELECT 1\n\t\t\t\t\tFROM ')), rt.get_property(var_wpdb,
				'term_relationships')), rt.new_string('\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string('\n\t\t\t\t\tON ')), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string('.term_taxonomy_id = ')), rt.get_property(var_wpdb,
				'term_relationships')), rt.new_string('.term_taxonomy_id\n\t\t\t\t\tWHERE ')), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string('.taxonomy = %s\n\t\t\t\t\tAND ')), rt.get_property(var_wpdb,
				'term_relationships')), rt.new_string('.object_id = ')), this.primary_table),
				rt.new_string('.')), this.primary_id_column), rt.new_string('\n\t\t\t\t)')),
			var_clause_mutated.array_get(rt.new_string('taxonomy')),
		])
	}
	var_sql.array_get_mut('join').array_push(var_join.clone())
	var_sql.array_get_mut('where').array_push(var_where.clone())
	return var_sql.clone()
}

fn (mut this Class_WP_Tax_Query) find_compatible_table_alias(var_clause rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_clause_mutated := var_clause
	mut var_alias := rt.new_bool(false)
	if !(var_clause_mutated.array_isset(rt.new_string('operator')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('IN'), var_clause_mutated.array_get(rt.new_string('operator')))))) {
		return var_alias.clone()
	}
	if !(var_parent_query.array_isset(rt.new_string('relation')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('OR'), var_parent_query.array_get(rt.new_string('relation')))))) {
		return var_alias.clone()
	}
	mut var_compatible_operators := ['IN']
	mut iter_3 := var_parent_query.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_sibling := item_3.val
		if !(var_sibling.clone().is_array()) || !(this.is_first_order_clause(var_sibling.clone())) {
			continue
		}
		if !rt.is_true(var_sibling.array_get(rt.new_string('alias')))
			|| !rt.is_true(var_sibling.array_get(rt.new_string('operator'))) {
			continue
		}
		if rt.is_true(rt.call_function('in_array', [
			rt.new_string(var_sibling.array_get(rt.new_string('operator')).to_string().to_upper()),
			rt.create_array_from_list(var_compatible_operators),
			rt.new_bool(true),
		]))
		{
			var_alias = rt.call_function('preg_replace', [rt.new_string('/\\W/'),
				rt.new_string('_'), var_sibling.array_get(rt.new_string('alias'))])
			break
		}
	}
	return var_alias.clone()
}

fn (mut this Class_WP_Tax_Query) clean_query(var_query rt.PhpVal) {
	mut var_query_mutated := var_query
	if !rt.is_true(var_query_mutated.array_get(rt.new_string('taxonomy'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('term_taxonomy_id'),
			var_query_mutated.array_get(rt.new_string('field'))))))
		{
			var_query_mutated = create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
				rt.new_string('Invalid taxonomy.'),
			]))
			return
		}
		var_query_mutated.array_set('include_children', false)
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_query_mutated.array_get(rt.new_string('taxonomy')),
	])))))
	{
		var_query_mutated = create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))
		return
	}
	if rt.is_true(rt.identical(rt.new_string('slug'), var_query_mutated.array_get(rt.new_string('field'))))
		|| rt.is_true(rt.identical(rt.new_string('name'), var_query_mutated.array_get(rt.new_string('field')))) {
		var_query_mutated.array_set('terms', rt.call_function('array_unique', [
			rt.cast_array(var_query_mutated.array_get(rt.new_string('terms'))),
		]))
	} else {
		var_query_mutated.array_set('terms', rt.call_function('wp_parse_id_list', [
			var_query_mutated.array_get(rt.new_string('terms')),
		]))
	}
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_query_mutated.array_get(rt.new_string('taxonomy'))]))
		&& rt.is_true(var_query_mutated.array_get(rt.new_string('include_children'))) {
		this.transform_query(var_query_mutated.clone(), rt.new_string('term_id'))
		if rt.is_true(rt.call_function('is_wp_error', [var_query_mutated.clone()])) {
			return
		}
		mut var_children := rt.new_array()
		mut iter_4 := var_query_mutated.array_get(rt.new_string('terms')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_term := item_4.val
			var_children = rt.call_function('array_merge', [var_children.clone(),
				rt.call_function('get_term_children', [var_term.clone(),
					var_query_mutated.array_get(rt.new_string('taxonomy'))])])
			var_children.array_push(var_term.clone())
		}
		var_query_mutated.array_set('terms', var_children.clone())
	}
	this.transform_query(var_query_mutated.clone(), rt.new_string('term_taxonomy_id'))
}

fn (mut this Class_WP_Tax_Query) transform_query(var_query rt.PhpVal, var_resulting_field rt.PhpVal) {
	mut var_query_mutated := var_query
	mut var_resulting_field_mutated := var_resulting_field
	if !rt.is_true(var_query_mutated.array_get(rt.new_string('terms'))) {
		return
	}
	if rt.is_true(rt.identical(var_query_mutated.array_get(rt.new_string('field')),
		var_resulting_field_mutated))
	{
		return
	}
	var_resulting_field_mutated = rt.call_function('sanitize_key', [
		var_resulting_field_mutated.clone()])
	mut var_terms := rt.call_function('array_filter', [
		var_query_mutated.array_get(rt.new_string('terms')),
	])
	if !rt.is_true(var_terms) {
		var_query_mutated.array_set('terms', rt.new_array())
		var_query_mutated.array_set('field', var_resulting_field_mutated.clone())
		return
	}
	mut var_args := {
		'get':                    rt.new_string('all')
		'number':                 rt.new_int(0)
		'taxonomy':               var_query_mutated.array_get(rt.new_string('taxonomy'))
		'update_term_meta_cache': rt.new_bool(false)
		'orderby':                rt.new_string('none')
	}
	mut switch_val_1 := var_query_mutated.array_get(rt.new_string('field'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('slug'))) {
		var_args['slug'] = var_terms.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) {
		var_args['name'] = var_terms.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('term_taxonomy_id'))) {
		var_args['term_taxonomy_id'] = var_terms.clone()
	} else {
		var_args['include'] = rt.call_function('wp_parse_id_list', [
			var_terms.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
		var_query_mutated.array_get(rt.new_string('taxonomy')),
	])))))
	{
		var_args['number'] = rt.new_int(var_terms.clone().array_count())
	}
	mut var_term_query := create_wp_term_query()
	mut var_term_list := var_term_query.query(var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_term_list.clone()])) {
		var_query_mutated = var_term_list.clone()
		return
	}
	if rt.is_true(rt.identical(rt.new_string('AND'), var_query_mutated.array_get(rt.new_string('operator'))))
		&& var_term_list.clone().array_count() < var_query_mutated.array_get(rt.new_string('terms')).array_count() {
		var_query_mutated = create_wp_error(rt.new_string('inexistent_terms'), rt.call_function('__', [
			rt.new_string('Inexistent terms.'),
		]))
		return
	}
	var_query_mutated.array_set('terms', rt.call_function('wp_list_pluck', [
		var_term_list.clone(), var_resulting_field_mutated.clone()]))
	var_query_mutated.array_set('field', var_resulting_field_mutated.clone())
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Term_Query {
	rt.PhpObjectBase
}

fn create_wp_tax_query(arg_0 rt.PhpVal) &Class_WP_Tax_Query {
	mut obj := &Class_WP_Tax_Query{
		PhpObjectBase:     rt.PhpObjectBase{}
		queries:           rt.new_array()
		relation:          rt.new_null()
		table_aliases:     rt.new_array()
		queried_terms:     rt.new_array()
		primary_table:     rt.new_null()
		primary_id_column: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_term_query(_args ...rt.PhpVal) &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Tax_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_query(dispatch_arg_0)
		}
		'sanitize_relation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.sanitize_relation(dispatch_arg_0))
		}
		'is_first_order_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Tax_Query.is_first_order_clause(dispatch_arg_0))
		}
		'get_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_sql(dispatch_arg_0, dispatch_arg_1)
		}
		'get_sql_clauses' {
			return this.get_sql_clauses()
		}
		'get_sql_for_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_sql_for_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_sql_for_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_sql_for_clause(dispatch_arg_0, dispatch_arg_1)
		}
		'find_compatible_table_alias' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.find_compatible_table_alias(dispatch_arg_0, dispatch_arg_1)
		}
		'clean_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clean_query(dispatch_arg_0)
			return rt.new_null()
		}
		'transform_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.transform_query(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Tax_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queries' { return this.queries }
		'relation' { return this.relation }
		'table_aliases' { return this.table_aliases }
		'queried_terms' { return this.queried_terms }
		'primary_table' { return this.primary_table }
		'primary_id_column' { return this.primary_id_column }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Tax_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queries' {
			this.queries = val
			return true
		}
		'relation' {
			this.relation = val
			return true
		}
		'table_aliases' {
			this.table_aliases = val
			return true
		}
		'queried_terms' {
			this.queried_terms = val
			return true
		}
		'primary_table' {
			this.primary_table = val
			return true
		}
		'primary_id_column' {
			this.primary_id_column = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Term_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Term_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Term_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
