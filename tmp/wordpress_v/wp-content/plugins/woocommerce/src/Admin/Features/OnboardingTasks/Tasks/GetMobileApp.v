import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) get_id() string {
	return 'get-mobile-app'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Get the free WooCommerce mobile app'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) get_content() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) get_time() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) is_complete() rt.PhpVal {
	return rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_admin_dismissed_mobile_app_modal'),
	]), rt.new_string('yes'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) can_view() bool {
	mut var_jetpack_can_be_installed := rt.new_bool(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp.is_jetpack_connected()))))))
	mut var_jetpack_is_installed_and_current_user_connected :=
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp.is_current_user_connected()
	return rt.is_true(var_jetpack_can_be_installed)
		|| rt.is_true(var_jetpack_is_installed_and_current_user_connected)
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp.is_jetpack_connected() bool {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\Jetpack\\Connection\\Manager')]))
		&& rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Automattic\\Jetpack\\Connection\\Manager'), rt.new_string('is_active')]))))
	{
		mut var_connection := create_automattic_jetpack_connection_manager()
		return (var_connection.is_active()).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp.is_current_user_connected() bool {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\Jetpack\\Connection\\Manager')]))
		&& rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Automattic\\Jetpack\\Connection\\Manager'), rt.new_string('is_user_connected')]))))
	{
		mut var_connection := create_automattic_jetpack_connection_manager()
		return (var_connection.is_connection_owner()).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) get_action_url() rt.PhpVal {
	return rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-admin&mobileAppModal=true'),
	])
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Manager {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_getmobileapp() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_manager() &Class_Automattic_Jetpack_Connection_Manager {
	mut obj := &Class_Automattic_Jetpack_Connection_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'get_time' {
			return rt.new_string(this.get_time())
		}
		'is_complete' {
			return this.is_complete()
		}
		'can_view' {
			return rt.new_bool(this.can_view())
		}
		'is_jetpack_connected' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp.is_jetpack_connected())
		}
		'is_current_user_connected' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp.is_current_user_connected())
		}
		'get_action_url' {
			return this.get_action_url()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_GetMobileApp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_getmobileapp_php() {
}
