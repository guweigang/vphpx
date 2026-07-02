import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.default_tasks() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'StoreDetails' }, rt.ArrayItem{ key: none, val: 'Products' }, rt.ArrayItem{ key: none, val: 'WooCommercePayments' }, rt.ArrayItem{ key: none, val: 'Payments' }, rt.ArrayItem{ key: none, val: 'Tax' }, rt.ArrayItem{ key: none, val: 'Shipping' }, rt.ArrayItem{ key: none, val: 'Marketing' }, rt.ArrayItem{ key: none, val: 'AdditionalPayments' }, rt.ArrayItem{ key: none, val: 'ReviewShippingOptions' }, rt.ArrayItem{ key: none, val: 'GetMobileApp' }])
}
struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_features_onboardingtasks_tasklists() {
		rt.init_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'instance', rt.new_null())
		rt.init_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'default_tasks_loaded', rt.new_bool(false))
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'instance'))))) {
		rt.set_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'instance', rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_static', []string{}, create_automattic_woocommerce_admin_features_onboardingtasks_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'instance')
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.init() {
	Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.init_default_lists()
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'set_active_task' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'init_tasks' }])])
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'menu_task_count' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'task_list_preloaded_settings' }]), rt.new_int(20)])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.is_experiment_treatment(var_name rt.PhpVal) rt.PhpVal {
	mut var_anon_id := if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').array_get(rt.new_string('tk_ai'))])]) } else { rt.new_string('') }
	mut var_allow_tracking := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking')]))
	mut var_abtest := create_automattic_woocommerce_admin_features_onboardingtasks_woocommerce_admin_experimental_abtest(var_anon_id.clone(), rt.new_string('woocommerce'), var_allow_tracking.clone())
	mut var_date := create_automattic_woocommerce_admin_features_onboardingtasks_datetime()
	var_date.settimezone(create_automattic_woocommerce_admin_features_onboardingtasks_datetimezone(rt.new_string('UTC')))
	mut var_experiment_name := rt.call_function('sprintf', [rt.new_string('%s_%s_%s'), var_name.clone(), var_date.format(rt.new_string('Y')), var_date.format(rt.new_string('m'))])
	return rt.identical(var_abtest.get_variation(var_experiment_name.clone()), rt.new_string('treatment'))
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.init_default_lists() {
	mut var_tasks := rt.create_array([rt.ArrayItem{ key: none, val: 'StoreDetails' }, rt.ArrayItem{ key: none, val: 'Products' }, rt.ArrayItem{ key: none, val: 'Payments' }, rt.ArrayItem{ key: none, val: 'CustomizeStore' }, rt.ArrayItem{ key: none, val: 'Tax' }, rt.ArrayItem{ key: none, val: 'Shipping' }, rt.ArrayItem{ key: none, val: 'LaunchYourStore' }])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('core-profiler'))
	if rt.is_true(iife_result_0) {
		mut var_key := rt.call_function('array_search', [rt.new_string('StoreDetails'), var_tasks.clone(), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
			var_tasks.array_unset(var_key)
		}
	}
	Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_list(rt.create_array([rt.ArrayItem{ key: 'id', val: 'setup' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Get ready to start selling'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'tasks', val: var_tasks }, rt.ArrayItem{ key: 'display_progress_header', val: true }, rt.ArrayItem{ key: 'event_prefix', val: 'tasklist_' }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'use_completed_title', val: true }]) }, rt.ArrayItem{ key: 'visible', val: true }]))
	Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_list(rt.create_array([rt.ArrayItem{ key: 'id', val: 'extended' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Things to do next'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'sort_by', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'is_complete' }, rt.ArrayItem{ key: 'order', val: 'asc' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'level' }, rt.ArrayItem{ key: 'order', val: 'asc' }]) }]) }, rt.ArrayItem{ key: 'tasks', val: rt.create_array([rt.ArrayItem{ key: none, val: 'Marketing' }, rt.ArrayItem{ key: none, val: 'ExtendStore' }, rt.ArrayItem{ key: none, val: 'AdditionalPayments' }, rt.ArrayItem{ key: none, val: 'GetMobileApp' }]) }]))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_1 := iife_temp_1.is_enabled(rt.new_string('shipping-smart-defaults'))
	if rt.is_true(iife_result_1) {
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_task(rt.new_string('extended'), create_automattic_woocommerce_admin_features_onboardingtasks_tasks_reviewshippingoptions(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_list(rt.new_string('extended'))))
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_list(rt.create_array([rt.ArrayItem{ key: 'id', val: 'secret_tasklist' }, rt.ArrayItem{ key: 'hidden_id', val: 'setup' }, rt.ArrayItem{ key: 'tasks', val: rt.create_array([rt.ArrayItem{ key: none, val: 'ExperimentalShippingRecommendation' }]) }, rt.ArrayItem{ key: 'event_prefix', val: 'secret_tasklist_' }, rt.ArrayItem{ key: 'visible', val: false }]))
	}
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_admin_experimental_onboarding_tasklists')])) {
		rt.set_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists', rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_experimental_onboarding_tasklists'), rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists')]))
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.init_tasks() {
	mut iter_1 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.default_tasks().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_task := item_1.val
		mut var_class := rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\OnboardingTasks\\Tasks\\' + (var_task).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_class.clone(), rt.new_string('init')]))))) {
			continue
		}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_{"nodeType":"Expr_Variable","line":207,"name":"class"}{}
	mut iife_result_2 := iife_temp_2.init()
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.set_active_task() {
	if !(rt.get_superglobal('_GET').array_isset(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.active_task_transient())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return
	}
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_referer)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_referer.clone(), rt.call_function('wc_admin_url', []rt.PhpVal{})]))))) {
		return
	}
	mut var_task_id := rt.call_function('sanitize_title_with_dashes', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.active_task_transient())])])
	mut var_task := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_task(var_task_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) {
		return
	}
	rt.call_method(var_task, 'set_active', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_list(var_args rt.PhpVal) rt.PhpVal {
	if rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').array_isset(var_args.array_get(rt.new_string('id'))) {
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error', []string{}, create_automattic_woocommerce_admin_features_onboardingtasks_wp_error(rt.new_string('woocommerce_task_list_exists'), rt.call_function('__', [rt.new_string('Task list ID already exists'), rt.new_string('woocommerce')])))
	}
	rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').array_set(var_args.array_get(rt.new_string('id')), create_automattic_woocommerce_admin_features_onboardingtasks_tasklist(var_args.clone()))
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').array_get(var_args.array_get(rt.new_string('id')))
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_task(var_list_id rt.PhpVal, var_task rt.PhpVal) rt.PhpVal {
	mut var_task_mutated := var_task
	if !(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').array_isset(var_list_id)) {
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error', []string{}, create_automattic_woocommerce_admin_features_onboardingtasks_wp_error(rt.new_string('woocommerce_task_list_invalid_list'), rt.call_function('__', [rt.new_string('Task list ID does not exist'), rt.new_string('woocommerce')])))
	}
	rt.call_method(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').array_get(var_list_id), 'add_task', [var_task_mutated.clone()])
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.maybe_add_extended_tasks(var_extended_tasks rt.PhpVal) {
	mut var_tasks := if !(var_extended_tasks).is_null() { var_extended_tasks } else { rt.new_array() }
	mut iter_2 := rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_task_list := item_2.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('extended'), rt.call_function('substr', [rt.get_property(var_task_list, 'id'), rt.new_int(0), rt.new_int(8)]))))) {
			continue
		}
		mut iter_3 := var_tasks.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_args := item_3.val
			mut var_task := create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(var_task_list.clone(), var_args.clone())
			rt.call_method(var_task_list, 'add_task', [var_task.clone()])
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_lists() rt.PhpVal {
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists')
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_lists_by_ids(var_ids rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn [var_ids] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task_list := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('in_array', [rt.call_method(var_task_list, 'get_list_id', []rt.PhpVal{}), var_ids.clone(), rt.new_bool(true)])
		}
	return rt.call_function('array_filter', [rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists'), rt.new_closure(closure_4_fn)])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_list_ids() rt.PhpVal {
	return rt.func_array_keys(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists'))
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.clear_lists() rt.PhpVal {
	rt.set_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists', rt.new_array())
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists')
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_visible() rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task_list := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_task_list, 'is_visible', []rt.PhpVal{})
		}
	return rt.call_function('array_filter', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_lists(), rt.new_closure(closure_5_fn)])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_list(var_id rt.PhpVal) rt.PhpVal {
	if rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').array_isset(var_id) {
		return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', 'lists').array_get(var_id)
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_task(var_id rt.PhpVal, var_task_list_id rt.PhpVal) rt.PhpVal {
	mut var_task_list := if rt.is_true(var_task_list_id) { Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_list(var_task_list_id.clone()) } else { rt.new_null() }
	if rt.is_true(var_task_list_id) && rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
		return rt.new_null()
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_all := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_curr := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.call_function('array_merge', [var_all.clone(), rt.get_property(var_curr, 'tasks')])
		}
	mut var_tasks_to_search := if rt.is_true(var_task_list) { rt.get_property(var_task_list, 'tasks') } else { rt.call_function('array_reduce', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_lists(), rt.new_closure(closure_6_fn), rt.new_array()]) }
	mut iter_4 := var_tasks_to_search.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_task := item_4.val
		if rt.is_true(rt.identical(var_id, rt.call_method(var_task, 'get_id', []rt.PhpVal{}))) {
			return var_task.clone()
		}
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.setup_tasks_remaining() i64 {
	mut var_setup_list := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_list(rt.new_string('setup'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_setup_list)))) || rt.is_true(rt.call_method(var_setup_list, 'is_hidden', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_setup_list, 'has_previously_completed', []rt.PhpVal{})) {
		return 0
	}
	mut var_viewable_tasks := rt.call_method(var_setup_list, 'get_viewable_tasks', []rt.PhpVal{})
	mut var_completed_tasks := rt.call_function('get_option', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.completed_option(), rt.new_array()])
	if !(var_completed_tasks.clone().is_array()) {
	var_completed_tasks = rt.new_array()
	}
	closure_7_fn := fn [var_completed_tasks] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return !(rt.is_true(rt.call_function('in_array', [rt.call_method(var_task, 'get_id', []rt.PhpVal{}), var_completed_tasks.clone(), rt.new_bool(true)])))
		}
	closure_8_fn := fn [var_completed_tasks] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return !(rt.is_true(rt.call_function('in_array', [rt.call_method(var_task, 'get_id', []rt.PhpVal{}), var_completed_tasks.clone(), rt.new_bool(true)])))
		}
	return rt.call_function('array_filter', [var_viewable_tasks.clone(), rt.new_closure(closure_7_fn)]).array_count()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.menu_task_count() {
	mut var_submenu := rt.new_null()
	mut var_tasks_count := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.setup_tasks_remaining()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tasks_count)))) || !(var_submenu.array_isset(rt.new_string('woocommerce'))) {
		return
	}
	mut iter_5 := var_submenu.array_get(rt.new_string('woocommerce')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_menu_item := item_5.val
		mut var_key := item_5.key
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_menu_item.array_get(rt.new_int(0)), rt.call_function('_x', [rt.new_string('Home'), rt.new_string('Admin menu name'), rt.new_string('woocommerce')])]))) {
			var_submenu.array_get(rt.new_string('woocommerce')).array_get(var_key).array_get(rt.new_int(0)) = rt.concat(var_submenu.array_get(rt.new_string('woocommerce')).array_get(var_key).array_get(rt.new_int(0)), rt.new_string(' <span class="menu-counter remaining-tasks-badge woocommerce-task-list-remaining-tasks-badge"><span class="count-' + (rt.call_function('esc_attr', [var_tasks_count.clone()])).str() + '">' + (rt.call_function('absint', [var_tasks_count.clone()])).str() + '</span></span>'))
			break
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.task_list_preloaded_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	var_settings_mutated.array_set('visibleTaskListIds', if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.all_hidden()) { rt.new_array() } else { rt.func_array_keys(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_visible()) })
	var_settings_mutated.array_set('completedTaskListIds', rt.call_function('get_option', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.completed_option(), rt.new_array()]))
	return var_settings_mutated.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.all_hidden() bool {
	mut var_hidden_lists := rt.call_function('get_option', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList.hidden_option(), rt.new_array()])
	return rt.new_bool(var_hidden_lists.clone().array_count() == Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_lists().array_count())
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WooCommerce_Admin_Experimental_Abtest {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ReviewShippingOptions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_{"nodeType":"Expr_Variable","line":207,"name":"class"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_static {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_woocommerce_admin_experimental_abtest(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WooCommerce_Admin_Experimental_Abtest {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WooCommerce_Admin_Experimental_Abtest{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_reviewshippingoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ReviewShippingOptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ReviewShippingOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_{"nodetype":"expr_variable","line":207,"name":"class"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_{"nodeType":"Expr_Variable","line":207,"name":"class"} {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_{"nodeType":"Expr_Variable","line":207,"name":"class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.instance()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.init()
			return rt.new_null()
		}
		'is_experiment_treatment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.is_experiment_treatment(dispatch_arg_0)
		}
		'init_default_lists' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.init_default_lists()
			return rt.new_null()
		}
		'init_tasks' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.init_tasks()
			return rt.new_null()
		}
		'set_active_task' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.set_active_task()
			return rt.new_null()
		}
		'add_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_list(dispatch_arg_0)
		}
		'add_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.add_task(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_add_extended_tasks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.maybe_add_extended_tasks(dispatch_arg_0)
			return rt.new_null()
		}
		'get_lists' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_lists()
		}
		'get_lists_by_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_lists_by_ids(dispatch_arg_0)
		}
		'get_list_ids' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_list_ids()
		}
		'clear_lists' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.clear_lists()
		}
		'get_visible' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_visible()
		}
		'get_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_list(dispatch_arg_0)
		}
		'get_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.get_task(dispatch_arg_0, dispatch_arg_1)
		}
		'setup_tasks_remaining' {
			return rt.new_int(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.setup_tasks_remaining())
		}
		'menu_task_count' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.menu_task_count()
			return rt.new_null()
		}
		'task_list_preloaded_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.task_list_preloaded_settings(dispatch_arg_0)
		}
		'all_hidden' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists.all_hidden())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WooCommerce_Admin_Experimental_Abtest) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WooCommerce_Admin_Experimental_Abtest) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WooCommerce_Admin_Experimental_Abtest) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ReviewShippingOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ReviewShippingOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ReviewShippingOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_{"nodeType":"Expr_Variable","line":207,"name":"class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_{"nodeType":"Expr_Variable","line":207,"name":"class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_{"nodeType":"Expr_Variable","line":207,"name":"class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
