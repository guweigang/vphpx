import rt

struct Class_ActionScheduler_ListTable {
	rt.PhpObjectBase
pub mut:
	package      rt.PhpVal = rt.new_string('action-scheduler')
	columns      rt.PhpVal = rt.new_array()
	row_actions  rt.PhpVal = rt.new_array()
	store        rt.PhpVal = rt.new_null()
	logger       rt.PhpVal = rt.new_null()
	runner       rt.PhpVal = rt.new_null()
	bulk_actions rt.PhpVal = rt.new_array()
}

fn init_static_actionscheduler_listtable() {
	rt.init_static_prop('ActionScheduler_ListTable', 'did_notification', rt.new_bool(false))
	rt.init_static_prop('ActionScheduler_ListTable', 'time_periods', rt.new_null())
}

fn (mut this Class_ActionScheduler_ListTable) construct(mut var_store Class_ActionScheduler_Store, mut var_logger Class_ActionScheduler_Logger, mut var_runner Class_ActionScheduler_QueueRunner) {
	mut var_store_mutated := var_store
	this.store = var_store_mutated
	this.logger = var_logger
	this.runner = var_runner
	this.dispatch_set_prop('table_header', rt.call_function('__', [
		rt.new_string('Scheduled Actions'),
		rt.new_string('woocommerce'),
	]))
	this.bulk_actions = rt.create_array([
		rt.ArrayItem{ key: 'delete', val: rt.call_function('__', [
			rt.new_string('Delete'),
			rt.new_string('woocommerce'),
		]) },
	])
	this.columns = rt.create_array([
		rt.ArrayItem{ key: 'hook', val: rt.call_function('__', [
			rt.new_string('Hook'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'status', val: rt.call_function('__', [
			rt.new_string('Status'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'args', val: rt.call_function('__', [
			rt.new_string('Arguments'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'group', val: rt.call_function('__', [
			rt.new_string('Group'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'recurrence', val: rt.call_function('__', [
			rt.new_string('Recurrence'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'schedule', val: rt.call_function('__', [
			rt.new_string('Scheduled Date'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'log_entries', val: rt.call_function('__', [
			rt.new_string('Log'), rt.new_string('woocommerce')]) },
	])
	this.dispatch_set_prop('sort_by', rt.create_array([
		rt.ArrayItem{ key: none, val: 'schedule' },
		rt.ArrayItem{ key: none, val: 'hook' },
		rt.ArrayItem{ key: none, val: 'group' },
	]))
	this.dispatch_set_prop('search_by', rt.create_array([
		rt.ArrayItem{ key: none, val: 'hook' },
		rt.ArrayItem{ key: none, val: 'args' },
		rt.ArrayItem{ key: none, val: 'claim_id' },
	]))
	mut var_request_status := this.get_request_status()
	if !rt.is_true(var_request_status) {
		rt.get_property(rt.new_object('ActionScheduler_ListTable', [
			'ActionScheduler_Abstract_ListTable',
		], &this), 'sort_by').array_push('status')
	} else if rt.is_true(rt.call_function('in_array', [var_request_status.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'in-progress' },
			rt.ArrayItem{ key: none, val: 'failed' }]),
		rt.new_bool(true)]))
	{
		this.columns = rt.add(this.columns, rt.create_array([
			rt.ArrayItem{ key: 'claim_id', val: rt.call_function('__', [
				rt.new_string('Claim ID'),
				rt.new_string('woocommerce'),
			]) },
		]))
		rt.get_property(rt.new_object('ActionScheduler_ListTable', [
			'ActionScheduler_Abstract_ListTable',
		], &this), 'sort_by').array_push('claim_id')
	}
	this.row_actions = rt.create_array([
		rt.ArrayItem{ key: 'hook', val: rt.create_array([
			rt.ArrayItem{ key: 'run', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
					rt.new_string('Run'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Process the action now as if it were run as part of a queue'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'cancel', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
					rt.new_string('Cancel'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Cancel the action now to avoid it being run in future'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'class', val: 'cancel trash' },
			]) },
		]) },
	])
	rt.set_static_prop('ActionScheduler_ListTable', 'time_periods', rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'seconds', val: rt.get_constant('YEAR_IN_SECONDS') },
			rt.ArrayItem{ key: 'names', val: rt.call_function('_n_noop', [
				rt.new_string('%s year'),
				rt.new_string('%s years'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'seconds', val: rt.get_constant('MONTH_IN_SECONDS') },
			rt.ArrayItem{ key: 'names', val: rt.call_function('_n_noop', [
				rt.new_string('%s month'),
				rt.new_string('%s months'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'seconds', val: rt.get_constant('WEEK_IN_SECONDS') },
			rt.ArrayItem{ key: 'names', val: rt.call_function('_n_noop', [
				rt.new_string('%s week'),
				rt.new_string('%s weeks'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'seconds', val: rt.get_constant('DAY_IN_SECONDS') },
			rt.ArrayItem{ key: 'names', val: rt.call_function('_n_noop', [
				rt.new_string('%s day'),
				rt.new_string('%s days'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'seconds', val: rt.get_constant('HOUR_IN_SECONDS') },
			rt.ArrayItem{ key: 'names', val: rt.call_function('_n_noop', [
				rt.new_string('%s hour'),
				rt.new_string('%s hours'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'seconds', val: rt.get_constant('MINUTE_IN_SECONDS') },
			rt.ArrayItem{ key: 'names', val: rt.call_function('_n_noop', [
				rt.new_string('%s minute'),
				rt.new_string('%s minutes'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'seconds', val: 1 },
			rt.ArrayItem{ key: 'names', val: rt.call_function('_n_noop', [
				rt.new_string('%s second'),
				rt.new_string('%s seconds'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
	this.Class_ActionScheduler_Abstract_ListTable.construct(rt.create_array([
		rt.ArrayItem{ key: 'singular', val: 'action-scheduler' },
		rt.ArrayItem{ key: 'plural', val: 'action-scheduler' },
		rt.ArrayItem{ key: 'ajax', val: false },
	]))
	rt.call_function('add_screen_option', [rt.new_string('per_page'),
		rt.create_array([
			rt.ArrayItem{ key: 'default', val: rt.get_property(rt.new_object('ActionScheduler_ListTable', [
				'ActionScheduler_Abstract_ListTable',
			], &this), 'items_per_page') },
		])])
	rt.call_function('add_filter', [
		rt.new_string('set_screen_option_' + this.get_per_page_option_name()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_ListTable', [
				'ActionScheduler_Abstract_ListTable',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_items_per_page_option' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('set_screen_options', []rt.PhpVal{})
}

fn (mut this Class_ActionScheduler_ListTable) set_items_per_page_option(var_status rt.PhpVal, var_option rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	return var_value.clone()
}

fn Class_ActionScheduler_ListTable.human_interval(var_interval rt.PhpVal, periods_to_include i64) rt.PhpVal {
	if rt.is_true(rt.less_equal(var_interval, rt.new_int(0))) {
		return rt.call_function('__', [rt.new_string('Now!'),
			rt.new_string('woocommerce')])
	}
	mut var_output := rt.new_string('')
	mut var_num_time_periods := rt.new_int(rt.get_static_prop('ActionScheduler_ListTable',
		'time_periods').array_count())
	mut var_time_period_index := rt.new_int(0)
	mut var_periods_included := rt.new_int(0)
	mut var_seconds_remaining := var_interval
	for {
		if !(rt.is_true(rt.less(var_time_period_index, var_num_time_periods)) && rt.is_true(rt.greater(var_seconds_remaining, rt.new_int(0))) && rt.is_true(rt.less(var_periods_included, rt.new_int(periods_to_include)))) { break
		 }
		mut var_periods_in_interval := rt.call_function('floor', [
			rt.div(var_seconds_remaining, rt.get_static_prop('ActionScheduler_ListTable',
				'time_periods').array_get(var_time_period_index).array_get(rt.new_string('seconds'))),
		])
		if rt.is_true(rt.greater(var_periods_in_interval, rt.new_int(0))) {
			if !(!rt.is_true(var_output)) {
				var_output = rt.concat(var_output, rt.new_string(' '))
			}
			var_output = rt.concat(var_output, rt.call_function('sprintf', [
				rt.call_function('translate_nooped_plural', [
					rt.get_static_prop('ActionScheduler_ListTable', 'time_periods').array_get(var_time_period_index).array_get(rt.new_string('names')),
					var_periods_in_interval.clone(),
					rt.new_string('action-scheduler'),
				]),
				var_periods_in_interval.clone(),
			]))
			var_seconds_remaining = rt.sub(var_seconds_remaining, rt.mul(var_periods_in_interval, rt.get_static_prop('ActionScheduler_ListTable',
				'time_periods').array_get(var_time_period_index).array_get(rt.new_string('seconds'))))
			rt.post_inc(var_periods_included)
		}
		rt.post_inc(var_time_period_index)
	}
	return var_output.clone()
}

fn (mut this Class_ActionScheduler_ListTable) get_recurrence(var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
	mut var_schedule := rt.call_method(var_action_mutated, 'get_schedule', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_schedule, 'is_recurring', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('method_exists', [var_schedule.clone(), rt.new_string('get_recurrence')])) {
		mut var_recurrence := rt.call_method(var_schedule, 'get_recurrence', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_recurrence.clone().is_long()
			|| var_recurrence.clone().is_double()))
		{
			return rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Every %s'),
					rt.new_string('woocommerce')]),
				Class_ActionScheduler_ListTable.human_interval(var_recurrence.to_i64()),
			])
		} else {
			return var_recurrence.clone()
		}
	}
	return rt.call_function('__', [rt.new_string('Non-repeating'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_ActionScheduler_ListTable) column_args(mut var_row Class_array) rt.PhpVal {
	if !rt.is_true(var_row.array_get(rt.new_string('args'))) {
		return rt.call_function('apply_filters', [
			rt.new_string('action_scheduler_list_table_column_args'),
			rt.new_string(''),
			var_row,
		])
	}
	mut var_row_html := rt.new_string('<ul>')
	mut iter_1 := var_row.array_get(rt.new_string('args')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		var_row_html = rt.concat(var_row_html, rt.call_function('sprintf', [
			rt.new_string('<li><code>%s => %s</code></li>'),
			rt.call_function('esc_html', [
				rt.call_function('var_export', [var_key.clone(),
					rt.new_bool(true)]),
			]),
			rt.call_function('esc_html', [
				rt.call_function('var_export', [var_value.clone(),
					rt.new_bool(true)]),
			]),
		]))
	}
	var_row_html = rt.concat(var_row_html, rt.new_string('</ul>'))
	return rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_list_table_column_args'),
		var_row_html.clone(),
		var_row,
	])
}

fn (mut this Class_ActionScheduler_ListTable) column_log_entries(mut var_row Class_array) rt.PhpVal {
	mut var_log_entries_html := rt.new_string('<ol>')
	mut var_timezone := create_datetimezone(rt.new_string('UTC'))
	mut iter_2 := var_row.array_get(rt.new_string('log_entries')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_log_entry := item_2.val
		var_log_entries_html = rt.concat(var_log_entries_html, this.get_log_entry_html(mut rt.cast_object_ptr[Class_ActionScheduler_LogEntry](var_log_entry), mut
			var_timezone))
	}
	var_log_entries_html = rt.concat(var_log_entries_html, rt.new_string('</ol>'))
	return var_log_entries_html.clone()
}

fn (mut this Class_ActionScheduler_ListTable) get_log_entry_html(mut var_log_entry Class_ActionScheduler_LogEntry, mut var_timezone Class_DateTimezone) rt.PhpVal {
	mut var_timezone_mutated := var_timezone
	mut var_date := var_log_entry.get_date()
	rt.call_method(var_date, 'setTimezone', [var_timezone_mutated])
	return rt.call_function('sprintf', [
		rt.new_string('<li><strong>%s</strong><br/>%s</li>'),
		rt.call_function('esc_html', [
			rt.call_method(var_date, 'format', [rt.new_string('Y-m-d H:i:s O')]),
		]),
		rt.call_function('esc_html', [
			var_log_entry.get_message(),
		]),
	])
}

fn (mut this Class_ActionScheduler_ListTable) maybe_render_actions(var_row rt.PhpVal, var_column_name rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('pending'),
		rt.new_string(var_row.array_get(rt.new_string('status_name')).to_string().to_lower())))
	{
		return (this.Class_ActionScheduler_Abstract_ListTable.maybe_render_actions(var_row.clone(),
			var_column_name.clone())).str()
	}
	return ''
}

fn (mut this Class_ActionScheduler_ListTable) display_admin_notices() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_function('is_a', [this.store, rt.new_string('ActionScheduler_HybridStore')]))
		|| rt.is_true(rt.call_function('is_a', [this.store, rt.new_string('ActionScheduler_DBStore')]))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('action_scheduler_enable_recreate_data_store'), rt.new_bool(true)])) {
		mut var_table_list := ['actionscheduler_actions', 'actionscheduler_logs',
			'actionscheduler_groups', 'actionscheduler_claims']
		mut var_found_tables := rt.call_method(var_wpdb, 'get_col', [
			rt.concat(rt.concat(rt.new_string("SHOW TABLES LIKE '"), rt.get_property(var_wpdb,
				'prefix')), rt.new_string("actionscheduler%'")),
		])
		for var_table_name in var_table_list {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + table_name),
				var_found_tables.clone(),
				rt.new_bool(true),
			])))))
			{
				rt.get_property(rt.new_object('ActionScheduler_ListTable', [
					'ActionScheduler_Abstract_ListTable',
				], &this), 'admin_notices').array_push(rt.create_array([
					rt.ArrayItem{ key: 'class', val: 'error' },
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('It appears one or more database tables were missing. Attempting to re-create the missing table(s).'),
						rt.new_string('woocommerce'),
					]) },
				]))
				this.recreate_tables()
				this.Class_ActionScheduler_Abstract_ListTable.display_admin_notices()
				return
			}
		}
	}
	if rt.is_true(rt.call_method(this.runner, 'has_maximum_concurrent_batches', []rt.PhpVal{})) {
		mut var_claim_count := rt.call_method(this.store, 'get_claim_count', []rt.PhpVal{})
		rt.get_property(rt.new_object('ActionScheduler_ListTable', [
			'ActionScheduler_Abstract_ListTable',
		], &this), 'admin_notices').array_push(rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'updated' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('Maximum simultaneous queues already in progress (%s queue). No additional queues will begin processing until the current queues are complete.'),
					rt.new_string('Maximum simultaneous queues already in progress (%s queues). No additional queues will begin processing until the current queues are complete.'),
					var_claim_count.clone(),
					rt.new_string('woocommerce'),
				]),
				var_claim_count.clone(),
			]) },
		]))
	} else if rt.is_true(rt.call_method(this.store, 'has_pending_actions_due', []rt.PhpVal{})) {
		mut iife_temp_0 := Class_ActionScheduler{}
		mut iife_result_0 := iife_temp_0.lock()
		mut var_async_request_lock_expiration := rt.call_method(iife_result_0, 'get_expiration', [
			rt.new_string('async-request-runner'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_async_request_lock_expiration))
			|| rt.is_true(rt.less(var_async_request_lock_expiration, rt.call_function('time', []rt.PhpVal{}))) {
			mut var_in_progress_url := rt.call_function('add_query_arg', [
				rt.new_string('status'),
				rt.new_string('in-progress'),
				rt.call_function('remove_query_arg', [rt.new_string('status')]),
			])
			mut var_async_request_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('A new queue has begun processing. <a href="%s">View actions in-progress &raquo;</a>'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_url', [
					var_in_progress_url.clone(),
				]),
			])
		} else {
			var_async_request_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The next queue will begin processing in approximately %d seconds.'),
					rt.new_string('woocommerce'),
				]),
				rt.sub(var_async_request_lock_expiration, rt.call_function('time', []rt.PhpVal{})),
			])
		}
		rt.get_property(rt.new_object('ActionScheduler_ListTable', [
			'ActionScheduler_Abstract_ListTable',
		], &this), 'admin_notices').array_push(rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'notice notice-info' },
			rt.ArrayItem{ key: 'message', val: var_async_request_message },
		]))
	}
	mut var_notification := rt.call_function('get_transient', [
		rt.new_string('action_scheduler_admin_notice'),
	])
	if rt.is_true(rt.new_bool(var_notification.clone().is_array())) {
		rt.call_function('delete_transient', [
			rt.new_string('action_scheduler_admin_notice'),
		])
		mut var_action := rt.call_method(this.store, 'fetch_action', [
			var_notification.array_get(rt.new_string('action_id')),
		])
		mut var_action_hook_html := rt.new_string('<strong><code>' +
			(rt.call_method(var_action, 'get_hook', []rt.PhpVal{})).str() + '</code></strong>')
		if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('absint', [
			var_notification.array_get(rt.new_string('success')),
		])))
		{
			mut var_class := rt.new_string('updated')
			mut switch_val_1 := var_notification.array_get(rt.new_string('row_action_type'))
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('run'))) {
				mut var_action_message_html := rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Successfully executed action: %s'),
						rt.new_string('woocommerce'),
					]),
					var_action_hook_html.clone(),
				])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cancel'))) {
				var_action_message_html = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Successfully canceled action: %s'),
						rt.new_string('woocommerce'),
					]),
					var_action_hook_html.clone(),
				])
			} else {
				var_action_message_html = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Successfully processed change for action: %s'),
						rt.new_string('woocommerce'),
					]),
					var_action_hook_html.clone(),
				])
			}
		} else {
			var_class = rt.new_string('error')
			var_action_message_html = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Could not process change for action: "%1$s" (ID: %2$d). Error: %3$s'),
					rt.new_string('woocommerce'),
				]),
				var_action_hook_html.clone(),
				rt.call_function('esc_html', [
					var_notification.array_get(rt.new_string('action_id')),
				]),
				rt.call_function('esc_html', [
					var_notification.array_get(rt.new_string('error_message')),
				]),
			])
		}
		var_action_message_html = rt.call_function('apply_filters', [
			rt.new_string('action_scheduler_admin_notice_html'),
			var_action_message_html.clone(),
			var_action.clone(),
			var_notification.clone(),
		])
		rt.get_property(rt.new_object('ActionScheduler_ListTable', [
			'ActionScheduler_Abstract_ListTable',
		], &this), 'admin_notices').array_push(rt.create_array([
			rt.ArrayItem{ key: 'class', val: var_class },
			rt.ArrayItem{ key: 'message', val: var_action_message_html },
		]))
	}
	this.Class_ActionScheduler_Abstract_ListTable.display_admin_notices()
}

