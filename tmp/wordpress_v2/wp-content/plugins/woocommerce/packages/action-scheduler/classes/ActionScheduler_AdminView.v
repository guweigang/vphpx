import rt

struct Class_ActionScheduler_AdminView {
	rt.PhpObjectBase
pub mut:
	list_table rt.PhpVal = rt.new_null()
}

fn init_static_actionscheduler_adminview() {
	rt.init_static_prop('ActionScheduler_AdminView', 'admin_view', rt.new_null())
	rt.init_static_prop('ActionScheduler_AdminView', 'screen_id',
		rt.new_string('tools_page_action-scheduler'))
}

fn Class_ActionScheduler_AdminView.instance() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('ActionScheduler_AdminView', 'admin_view')) {
		mut var_class := rt.call_function('apply_filters', [
			rt.new_string('action_scheduler_admin_view_class'),
			rt.new_string('ActionScheduler_AdminView'),
		])
		rt.set_static_prop('ActionScheduler_AdminView', 'admin_view', rt.new_object('', []string{}, rt.create_object_dynamically(var_class,
			[]rt.PhpVal{})))
	}
	return rt.get_static_prop('ActionScheduler_AdminView', 'admin_view')
}

fn (mut this Class_ActionScheduler_AdminView) init() {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('DOING_AJAX'))))) {
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WooCommerce')])) {
			rt.call_function('add_action', [
				rt.new_string('woocommerce_admin_status_content_action-scheduler'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
						'ActionScheduler_AdminView_Deprecated',
					], &this) },
					rt.ArrayItem{ key: none, val: 'render_admin_ui' },
				]),
			])
			rt.call_function('add_action', [
				rt.new_string('woocommerce_system_status_report'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
						'ActionScheduler_AdminView_Deprecated',
					], &this) },
					rt.ArrayItem{ key: none, val: 'system_status_report' },
				]),
			])
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_admin_status_tabs'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
						'ActionScheduler_AdminView_Deprecated',
					], &this) },
					rt.ArrayItem{ key: none, val: 'register_system_status_tab' },
				]),
			])
		}
		rt.call_function('add_action', [rt.new_string('admin_menu'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
					'ActionScheduler_AdminView_Deprecated',
				], &this) },
				rt.ArrayItem{ key: none, val: 'register_menu' },
			])])
		rt.call_function('add_action', [rt.new_string('admin_notices'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
					'ActionScheduler_AdminView_Deprecated',
				], &this) },
				rt.ArrayItem{ key: none, val: 'maybe_check_pastdue_actions' },
			])])
		rt.call_function('add_action', [rt.new_string('current_screen'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
					'ActionScheduler_AdminView_Deprecated',
				], &this) },
				rt.ArrayItem{ key: none, val: 'add_help_tabs' },
			])])
	}
}

fn (mut this Class_ActionScheduler_AdminView) system_status_report() {
	mut iife_temp_0 := Class_ActionScheduler{}
	mut iife_result_0 := iife_temp_0.store()
	mut var_table := create_actionscheduler_wcsystemstatus(iife_result_0)
	rt.call_method(var_table, 'render', []rt.PhpVal{})
}

fn (mut this Class_ActionScheduler_AdminView) register_system_status_tab(mut var_tabs Class_array) rt.PhpVal {
	mut var_tabs_mutated := var_tabs
	var_tabs_mutated.array_set('action-scheduler', rt.call_function('__', [
		rt.new_string('Scheduled Actions'),
		rt.new_string('woocommerce'),
	]))
	return rt.new_object('array', []string{}, var_tabs_mutated)
}

fn (mut this Class_ActionScheduler_AdminView) register_menu() {
	mut var_hook_suffix := rt.call_function('add_submenu_page', [
		rt.new_string('tools.php'),
		rt.call_function('__', [rt.new_string('Scheduled Actions'),
			rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('Scheduled Actions'),
			rt.new_string('woocommerce')]),
		rt.new_string('manage_options'),
		rt.new_string('action-scheduler'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
			'ActionScheduler_AdminView_Deprecated',
		], &this) }, rt.ArrayItem{ key: none, val: 'render_admin_ui' }]),
	])
	rt.call_function('add_action', [rt.new_string('load-' + var_hook_suffix.str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_AdminView', [
				'ActionScheduler_AdminView_Deprecated',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_ui' },
		])])
}

fn (mut this Class_ActionScheduler_AdminView) process_admin_ui() {
	this.get_list_table()
}

