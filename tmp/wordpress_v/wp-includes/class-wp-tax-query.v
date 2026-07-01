import rt

struct Class_WP_Tax_Query {
	rt.PhpObjectBase
pub mut:
		queries rt.PhpVal = rt.new_array()
		relation rt.PhpVal = rt.new_null()
		no_results rt.PhpVal = rt.new_array()
		table_aliases rt.PhpVal = rt.new_array()
		queried_terms rt.PhpVal = rt.new_array()
		primary_table rt.PhpVal = rt.new_null()
		primary_id_column rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Tax_Query) construct(var_tax_query rt.PhpVal)  {
	if var_tax_query.array_isset(rt.new_string('relation')) {
		this.relation = this.sanitize_relation(var_tax_query.array_get('relation'))
	} else {
		this.relation = rt.new_string('AND')
	}
	this.queries = this.sanitize_query(var_tax_query.dup())
}

fn (mut this Class_WP_Tax_Query) sanitize_query(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_cleaned_query := rt.new_array()
	mut var_defaults := { 'taxonomy': rt.new_string(''), 'terms': rt.new_array(), 'field': rt.new_string('term_id'), 'operator': rt.new_string('IN'), 'include_children': rt.new_bool(true) }
	{
		mut iter_1 := var_queries_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
				var_cleaned_query.array_set('relation', this.sanitize_relation(var_query.dup()))
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(Class_WP_Tax_Query.is_first_order_clause(var_query.dup())) {
				mut var_cleaned_clause := rt.call_function('array_merge', [var_defaults.dup(), var_query.dup()])
				var_cleaned_clause.array_set('terms', rt.cast_array(var_cleaned_clause.array_get('terms')))
				var_cleaned_query.array_push(var_cleaned_clause.dup())
				if rt.is_true(rt.new_bool(!(!rt.is_true(var_cleaned_clause.array_get('taxonomy'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					mut var_taxonomy := var_cleaned_clause.array_get('taxonomy')
					if !(this.queried_terms.array_isset(var_taxonomy)) {
						this.queried_terms.array_set(var_taxonomy, rt.new_array())
					}
					if !(!rt.is_true(var_cleaned_clause.array_get('terms'))) && !(this.queried_terms.array_get(var_taxonomy).array_isset(rt.new_string('terms'))) {
						this.queried_terms.array_get_mut(var_taxonomy).array_set('terms', var_cleaned_clause.array_get('terms'))
					}
					if !(!rt.is_true(var_cleaned_clause.array_get('field'))) && !(this.queried_terms.array_get(var_taxonomy).array_isset(rt.new_string('field'))) {
						this.queried_terms.array_get_mut(var_taxonomy).array_set('field', var_cleaned_clause.array_get('field'))
					}
				}
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(rt.new_bool(var_query.dup().is_array())) {
				mut var_cleaned_subquery := this.sanitize_query(var_query.dup())
				if !(!rt.is_true(var_cleaned_subquery)) {
					if !(var_cleaned_subquery.array_isset(rt.new_string('relation'))) {
						var_cleaned_subquery.array_set('relation', 'AND')
					}
					var_cleaned_query.array_push(var_cleaned_subquery.dup())
				}
			}
		}
	}
	return var_cleaned_query.dup()
}

fn (mut this Class_WP_Tax_Query) sanitize_relation(var_relation rt.PhpVal) string {
	mut var_relation_mutated := var_relation
	if rt.is_true(rt.identical(rt.new_string('OR'), rt.new_string(var_relation_mutated.dup().to_string().to_upper()))) {
		return 'OR'
	} else {
		return 'AND'
	}
	return ''
}

fn Class_WP_Tax_Query.is_first_order_clause(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
	return rt.is_true(rt.new_bool(var_query_mutated.dup().is_array())) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_query_mutated) || rt.is_true(rt.new_bool(var_query_mutated.dup().array_isset(rt.new_string('terms')))))) || rt.is_true(rt.new_bool(var_query_mutated.dup().array_isset(rt.new_string('taxonomy')))))) || rt.is_true(rt.new_bool(var_query_mutated.dup().array_isset(rt.new_string('include_children')))))) || rt.is_true(rt.new_bool(var_query_mutated.dup().array_isset(rt.new_string('field')))))) || rt.is_true(rt.new_bool(var_query_mutated.dup().array_isset(rt.new_string('operator'))))))
}

fn (mut this Class_WP_Tax_Query) get_sql(var_primary_table rt.PhpVal, var_primary_id_column rt.PhpVal) rt.PhpVal {
	this.primary_table = var_primary_table.dup()
	this.primary_id_column = var_primary_id_column.dup()
	return this.get_sql_clauses()
}

