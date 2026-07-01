import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) init()  {
	rt.call_function('add_action', ['update_option_' + (Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option()).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'send_profile_data_on_update' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_connected'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'send_profile_data_on_connect' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'redirect_wccom_install' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) send_profile_data() bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Helper_API')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [rt.new_string('\\WC_Helper_API'), rt.new_string('put')]))))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Helper_Options')]))))) {
		return false
	}
	mut var_auth := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('auth'))
	if !rt.is_true(var_auth.array_get('access_token')) || !rt.is_true(var_auth.array_get('access_token_secret')) {
		return false
	}
	mut var_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'plugins', val: 'skipped' }, rt.ArrayItem{ key: 'industry', val: rt.new_array() }, rt.ArrayItem{ key: 'product_types', val: rt.new_array() }, rt.ArrayItem{ key: 'product_count', val: '0' }, rt.ArrayItem{ key: 'selling_venues', val: 'no' }, rt.ArrayItem{ key: 'number_employees', val: '1' }, rt.ArrayItem{ key: 'revenue', val: 'none' }, rt.ArrayItem{ key: 'other_platform', val: 'none' }, rt.ArrayItem{ key: 'business_extensions', val: rt.new_array() }, rt.ArrayItem{ key: 'theme', val: rt.call_function('get_stylesheet', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'setup_client', val: false }, rt.ArrayItem{ key: 'store_location', val: var_base_location.array_get('country') }, rt.ArrayItem{ key: 'default_currency', val: rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }])
	if rt.is_true(rt.new_bool(var_profile.array_isset(rt.new_string('industry')) && rt.is_true(rt.new_bool(var_profile.array_get('industry').is_array())))) {
		mut var_industry_slugs := rt.new_array()
		{
			mut iter_1 := var_profile.array_get('industry').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_industry := item_1.val
				var_industry_slugs.array_push(if rt.is_true(rt.new_bool(var_industry.dup().is_array())) { var_industry.array_get('slug') } else { var_industry })
			}
		}
		var_profile.array_set('industry', var_industry_slugs.dup())
	}
	mut var_body := rt.call_function('wp_parse_args', [var_profile.dup(), var_defaults.dup()])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_API{}; return temp.put(arg_0, arg_1) }(rt.new_string('profile'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [var_body.dup()]) }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }]) }]))
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) send_profile_data_on_update(var_old_value rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(var_value.array_isset(rt.new_string('completed'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_value.array_get('completed'))))))) {
		return rt.new_null()
	}
	this.send_profile_data()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) send_profile_data_on_connect()  {
	mut var_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	if rt.is_true(rt.new_bool(!(var_profile.array_isset(rt.new_string('completed'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_profile.array_get('completed'))))))) {
		return rt.new_null()
	}
	this.send_profile_data()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) redirect_wccom_install()  {
	mut var_task_list := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.get_list(arg_0) }(rt.new_string('setup'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) || rt.is_true(rt.call_method(var_task_list, 'is_hidden', []rt.PhpVal{})))) || !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_REFERER'))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	rt.call_function('wp_safe_redirect', [rt.call_function('wc_admin_url', []rt.PhpVal{})])
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_API {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingsync() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_wc_helper_options() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_wc_helper_api() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_API {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'send_profile_data' {
			return rt.new_bool(this.send_profile_data())
		}
		'send_profile_data_on_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.send_profile_data_on_update(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'send_profile_data_on_connect' {
			this.send_profile_data_on_connect()
			return rt.new_null()
		}
		'redirect_wccom_install' {
			this.redirect_wccom_install()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_onboarding_onboardingsync_php() {
}
