import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.tax_rate_exists_cache_key() string {
	return 'woocommerce_onboarding_task_tax_rates_exist'
}
struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax {
	rt.PhpObjectBase
pub mut:
		is_complete_result bool
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) construct(var_task_list rt.PhpVal)  {
	this.Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.construct(var_task_list.dup())
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_return_notice_script' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_tax_rate_added'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'on_tax_rate_added' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_tax_rate_deleted'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'on_tax_rate_deleted' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) possibly_add_return_notice_script()  {
	mut var_page := if rt.get_superglobal('_GET').array_isset(rt.new_string('page')) { rt.get_superglobal('_GET').array_get('page') } else { rt.new_string('') }
	mut var_tab := if rt.get_superglobal('_GET').array_isset(rt.new_string('tab')) { rt.get_superglobal('_GET').array_get('tab') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.is_active())))) || this.is_complete())) {
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('onboarding-tax-notice'), rt.new_bool(true))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) get_id() string {
	return 'tax'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Collect sales tax'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) get_content() rt.PhpVal {
	return if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.can_use_automated_taxes()) { rt.call_function('__', [rt.new_string('Good news! WooCommerce Tax can automate your sales tax calculations for you.'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Set your store location and configure tax rate settings.'), rt.new_string('woocommerce')]) }
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('1 minute'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) get_action_label() rt.PhpVal {
	return if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.can_use_automated_taxes()) { rt.call_function('__', [rt.new_string('Yes please'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Let\'s go'), rt.new_string('woocommerce')]) }
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) is_complete() bool {
	if rt.is_true(rt.identical(this.is_complete_result, rt.new_null())) {
		mut var_wc_connect_taxes_enabled := rt.call_function('get_option', [rt.new_string('wc_connect_taxes_enabled')])
		mut var_is_wc_connect_taxes_enabled := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(var_wc_connect_taxes_enabled, rt.new_string('yes'))) || rt.is_true(rt.identical(var_wc_connect_taxes_enabled, rt.new_bool(true)))))
		mut var_third_party_complete := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_third_party_tax_setup_complete'), rt.new_bool(false)])
		this.is_complete_result = rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_wc_connect_taxes_enabled) || rt.is_true(var_third_party_complete))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(this.has_existing_tax_rates())
	}
	return this.is_complete_result
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) has_existing_tax_rates() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_has_existing_tax_rates := rt.call_function('wp_cache_get', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.tax_rate_exists_cache_key()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_has_existing_tax_rates)) {
		mut var_rate_exists := // unsupported expression: Expr_Cast_Bool
		var_has_existing_tax_rates = rt.new_string(if rt.is_true(var_rate_exists) { rt.new_string('yes') } else { rt.new_string('no') })
		rt.call_function('wp_cache_set', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.tax_rate_exists_cache_key(), var_has_existing_tax_rates.dup()])
	}
	return rt.identical(rt.new_string('yes'), var_has_existing_tax_rates)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) on_tax_rate_added()  {
	this.mark_actioned()
	rt.call_function('wp_cache_set', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.tax_rate_exists_cache_key(), rt.new_string('yes')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) on_tax_rate_deleted()  {
	rt.call_function('wp_cache_delete', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.tax_rate_exists_cache_key()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) get_additional_data() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'avalara_activated', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_active(arg_0) }(rt.new_string('woocommerce-avatax')) }, rt.ArrayItem{ key: 'tax_jar_activated', val: rt.call_function('class_exists', [rt.new_string('WC_Taxjar')]) }, rt.ArrayItem{ key: 'stripe_tax_activated', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_active(arg_0) }(rt.new_string('stripe-tax-for-woocommerce')) }, rt.ArrayItem{ key: 'woocommerce_tax_activated', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_active(arg_0) }(rt.new_string('woocommerce-tax')) }, rt.ArrayItem{ key: 'woocommerce_shipping_activated', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_active(arg_0) }(rt.new_string('woocommerce-shipping')) }, rt.ArrayItem{ key: 'woocommerce_tax_countries', val: Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.get_automated_support_countries() }, rt.ArrayItem{ key: 'stripe_tax_countries', val: Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.get_stripe_tax_support_countries() }])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.can_use_automated_taxes() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Taxjar')]))))) {
		return false
	}
	return (rt.call_function('in_array', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}), Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.get_automated_support_countries(), rt.new_bool(true)])).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.get_automated_support_countries() rt.PhpVal {
	mut var_tax_supported_countries := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'US' }, rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'AU' }, rt.ArrayItem{ key: none, val: 'GB' }]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_european_union_countries', []rt.PhpVal{})])
	return var_tax_supported_countries.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.get_stripe_tax_support_countries() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'AU' }, rt.ArrayItem{ key: none, val: 'AT' }, rt.ArrayItem{ key: none, val: 'BE' }, rt.ArrayItem{ key: none, val: 'BG' }, rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'HR' }, rt.ArrayItem{ key: none, val: 'CY' }, rt.ArrayItem{ key: none, val: 'CZ' }, rt.ArrayItem{ key: none, val: 'DK' }, rt.ArrayItem{ key: none, val: 'EE' }, rt.ArrayItem{ key: none, val: 'FI' }, rt.ArrayItem{ key: none, val: 'FR' }, rt.ArrayItem{ key: none, val: 'DE' }, rt.ArrayItem{ key: none, val: 'GR' }, rt.ArrayItem{ key: none, val: 'HK' }, rt.ArrayItem{ key: none, val: 'HU' }, rt.ArrayItem{ key: none, val: 'IE' }, rt.ArrayItem{ key: none, val: 'IT' }, rt.ArrayItem{ key: none, val: 'JP' }, rt.ArrayItem{ key: none, val: 'LV' }, rt.ArrayItem{ key: none, val: 'LT' }, rt.ArrayItem{ key: none, val: 'LU' }, rt.ArrayItem{ key: none, val: 'MT' }, rt.ArrayItem{ key: none, val: 'NL' }, rt.ArrayItem{ key: none, val: 'NZ' }, rt.ArrayItem{ key: none, val: 'NO' }, rt.ArrayItem{ key: none, val: 'PL' }, rt.ArrayItem{ key: none, val: 'PT' }, rt.ArrayItem{ key: none, val: 'RO' }, rt.ArrayItem{ key: none, val: 'SG' }, rt.ArrayItem{ key: none, val: 'SK' }, rt.ArrayItem{ key: none, val: 'SI' }, rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'SE' }, rt.ArrayItem{ key: none, val: 'CH' }, rt.ArrayItem{ key: none, val: 'AE' }, rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'US' }])
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_tax(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
		is_complete_result: false
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

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'possibly_add_return_notice_script' {
			this.possibly_add_return_notice_script()
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
		'is_complete' {
			return rt.new_bool(this.is_complete())
		}
		'has_existing_tax_rates' {
			return this.has_existing_tax_rates()
		}
		'on_tax_rate_added' {
			this.on_tax_rate_added()
			return rt.new_null()
		}
		'on_tax_rate_deleted' {
			this.on_tax_rate_deleted()
			return rt.new_null()
		}
		'get_additional_data' {
			return this.get_additional_data()
		}
		'can_use_automated_taxes' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.can_use_automated_taxes())
		}
		'get_automated_support_countries' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.get_automated_support_countries()
		}
		'get_stripe_tax_support_countries' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax.get_stripe_tax_support_countries()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_complete_result' { return rt.new_bool(this.is_complete_result) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_complete_result' { this.is_complete_result = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_tax_php() {
}