fn (mut this Class_WP_Tax_Query) get_sql_clauses() rt.PhpVal {
	mut var_queries := this.queries
	mut var_sql := this.get_sql_for_query(var_queries.dup(), 0)
	if !(!rt.is_true(var_sql.array_get('where'))) {
		var_sql.array_set('where', ' AND ' + (var_sql.array_get('where')).str())
	}
	return var_sql.dup()
}

fn (mut this Class_WP_Tax_Query) get_sql_for_query(var_query rt.PhpVal, depth i64) rt.PhpVal {
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
						var_sql_chunks.array_get_mut('where').array_push('( ' + (rt.call_function('implode', [rt.new_string(' AND '), var_clause_sql.array_get('where')])).str() + ' )')
					}
					var_sql_chunks['join'] = rt.call_function('array_merge', [var_sql_chunks.array_get('join'), var_clause_sql.array_get('join')])
					// unsupported statement: Stmt_Nop
				} else {
					var_clause_sql = this.get_sql_for_query(var_clause.dup(), depth + 1)
					var_sql_chunks.array_get_mut('where').array_push(var_clause_sql.array_get('where'))
					var_sql_chunks.array_get_mut('join').array_push(var_clause_sql.array_get('join'))
				}
			}
		}
	}
	var_sql_chunks['join'] = rt.call_function('array_filter', [var_sql_chunks.array_get('join')])
	var_sql_chunks['where'] = rt.call_function('array_filter', [var_sql_chunks.array_get('where')])
	if !rt.is_true(var_relation) {
		mut var_relation := rt.new_string(rt.new_string('AND'))
	}
	if !(!rt.is_true(var_sql_chunks.array_get('join'))) {
		var_sql.array_set('join', rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_unique', [var_sql_chunks.array_get('join')])]))
	}
	if !(!rt.is_true(var_sql_chunks.array_get('where'))) {
		var_sql.array_set('where', '( ' + '\n  ' + (var_indent).str() + (rt.call_function('implode', [' ' + '\n  ' + (var_indent).str() + (var_relation).str() + ' ' + '\n  ' + (var_indent).str(), var_sql_chunks.array_get('where')])).str() + '\n' + (var_indent).str() + ')')
	}
	return var_sql.dup()
}

fn (mut this Class_WP_Tax_Query) get_sql_for_clause(var_clause rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_clause_mutated := var_clause
	// unsupported statement: Stmt_Global
	mut var_sql := rt.create_array([rt.ArrayItem{ key: 'where', val: rt.new_array() }, rt.ArrayItem{ key: 'join', val: rt.new_array() }])
	mut var_join := rt.new_string(rt.new_string(''))
	mut var_where := rt.new_string(rt.new_string(''))
	this.clean_query(var_clause_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_clause_mutated.dup()])) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	mut var_terms := var_clause_mutated.array_get('terms')
	mut var_operator := rt.new_string(rt.new_string(var_clause_mutated.array_get('operator').to_string().to_upper()))
	if rt.is_true(rt.identical(rt.new_string('IN'), var_operator)) {
		if !rt.is_true(var_terms) {
			return // unsupported expression: Expr_StaticPropertyFetch
		}
		var_terms = rt.call_function('implode', [rt.new_string(','), var_terms.dup()])
		mut var_alias := this.find_compatible_table_alias(var_clause_mutated.dup(), var_parent_query.dup())
		if rt.is_true(rt.identical(rt.new_bool(false), var_alias)) {
			mut var_i := rt.new_int(rt.new_int(this.table_aliases.array_count()))
			var_alias = if rt.is_true(var_i) { 'tt' + (var_i).str() } else { rt.get_property(var_wpdb, 'term_relationships') }
			this.table_aliases.array_push(var_alias.dup())
			var_clause_mutated.array_set('alias', var_alias.dup())
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_where = rt.new_string(rt.new_string("${var_alias.to_string()}.term_taxonomy_id ${var_operator.to_string()} (${var_terms.to_string()})"))
	} else if rt.is_true(rt.identical(rt.new_string('NOT IN'), var_operator)) {
		if !rt.is_true(var_terms) {
			return var_sql.dup()
		}
		var_terms = rt.call_function('implode', [rt.new_string(','), var_terms.dup()])
		var_where = rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.primary_table, rt.new_string('.')), this.primary_id_column), rt.new_string(' NOT IN (\n\t\t\t\tSELECT object_id\n\t\t\t\tFROM ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('\n\t\t\t\tWHERE term_taxonomy_id IN (')), var_terms), rt.new_string(')\n\t\t\t)')))
	} else if rt.is_true(rt.identical(rt.new_string('AND'), var_operator)) {
		if !rt.is_true(var_terms) {
			return var_sql.dup()
		}
		mut var_num_terms := rt.new_int(rt.new_int(var_terms.dup().array_count()))
		var_terms = rt.call_function('implode', [rt.new_string(','), var_terms.dup()])
		var_where = rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('(\n\t\t\t\tSELECT COUNT(1)\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('\n\t\t\t\tWHERE term_taxonomy_id IN (')), var_terms), rt.new_string(')\n\t\t\t\tAND object_id = ')), this.primary_table), rt.new_string('.')), this.primary_id_column), rt.new_string('\n\t\t\t) = ')), var_num_terms))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('NOT EXISTS'), var_operator)) || rt.is_true(rt.identical(rt.new_string('EXISTS'), var_operator)))) {
		var_where = rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_operator, rt.new_string(' (\n\t\t\t\t\tSELECT 1\n\t\t\t\t\tFROM ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string('\n\t\t\t\t\tON ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string('.term_taxonomy_id = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.term_taxonomy_id\n\t\t\t\t\tWHERE ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string('.taxonomy = %s\n\t\t\t\t\tAND ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.object_id = ')), this.primary_table), rt.new_string('.')), this.primary_id_column), rt.new_string('\n\t\t\t\t)')), var_clause_mutated.array_get('taxonomy')])
	}
	var_sql.array_get_mut('join').array_push(var_join.dup())
	var_sql.array_get_mut('where').array_push(var_where.dup())
	return var_sql.dup()
}

