import rt

struct Class_ActionScheduler_WPCommentCleaner {
	rt.PhpObjectBase
}

fn init_static_actionscheduler_wpcommentcleaner() {
		rt.init_static_prop('ActionScheduler_WPCommentCleaner', 'cleanup_hook', rt.new_string('action_scheduler/cleanup_wp_comment_logs'))
		rt.init_static_prop('ActionScheduler_WPCommentCleaner', 'wp_comment_logger', rt.new_null())
		rt.init_static_prop('ActionScheduler_WPCommentCleaner', 'has_logs_option_key', rt.new_string('as_has_wp_comment_logs'))
}

fn Class_ActionScheduler_WPCommentCleaner.init() {
	if !rt.is_true(rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'wp_comment_logger')) {
		rt.set_static_prop('ActionScheduler_WPCommentCleaner', 'wp_comment_logger', rt.new_object('ActionScheduler_wpCommentLogger', []string{}, create_actionscheduler_wpcommentlogger()))
	}
	rt.call_function('add_action', [rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'cleanup_hook'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_all_action_comments' }])])
	rt.call_function('add_action', [rt.new_string('pre_get_comments'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'wp_comment_logger') }, rt.ArrayItem{ key: none, val: 'filter_comment_queries' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_count_comments'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'wp_comment_logger') }, rt.ArrayItem{ key: none, val: 'filter_comment_count' }]), rt.new_int(20), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'wp_comment_logger') }, rt.ArrayItem{ key: none, val: 'filter_comment_feed' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('load-tools_page_action-scheduler'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_admin_notice' }])])
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-status'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_admin_notice' }])])
}

fn Class_ActionScheduler_WPCommentCleaner.has_logs() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'has_logs_option_key')]))
}

fn Class_ActionScheduler_WPCommentCleaner.maybe_schedule_cleanup() {
	mut var_has_logs := rt.new_string('no')
	mut var_args := { 'type': Class_ActionScheduler_wpCommentLogger.type(), 'number': rt.new_int(1), 'fields': rt.new_string('ids') }
	if rt.is_true((rt.call_function('get_comments', [rt.create_array_from_native_map(var_args)])).to_bool()) {
		var_has_logs = rt.new_string('yes')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('as_next_scheduled_action', [rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'cleanup_hook')]))))) {
			rt.call_function('as_schedule_single_action', [rt.add(rt.call_function('gmdate', [rt.new_string('U')]), rt.mul(rt.new_int(6), rt.get_constant('MONTH_IN_SECONDS'))), rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'cleanup_hook')])
		}
	}
	rt.call_function('update_option', [rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'has_logs_option_key'), var_has_logs.clone(), rt.new_bool(true)])
}

fn Class_ActionScheduler_WPCommentCleaner.delete_all_action_comments() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'comments'), rt.create_array([rt.ArrayItem{ key: 'comment_type', val: Class_ActionScheduler_wpCommentLogger.type() }, rt.ArrayItem{ key: 'comment_agent', val: Class_ActionScheduler_wpCommentLogger.agent() }])])
	rt.call_function('update_option', [rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'has_logs_option_key'), rt.new_string('no'), rt.new_bool(true)])
}

fn Class_ActionScheduler_WPCommentCleaner.register_admin_notice() {
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'print_admin_notice' }])])
}

fn Class_ActionScheduler_WPCommentCleaner.print_admin_notice() {
	mut var_next_cleanup_message := rt.new_string('')
	mut var_next_scheduled_cleanup_hook := rt.call_function('as_next_scheduled_action', [rt.get_static_prop('ActionScheduler_WPCommentCleaner', 'cleanup_hook')])
	if rt.is_true(var_next_scheduled_cleanup_hook) {
	var_next_cleanup_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This data will be deleted in %s.'), rt.new_string('woocommerce')]), rt.call_function('human_time_diff', [rt.call_function('gmdate', [rt.new_string('U')]), var_next_scheduled_cleanup_hook.clone()])])
	}
	mut var_notice := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Action Scheduler has migrated data to custom tables; however, orphaned log entries exist in the WordPress Comments table. %1$s <a href="%2$s">Learn more &raquo;</a>'), rt.new_string('woocommerce')]), var_next_cleanup_message.clone(), rt.new_string('https://github.com/woocommerce/action-scheduler/issues/368')])
	print('<div class="notice notice-warning"><p>' + (rt.call_function('wp_kses_post', [var_notice.clone()])).str() + '</p></div>')
}

struct Class_ActionScheduler_wpCommentLogger {
	rt.PhpObjectBase
}

fn create_actionscheduler_wpcommentcleaner(_args ...rt.PhpVal) &Class_ActionScheduler_WPCommentCleaner {
	mut obj := &Class_ActionScheduler_WPCommentCleaner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_wpcommentlogger(_args ...rt.PhpVal) &Class_ActionScheduler_wpCommentLogger {
	mut obj := &Class_ActionScheduler_wpCommentLogger{
		PhpObjectBase: rt.PhpObjectBase{}
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
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_WPCommentCleaner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_wpCommentLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_wpCommentLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpCommentLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
