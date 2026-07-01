import rt

pub fn Class_ActionScheduler_wpCommentLogger.agent() string {
	return 'ActionScheduler'
}
pub fn Class_ActionScheduler_wpCommentLogger.type() string {
	return 'action_log'
}
struct Class_ActionScheduler_wpCommentLogger {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_wpCommentLogger) log(var_action_id rt.PhpVal, var_message rt.PhpVal, mut var_date Class_?DateTime) rt.PhpVal {
	mut var_date_mutated := var_date
	if !rt.is_true(var_date_mutated) {
		var_date_mutated = rt.call_function('as_get_datetime_object', []rt.PhpVal{})
	} else {
		var_date_mutated = rt.call_function('as_get_datetime_object', [// unsupported expression: Expr_Clone])
	}
	mut var_comment_id := this.create_wp_comment(var_action_id.dup(), var_message.dup(), mut var_date_mutated)
	return var_comment_id.dup()
}

fn (mut this Class_ActionScheduler_wpCommentLogger) create_wp_comment(var_action_id rt.PhpVal, var_message rt.PhpVal, mut var_date Class_DateTime) rt.PhpVal {
	mut var_date_mutated := var_date
	mut var_comment_date_gmt := rt.call_method(var_date_mutated, 'format', [rt.new_string('Y-m-d H:i:s')])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler_TimezoneHelper{}; return temp.set_local_timezone(arg_0) }(rt.new_object('DateTime', []string{}, var_date_mutated))
	mut var_comment_data := { 'comment_post_ID': var_action_id, 'comment_date': rt.call_method(var_date_mutated, 'format', [rt.new_string('Y-m-d H:i:s')]), 'comment_date_gmt': var_comment_date_gmt, 'comment_author': Class_ActionScheduler_wpCommentLogger.agent(), 'comment_content': var_message, 'comment_agent': Class_ActionScheduler_wpCommentLogger.agent(), 'comment_type': Class_ActionScheduler_wpCommentLogger.type() }
	return rt.call_function('wp_insert_comment', [var_comment_data.dup()])
}

fn (mut this Class_ActionScheduler_wpCommentLogger) get_entry(var_entry_id rt.PhpVal) rt.PhpVal {
	mut var_comment := this.get_comment(var_entry_id.dup())
	if rt.is_true(rt.new_bool(!rt.is_true(var_comment) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_actionscheduler_nulllogentry()
	}
	mut var_date := rt.call_function('as_get_datetime_object', [rt.get_property(var_comment, 'comment_date_gmt')])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler_TimezoneHelper{}; return temp.set_local_timezone(arg_0) }(var_date.dup())
	return create_actionscheduler_logentry(rt.get_property(var_comment, 'comment_post_ID'), rt.get_property(var_comment, 'comment_content'), var_date.dup())
}

fn (mut this Class_ActionScheduler_wpCommentLogger) get_logs(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_status := rt.new_string(rt.new_string('all'))
	mut var_logs := []rt.PhpVal{}
	if rt.is_true(rt.identical(rt.call_function('get_post_status', [var_action_id.dup()]), rt.new_string('trash'))) {
		var_status = rt.new_string(rt.new_string('post-trashed'))
	}
	mut var_comments := rt.call_function('get_comments', [rt.create_array([rt.ArrayItem{ key: 'post_id', val: var_action_id }, rt.ArrayItem{ key: 'orderby', val: 'comment_date_gmt' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'type', val: Class_ActionScheduler_wpCommentLogger.type() }, rt.ArrayItem{ key: 'status', val: var_status }])])
	{
		mut iter_1 := var_comments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_c := item_1.val
			mut var_entry := this.get_entry(var_c.dup())
			if !(!rt.is_true(var_entry)) {
				var_logs << var_entry.dup()
			}
		}
	}
	return var_logs.dup()
}

fn (mut this Class_ActionScheduler_wpCommentLogger) get_comment(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment_id_mutated := var_comment_id
	return rt.call_function('get_comment', [var_comment_id_mutated.dup()])
}

fn (mut this Class_ActionScheduler_wpCommentLogger) filter_comment_queries(var_query rt.PhpVal)  {
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'ID' }, rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'post_author' }, rt.ArrayItem{ key: none, val: 'post_name' }, rt.ArrayItem{ key: none, val: 'post_parent' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'post_id' }, rt.ArrayItem{ key: none, val: 'post_ID' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if !(!rt.is_true(rt.get_property(var_query, 'query_vars').array_get(var_key))) {
				return rt.new_null()
				// unsupported statement: Stmt_Nop
			}
		}
	}
	rt.get_property(var_query, 'query_vars').array_set('action_log_filter', true)
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'filter_comment_query_clauses' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_ActionScheduler_wpCommentLogger) filter_comment_query_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(rt.get_property(var_query, 'query_vars').array_get('action_log_filter'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_clauses.dup()
}

fn (mut this Class_ActionScheduler_wpCommentLogger) filter_comment_feed(var_where rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_comment_feed', []rt.PhpVal{})) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_where.dup()
}

fn (mut this Class_ActionScheduler_wpCommentLogger) get_where_clause() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_function('sprintf', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_type != \'%s\'')), Class_ActionScheduler_wpCommentLogger.type()])
}

