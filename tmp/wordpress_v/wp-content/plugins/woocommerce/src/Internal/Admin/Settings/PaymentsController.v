import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController.transient_has_providers_with_incentive_key() string {
	return 'woocommerce_admin_settings_payments_has_providers_with_incentive'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController {
	rt.PhpObjectBase
pub mut:
		payments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) register()  {
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_menu' }])])
	rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_body_classes' }]), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'preload_settings' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_allowed_promo_notes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_allowed_promo_notes' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_sections_checkout'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_sections' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_payments_extension_suggestion_incentive_dismissed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_incentive_dismissed' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) init(mut var_payments Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments)  {
	this.payments = var_payments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) add_menu()  {
	mut var_menu := rt.new_null()
	// unsupported statement: Stmt_Global
	if this.is_woopayments_account_onboarded() {
		return rt.new_null()
	} else {
		rt.call_function('remove_menu_page', [rt.new_string('wc-admin&path=/payments/connect')])
	}
	mut var_menu_title := rt.call_function('esc_html__', [rt.new_string('Payments'), rt.new_string('woocommerce')])
	mut var_menu_icon := rt.new_string(rt.new_string('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI4NTIiIGhlaWdodD0iNjg0Ij48cGF0aCBmaWxsPSIjYTJhYWIyIiBkPSJNODIgODZ2NTEyaDY4NFY4NlptMCA1OThjLTQ4IDAtODQtMzgtODQtODZWODZDLTIgMzggMzQgMCA4MiAwaDY4NGM0OCAwIDg0IDM4IDg0IDg2djUxMmMwIDQ4LTM2IDg2LTg0IDg2em0zODQtNTU2djQ0aDg2djg0SDM4MnY0NGgxMjhjMjQgMCA0MiAxOCA0MiA0MnYxMjhjMCAyNC0xOCA0Mi00MiA0MmgtNDR2NDRoLTg0di00NGgtODZ2LTg0aDE3MHYtNDRIMzM4Yy0yNCAwLTQyLTE4LTQyLTQyVjIxNGMwLTI0IDE4LTQyIDQyLTQyaDQ0di00NHoiLz48L3N2Zz4='))
	mut var_menu_path := rt.new_string('admin.php?page=wc-settings&tab=checkout&from=' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_menu_item()).str())
	rt.call_function('add_menu_page', [var_menu_title.dup(), var_menu_title.dup(), rt.new_string('manage_woocommerce'), var_menu_path.dup(), rt.new_null(), var_menu_icon.dup(), rt.new_int(56)])
	if this.store_has_providers_with_incentive() {
		mut var_badge := rt.new_string(rt.new_string(' <span class="wcpay-menu-badge awaiting-mod count-1"><span class="plugin-count">1</span></span>'))
		{
			mut iter_1 := var_menu.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_menu_item := item_1.val
				mut var_index := item_1.key
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_menu_item.array_get(0), var_menu_title.dup()]))) && rt.is_true(rt.identical(var_menu_path, var_menu_item.array_get(2))))) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_menu_item.array_get(0), var_badge.dup()]))))) {
					// unsupported expression: Expr_AssignOp_Concat
					break
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) add_body_classes(classes string) rt.PhpVal {
	mut var_current_tab := rt.new_null()
	mut classes_mutated := classes
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(classes_mutated).dup().is_string()))))) {
		return rt.new_string(classes_mutated)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('checkout'), var_current_tab)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string('woocommerce-settings-payments-tab'), rt.new_string(classes_mutated).dup()]))))))) {
		classes_mutated = "${var_classes.to_string()} woocommerce-settings-payments-tab"
	}
	return rt.new_string(classes_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) preload_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return var_settings_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_settings_mutated.dup().is_array()))))) {
		var_settings_mutated = rt.new_array()
	}
	if !(var_settings_mutated.array_isset(Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key())) {
		var_settings_mutated.array_set(Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(), rt.new_array())
	}
	var_settings_mutated.array_get_mut(Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key()).array_set('business_country_code', rt.call_method(this.payments, 'get_country', []rt.PhpVal{}))
	return var_settings_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) add_allowed_promo_notes(var_promo_notes rt.PhpVal) rt.PhpVal {
	mut var_promo_notes_mutated := var_promo_notes
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_promo_notes_mutated.dup().is_array()))))) {
		var_promo_notes_mutated = rt.new_array()
	}
	mut var_providers := rt.call_method(this.payments, 'get_payment_providers', [rt.call_method(this.payments, 'get_country', []rt.PhpVal{}), rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', ['Failed to get payment providers: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }])])
		return var_promo_notes_mutated.dup()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if !(!rt.is_true(var_provider.array_get('_incentive').array_get('promo_id'))) {
				var_promo_notes_mutated.array_push(var_provider.array_get('_incentive').array_get('promo_id'))
			}
		}
	}
	return var_promo_notes_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) handle_sections(var_sections rt.PhpVal) rt.PhpVal {
	mut var_current_section := rt.new_null()
	mut var_sections_mutated := var_sections
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_sections_mutated.dup().is_array()))))) {
		var_sections_mutated = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_current_section) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_current_section.dup().is_string()))))))) {
		return var_sections_mutated.dup()
	}
	if rt.is_true(rt.call_function('in_array', [var_current_section.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_BACS.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_Cheque.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_COD.id() }]), rt.new_bool(true)])) {
		return rt.new_array()
	}
	return var_sections_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) handle_incentive_dismissed()  {
	rt.call_function('delete_transient', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController.transient_has_providers_with_incentive_key()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) store_has_enabled_gateways() bool {
	mut var_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_gateway := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.identical(rt.new_string('yes'), rt.get_property(var_gateway, 'enabled'))).to_bool()
	}
	mut var_enabled_gateways := rt.call_function('array_filter', [var_gateways.dup(), rt.new_closure(closure_1_fn)])
	return !(!rt.is_true(var_enabled_gateways))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) store_has_providers_with_incentive() bool {
	mut var_transient := rt.call_function('get_transient', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController.transient_has_providers_with_incentive_key()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_function('filter_var', [var_transient.dup(), rt.get_constant('FILTER_VALIDATE_BOOLEAN')])).to_bool()
	}
	mut var_providers := rt.call_method(this.payments, 'get_payment_providers', [rt.call_method(this.payments, 'get_country', []rt.PhpVal{}), rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', ['Failed to get payment providers: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }])])
		rt.call_function('set_transient', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController.transient_has_providers_with_incentive_key(), rt.new_string('no'), rt.get_constant('HOUR_IN_SECONDS')])
		return false
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	mut var_has_providers_with_incentive := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if !rt.is_true(var_provider.array_get('_incentive')) {
				continue
			}
			mut var_dismissals := if !(var_provider.array_get('_incentive').array_get('_dismissals')).is_null() { var_provider.array_get('_incentive').array_get('_dismissals') } else { rt.new_array() }
			if !rt.is_true(var_dismissals) {
				var_has_providers_with_incentive = rt.new_bool(rt.new_bool(true))
				break
			}
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_dismissal := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_dismissal.array_isset(rt.new_string('context')) && rt.is_true(rt.identical(rt.new_string('wc_settings_payments__banner'), var_dismissal.array_get('context')))
	}
			mut var_is_dismissed_banner := rt.new_bool(rt.new_bool(!(!rt.is_true(rt.call_function('array_filter', [var_dismissals.dup(), rt.new_closure(closure_2_fn)])))))
			if rt.is_true(var_is_dismissed_banner) {
				continue
			}
			closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_dismissal := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_dismissal.array_isset(rt.new_string('context')) && rt.is_true(rt.identical(rt.new_string('wc_settings_payments__modal'), var_dismissal.array_get('context')))
	}
			mut var_is_dismissed_modal := rt.new_bool(rt.new_bool(!(!rt.is_true(rt.call_function('array_filter', [var_dismissals.dup(), rt.new_closure(closure_3_fn)])))))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_is_dismissed_modal)))) {
				var_has_providers_with_incentive = rt.new_bool(rt.new_bool(true))
				break
			}
			closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_dismissal := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.is_true(rt.new_bool(var_dismissal.array_isset(rt.new_string('context')) && var_dismissal.array_isset(rt.new_string('timestamp')) && rt.is_true(rt.identical(rt.new_string('wc_settings_payments__modal'), var_dismissal.array_get('context'))))) && rt.is_true(rt.less(var_dismissal.array_get('timestamp'), rt.call_function('strtotime', [rt.new_string('-30 days')])))
	}
			mut var_is_dismissed_modal_more_than_30_days_ago := rt.new_bool(rt.new_bool(!(!rt.is_true(rt.call_function('array_filter', [var_dismissals.dup(), rt.new_closure(closure_4_fn)])))))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_is_dismissed_modal_more_than_30_days_ago)))) {
				continue
			}
			var_has_providers_with_incentive = rt.new_bool(rt.new_bool(true))
			break
		}
	}
	rt.call_function('set_transient', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController.transient_has_providers_with_incentive_key(), if rt.is_true(var_has_providers_with_incentive) { rt.new_string('yes') } else { rt.new_string('no') }, rt.get_constant('HOUR_IN_SECONDS')])
	return (var_has_providers_with_incentive).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) is_woopayments_account_onboarded() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Payments')]))))) {
		return false
	}
	mut var_account_data := rt.call_function('get_option', [rt.new_string('wcpay_account_data'), rt.new_array()])
	if !rt.is_true(var_account_data.array_get('data').array_get('account_id')) {
		return false
	}
	if !rt.is_true(var_account_data.array_get('data').array_get('details_submitted')) {
		return false
	}
	return (if !(rt.call_function('filter_var', [var_account_data.array_get('data').array_get('details_submitted'), rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])).is_null() { rt.call_function('filter_var', [var_account_data.array_get('data').array_get('details_submitted'), rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')]) } else { rt.new_bool(false) }).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentscontroller() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController{
		PhpObjectBase: rt.PhpObjectBase{}
		payments: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy() &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_menu' {
			this.add_menu()
			return rt.new_null()
		}
		'add_body_classes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.add_body_classes(dispatch_arg_0)
		}
		'preload_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.preload_settings(dispatch_arg_0)
		}
		'add_allowed_promo_notes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_allowed_promo_notes(dispatch_arg_0)
		}
		'handle_sections' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_sections(dispatch_arg_0)
		}
		'handle_incentive_dismissed' {
			this.handle_incentive_dismissed()
			return rt.new_null()
		}
		'store_has_enabled_gateways' {
			return rt.new_bool(this.store_has_enabled_gateways())
		}
		'store_has_providers_with_incentive' {
			return rt.new_bool(this.store_has_providers_with_incentive())
		}
		'is_woopayments_account_onboarded' {
			return rt.new_bool(this.is_woopayments_account_onboarded())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payments' { return this.payments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payments' { this.payments = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentscontroller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
