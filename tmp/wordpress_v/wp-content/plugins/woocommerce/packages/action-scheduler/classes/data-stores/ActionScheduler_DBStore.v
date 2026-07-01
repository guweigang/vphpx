import rt
import crypto.md5

struct Class_ActionScheduler_DBStore {
	rt.PhpObjectBase
pub mut:
		claim_before_date rt.PhpVal = rt.new_null()
		max_args_length rt.PhpVal = rt.new_int(8000)
		max_index_length rt.PhpVal = rt.new_int(191)
		claim_filters rt.PhpVal = rt.new_array()
}

fn (mut this Class_ActionScheduler_DBStore) init()  {
	mut var_table_maker := create_actionscheduler_storeschema()
	var_table_maker.init()
	var_table_maker.register_tables()
}

fn (mut this Class_ActionScheduler_DBStore) save_unique_action(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime) rt.PhpVal {
	mut var_action_mutated := var_action
	return rt.new_int(this.save_action_to_db(mut var_action_mutated, mut var_scheduled_date, true))
}

fn (mut this Class_ActionScheduler_DBStore) save_action(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime) rt.PhpVal {
	mut var_action_mutated := var_action
	return rt.new_int(this.save_action_to_db(mut var_action_mutated, mut var_scheduled_date, false))
}

