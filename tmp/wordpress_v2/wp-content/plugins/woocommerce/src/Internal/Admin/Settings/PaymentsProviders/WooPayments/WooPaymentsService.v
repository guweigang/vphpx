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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) init(mut var_payment_providers Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders, mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy) {
	this.payments_providers = var_payment_providers
	this.proxy = var_proxy
	this.wpcom_connection_manager = rt.call_method(this.proxy, 'get_instance_of', [Class_Automattic_Jetpack_Connection_Manager.class(), rt.new_string('woocommerce')])
	this.provider = rt.call_method(this.payments_providers, 'get_payment_gateway_provider_instance', [Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_details(location string, rest_path string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
	this.check_if_onboarding_action_is_acceptable()
	var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
	mut var_gateway := this.get_payment_gateway()
	mut var_onboarding_supported := if !(rt.call_method(this.provider, 'is_onboarding_supported', [var_gateway.clone(), rt.new_string(location)])).is_null() { rt.call_method(this.provider, 'is_onboarding_supported', [var_gateway.clone(), rt.new_string(location)]) } else { rt.new_bool(true) }
	mut var_onboarding_started := rt.call_method(this.provider, 'is_onboarding_started', [var_gateway.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_onboarding_started)))) && !(!rt.is_true(this.get_nox_profile_onboarding(location))) {
	var_onboarding_started = rt.new_bool(true)
	}
	return rt.create_array([rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'supported', val: var_onboarding_supported }, rt.ArrayItem{ key: 'started', val: var_onboarding_started }, rt.ArrayItem{ key: 'completed', val: rt.call_method(this.provider, 'is_onboarding_completed', [var_gateway.clone()]) }, rt.ArrayItem{ key: 'test_mode', val: rt.call_method(this.provider, 'is_in_test_mode_onboarding', [var_gateway.clone()]) }, rt.ArrayItem{ key: 'dev_mode', val: rt.call_method(this.provider, 'is_in_dev_mode', [var_gateway.clone()]) }]) }, rt.ArrayItem{ key: 'messages', val: rt.create_array([rt.ArrayItem{ key: 'not_supported', val: if rt.is_true(rt.new_bool(!(rt.is_true(var_onboarding_supported)))) { rt.call_method(this.provider, 'get_onboarding_not_supported_message', [var_gateway.clone(), rt.new_string(location)]) } else { rt.new_null() } }]) }, rt.ArrayItem{ key: 'steps', val: this.get_onboarding_steps(location, (rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + 'step', mut var_source_mutated) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'urls', val: rt.create_array([rt.ArrayItem{ key: 'overview_page', val: this.get_overview_page_url() }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_valid_onboarding_step_id(step_id string) bool {
	return (rt.call_function('in_array', [rt.new_string(step_id), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification() }]), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_step_status(step_id string, location string) string {
	if !(this.is_valid_onboarding_step_id(step_id)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(rt.new_string('woocommerce_woopayments_onboarding_invalid_step_id'), rt.call_function('esc_html__', [rt.new_string('Invalid onboarding step ID.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.bad_request()).to_i64()))))
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
		if rt.is_true(var_meets_requirements) && this.was_onboarding_step_marked_completed(step_id, location) && !(this.has_test_account() && !(this.has_valid_account())) {
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
		}
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification())) {
		if rt.is_true(var_meets_requirements) && this.was_onboarding_step_marked_completed(step_id, location) && this.has_valid_account() && this.has_live_account() || this.has_sandbox_account() {
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed()).str()
		}
	} else {
		if rt.is_true(var_meets_requirements) && this.was_onboarding_step_marked_completed(step_id, location) {
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
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account(), rt.new_string(step_id))) && !(this.has_account()) {
			mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
			mut var_started_timestamp := rt.new_int(if !(!rt.is_true(var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started()))) { rt.new_int((var_statuses.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_started())).to_i64()) } else { 0 })
			if rt.is_true(var_started_timestamp) && rt.is_true(rt.greater(rt.sub(rt.call_method(this.proxy, 'call_function', [rt.new_string('time')]), var_started_timestamp), rt.new_int(60))) {
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
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(rt.new_string('woocommerce_woopayments_onboarding_invalid_step_id'), rt.call_function('esc_html__', [rt.new_string('Invalid onboarding step ID.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.bad_request()).to_i64()))))
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
		this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_step_failed', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'step_id', val: step_id }, rt.ArrayItem{ key: 'error_code', val: if !(!rt.is_true(var_error_mutated.array_get(rt.new_string('code')))) { var_error_mutated.array_get(rt.new_string('code')) } else { rt.new_string('') } }])))
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
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	var_statuses.array_set(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked(), rt.call_method(this.proxy, 'call_function', [rt.new_string('time')]))
	var_statuses.array_unset(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed())
	return this.save_nox_profile_onboarding_step_entry(step_id, location, 'statuses', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_statuses))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) clear_onboarding_step_blocked(step_id string, location string) bool {
	if !(this.is_onboarding_step_blocked(step_id, location)) {
		return false
	}
	this.save_nox_profile_onboarding_step_data_entry(step_id, location, 'error', rt.new_array())
	mut var_statuses := rt.cast_array(this.get_nox_profile_onboarding_step_entry(step_id, location, 'statuses', rt.new_null()))
	var_statuses.array_unset(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked())
	return this.save_nox_profile_onboarding_step_entry(step_id, location, 'statuses', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_statuses))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_step_error(step_id string, location string) rt.PhpVal {
	return rt.cast_array(this.get_nox_profile_onboarding_step_data_entry(step_id, location, 'error', (rt.new_array()).to_bool()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) sanitize_onboarding_step_error(mut var_error Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) rt.PhpVal {
	mut var_error_mutated := var_error
	mut var_sanitized_error := rt.create_array([rt.ArrayItem{ key: 'code', val: if var_error_mutated.array_isset(rt.new_string('code')) { rt.call_function('sanitize_text_field', [var_error_mutated.array_get(rt.new_string('code'))]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'message', val: if var_error_mutated.array_isset(rt.new_string('message')) { rt.call_function('sanitize_text_field', [var_error_mutated.array_get(rt.new_string('message'))]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'context', val: rt.new_array() }])
	mut var_reserved_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'code' }, rt.ArrayItem{ key: none, val: 'message' }, rt.ArrayItem{ key: none, val: 'context' }])
	mut iter_1 := var_error_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_key.clone(), var_reserved_keys.clone(), rt.new_bool(true)]))))) {
			var_sanitized_error.array_get_mut('context').array_set(var_key, var_value.clone())
		}
	}
	if var_error_mutated.array_isset(rt.new_string('context')) && var_error_mutated.array_get(rt.new_string('context')).is_array() || var_error_mutated.array_get(rt.new_string('context')).is_object() {
		mut var_existing_context := rt.call_function('json_decode', [rt.call_function('wp_json_encode', [var_error_mutated.array_get(rt.new_string('context'))]), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(var_existing_context.clone().is_array())) {
			var_sanitized_error.array_set('context', rt.call_function('array_merge', [var_sanitized_error.array_get(rt.new_string('context')), var_existing_context.clone()]))
		}
	}
	if var_sanitized_error.array_get(rt.new_string('context')).array_isset(rt.new_string('context')) && var_sanitized_error.array_get(rt.new_string('context')).array_get(rt.new_string('context')).is_array() {
		mut var_nested_context := var_sanitized_error.array_get(rt.new_string('context')).array_get(rt.new_string('context'))
		var_sanitized_error.array_get(rt.new_string('context')).array_unset(rt.new_string('context'))
		var_sanitized_error.array_set('context', rt.call_function('array_merge', [var_sanitized_error.array_get(rt.new_string('context')), var_nested_context.clone()]))
	}
	if !(!rt.is_true(var_sanitized_error.array_get(rt.new_string('context')))) {
		mut iter_2 := var_sanitized_error.array_get(rt.new_string('context')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
				var_sanitized_error.array_get_mut('context').array_set(var_key, rt.call_function('sanitize_text_field', [var_value.clone()]))
			} else if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
				closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					if rt.is_true(rt.new_bool(var_item.clone().is_string())) {
						return rt.call_function('sanitize_text_field', [var_item.clone()])
					} else if rt.is_true(rt.call_function('is_scalar', [var_item.clone()])) {
						return rt.call_function('sanitize_text_field', [rt.new_string((var_item).str())])
					} else {
						return rt.new_string('')
					}
					return rt.new_null()
					}
				closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					if rt.is_true(rt.new_bool(var_item.clone().is_string())) {
						return rt.call_function('sanitize_text_field', [var_item.clone()])
					} else if rt.is_true(rt.call_function('is_scalar', [var_item.clone()])) {
						return rt.call_function('sanitize_text_field', [rt.new_string((var_item).str())])
					} else {
						return rt.new_string('')
					}
					return rt.new_null()
					}
				var_sanitized_error.array_get_mut('context').array_set(var_key, rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_value.clone()]))
				closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_item)))
					}
				var_sanitized_error.array_get_mut('context').array_set(var_key, rt.call_function('array_filter', [var_sanitized_error.array_get(rt.new_string('context')).array_get(var_key), rt.new_closure(closure_3_fn)]))
			} else {
				var_sanitized_error.array_get(rt.new_string('context')).array_unset(var_key)
			}
		}
	}
	return var_sanitized_error.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_step_save(step_id string, location string, mut var_request_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	this.check_if_onboarding_step_action_is_acceptable(step_id, location)
	if !(this.is_valid_onboarding_step_data(step_id, mut var_request_data)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(rt.new_string('woocommerce_woopayments_onboarding_invalid_step_data'), rt.call_function('esc_html__', [rt.new_string('Invalid onboarding step data.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.bad_request()).to_i64()))))
	}
	mut var_step_details := this.get_nox_profile_onboarding_step(step_id, location)
	if !rt.is_true(var_step_details.array_get(rt.new_string('data'))) {
		var_step_details.array_set('data', rt.new_array())
	}
	mut switch_val_3 := rt.new_string(step_id)
	if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods())) {
		if var_request_data.array_isset(rt.new_string('payment_methods')) {
			var_step_details.array_get_mut('data').array_set('payment_methods', var_request_data.array_get(rt.new_string('payment_methods')))
		}
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification())) {
		if var_request_data.array_isset(rt.new_string('self_assessment')) {
			var_step_details.array_get_mut('data').array_set('self_assessment', var_request_data.array_get(rt.new_string('self_assessment')))
		}
		if var_request_data.array_isset(rt.new_string('sub_steps')) {
			var_step_details.array_get_mut('data').array_set('sub_steps', var_request_data.array_get(rt.new_string('sub_steps')))
		}
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_step_action_not_supported'), rt.call_function('esc_html__', [rt.new_string('Save action not supported for the onboarding step ID.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.not_acceptable()).to_i64()))))
	}
	return this.save_nox_profile_onboarding_step(step_id, location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_step_details))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_valid_onboarding_step_data(step_id string, mut var_request_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	mut switch_val_4 := rt.new_string(step_id)
	if rt.is_true(rt.equal(switch_val_4, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods())) {
		if !(var_request_data.array_isset(rt.new_string('payment_methods'))) {
			return false
		}
		if !(var_request_data.array_get(rt.new_string('payment_methods')).is_array()) {
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_4, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification())) {
		if !(var_request_data.array_isset(rt.new_string('self_assessment'))) && !(var_request_data.array_isset(rt.new_string('sub_steps'))) {
			return false
		}
		if var_request_data.array_isset(rt.new_string('self_assessment')) && !(var_request_data.array_get(rt.new_string('self_assessment')).is_array()) {
			return false
		}
		if var_request_data.array_isset(rt.new_string('sub_steps')) && !(var_request_data.array_get(rt.new_string('sub_steps')).is_array()) {
			return false
		}
	} else {
		return true
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_step_check(step_id string, location string) rt.PhpVal {
	this.check_if_onboarding_step_action_is_acceptable(step_id, location)
	return rt.create_array([rt.ArrayItem{ key: 'status', val: this.get_onboarding_step_status(step_id, location) }, rt.ArrayItem{ key: 'error', val: this.get_onboarding_step_error(step_id, location) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_recommended_payment_methods(location string) rt.PhpVal {
	return rt.call_method(this.provider, 'get_recommended_payment_methods', [this.get_payment_gateway(), rt.new_string(location)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_test_account_init(location string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
	this.check_if_onboarding_step_action_is_acceptable((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location)
	if this.has_test_account() {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_test_account_already_exists'), rt.call_function('esc_html__', [rt.new_string('A test account is already set up.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.forbidden()).to_i64()))))
	}
	if this.has_account() {
		this.mark_onboarding_step_completed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location, false, rt.new_null())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_action_error'), rt.call_function('esc_html__', [rt.new_string('An account is already set up. Reset the onboarding first.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.forbidden()).to_i64()))))
	}
	this.clear_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location)
	mut var_configured_payment_methods := this.get_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods()).str(), location, 'payment_methods', (rt.new_array()).to_bool())
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
	this.set_onboarding_lock()
	mut var_response := rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('rest_endpoint_post_request'), rt.new_string('/wc/v3/payments/onboarding/test_drive_account/init'), rt.create_array([rt.ArrayItem{ key: 'country', val: location }, rt.ArrayItem{ key: 'capabilities', val: var_configured_payment_methods }, rt.ArrayItem{ key: 'source', val: var_source_mutated }, rt.ArrayItem{ key: 'from', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_nox_in_context() }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		var_response = create_wp_error(rt.new_string('woocommerce_woopayments_onboarding_client_api_exception'), rt.call_function('esc_html__', [rt.new_string('An unexpected error happened while initializing the test account.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'trace', val: rt.call_method(var_e, 'getTrace', []rt.PhpVal{}) }]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	this.clear_onboarding_lock()
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		this.mark_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_response, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'context', val: rt.call_method(var_response, 'get_error_data', []rt.PhpVal{}) }])))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()), rt.call_function('map_deep', [rt.cast_array(rt.call_method(var_response, 'get_error_data', []rt.PhpVal{})), rt.new_string('esc_html')]))))
	}
	if !(var_response.clone().is_array()) || !rt.is_true(var_response.array_get(rt.new_string('success'))) {
		this.mark_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'code', val: 'malformed_response' }, rt.ArrayItem{ key: 'message', val: rt.call_function('esc_html__', [rt.new_string('Received an unexpected response from the platform.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'response', val: var_response }]) }])))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html__', [rt.new_string('Failed to initialize the test account.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()))))
	}
	mut var_payment_methods_enabled := rt.new_array()
	mut var_payment_methods_disabled := rt.new_array()
	if !(!rt.is_true(var_configured_payment_methods)) && var_configured_payment_methods.clone().is_array() {
		mut iter_3 := var_configured_payment_methods.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_enabled := item_3.val
			mut var_pm_id := item_3.key
			if !(var_pm_id.clone().is_string()) || !(var_enabled.clone().is_bool()) {
				continue
			}
			if rt.is_true(var_enabled) {
				var_payment_methods_enabled.array_push(rt.call_function('sanitize_key', [var_pm_id.clone()]))
			} else {
				var_payment_methods_disabled.array_push(rt.call_function('sanitize_key', [var_pm_id.clone()]))
			}
		}
	}
	var_payment_methods_enabled = rt.call_function('array_unique', [var_payment_methods_enabled.clone()])
	var_payment_methods_disabled = rt.call_function('array_unique', [var_payment_methods_disabled.clone()])
	mut var_event_props := rt.create_array([rt.ArrayItem{ key: 'payment_methods_enabled', val: rt.call_function('implode', [rt.new_string(', '), var_payment_methods_enabled.clone()]) }, rt.ArrayItem{ key: 'payment_methods_disabled', val: rt.call_function('implode', [rt.new_string(', '), var_payment_methods_disabled.clone()]) }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])
	this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_test_account_init', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_event_props))
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_kyc_session(location string, mut var_self_assessment Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_self_assessment_mutated := var_self_assessment
	mut var_source_mutated := var_source
	this.check_if_onboarding_step_action_is_acceptable((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location)
	if !rt.is_true(var_self_assessment_mutated) {
	var_self_assessment_mutated = rt.cast_array(this.get_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, 'self_assessment', false))
	}
	this.clear_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location)
	mut var_selected_payment_methods := this.get_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods()).str(), location, 'payment_methods', (rt.new_array()).to_bool())
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
	this.set_onboarding_lock()
	mut var_response := rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('rest_endpoint_post_request'), rt.new_string('/wc/v3/payments/onboarding/kyc/session'), rt.create_array([rt.ArrayItem{ key: 'self_assessment', val: var_self_assessment_mutated }, rt.ArrayItem{ key: 'capabilities', val: var_selected_payment_methods }])])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		var_response = create_wp_error(rt.new_string('woocommerce_woopayments_onboarding_client_api_exception'), rt.call_function('esc_html__', [rt.new_string('An unexpected error happened while creating the KYC session.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'trace', val: rt.call_method(var_e, 'getTrace', []rt.PhpVal{}) }]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	this.clear_onboarding_lock()
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		this.mark_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_response, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'context', val: rt.call_method(var_response, 'get_error_data', []rt.PhpVal{}) }])))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()), rt.call_function('map_deep', [rt.cast_array(rt.call_method(var_response, 'get_error_data', []rt.PhpVal{})), rt.new_string('esc_html')]))))
	}
	if !(var_response.clone().is_array()) {
		this.mark_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'code', val: 'malformed_response' }, rt.ArrayItem{ key: 'message', val: rt.call_function('esc_html__', [rt.new_string('Received an unexpected response from the platform.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'response', val: var_response }]) }])))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html__', [rt.new_string('Failed to get the KYC session data.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()))))
	}
	var_response.array_set('locale', rt.call_method(this.proxy, 'call_function', [rt.new_string('get_user_locale')]))
	this.mark_onboarding_step_completed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location, false, mut var_source_mutated)
	mut var_event_props := rt.create_array([rt.ArrayItem{ key: 'new_account_created', val: if !(var_response.array_get(rt.new_string('accountCreated'))).is_null() { var_response.array_get(rt.new_string('accountCreated')) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'account_mode', val: if rt.is_true(if !(var_response.array_get(rt.new_string('isLive'))).is_null() { var_response.array_get(rt.new_string('isLive')) } else { rt.new_bool(false) }) { 'live' } else { 'test' } }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])
	this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_kyc_session_created', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_event_props))
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) finish_onboarding_kyc_session(location string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
	this.check_if_onboarding_step_action_is_acceptable((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location)
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
	this.set_onboarding_lock()
	mut var_response := rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('rest_endpoint_post_request'), rt.new_string('/wc/v3/payments/onboarding/kyc/finalize'), rt.create_array([rt.ArrayItem{ key: 'source', val: var_source_mutated }, rt.ArrayItem{ key: 'from', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_nox_in_context() }])])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		var_response = create_wp_error(rt.new_string('woocommerce_woopayments_onboarding_client_api_exception'), rt.call_function('esc_html__', [rt.new_string('An unexpected error happened while finalizing the KYC session.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'trace', val: rt.call_method(var_e, 'getTrace', []rt.PhpVal{}) }]))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	this.clear_onboarding_lock()
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		this.mark_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_response, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'context', val: rt.call_method(var_response, 'get_error_data', []rt.PhpVal{}) }])))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()), rt.call_function('map_deep', [rt.cast_array(rt.call_method(var_response, 'get_error_data', []rt.PhpVal{})), rt.new_string('esc_html')]))))
	}
	if !(var_response.clone().is_array()) {
		this.mark_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'code', val: 'malformed_response' }, rt.ArrayItem{ key: 'message', val: rt.call_function('esc_html__', [rt.new_string('Received an unexpected response from the platform.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'response', val: var_response }]) }])))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html__', [rt.new_string('Failed to finish the KYC session.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()))))
	}
	this.mark_onboarding_step_completed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location, false, mut var_source_mutated)
	mut var_event_props := rt.create_array([rt.ArrayItem{ key: 'successful_kyc', val: if !(rt.call_function('filter_var', [if !(var_response.array_get(rt.new_string('success'))).is_null() { var_response.array_get(rt.new_string('success')) } else { rt.new_bool(false) }, rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])).is_null() { rt.call_function('filter_var', [if !(var_response.array_get(rt.new_string('success'))).is_null() { var_response.array_get(rt.new_string('success')) } else { rt.new_bool(false) }, rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')]) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'account_mode', val: if rt.is_true(rt.identical(rt.new_string('live'), if !(var_response.array_get(rt.new_string('mode'))).is_null() { var_response.array_get(rt.new_string('mode')) } else { rt.new_bool(false) })) { 'live' } else { 'test' } }, rt.ArrayItem{ key: 'details_submitted', val: if !(rt.call_function('filter_var', [if !(var_response.array_get(rt.new_string('details_submitted'))).is_null() { var_response.array_get(rt.new_string('details_submitted')) } else { rt.new_bool(false) }, rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])).is_null() { rt.call_function('filter_var', [if !(var_response.array_get(rt.new_string('details_submitted'))).is_null() { var_response.array_get(rt.new_string('details_submitted')) } else { rt.new_bool(false) }, rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')]) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'promotion_id', val: if !(var_response.array_get(rt.new_string('promotion_id'))).is_null() { var_response.array_get(rt.new_string('promotion_id')) } else { rt.new_string('none') } }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])
	this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_kyc_session_finished', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_event_props))
	this.mark_onboarding_step_completed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, false, mut var_source_mutated)
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) onboarding_preload() rt.PhpVal {
	if this.is_onboarding_locked() {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_locked'), rt.call_function('esc_html__', [rt.new_string('Another onboarding action is already in progress. Please wait for it to finish.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.conflict()).to_i64()))))
	}
	mut var_result := rt.new_bool(true)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.wpcom_connection_manager, 'is_connected', []rt.PhpVal{}))))) {
		var_result = rt.call_method(this.wpcom_connection_manager, 'try_registration', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_action_error'), rt.call_function('esc_html', [rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})]), rt.new_int((Class_WP_Http.internal_server_error()).to_i64()), rt.call_function('map_deep', [rt.cast_array(rt.call_method(var_result, 'get_error_data', []rt.PhpVal{})), rt.new_string('esc_html')]))))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'success', val: var_result }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) reset_onboarding(location string, from string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
	this.check_if_onboarding_action_is_acceptable()
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	mut var_event_props := rt.new_array()
	var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
	this.set_onboarding_lock()
	var_event_props = rt.create_array([rt.ArrayItem{ key: 'has_account', val: this.has_account() }, rt.ArrayItem{ key: 'account_mode', val: if this.has_account() { if this.has_live_account() { 'live' } else { 'test' } } else { 'none' } }, rt.ArrayItem{ key: 'test_account', val: this.has_test_account() }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if this.has_account() {
		mut var_response := rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('rest_endpoint_post_request'), rt.new_string('/wc/v3/payments/onboarding/reset'), rt.create_array([rt.ArrayItem{ key: 'from', val: if !(from == '') { rt.call_function('esc_attr', [rt.new_string(from)]) } else { Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_payment_settings() } }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	} else {
		var_response = rt.create_array([rt.ArrayItem{ key: 'success', val: true }])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		var_response = create_wp_error(rt.new_string('woocommerce_woopayments_onboarding_client_api_exception'), rt.call_function('esc_html__', [rt.new_string('An unexpected error happened while resetting onboarding.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'trace', val: rt.call_method(var_e, 'getTrace', []rt.PhpVal{}) }]))
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	this.clear_onboarding_lock()
	rt.call_method(this.proxy, 'call_function', [rt.new_string('delete_option'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_profile_option_key()])
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Payments_Onboarding_Service')])) && rt.is_true(rt.call_function('defined', [rt.new_string('WC_Payments_Onboarding_Service::TEST_MODE_OPTION')])) {
		mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_3 := iife_temp_3.get_constant(rt.new_string('WC_Payments_Onboarding_Service::TEST_MODE_OPTION'))
		rt.call_method(this.proxy, 'call_function', [rt.new_string('update_option'), iife_result_3, rt.new_string('no')])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()), rt.call_function('map_deep', [rt.cast_array(rt.call_method(var_response, 'get_error_data', []rt.PhpVal{})), rt.new_string('esc_html')]))))
	}
	if !(var_response.clone().is_array()) || !rt.is_true(var_response.array_get(rt.new_string('success'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html__', [rt.new_string('Failed to reset onboarding.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()))))
	}
	this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_reset', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_event_props))
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) disable_test_account(location string, from string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
	this.check_if_onboarding_action_is_acceptable()
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'success', val: true }])
	mut var_event_props := rt.new_array()
	var_source_mutated = rt.new_string(this.validate_onboarding_source(mut var_source_mutated))
	this.set_onboarding_lock()
	mut var_has_test_account := rt.new_bool(this.has_test_account())
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_has_sandbox_account := rt.new_bool(this.has_sandbox_account())
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	var_event_props = rt.create_array([rt.ArrayItem{ key: 'account_type', val: if rt.is_true(var_has_test_account) { 'test_drive' } else { if rt.is_true(var_has_sandbox_account) { 'sandbox' } else { 'unknown' } } }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(var_has_test_account) {
		var_response = rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('rest_endpoint_post_request'), rt.new_string('/wc/v3/payments/onboarding/test_drive_account/disable'), rt.create_array([rt.ArrayItem{ key: 'from', val: if !(from == '') { rt.call_function('esc_attr', [rt.new_string(from)]) } else { Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_payment_settings() } }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])])
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	} else if rt.is_true(var_has_sandbox_account) {
		var_response = rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('rest_endpoint_post_request'), rt.new_string('/wc/v3/payments/onboarding/reset'), rt.create_array([rt.ArrayItem{ key: 'from', val: if !(from == '') { rt.call_function('esc_attr', [rt.new_string(from)]) } else { Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_payment_settings() } }, rt.ArrayItem{ key: 'source', val: var_source_mutated }])])
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_e := var_e_5.clone()
		var_response = create_wp_error(rt.new_string('woocommerce_woopayments_onboarding_client_api_exception'), rt.call_function('esc_html__', [rt.new_string('An unexpected error happened while disabling the test account.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'trace', val: rt.call_method(var_e, 'getTrace', []rt.PhpVal{}) }]))
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	this.clear_onboarding_lock()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Payments_Onboarding_Service')])) && rt.is_true(rt.call_function('defined', [rt.new_string('WC_Payments_Onboarding_Service::TEST_MODE_OPTION')])) {
		mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_4 := iife_temp_4.get_constant(rt.new_string('WC_Payments_Onboarding_Service::TEST_MODE_OPTION'))
		rt.call_method(this.proxy, 'call_function', [rt.new_string('update_option'), iife_result_4, rt.new_string('no')])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) || !(var_response.clone().is_array()) || !rt.is_true(var_response.array_get(rt.new_string('success'))) {
		this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_test_account_disable_error', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'source', val: var_source_mutated }])))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()), rt.call_function('map_deep', [rt.cast_array(rt.call_method(var_response, 'get_error_data', []rt.PhpVal{})), rt.new_string('esc_html')]))))
	}
	if !(var_response.clone().is_array()) || !rt.is_true(var_response.array_get(rt.new_string('success'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_client_api_error'), rt.call_function('esc_html__', [rt.new_string('Failed to disable the test account.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.failed_dependency()).to_i64()))))
	}
	this.mark_onboarding_step_completed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods()).str(), location, false, rt.new_null())
	this.mark_onboarding_step_completed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location, false, rt.new_null())
	this.clear_onboarding_step_blocked((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location)
	this.clear_onboarding_step_failed((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str(), location)
	mut var_business_verification_sub_step_data := this.get_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, 'sub_steps', (rt.new_array()).to_bool())
	if !(!rt.is_true(var_business_verification_sub_step_data)) {
		this.save_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, 'sub_steps', rt.new_array())
	}
	this.record_event((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + 'onboarding_test_account_disabled', location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_event_props))
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) record_event(name string, business_country string, mut var_properties Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) {
	mut name_mutated := name
	mut var_properties_mutated := var_properties
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_admin_record_tracks_event')]))))) {
		return
	}
	if name_mutated == '' {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [rt.new_string(name_mutated).clone(), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()]))))) {
	name_mutated = (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.event_prefix()).str() + name_mutated
	}
	var_properties_mutated = rt.call_function('array_merge', [var_properties_mutated, rt.create_array([rt.ArrayItem{ key: 'business_country', val: business_country }])])
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string(name_mutated).clone(), var_properties_mutated])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) check_if_onboarding_action_is_acceptable() {
	if !(this.is_extension_active()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_extension_not_active'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The %s extension is not active.'), rt.new_string('woocommerce')]), rt.new_string('WooPayments')]), rt.new_int((Class_WP_Http.forbidden()).to_i64()))))
	}
	mut iife_temp_5 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_5 := iife_temp_5.is_defined(rt.new_string('WCPAY_VERSION_NUMBER'))
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.get_constant(rt.new_string('WCPAY_VERSION_NUMBER'))
	mut iife_temp_7 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_7 := iife_temp_7.get_constant(rt.new_string('WCPAY_VERSION_NUMBER'))
	if rt.is_true(iife_result_5) && rt.is_true(rt.call_function('version_compare', [iife_result_6, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.extension_minimum_version(), rt.new_string('<')])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_extension_version'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The %s extension is not up-to-date. Please update to the latest version and try again.'), rt.new_string('woocommerce')]), rt.new_string('WooPayments')]), rt.new_int((Class_WP_Http.forbidden()).to_i64()))))
	}
	if this.is_onboarding_locked() {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_locked'), rt.call_function('esc_html__', [rt.new_string('Another onboarding action is already in progress. Please wait for it to finish.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.conflict()).to_i64()))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) check_if_onboarding_step_action_is_acceptable(step_id string, location string) {
	this.check_if_onboarding_action_is_acceptable()
	if !(this.is_valid_onboarding_step_id(step_id)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(rt.new_string('woocommerce_woopayments_onboarding_invalid_step_id'), rt.call_function('esc_html__', [rt.new_string('Invalid onboarding step ID.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.bad_request()).to_i64()))))
	}
	if !(this.check_onboarding_step_requirements(step_id, location)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_step_requirements_not_met'), rt.call_function('esc_html__', [rt.new_string('Onboarding step requirements are not met.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.forbidden()).to_i64()))))
	}
	if this.is_onboarding_step_blocked(step_id, location) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException', []string{}, create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(rt.new_string('woocommerce_woopayments_onboarding_step_blocked'), rt.call_function('esc_html__', [rt.new_string('There are environment or store setup issues which are blocking progress. Please resolve them to proceed.'), rt.new_string('woocommerce')]), rt.new_int((Class_WP_Http.forbidden()).to_i64()), rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_function('map_deep', [this.get_onboarding_step_error(step_id, location), rt.new_string('esc_html')]) }]))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_onboarding_locked() bool {
	mut var_lock_timestamp := rt.new_int((rt.call_method(this.proxy, 'call_function', [rt.new_string('absint'), rt.call_method(this.proxy, 'call_function', [rt.new_string('get_option'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_onboarding_locked_key(), rt.new_int(0)])])).to_i64())
	if rt.is_true(rt.identical(rt.new_int(0), var_lock_timestamp)) {
		return false
	}
	mut var_now := rt.call_method(this.proxy, 'call_function', [rt.new_string('time')])
	if rt.is_true(rt.less(var_lock_timestamp, rt.sub(var_now, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_onboarding_locked_ttl_seconds()))) {
		this.clear_onboarding_lock()
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) set_onboarding_lock() {
	mut var_now := rt.call_method(this.proxy, 'call_function', [rt.new_string('time')])
	rt.call_method(this.proxy, 'call_function', [rt.new_string('update_option'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_onboarding_locked_key(), var_now.clone(), rt.new_bool(false)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) clear_onboarding_lock() {
	rt.call_method(this.proxy, 'call_function', [rt.new_string('update_option'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_onboarding_locked_key(), rt.new_int(0), rt.new_bool(false)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_steps(location string, rest_path string, mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) rt.PhpVal {
	mut var_source_mutated := var_source
	mut var_steps := rt.new_array()
	mut var_recommended_pms := this.get_onboarding_recommended_payment_methods(location)
	if !(!rt.is_true(var_recommended_pms)) {
		var_steps.array_push(this.standardize_onboarding_step_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'recommended_pms', val: var_recommended_pms }, rt.ArrayItem{ key: 'pms_state', val: this.get_onboarding_payment_methods_state(location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?array](var_recommended_pms)) }]) }, rt.ArrayItem{ key: 'actions', val: rt.create_array([rt.ArrayItem{ key: 'start', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods()).str() + '/start')]) }]) }, rt.ArrayItem{ key: 'save', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods()).str() + '/save')]) }]) }, rt.ArrayItem{ key: 'finish', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods()).str() + '/finish')]) }]) }]) }])), location, rest_path))
	}
	mut var_wpcom_step := this.standardize_onboarding_step_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'connection_state', val: this.get_wpcom_connection_state() }]) }])), location, rest_path)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed(), var_wpcom_step.array_get(rt.new_string('status')))))) {
		mut switch_val_5 := var_source_mutated
		if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_lys())) {
		mut var_return_url := rt.call_method(this.proxy, 'call_function', [rt.new_string('admin_url'), rt.new_string('admin.php?page=wc-admin&path=/launch-your-store' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_path_base()).str() + '&sidebar=hub&content=payments')])
		} else {
		var_return_url = rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('wc_payments_settings_url'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_path_base()])
		}
		var_return_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.wpcom_connection_return_param(), val: '1' }, rt.ArrayItem{ key: 'source', val: var_source_mutated }, rt.ArrayItem{ key: 'from', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_wpcom() }]), var_return_url.clone()])
		mut var_wpcom_connection := this.get_wpcom_connection_authorization((var_return_url).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_wpcom_connection.array_get(rt.new_string('success')))))) {
			var_wpcom_step.array_set('errors', rt.call_function('array_values', [rt.cast_array(if !(var_wpcom_connection.array_get(rt.new_string('errors'))).is_null() { var_wpcom_connection.array_get(rt.new_string('errors')) } else { rt.new_array() })]))
		}
		var_wpcom_step.array_set('actions', rt.create_array([rt.ArrayItem{ key: 'start', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection()).str() + '/start')]) }]) }, rt.ArrayItem{ key: 'auth', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_redirect() }, rt.ArrayItem{ key: 'href', val: var_wpcom_connection.array_get(rt.new_string('url')) }]) }]))
	}
	var_steps.array_push(var_wpcom_step.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(location), rt.create_array([rt.ArrayItem{ key: none, val: 'AE' }, rt.ArrayItem{ key: none, val: 'SG' }]), rt.new_bool(true)]))))) {
		mut var_test_account_step := this.standardize_onboarding_step_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account() }])), location, rest_path)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed(), var_test_account_step.array_get(rt.new_string('status')))))) {
			var_test_account_step.array_set('actions', rt.create_array([rt.ArrayItem{ key: 'start', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/start')]) }]) }, rt.ArrayItem{ key: 'init', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/init')]) }]) }, rt.ArrayItem{ key: 'finish', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/finish')]) }]) }]))
		}
		var_test_account_step.array_get_mut('actions').array_set('reset', rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account()).str() + '/reset')]) }]))
		var_steps.array_push(var_test_account_step.clone())
	}
	mut var_business_verification_step_sub_steps := this.get_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, 'sub_steps', (rt.new_array()).to_bool())
	if !(this.has_account()) {
	var_business_verification_step_sub_steps = rt.new_array()
	}
	mut var_business_verification_step := this.standardize_onboarding_step_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: 'fields', val: rt.new_array() }, rt.ArrayItem{ key: 'sub_steps', val: var_business_verification_step_sub_steps }, rt.ArrayItem{ key: 'self_assessment', val: this.get_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location, 'self_assessment', (rt.new_array()).to_bool()) }, rt.ArrayItem{ key: 'has_test_account', val: this.has_test_account() }, rt.ArrayItem{ key: 'has_sandbox_account', val: this.has_sandbox_account() }]) }])), location, rest_path)
	if this.check_onboarding_step_requirements((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str(), location) {
		var_business_verification_step.array_get_mut('context').array_set('fields', this.get_onboarding_kyc_fields(location))
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		unsafe { goto end_label_6 }

catch_label_6:
		mut var_e_6 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_6, 'Exception') {
			mut var_e := var_e_6.clone()
			var_business_verification_step.array_get_mut('errors').array_push(rt.create_array([rt.ArrayItem{ key: 'code', val: 'fields_error' }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }]))
			unsafe { goto end_label_6 }
		}
		else {
			rt.throw_exception(var_e_6)
			unsafe { goto end_label_6 }
		}

