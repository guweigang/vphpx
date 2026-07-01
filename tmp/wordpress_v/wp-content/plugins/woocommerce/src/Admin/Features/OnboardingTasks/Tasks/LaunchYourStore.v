import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) construct(var_task_list rt.PhpVal)  {
	this.Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.construct(var_task_list.dup())
	rt.call_function('add_action', [rt.new_string('show_admin_bar'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'possibly_hide_wp_admin_bar' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) get_id() string {
	return 'launch-your-store'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Launch your store'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) get_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('It\'s time to celebrate – you\'re ready to launch your store! Woo! Hit the button to preview your store and make it public.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) get_time() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) get_action_url() rt.PhpVal {
	return rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=%2Flaunch-your-store')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) is_complete() rt.PhpVal {
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) can_view() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('launch-your-store'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) possibly_hide_wp_admin_bar(var_show rt.PhpVal) bool {
	mut var_wp := rt.new_null()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('site-preview')) {
		return false
	}
	// unsupported statement: Stmt_Global
	mut var_http_referer := if !(rt.call_function('wp_get_referer', []rt.PhpVal{})).is_null() { rt.call_function('wp_get_referer', []rt.PhpVal{}) } else { rt.new_string('') }
	mut var_parsed_url := rt.call_function('wp_parse_url', [var_http_referer.dup(), rt.get_constant('PHP_URL_QUERY')])
	mut var_query_string := if rt.is_true(rt.new_bool(var_parsed_url.dup().is_string())) { var_parsed_url } else { rt.new_string('') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI'))) {
			return (var_show).to_bool()
		}
		mut var_current_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'site-preview', val: 1 }]), rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])])
		rt.call_function('wp_safe_redirect', [var_current_url.dup()])
		// unsupported expression: Expr_Exit
	}
	return (var_show).to_bool()
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_launchyourstore(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
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
			return rt.new_string(this.get_time())
		}
		'get_action_url' {
			return this.get_action_url()
		}
		'is_complete' {
			return this.is_complete()
		}
		'can_view' {
			return this.can_view()
		}
		'possibly_hide_wp_admin_bar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.possibly_hide_wp_admin_bar(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_LaunchYourStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_launchyourstore_php() {
}
