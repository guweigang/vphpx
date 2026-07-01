import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) init()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_help_tab' }]), rt.new_int(60)])
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'reset_task_list' }])])
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'reset_extended_task_list' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) add_help_tab()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_screen_ids')]))))) {
		return rt.new_null()
	}
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_screen)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_screen, 'id'), rt.call_function('wc_get_screen_ids', []rt.PhpVal{}), rt.new_bool(true)]))))))) {
		return rt.new_null()
	}
	mut var_help_tabs := rt.call_method(var_screen, 'get_help_tabs', []rt.PhpVal{})
	{
		mut iter_1 := var_help_tabs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_help_tab := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			rt.call_method(var_screen, 'remove_help_tab', [rt.new_string('woocommerce_onboard_tab')])
		}
	}
	mut var_help_tab := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Setup wizard'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_onboard_tab' }])
	mut var_setup_list := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.get_list(arg_0) }(rt.new_string('setup'))
	mut var_extended_list := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.get_list(arg_0) }(rt.new_string('extended'))
	if rt.is_true(var_setup_list) {
		var_help_tab.array_set('content', '<h2>' + (rt.call_function('__', [rt.new_string('WooCommerce Onboarding'), rt.new_string('woocommerce')])).str() + '</h2>')
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_setup_list, 'is_complete', []rt.PhpVal{}))))) {
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(var_extended_list) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_method(var_screen, 'add_help_tab', [var_help_tab.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) reset_task_list()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('reset_task_list'))))) {
		return rt.new_null()
	}
	mut var_task_list := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.get_list(arg_0) }(rt.new_string('setup'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
		return rt.new_null()
	}
	mut var_show := rt.identical(rt.new_int(1), rt.call_function('absint', [rt.get_superglobal('_GET').array_get('reset_task_list')]))
	mut var_update := if rt.is_true(var_show) { rt.call_method(var_task_list, 'unhide', []rt.PhpVal{}) } else { rt.call_method(var_task_list, 'hide', []rt.PhpVal{}) }
	if rt.is_true(var_update) {
		rt.call_function('wc_admin_record_tracks_event', [rt.new_string('tasklist_toggled'), rt.create_array([rt.ArrayItem{ key: 'status', val: if rt.is_true(var_show) { 'enabled' } else { 'disabled' } }])])
	}
	rt.call_function('wp_safe_redirect', [rt.call_function('wc_admin_url', []rt.PhpVal{})])
	// unsupported expression: Expr_Exit
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) reset_extended_task_list()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('reset_extended_task_list'))))) {
		return rt.new_null()
	}
	mut var_task_list := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.get_list(arg_0) }(rt.new_string('extended'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
		return rt.new_null()
	}
	mut var_show := rt.identical(rt.new_int(1), rt.call_function('absint', [rt.get_superglobal('_GET').array_get('reset_extended_task_list')]))
	mut var_update := if rt.is_true(var_show) { rt.call_method(var_task_list, 'unhide', []rt.PhpVal{}) } else { rt.call_method(var_task_list, 'hide', []rt.PhpVal{}) }
	if rt.is_true(var_update) {
		rt.call_function('wc_admin_record_tracks_event', [rt.new_string('extended_tasklist_toggled'), rt.create_array([rt.ArrayItem{ key: 'status', val: if rt.is_true(var_show) { 'disabled' } else { 'enabled' } }])])
	}
	rt.call_function('wp_safe_redirect', [rt.call_function('wc_admin_url', []rt.PhpVal{})])
	// unsupported expression: Expr_Exit
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardinghelper() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_onboarding_onboardinghelper_php() {
}
