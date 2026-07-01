import rt

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
pub mut:
		queries rt.PhpVal = rt.new_array()
		relation string
		meta_table rt.PhpVal = rt.new_null()
		meta_id_column rt.PhpVal = rt.new_null()
		primary_table rt.PhpVal = rt.new_null()
		primary_id_column rt.PhpVal = rt.new_null()
		table_aliases rt.PhpVal = rt.new_array()
		clauses rt.PhpVal = rt.new_array()
		has_or_relation bool
}

fn (mut this Class_WP_Meta_Query) construct(var_meta_query rt.PhpVal)  {
	mut var_meta_query_mutated := var_meta_query
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_query_mutated)))) {
		return
	}
	if rt.is_true(rt.new_bool(var_meta_query_mutated.array_isset(rt.new_string('relation')) && rt.is_true(rt.identical(rt.new_string('OR'), rt.new_string(var_meta_query_mutated.array_get('relation').to_string().to_upper()))))) {
		this.relation = 'OR'
	} else {
		this.relation = 'AND'
	}
	this.queries = this.sanitize_query(var_meta_query_mutated.dup())
}

fn (mut this Class_WP_Meta_Query) sanitize_query(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_clean_queries := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_queries_mutated.dup().is_array()))))) {
		return var_clean_queries.dup()
	}
	{
		mut iter_1 := var_queries_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
				mut var_relation := var_query
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_query.dup().is_array()))))) {
				continue
				// unsupported statement: Stmt_Nop
			} else if this.is_first_order_clause(var_query.dup()) {
				if rt.is_true(rt.new_bool(var_query.array_isset(rt.new_string('value')) && rt.is_true(rt.identical(rt.new_array(), var_query.array_get('value'))))) {
					var_query.array_unset(rt.new_string('value'))
				}
				var_clean_queries.array_set(var_key, var_query.dup())
				// unsupported statement: Stmt_Nop
			} else {
				mut var_cleaned_query := this.sanitize_query(var_query.dup())
				if !(!rt.is_true(var_cleaned_query)) {
					var_clean_queries.array_set(var_key, var_cleaned_query.dup())
				}
			}
		}
	}
	if !rt.is_true(var_clean_queries) {
		return var_clean_queries.dup()
	}
	if rt.is_true(rt.new_bool(!(var_relation).is_null() && rt.is_true(rt.identical(rt.new_string('OR'), rt.new_string(var_relation.dup().to_string().to_upper()))))) {
		var_clean_queries.array_set('relation', 'OR')
		this.has_or_relation = true
		// unsupported statement: Stmt_Nop
	} else if 1 == var_clean_queries.dup().array_count() {
		var_clean_queries.array_set('relation', 'OR')
		// unsupported statement: Stmt_Nop
	} else {
		var_clean_queries.array_set('relation', 'AND')
	}
	return var_clean_queries.dup()
}

fn (mut this Class_WP_Meta_Query) is_first_order_clause(var_query rt.PhpVal) bool {
	return var_query.array_isset(rt.new_string('key')) || var_query.array_isset(rt.new_string('value'))
}

fn (mut this Class_WP_Meta_Query) parse_query_vars(var_qv rt.PhpVal)  {
	mut var_meta_query := rt.new_array()
	mut var_primary_meta_query := rt.new_array()
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'key' }, rt.ArrayItem{ key: none, val: 'compare' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'compare_key' }, rt.ArrayItem{ key: none, val: 'type_key' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if !(!rt.is_true(var_qv.array_get("meta_${var_key.to_string()}"))) {
				var_primary_meta_query.array_set(var_key, var_qv.array_get("meta_${var_key.to_string()}"))
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_qv.array_isset(rt.new_string('meta_value')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_qv.array_get('meta_value').is_array()))))) || rt.is_true(var_qv.array_get('meta_value')))))) {
		var_primary_meta_query.array_set('value', var_qv.array_get('meta_value'))
	}
	mut var_existing_meta_query := if rt.is_true(rt.new_bool(var_qv.array_isset(rt.new_string('meta_query')) && rt.is_true(rt.new_bool(var_qv.array_get('meta_query').is_array())))) { var_qv.array_get('meta_query') } else { rt.new_array() }
	if !(!rt.is_true(var_primary_meta_query)) && !(!rt.is_true(var_existing_meta_query)) {
		var_meta_query = rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: var_primary_meta_query }, rt.ArrayItem{ key: none, val: var_existing_meta_query }])
	} else if !(!rt.is_true(var_primary_meta_query)) {
		var_meta_query = rt.create_array([rt.ArrayItem{ key: none, val: var_primary_meta_query }])
	} else if !(!rt.is_true(var_existing_meta_query)) {
		var_meta_query = var_existing_meta_query.dup()
	}
	this.construct(var_meta_query.dup())
}