end_label_6:
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed(), var_business_verification_step.array_get(rt.new_string('status')))))) {
		var_business_verification_step.array_set('actions', rt.create_array([rt.ArrayItem{ key: 'start', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/start')]) }]) }, rt.ArrayItem{ key: 'save', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/save')]) }]) }, rt.ArrayItem{ key: 'kyc_session', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/kyc_session')]) }]) }, rt.ArrayItem{ key: 'kyc_session_finish', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/kyc_session/finish')]) }]) }, rt.ArrayItem{ key: 'kyc_fallback', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_redirect() }, rt.ArrayItem{ key: 'href', val: this.get_onboarding_kyc_fallback_url() }]) }, rt.ArrayItem{ key: 'finish', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/finish')]) }]) }, rt.ArrayItem{ key: 'test_account_disable', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification()).str() + '/test_account/disable')]) }]) }]))
	}
	var_steps.array_push(var_business_verification_step.clone())
	return this.standardize_onboarding_steps_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_steps), location, rest_path)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) standardize_onboarding_step_details(mut var_step_details Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array, location string, rest_path string) rt.PhpVal {
	mut var_step_details_mutated := var_step_details
	if !(var_step_details_mutated.array_isset(rt.new_string('id'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The onboarding step is missing required entries: %s'), rt.new_string('woocommerce')]), rt.new_string('id')]))))
	}
	if !(this.is_valid_onboarding_step_id((var_step_details_mutated.array_get(rt.new_string('id'))).str())) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The onboarding step ID is invalid: %s'), rt.new_string('woocommerce')]), rt.call_function('esc_attr', [var_step_details_mutated.array_get(rt.new_string('id'))])]))))
	}
	if !rt.is_true(var_step_details_mutated.array_get(rt.new_string('status'))) {
		var_step_details_mutated.array_set('status', this.get_onboarding_step_status((var_step_details_mutated.array_get(rt.new_string('id'))).str(), location))
	}
	if !rt.is_true(var_step_details_mutated.array_get(rt.new_string('errors'))) {
		var_step_details_mutated.array_set('errors', rt.new_array())
		if rt.is_true(rt.call_function('in_array', [var_step_details_mutated.array_get(rt.new_string('status')), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_blocked() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_failed() }]), rt.new_bool(true)])) {
			mut var_stored_error := this.get_onboarding_step_error((var_step_details_mutated.array_get(rt.new_string('id'))).str(), location)
			if !(!rt.is_true(var_stored_error)) {
				var_step_details_mutated.array_set('errors', rt.create_array([rt.ArrayItem{ key: none, val: var_stored_error }]))
			}
		}
	}
	mut var_standardized_errors := rt.new_array()
	if !(var_step_details_mutated.array_get(rt.new_string('errors')).is_array()) || rt.is_true(rt.new_bool(var_step_details_mutated.array_get(rt.new_string('errors')).array_isset(rt.new_string('code')))) || rt.is_true(rt.new_bool(var_step_details_mutated.array_get(rt.new_string('errors')).array_isset(rt.new_string('message')))) || rt.is_true(rt.new_bool(var_step_details_mutated.array_get(rt.new_string('errors')).array_isset(rt.new_string('context')))) {
	mut var_raw_errors := rt.create_array([rt.ArrayItem{ key: none, val: var_step_details_mutated.array_get(rt.new_string('errors')) }])
	} else {
	var_raw_errors = var_step_details_mutated.array_get(rt.new_string('errors'))
	}
	mut iter_4 := var_raw_errors.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_error := item_4.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'WP_Error'))) {
		var_error = rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_error, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_error, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'context', val: rt.call_method(var_error, 'get_error_data', []rt.PhpVal{}) }])
		} else if rt.is_true(rt.new_bool(var_error.clone().is_array())) {
			if !rt.is_true(var_error.array_get(rt.new_string('code'))) {
				var_error.array_set('code', 'general_error')
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_error.clone().array_isset(rt.new_string('message'))))))) {
				var_error.array_set('message', '')
			}
		} else {
		var_error = rt.create_array([rt.ArrayItem{ key: 'code', val: 'general_error' }, rt.ArrayItem{ key: 'message', val: (var_error).str() }])
		}
		var_standardized_errors.array_push(this.sanitize_onboarding_step_error(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_error)))
	}
	var_step_details_mutated.array_set('errors', var_standardized_errors.clone())
	if !rt.is_true(var_step_details_mutated.array_get(rt.new_string('actions'))) {
		var_step_details_mutated.array_set('actions', rt.new_array())
	}
	if !rt.is_true(var_step_details_mutated.array_get(rt.new_string('actions')).array_get(rt.new_string('check'))) {
		var_step_details_mutated.array_get_mut('actions').array_set('check', rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (var_step_details_mutated.array_get(rt.new_string('id'))).str() + '/check')]) }]))
	}
	if !rt.is_true(var_step_details_mutated.array_get(rt.new_string('actions')).array_get(rt.new_string('clean'))) {
		var_step_details_mutated.array_get_mut('actions').array_set('clean', rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.action_type_rest() }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((rt.call_function('trailingslashit', [rt.new_string(rest_path)])).str() + (var_step_details_mutated.array_get(rt.new_string('id'))).str() + '/clean')]) }]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: var_step_details_mutated.array_get(rt.new_string('id')) }, rt.ArrayItem{ key: 'path', val: if !(var_step_details_mutated.array_get(rt.new_string('path'))).is_null() { var_step_details_mutated.array_get(rt.new_string('path')) } else { (rt.call_function('trailingslashit', [Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_path_base()])).str() + (var_step_details_mutated.array_get(rt.new_string('id'))).str() } }, rt.ArrayItem{ key: 'required_steps', val: if !(var_step_details_mutated.array_get(rt.new_string('required_steps'))).is_null() { var_step_details_mutated.array_get(rt.new_string('required_steps')) } else { this.get_onboarding_step_required_steps((var_step_details_mutated.array_get(rt.new_string('id'))).str()) } }, rt.ArrayItem{ key: 'status', val: var_step_details_mutated.array_get(rt.new_string('status')) }, rt.ArrayItem{ key: 'errors', val: var_step_details_mutated.array_get(rt.new_string('errors')) }, rt.ArrayItem{ key: 'actions', val: var_step_details_mutated.array_get(rt.new_string('actions')) }, rt.ArrayItem{ key: 'context', val: if !(var_step_details_mutated.array_get(rt.new_string('context'))).is_null() { var_step_details_mutated.array_get(rt.new_string('context')) } else { rt.new_array() } }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) standardize_onboarding_steps_details(mut var_steps Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array, location string, rest_path string) rt.PhpVal {
	mut var_steps_mutated := var_steps
	mut var_standardized_steps := rt.new_array()
	mut iter_5 := var_steps_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_step := item_5.val
		var_standardized_steps.array_push(this.standardize_onboarding_step_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_step), location, rest_path))
	}
	return var_standardized_steps.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile() rt.PhpVal {
	mut var_nox_profile := rt.call_method(this.proxy, 'call_function', [rt.new_string('get_option'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_profile_option_key(), rt.new_array()])
	if !rt.is_true(var_nox_profile) {
	var_nox_profile = rt.new_array()
	} else {
	var_nox_profile = rt.call_function('maybe_unserialize', [var_nox_profile.clone()])
	}
	return var_nox_profile.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile(mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	return (rt.call_method(this.proxy, 'call_function', [rt.new_string('update_option'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.nox_profile_option_key(), var_data, rt.new_bool(false)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding(location string) rt.PhpVal {
	mut var_nox_profile := this.get_nox_profile()
	if !rt.is_true(var_nox_profile.array_get(rt.new_string('onboarding'))) {
		var_nox_profile.array_set('onboarding', rt.new_array())
	}
	if !rt.is_true(var_nox_profile.array_get(rt.new_string('onboarding')).array_get(rt.new_string(location))) {
		var_nox_profile.array_get_mut('onboarding').array_set(location, rt.new_array())
	}
	return var_nox_profile.array_get(rt.new_string('onboarding')).array_get(rt.new_string(location))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding(location string, mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	mut var_nox_profile := this.get_nox_profile()
	if !rt.is_true(var_nox_profile.array_get(rt.new_string('onboarding'))) {
		var_nox_profile.array_set('onboarding', rt.new_array())
	}
	var_nox_profile.array_get_mut('onboarding').array_set(location, var_data)
	return this.save_nox_profile(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_nox_profile))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding_step(step_id string, location string) rt.PhpVal {
	mut var_nox_profile_onboarding := this.get_nox_profile_onboarding(location)
	if !rt.is_true(var_nox_profile_onboarding.array_get(rt.new_string('steps'))) {
		var_nox_profile_onboarding.array_set('steps', rt.new_array())
	}
	if !rt.is_true(var_nox_profile_onboarding.array_get(rt.new_string('steps')).array_get(rt.new_string(step_id))) {
		var_nox_profile_onboarding.array_get_mut('steps').array_set(step_id, rt.new_array())
	}
	return var_nox_profile_onboarding.array_get(rt.new_string('steps')).array_get(rt.new_string(step_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding_step(step_id string, location string, mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	mut var_nox_profile_onboarding := this.get_nox_profile_onboarding(location)
	if !rt.is_true(var_nox_profile_onboarding.array_get(rt.new_string('steps'))) {
		var_nox_profile_onboarding.array_set('steps', rt.new_array())
	}
	var_nox_profile_onboarding.array_get_mut('steps').array_set(step_id, var_data)
	return this.save_nox_profile_onboarding(location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_nox_profile_onboarding))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding_step_entry(step_id string, location string, entry string, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_step_details := this.get_nox_profile_onboarding_step(step_id, location)
	if !(var_step_details.array_isset(rt.new_string(entry))) {
		return var_default_value.clone()
	}
	return var_step_details.array_get(rt.new_string(entry))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding_step_entry(step_id string, location string, entry string, mut var_data Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array) bool {
	mut var_step_details := this.get_nox_profile_onboarding_step(step_id, location)
	var_step_details.array_set(entry, var_data)
	return this.save_nox_profile_onboarding_step(step_id, location, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_step_details))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_nox_profile_onboarding_step_data_entry(step_id string, location string, entry string, default_value bool) rt.PhpVal {
	mut var_step_details_data := this.get_nox_profile_onboarding_step_entry(step_id, location, 'data', rt.new_null())
	if !(var_step_details_data.array_isset(rt.new_string(entry))) {
		return rt.new_bool(default_value)
	}
	return var_step_details_data.array_get(rt.new_string(entry))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) save_nox_profile_onboarding_step_data_entry(step_id string, location string, entry string, var_data rt.PhpVal) bool {
	mut var_step_details_data := this.get_nox_profile_onboarding_step_entry(step_id, location, 'data', rt.new_null())
	var_step_details_data.array_set(entry, var_data.clone())
	return this.save_nox_profile_onboarding_step_entry(step_id, location, 'data', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_array](var_step_details_data))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_step_required_steps(step_id string) rt.PhpVal {
	mut switch_val_6 := rt.new_string(step_id)
	if rt.is_true(rt.equal(switch_val_6, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_test_account())) || rt.is_true(rt.equal(switch_val_6, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_business_verification())) {
		return rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_wpcom_connection() }])
	} else {
		return rt.new_array()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) check_onboarding_step_requirements(step_id string, location string) bool {
	mut var_requirements := this.get_onboarding_step_required_steps(step_id)
	mut iter_6 := var_requirements.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_required_step_id := item_6.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.get_onboarding_step_status((var_required_step_id).str(), location), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_status_completed())))) {
			return false
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_payment_methods_state(location string, mut var_recommended_pms Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?array) rt.PhpVal {
	mut var_recommended_pms_mutated := var_recommended_pms
	if rt.is_true(rt.identical(rt.new_null(), var_recommended_pms_mutated)) {
	var_recommended_pms_mutated = this.get_onboarding_recommended_payment_methods(location)
	}
	if !rt.is_true(var_recommended_pms_mutated) {
		return rt.new_array()
	}
	mut var_step_pms_data := rt.cast_array(this.get_nox_profile_onboarding_step_data_entry((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_step_payment_methods()).str(), location, 'payment_methods', false))
	mut var_payment_methods_state := rt.new_array()
	mut var_apple_pay_enabled := rt.new_bool(false)
	mut var_google_pay_enabled := rt.new_bool(false)
	mut iter_7 := var_recommended_pms_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_recommended_pm := item_7.val
		mut var_pm_id := var_recommended_pm.array_get(rt.new_string('id'))
		if rt.is_true(rt.identical(rt.new_string('apple_pay'), var_pm_id)) {
			var_apple_pay_enabled = var_recommended_pm.array_get(rt.new_string('enabled'))
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('google_pay'), var_pm_id)) {
			var_google_pay_enabled = var_recommended_pm.array_get(rt.new_string('enabled'))
			continue
		}
		var_payment_methods_state.array_set(var_pm_id, var_recommended_pm.array_get(rt.new_string('enabled')))
		if rt.is_true(var_recommended_pm.array_get(rt.new_string('required'))) {
			var_payment_methods_state.array_set(var_pm_id, true)
			continue
		}
		if var_step_pms_data.array_isset(var_pm_id) {
			var_payment_methods_state.array_set(var_pm_id, rt.call_function('wc_string_to_bool', [var_step_pms_data.array_get(var_pm_id)]))
		}
	}
	if var_step_pms_data.array_isset(rt.new_string('apple_google')) {
	mut var_apple_google_enabled := rt.call_function('wc_string_to_bool', [var_step_pms_data.array_get(rt.new_string('apple_google'))])
	} else {
	var_apple_google_enabled = rt.new_bool(rt.is_true(var_apple_pay_enabled) || rt.is_true(var_google_pay_enabled))
	}
	var_payment_methods_state.array_set('apple_google', var_apple_google_enabled.clone())
	return var_payment_methods_state.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_wpcom_connection_authorization(return_url string) rt.PhpVal {
	mut return_url_mutated := return_url
	return rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('get_wpcom_connection_authorization'), rt.new_string(return_url_mutated).clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_wpcom_connection_state() rt.PhpVal {
	mut var_is_connected := rt.call_method(this.wpcom_connection_manager, 'is_connected', []rt.PhpVal{})
	mut var_has_connected_owner := rt.call_method(this.wpcom_connection_manager, 'has_connected_owner', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: 'has_working_connection', val: this.has_working_wpcom_connection() }, rt.ArrayItem{ key: 'is_store_connected', val: var_is_connected }, rt.ArrayItem{ key: 'has_connected_owner', val: var_has_connected_owner }, rt.ArrayItem{ key: 'is_connection_owner', val: rt.is_true(var_has_connected_owner) && rt.is_true(rt.call_method(this.wpcom_connection_manager, 'is_connection_owner', []rt.PhpVal{})) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_working_wpcom_connection() bool {
	return rt.is_true(rt.call_method(this.wpcom_connection_manager, 'is_connected', []rt.PhpVal{})) && rt.is_true(rt.call_method(this.wpcom_connection_manager, 'has_connected_owner', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) is_extension_active() bool {
	return (rt.call_method(this.proxy, 'call_function', [rt.new_string('class_exists'), rt.new_string('\\WC_Payments')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_payment_gateway() rt.PhpVal {
	return rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments'), rt.new_string('get_gateway')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_account() bool {
	return (rt.call_method(this.provider, 'is_account_connected', [this.get_payment_gateway()])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_valid_account() bool {
	if !(this.has_account()) {
		return false
	}
	mut var_account_service := rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments'), rt.new_string('get_account_service')])
	return (rt.call_method(var_account_service, 'is_stripe_account_valid', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_working_account() bool {
	if !(this.has_account()) {
		return false
	}
	mut var_account_service := rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments'), rt.new_string('get_account_service')])
	mut var_account_status := rt.call_method(var_account_service, 'get_account_status_data', []rt.PhpVal{})
	return !(!rt.is_true(var_account_status.array_get(rt.new_string('paymentsEnabled'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_test_account() bool {
	if !(this.has_account()) {
		return false
	}
	mut var_account_service := rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments'), rt.new_string('get_account_service')])
	mut var_account_status := rt.call_method(var_account_service, 'get_account_status_data', []rt.PhpVal{})
	return !(!rt.is_true(var_account_status.array_get(rt.new_string('testDrive'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_sandbox_account() bool {
	if !(this.has_account()) {
		return false
	}
	mut var_account_service := rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments'), rt.new_string('get_account_service')])
	mut var_account_status := rt.call_method(var_account_service, 'get_account_status_data', []rt.PhpVal{})
	return !rt.is_true(var_account_status.array_get(rt.new_string('isLive'))) && !rt.is_true(var_account_status.array_get(rt.new_string('testDrive')))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) has_live_account() bool {
	if !(this.has_account()) {
		return false
	}
	mut var_account_service := rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments'), rt.new_string('get_account_service')])
	mut var_account_status := rt.call_method(var_account_service, 'get_account_status_data', []rt.PhpVal{})
	return !(!rt.is_true(var_account_status.array_get(rt.new_string('isLive'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_kyc_fields(location string) rt.PhpVal {
	mut var_response := rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.class(), rt.new_string('rest_endpoint_get_request'), rt.new_string('/wc/v3/payments/onboarding/fields')])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})]))))
	}
	if !(var_response.clone().is_array()) || !(var_response.array_isset(rt.new_string('data'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('Failed to get onboarding fields data.'), rt.new_string('woocommerce')]))))
	}
	mut var_fields := var_response.array_get(rt.new_string('data'))
	if !(var_fields.array_isset(rt.new_string('available_countries'))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Payments_Utils')])) && rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('is_callable'), rt.new_string('\\WC_Payments_Utils::supported_countries')])) {
		var_fields.array_set('available_countries', rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments_Utils'), rt.new_string('supported_countries')]))
	}
	var_fields.array_set('location', location)
	return var_fields.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_onboarding_kyc_fallback_url() string {
	if rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('is_callable'), rt.new_string('\\WC_Payments_Account::get_connect_url')])) {
		return (rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments_Account'), rt.new_string('get_connect_url'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_nox_in_context()])).str()
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_8 := iife_temp_8.wc_payments_settings_url(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.onboarding_path_base(), rt.create_array([rt.ArrayItem{ key: 'from', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_kyc() }]))
	return (rt.call_method(this.provider, 'get_onboarding_url', [this.get_payment_gateway(), iife_result_8])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) get_overview_page_url() string {
	if rt.is_true(rt.call_method(this.proxy, 'call_function', [rt.new_string('is_callable'), rt.new_string('\\WC_Payments_Account::get_overview_page_url')])) {
		return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'from', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_nox_in_context() }]), rt.call_method(this.proxy, 'call_static', [rt.new_string('\\WC_Payments_Account'), rt.new_string('get_overview_page_url')])])).str()
	}
	return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-admin' }, rt.ArrayItem{ key: 'path', val: '/payments/overview' }, rt.ArrayItem{ key: 'from', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.from_nox_in_context() }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService) validate_onboarding_source(mut var_source Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_?string) string {
	mut var_source_mutated := var_source
	if !rt.is_true(var_source_mutated) {
		return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_default()).str()
	}
	mut var_valid_sources := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_default() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_lys() }])
	return (if rt.is_true(rt.call_function('in_array', [var_source_mutated, var_valid_sources.clone(), rt.new_bool(true)])) { var_source_mutated } else { Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.session_entry_default() }).str()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_woopayments_woopaymentsservice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService{
		PhpObjectBase: rt.PhpObjectBase{}
		payments_providers: rt.new_null()
		proxy: rt.new_null()
		wpcom_connection_manager: rt.new_null()
		provider: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
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
			return this.get_onboarding_step_required_steps(dispatch_arg_0)
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
