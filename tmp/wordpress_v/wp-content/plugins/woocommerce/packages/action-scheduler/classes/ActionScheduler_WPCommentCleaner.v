import rt

struct Class_ActionScheduler_WPCommentCleaner {
	rt.PhpObjectBase
pub mut:
		cleanup_hook rt.PhpVal = rt.new_string('action_scheduler/cleanup_wp_comment_logs')
		wp_comment_logger rt.PhpVal = rt.new_null()
		has_logs_option_key rt.PhpVal = rt.new_string('as_has_wp_comment_logs')
}

fn Class_ActionScheduler_WPCommentCleaner.init()  {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	rt.call_function('add_action', [// unsupported expression: Expr_StaticPropertyFetch, rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_all_action_comments' }])])
	rt.call_function('add_action', [rt.new_string('pre_get_comments'), rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: none, val: 'filter_comment_queries' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_count_comments'), rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: none, val: 'filter_comment_count' }]), rt.new_int(20), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: none, val: 'filter_comment_feed' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('load-tools_page_action-scheduler'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_admin_notice' }])])
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-status'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_admin_notice' }])])
}

fn Class_ActionScheduler_WPCommentCleaner.has_logs() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [// unsupported expression: Expr_StaticPropertyFetch]))
}

fn Class_ActionScheduler_WPCommentCleaner.maybe_schedule_cleanup()  {
	mut var_has_logs := rt.new_string(rt.new_string('no'))
	mut var_args := { 'type': Class_ActionScheduler_wpCommentLogger.type(), 'number': rt.new_int(1), 'fields': rt.new_string('ids') }
	if rt.is_true(// unsupported expression: Expr_Cast_Bool) {
		var_has_logs = rt.new_string(rt.new_string('yes'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('as_next_scheduled_action', [// unsupported expression: Expr_StaticPropertyFetch]))))) {
			rt.call_function('as_schedule_single_action', [rt.add(rt.call_function('gmdate', [rt.new_string('U')]), rt.mul(rt.new_int(6), rt.get_constant('MONTH_IN_SECONDS'))), // unsupported expression: Expr_StaticPropertyFetch])
		}
	}
	rt.call_function('update_option', [// unsupported expression: Expr_StaticPropertyFetch, var_has_logs.dup(), rt.new_bool(true)])
}

fn Class_ActionScheduler_WPCommentCleaner.delete_all_action_comments()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'comments'), rt.create_array([rt.ArrayItem{ key: 'comment_type', val: Class_ActionScheduler_wpCommentLogger.type() }, rt.ArrayItem{ key: 'comment_agent', val: Class_ActionScheduler_wpCommentLogger.agent() }])])
	rt.call_function('update_option', [// unsupported expression: Expr_StaticPropertyFetch, rt.new_string('no'), rt.new_bool(true)])
}

fn Class_ActionScheduler_WPCommentCleaner.register_admin_notice()  {
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'print_admin_notice' }])])
}

fn Class_ActionScheduler_WPCommentCleaner.print_admin_notice()  {
	mut var_next_cleanup_message := rt.new_string(rt.new_string(''))
	mut var_next_scheduled_cleanup_hook := rt.call_function('as_next_scheduled_action', [// unsupported expression: Expr_StaticPropertyFetch])
	if rt.is_true(var_next_scheduled_cleanup_hook) {
		var_next_cleanup_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This data will be deleted in %s.'), rt.new_string('woocommerce')]), rt.call_function('human_time_diff', [rt.call_function('gmdate', [rt.new_string('U')]), var_next_scheduled_cleanup_hook.dup()])])
	}
	mut var_notice := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Action Scheduler has migrated data to custom tables; however, orphaned log entries exist in the WordPress Comments table. %1$s <a href="%2$s">Learn more &raquo;</a>'), rt.new_string('woocommerce')]), var_next_cleanup_message.dup(), rt.new_string('https://github.com/woocommerce/action-scheduler/issues/368')])
	print('<div class="notice notice-warning"><p>' + (rt.call_function('wp_kses_post', [var_notice.dup()])).str() + '</p></div>')
}

fn create_actionscheduler_wpcommentcleaner() &Class_ActionScheduler_WPCommentCleaner {
	mut obj := &Class_ActionScheduler_WPCommentCleaner{
		PhpObjectBase: rt.PhpObjectBase{}
		cleanup_hook: rt.new_string('action_scheduler/cleanup_wp_comment_logs')
		wp_comment_logger: rt.new_null()
		has_logs_option_key: rt.new_string('as_has_wp_comment_logs')
	}
	return obj
}

fn (mut this Class_ActionScheduler_WPCommentCleaner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_ActionScheduler_WPCommentCleaner.init()
			return rt.new_null()
		}
		'has_logs' {
			return Class_ActionScheduler_WPCommentCleaner.has_logs()
		}
		'maybe_schedule_cleanup' {
			Class_ActionScheduler_WPCommentCleaner.maybe_schedule_cleanup()
			return rt.new_null()
		}
		'delete_all_action_comments' {
			Class_ActionScheduler_WPCommentCleaner.delete_all_action_comments()
			return rt.new_null()
		}
		'register_admin_notice' {
			Class_ActionScheduler_WPCommentCleaner.register_admin_notice()
			return rt.new_null()
		}
		'print_admin_notice' {
			Class_ActionScheduler_WPCommentCleaner.print_admin_notice()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_WPCommentCleaner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cleanup_hook' { return this.cleanup_hook }
		'wp_comment_logger' { return this.wp_comment_logger }
		'has_logs_option_key' { return this.has_logs_option_key }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_WPCommentCleaner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cleanup_hook' { this.cleanup_hook = val; return true }
		'wp_comment_logger' { this.wp_comment_logger = val; return true }
		'has_logs_option_key' { this.has_logs_option_key = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_wpcommentcleaner_php() {
}
