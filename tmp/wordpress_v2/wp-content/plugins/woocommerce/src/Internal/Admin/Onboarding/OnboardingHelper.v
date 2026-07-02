import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_onboarding_onboardinghelper() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_static',
			[]string{}, create_automattic_woocommerce_internal_admin_onboarding_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_help_tab' },
		]),
		rt.new_int(60)])
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'reset_task_list' },
		])])
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'reset_extended_task_list' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) add_help_tab() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_get_screen_ids'),
	])))))
	{
		return
	}
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_screen, 'id'), rt.call_function('wc_get_screen_ids', []rt.PhpVal{}), rt.new_bool(true)]))))) {
		return
	}
	mut var_help_tabs := rt.call_method(var_screen, 'get_help_tabs', []rt.PhpVal{})
	mut iter_1 := var_help_tabs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_help_tab := item_1.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_onboard_tab'),
			var_help_tab.array_get(rt.new_string('id'))))))
		{
			continue
		}
		rt.call_method(var_screen, 'remove_help_tab', [
			rt.new_string('woocommerce_onboard_tab'),
		])
	}
	mut var_help_tab := rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Setup wizard'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'id', val: 'woocommerce_onboard_tab' },
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_0 := iife_temp_0.get_list(rt.new_string('setup'))
	mut var_setup_list := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_1 := iife_temp_1.get_list(rt.new_string('extended'))
	mut var_extended_list := iife_result_1
	if rt.is_true(var_setup_list) {
		var_help_tab.array_set('content', '<h2>' +
			(rt.call_function('__', [rt.new_string('WooCommerce Onboarding'), rt.new_string('woocommerce')])).str() +
			'</h2>')
		var_help_tab.array_get(rt.new_string('content')) = rt.concat(var_help_tab.array_get(rt.new_string('content')), rt.new_string(
			'<h3>' +
			(rt.call_function('__', [rt.new_string('Profile Setup Wizard'), rt.new_string('woocommerce')])).str() +
			'</h3>'))
		var_help_tab.array_get(rt.new_string('content')) = rt.concat(var_help_tab.array_get(rt.new_string('content')), rt.new_string(
			'<p>' +
			(rt.call_function('__', [rt.new_string('If you need to access the setup wizard again, please click on the button below.'), rt.new_string('woocommerce')])).str() +
			'</p>' + '<p><a href="' +
			(rt.call_function('wc_admin_url', [rt.new_string('&path=/setup-wizard')])).str() +
			'" class="button button-primary">' +
			(rt.call_function('__', [rt.new_string('Setup wizard'), rt.new_string('woocommerce')])).str() +
			'</a></p>'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_setup_list, 'is_complete',
			[]rt.PhpVal{})))))
		{
			var_help_tab.array_get(rt.new_string('content')) = rt.concat(var_help_tab.array_get(rt.new_string('content')), rt.new_string(
				'<h3>' +
				(rt.call_function('__', [rt.new_string('Task List'), rt.new_string('woocommerce')])).str() +
				'</h3>'))
			var_help_tab.array_get(rt.new_string('content')) = rt.concat(var_help_tab.array_get(rt.new_string('content')), rt.new_string(
				'<p>' +
				(rt.call_function('__', [rt.new_string('If you need to enable or disable the task lists, please click on the button below.'), rt.new_string('woocommerce')])).str() +
				'</p>' +
				if rt.is_true(rt.call_method(var_setup_list, 'is_hidden', []rt.PhpVal{})) { '<p><a href="' +
				(rt.call_function('wc_admin_url', [rt.new_string('&reset_task_list=1')])).str() +
				'" class="button button-primary">' +
				(rt.call_function('__', [rt.new_string('Enable'), rt.new_string('woocommerce')])).str() +
				'</a></p>' } else { '<p><a href="' +
				(rt.call_function('wc_admin_url', [rt.new_string('&reset_task_list=0')])).str() +
				'" class="button button-primary">' +
				(rt.call_function('__', [rt.new_string('Disable'), rt.new_string('woocommerce')])).str() +
				'</a></p>' }))
		}
	}
	if rt.is_true(var_extended_list) {
		var_help_tab.array_get(rt.new_string('content')) = rt.concat(var_help_tab.array_get(rt.new_string('content')), rt.new_string(
			'<h3>' +
			(rt.call_function('__', [rt.new_string('Extended task List'), rt.new_string('woocommerce')])).str() +
			'</h3>'))
		var_help_tab.array_get(rt.new_string('content')) = rt.concat(var_help_tab.array_get(rt.new_string('content')), rt.new_string(
			'<p>' +
			(rt.call_function('__', [rt.new_string('If you need to enable or disable the extended task lists, please click on the button below.'), rt.new_string('woocommerce')])).str() +
			'</p>' +
			if rt.is_true(rt.call_method(var_extended_list, 'is_hidden', []rt.PhpVal{})) { '<p><a href="' +
			(rt.call_function('wc_admin_url', [rt.new_string('&reset_extended_task_list=1')])).str() +
			'" class="button button-primary">' +
			(rt.call_function('__', [rt.new_string('Enable'), rt.new_string('woocommerce')])).str() +
			'</a></p>' } else { '<p><a href="' +
			(rt.call_function('wc_admin_url', [rt.new_string('&reset_extended_task_list=0')])).str() +
			'" class="button button-primary">' +
			(rt.call_function('__', [rt.new_string('Disable'), rt.new_string('woocommerce')])).str() +
			'</a></p>' }))
	}
	rt.call_method(var_screen, 'add_help_tab', [var_help_tab.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) reset_task_list() {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_2 := iife_temp_2.is_admin_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('reset_task_list'))) {
		return
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_3 := iife_temp_3.get_list(rt.new_string('setup'))
	mut var_task_list := iife_result_3
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
		return
	}
	mut var_show := rt.identical(rt.new_int(1), rt.call_function('absint', [
		rt.get_superglobal('_GET').array_get(rt.new_string('reset_task_list')),
	]))
	mut var_update := if rt.is_true(var_show) {
		rt.call_method(var_task_list, 'unhide', []rt.PhpVal{})
	} else {
		rt.call_method(var_task_list, 'hide', []rt.PhpVal{})
	}
	if rt.is_true(var_update) {
		rt.call_function('wc_admin_record_tracks_event', [
			rt.new_string('tasklist_toggled'),
			rt.create_array([
				rt.ArrayItem{
					key: 'status'
					val: if rt.is_true(var_show) { 'enabled' } else { 'disabled' }
				},
			]),
		])
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('wc_admin_url', []rt.PhpVal{}),
	])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) reset_extended_task_list() {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_4 := iife_temp_4.is_admin_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('reset_extended_task_list'))) {
		return
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_5 := iife_temp_5.get_list(rt.new_string('extended'))
	mut var_task_list := iife_result_5
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
		return
	}
	mut var_show := rt.identical(rt.new_int(1), rt.call_function('absint', [
		rt.get_superglobal('_GET').array_get(rt.new_string('reset_extended_task_list')),
	]))
	mut var_update := if rt.is_true(var_show) {
		rt.call_method(var_task_list, 'unhide', []rt.PhpVal{})
	} else {
		rt.call_method(var_task_list, 'hide', []rt.PhpVal{})
	}
	if rt.is_true(var_update) {
		rt.call_function('wc_admin_record_tracks_event', [
			rt.new_string('extended_tasklist_toggled'),
			rt.create_array([
				rt.ArrayItem{
					key: 'status'
					val: if rt.is_true(var_show) { 'disabled' } else { 'enabled' }
				},
			]),
		])
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('wc_admin_url', []rt.PhpVal{}),
	])
	exit(0)
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardinghelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_help_tab' {
			this.add_help_tab()
			return rt.new_null()
		}
		'reset_task_list' {
			this.reset_task_list()
			return rt.new_null()
		}
		'reset_extended_task_list' {
			this.reset_extended_task_list()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
