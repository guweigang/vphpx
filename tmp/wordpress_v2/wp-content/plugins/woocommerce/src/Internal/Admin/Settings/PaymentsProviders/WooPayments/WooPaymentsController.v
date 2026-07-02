import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController {
	rt.PhpObjectBase
pub mut:
	payments    rt.PhpVal = rt.new_null()
	woopayments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController) register() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_returns_from_wpcom' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController) init(mut var_payments Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments, mut var_woopayments Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) {
	this.payments = var_payments
	this.woopayments = var_woopayments
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController) handle_returns_from_wpcom() {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.wpcom_connection_return_param()))) {
		if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('source'))) {
			return
		}
		mut var_source := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('source'))]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_source.clone(),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_default()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_lys()
				},
			]),
			rt.new_bool(true)])))))
		{
			return
		}
		mut var_location := rt.call_method(this.payments, 'get_country', []rt.PhpVal{})
		mut var_wpcom_connected := rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed(), rt.call_method(this.woopayments,
			'get_onboarding_step_status', [
			Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection(),
			var_location.clone(),
		]))
		mut var_event_props := rt.create_array([
			rt.ArrayItem{
				key: 'step_id'
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection()
			},
			rt.ArrayItem{ key: 'source', val: var_source },
		])
		rt.call_method(this.woopayments, 'record_event', [
			rt.new_string((if rt.is_true(var_wpcom_connected) {
				'wpcom_connection_success'
			} else {
				'wpcom_connection_failure'
			}).str()),
			var_location.clone(),
			var_event_props.clone(),
		])
		if rt.is_true(var_wpcom_connected) {
			rt.call_method(this.woopayments, 'mark_onboarding_step_completed', [
				Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection(),
				var_location.clone(),
			])
		}
	}
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_woopayments_woopaymentscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController{
		PhpObjectBase: rt.PhpObjectBase{}
		payments:      rt.new_null()
		woopayments:   rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_returns_from_wpcom' {
			this.handle_returns_from_wpcom()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payments' { return this.payments }
		'woopayments' { return this.woopayments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payments' {
			this.payments = val
			return true
		}
		'woopayments' {
			this.woopayments = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