fn (mut this Class_ActionScheduler_AdminView) render_admin_ui() {
	mut var_table := this.get_list_table()
	rt.call_method(var_table, 'display_page', []rt.PhpVal{})
}

fn (mut this Class_ActionScheduler_AdminView) get_list_table() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.list_table)) {
		mut iife_temp_1 := Class_ActionScheduler{}
		mut iife_result_1 := iife_temp_1.store()
		mut iife_temp_2 := Class_ActionScheduler{}
		mut iife_result_2 := iife_temp_2.logger()
		mut iife_temp_3 := Class_ActionScheduler{}
		mut iife_result_3 := iife_temp_3.runner()
		this.list_table = create_actionscheduler_listtable(iife_result_1, iife_result_2,
			iife_result_3)
		rt.call_method(this.list_table, 'process_actions', []rt.PhpVal{})
	}
	return this.list_table
}

fn (mut this Class_ActionScheduler_AdminView) maybe_check_pastdue_actions() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_check_pastdue_actions'),
		rt.call_function('current_user_can', [rt.new_string('manage_options')]),
	])))))
	{
		return
	}
	mut var_last_check := rt.call_function('get_transient', [
		rt.new_string('action_scheduler_last_pastdue_actions_check'),
	])
	if !(!rt.is_true(var_last_check)) {
		return
	}
	this.check_pastdue_actions()
}

fn (mut this Class_ActionScheduler_AdminView) check_pastdue_actions() {
	mut var_threshold_seconds := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_pastdue_actions_seconds'),
		rt.get_constant('DAY_IN_SECONDS'),
	])).to_i64())
	mut var_threshold_min := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_pastdue_actions_min'),
		rt.new_int(1),
	])).to_i64())
	mut var_num_pastdue_actions := rt.new_int(0)
	mut var_check := rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_pastdue_actions_check_pre'),
		rt.new_null(),
	])
	if !(var_check.clone().is_null()) {
		return
	}
	mut var_query_args := {
		'date':     rt.call_function('as_get_datetime_object', [
			rt.sub(rt.call_function('time', []rt.PhpVal{}), var_threshold_seconds),
		])
		'status':   Class_ActionScheduler_Store.status_pending()
		'per_page': var_threshold_min
	}
	if rt.is_true(rt.new_bool(var_check.clone().is_null())) {
		mut iife_temp_4 := Class_ActionScheduler_Store{}
		mut iife_result_4 := iife_temp_4.instance()
		mut var_store := iife_result_4
		var_num_pastdue_actions = rt.new_int((rt.call_method(var_store, 'query_actions', [
			rt.create_array_from_native_map(var_query_args),
			rt.new_string('count'),
		])).to_i64())
		var_check = rt.greater_equal(var_num_pastdue_actions, var_threshold_min)
		var_check = rt.new_bool((rt.call_function('apply_filters', [
			rt.new_string('action_scheduler_pastdue_actions_check'),
			var_check.clone(),
			var_num_pastdue_actions.clone(),
			var_threshold_seconds.clone(),
			var_threshold_min.clone(),
		])).to_bool())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(var_check.clone())))))) {
		mut var_interval := rt.call_function('apply_filters', [
			rt.new_string('action_scheduler_pastdue_actions_check_interval'),
			rt.call_function('round', [rt.div(var_threshold_seconds, rt.new_int(4))]),
			var_threshold_seconds.clone(),
		])
		rt.call_function('set_transient', [
			rt.new_string('action_scheduler_last_pastdue_actions_check'),
			rt.call_function('time', []rt.PhpVal{}),
			var_interval.clone(),
		])
		return
	}
	mut var_actions_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'page', val: 'action-scheduler' },
			rt.ArrayItem{ key: 'status', val: 'past-due' }, rt.ArrayItem{ key: 'order', val: 'asc' }]),
		rt.call_function('admin_url', [rt.new_string('tools.php')]),
	])
	print('<div class="notice notice-warning"><p>')
	rt.call_function('printf', [
		rt.call_function('wp_kses', [
			rt.call_function('_n', [
				rt.new_string('<strong>Action Scheduler:</strong> %1$d <a href="%2$s">past-due action</a> found; something may be wrong. <a href="https://actionscheduler.org/faq/#my-site-has-past-due-actions-what-can-i-do" target="_blank">Read documentation &raquo;</a>'),
				rt.new_string('<strong>Action Scheduler:</strong> %1$d <a href="%2$s">past-due actions</a> found; something may be wrong. <a href="https://actionscheduler.org/faq/#my-site-has-past-due-actions-what-can-i-do" target="_blank">Read documentation &raquo;</a>'),
				var_num_pastdue_actions.clone(),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'strong', val: rt.new_array() },
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: true },
					rt.ArrayItem{ key: 'target', val: true },
				]) },
			]),
		]),
		rt.call_function('absint', [
			var_num_pastdue_actions.clone(),
		]),
		rt.call_function('esc_attr', [
			rt.call_function('esc_url', [
				var_actions_url.clone(),
			]),
		]),
	])
	print('</p></div>')
	rt.call_function('do_action', [
		rt.new_string('action_scheduler_pastdue_actions_extra_notices'),
		rt.create_array_from_native_map(var_query_args),
	])
}

