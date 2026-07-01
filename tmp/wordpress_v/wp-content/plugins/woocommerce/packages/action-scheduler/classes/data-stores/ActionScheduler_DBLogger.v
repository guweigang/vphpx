import rt

struct Class_ActionScheduler_DBLogger {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_DBLogger) log(var_action_id rt.PhpVal, var_message rt.PhpVal, mut var_date Class_?DateTime) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_message_mutated := var_message
	mut var_date_mutated := var_date
	if !rt.is_true(var_date_mutated) {
		var_date_mutated = rt.call_function('as_get_datetime_object', []rt.PhpVal{})
	} else {
		var_date_mutated = // unsupported expression: Expr_Clone
	}
	mut var_date_gmt := rt.call_method(var_date_mutated, 'format', [rt.new_string('Y-m-d H:i:s')])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler_TimezoneHelper{}; return temp.set_local_timezone(arg_0) }(rt.new_object('?DateTime', []string{}, var_date_mutated))
	mut var_date_local := rt.call_method(var_date_mutated, 'format', [rt.new_string('Y-m-d H:i:s')])
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'actionscheduler_logs'), rt.create_array([rt.ArrayItem{ key: 'action_id', val: var_action_id }, rt.ArrayItem{ key: 'message', val: var_message_mutated }, rt.ArrayItem{ key: 'log_date_gmt', val: var_date_gmt }, rt.ArrayItem{ key: 'log_date_local', val: var_date_local }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])])
	return rt.get_property(var_wpdb, 'insert_id')
}

fn (mut this Class_ActionScheduler_DBLogger) get_entry(var_entry_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_entry := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'actionscheduler_logs')), rt.new_string(' WHERE log_id=%d')), var_entry_id.dup()])])
	return this.create_entry_from_db_record(var_entry.dup())
}

fn (mut this Class_ActionScheduler_DBLogger) create_entry_from_db_record(var_record rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_record) {
		return create_actionscheduler_nulllogentry()
	}
	if rt.is_true(rt.new_bool(rt.get_property(var_record, 'log_date_gmt').is_null())) {
		mut var_date := rt.call_function('as_get_datetime_object', [Class_ActionScheduler_StoreSchema.default_date()])
	} else {
		var_date = rt.call_function('as_get_datetime_object', [rt.get_property(var_record, 'log_date_gmt')])
	}
	return create_actionscheduler_logentry(rt.get_property(var_record, 'action_id'), rt.get_property(var_record, 'message'), var_date.dup())
}

fn (mut this Class_ActionScheduler_DBLogger) get_logs(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_records := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'actionscheduler_logs')), rt.new_string(' WHERE action_id=%d')), var_action_id.dup()])])
	return rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_DBLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'create_entry_from_db_record' }]), var_records.dup()])
}

fn (mut this Class_ActionScheduler_DBLogger) init()  {
	mut var_table_maker := create_actionscheduler_loggerschema()
	var_table_maker.init()
	var_table_maker.register_tables()
	this.Class_ActionScheduler_Logger.init()
	rt.call_function('add_action', [rt.new_string('action_scheduler_deleted_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_DBLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'clear_deleted_action_logs' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_ActionScheduler_DBLogger) clear_deleted_action_logs(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'actionscheduler_logs'), rt.create_array([rt.ArrayItem{ key: 'action_id', val: var_action_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
}

fn (mut this Class_ActionScheduler_DBLogger) bulk_log_cancel_actions(var_action_ids rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	if !rt.is_true(var_action_ids) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	mut var_date := rt.call_function('as_get_datetime_object', []rt.PhpVal{})
	mut var_date_gmt := rt.call_method(var_date, 'format', [rt.new_string('Y-m-d H:i:s')])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler_TimezoneHelper{}; return temp.set_local_timezone(arg_0) }(var_date.dup())
	mut var_date_local := rt.call_method(var_date, 'format', [rt.new_string('Y-m-d H:i:s')])
	mut var_message := rt.call_function('__', [rt.new_string('action canceled'), rt.new_string('woocommerce')])
	mut var_format := rt.new_string('(%d, ' + (rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s, %s, %s'), var_message.dup(), var_date_gmt.dup(), var_date_local.dup()])).str() + ')')
	mut var_sql_query := rt.new_string(rt.concat(rt.concat(rt.new_string('INSERT '), rt.get_property(var_wpdb, 'actionscheduler_logs')), rt.new_string(' (action_id, message, log_date_gmt, log_date_local) VALUES ')))
	mut var_value_rows := []rt.PhpVal{}
	{
		mut iter_1 := var_action_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action_id := item_1.val
			var_value_rows << rt.call_method(var_wpdb, 'prepare', [var_format.dup(), var_action_id.dup()])
			// unsupported statement: Stmt_Nop
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(var_wpdb, 'query', [var_sql_query.dup()])
	// unsupported statement: Stmt_Nop
}

struct Class_ActionScheduler_Logger {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_TimezoneHelper {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullLogEntry {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_LogEntry {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_LoggerSchema {
	rt.PhpObjectBase
}

fn create_actionscheduler_dblogger() &Class_ActionScheduler_DBLogger {
	mut obj := &Class_ActionScheduler_DBLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_logger() &Class_ActionScheduler_Logger {
	mut obj := &Class_ActionScheduler_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_timezonehelper() &Class_ActionScheduler_TimezoneHelper {
	mut obj := &Class_ActionScheduler_TimezoneHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nulllogentry() &Class_ActionScheduler_NullLogEntry {
	mut obj := &Class_ActionScheduler_NullLogEntry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_logentry() &Class_ActionScheduler_LogEntry {
	mut obj := &Class_ActionScheduler_LogEntry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_loggerschema() &Class_ActionScheduler_LoggerSchema {
	mut obj := &Class_ActionScheduler_LoggerSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_DBLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.log(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_entry(dispatch_arg_0)
		}
		'create_entry_from_db_record' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_entry_from_db_record(dispatch_arg_0)
		}
		'get_logs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_logs(dispatch_arg_0)
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'clear_deleted_action_logs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_deleted_action_logs(dispatch_arg_0)
			return rt.new_null()
		}
		'bulk_log_cancel_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bulk_log_cancel_actions(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_DBLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DBLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_TimezoneHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_NullLogEntry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_NullLogEntry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullLogEntry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_LogEntry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_LogEntry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_LogEntry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_LoggerSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_data_stores_actionscheduler_dblogger_php() {
}