fn (mut this Class_WP_Meta_Query) get_cast_for_type(type string) string {
	if type == '' {
		return 'CHAR'
	}
	mut var_meta_type := rt.new_string(rt.new_string(type.to_upper()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(?:BINARY|CHAR|DATE|DATETIME|SIGNED|UNSIGNED|TIME|NUMERIC(?:\\(\\d+(?:,\\s?\\d+)?\\))?|DECIMAL(?:\\(\\d+(?:,\\s?\\d+)?\\))?)$/'), var_meta_type.dup()]))))) {
		return 'CHAR'
	}
	if rt.is_true(rt.identical(rt.new_string('NUMERIC'), var_meta_type)) {
		var_meta_type = rt.new_string(rt.new_string('SIGNED'))
	}
	return (var_meta_type).str()
}

fn (mut this Class_WP_Meta_Query) get_sql(var_type rt.PhpVal, var_primary_table rt.PhpVal, var_primary_id_column rt.PhpVal, var_context rt.PhpVal) bool {
	mut var_meta_table := rt.call_function('_get_meta_table', [var_type.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_table)))) {
		return false
	}
	this.table_aliases = rt.new_array()
	this.meta_table = var_meta_table.dup()
	this.meta_id_column = rt.call_function('sanitize_key', [(var_type).str() + '_id'])
	this.primary_table = var_primary_table.dup()
	this.primary_id_column = var_primary_id_column.dup()
	mut var_sql := this.get_sql_clauses()
	if rt.is_true(rt.call_function('str_contains', [var_sql.array_get('join'), rt.new_string('LEFT JOIN')])) {
		var_sql.array_set('join', rt.call_function('str_replace', [rt.new_string('INNER JOIN'), rt.new_string('LEFT JOIN'), var_sql.array_get('join')]))
	}
	return (rt.call_function('apply_filters_ref_array', [rt.new_string('get_meta_sql'), rt.create_array([rt.ArrayItem{ key: none, val: var_sql }, rt.ArrayItem{ key: none, val: this.queries }, rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: var_primary_table }, rt.ArrayItem{ key: none, val: var_primary_id_column }, rt.ArrayItem{ key: none, val: var_context }])])).to_bool()
}

fn (mut this Class_WP_Meta_Query) get_sql_clauses() rt.PhpVal {
	mut var_queries := this.queries
	mut var_sql := this.get_sql_for_query(var_queries.dup(), 0)
	if !(!rt.is_true(var_sql.array_get('where'))) {
		var_sql.array_set('where', ' AND ' + (var_sql.array_get('where')).str())
	}
	return var_sql.dup()
}