fn (mut this Class_ActionScheduler_DBStore) save_action_to_db(mut var_action Class_ActionScheduler_Action, mut var_date Class_?DateTime, unique bool) i64 {
	mut var_wpdb := rt.new_null()
	mut var_action_mutated := var_action
	mut var_date_mutated := var_date
	// unsupported statement: Stmt_Global
	this.validate_action(rt.new_object('ActionScheduler_Action', []string{}, var_action_mutated))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'hook', val: rt.call_method(var_action_mutated, 'get_hook', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: if rt.is_true(rt.call_method(var_action_mutated, 'is_finished', []rt.PhpVal{})) { Class_ActionScheduler_DBStore.status_complete() } else { Class_ActionScheduler_DBStore.status_pending() } }, rt.ArrayItem{ key: 'scheduled_date_gmt', val: this.get_scheduled_date_string(rt.new_object('ActionScheduler_Action', []string{}, var_action_mutated), rt.new_object('?DateTime', []string{}, var_date_mutated)) }, rt.ArrayItem{ key: 'scheduled_date_local', val: this.get_scheduled_date_string_local(rt.new_object('ActionScheduler_Action', []string{}, var_action_mutated), rt.new_object('?DateTime', []string{}, var_date_mutated)) }, rt.ArrayItem{ key: 'schedule', val: rt.call_function('serialize', [rt.call_method(var_action_mutated, 'get_schedule', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'group_id', val: rt.call_function('current', [this.get_group_ids(rt.call_method(var_action_mutated, 'get_group', []rt.PhpVal{}), false)]) }, rt.ArrayItem{ key: 'priority', val: rt.call_method(var_action_mutated, 'get_priority', []rt.PhpVal{}) }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_args := rt.call_function('wp_json_encode', [rt.call_method(var_action_mutated, 'get_args', []rt.PhpVal{})])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.less_equal(rt.new_int(var_args.dup().to_string().len), // unsupported expression: Expr_StaticPropertyFetch)) {
		var_data.array_set('args', var_args.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		var_data.array_set('args', this.hash_args(var_args.dup()))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_data.array_set('extended_args', var_args.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_insert_sql := this.build_insert_sql(mut rt.cast_object_ptr[Class_array](var_data), rt.new_bool(unique))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_wpdb, 'query', [var_insert_sql.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_action_id := rt.get_property(var_wpdb, 'insert_id')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_action_id.dup()])) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_method(var_action_id, 'get_error_message', []rt.PhpVal{}))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if !rt.is_true(var_action_id) {
		if var_unique {
			return 0
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(if rt.is_true(rt.get_property(var_wpdb, 'last_error')) { rt.get_property(var_wpdb, 'last_error') } else { rt.call_function('__', [rt.new_string('Database error.'), rt.new_string('woocommerce')]) })))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('action_scheduler_stored_action'), var_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return (var_action_id).to_i64()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error saving action: %s'), rt.new_string('woocommerce')]), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.new_int(0))))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return i64(0)
}

fn (mut this Class_ActionScheduler_DBStore) build_insert_sql(mut var_data Class_array, var_unique rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	mut var_columns := rt.func_array_keys(var_data_mutated.dup())
	mut var_values := rt.call_function('array_values', [var_data_mutated.dup()])
	mut var_placeholders := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_DBStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'get_placeholder_for_column' }]), var_columns.dup()])
	mut var_table_name := if !(!rt.is_true(rt.get_property(var_wpdb, 'actionscheduler_actions'))) { rt.get_property(var_wpdb, 'actionscheduler_actions') } else { (rt.get_property(var_wpdb, 'prefix')).str() + 'actionscheduler_actions' }
	mut var_column_sql := rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`, `'), var_columns.dup()])).str() + '`')
	mut var_placeholder_sql := rt.call_function('implode', [rt.new_string(', '), var_placeholders.dup()])
	mut var_where_clause := rt.new_string(this.build_where_clause_for_insert(rt.new_object('array', []string{}, var_data_mutated), var_table_name.dup(), var_unique.dup()))
	mut var_insert_query := rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nINSERT INTO ${var_table_name.to_string()} ( ${var_column_sql.to_string()} )\nSELECT ${var_placeholder_sql.to_string()} FROM DUAL\nWHERE ( ${var_where_clause.to_string()} ) IS NULL"), var_values.dup()])
	return var_insert_query.dup()
}

fn (mut this Class_ActionScheduler_DBStore) build_where_clause_for_insert(var_data rt.PhpVal, var_table_name rt.PhpVal, var_unique rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	mut var_table_name_mutated := var_table_name
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(var_unique)))) {
		return 'SELECT NULL FROM DUAL'
	}
	mut var_pending_statuses := [Class_ActionScheduler_Store.status_pending(), Class_ActionScheduler_Store.status_running()]
	mut var_pending_status_placeholders := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_pending_statuses.len), rt.new_string('%s')])])
	mut var_where_clause := rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nSELECT action_id FROM ${var_table_name.to_string()}\nWHERE status IN ( ${var_pending_status_placeholders.to_string()} )\nAND hook = %s\nAND `group_id` = %d\n"), rt.call_function('array_merge', [var_pending_statuses.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_data_mutated.array_get('hook') }, rt.ArrayItem{ key: none, val: var_data_mutated.array_get('group_id') }])])])
	return "${var_where_clause.to_string()}" + ' LIMIT 1'
}

fn (mut this Class_ActionScheduler_DBStore) get_placeholder_for_column(var_column_name rt.PhpVal) string {
	mut var_string_columns := ['hook', 'status', 'scheduled_date_gmt', 'scheduled_date_local', 'args', 'schedule', 'last_attempt_gmt', 'last_attempt_local', 'extended_args']
	return if rt.is_true(rt.call_function('in_array', [var_column_name.dup(), var_string_columns.dup(), rt.new_bool(true)])) { '%s' } else { '%d' }
}

fn (mut this Class_ActionScheduler_DBStore) hash_args(var_args rt.PhpVal) string {
	mut var_args_mutated := var_args
	return md5.hexhash(var_args_mutated.dup().to_string())
}

fn (mut this Class_ActionScheduler_DBStore) get_args_for_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_encoded := rt.call_function('wp_json_encode', [var_args_mutated.dup()])
	if rt.is_true(rt.less_equal(rt.new_int(var_encoded.dup().to_string().len), // unsupported expression: Expr_StaticPropertyFetch)) {
		return var_encoded.dup()
	}
	return rt.new_string(this.hash_args(var_encoded.dup()))
}

fn (mut this Class_ActionScheduler_DBStore) get_group_ids(var_slugs rt.PhpVal, create_if_not_exists bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_slugs_mutated := var_slugs
	var_slugs_mutated = rt.cast_array(var_slugs_mutated)
	mut var_group_ids := rt.new_array()
	if !rt.is_true(var_slugs_mutated) {
		return rt.new_array()
	}
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := var_slugs_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_slug := item_1.val
			mut var_group_id := // unsupported expression: Expr_Cast_Int
			if !rt.is_true(var_group_id) && var_create_if_not_exists {
				var_group_id = this.create_group(var_slug.dup())
			}
			if rt.is_true(var_group_id) {
				var_group_ids.array_push(var_group_id.dup())
			}
		}
	}
	return var_group_ids.dup()
}

fn (mut this Class_ActionScheduler_DBStore) create_group(var_slug rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'actionscheduler_groups'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }])])
	return // unsupported expression: Expr_Cast_Int
}

fn (mut this Class_ActionScheduler_DBStore) fetch_action(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
	// unsupported statement: Stmt_Global
	mut var_data := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT a.*, g.slug AS `group` FROM '), rt.get_property(var_wpdb, 'actionscheduler_actions')), rt.new_string(' a LEFT JOIN ')), rt.get_property(var_wpdb, 'actionscheduler_groups')), rt.new_string(' g ON a.group_id=g.group_id WHERE a.action_id=%d')), var_action_id_mutated.dup()])])
	if !rt.is_true(var_data) {
		return this.get_null_action()
	}
	if !(!rt.is_true(rt.get_property(var_data, 'extended_args'))) {
		rt.set_property(var_data, 'args', rt.get_property(var_data, 'extended_args'))
		rt.get_property(var_data, 'extended_args') = rt.new_null()
	}
	mut var_date_fields := ['scheduled_date_gmt', 'scheduled_date_local', 'last_attempt_gmt', 'last_attempt_gmt']
	for var_date_field in var_date_fields {
		if rt.is_true(rt.new_bool(rt.get_property(var_data, '{"nodeType":"Expr_Variable","line":362,"name":"date_field"}').is_null())) {
			rt.set_property(var_data, '{"nodeType":"Expr_Variable","line":363,"name":"date_field"}', Class_ActionScheduler_StoreSchema.default_date())
		}
	}
	mut var_action := this.make_action_from_db_record(var_data.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'ActionScheduler_InvalidActionException') {
		mut var_exception := var_e_2.dup()
		rt.call_function('do_action', [rt.new_string('action_scheduler_failed_fetch_action'), var_action_id_mutated.dup(), var_exception.dup()])
		return this.get_null_action()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return var_action.dup()
}

fn (mut this Class_ActionScheduler_DBStore) get_null_action() rt.PhpVal {
	return create_actionscheduler_nullaction()
}

fn (mut this Class_ActionScheduler_DBStore) make_action_from_db_record(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_hook := rt.get_property(var_data_mutated, 'hook')
	mut var_args := rt.call_function('json_decode', [rt.get_property(var_data_mutated, 'args'), rt.new_bool(true)])
	mut var_schedule := rt.call_function('unserialize', [rt.get_property(var_data_mutated, 'schedule')])
	this.validate_args(var_args.dup(), rt.get_property(var_data_mutated, 'action_id'))
	this.validate_schedule(var_schedule.dup(), rt.get_property(var_data_mutated, 'action_id'))
	if !rt.is_true(var_schedule) {
		var_schedule = create_actionscheduler_nullschedule()
	}
	mut var_group := if rt.is_true(rt.get_property(var_data_mutated, 'group')) { rt.get_property(var_data_mutated, 'group') } else { rt.new_string('') }
	return rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.factory() }(), 'get_stored_action', [rt.get_property(var_data_mutated, 'status'), rt.get_property(var_data_mutated, 'hook'), var_args.dup(), var_schedule.dup(), var_group.dup(), rt.get_property(var_data_mutated, 'priority')])
}

fn (mut this Class_ActionScheduler_DBStore) get_query_actions_sql(mut var_query Class_array, select_or_count string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(select_or_count), rt.create_array([rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'count' }]), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('Invalid value for select or count parameter. Cannot query actions.'), rt.new_string('woocommerce')]))))
	}
	var_query_mutated = rt.call_function('wp_parse_args', [var_query_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'hook', val: '' }, rt.ArrayItem{ key: 'args', val: rt.new_null() }, rt.ArrayItem{ key: 'partial_args_matching', val: 'off' }, rt.ArrayItem{ key: 'date', val: rt.new_null() }, rt.ArrayItem{ key: 'date_compare', val: '<=' }, rt.ArrayItem{ key: 'modified', val: rt.new_null() }, rt.ArrayItem{ key: 'modified_compare', val: '<=' }, rt.ArrayItem{ key: 'group', val: '' }, rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'claimed', val: rt.new_null() }, rt.ArrayItem{ key: 'per_page', val: 5 }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'ASC' }])])
	// unsupported statement: Stmt_Global
	mut var_db_server_info := if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_wpdb }, rt.ArrayItem{ key: none, val: 'db_server_info' }])])) { rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{}) } else { rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{}) }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_supports_json := rt.call_function('version_compare', [if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80016))) { rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{}) } else { rt.call_function('preg_replace', [rt.new_string('/[^0-9.].*/'), rt.new_string(''), rt.call_function('str_replace', [rt.new_string('5.5.5-'), rt.new_string(''), var_db_server_info.dup()])]) }, rt.new_string('10.2'), rt.new_string('>=')])
	} else {
		var_supports_json = rt.call_function('version_compare', [rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{}), rt.new_string('5.7'), rt.new_string('>=')])
	}
	mut var_sql := rt.new_string(if rt.is_true(rt.identical(rt.new_string('count'), rt.new_string(select_or_count))) { rt.new_string('SELECT count(a.action_id)') } else { rt.new_string('SELECT a.action_id') })
	// unsupported expression: Expr_AssignOp_Concat
	mut var_sql_params := rt.new_array()
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_query_mutated.array_get('group'))) || rt.is_true(rt.identical(rt.new_string('group'), var_query_mutated.array_get('orderby'))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(var_query_mutated.array_get('group'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params.array_push(var_query_mutated.array_get('group'))
	}
	if !(!rt.is_true(var_query_mutated.array_get('hook'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params.array_push(var_query_mutated.array_get('hook'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_query_mutated.array_get('args').is_null()))))) {
		mut switch_val_1 := var_query_mutated.array_get('partial_args_matching')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('json'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_json)))) {
				rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception()))
			}
			mut var_supported_types := rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
			{
				mut iter_1 := .array_get().iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, )) {
		} else if rt.is_true(rt.equal(switch_val_1, )) {
		} else {
		}
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	} else if rt.is_true() {
	} else if rt.is_true() {
	}
	if !(!rt.is_true()) {
	}
	if rt.is_true() {
	}
	if !(!rt.is_true()) {
	}
	return .dup()
}

fn (mut this Class_ActionScheduler_DBStore) query_actions(var_query rt.PhpVal, query_type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) action_counts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) cancel_action(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
}

fn (mut this Class_ActionScheduler_DBStore) cancel_actions_by_hook(var_hook rt.PhpVal)  {
	mut var_hook_mutated := var_hook
}

fn (mut this Class_ActionScheduler_DBStore) cancel_actions_by_group(var_group rt.PhpVal)  {
	mut var_group_mutated := var_group
}

fn (mut this Class_ActionScheduler_DBStore) bulk_cancel_actions(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_ActionScheduler_DBStore) delete_action(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
}

fn (mut this Class_ActionScheduler_DBStore) get_date(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_action_id_mutated := var_action_id
}

fn (mut this Class_ActionScheduler_DBStore) get_date_gmt(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) stake_claim(max_actions i64, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) rt.PhpVal {
	mut var_before_date_mutated := var_before_date
	mut var_hooks_mutated := var_hooks
	mut group_mutated := group
}

fn (mut this Class_ActionScheduler_DBStore) generate_claim_id() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) set_claim_filter(var_filter_name rt.PhpVal, var_filter_values rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_DBStore) get_claim_filter(var_filter_name rt.PhpVal) string {
}

fn (mut this Class_ActionScheduler_DBStore) claim_actions(var_claim_id rt.PhpVal, var_limit rt.PhpVal, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_claim_id_mutated := var_claim_id
	mut var_before_date_mutated := var_before_date
	mut var_hooks_mutated := var_hooks
	mut group_mutated := group
}

fn (mut this Class_ActionScheduler_DBStore) db_supports_skip_locked() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) get_claim_count() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) get_claim_id(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) find_actions_by_claim_id(var_claim_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_claim_id_mutated := var_claim_id
}

fn (mut this Class_ActionScheduler_DBStore) release_claim(mut var_claim Class_ActionScheduler_ActionClaim)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_DBStore) unclaim_action(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
}

fn (mut this Class_ActionScheduler_DBStore) mark_failure(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
}

fn (mut this Class_ActionScheduler_DBStore) log_execution(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
}

fn (mut this Class_ActionScheduler_DBStore) mark_complete(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
}

fn (mut this Class_ActionScheduler_DBStore) get_status(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_action_id_mutated := var_action_id
	return rt.new_null()
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_StoreSchema {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullAction {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullSchedule {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_actionscheduler_dbstore() &Class_ActionScheduler_DBStore {
	mut obj := &Class_ActionScheduler_DBStore{
		PhpObjectBase: rt.PhpObjectBase{}
		claim_before_date: rt.new_null()
		max_args_length: rt.new_int(8000)
		max_index_length: rt.new_int(191)
		claim_filters: rt.new_array()
	}
	return obj
}

fn create_actionscheduler_store() &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_storeschema() &Class_ActionScheduler_StoreSchema {
	mut obj := &Class_ActionScheduler_StoreSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception() &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nullaction() &Class_ActionScheduler_NullAction {
	mut obj := &Class_ActionScheduler_NullAction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nullschedule() &Class_ActionScheduler_NullSchedule {
	mut obj := &Class_ActionScheduler_NullSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_DBStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'save_unique_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.save_unique_action(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'save_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.save_action(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'save_action_to_db' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.save_action_to_db(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'build_insert_sql' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.build_insert_sql(mut dispatch_arg_0, dispatch_arg_1)
		}
		'build_where_clause_for_insert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.build_where_clause_for_insert(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_placeholder_for_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_placeholder_for_column(dispatch_arg_0))
		}
		'hash_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.hash_args(dispatch_arg_0))
		}
		'get_args_for_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_args_for_query(dispatch_arg_0)
		}
		'get_group_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_group_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'create_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_group(dispatch_arg_0)
		}
		'fetch_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_action(dispatch_arg_0)
		}
		'get_null_action' {
			return this.get_null_action()
		}
		'make_action_from_db_record' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.make_action_from_db_record(dispatch_arg_0)
		}
		'get_query_actions_sql' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_query_actions_sql(mut dispatch_arg_0, dispatch_arg_1)
		}
		'query_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.query_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'action_counts' {
			return this.action_counts()
		}
		'cancel_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.cancel_action(dispatch_arg_0)
			return rt.new_null()
		}
		'cancel_actions_by_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.cancel_actions_by_hook(dispatch_arg_0)
			return rt.new_null()
		}
		'cancel_actions_by_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.cancel_actions_by_group(dispatch_arg_0)
			return rt.new_null()
		}
		'bulk_cancel_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bulk_cancel_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_action(dispatch_arg_0)
			return rt.new_null()
		}
		'get_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_date(dispatch_arg_0)
		}
		'get_date_gmt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_date_gmt(dispatch_arg_0)
		}
		'stake_claim' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.stake_claim(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'generate_claim_id' {
			return this.generate_claim_id()
		}
		'set_claim_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_claim_filter(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_claim_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_claim_filter(dispatch_arg_0))
		}
		'claim_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.claim_actions(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'db_supports_skip_locked' {
			return this.db_supports_skip_locked()
		}
		'get_claim_count' {
			return this.get_claim_count()
		}
		'get_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_claim_id(dispatch_arg_0)
		}
		'find_actions_by_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_actions_by_claim_id(dispatch_arg_0)
		}
		'release_claim' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_ActionClaim](if args.len > 0 { args[0] } else { rt.new_null() })
			this.release_claim(mut dispatch_arg_0)
			return rt.new_null()
		}
		'unclaim_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.unclaim_action(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_failure' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mark_failure(dispatch_arg_0)
			return rt.new_null()
		}
		'log_execution' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.log_execution(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mark_complete(dispatch_arg_0)
			return rt.new_null()
		}
		'get_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_status(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_DBStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'claim_before_date' { return this.claim_before_date }
		'max_args_length' { return this.max_args_length }
		'max_index_length' { return this.max_index_length }
		'claim_filters' { return this.claim_filters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_DBStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'claim_before_date' { this.claim_before_date = val; return true }
		'max_args_length' { this.max_args_length = val; return true }
		'max_index_length' { this.max_index_length = val; return true }
		'claim_filters' { this.claim_filters = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_StoreSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_StoreSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_StoreSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_NullAction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_NullAction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullAction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_NullSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_NullSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_data_stores_actionscheduler_dbstore_php() {
}