fn (mut this Class_ActionScheduler_ListTable) column_schedule(var_row rt.PhpVal) rt.PhpVal {
	return rt.new_string(this.get_schedule_display_string(mut rt.cast_object_ptr[Class_ActionScheduler_Schedule](var_row.array_get(rt.new_string('schedule')))))
}

fn (mut this Class_ActionScheduler_ListTable) get_schedule_display_string(mut var_schedule Class_ActionScheduler_Schedule) string {
	mut var_schedule_mutated := var_schedule
	mut var_schedule_display_string := rt.new_string('')
	if rt.is_true(rt.call_function('is_a', [var_schedule_mutated,
		rt.new_string('ActionScheduler_NullSchedule')]))
	{
		return (rt.call_function('__', [rt.new_string('async'),
			rt.new_string('woocommerce')])).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_schedule_mutated, rt.new_string('get_date')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_schedule_mutated, 'get_date', []rt.PhpVal{}))))) {
		return '0000-00-00 00:00:00'
	}
	mut var_next_timestamp := rt.call_method(rt.call_method(var_schedule_mutated, 'get_date',
		[]rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})
	var_schedule_display_string = rt.concat(var_schedule_display_string, rt.call_method(rt.call_method(var_schedule_mutated,
		'get_date', []rt.PhpVal{}), 'format', [rt.new_string('Y-m-d H:i:s O')]))
	var_schedule_display_string = rt.concat(var_schedule_display_string, rt.new_string('<br/>'))
	if rt.is_true(rt.greater(rt.call_function('gmdate', [rt.new_string('U')]), var_next_timestamp)) {
		var_schedule_display_string = rt.concat(var_schedule_display_string, rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string(' (%s ago)'),
				rt.new_string('woocommerce')]),
			Class_ActionScheduler_ListTable.human_interval((rt.sub(rt.call_function('gmdate', [
				rt.new_string('U')]), var_next_timestamp)).to_i64()),
		]))
	} else {
		var_schedule_display_string = rt.concat(var_schedule_display_string, rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string(' (%s)'), rt.new_string('woocommerce')]),
			Class_ActionScheduler_ListTable.human_interval((rt.sub(var_next_timestamp, rt.call_function('gmdate', [
				rt.new_string('U')]))).to_i64()),
		]))
	}
	return var_schedule_display_string.str()
}