fn (mut this Class_ActionScheduler_wpCommentLogger) filter_comment_count(var_stats rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_stats_mutated := var_stats
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_int(0), var_post_id)) {
		var_stats_mutated = this.get_comment_count()
	}
	return var_stats_mutated.dup()
}

fn (mut this Class_ActionScheduler_wpCommentLogger) get_comment_count() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_stats := rt.call_function('get_transient', [rt.new_string('as_comment_count')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_stats)))) {
		var_stats = []rt.PhpVal{}
		mut var_count := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT comment_approved, COUNT( * ) AS num_comments FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_type NOT IN(\'order_note\',\'action_log\') GROUP BY comment_approved')), rt.get_constant('ARRAY_A')])
		mut var_total := rt.new_int(rt.new_int(0))
		var_stats = []rt.PhpVal{}
		mut var_approved := rt.create_array([rt.ArrayItem{ key: '0', val: 'moderated' }, rt.ArrayItem{ key: '1', val: 'approved' }, rt.ArrayItem{ key: 'spam', val: 'spam' }, rt.ArrayItem{ key: 'trash', val: 'trash' }, rt.ArrayItem{ key: 'post-trashed', val: 'post-trashed' }])
		{
			mut iter_1 := rt.cast_array(var_count).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_row := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					// unsupported expression: Expr_AssignOp_Plus
				}
				if var_approved.array_isset(var_row.array_get('comment_approved')) {
					var_stats.array_set(var_approved.array_get(var_row.array_get('comment_approved')), var_row.array_get('num_comments'))
				}
			}
		}
		var_stats.array_set('total_comments', var_total.dup())
		var_stats.array_set('all', var_total.dup())
		{
			mut iter_1 := var_approved.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_key := item_1.val
				if !rt.is_true(var_stats.array_get(var_key)) {
					var_stats.array_set(var_key, 0)
				}
			}
		}
		var_stats = // unsupported expression: Expr_Cast_Object
		rt.call_function('set_transient', [rt.new_string('as_comment_count'), var_stats.dup()])
	}
	return var_stats.dup()
}

fn (mut this Class_ActionScheduler_wpCommentLogger) delete_comment_count_cache()  {
	rt.call_function('delete_transient', [rt.new_string('as_comment_count')])
}

fn (mut this Class_ActionScheduler_wpCommentLogger) init()  {
	rt.call_function('add_action', [rt.new_string('action_scheduler_before_process_queue'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'disable_comment_counting' }]), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_after_process_queue'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'enable_comment_counting' }]), rt.new_int(10), rt.new_int(0)])
	this.Class_ActionScheduler_Logger.init()
	rt.call_function('add_action', [rt.new_string('pre_get_comments'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'filter_comment_queries' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_count_comments'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'filter_comment_count' }]), rt.new_int(20), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'filter_comment_feed' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_insert_comment'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'delete_comment_count_cache' }])])
	rt.call_function('add_action', [rt.new_string('wp_set_comment_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpCommentLogger', ['ActionScheduler_Logger'], &this) }, rt.ArrayItem{ key: none, val: 'delete_comment_count_cache' }])])
}

fn (mut this Class_ActionScheduler_wpCommentLogger) disable_comment_counting()  {
	rt.call_function('wp_defer_comment_counting', [rt.new_bool(true)])
}

fn (mut this Class_ActionScheduler_wpCommentLogger) enable_comment_counting()  {
	rt.call_function('wp_defer_comment_counting', [rt.new_bool(false)])
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

fn create_actionscheduler_wpcommentlogger() &Class_ActionScheduler_wpCommentLogger {
	mut obj := &Class_ActionScheduler_wpCommentLogger{
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

fn (mut this Class_ActionScheduler_wpCommentLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.log(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'create_wp_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.create_wp_comment(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_entry(dispatch_arg_0)
		}
		'get_logs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_logs(dispatch_arg_0)
		}
		'get_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_comment(dispatch_arg_0)
		}
		'filter_comment_queries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.filter_comment_queries(dispatch_arg_0)
			return rt.new_null()
		}
		'filter_comment_query_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_comment_query_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_comment_feed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_comment_feed(dispatch_arg_0, dispatch_arg_1)
		}
		'get_where_clause' {
			return this.get_where_clause()
		}
		'filter_comment_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_comment_count(dispatch_arg_0, dispatch_arg_1)
		}
		'get_comment_count' {
			return this.get_comment_count()
		}
		'delete_comment_count_cache' {
			this.delete_comment_count_cache()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'disable_comment_counting' {
			this.disable_comment_counting()
			return rt.new_null()
		}
		'enable_comment_counting' {
			this.enable_comment_counting()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_wpCommentLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpCommentLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_data_stores_actionscheduler_wpcommentlogger_php() {
}
