import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.email_customizers() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: 'aco-email-customizer-and-designer-for-woocommerce.php' },
		rt.ArrayItem{ key: none, val: 'decorator.php' },
		rt.ArrayItem{ key: none, val: 'email-customizer-for-woocommerce.php' },
		rt.ArrayItem{ key: none, val: 'email-customizer-pro.php' },
		rt.ArrayItem{ key: none, val: 'kadence-woocommerce-email-designer.php' },
		rt.ArrayItem{ key: none, val: 'mailpoet.php' },
		rt.ArrayItem{ key: none, val: 'wp-html-mail.php' },
		rt.ArrayItem{ key: none, val: 'yaymail.php' },
	])
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.email_template_parts() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'email-addresses.php' },
		rt.ArrayItem{ key: none, val: 'email-customer-details.php' },
		rt.ArrayItem{ key: none, val: 'email-downloads.php' },
		rt.ArrayItem{ key: none, val: 'email-footer.php' }, rt.ArrayItem{
			key: none
			val: 'email-header.php'
		}, rt.ArrayItem{ key: none, val: 'email-mobile-messaging.php' },
		rt.ArrayItem{ key: none, val: 'email-order-details.php' },
		rt.ArrayItem{ key: none, val: 'email-order-items.php' },
		rt.ArrayItem{ key: none, val: 'email-styles.php' }])
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) construct() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_email_improvements_modal_to_url' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.has_email_templates_overridden() bool {
	mut iife_temp_0 := Class_WC_Tracker{}
	mut iife_result_0 := iife_temp_0.get_all_template_overrides()
	mut var_all_template_overrides := iife_result_0
	mut var_core_email_overrides :=
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_core_email_overrides(var_all_template_overrides.clone())
	return rt.new_bool(var_core_email_overrides.clone().array_count() > 0)
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.is_email_customizer_enabled() bool {
	mut iife_temp_1 := Class_WC_Tracker{}
	mut iife_result_1 := iife_temp_1.get_all_plugins()
	mut var_all_plugins := iife_result_1
	mut var_active_plugins := var_all_plugins.array_get(rt.new_string('active_plugins'))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parts := rt.call_function('explode', [rt.new_string('/'),
			var_plugin_path.clone()])
		return (rt.call_function('end', [var_parts.clone()])).to_bool()
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parts := rt.call_function('explode', [rt.new_string('/'),
			var_plugin_path.clone()])
		return (rt.call_function('end', [var_parts.clone()])).to_bool()
	}
	mut var_plugin_slugs := rt.call_function('array_map', [rt.new_closure(closure_3_fn),
		rt.func_array_keys(var_active_plugins.clone())])
	return rt.new_bool(rt.call_function('array_intersect', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.email_customizers(),
		var_plugin_slugs.clone(),
	]).array_count() > 0)
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.is_email_improvements_enabled_for_existing_stores() bool {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_4 := iife_temp_4.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_is_feature_enabled := iife_result_4
	mut var_is_enabled_for_existing_stores := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_email_improvements_existing_store_enabled'),
	]))
	return rt.is_true(var_is_feature_enabled) && rt.is_true(var_is_enabled_for_existing_stores)
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.should_enable_email_improvements_for_existing_stores() bool {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_5 := iife_temp_5.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_5) {
		return false
	}
	mut var_manually_disabled_before := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_improvements_last_disabled_at'),
	])
	if rt.is_true(var_manually_disabled_before) {
		return false
	}
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.has_email_templates_overridden()) {
		return false
	}
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.is_email_customizer_enabled()) {
		return false
	}
	return false
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.should_notify_merchant_about_email_improvements() bool {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_6 := iife_temp_6.feature_is_enabled(rt.new_string('email_improvements'))
	return !(rt.is_true(iife_result_6))
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.add_email_improvements_modal_to_url() {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('page')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wc-admin'), rt.get_superglobal('_GET').array_get(rt.new_string('page'))))))
		|| rt.get_superglobal('_GET').array_isset(rt.new_string('path')) {
		return
	}
	mut var_dismissed_modal := rt.call_function('get_option', [
		rt.new_string('woocommerce_admin_dismissed_email_improvements_modal'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), var_dismissed_modal))))
		&& rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.is_email_improvements_enabled_for_existing_stores()) {
		rt.call_function('update_option', [
			rt.new_string('woocommerce_admin_dismissed_email_improvements_modal'),
			rt.new_string('yes'),
		])
		rt.call_function('wp_safe_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('emailImprovementsModal'),
				rt.new_string('enabled')]),
		])
		exit(0)
	}
	var_dismissed_modal = rt.call_function('get_option', [
		rt.new_string('woocommerce_admin_dismissed_try_email_improvements_modal'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), var_dismissed_modal))))
		&& rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.should_notify_merchant_about_email_improvements()) {
		rt.call_function('update_option', [
			rt.new_string('woocommerce_admin_dismissed_try_email_improvements_modal'),
			rt.new_string('yes'),
		])
		rt.call_function('wp_safe_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('emailImprovementsModal'),
				rt.new_string('try')]),
		])
		exit(0)
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_core_emails() rt.PhpVal {
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(
			rt.is_true(rt.identical(rt.call_function('strpos', [rt.call_function('get_class', [var_email.clone()]), rt.new_string('WC_Email_')]), rt.new_int(0)))
			&& rt.get_property(var_email, 'template_html').is_string())
	}
	return rt.call_function('array_filter', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_emails(),
		rt.new_closure(closure_8_fn),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_core_email_overrides(var_template_overrides rt.PhpVal) rt.PhpVal {
	mut var_core_emails :=
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_core_emails()
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('basename', [rt.get_property(var_email, 'template_html')])
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('basename', [rt.get_property(var_email, 'template_html')])
	}
	mut var_core_email_templates := rt.call_function('array_map', [
		rt.new_closure(closure_9_fn),
		var_core_emails.clone(),
	])
	mut var_all_email_templates := rt.call_function('array_merge', [
		var_core_email_templates.clone(),
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.email_template_parts()])
	return rt.call_function('array_intersect', [var_all_email_templates.clone(),
		var_template_overrides.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_enabled_emails() rt.PhpVal {
	mut var_email := rt.new_null()
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(rt.call_method(var_email, 'is_enabled', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_email, 'is_manual', []rt.PhpVal{}))))))
	}
	mut var_enabled_emails := rt.call_function('array_filter', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_emails(),
		rt.new_closure(closure_11_fn),
	])
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	return rt.call_function('array_values', [
		rt.call_function('array_map', [rt.new_closure(closure_12_fn),
			var_enabled_emails.clone()]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_disabled_emails() rt.PhpVal {
	mut var_email := rt.new_null()
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_email, 'is_enabled', []rt.PhpVal{})))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_email, 'is_manual', []rt.PhpVal{}))))))
	}
	mut var_disabled_emails := rt.call_function('array_filter', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_emails(),
		rt.new_closure(closure_16_fn),
	])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('get_class', [var_email.clone()])
	}
	return rt.call_function('array_values', [
		rt.call_function('array_map', [rt.new_closure(closure_17_fn),
			var_disabled_emails.clone()]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_enabled_or_manual_emails_with_cc_or_bcc() rt.PhpVal {
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(rt.call_method(var_email, 'is_enabled', []rt.PhpVal{}))
			|| rt.is_true(rt.call_method(var_email, 'is_manual', []rt.PhpVal{})))
	}
	mut var_enabled_or_manual_emails := rt.call_function('array_filter', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_emails(),
		rt.new_closure(closure_21_fn),
	])
	mut var_email_ids_with_cc := rt.new_array()
	mut var_email_ids_with_bcc := rt.new_array()
	mut iter_1 := var_enabled_or_manual_emails.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_email := item_1.val
		if rt.is_true(rt.call_method(var_email, 'get_cc_recipient', []rt.PhpVal{})) {
			var_email_ids_with_cc.array_push(rt.call_function('get_class', [
				var_email.clone()]))
		}
		if rt.is_true(rt.call_method(var_email, 'get_bcc_recipient', []rt.PhpVal{})) {
			var_email_ids_with_bcc.array_push(rt.call_function('get_class', [
				var_email.clone()]))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'ccs', val: var_email_ids_with_cc },
		rt.ArrayItem{ key: 'bccs', val: var_email_ids_with_bcc }])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_emails() rt.PhpVal {
	mut var_email := rt.new_null()
	mut var_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_email.clone().is_object()
			&& rt.is_true(rt.new_bool(rt.instance_of(var_email, 'Automattic_WooCommerce_Internal_Admin_EmailImprovements_WC_Email'))))
	}
	return rt.call_function('array_filter', [var_emails.clone(),
		rt.new_closure(closure_22_fn)])
}

struct Class_WC_Tracker {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_emailimprovements_emailimprovements() &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_tracker(_args ...rt.PhpVal) &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'has_email_templates_overridden' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.has_email_templates_overridden())
		}
		'is_email_customizer_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.is_email_customizer_enabled())
		}
		'is_email_improvements_enabled_for_existing_stores' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.is_email_improvements_enabled_for_existing_stores())
		}
		'should_enable_email_improvements_for_existing_stores' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.should_enable_email_improvements_for_existing_stores())
		}
		'should_notify_merchant_about_email_improvements' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.should_notify_merchant_about_email_improvements())
		}
		'add_email_improvements_modal_to_url' {
			Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.add_email_improvements_modal_to_url()
			return rt.new_null()
		}
		'get_core_emails' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_core_emails()
		}
		'get_core_email_overrides' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_core_email_overrides(dispatch_arg_0)
		}
		'get_enabled_emails' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_enabled_emails()
		}
		'get_disabled_emails' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_disabled_emails()
		}
		'get_enabled_or_manual_emails_with_cc_or_bcc' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_enabled_or_manual_emails_with_cc_or_bcc()
		}
		'get_emails' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements.get_emails()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