fn (mut this Class_ActionScheduler_AdminView) add_help_tabs() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('ActionScheduler_AdminView', 'screen_id'), rt.get_property(var_screen, 'id'))))) {
		return
	}
	mut iife_temp_5 := Class_ActionScheduler_Versions{}
	mut iife_result_5 := iife_temp_5.instance()
	mut var_as_version := rt.call_method(iife_result_5, 'latest_version', []rt.PhpVal{})
	mut iife_temp_6 := Class_ActionScheduler_SystemInformation{}
	mut iife_result_6 := iife_temp_6.active_source()
	mut var_as_source := iife_result_6
	mut iife_temp_7 := Class_ActionScheduler_SystemInformation{}
	mut iife_result_7 := iife_temp_7.active_source_path()
	mut var_as_source_path := iife_result_7
	mut var_as_source_markup := rt.call_function('sprintf', [
		rt.new_string('<code>%s</code>'),
		rt.call_function('esc_html', [var_as_source_path.clone()]),
	])
	if !(!rt.is_true(var_as_source)) {
		var_as_source_markup = rt.call_function('sprintf', [
			rt.new_string('%s: <abbr title="%s">%s</abbr>'),
			rt.call_function('ucfirst', [var_as_source.array_get(rt.new_string('type'))]),
			rt.call_function('esc_attr', [var_as_source_path.clone()]),
			rt.call_function('esc_html', [var_as_source.array_get(rt.new_string('name'))]),
		])
	}
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'action_scheduler_about' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('About'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'content', val: '<h2>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('About Action Scheduler %s'), rt.new_string('woocommerce')]), var_as_version.clone()])).str() +
				'</h2>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Action Scheduler is a scalable, traceable job queue for background processing large sets of actions. Action Scheduler works by triggering an action hook to run at some time in the future. Scheduled actions can also be scheduled to run on a recurring schedule.'), rt.new_string('woocommerce')])).str() +
				'</p>' + '<h3>' +
				(rt.call_function('esc_html__', [rt.new_string('Source'), rt.new_string('woocommerce')])).str() +
				'</h3>' + '<p>' +
				(rt.call_function('esc_html__', [rt.new_string('Action Scheduler is currently being loaded from the following location. This can be useful when debugging, or if requested by the support team.'), rt.new_string('woocommerce')])).str() +
				'</p>' + '<p>' + var_as_source_markup.str() + '</p>' + '<h3>' +
				(rt.call_function('esc_html__', [rt.new_string('WP CLI'), rt.new_string('woocommerce')])).str() +
				'</h3>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('WP CLI commands are available: execute %1$s for a list of available commands.'), rt.new_string('woocommerce')]), rt.new_string('<code>wp help action-scheduler</code>')])).str() +
				'</p>' }]),
	])
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'action_scheduler_columns' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Columns'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'content', val: '<h2>' +
				(rt.call_function('__', [rt.new_string('Scheduled Action Columns'), rt.new_string('woocommerce')])).str() +
				'</h2>' + '<ul>' +
				(rt.call_function('sprintf', [rt.new_string('<li><strong>%1$s</strong>: %2$s</li>'), rt.call_function('__', [rt.new_string('Hook'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('Name of the action hook that will be triggered.'), rt.new_string('woocommerce')])])).str() +
				(rt.call_function('sprintf', [rt.new_string('<li><strong>%1$s</strong>: %2$s</li>'), rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('Action statuses are Pending, Complete, Canceled, Failed'), rt.new_string('woocommerce')])])).str() +
				(rt.call_function('sprintf', [rt.new_string('<li><strong>%1$s</strong>: %2$s</li>'), rt.call_function('__', [rt.new_string('Arguments'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('Optional data array passed to the action hook.'), rt.new_string('woocommerce')])])).str() +
				(rt.call_function('sprintf', [rt.new_string('<li><strong>%1$s</strong>: %2$s</li>'), rt.call_function('__', [rt.new_string('Group'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('Optional action group.'), rt.new_string('woocommerce')])])).str() +
				(rt.call_function('sprintf', [rt.new_string('<li><strong>%1$s</strong>: %2$s</li>'), rt.call_function('__', [rt.new_string('Recurrence'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string("The action's schedule frequency."), rt.new_string('woocommerce')])])).str() +
				(rt.call_function('sprintf', [rt.new_string('<li><strong>%1$s</strong>: %2$s</li>'), rt.call_function('__', [rt.new_string('Scheduled'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('The date/time the action is/was scheduled to run.'), rt.new_string('woocommerce')])])).str() +
				(rt.call_function('sprintf', [rt.new_string('<li><strong>%1$s</strong>: %2$s</li>'), rt.call_function('__', [rt.new_string('Log'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('Activity log for the action.'), rt.new_string('woocommerce')])])).str() +
				'</ul>' }]),
	])
}

