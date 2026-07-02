import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.dismissed_option() string {
	return 'woocommerce_task_list_dismissed_tasks'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.snoozed_option() string {
	return 'woocommerce_task_list_remind_me_later_tasks'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.actioned_option() string {
	return 'woocommerce_task_list_tracked_completed_actions'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.completed_option() string {
	return 'woocommerce_task_list_tracked_completed_tasks'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.active_task_transient() string {
	return 'wc_onboarding_active_task'
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
pub mut:
	task_list      rt.PhpVal = rt.new_null()
	duration_to_ms rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) construct(var_task_list rt.PhpVal) {
	this.task_list = var_task_list.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_id() {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_title() {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_content() {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_time() {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_parent_id() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.task_list)))) {
		return ''
	}
	return (rt.call_method(this.task_list, 'get_list_id', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_parent_options() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.task_list)))) {
		return rt.new_array()
	}
	return rt.get_property(this.task_list, 'options')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_parent_option(var_option_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(this.task_list)
		&& rt.get_property(this.task_list, 'options').array_isset(var_option_name) {
		return rt.get_property(this.task_list, 'options').array_get(var_option_name)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) prefix_event(var_event_name rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.task_list)))) {
		return ''
	}
	return (rt.call_method(this.task_list, 'prefix_event', [var_event_name.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_additional_info() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_additional_data() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_badge() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_level() i64 {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	return 3
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_action_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string("Let's go"),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_action_url() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_dismissable() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_dismissed() bool {
	if !(this.is_dismissable()) {
		return false
	}
	mut var_dismissed := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.dismissed_option(),
		rt.new_array(),
	])
	return (rt.call_function('in_array', [this.get_id(), var_dismissed.clone(),
		rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dismiss() bool {
	if !(this.is_dismissable()) {
		return false
	}
	mut var_dismissed := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.dismissed_option(),
		rt.new_array(),
	])
	var_dismissed.array_push(this.get_id())
	mut var_update := rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.dismissed_option(),
		rt.call_function('array_unique', [var_dismissed.clone()]),
	])
	if rt.is_true(var_update) {
		this.record_tracks_event(rt.new_string('dismiss_task'), rt.create_array([
			rt.ArrayItem{ key: 'task_name', val: this.get_id() },
		]))
	}
	return var_update.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) undo_dismiss() rt.PhpVal {
	mut var_dismissed := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.dismissed_option(),
		rt.new_array(),
	])
	var_dismissed = rt.call_function('array_diff', [var_dismissed.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() }])])
	mut var_update := rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.dismissed_option(),
		var_dismissed.clone(),
	])
	if rt.is_true(var_update) {
		this.record_tracks_event(rt.new_string('undo_dismiss_task'), rt.create_array([
			rt.ArrayItem{ key: 'task_name', val: this.get_id() },
		]))
	}
	return var_update.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_snoozeable() bool {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_snoozed_until() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	mut var_snoozed_tasks := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.snoozed_option(),
		rt.new_array(),
	])
	if var_snoozed_tasks.array_isset(this.get_id()) {
		return var_snoozed_tasks.array_get(this.get_id())
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_snoozed() bool {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	if !(this.is_snoozeable()) {
		return false
	}
	mut var_snoozed := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.snoozed_option(),
		rt.new_array(),
	])
	return var_snoozed.array_isset(this.get_id())
		&& rt.is_true(rt.greater(var_snoozed.array_get(this.get_id()), rt.mul(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1000))))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) snooze(duration string) bool {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	if !(this.is_snoozeable()) {
		return false
	}
	mut var_snoozed := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.snoozed_option(),
		rt.new_array(),
	])
	mut var_snoozed_until := rt.add(this.duration_to_ms.array_get(rt.new_string(duration)), rt.mul(rt.call_function('time',
		[]rt.PhpVal{}), rt.new_int(1000)))
	var_snoozed.array_set(this.get_id(), var_snoozed_until.clone())
	mut var_update := rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.snoozed_option(),
		var_snoozed.clone(),
	])
	if rt.is_true(var_update) {
		if rt.is_true(var_update) {
			this.record_tracks_event(rt.new_string('remindmelater_task'), rt.create_array([
				rt.ArrayItem{ key: 'task_name', val: this.get_id() },
			]))
		}
	}
	return var_update.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) undo_snooze() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	mut var_snoozed := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.snoozed_option(),
		rt.new_array(),
	])
	var_snoozed.array_unset(this.get_id())
	mut var_update := rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.snoozed_option(),
		var_snoozed.clone(),
	])
	if rt.is_true(var_update) {
		this.record_tracks_event(rt.new_string('undo_remindmelater_task'), rt.create_array([
			rt.ArrayItem{ key: 'task_name', val: this.get_id() },
		]))
	}
	return var_update.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) has_previously_completed() rt.PhpVal {
	mut var_complete := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.completed_option(),
		rt.new_array(),
	])
	return rt.call_function('in_array', [this.get_id(), var_complete.clone(),
		rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) possibly_track_completion() {
	if rt.is_true(this.has_previously_completed()) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_complete())))) {
		return
	}
	mut var_completed_tasks := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.completed_option(),
		rt.new_array(),
	])
	var_completed_tasks.array_push(this.get_id())
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.completed_option(),
		var_completed_tasks.clone(),
	])
	this.record_tracks_event(rt.new_string('task_completed'), rt.create_array([
		rt.ArrayItem{ key: 'task_name', val: this.get_id() },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) set_active() {
	if rt.is_true(this.is_complete()) {
		return
	}
	rt.call_function('set_transient', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.active_task_transient(),
		this.get_id(),
		rt.get_constant('DAY_IN_SECONDS'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_active() rt.PhpVal {
	return rt.identical(rt.call_function('get_transient', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.active_task_transient(),
	]), this.get_id())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) can_view() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_disabled() bool {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('7.2.0')])
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_complete() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{}
	mut iife_result_0 := iife_temp_0.is_actioned()
	return iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_in_progress() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) in_progress_label() rt.PhpVal {
	return rt.call_function('esc_html__', [rt.new_string('In progress'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_always_accessible() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_visited() bool {
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}
	mut iife_result_1 := iife_temp_1.get_user_data_field(var_user_id.clone(),
		rt.new_string('task_list_tracked_started_tasks'))
	mut var_response := iife_result_1
	mut var_tracked_tasks := if rt.is_true(var_response) { rt.call_function('json_decode', [
			var_response.clone(),
			rt.new_bool(true),
		]) } else { rt.new_array() }
	return var_tracked_tasks.array_isset(this.get_id())
		&& rt.is_true(rt.greater(var_tracked_tasks.array_get(this.get_id()), rt.new_int(0)))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_record_view_event() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) get_json() rt.PhpVal {
	mut var_is_complete := this.is_complete()
	if rt.is_true(var_is_complete) {
		this.possibly_track_completion()
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() },
		rt.ArrayItem{ key: 'parentId', val: this.get_parent_id() },
		rt.ArrayItem{ key: 'title', val: this.get_title() }, rt.ArrayItem{
			key: 'badge'
			val: this.get_badge()
		}, rt.ArrayItem{ key: 'canView', val: this.can_view() },
		rt.ArrayItem{ key: 'content', val: this.get_content() },
		rt.ArrayItem{ key: 'additionalInfo', val: this.get_additional_info() },
		rt.ArrayItem{ key: 'actionLabel', val: this.get_action_label() },
		rt.ArrayItem{ key: 'actionUrl', val: this.get_action_url() },
		rt.ArrayItem{ key: 'isComplete', val: var_is_complete },
		rt.ArrayItem{ key: 'isInProgress', val: this.is_in_progress() },
		rt.ArrayItem{ key: 'inProgressLabel', val: this.in_progress_label() },
		rt.ArrayItem{ key: 'time', val: this.get_time() }, rt.ArrayItem{ key: 'level', val: 3 },
		rt.ArrayItem{ key: 'isActioned', val: this.is_actioned() },
		rt.ArrayItem{ key: 'isDismissed', val: this.is_dismissed() },
		rt.ArrayItem{ key: 'isDismissable', val: this.is_dismissable() },
		rt.ArrayItem{ key: 'isSnoozed', val: false }, rt.ArrayItem{ key: 'isSnoozeable', val: false },
		rt.ArrayItem{ key: 'isVisited', val: this.is_visited() },
		rt.ArrayItem{ key: 'isDisabled', val: false }, rt.ArrayItem{
			key: 'snoozedUntil'
			val: rt.new_null()
		}, rt.ArrayItem{
			key: 'additionalData'
			val: Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.convert_object_to_camelcase(this.get_additional_data())
		}, rt.ArrayItem{ key: 'eventPrefix', val: this.prefix_event(rt.new_string('')) },
		rt.ArrayItem{ key: 'recordViewEvent', val: this.get_record_view_event() }])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.convert_object_to_camelcase(var_data rt.PhpVal) rt.PhpVal {
	if !(var_data.clone().is_array()) {
		return var_data.clone()
	}
	mut var_new_object := rt.array_to_object(rt.new_array())
	mut iter_1 := var_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		mut var_new_key := rt.call_function('lcfirst', [
			rt.call_function('implode', [rt.new_string(''),
				rt.call_function('array_map', [rt.new_string('ucfirst'),
					rt.call_function('explode', [rt.new_string('_'),
						var_key.clone()])])]),
		])
		rt.set_property(var_new_object, '{"nodeType":"Expr_Variable","line":571,"name":"new_key"}',
			var_value.clone())
	}
	return var_new_object.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) mark_actioned() rt.PhpVal {
	mut var_actioned := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.actioned_option(),
		rt.new_array(),
	])
	var_actioned.array_push(this.get_id())
	mut var_update := rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.actioned_option(),
		rt.call_function('array_unique', [var_actioned.clone()]),
	])
	if rt.is_true(var_update) {
		this.record_tracks_event(rt.new_string('actioned_task'), rt.create_array([
			rt.ArrayItem{ key: 'task_name', val: this.get_id() },
		]))
	}
	return var_update.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) is_actioned() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.is_task_actioned(this.get_id())
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.is_task_actioned(var_id rt.PhpVal) rt.PhpVal {
	mut var_actioned := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.actioned_option(),
		rt.new_array(),
	])
	return rt.call_function('in_array', [var_id.clone(), var_actioned.clone(),
		rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.sort(var_a rt.PhpVal, var_b rt.PhpVal, var_sort_by rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_int(0)
	mut iter_2 := var_sort_by.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_data := item_2.val
		mut var_key := var_data.array_get(rt.new_string('key'))
		mut var_a_val := if !(rt.get_property(var_a,
			'{"nodeType":"Expr_Variable","line":627,"name":"key"}')).is_null() {
			rt.get_property(var_a, '{"nodeType":"Expr_Variable","line":627,"name":"key"}')
		} else {
			rt.new_bool(false)
		}
		mut var_b_val := if !(rt.get_property(var_b,
			'{"nodeType":"Expr_Variable","line":628,"name":"key"}')).is_null() {
			rt.get_property(var_b, '{"nodeType":"Expr_Variable","line":628,"name":"key"}')
		} else {
			rt.new_bool(false)
		}
		if rt.is_true(rt.identical(rt.new_string('asc'), var_data.array_get(rt.new_string('order')))) {
			var_result = rt.new_null()
		} else {
			var_result = rt.new_null()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_result)))) {
			break
		}
	}
	return var_result.clone()
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase:  rt.PhpObjectBase{}
		task_list:      rt.new_null()
		duration_to_ms: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminuser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			this.get_id()
			return rt.new_null()
		}
		'get_title' {
			this.get_title()
			return rt.new_null()
		}
		'get_content' {
			this.get_content()
			return rt.new_null()
		}
		'get_time' {
			this.get_time()
			return rt.new_null()
		}
		'get_parent_id' {
			return rt.new_string(this.get_parent_id())
		}
		'get_parent_options' {
			return this.get_parent_options()
		}
		'get_parent_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_parent_option(dispatch_arg_0)
		}
		'prefix_event' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.prefix_event(dispatch_arg_0))
		}
		'get_additional_info' {
			return rt.new_string(this.get_additional_info())
		}
		'get_additional_data' {
			return this.get_additional_data()
		}
		'get_badge' {
			return rt.new_string(this.get_badge())
		}
		'get_level' {
			return rt.new_int(this.get_level())
		}
		'get_action_label' {
			return this.get_action_label()
		}
		'get_action_url' {
			return this.get_action_url()
		}
		'is_dismissable' {
			return rt.new_bool(this.is_dismissable())
		}
		'is_dismissed' {
			return rt.new_bool(this.is_dismissed())
		}
		'dismiss' {
			return rt.new_bool(this.dismiss())
		}
		'undo_dismiss' {
			return this.undo_dismiss()
		}
		'is_snoozeable' {
			return rt.new_bool(this.is_snoozeable())
		}
		'get_snoozed_until' {
			return this.get_snoozed_until()
		}
		'is_snoozed' {
			return rt.new_bool(this.is_snoozed())
		}
		'snooze' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.snooze(dispatch_arg_0))
		}
		'undo_snooze' {
			return this.undo_snooze()
		}
		'has_previously_completed' {
			return this.has_previously_completed()
		}
		'possibly_track_completion' {
			this.possibly_track_completion()
			return rt.new_null()
		}
		'set_active' {
			this.set_active()
			return rt.new_null()
		}
		'is_active' {
			return this.is_active()
		}
		'can_view' {
			return rt.new_bool(this.can_view())
		}
		'is_disabled' {
			return rt.new_bool(this.is_disabled())
		}
		'is_complete' {
			return this.is_complete()
		}
		'is_in_progress' {
			return rt.new_bool(this.is_in_progress())
		}
		'in_progress_label' {
			return this.in_progress_label()
		}
		'is_always_accessible' {
			return rt.new_bool(this.is_always_accessible())
		}
		'is_visited' {
			return rt.new_bool(this.is_visited())
		}
		'get_record_view_event' {
			return rt.new_bool(this.get_record_view_event())
		}
		'get_json' {
			return this.get_json()
		}
		'convert_object_to_camelcase' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.convert_object_to_camelcase(dispatch_arg_0)
		}
		'mark_actioned' {
			return this.mark_actioned()
		}
		'is_actioned' {
			return this.is_actioned()
		}
		'is_task_actioned' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.is_task_actioned(dispatch_arg_0)
		}
		'sort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.sort(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'task_list' { return this.task_list }
		'duration_to_ms' { return this.duration_to_ms }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'task_list' {
			this.task_list = val
			return true
		}
		'duration_to_ms' {
			this.duration_to_ms = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
