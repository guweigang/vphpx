import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.hidden_option() string {
	return 'woocommerce_task_list_hidden_lists'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.completed_option() string {
	return 'woocommerce_task_list_completed_lists'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.reminder_bar_hidden_option() string {
	return 'woocommerce_task_list_reminder_bar_hidden'
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList {
	rt.PhpObjectBase
pub mut:
	id                      rt.PhpVal = rt.new_string('')
	hidden_id               rt.PhpVal = rt.new_string('')
	display_progress_header rt.PhpVal = rt.new_bool(false)
	title                   rt.PhpVal = rt.new_string('')
	tasks                   rt.PhpVal = rt.new_array()
	sort_by                 rt.PhpVal = rt.new_array()
	event_prefix            rt.PhpVal = rt.new_null()
	visible                 rt.PhpVal = rt.new_bool(true)
	options                 rt.PhpVal = rt.new_array()
	sections                rt.PhpVal = rt.new_array()
	task_class_id_map       rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) construct(var_data rt.PhpVal) {
	mut var_data_mutated := var_data
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_null() },
		rt.ArrayItem{ key: 'hidden_id', val: rt.new_null() },
		rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'tasks', val: rt.new_array() },
		rt.ArrayItem{ key: 'sort_by', val: rt.new_array() }, rt.ArrayItem{
			key: 'event_prefix'
			val: rt.new_null()
		}, rt.ArrayItem{ key: 'options', val: rt.new_array() },
		rt.ArrayItem{ key: 'visible', val: true }, rt.ArrayItem{
			key: 'display_progress_header'
			val: false
		}])
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(),
		var_defaults.clone()])
	this.id = var_data_mutated.array_get(rt.new_string('id'))
	this.hidden_id = var_data_mutated.array_get(rt.new_string('hidden_id'))
	this.title = var_data_mutated.array_get(rt.new_string('title'))
	this.sort_by = var_data_mutated.array_get(rt.new_string('sort_by'))
	this.event_prefix = var_data_mutated.array_get(rt.new_string('event_prefix'))
	this.options = var_data_mutated.array_get(rt.new_string('options'))
	this.visible = var_data_mutated.array_get(rt.new_string('visible'))
	this.display_progress_header =
		var_data_mutated.array_get(rt.new_string('display_progress_header'))
	mut iter_1 := var_data_mutated.array_get(rt.new_string('tasks')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_task_name := item_1.val
		mut var_class := rt.new_string(
			'Automattic\\WooCommerce\\Admin\\Features\\OnboardingTasks\\Tasks\\' +
			var_task_name.str())
		mut var_task := rt.create_object_dynamically(var_class, [
			rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList',
				[]string{}, &this),
		])
		this.add_task(var_task.clone())
	}
	this.possibly_remove_reminder_bar()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) is_hidden() rt.PhpVal {
	mut var_hidden := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.hidden_option(),
		rt.new_array(),
	])
	return rt.call_function('in_array', [if rt.is_true(this.hidden_id) {
		this.hidden_id
	} else {
		this.id
	}, var_hidden.clone(), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) is_visible() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.visible)))) {
		return false
	}
	if rt.is_true(this.is_hidden()) {
		return false
	}
	mut var_no_viewable_tasks := rt.new_bool(this.get_viewable_tasks().array_count() == 0)
	if rt.is_true(var_no_viewable_tasks) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) hide() rt.PhpVal {
	if rt.is_true(this.is_hidden()) {
		return rt.new_null()
	}
	mut var_viewable_tasks := this.get_viewable_tasks()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_total := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_task := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return if rt.is_true(rt.call_method(var_task, 'is_complete', []rt.PhpVal{})) {
			rt.add(var_total, rt.new_int(1))
		} else {
			var_total
		}
	}
	mut var_completed_count := rt.call_function('array_reduce', [
		var_viewable_tasks.clone(), rt.new_closure(closure_1_fn),
		rt.new_int(0)])
	this.record_tracks_event(rt.new_string('completed'), rt.create_array([
		rt.ArrayItem{ key: 'action', val: 'remove_card' },
		rt.ArrayItem{ key: 'completed_task_count', val: var_completed_count },
		rt.ArrayItem{ key: 'incomplete_task_count', val: rt.sub(rt.new_int(var_viewable_tasks.clone().array_count()),
			var_completed_count) },
		rt.ArrayItem{ key: 'tasklist_id', val: this.id },
	]))
	mut var_hidden := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.hidden_option(),
		rt.new_array(),
	])
	var_hidden.array_push(if rt.is_true(this.hidden_id) { this.hidden_id } else { this.id })
	this.maybe_set_default_layout(var_hidden.clone())
	return rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.hidden_option(),
		rt.call_function('array_unique', [var_hidden.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) maybe_set_default_layout(var_completed_or_hidden_tasklist_ids rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array', [rt.new_string('setup'),
		var_completed_or_hidden_tasklist_ids.clone(), rt.new_bool(true)]))
	{
		rt.call_function('update_option', [
			rt.new_string('woocommerce_default_homepage_layout'),
			rt.new_string('two_columns'),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) unhide() rt.PhpVal {
	mut var_hidden := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.hidden_option(),
		rt.new_array(),
	])
	var_hidden = rt.call_function('array_diff', [var_hidden.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: if rt.is_true(this.hidden_id) { this.hidden_id } else { this.id }
			},
		])])
	return rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.hidden_option(),
		var_hidden.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) is_complete() bool {
	mut iter_2 := this.get_viewable_tasks().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_viewable_task := item_2.val
		if rt.is_true(rt.identical(rt.call_method(var_viewable_task, 'is_complete', []rt.PhpVal{}),
			rt.new_bool(false)))
		{
			return false
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) has_previously_completed() rt.PhpVal {
	mut var_complete := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.completed_option(),
		rt.new_array(),
	])
	return rt.call_function('in_array', [this.get_list_id(), var_complete.clone(),
		rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) add_task(var_task rt.PhpVal) rt.PhpVal {
	mut var_task_mutated := var_task
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [
		var_task_mutated.clone(),
		rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\OnboardingTasks\\Task'),
	])))))
	{
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_features_onboardingtasks_wp_error(rt.new_string('woocommerce_task_list_invalid_task'), rt.call_function('__', [
			rt.new_string('Task is not a subclass of `Task`'),
			rt.new_string('woocommerce'),
		])))
	}
	if rt.is_true(rt.call_function('array_search', [var_task_mutated.clone(), this.tasks,
		rt.new_bool(true)]))
	{
		return rt.new_null()
	}
	this.tasks.array_push(var_task_mutated.clone())
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) get_task(var_task_id rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_task_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.call_method(var_task, 'get_id', []rt.PhpVal{}), var_task_id)
	}
	closure_3_fn := fn [var_task_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.call_method(var_task, 'get_id', []rt.PhpVal{}), var_task_id)
	}
	return rt.call_function('current', [
		rt.call_function('array_filter', [this.tasks, rt.new_closure(closure_2_fn)]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) get_viewable_tasks() rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_task, 'can_view', []rt.PhpVal{})
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_task, 'can_view', []rt.PhpVal{})
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [this.tasks, rt.new_closure(closure_4_fn)]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) get_sections() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	return this.sections
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) possibly_track_completion() {
	if rt.is_true(this.has_previously_completed()) {
		return
	}
	if rt.is_true(this.is_hidden()) {
		return
	}
	if !(this.is_complete()) {
		return
	}
	mut var_completed_lists := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.completed_option(),
		rt.new_array(),
	])
	var_completed_lists.array_push(this.get_list_id())
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.completed_option(),
		var_completed_lists.clone(),
		rt.new_bool(true),
	])
	this.maybe_set_default_layout(var_completed_lists.clone())
	this.record_tracks_event(rt.new_string('tasks_completed'), rt.create_array([
		rt.ArrayItem{ key: 'tasklist_id', val: this.id },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) sort_tasks(var_sort_by rt.PhpVal) rt.PhpVal {
	mut var_sort_by_mutated := var_sort_by
	var_sort_by_mutated = if var_sort_by_mutated.clone().array_count() > 0 {
		var_sort_by_mutated
	} else {
		this.sort_by
	}
	if rt.is_true(rt.new_bool(0 != var_sort_by_mutated.clone().array_count())) {
		closure_7_fn := fn [var_sort_by] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{}
			mut iife_result_6 := iife_temp_6.sort(var_a.clone(), var_b.clone(),
				var_sort_by_mutated.clone())
			return iife_result_6
		}
		rt.call_function('usort', [this.tasks, rt.new_closure(closure_7_fn)])
	}
	return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) prefix_event(var_event_name rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.event_prefix)))) {
		return (this.event_prefix).str() + var_event_name.str()
	}
	return (this.get_list_id()).str() + '_tasklist_' + var_event_name.str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) get_keep_completed_task_list() rt.PhpVal {
	return rt.call_function('get_option', [
		rt.new_string('woocommerce_task_list_keep_completed'),
		rt.new_string('no'),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.possibly_remove_reminder_bar() {
	mut var_bar_hidden := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.reminder_bar_hidden_option(),
		rt.new_string('no'),
	])
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}
	mut iife_result_7 := iife_temp_7.is_wc_admin_active_for(rt.mul(rt.get_constant('WEEK_IN_SECONDS'),
		rt.new_int(4)))
	mut var_active_for_four_weeks := iife_result_7
	if rt.is_true(rt.identical(rt.new_string('yes'), var_bar_hidden))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_active_for_four_weeks)))) {
		return
	}
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.reminder_bar_hidden_option(),
		rt.new_string('yes'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) get_json() rt.PhpVal {
	this.possibly_track_completion()
	mut var_tasks_json := rt.new_array()
	mut iter_3 := this.tasks.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_task := item_3.val
		mut var_list_is_visible := rt.new_bool(this.is_visible()
			|| rt.is_true(rt.identical(rt.new_string('secret_tasklist'), this.id)))
		if rt.is_true(var_list_is_visible)|| (rt.is_true(rt.call_function('method_exists', [var_task.clone(), rt.new_string('is_always_accessible')]))
			&& rt.is_true(rt.call_method(var_task, 'is_always_accessible', []rt.PhpVal{}))) {
			mut var_json := rt.call_method(var_task, 'get_json', []rt.PhpVal{})
			if rt.is_true(var_json.array_get(rt.new_string('canView'))) {
				var_tasks_json.array_push(var_json.clone())
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_list_id() },
		rt.ArrayItem{ key: 'title', val: this.title }, rt.ArrayItem{
			key: 'isHidden'
			val: this.is_hidden()
		}, rt.ArrayItem{ key: 'isVisible', val: this.is_visible() },
		rt.ArrayItem{ key: 'isComplete', val: this.is_complete() },
		rt.ArrayItem{ key: 'tasks', val: var_tasks_json }, rt.ArrayItem{
			key: 'eventPrefix'
			val: this.prefix_event(rt.new_string(''))
		}, rt.ArrayItem{ key: 'displayProgressHeader', val: this.display_progress_header },
		rt.ArrayItem{ key: 'keepCompletedTaskList', val: this.get_keep_completed_task_list() }])
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklist(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList{
		PhpObjectBase:           rt.PhpObjectBase{}
		id:                      rt.new_string('')
		hidden_id:               rt.new_string('')
		display_progress_header: rt.new_bool(false)
		title:                   rt.new_string('')
		tasks:                   rt.new_array()
		sort_by:                 rt.new_array()
		event_prefix:            rt.new_null()
		visible:                 rt.new_bool(true)
		options:                 rt.new_array()
		sections:                rt.new_array()
		task_class_id_map:       rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wcadminhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'is_hidden' {
			return this.is_hidden()
		}
		'is_visible' {
			return rt.new_bool(this.is_visible())
		}
		'hide' {
			return this.hide()
		}
		'maybe_set_default_layout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_set_default_layout(dispatch_arg_0)
			return rt.new_null()
		}
		'unhide' {
			return this.unhide()
		}
		'is_complete' {
			return rt.new_bool(this.is_complete())
		}
		'has_previously_completed' {
			return this.has_previously_completed()
		}
		'add_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_task(dispatch_arg_0)
		}
		'get_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_task(dispatch_arg_0)
		}
		'get_viewable_tasks' {
			return this.get_viewable_tasks()
		}
		'get_sections' {
			return this.get_sections()
		}
		'possibly_track_completion' {
			this.possibly_track_completion()
			return rt.new_null()
		}
		'sort_tasks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sort_tasks(dispatch_arg_0)
		}
		'prefix_event' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.prefix_event(dispatch_arg_0))
		}
		'get_keep_completed_task_list' {
			return this.get_keep_completed_task_list()
		}
		'possibly_remove_reminder_bar' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.possibly_remove_reminder_bar()
			return rt.new_null()
		}
		'get_json' {
			return this.get_json()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'hidden_id' { return this.hidden_id }
		'display_progress_header' { return this.display_progress_header }
		'title' { return this.title }
		'tasks' { return this.tasks }
		'sort_by' { return this.sort_by }
		'event_prefix' { return this.event_prefix }
		'visible' { return this.visible }
		'options' { return this.options }
		'sections' { return this.sections }
		'task_class_id_map' { return this.task_class_id_map }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'hidden_id' {
			this.hidden_id = val
			return true
		}
		'display_progress_header' {
			this.display_progress_header = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'tasks' {
			this.tasks = val
			return true
		}
		'sort_by' {
			this.sort_by = val
			return true
		}
		'event_prefix' {
			this.event_prefix = val
			return true
		}
		'visible' {
			this.visible = val
			return true
		}
		'options' {
			this.options = val
			return true
		}
		'sections' {
			this.sections = val
			return true
		}
		'task_class_id_map' {
			this.task_class_id_map = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_automattic_woocommerce_admin_features_onboardingtasks_tasklist(c_arg_0)
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_onboardingtasks_wp_error()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_onboardingtasks_task()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_WCAdminHelper', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_wcadminhelper()
		return rt.new_object('Automattic_WooCommerce_Admin_WCAdminHelper', []string{}, obj)
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
