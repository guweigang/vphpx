import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage.incentive_type() string {
	return 'welcome_page'
}

struct Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage {
	rt.PhpObjectBase
pub mut:
	suggestion_incentives rt.PhpVal = rt.new_null()
}

fn init_static_automattic_woocommerce_internal_admin_wcpaywelcomepage() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage', 'instance',
		rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage.instance() rt.PhpVal {
	rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage', 'instance', if rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage',
		'instance').is_null()
	{
		create_automattic_woocommerce_internal_admin_self()
	} else {
		rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage', 'instance')
	})
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) construct() {
	this.suggestion_incentives = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives.class(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) has_incentive(skip_wcpay_active bool) bool {
	if !var_skip_wcpay_active && this.is_wcpay_active() {
		return false
	}
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_show_marketplace_suggestions'),
		rt.new_string('yes'),
	]), rt.new_string('no')))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_allow_marketplace_suggestions'),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	mut var_incentive := this.get_incentive()
	if !rt.is_true(var_incentive) {
		return false
	}
	if this.is_incentive_dismissed(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_array](var_incentive)) {
		return false
	}
	return (rt.call_method(this.suggestion_incentives, 'is_incentive_visible', [
		var_incentive.array_get(rt.new_string('id')),
		Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.woopayments(),
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_base_country', []rt.PhpVal{}),
		rt.new_bool(skip_wcpay_active),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) get_incentive() rt.PhpVal {
	return rt.call_method(this.suggestion_incentives, 'get_incentive', [
		Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.woopayments(),
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_base_country', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage.incentive_type(),
		rt.new_bool(true),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) is_wcpay_active() bool {
	return (rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) is_incentive_dismissed(mut var_incentive Class_Automattic_WooCommerce_Internal_Admin_array) bool {
	mut var_incentive_mutated := var_incentive
	mut var_dismissed_incentives := rt.call_function('get_option', [
		rt.new_string('wcpay_welcome_page_incentives_dismissed'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_dismissed_incentives)) {
		if rt.is_true(rt.call_function('in_array', [var_incentive_mutated.array_get(rt.new_string('id')),
			var_dismissed_incentives.clone(), rt.new_bool(true)]))
		{
			return true
		}
	}
	return (rt.call_method(this.suggestion_incentives, 'is_incentive_dismissed', [
		var_incentive_mutated.array_get(rt.new_string('id')),
		Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.woopayments(),
		rt.new_string('wc_payments_task'),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) get_active_payments_task_slug() string {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_0 := iife_temp_0.get_list(rt.new_string('setup'))
	mut var_setup_task_list := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_1 := iife_temp_1.get_list(rt.new_string('extended'))
	mut var_extended_task_list := iife_result_1
	if !rt.is_true(var_setup_task_list)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_setup_task_list, 'is_visible', []rt.PhpVal{})))))
		&& !rt.is_true(var_extended_task_list)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_extended_task_list, 'is_visible', []rt.PhpVal{}))))) {
		return ''
	}
	if !(!rt.is_true(var_setup_task_list))
		&& rt.is_true(rt.call_method(var_setup_task_list, 'is_visible', []rt.PhpVal{})) {
		mut var_payments_task := rt.call_method(var_setup_task_list, 'get_task', [
			rt.new_string('payments'),
		])
		if !(!rt.is_true(var_payments_task))
			&& rt.is_true(rt.call_method(var_payments_task, 'can_view', []rt.PhpVal{})) {
			return 'payments'
		}
	}
	if !(!rt.is_true(var_extended_task_list))
		&& rt.is_true(rt.call_method(var_extended_task_list, 'is_visible', []rt.PhpVal{})) {
		var_payments_task = rt.call_method(var_extended_task_list, 'get_task', [
			rt.new_string('payments'),
		])
		if !(!rt.is_true(var_payments_task))
			&& rt.is_true(rt.call_method(var_payments_task, 'can_view', []rt.PhpVal{})) {
			return 'payments'
		}
	}
	if !(!rt.is_true(var_setup_task_list))
		&& rt.is_true(rt.call_method(var_setup_task_list, 'is_visible', []rt.PhpVal{})) {
		var_payments_task = rt.call_method(var_setup_task_list, 'get_task', [
			rt.new_string('woocommerce-payments'),
		])
		if !(!rt.is_true(var_payments_task))
			&& rt.is_true(rt.call_method(var_payments_task, 'can_view', []rt.PhpVal{})) {
			return 'woocommerce-payments'
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) get_payments_task() rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_2 := iife_temp_2.get_list(rt.new_string('setup'))
	mut var_task_list := iife_result_2
	if !rt.is_true(var_task_list) {
		return rt.new_null()
	}
	mut var_payments_task := rt.call_method(var_task_list, 'get_task', [
		rt.new_string('payments'),
	])
	if !rt.is_true(var_payments_task) {
		return rt.new_null()
	}
	return var_payments_task.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) is_payments_task_complete() bool {
	mut var_payments_task := this.get_payments_task()
	return !(!rt.is_true(var_payments_task))
		&& rt.is_true(rt.call_method(var_payments_task, 'is_complete', []rt.PhpVal{}))
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcpaywelcomepage() &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage{
		PhpObjectBase:         rt.PhpObjectBase{}
		suggestion_incentives: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage.instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'has_incentive' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.has_incentive(dispatch_arg_0))
		}
		'get_incentive' {
			return this.get_incentive()
		}
		'is_wcpay_active' {
			return rt.new_bool(this.is_wcpay_active())
		}
		'is_incentive_dismissed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_incentive_dismissed(mut dispatch_arg_0))
		}
		'get_active_payments_task_slug' {
			return rt.new_string(this.get_active_payments_task_slug())
		}
		'get_payments_task' {
			return this.get_payments_task()
		}
		'is_payments_task_complete' {
			return rt.new_bool(this.is_payments_task_complete())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'suggestion_incentives' { return this.suggestion_incentives }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'suggestion_incentives' {
			this.suggestion_incentives = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