fn (mut this Class_ActionScheduler_ListTable) bulk_delete(mut var_ids Class_array, var_ids_sql rt.PhpVal) {
	mut iter_3 := var_ids.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_id := item_3.val
		rt.call_method(this.store, 'delete_action', [var_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			rt.call_function('error_log', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Action Scheduler was unable to delete action %1$d. Reason: %2$s'),
						rt.new_string('woocommerce'),
					]),
					var_id.clone(),
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]),
			])
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
}

fn (mut this Class_ActionScheduler_ListTable) row_action_cancel(var_action_id rt.PhpVal) {
	this.process_row_action(var_action_id.clone(), rt.new_string('cancel'))
}

fn (mut this Class_ActionScheduler_ListTable) row_action_run(var_action_id rt.PhpVal) {
	this.process_row_action(var_action_id.clone(), rt.new_string('run'))
}

fn (mut this Class_ActionScheduler_ListTable) recreate_tables() {
	if rt.is_true(rt.call_function('is_a',
		[this.store, rt.new_string('ActionScheduler_HybridStore')]))
	{
		mut var_store := this.store
	} else {
		var_store = create_actionscheduler_hybridstore()
	}
	rt.call_function('add_action', [rt.new_string('action_scheduler/created_table'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_store },
			rt.ArrayItem{ key: none, val: 'set_autoincrement' }]),
		rt.new_int(10), rt.new_int(2)])
	mut var_store_schema := create_actionscheduler_storeschema()
	mut var_logger_schema := create_actionscheduler_loggerschema()
	var_store_schema.register_tables(rt.new_bool(true))
	var_logger_schema.register_tables(rt.new_bool(true))
	rt.call_function('remove_action', [rt.new_string('action_scheduler/created_table'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_store },
			rt.ArrayItem{ key: none, val: 'set_autoincrement' }]),
		rt.new_int(10)])
}

