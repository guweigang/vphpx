import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id() string {
	return 'woocommerce_payments'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.extension_minimum_version() string {
	return '9.3.0'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_path_base() string {
	return '/woopayments/onboarding'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods() string {
	return 'payment_methods'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection() string {
	return 'wpcom_connection'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account() string {
	return 'test_account'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification() string {
	return 'business_verification'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_not_started() string {
	return 'not_started'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started() string {
	return 'started'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed() string {
	return 'completed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed() string {
	return 'failed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked() string {
	return 'blocked'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() string {
	return 'REST'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_redirect() string {
	return 'REDIRECT'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_profile_option_key() string {
	return 'woocommerce_woopayments_nox_profile'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_onboarding_locked_key() string {
	return 'woocommerce_woopayments_nox_onboarding_locked'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_onboarding_locked_ttl_seconds() i64 {
	return 120
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_default() string {
	return 'settings_payments'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_lys() string {
	return 'lys'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_payment_settings() string {
	return 'WCADMIN_PAYMENT_SETTINGS'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_nox_in_context() string {
	return 'WCADMIN_NOX_IN_CONTEXT'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_kyc() string {
	return 'KYC'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_wpcom() string {
	return 'WPCOM'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.wpcom_connection_return_param() string {
	return 'wpcom_connection_return'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix() string {
	return 'settings_payments_woopayments_'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService {
	rt.PhpObjectBase
pub mut:
		payments_providers rt.PhpVal = rt.new_null()
		proxy rt.PhpVal = rt.new_null()
		wpcom_connection_manager rt.PhpVal = rt.new_null()
		provider rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) init(mut var_payment_providers Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders, mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy)  {
	this.payments_providers = var_payment_providers.dup()
	this.proxy = var_proxy.dup()
	this.wpcom_connection_manager = rt.call_method(this.proxy, 'get_instance_of', [Class_Automattic_Jetpack_Connection_Manager.class(), rt.new_string('woocommerce')])
	this.provider = rt.call_method(this.payments_providers, 'get_payment_gateway_provider_instance', [Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_details(location string, rest_path string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
	this.check_if_onboarding_action_is_acceptable()
	var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
	mut var_gateway := this.get_payment_gateway()
	mut var_onboarding_supported := if !(rt.call_method(this.provider, 'is_onboarding_supported', [var_gateway.dup(), rt.new_string(location)])).is_null() { rt.call_method(this.provider, 'is_onboarding_supported', [var_gateway.dup(), rt.new_string(location)]) } else { rt.new_bool(true) }
	mut var_onboarding_started := rt.call_method(this.provider, 'is_onboarding_started', [var_gateway.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_onboarding_started)))) && !(!rt.is_true(this.get_nox_profile_onboarding(location))))) {
		var_onboarding_started = rt.new_bool(rt.new_bool(true))
	}
	return rt.create_array([rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'supported', val: var_onboarding_supported }, rt.ArrayItem{ key: 'started', val: var_onboarding_started }, rt.ArrayItem{ key: 'completed', val: rt.call_method(this.provider, 'is_onboarding_completed', [var_gateway.dup()]) }, rt.ArrayItem{ key: 'test_mode', val: rt.call_method(this.provider, 'is_in_test_mode_onboarding', [var_gateway.dup()]) }, rt.ArrayItem{ key: 'dev_mode', val: rt.call_method(this.provider, 'is_in_dev_mode', [var_gateway.dup()]) }]) }, rt.ArrayItem{ key: 'messages', val: rt.create_array([rt.ArrayItem{ key: 'not_supported', val: if rt.is_true(rt.new_bool(!(rt.is_true(var_onboarding_supported)))) { rt.call_method(this.provider, 'get_onboarding_not_supported_message', [var_gateway.dup(), rt.new_string(location)]) } else { rt.new_null() } }]) }, rt.ArrayItem{ key: 'steps', val: this.get_onboarding_steps(location, (rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + 'step', mut var_source_mutated) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'urls', val: rt.create_array([rt.ArrayItem{ key: 'overview_page', val: this.get_overview_page_url() }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_valid_onboarding_step_id(step_id string) bool {
	return (rt.call_function('in_array', [rt.new_string(step_id), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification() }]), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_step_status(step_id string, location string) string {
	if !(this.is_valid_onboarding_step_id(step_id)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(rt.new_string('woocommerce_woopayments_onboarding_invalid_step_id'), rt.call_function('esc_html__', [rt.new_string('Invalid onboarding step ID.'), rt.new_string('woocommerce')]), // unsupported expression: Expr_Cast_Int)))
	}
	mut var_meets_requirements := rt.new_bool(this.check_onboarding_step_requirements(step_id, location))
	if rt.is_true(var_meets_requirements) {
		mut switch_val_1 := rt.new_string(step_id)
		if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods())) {
			if this.has_valid_account() {
				return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
			}
		} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection())) {
			if this.has_working_wpcom_connection() {
				return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
			}
		} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account())) {
			if this.has_test_account() || this.has_sandbox_account() && this.has_valid_account() && this.has_working_account() {
				this.clear_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location)
				this.clear_onboarding_step_blocked((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location)
				this.mark_onboarding_step_completed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location, false, rt.new_null())
				return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
			}
		} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification())) {
			if this.has_valid_account() && this.has_live_account() {
				return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
			}
		}
	}
	mut switch_val_2 := rt.new_string(step_id)
	if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection())) {
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account())) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_meets_requirements) && this.was_onboarding_step_marked_completed(step_id, location))) && !(this.has_test_account() && !(this.has_valid_account())))) {
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
		}
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification())) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_meets_requirements) && this.was_onboarding_step_marked_completed(step_id, location))) && this.has_valid_account())) && this.has_live_account() || this.has_sandbox_account())) {
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
		}
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(var_meets_requirements) && this.was_onboarding_step_marked_completed(step_id, location))) {
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
		}
	}
	if rt.is_true(var_meets_requirements) {
		if this.is_onboarding_step_blocked(step_id, location) {
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked()).str()
		}
		if this.is_onboarding_step_failed(step_id, location) {
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed()).str()
		}
	}
	if this.was_onboarding_step_marked_started(step_id, location) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account(), rt.new_string(step_id))) && !(this.has_account()))) {
			mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
			mut var_started_timestamp := if !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started()))) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
			if rt.is_true(rt.new_bool(rt.is_true(var_started_timestamp) && rt.is_true(rt.greater(rt.sub(rt.call_method(this.proxy, 'call_function', [rt.new_string('time')]), var_started_timestamp), rt.new_int(60))))) {
				this.clean_onboarding_step_progress(step_id, location)
				this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_step_progress_reset_due_to_timeout', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'step_id', val: step_id }])))
				return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_not_started()).str()
			}
		}
		return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started()).str()
	}
	return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_not_started()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) was_onboarding_step_marked_started(step_id string, location string) bool {
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	return !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started())))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) mark_onboarding_step_started(step_id string, location string, overwrite bool, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) bool {
	mut var_source_mutated := var_source
	this.check_if_onboarding_step_action_is_acceptable(step_id, location)
	this.clear_onboarding_step_failed(step_id, location)
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	if !(var_overwrite) && !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started()))) {
		return true
	}
	var_statuses.array_set(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started(), rt.call_method(this.proxy, 'call_function', [rt.new_string('time')]))
	mut var_result := rt.new_bool(this.save_nox_profile_onboarding_step_entry(step_id, location, 'statuses', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_statuses)))
	if rt.is_true(var_result) {
		var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
		this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_step_started', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'step_id', val: step_id }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])))
	}
	return (var_result).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_onboarding_step_completed(step_id string, location string) bool {
	return (rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed(), this.get_onboarding_step_status(step_id, location))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) was_onboarding_step_marked_completed(step_id string, location string) bool {
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	return !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed())))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) mark_onboarding_step_completed(step_id string, location string, overwrite bool, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) bool {
	mut var_source_mutated := var_source
	this.check_if_onboarding_step_action_is_acceptable(step_id, location)
	this.clear_onboarding_step_failed(step_id, location)
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	if !(var_overwrite) && !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()))) {
		return true
	}
	var_statuses.array_set(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed(), rt.call_method(this.proxy, 'call_function', [rt.new_string('time')]))
	mut var_result := rt.new_bool(this.save_nox_profile_onboarding_step_entry(step_id, location, 'statuses', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_statuses)))
	if rt.is_true(var_result) {
		var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
		this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_step_completed', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'step_id', val: step_id }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])))
	}
	return (var_result).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) clean_onboarding_step_progress(step_id string, location string) bool {
	this.check_if_onboarding_action_is_acceptable()
	if !(this.is_valid_onboarding_step_id(step_id)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(rt.new_string('woocommerce_woopayments_onboarding_invalid_step_id'), rt.call_function('esc_html__', [rt.new_string('Invalid onboarding step ID.'), rt.new_string('woocommerce')]), // unsupported expression: Expr_Cast_Int)))
	}
	this.clear_onboarding_step_failed(step_id, location)
	this.clear_onboarding_step_blocked(step_id, location)
	mut var_result := rt.new_bool(this.save_nox_profile_onboarding_step_entry(step_id, location, 'statuses', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.new_array())))
	if rt.is_true(var_result) {
		this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_step_progress_reset', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'step_id', val: step_id }])))
	}
	return (var_result).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_onboarding_step_failed(step_id string, location string) bool {
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	return !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed())))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) mark_onboarding_step_failed(step_id string, location string, mut var_error Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	mut var_error_mutated := var_error
	this.save_nox_profile_onboarding_step_data_entry(step_id, location, 'error', this.sanitize_onboarding_step_error(mut var_error_mutated))
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	var_statuses.array_set(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed(), rt.call_method(this.proxy, 'call_function', [rt.new_string('time')]))
	var_statuses.array_unset(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked())
	mut var_result := rt.new_bool(this.save_nox_profile_onboarding_step_entry(step_id, location, 'statuses', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_statuses)))
	if rt.is_true(var_result) {
		this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_step_failed', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'step_id', val: step_id }, rt.ArrayItem{ key: 'error_code', val: if !(!rt.is_true(var_error_mutated.array_get('code'))) { var_error_mutated.array_get('code') } else { rt.new_string('') } }])))
	}
	return (var_result).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) clear_onboarding_step_failed(step_id string, location string) bool {
	if !(this.is_onboarding_step_failed(step_id, location)) {
		return false
	}
	this.save_nox_profile_onboarding_step_data_entry(step_id, location, 'error', rt.new_array())
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	var_statuses.array_unset(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed())
	return this.save_nox_profile_onboarding_step_entry(step_id, location, 'statuses', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_statuses))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_onboarding_step_blocked(step_id string, location string) bool {
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	return !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked())))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) mark_onboarding_step_blocked(step_id string, location string, mut var_errors Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	this.save_nox_profile_onboarding_step_data_entry(step_id, location, 'error', this.sanitize_onboarding_step_error(mut var_errors))
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(, , , rt.new_null()))
	var_statuses.array_set(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked(), rt.call_method(, 'call_function', []))
	var_statuses.array_unset(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed())
	return 
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) clear_onboarding_step_blocked(step_id string, location string) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_step_error(step_id string, location string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) sanitize_onboarding_step_error(mut var_error Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) rt.PhpVal {
	mut var_error_mutated := var_error
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_step_save(step_id string, location string, mut var_request_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_valid_onboarding_step_data(step_id string, mut var_request_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_step_check(step_id string, location string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_recommended_payment_methods(location string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_test_account_init(location string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_kyc_session(location string, mut var_self_assessment Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_self_assessment_mutated := var_self_assessment
	mut var_source_mutated := var_source
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) finish_onboarding_kyc_session(location string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_preload() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) reset_onboarding(location string, from string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) disable_test_account(location string, from string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) record_event(name string, business_country string, mut var_properties Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array)  {
	mut name_mutated := name
	mut var_properties_mutated := var_properties
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) check_if_onboarding_action_is_acceptable()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) check_if_onboarding_step_action_is_acceptable(step_id string, location string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_onboarding_locked() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) set_onboarding_lock()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) clear_onboarding_lock()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_steps(location string, rest_path string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) standardize_onboarding_step_details(mut var_step_details Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array, location string, rest_path string) rt.PhpVal {
	mut var_step_details_mutated := var_step_details
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) standardize_onboarding_steps_details(mut var_steps Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array, location string, rest_path string) rt.PhpVal {
	mut var_steps_mutated := var_steps
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile(mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding(location string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding(location string, mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding_step(step_id string, location string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding_step(step_id string, location string, mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding_step_entry(step_id string, location string, entry string, var_default_value rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding_step_entry(step_id string, location string, entry string, mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding_step_data_entry(step_id string, location string, entry string, default_value bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding_step_data_entry(step_id string, location string, entry string, var_data rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_step_required_steps(step_id string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) check_onboarding_step_requirements(step_id string, location string) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_payment_methods_state(location string, mut var_recommended_pms Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?array) rt.PhpVal {
	mut var_recommended_pms_mutated := var_recommended_pms
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_wpcom_connection_authorization(return_url string) rt.PhpVal {
	mut return_url_mutated := return_url
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_wpcom_connection_state() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_working_wpcom_connection() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_extension_active() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_payment_gateway() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_valid_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_working_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_test_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_sandbox_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_live_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_kyc_fields(location string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_kyc_fallback_url() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_overview_page_url() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) validate_onboarding_source(mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) string {
	mut var_source_mutated := var_source
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_woopayments_woopaymentsservice() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService{
		PhpObjectBase: rt.PhpObjectBase{}
		payments_providers: rt.new_null()
		proxy: rt.new_null()
		wpcom_connection_manager: rt.new_null()
		provider: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception() &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_onboarding_details' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_onboarding_details(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'is_valid_onboarding_step_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_valid_onboarding_step_id(dispatch_arg_0))
		}
		'get_onboarding_step_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_onboarding_step_status(dispatch_arg_0, dispatch_arg_1))
		}
		'was_onboarding_step_marked_started' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.was_onboarding_step_marked_started(dispatch_arg_0, dispatch_arg_1))
		}
		'mark_onboarding_step_started' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_bool(this.mark_onboarding_step_started(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3))
		}
		'is_onboarding_step_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_onboarding_step_completed(dispatch_arg_0, dispatch_arg_1))
		}
		'was_onboarding_step_marked_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.was_onboarding_step_marked_completed(dispatch_arg_0, dispatch_arg_1))
		}
		'mark_onboarding_step_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_bool(this.mark_onboarding_step_completed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3))
		}
		'clean_onboarding_step_progress' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.clean_onboarding_step_progress(dispatch_arg_0, dispatch_arg_1))
		}
		'is_onboarding_step_failed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_onboarding_step_failed(dispatch_arg_0, dispatch_arg_1))
		}
		'mark_onboarding_step_failed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.mark_onboarding_step_failed(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'clear_onboarding_step_failed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.clear_onboarding_step_failed(dispatch_arg_0, dispatch_arg_1))
		}
		'is_onboarding_step_blocked' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_onboarding_step_blocked(dispatch_arg_0, dispatch_arg_1))
		}
		'mark_onboarding_step_blocked' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.mark_onboarding_step_blocked(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'clear_onboarding_step_blocked' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.clear_onboarding_step_blocked(dispatch_arg_0, dispatch_arg_1))
		}
		'get_onboarding_step_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_onboarding_step_error(dispatch_arg_0, dispatch_arg_1)
		}
		'sanitize_onboarding_step_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sanitize_onboarding_step_error(mut dispatch_arg_0)
		}
		'onboarding_step_save' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.onboarding_step_save(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'is_valid_onboarding_step_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.is_valid_onboarding_step_data(dispatch_arg_0, mut dispatch_arg_1))
		}
		'onboarding_step_check' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.onboarding_step_check(dispatch_arg_0, dispatch_arg_1)
		}
		'get_onboarding_recommended_payment_methods' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_onboarding_recommended_payment_methods(dispatch_arg_0)
		}
		'onboarding_test_account_init' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.onboarding_test_account_init(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_onboarding_kyc_session' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_onboarding_kyc_session(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'finish_onboarding_kyc_session' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.finish_onboarding_kyc_session(dispatch_arg_0, mut dispatch_arg_1)
		}
		'onboarding_preload' {
			return this.onboarding_preload()
		}
		'reset_onboarding' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.reset_onboarding(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'disable_test_account' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.disable_test_account(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'record_event' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.record_event(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'check_if_onboarding_action_is_acceptable' {
			this.check_if_onboarding_action_is_acceptable()
			return rt.new_null()
		}
		'check_if_onboarding_step_action_is_acceptable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.check_if_onboarding_step_action_is_acceptable(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_onboarding_locked' {
			return rt.new_bool(this.is_onboarding_locked())
		}
		'set_onboarding_lock' {
			this.set_onboarding_lock()
			return rt.new_null()
		}
		'clear_onboarding_lock' {
			this.clear_onboarding_lock()
			return rt.new_null()
		}
		'get_onboarding_steps' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_onboarding_steps(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'standardize_onboarding_step_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.standardize_onboarding_step_details(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'standardize_onboarding_steps_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.standardize_onboarding_steps_details(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_nox_profile' {
			return this.get_nox_profile()
		}
		'save_nox_profile' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.save_nox_profile(mut dispatch_arg_0))
		}
		'get_nox_profile_onboarding' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_nox_profile_onboarding(dispatch_arg_0)
		}
		'save_nox_profile_onboarding' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.save_nox_profile_onboarding(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_nox_profile_onboarding_step' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_nox_profile_onboarding_step(dispatch_arg_0, dispatch_arg_1)
		}
		'save_nox_profile_onboarding_step' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.save_nox_profile_onboarding_step(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'get_nox_profile_onboarding_step_entry' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_nox_profile_onboarding_step_entry(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'save_nox_profile_onboarding_step_entry' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_bool(this.save_nox_profile_onboarding_step_entry(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3))
		}
		'get_nox_profile_onboarding_step_data_entry' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_nox_profile_onboarding_step_data_entry(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'save_nox_profile_onboarding_step_data_entry' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.save_nox_profile_onboarding_step_data_entry(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_onboarding_step_required_steps' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.get_onboarding_step_required_steps(dispatch_arg_0)
			return rt.new_null()
		}
		'check_onboarding_step_requirements' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.check_onboarding_step_requirements(dispatch_arg_0, dispatch_arg_1))
		}
		'get_onboarding_payment_methods_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_onboarding_payment_methods_state(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_wpcom_connection_authorization' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_wpcom_connection_authorization(dispatch_arg_0)
		}
		'get_wpcom_connection_state' {
			return this.get_wpcom_connection_state()
		}
		'has_working_wpcom_connection' {
			return rt.new_bool(this.has_working_wpcom_connection())
		}
		'is_extension_active' {
			return rt.new_bool(this.is_extension_active())
		}
		'get_payment_gateway' {
			return this.get_payment_gateway()
		}
		'has_account' {
			return rt.new_bool(this.has_account())
		}
		'has_valid_account' {
			return rt.new_bool(this.has_valid_account())
		}
		'has_working_account' {
			return rt.new_bool(this.has_working_account())
		}
		'has_test_account' {
			return rt.new_bool(this.has_test_account())
		}
		'has_sandbox_account' {
			return rt.new_bool(this.has_sandbox_account())
		}
		'has_live_account' {
			return rt.new_bool(this.has_live_account())
		}
		'get_onboarding_kyc_fields' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_onboarding_kyc_fields(dispatch_arg_0)
		}
		'get_onboarding_kyc_fallback_url' {
			return rt.new_string(this.get_onboarding_kyc_fallback_url())
		}
		'get_overview_page_url' {
			return rt.new_string(this.get_overview_page_url())
		}
		'validate_onboarding_source' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.validate_onboarding_source(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payments_providers' { return this.payments_providers }
		'proxy' { return this.proxy }
		'wpcom_connection_manager' { return this.wpcom_connection_manager }
		'provider' { return this.provider }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payments_providers' { this.payments_providers = val; return true }
		'proxy' { this.proxy = val; return true }
		'wpcom_connection_manager' { this.wpcom_connection_manager = val; return true }
		'provider' { this.provider = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_woopayments_woopaymentsservice_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
