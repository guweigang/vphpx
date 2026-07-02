import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribe_endpoint() string {
	return 'https://woocommerce.com/wp-json/wccom/v1/subscribe'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribe_endpoint_dev() string {
	return 'https://woocommerce.test/wp-json/wccom/v1/subscribe'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_option_name() string {
	return 'woocommerce_onboarding_subscribed_to_mailchimp'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_error_count_option_name() string {
	return 'woocommerce_onboarding_subscribed_to_mailchimp_error_count'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.max_error_threshold() i64 {
	return 3
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.logger_context() string {
	return 'mailchimp_scheduler'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	rt.PhpObjectBase
pub mut:
		logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) construct(mut var_logger Class_Automattic_WooCommerce_Internal_Admin_Schedulers_?WC_Logger_Interface) {
	mut var_logger_mutated := var_logger
	if rt.is_true(rt.identical(rt.new_null(), var_logger_mutated)) {
	var_logger_mutated = rt.call_function('wc_get_logger', []rt.PhpVal{})
	}
	this.logger = var_logger_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) run() bool {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_option_name()]))) {
		return false
	}
	mut var_profile_data := rt.call_function('get_option', [rt.new_string('woocommerce_onboarding_profile')])
	if !(var_profile_data.array_isset(rt.new_string('is_agree_marketing'))) || rt.is_true(rt.identical(rt.new_bool(false), var_profile_data.array_get(rt.new_string('is_agree_marketing')))) {
		return false
	}
	if !(var_profile_data.array_isset(rt.new_string('store_email'))) {
		return false
	}
	if rt.is_true(rt.greater_equal(rt.new_int(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_error_count_option_name(), rt.new_int(0)]).to_i64()), Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.max_error_threshold())) {
		return false
	}
	mut var_country_code := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_state := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{})
	mut var_address := rt.create_array([rt.ArrayItem{ key: 'addr1', val: 'N/A' }, rt.ArrayItem{ key: 'addr2', val: '' }, rt.ArrayItem{ key: 'city', val: 'N/A' }, rt.ArrayItem{ key: 'state', val: if !(var_state).is_null() { var_state } else { rt.new_string('N/A') } }, rt.ArrayItem{ key: 'zip', val: 'N/A' }, rt.ArrayItem{ key: 'country', val: if !(var_country_code).is_null() { var_country_code } else { rt.new_string('N/A') } }])
	mut var_response := this.make_request(var_profile_data.array_get(rt.new_string('store_email')), var_address.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) || !(var_response.array_isset(rt.new_string('body'))) {
		this.handle_request_error(rt.new_null())
		return false
	}
	mut var_body := rt.call_function('json_decode', [var_response.array_get(rt.new_string('body'))])
	if !(rt.get_property(var_body, 'success')).is_null() && rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_body, 'success'))) {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_option_name(), rt.new_string('yes')])
		return true
	}
	this.handle_request_error(var_body.clone())
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) make_request(var_store_email rt.PhpVal, var_address rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	if rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('defined', [rt.new_string('WP_ENVIRONMENT_TYPE')]))) && rt.is_true(rt.identical(rt.new_string('development'), rt.call_function('constant', [rt.new_string('WP_ENVIRONMENT_TYPE')]))) {
	mut var_subscribe_endpoint := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribe_endpoint_dev()
	} else {
	var_subscribe_endpoint = Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribe_endpoint()
	}
	return rt.call_function('wp_remote_post', [var_subscribe_endpoint.clone(), rt.create_array([rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' + (rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() }, rt.ArrayItem{ key: 'method', val: 'POST' }, rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'email', val: var_store_email }, rt.ArrayItem{ key: 'address', val: var_address_mutated }]) }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.reset() {
	rt.call_function('delete_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_option_name()])
	rt.call_function('delete_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_error_count_option_name()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) handle_request_error(var_extra_msg rt.PhpVal) {
	mut var_msg := rt.new_string((if !(var_extra_msg).is_null() { 'Incorrect response from Mailchimp API with: ' + (println(var_extra_msg.clone().to_string())).str() } else { 'Error getting a response from Mailchimp API.' }).str())
	rt.call_method(this.logger, 'error', [var_msg.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.logger_context() }])])
	mut var_accumulated_error_count := rt.new_int(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_error_count_option_name(), rt.new_int(0)]).to_i64() + 1)
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.subscribed_error_count_option_name(), var_accumulated_error_count.clone()])
}

fn create_automattic_woocommerce_internal_admin_schedulers_mailchimpscheduler(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
		logger: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Schedulers_?WC_Logger_Interface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			return rt.new_bool(this.run())
		}
		'make_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.make_request(dispatch_arg_0, dispatch_arg_1)
		}
		'reset' {
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler.reset()
			return rt.new_null()
		}
		'handle_request_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_request_error(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