fn (mut this Class_WP_Meta_Query) get_sql_for_query(var_query rt.PhpVal, depth i64) rt.PhpVal {
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
		mut iter_1 := var_query.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_clause := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
				mut var_relation := var_query.array_get('relation')
			} else if rt.is_true(rt.new_bool(var_clause.dup().is_array())) {
				if this.is_first_order_clause(var_clause.dup()) {
					mut var_clause_sql := this.get_sql_for_clause(var_clause.dup(), var_query.dup(), (var_key).str())
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

fn (mut this Class_WP_Meta_Query) get_sql_for_clause(var_clause rt.PhpVal, var_parent_query rt.PhpVal, clause_key string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_clause_mutated := var_clause
	mut clause_key_mutated := clause_key
	// unsupported statement: Stmt_Global
	mut var_sql_chunks := { 'where': rt.new_array(), 'join': rt.new_array() }
	if var_clause_mutated.array_isset(rt.new_string('compare')) {
		var_clause_mutated.array_set('compare', var_clause_mutated.array_get('compare').to_string().to_upper())
	} else {
		var_clause_mutated.array_set('compare', if rt.is_true(rt.new_bool(var_clause_mutated.array_isset(rt.new_string('value')) && rt.is_true(rt.new_bool(var_clause_mutated.array_get('value').is_array())))) { 'IN' } else { '=' })
	}
	mut var_non_numeric_operators := ['=', '!=', 'LIKE', 'NOT LIKE', 'IN', 'NOT IN', 'EXISTS', 'NOT EXISTS', 'RLIKE', 'REGEXP', 'NOT REGEXP']
	mut var_numeric_operators := ['>', '>=', '<', '<=', 'BETWEEN', 'NOT BETWEEN']
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_clause_mutated.array_get('compare'), var_non_numeric_operators.dup(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_clause_mutated.array_get('compare'), var_numeric_operators.dup(), rt.new_bool(true)]))))))) {
		var_clause_mutated.array_set('compare', '=')
	}
	if var_clause_mutated.array_isset(rt.new_string('compare_key')) {
		var_clause_mutated.array_set('compare_key', var_clause_mutated.array_get('compare_key').to_string().to_upper())
	} else {
		var_clause_mutated.array_set('compare_key', if rt.is_true(rt.new_bool(var_clause_mutated.array_isset(rt.new_string('key')) && rt.is_true(rt.new_bool(var_clause_mutated.array_get('key').is_array())))) { 'IN' } else { '=' })
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_clause_mutated.array_get('compare_key'), var_non_numeric_operators.dup(), rt.new_bool(true)]))))) {
		var_clause_mutated.array_set('compare_key', '=')
	}
	mut var_meta_compare := var_clause_mutated.array_get('compare')
	mut var_meta_compare_key := var_clause_mutated.array_get('compare_key')
	mut var_join := rt.new_string(rt.new_string(''))
	mut var_alias := this.find_compatible_table_alias(var_clause_mutated.dup(), var_parent_query.dup())
	if rt.is_true(rt.identical(rt.new_bool(false), var_alias)) {
		mut var_i := rt.new_int(rt.new_int(this.table_aliases.array_count()))
		var_alias = if rt.is_true(var_i) { 'mt' + (var_i).str() } else { this.meta_table }
		if rt.is_true(rt.identical(rt.new_string('NOT EXISTS'), var_meta_compare)) {
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.identical(rt.new_string('LIKE'), var_meta_compare_key)) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				
			}
			// unsupported statement: Stmt_Nop
		} else {
		}
		
	}
	
}

fn (mut this Class_WP_Meta_Query) get_clauses() rt.PhpVal {
}

fn (mut this Class_WP_Meta_Query) find_compatible_table_alias(var_clause rt.PhpVal, var_parent_query rt.PhpVal) rt.PhpVal {
	mut var_clause_mutated := var_clause
}

fn (mut this Class_WP_Meta_Query) has_or_relation() bool {
}

fn create_wp_meta_query(arg_0 rt.PhpVal) &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		queries: rt.new_array()
		relation: ''
		meta_table: rt.new_null()
		meta_id_column: rt.new_null()
		primary_table: rt.new_null()
		primary_id_column: rt.new_null()
		table_aliases: rt.new_array()
		clauses: rt.new_array()
		has_or_relation: false
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Meta_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'is_first_order_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_first_order_clause(dispatch_arg_0))
		}
		'parse_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.parse_query_vars(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cast_for_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_cast_for_type(dispatch_arg_0))
		}
		'get_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.get_sql(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
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
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_sql_for_clause(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_clauses' {
			return this.get_clauses()
		}
		'find_compatible_table_alias' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.find_compatible_table_alias(dispatch_arg_0, dispatch_arg_1)
		}
		'has_or_relation' {
			return rt.new_bool(this.has_or_relation())
		}
		else { return none }
	}
}

fn (this &Class_WP_Meta_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queries' { return this.queries }
		'relation' { return rt.new_string(this.relation) }
		'meta_table' { return this.meta_table }
		'meta_id_column' { return this.meta_id_column }
		'primary_table' { return this.primary_table }
		'primary_id_column' { return this.primary_id_column }
		'table_aliases' { return this.table_aliases }
		'clauses' { return this.clauses }
		'has_or_relation' { return rt.new_bool(this.has_or_relation) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Meta_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queries' { this.queries = val; return true }
		'relation' { this.relation = (val).str(); return true }
		'meta_table' { this.meta_table = val; return true }
		'meta_id_column' { this.meta_id_column = val; return true }
		'primary_table' { this.primary_table = val; return true }
		'primary_id_column' { this.primary_id_column = val; return true }
		'table_aliases' { this.table_aliases = val; return true }
		'clauses' { this.clauses = val; return true }
		'has_or_relation' { this.has_or_relation = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_meta_query_php() {
}
