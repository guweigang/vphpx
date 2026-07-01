import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) construct() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_complete())))) {
		rt.call_function('add_action', [rt.new_string('load-theme-install.php'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance', [
					'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task',
				], &this) },
				rt.ArrayItem{ key: none, val: 'mark_actioned' },
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) get_id() string {
	return 'appearance'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Choose your theme'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) get_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string("Choose a theme that best fits your brand's look and feel, then make it your own. Change the colors, add your logo, and create pages."),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('2 minutes'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) get_action_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Choose theme'),
		rt.new_string('woocommerce')])
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_appearance() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_content' {
			return this.get_content()
		}
		'get_time' {
			return this.get_time()
		}
		'get_action_label' {
			return this.get_action_label()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Appearance) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_appearance_php() {
}
