import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery.non_numeric_operators() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '=' }, rt.ArrayItem{ key: none, val: '!=' }, rt.ArrayItem{ key: none, val: 'LIKE' }, rt.ArrayItem{ key: none, val: 'NOT LIKE' }, rt.ArrayItem{ key: none, val: 'IN' }, rt.ArrayItem{ key: none, val: 'NOT IN' }, rt.ArrayItem{ key: none, val: 'EXISTS' }, rt.ArrayItem{ key: none, val: 'NOT EXISTS' }, rt.ArrayItem{ key: none, val: 'RLIKE' }, rt.ArrayItem{ key: none, val: 'REGEXP' }, rt.ArrayItem{ key: none, val: 'NOT REGEXP' }])
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery.numeric_operators() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: 'BETWEEN' }, rt.ArrayItem{ key: none, val: 'NOT BETWEEN' }])
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery.alias_prefix() string {
	return 'meta'
}
struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery {
	rt.PhpObjectBase
pub mut:
		meta_table rt.PhpVal = rt.new_string('')
		orders_table rt.PhpVal = rt.new_string('')
		queries rt.PhpVal = rt.new_array()
		flattened_clauses rt.PhpVal = rt.new_array()
		join rt.PhpVal = rt.new_array()
		where rt.PhpVal = rt.new_array()
		table_aliases rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) construct(mut var_q Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery)  {
	mut var_meta_query := var_q.get(rt.new_string('meta_query'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_query)))) {
		return
	}
	this.queries = this.sanitize_meta_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_meta_query))
	this.meta_table = var_q.get_table_name(rt.new_string('meta'))
	this.orders_table = var_q.get_table_name(rt.new_string('orders'))
	this.build_query()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) get_sql_clauses() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'join', val: this.sanitize_join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](this.join)) }, rt.ArrayItem{ key: 'where', val: this.flatten_where_clauses(this.where) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) get_orderby_keys() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.flattened_clauses)))) {
		return rt.new_array()
	}
	mut var_keys := rt.new_array()
	var_keys.array_push('meta_value')
	var_keys.array_push('meta_value_num')
	mut var_first_clause := rt.call_function('reset', [this.flattened_clauses])
	if rt.is_true(rt.new_bool(rt.is_true(var_first_clause) && !(!rt.is_true(var_first_clause.array_get('key'))))) {
		var_keys.array_push(var_first_clause.array_get('key'))
	}
	var_keys = rt.call_function('array_merge', [var_keys.dup(), rt.func_array_keys(this.flattened_clauses)])
	return var_keys.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) get_orderby_clause_for_key(key string) string {
	mut var_clause := rt.new_bool(rt.new_bool(false))
	if this.flattened_clauses.array_isset(rt.new_string(key)) {
		var_clause = this.flattened_clauses.array_get(key)
	} else {
		mut var_first_clause := rt.call_function('reset', [this.flattened_clauses])
		if rt.is_true(rt.new_bool(rt.is_true(var_first_clause) && !(!rt.is_true(var_first_clause.array_get('key'))))) {
			if rt.is_true(rt.identical(rt.new_string('meta_value_num'), rt.new_string(key))) {
				return rt.concat(var_first_clause.array_get('alias'), rt.new_string('.meta_value+0'))
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('meta_value'), rt.new_string(key))) || rt.is_true(rt.identical(var_first_clause.array_get('key'), rt.new_string(key))))) {
				var_clause = var_first_clause.dup()
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_clause)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid meta_query clause key: %s.'), rt.new_string('woocommerce')]), rt.new_string(key)]))))
	}
	return rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST('), var_clause.array_get('alias')), rt.new_string('.meta_value AS ')), var_clause.array_get('cast')), rt.new_string(')'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) is_atomic(mut var_arg Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) bool {
	mut var_arg_mutated := var_arg
	return var_arg_mutated.array_isset(rt.new_string('key')) || var_arg_mutated.array_isset(rt.new_string('value'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) sanitize_meta_query(mut var_q Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_sanitized := rt.new_array()
	{
		mut iter_1 := var_q.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
				mut var_relation := var_arg.dup()
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_arg.dup().is_array()))))) {
				continue
			} else if this.is_atomic(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_arg)) {
				if rt.is_true(rt.new_bool(var_arg.array_isset(rt.new_string('value')) && rt.is_true(rt.identical(rt.new_array(), var_arg.array_get('value'))))) {
					var_arg.array_unset(rt.new_string('value'))
				}
				var_arg.array_set('compare', if var_arg.array_isset(rt.new_string('compare')) { var_arg.array_get('compare').to_string().to_upper() } else { if rt.is_true(rt.new_bool(var_arg.array_isset(rt.new_string('value')) && rt.is_true(rt.new_bool(var_arg.array_get('value').is_array())))) { 'IN' } else { '=' } })
				var_arg.array_set('compare_key', if var_arg.array_isset(rt.new_string('compare_key')) { var_arg.array_get('compare_key').to_string().to_upper() } else { if rt.is_true(rt.new_bool(var_arg.array_isset(rt.new_string('key')) && rt.is_true(rt.new_bool(var_arg.array_get('key').is_array())))) { 'IN' } else { '=' } })
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_arg.array_get('compare'), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery.non_numeric_operators(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_arg.array_get('compare'), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery.numeric_operators(), rt.new_bool(true)]))))))) {
					var_arg.array_set('compare', '=')
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_arg.array_get('compare_key'), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery.non_numeric_operators(), rt.new_bool(true)]))))) {
					var_arg.array_set('compare_key', '=')
				}
				var_sanitized.array_set(var_key, var_arg.dup())
				var_sanitized.array_get_mut(var_key).array_set('index', var_key.dup())
			} else {
				mut var_sanitized_arg := this.sanitize_meta_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_arg))
				if rt.is_true(var_sanitized_arg) {
					var_sanitized.array_set(var_key, var_sanitized_arg.dup())
				}
			}
		}
	}
	if rt.is_true(var_sanitized) {
		var_sanitized.array_set('relation', if 1 == var_sanitized.dup().array_count() { 'OR' } else { this.sanitize_relation((if !(var_relation).is_null() { var_relation } else { rt.new_string('AND') }).str()) })
	}
	return var_sanitized.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) sanitize_relation(relation string) string {
	mut relation_mutated := relation
	if rt.is_true(rt.new_bool(!(relation_mutated == '') && rt.is_true(rt.identical(rt.new_string('OR'), rt.new_string(relation_mutated.to_upper()))))) {
		return 'OR'
	}
	return 'AND'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) sanitize_cast_type(type string) string {
	mut var_meta_type := rt.new_string(rt.new_string(type.to_upper()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(?:BINARY|CHAR|DATE|DATETIME|SIGNED|UNSIGNED|TIME|NUMERIC(?:\\(\\d+(?:,\\s?\\d+)?\\))?|DECIMAL(?:\\(\\d+(?:,\\s?\\d+)?\\))?)$/'), var_meta_type.dup()]))))))) {
		return 'CHAR'
	}
	if rt.is_true(rt.identical(rt.new_string('NUMERIC'), var_meta_type)) {
		var_meta_type = rt.new_string(rt.new_string('SIGNED'))
	}
	return (var_meta_type).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) sanitize_join(mut var_join Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	return rt.call_function('array_filter', [rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('trim'), var_join])])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) flatten_where_clauses(var_where rt.PhpVal) string {
	mut var_where_mutated := var_where
	if rt.is_true(rt.new_bool(var_where_mutated.dup().is_string())) {
		return var_where_mutated.dup().to_string().trim_space()
	}
	mut var_chunks := rt.new_array()
	mut var_operator := rt.new_string(this.sanitize_relation((if !(var_where_mutated.array_get('operator')).is_null() { var_where_mutated.array_get('operator') } else { rt.new_string('') }).str()))
	{
		mut iter_1 := var_where_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_w := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('operator'), var_key)) {
				continue
			}
			mut var_flattened := rt.new_string(this.flatten_where_clauses(var_w.dup()))
			if rt.is_true(var_flattened) {
				var_chunks.array_push(var_flattened.dup())
			}
		}
	}
	if rt.is_true(var_chunks) {
		return '(' + (rt.call_function('implode', [rt.new_string(" ${var_operator.to_string()} "), var_chunks.dup()])).str() + ')'
	} else {
		return ''
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) build_query()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.queries)))) {
		return rt.new_null()
	}
	mut var_queries := this.queries
	mut var_sql_where := this.process(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_queries), rt.new_null())
	this.where = var_sql_where.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) process(mut var_arg Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, var_parent rt.PhpVal) rt.PhpVal {
	mut var_arg_mutated := var_arg
	mut var_where := rt.new_array()
	if this.is_atomic(mut var_arg_mutated) {
		var_arg_mutated.array_set('alias', this.find_or_create_table_alias_for_clause(mut var_arg_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_parent)))
		var_arg_mutated.array_set('cast', this.sanitize_cast_type((if !(var_arg_mutated.array_get('type')).is_null() { var_arg_mutated.array_get('type') } else { rt.new_string('') }).str()))
		var_where = rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: this.generate_where_for_clause_key(mut var_arg_mutated) }, rt.ArrayItem{ key: none, val: this.generate_where_for_clause_value(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_arg_mutated)) }])])
		mut var_flat_clause_key := if rt.is_true(rt.new_bool(var_arg_mutated.array_get('index').is_long())) { var_arg_mutated.array_get('alias') } else { var_arg_mutated.array_get('index') }
		mut var_unique_flat_key := var_flat_clause_key.dup()
		mut var_i := rt.new_int(rt.new_int(1))
		for this.flattened_clauses.array_isset(var_unique_flat_key) {
			var_unique_flat_key = rt.new_string((var_flat_clause_key).str() + '-' + (var_i).str())
			rt.pre_inc(var_i)
		}
		// unsupported expression: Expr_AssignRef
	} else {
		mut var_relation := var_arg_mutated.array_get('relation')
		var_arg_mutated.array_unset(rt.new_string('relation'))
		mut var_chunks := rt.new_array()
		{
			mut iter_1 := var_arg_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_clause := item_1.val
				mut var_index := item_1.key
				var_chunks.array_push(this.process(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_clause), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_arg_mutated)))
			}
		}
		if 1 == var_chunks.dup().array_count() {
			var_where = var_chunks.array_get(0)
		} else {
			var_where = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'operator', val: var_relation }]), var_chunks.dup()])
		}
	}
	return var_where.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) generate_join_for_clause(mut var_clause Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, alias string) string {
	mut var_wpdb := rt.new_null()
	mut var_clause_mutated := var_clause
	mut alias_mutated := alias
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string('NOT EXISTS'), var_clause_mutated.array_get('compare'))) {
		if rt.is_true(rt.identical(rt.new_string('LIKE'), var_clause_mutated.array_get('compare_key'))) {
			return (rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN '), this.meta_table), rt.new_string(' AS ')), rt.new_string(alias_mutated)), rt.new_string(' ON ( ')), this.orders_table), rt.new_string('.id = ')), rt.new_string(alias_mutated)), rt.new_string('.order_id AND ')), rt.new_string(alias_mutated)), rt.new_string('.meta_key LIKE %s )')), '%' + (rt.call_method(var_wpdb, 'esc_like', [var_clause_mutated.array_get('key')])).str() + '%'])).str()
		} else {
			return (rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN '), this.meta_table), rt.new_string(' AS ')), rt.new_string(alias_mutated)), rt.new_string(' ON ( ')), this.orders_table), rt.new_string('.id = ')), rt.new_string(alias_mutated)), rt.new_string('.order_id AND ')), rt.new_string(alias_mutated)), rt.new_string('.meta_key = %s )')), var_clause_mutated.array_get('key')])).str()
		}
	}
	return rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INNER JOIN '), this.meta_table), rt.new_string(' AS ')), rt.new_string(alias_mutated)), rt.new_string(' ON ( ')), this.orders_table), rt.new_string('.id = ')), rt.new_string(alias_mutated)), rt.new_string('.order_id )'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) find_or_create_table_alias_for_clause(mut var_clause Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_parent_query Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) string {
	mut var_clause_mutated := var_clause
	if !(!rt.is_true(var_clause_mutated.array_get('alias'))) {
		return (var_clause_mutated.array_get('alias')).str()
	}
	mut var_alias := rt.new_bool(rt.new_bool(false))
	mut var_siblings := rt.call_function('array_filter', [var_parent_query, rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'is_atomic' }])])
	{
		mut iter_1 := var_siblings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sibling := item_1.val
			if !rt.is_true(var_sibling.array_get('alias')) {
				continue
			}
			if this.is_operator_compatible_with_shared_join(mut var_clause_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_sibling), (if !(var_parent_query.array_get('relation')).is_null() { var_parent_query.array_get('relation') } else { rt.new_string('AND') }).str()) {
				var_alias = var_sibling.array_get('alias')
				break
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_alias)))) {
		var_alias = rt.new_string((Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery.alias_prefix()).str() + this.table_aliases.array_count().str())
		this.join.array_push(this.generate_join_for_clause(mut var_clause_mutated, (var_alias).str()))
		this.table_aliases.array_push(var_alias.dup())
	}
	return (var_alias).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) is_operator_compatible_with_shared_join(mut var_clause Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_sibling Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, relation string) bool {
	mut var_clause_mutated := var_clause
	mut relation_mutated := relation
	if !(this.is_atomic(mut var_clause_mutated)) || !(this.is_atomic(mut var_sibling)) {
		return false
	}
	mut var_valid_operators := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('OR'), rt.new_string(relation_mutated))) {
		var_valid_operators = 
	} else if rt.is_true(rt.new_bool(.array_isset() && .array_isset() && rt.is_true())) {
		
	}
	return 
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) generate_where_for_clause_key(mut var_clause Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) string {
	mut var_wpdb := rt.new_null()
	mut var_clause_mutated := var_clause
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) generate_where_for_clause_value(var_clause rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_clause_mutated := var_clause
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablemetaquery(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery{
		PhpObjectBase: rt.PhpObjectBase{}
		meta_table: rt.new_string('')
		orders_table: rt.new_string('')
		queries: rt.new_array()
		flattened_clauses: rt.new_array()
		join: rt.new_array()
		where: rt.new_array()
		table_aliases: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_sql_clauses' {
			return this.get_sql_clauses()
		}
		'get_orderby_keys' {
			return this.get_orderby_keys()
		}
		'get_orderby_clause_for_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_orderby_clause_for_key(dispatch_arg_0))
		}
		'is_atomic' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_atomic(mut dispatch_arg_0))
		}
		'sanitize_meta_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sanitize_meta_query(mut dispatch_arg_0)
		}
		'sanitize_relation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.sanitize_relation(dispatch_arg_0))
		}
		'sanitize_cast_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.sanitize_cast_type(dispatch_arg_0))
		}
		'sanitize_join' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sanitize_join(mut dispatch_arg_0)
		}
		'flatten_where_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.flatten_where_clauses(dispatch_arg_0))
		}
		'build_query' {
			this.build_query()
			return rt.new_null()
		}
		'process' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.process(mut dispatch_arg_0, dispatch_arg_1)
		}
		'generate_join_for_clause' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.generate_join_for_clause(mut dispatch_arg_0, dispatch_arg_1))
		}
		'find_or_create_table_alias_for_clause' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.find_or_create_table_alias_for_clause(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'is_operator_compatible_with_shared_join' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_operator_compatible_with_shared_join(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'generate_where_for_clause_key' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_where_for_clause_key(mut dispatch_arg_0))
		}
		'generate_where_for_clause_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.generate_where_for_clause_value(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_table' { return this.meta_table }
		'orders_table' { return this.orders_table }
		'queries' { return this.queries }
		'flattened_clauses' { return this.flattened_clauses }
		'join' { return this.join }
		'where' { return this.where }
		'table_aliases' { return this.table_aliases }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableMetaQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_table' { this.meta_table = val; return true }
		'orders_table' { this.orders_table = val; return true }
		'queries' { this.queries = val; return true }
		'flattened_clauses' { this.flattened_clauses = val; return true }
		'join' { this.join = val; return true }
		'where' { this.where = val; return true }
		'table_aliases' { this.table_aliases = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_datastores_orders_orderstablemetaquery_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