fn (mut this Class_ActionScheduler_ListTable) process_row_action(var_action_id rt.PhpVal, var_row_action_type rt.PhpVal) {
	mut switch_val_2 := var_row_action_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('run'))) {
		rt.call_method(this.runner, 'process_action', [var_action_id.clone(),
			rt.new_string('Admin List Table')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('cancel'))) {
		rt.call_method(this.store, 'cancel_action', [var_action_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_success := rt.new_int(1)
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_error_message := rt.new_string('')
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		var_success = rt.new_int(0)
		var_error_message = rt.call_method(var_e, 'getMessage', []rt.PhpVal{})
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	rt.call_function('set_transient', [rt.new_string('action_scheduler_admin_notice'),
		rt.call_function('compact', [rt.new_string('action_id'),
			rt.new_string('success'), rt.new_string('error_message'),
			rt.new_string('row_action_type')]),
		rt.new_int(30)])
}

fn (mut this Class_ActionScheduler_ListTable) prepare_items() {
	this.prepare_column_headers()
	mut var_per_page := this.get_items_per_page(rt.new_string(this.get_per_page_option_name()), rt.get_property(rt.new_object('ActionScheduler_ListTable', [
		'ActionScheduler_Abstract_ListTable',
	], &this), 'items_per_page'))
	mut var_query := {
		'per_page': var_per_page
		'offset':   this.get_items_offset()
		'status':   this.get_request_status()
		'orderby':  this.get_request_orderby()
		'order':    this.get_request_order()
		'search':   this.get_request_search_query()
	}
	if rt.is_true(rt.identical(rt.new_string('past-due'), this.get_request_status())) {
		var_query['status'] = Class_ActionScheduler_Store.status_pending()
		var_query['date'] = rt.call_function('as_get_datetime_object', []rt.PhpVal{})
	}
	this.dispatch_set_prop('items', rt.new_array())
	mut var_total_items := rt.call_method(this.store, 'query_actions', [
		rt.create_array_from_native_map(var_query),
		rt.new_string('count'),
	])
	mut var_status_labels := rt.call_method(this.store, 'get_status_labels', []rt.PhpVal{})
	mut iter_4 := rt.call_method(this.store, 'query_actions', [
		rt.create_array_from_native_map(var_query),
	]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_action_id := item_4.val
		mut var_action := rt.call_method(this.store, 'fetch_action', [
			var_action_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		unsafe {
			goto end_label_3
		}
		catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Exception') {
			mut var_e := var_e_3.clone()
			continue
			unsafe {
				goto end_label_3
			}
		} else {
			rt.throw_exception(var_e_3)
			unsafe {
				goto end_label_3
			}
		}

		end_label_3:
		if rt.is_true(rt.call_function('is_a', [var_action.clone(),
			rt.new_string('ActionScheduler_NullAction')]))
		{
			continue
		}
		rt.get_property(rt.new_object('ActionScheduler_ListTable', [
			'ActionScheduler_Abstract_ListTable',
		], &this), 'items').array_set(var_action_id, rt.create_array([
			rt.ArrayItem{ key: 'ID', val: var_action_id },
			rt.ArrayItem{ key: 'hook', val: rt.call_method(var_action, 'get_hook', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'status_name', val: rt.call_method(this.store, 'get_status', [
				var_action_id.clone(),
			]) },
			rt.ArrayItem{ key: 'status', val: var_status_labels.array_get(rt.call_method(this.store,
				'get_status', [
				var_action_id.clone(),
			])) },
			rt.ArrayItem{ key: 'args', val: rt.call_method(var_action, 'get_args', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'group', val: rt.call_method(var_action, 'get_group', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'log_entries', val: rt.call_method(this.logger, 'get_logs', [
				var_action_id.clone(),
			]) },
			rt.ArrayItem{ key: 'claim_id', val: rt.call_method(this.store, 'get_claim_id', [
				var_action_id.clone(),
			]) },
			rt.ArrayItem{ key: 'recurrence', val: this.get_recurrence(var_action.clone()) },
			rt.ArrayItem{ key: 'schedule', val: rt.call_method(var_action, 'get_schedule',
				[]rt.PhpVal{}) },
		]))
	}
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: var_total_items },
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [
			rt.div(var_total_items, var_per_page),
		]) },
	]))
}

fn (mut this Class_ActionScheduler_ListTable) display_filter_by_status() {
	this.dispatch_set_prop('status_counts', rt.add(rt.call_method(this.store, 'action_counts',
		[]rt.PhpVal{}), rt.call_method(this.store, 'extra_action_counts', []rt.PhpVal{})))
	this.Class_ActionScheduler_Abstract_ListTable.display_filter_by_status()
}

fn (mut this Class_ActionScheduler_ListTable) get_search_box_button_text() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Search hook, args and claim ID'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_ActionScheduler_ListTable) get_per_page_option_name() string {
	return
		(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), rt.get_property(rt.get_property(rt.new_object('ActionScheduler_ListTable', ['ActionScheduler_Abstract_ListTable'], &this), 'screen'), 'id')])).str() +
		'_per_page'
}