struct Class_ActionScheduler_AdminView_Deprecated {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_wcSystemStatus {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_ListTable {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_SystemInformation {
	rt.PhpObjectBase
}

fn create_actionscheduler_adminview(_args ...rt.PhpVal) &Class_ActionScheduler_AdminView {
	mut obj := &Class_ActionScheduler_AdminView{
		PhpObjectBase: rt.PhpObjectBase{}
		list_table:    rt.new_null()
	}
	return obj
}

fn create_actionscheduler_adminview_deprecated(_args ...rt.PhpVal) &Class_ActionScheduler_AdminView_Deprecated {
	mut obj := &Class_ActionScheduler_AdminView_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_wcsystemstatus(_args ...rt.PhpVal) &Class_ActionScheduler_wcSystemStatus {
	mut obj := &Class_ActionScheduler_wcSystemStatus{
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

fn create_actionscheduler_listtable(_args ...rt.PhpVal) &Class_ActionScheduler_ListTable {
	mut obj := &Class_ActionScheduler_ListTable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_versions(_args ...rt.PhpVal) &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_systeminformation(_args ...rt.PhpVal) &Class_ActionScheduler_SystemInformation {
	mut obj := &Class_ActionScheduler_SystemInformation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_AdminView) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_ActionScheduler_AdminView.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'system_status_report' {
			this.system_status_report()
			return rt.new_null()
		}
		'register_system_status_tab' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.register_system_status_tab(mut dispatch_arg_0)
		}
		'register_menu' {
			this.register_menu()
			return rt.new_null()
		}
		'process_admin_ui' {
			this.process_admin_ui()
			return rt.new_null()
		}
		'render_admin_ui' {
			this.render_admin_ui()
			return rt.new_null()
		}
		'get_list_table' {
			return this.get_list_table()
		}
		'maybe_check_pastdue_actions' {
			this.maybe_check_pastdue_actions()
			return rt.new_null()
		}
		'check_pastdue_actions' {
			this.check_pastdue_actions()
			return rt.new_null()
		}
		'add_help_tabs' {
			this.add_help_tabs()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_AdminView) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'list_table' { return this.list_table }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_AdminView) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'list_table' {
			this.list_table = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_AdminView_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_wcSystemStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_wcSystemStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wcSystemStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ActionScheduler_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_ListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_ListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_SystemInformation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_SystemInformation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_SystemInformation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('ActionScheduler_AdminView', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_adminview()
		return rt.new_object('ActionScheduler_AdminView', [
			'ActionScheduler_AdminView_Deprecated',
		], obj)
	})
	rt.register_class_factory('ActionScheduler_AdminView_Deprecated', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_adminview_deprecated()
		return rt.new_object('ActionScheduler_AdminView_Deprecated', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_wcSystemStatus', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_wcsystemstatus()
		return rt.new_object('ActionScheduler_wcSystemStatus', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler()
		return rt.new_object('ActionScheduler', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_ListTable', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_listtable()
		return rt.new_object('ActionScheduler_ListTable', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_store()
		return rt.new_object('ActionScheduler_Store', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_Versions', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_versions()
		return rt.new_object('ActionScheduler_Versions', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_SystemInformation', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_systeminformation()
		return rt.new_object('ActionScheduler_SystemInformation', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
