import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery.valid_comparison_operators() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '=' },
		rt.ArrayItem{ key: none, val: '!=' }, rt.ArrayItem{ key: none, val: 'LIKE' },
		rt.ArrayItem{ key: none, val: 'NOT LIKE' }, rt.ArrayItem{ key: none, val: 'IN' },
		rt.ArrayItem{ key: none, val: 'NOT IN' }, rt.ArrayItem{ key: none, val: 'EXISTS' },
		rt.ArrayItem{ key: none, val: 'NOT EXISTS' }, rt.ArrayItem{ key: none, val: 'RLIKE' },
		rt.ArrayItem{ key: none, val: 'REGEXP' }, rt.ArrayItem{ key: none, val: 'NOT REGEXP' },
		rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' },
		rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' },
		rt.ArrayItem{ key: none, val: 'BETWEEN' }, rt.ArrayItem{ key: none, val: 'NOT BETWEEN' }])
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery {
	rt.PhpObjectBase
pub mut:
	query            rt.PhpVal = rt.new_null()
	force_no_results bool
	queries          rt.PhpVal = rt.new_array()
	join             rt.PhpVal = rt.new_array()
	where            rt.PhpVal = rt.new_array()
	table_aliases    rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) construct(mut var_q Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) {
	mut var_q_mutated := var_q
	mut var_field_query := rt.call_method(var_q_mutated, 'get', [
		rt.new_string('field_query'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_field_query))))
		|| !(var_field_query.clone().is_array()) {
		return
	}
	this.query = var_q_mutated
	this.queries =
		this.sanitize_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_field_query))
	this.where = if !(this.force_no_results) {
		this.process(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](this.queries))
	} else {
		rt.new_string('1=0')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) sanitize_query(mut var_q Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_sanitized := rt.new_array()
	mut iter_1 := var_q_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_arg := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.identical(rt.new_string('relation'), var_key)) {
			mut var_relation := var_arg.clone()
		} else if !(var_arg.clone().is_array()) {
			continue
		} else if rt.is_true(this.is_atomic(var_arg.clone())) {
			if var_arg.array_isset(rt.new_string('value'))
				&& rt.is_true(rt.identical(rt.new_array(), var_arg.array_get(rt.new_string('value')))) {
				continue
			}
			var_arg.array_set('compare', if !(var_arg.array_get(rt.new_string('compare'))).is_null() {
				var_arg.array_get(rt.new_string('compare'))
			} else {
				rt.new_string('=')
			}.to_string().to_upper())
			var_arg.array_set('compare', if rt.is_true(rt.call_function('in_array', [
				var_arg.array_get(rt.new_string('compare')),
				Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery.valid_comparison_operators(),
				rt.new_bool(true),
			]))
			{ var_arg.array_get(rt.new_string('compare')) } else { rt.new_string('=') })
			if rt.is_true(rt.identical(rt.new_string('='), var_arg.array_get(rt.new_string('compare'))))
				&& var_arg.array_isset(rt.new_string('value'))
				&& var_arg.array_get(rt.new_string('value')).is_array() {
				var_arg.array_set('compare', 'IN')
			}
			var_arg.array_set('cast', this.sanitize_cast_type(if !(var_arg.array_get(rt.new_string('type'))).is_null() {
				var_arg.array_get(rt.new_string('type'))
			} else {
				rt.new_string('')
			}))
			mut var_field_info := rt.call_method(this.query, 'get_field_mapping_info', [
				var_arg.array_get(rt.new_string('field')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_field_info)))) {
				this.force_no_results = true
				continue
			}
			var_arg = rt.call_function('array_merge', [var_arg.clone(),
				var_field_info.clone()])
			var_sanitized.array_set(var_key, var_arg.clone())
		} else {
			mut var_sanitized_arg :=
				this.sanitize_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_arg))
			if rt.is_true(var_sanitized_arg) {
				var_sanitized.array_set(var_key, var_sanitized_arg.clone())
			}
		}
	}
	if rt.is_true(var_sanitized) {
		var_sanitized.array_set('relation', if 1 == var_sanitized.clone().array_count() { 'OR' } else { this.sanitize_relation((if !var_relation.is_null() {
				var_relation
			} else {
				rt.new_string('AND')
			}).str())
		 })
	}
	return var_sanitized.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) sanitize_relation(relation string) string {
	mut relation_mutated := relation
	if !(relation_mutated == '')
		&& rt.is_true(rt.identical(rt.new_string('OR'), rt.new_string(relation_mutated.to_upper()))) {
		return 'OR'
	}
	return 'AND'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) process(mut var_q Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_where := rt.new_string('')
	if !rt.is_true(var_q_mutated) {
		return var_where.clone()
	}
	if rt.is_true(this.is_atomic(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array',
		[]string{}, var_q_mutated)))
	{
		var_q_mutated.array_set('alias', this.find_or_create_table_alias_for_clause(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array',
			[]string{}, var_q_mutated)))
		var_where = rt.new_string(this.generate_where_for_clause(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array',
			[]string{}, var_q_mutated)))
	} else {
		mut var_relation := var_q_mutated.array_get(rt.new_string('relation'))
		var_q_mutated.array_unset(rt.new_string('relation'))
		mut var_chunks := rt.new_array()
		mut iter_2 := var_q_mutated.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_query := item_2.val
			var_chunks.array_push(this.process(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_query)))
		}
		if 1 == var_chunks.clone().array_count() {
			var_where = var_chunks.array_get(rt.new_int(0))
		} else {
			var_where = rt.new_string('(' +
				(rt.call_function('implode', [rt.new_string(' ${var_relation.to_string()} '), var_chunks.clone()])).str() +
				')')
		}
	}
	return var_where.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) is_atomic(var_q rt.PhpVal) rt.PhpVal {
	mut var_q_mutated := var_q
	return rt.new_bool(var_q_mutated.array_isset(rt.new_string('field')))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) find_or_create_table_alias_for_clause(var_q rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_q_mutated := var_q
	if !(!rt.is_true(var_q_mutated.array_get(rt.new_string('alias')))) {
		return var_q_mutated.array_get(rt.new_string('alias'))
	}
	if !rt.is_true(var_q_mutated.array_get(rt.new_string('table')))
		|| !rt.is_true(var_q_mutated.array_get(rt.new_string('column'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
			[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('__', [
			rt.new_string('Missing table info for query arg.'),
			rt.new_string('woocommerce'),
		]))))
	}
	mut var_join := rt.new_string('')
	if var_q_mutated.array_isset(rt.new_string('mapping_id')) {
		mut var_alias := rt.call_method(this.query, 'get_core_mapping_alias', [
			var_q_mutated.array_get(rt.new_string('mapping_id')),
		])
		var_join = rt.call_method(this.query, 'get_core_mapping_join', [
			var_q_mutated.array_get(rt.new_string('mapping_id')),
		])
	} else {
		var_alias = var_q_mutated.array_get(rt.new_string('table'))
		var_join = rt.new_string('')
	}
	if rt.is_true(rt.call_function('in_array', [var_alias.clone(), this.table_aliases,
		rt.new_bool(true)]))
	{
		return var_alias.clone()
	}
	this.table_aliases.array_push(var_alias.clone())
	if rt.is_true(var_join) {
		this.join.array_set(var_alias, var_join.clone())
	}
	return var_alias.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) sanitize_cast_type(var_type rt.PhpVal) string {
	mut var_clause_type := rt.new_string(var_type.clone().to_string().to_upper())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_clause_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(?:BINARY|CHAR|DATE|DATETIME|SIGNED|UNSIGNED|TIME|NUMERIC(?:\\(\\d+(?:,\\s?\\d+)?\\))?|DECIMAL(?:\\(\\d+(?:,\\s?\\d+)?\\))?)$/'), var_clause_type.clone()]))))) {
		return 'CHAR'
	}
	if rt.is_true(rt.identical(rt.new_string('NUMERIC'), var_clause_type)) {
		var_clause_type = rt.new_string('SIGNED')
	}
	return var_clause_type.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) generate_where_for_clause(var_clause rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_clause_value := if !(var_clause.array_get(rt.new_string('value'))).is_null() {
		var_clause.array_get(rt.new_string('value'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.call_function('in_array', [var_clause.array_get(rt.new_string('compare')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'IN' },
			rt.ArrayItem{ key: none, val: 'NOT IN' }, rt.ArrayItem{ key: none, val: 'BETWEEN' },
			rt.ArrayItem{ key: none, val: 'NOT BETWEEN' }]),
		rt.new_bool(true)]))
	{
		if !(var_clause_value.clone().is_array()) {
			var_clause_value = rt.call_function('preg_split', [
				rt.new_string('/[,\\s]+/'),
				var_clause_value.clone(),
			])
		}
	} else if rt.is_true(rt.new_bool(var_clause_value.clone().is_string())) {
		var_clause_value = rt.new_string(var_clause_value.clone().to_string().trim_space())
	}
	mut var_clause_compare := var_clause.array_get(rt.new_string('compare'))
	mut switch_val_1 := var_clause_compare
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('IN')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('NOT IN'))) {
		mut var_where := rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('(' +
				(rt.call_function('substr', [rt.call_function('str_repeat', [rt.new_string(',%s'), rt.new_int(rt.cast_array(var_clause_value).array_count())]), rt.new_int(1)])).str() +
				')'),
			var_clause_value.clone(),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('BETWEEN')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('NOT BETWEEN'))) {
		var_where = rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s AND %s'),
			var_clause_value.array_get(rt.new_int(0)), if !(var_clause_value.array_get(rt.new_int(1))).is_null() {
				var_clause_value.array_get(rt.new_int(1))
			} else {
				var_clause_value.array_get(rt.new_int(0))
			}])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('LIKE')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('NOT LIKE'))) {
		var_where = rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'),
			rt.new_string('%' +
				(rt.call_method(var_wpdb, 'esc_like', [var_clause_value.clone()])).str() + '%')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('EXISTS'))) {
		if rt.is_true(var_clause_value) {
			var_clause_compare = rt.new_string('=')
			var_where = rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('%s'), var_clause_value.clone()])
		} else {
			var_clause_compare = rt.new_string('IS NOT')
			var_where = rt.new_string('NULL')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('NOT EXISTS'))) {
		var_clause_compare = rt.new_string('IS')
		var_where = rt.new_string('NULL')
	} else {
		var_where = rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'),
			var_clause_value.clone()])
	}
	if !(!rt.is_true(var_where)) {
		if rt.is_true(rt.identical(rt.new_string('CHAR'),
			var_clause.array_get(rt.new_string('cast'))))
		{
			return rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'),
				var_clause.array_get(rt.new_string('alias'))), rt.new_string('`.`')),
				var_clause.array_get(rt.new_string('column'))), rt.new_string('` ')),
				var_clause_compare), rt.new_string(' ')), var_where)
		} else {
			return rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST(`'),
				var_clause.array_get(rt.new_string('alias'))), rt.new_string('`.`')),
				var_clause.array_get(rt.new_string('column'))), rt.new_string('` AS ')),
				var_clause.array_get(rt.new_string('cast'))), rt.new_string(') ')),
				var_clause_compare), rt.new_string(' ')), var_where)
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) get_sql_clauses() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'join', val: this.join },
		rt.ArrayItem{
			key: 'where'
			val: if rt.is_true(this.where) { rt.create_array([
					rt.ArrayItem{ key: none, val: this.where },
				]) } else { rt.new_array() }
		}])
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablefieldquery(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery{
		PhpObjectBase:    rt.PhpObjectBase{}
		query:            rt.new_null()
		force_no_results: false
		queries:          rt.new_array()
		join:             rt.new_array()
		where:            rt.new_array()
		table_aliases:    rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.sanitize_query(mut dispatch_arg_0)
		}
		'sanitize_relation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.sanitize_relation(dispatch_arg_0))
		}
		'process' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.process(mut dispatch_arg_0)
		}
		'is_atomic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_atomic(dispatch_arg_0)
		}
		'find_or_create_table_alias_for_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_or_create_table_alias_for_clause(dispatch_arg_0)
		}
		'sanitize_cast_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.sanitize_cast_type(dispatch_arg_0))
		}
		'generate_where_for_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.generate_where_for_clause(dispatch_arg_0))
		}
		'get_sql_clauses' {
			return this.get_sql_clauses()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query' { return this.query }
		'force_no_results' { return rt.new_bool(this.force_no_results) }
		'queries' { return this.queries }
		'join' { return this.join }
		'where' { return this.where }
		'table_aliases' { return this.table_aliases }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableFieldQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query' {
			this.query = val
			return true
		}
		'force_no_results' {
			this.force_no_results = val.to_bool()
			return true
		}
		'queries' {
			this.queries = val
			return true
		}
		'join' {
			this.join = val
			return true
		}
		'where' {
			this.where = val
			return true
		}
		'table_aliases' {
			this.table_aliases = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