fn (mut this Class_WP_Tax_Query) find_compatible_table_alias(var_clause rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_clause_mutated := var_clause
	mut var_alias := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(!(var_clause_mutated.array_isset(rt.new_string('operator'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_alias.dup()
	}
	if rt.is_true(rt.new_bool(!(var_parent_query.array_isset(rt.new_string('relation'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_alias.dup()
	}
	mut var_compatible_operators := ['IN']
	{
		mut iter_1 := var_parent_query.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sibling := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_sibling.dup().is_array()))))) || !(this.is_first_order_clause(var_sibling.dup())))) {
				continue
			}
			if !rt.is_true(var_sibling.array_get('alias')) || !rt.is_true(var_sibling.array_get('operator')) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string(var_sibling.array_get('operator').to_string().to_upper()), var_compatible_operators.dup(), rt.new_bool(true)])) {
				var_alias = rt.call_function('preg_replace', [rt.new_string('/\\W/'), rt.new_string('_'), var_sibling.array_get('alias')])
				break
			}
		}
	}
	return var_alias.dup()
}

fn (mut this Class_WP_Tax_Query) clean_query(var_query rt.PhpVal)  {
	mut var_query_mutated := var_query
	if !rt.is_true(var_query_mutated.array_get('taxonomy')) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_query_mutated = create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', []))
			return rt.new_null()
		}
		var_query_mutated.array_set('include_children', false)
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', []))))) {
		var_query_mutated = 
		return rt.new_null()
	}
	if rt.is_true() {
	} else {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP_Tax_Query) transform_query(var_query rt.PhpVal, var_resulting_field rt.PhpVal)  {
	mut var_query_mutated := var_query
	mut var_resulting_field_mutated := var_resulting_field
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_tax_query(arg_0 rt.PhpVal) &Class_WP_Tax_Query {
	mut obj := &Class_WP_Tax_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		queries: rt.new_array()
		relation: rt.new_null()
		no_results: rt.new_array()
		table_aliases: rt.new_array()
		queried_terms: rt.new_array()
		primary_table: rt.new_null()
		primary_id_column: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
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
		else { return none }
	}
}

fn (this &Class_WP_Tax_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queries' { return this.queries }
		'relation' { return this.relation }
		'no_results' { return this.no_results }
		'table_aliases' { return this.table_aliases }
		'queried_terms' { return this.queried_terms }
		'primary_table' { return this.primary_table }
		'primary_id_column' { return this.primary_id_column }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Tax_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queries' { this.queries = val; return true }
		'relation' { this.relation = val; return true }
		'no_results' { this.no_results = val; return true }
		'table_aliases' { this.table_aliases = val; return true }
		'queried_terms' { this.queried_terms = val; return true }
		'primary_table' { this.primary_table = val; return true }
		'primary_id_column' { this.primary_id_column = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_class_wp_tax_query_php() {
}
