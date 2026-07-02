import rt

struct Class_WC_Admin_Dashboard_Setup {
	rt.PhpObjectBase
pub mut:
			initalized bool
			task_list rt.PhpVal = rt.new_null()
			tasks rt.PhpVal = rt.new_null()
			completed_tasks_count rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WC_Admin_Dashboard_Setup) construct() {
	if this.should_display_widget() {
		rt.call_function('add_meta_box', [rt.new_string('wc_admin_dashboard_setup'), rt.call_function('__', [rt.new_string('WooCommerce Setup'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard_Setup', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render' }]), rt.new_string('dashboard'), rt.new_string('normal'), rt.new_string('high')])
	}
}

fn (mut this Class_WC_Admin_Dashboard_Setup) render() {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_0
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-dashboard-setup'), rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/dashboard-setup.css'), rt.new_array(), var_version.clone()])
	mut var_task := this.get_next_task()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) {
		return
	}
	mut var_button_link := this.get_button_link(var_task.clone())
	mut var_completed_tasks_count := rt.new_int(this.get_completed_tasks_count())
	mut var_step_number := rt.new_int(this.get_completed_tasks_count() + 1)
	mut var_tasks_count := rt.new_int(this.get_tasks().array_count())
	mut var_progress_percentage := rt.mul(rt.div(var_completed_tasks_count, var_tasks_count), rt.new_int(100))
	mut var_circle_r := rt.new_float(6.5)
	mut var_circle_dashoffset := rt.mul(rt.div(rt.sub(rt.new_int(100), var_progress_percentage), rt.new_int(100)), rt.mul(rt.call_function('pi', []rt.PhpVal{}), rt.mul(var_circle_r, rt.new_int(2))))
	rt.include_file(@DIR + '/views/html-admin-dashboard-setup.php', '1')
}

fn (mut this Class_WC_Admin_Dashboard_Setup) get_button_link(var_task rt.PhpVal) rt.PhpVal {
	mut var_task_mutated := var_task
	if rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.class()])) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{}
		mut iife_result_1 := iife_temp_1.needs_completion()
		if rt.is_true(iife_result_1) {
			return rt.call_function('wc_admin_url', [rt.new_string('&path=/setup-wizard')])
		}
	}
	mut var_url := rt.new_string((rt.call_method(var_task_mutated, 'get_json', []rt.PhpVal{}).array_get(rt.new_string('actionUrl'))).str())
	if rt.is_true(rt.identical(rt.call_function('substr', [var_url.clone(), rt.new_int(0), rt.new_int(4)]), rt.new_string('http'))) {
		return var_url.clone()
	} else if rt.is_true(var_url) {
		return rt.call_function('wc_admin_url', [rt.new_string('&path=' + (var_url).str())])
	}
	return rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&task=' + (rt.call_method(var_task_mutated, 'get_id', []rt.PhpVal{})).str())])
}

fn (mut this Class_WC_Admin_Dashboard_Setup) get_task_list() rt.PhpVal {
	if rt.is_true(this.task_list) || this.initalized {
		return this.task_list
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_2 := iife_temp_2.get_list(rt.new_string('setup'))
	this.set_task_list(iife_result_2)
	this.initalized = true
	return this.task_list
}

fn (mut this Class_WC_Admin_Dashboard_Setup) set_task_list(var_task_list rt.PhpVal) rt.PhpVal {
	return this.task_list = var_task_list.clone()
}

fn (mut this Class_WC_Admin_Dashboard_Setup) get_tasks() rt.PhpVal {
	if rt.is_true(this.tasks) {
		return this.tasks
	}
	this.tasks = rt.call_method(this.get_task_list(), 'get_viewable_tasks', []rt.PhpVal{})
	return this.tasks
}

fn (mut this Class_WC_Admin_Dashboard_Setup) get_completed_tasks_count() i64 {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (rt.call_method(var_task, 'is_complete', []rt.PhpVal{})).to_i64()
		}
	mut var_completed_tasks := rt.call_function('array_filter', [this.get_tasks(), rt.new_closure(closure_4_fn)])
	return var_completed_tasks.clone().array_count()
}

fn (mut this Class_WC_Admin_Dashboard_Setup) get_next_task() rt.PhpVal {
	mut iter_1 := this.get_tasks().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_task := item_1.val
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_task, 'is_complete', []rt.PhpVal{}))) {
			return var_task.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_WC_Admin_Dashboard_Setup) should_display_widget() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\Features')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\OnboardingTasks\\TaskLists')]))))) {
		return false
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_4 := iife_temp_4.is_enabled(rt.new_string('onboarding'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{}))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_task_list())))) || rt.is_true(rt.call_method(this.get_task_list(), 'is_hidden', []rt.PhpVal{})) || rt.is_true(rt.call_method(this.get_task_list(), 'is_complete', []rt.PhpVal{})) {
		return false
	}
	return true
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_wc_admin_dashboard_setup() &Class_WC_Admin_Dashboard_Setup {
	mut obj := &Class_WC_Admin_Dashboard_Setup{
		PhpObjectBase: rt.PhpObjectBase{}
		initalized: false
		task_list: rt.new_null()
		tasks: rt.new_null()
		completed_tasks_count: rt.new_int(0)
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingprofile(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{
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

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Dashboard_Setup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		'get_button_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_button_link(dispatch_arg_0)
		}
		'get_task_list' {
			return this.get_task_list()
		}
		'set_task_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_task_list(dispatch_arg_0)
		}
		'get_tasks' {
			return this.get_tasks()
		}
		'get_completed_tasks_count' {
			return rt.new_int(this.get_completed_tasks_count())
		}
		'get_next_task' {
			return this.get_next_task()
		}
		'should_display_widget' {
			return rt.new_bool(this.should_display_widget())
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Dashboard_Setup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'initalized' { return rt.new_bool(this.initalized) }
		'task_list' { return this.task_list }
		'tasks' { return this.tasks }
		'completed_tasks_count' { return this.completed_tasks_count }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Dashboard_Setup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'initalized' { this.initalized = (val).to_bool(); return true }
		'task_list' { this.task_list = val; return true }
		'tasks' { this.tasks = val; return true }
		'completed_tasks_count' { this.completed_tasks_count = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Dashboard_Setup'), rt.new_bool(false)]))))) {
	}
	return rt.new_object('WC_Admin_Dashboard_Setup', []string{}, create_wc_admin_dashboard_setup())
}