struct Class_ActionScheduler_Abstract_ListTable {
	rt.PhpObjectBase
}

struct Class_DateTimezone {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_HybridStore {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_StoreSchema {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_LoggerSchema {
	rt.PhpObjectBase
}

fn create_actionscheduler_listtable(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ActionScheduler_ListTable {
	mut obj := &Class_ActionScheduler_ListTable{
		PhpObjectBase: rt.PhpObjectBase{}
		package:       rt.new_string('action-scheduler')
		columns:       rt.new_array()
		row_actions:   rt.new_array()
		store:         rt.new_null()
		logger:        rt.new_null()
		runner:        rt.new_null()
		bulk_actions:  rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_actionscheduler_abstract_listtable(_args ...rt.PhpVal) &Class_ActionScheduler_Abstract_ListTable {
	mut obj := &Class_ActionScheduler_Abstract_ListTable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimezone {
	mut obj := &Class_DateTimezone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_hybridstore(_args ...rt.PhpVal) &Class_ActionScheduler_HybridStore {
	mut obj := &Class_ActionScheduler_HybridStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_storeschema(_args ...rt.PhpVal) &Class_ActionScheduler_StoreSchema {
	mut obj := &Class_ActionScheduler_StoreSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_loggerschema(_args ...rt.PhpVal) &Class_ActionScheduler_LoggerSchema {
	mut obj := &Class_ActionScheduler_LoggerSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Store](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ActionScheduler_Logger](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ActionScheduler_QueueRunner](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'set_items_per_page_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.set_items_per_page_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'human_interval' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ActionScheduler_ListTable.human_interval(dispatch_arg_0, dispatch_arg_1)
		}
		'get_recurrence' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recurrence(dispatch_arg_0)
		}
		'column_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.column_args(mut dispatch_arg_0)
		}
		'column_log_entries' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.column_log_entries(mut dispatch_arg_0)
		}
		'get_log_entry_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_LogEntry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_DateTimezone](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_log_entry_html(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'maybe_render_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.maybe_render_actions(dispatch_arg_0, dispatch_arg_1))
		}
		'display_admin_notices' {
			this.display_admin_notices()
			return rt.new_null()
		}
		'column_schedule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_schedule(dispatch_arg_0)
		}
		'get_schedule_display_string' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Schedule](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_schedule_display_string(mut dispatch_arg_0))
		}
		'bulk_delete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.bulk_delete(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'row_action_cancel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.row_action_cancel(dispatch_arg_0)
			return rt.new_null()
		}
		'row_action_run' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.row_action_run(dispatch_arg_0)
			return rt.new_null()
		}
		'recreate_tables' {
			this.recreate_tables()
			return rt.new_null()
		}
		'process_row_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.process_row_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'display_filter_by_status' {
			this.display_filter_by_status()
			return rt.new_null()
		}
		'get_search_box_button_text' {
			return this.get_search_box_button_text()
		}
		'get_per_page_option_name' {
			return rt.new_string(this.get_per_page_option_name())
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_ListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'package' { return this.package }
		'columns' { return this.columns }
		'row_actions' { return this.row_actions }
		'store' { return this.store }
		'logger' { return this.logger }
		'runner' { return this.runner }
		'bulk_actions' { return this.bulk_actions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_ListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'package' {
			this.package = val
			return true
		}
		'columns' {
			this.columns = val
			return true
		}
		'row_actions' {
			this.row_actions = val
			return true
		}
		'store' {
			this.store = val
			return true
		}
		'logger' {
			this.logger = val
			return true
		}
		'runner' {
			this.runner = val
			return true
		}
		'bulk_actions' {
			this.bulk_actions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Abstract_ListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_ListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimezone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimezone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimezone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ActionScheduler_HybridStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_HybridStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_HybridStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_LoggerSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
