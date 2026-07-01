import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined() string {
	return 'already_joined'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined_double_opt_in() string {
	return 'already_joined_double_opt_in'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success() string {
	return 'success'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created() string {
	return 'success_account_created'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created_double_opt_in() string {
	return 'success_account_created_double_opt_in'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_double_opt_in() string {
	return 'success_double_opt_in'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_failed() string {
	return 'failed_to_signup'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_request() string {
	return 'invalid_request'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product() string {
	return 'invalid_product'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_requires_account() string {
	return 'requires_account'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_rate_limited() string {
	return 'rate_limited'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_user() string {
	return 'invalid_user'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_email() string {
	return 'invalid_email'
}
pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_opt_in() string {
	return 'invalid_opt_in'
}
struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService {
	rt.PhpObjectBase
pub mut:
		eligibility_service rt.PhpVal = rt.new_null()
		notification_management_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) init(mut var_eligibility_service Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService, mut var_notification_management_service Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService)  {
	this.eligibility_service = var_eligibility_service.dup()
	this.notification_management_service = var_notification_management_service.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) signup(product_id i64, user_id i64, user_email string, mut var_posted_attributes Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut product_id_mutated := product_id
	mut user_id_mutated := user_id
	mut var_posted_attributes_mutated := var_posted_attributes
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.allows_signups() }())))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_failed())
	}
	if user_email == '' && user_id_mutated == 0 {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_request())
	}
	mut var_product := rt.call_function('wc_get_product', [rt.new_int(product_id_mutated).dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service, 'is_product_eligible', [var_product.dup()]))))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product())
	}
	if rt.is_true(rt.call_method(this.eligibility_service, 'is_stock_status_eligible', [rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{})])) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_request())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service, 'product_allows_signups', [var_product.dup()]))))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product())
	}
	mut var_notification := this.is_already_signed_up(product_id_mutated, user_id_mutated, user_email, mut var_posted_attributes_mutated)
	if rt.is_true(rt.new_bool(rt.instance_of(var_notification, 'Automattic_WooCommerce_Internal_StockNotifications_Notification'))) {
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active(), rt.call_method(var_notification, 'get_status', []rt.PhpVal{}))) {
			return create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined(), var_notification.dup())
		}
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending(), rt.call_method(var_notification, 'get_status', []rt.PhpVal{}))) {
			if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_double_opt_in() }()) {
				return create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined_double_opt_in(), var_notification.dup())
			}
			rt.call_method(var_notification, 'set_status', [Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active()])
			rt.call_method(var_notification, 'save', []rt.PhpVal{})
			rt.call_function('do_action', [rt.new_string('woocommerce_customer_stock_notifications_signup'), var_notification.dup()])
			return create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success(), var_notification.dup())
		}
	}
	mut var_account_created := rt.new_null()
	if rt.is_true(rt.new_bool(user_id_mutated == 0 && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.creates_account_on_signup() }()))) {
		var_account_created = this.create_customer(user_email)
		user_id_mutated = (if rt.is_true(var_account_created) { var_account_created } else { rt.new_int(user_id_mutated) }).to_i64()
	}
	var_notification = create_automattic_woocommerce_internal_stocknotifications_notification()
	rt.call_method(var_notification, 'set_status', [Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active()])
	rt.call_method(var_notification, 'set_product_id', [rt.new_int(product_id_mutated).dup()])
	rt.call_method(var_notification, 'set_user_id', [rt.new_int(user_id_mutated).dup()])
	rt.call_method(var_notification, 'set_user_email', [rt.new_string(user_email)])
	if !(!rt.is_true(var_posted_attributes_mutated)) {
		rt.call_method(var_notification, 'update_meta_data', [rt.new_string('posted_attributes'), var_posted_attributes_mutated.dup()])
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_double_opt_in() }()) {
		rt.call_method(var_notification, 'set_status', [Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending()])
	}
	mut var_saved := rt.call_method(var_notification, 'save', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_failed())
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_customer_stock_notifications_signup'), var_notification.dup()])
	mut var_signup_code := Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success()
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_double_opt_in() }()) {
		var_signup_code = if rt.is_true(var_account_created) { Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created_double_opt_in() } else { Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_double_opt_in() }
	} else if rt.is_true(var_account_created) {
		var_signup_code = Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created()
	}
	return create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(var_signup_code.dup(), var_notification.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) is_already_signed_up(product_id i64, user_id i64, user_email string, mut var_posted_attributes Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut product_id_mutated := product_id
	mut user_id_mutated := user_id
	mut var_posted_attributes_mutated := var_posted_attributes
	if product_id_mutated == 0 {
		return rt.new_null()
	}
	if user_id_mutated == 0 && user_email == '' {
		return rt.new_null()
	}
	mut var_found := rt.new_bool(rt.new_bool(false))
	if !(user_id_mutated == 0) {
		var_found = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}; return temp.notification_exists_by_user_id(arg_0, arg_1) }(rt.new_int(product_id_mutated), rt.new_int(user_id_mutated))
	} else {
		var_found = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}; return temp.notification_exists_by_email(arg_0, arg_1) }(rt.new_int(product_id_mutated), rt.new_string(user_email))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
		return rt.new_null()
	}
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'product_id', val: product_id_mutated }])
	if !(user_id_mutated == 0) {
		var_query_args.array_set('user_id', user_id_mutated)
	} else {
		var_query_args.array_set('user_email', user_email)
	}
	var_query_args.array_set('return', 'ids')
	var_query_args.array_set('limit', 1)
	if !(!rt.is_true(var_posted_attributes_mutated)) {
		var_query_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'posted_attributes' }, rt.ArrayItem{ key: 'value', val: rt.call_function('maybe_serialize', [var_posted_attributes_mutated.dup()]) }, rt.ArrayItem{ key: 'compare', val: '=' }]) }]))
	}
	mut var_ids := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}; return temp.get_notifications(arg_0) }(var_query_args.dup())
	if rt.is_true(rt.new_bool(!rt.is_true(var_ids) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_ids.array_get(0).is_long() || var_ids.array_get(0).is_double()))))))) {
		return rt.new_null()
	}
	mut var_notification := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}; return temp.get_notification(arg_0) }(var_ids.array_get(0))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notification)))) {
		return rt.new_null()
	}
	return var_notification.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) create_customer(user_email string) rt.PhpVal {
	if rt.is_true(rt.new_bool(user_email == '' || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.new_string(user_email)]))))))) {
		return rt.new_null()
	}
	mut var_username := rt.call_function('wc_create_new_customer_username', [rt.new_string(user_email)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_username = rt.call_function('sanitize_user', [var_username.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!rt.is_true(var_username) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_username', [var_username.dup()]))))))) {
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_password := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password')]))) { rt.new_string('') } else { rt.call_function('wp_generate_password', []rt.PhpVal{}) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_user_id := rt.call_function('wc_create_new_customer', [rt.new_string(user_email), var_username.dup(), var_password.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_a', [var_user_id.dup(), rt.new_string('WP_Error')])) {
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_StockNotifications_Frontend_Throwable') {
		mut var_e := var_e_1.dup()
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return var_user_id.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut var_parsed_data := this.parse_user_data(mut var_source)
	if rt.is_true(rt.call_function('is_wp_error', [var_parsed_data.dup()])) {
		return var_parsed_data.dup()
	}
	mut var_product := this.parse_product(mut var_source)
	if rt.is_true(rt.call_function('is_wp_error', [var_product.dup()])) {
		return var_product.dup()
	}
	var_parsed_data.array_set('product_id', rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product_Variation'))) {
		mut var_posted_attributes := this.parse_posted_attributes(mut var_source, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product](var_product))
		if !(!rt.is_true(var_posted_attributes)) {
			var_parsed_data.array_set('posted_attributes', var_posted_attributes.dup())
		}
	}
	return var_parsed_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse_user_data(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_is_logged_in := rt.call_function('is_user_logged_in', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_logged_in)))) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_account() }()))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_requires_account())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_logged_in)))) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.creates_account_on_signup() }()))) && rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_account() }())))))) {
		mut var_opt_in := if var_source.array_isset(rt.new_string('wc_bis_opt_in')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_source.array_get('wc_bis_opt_in')])]) } else { rt.new_bool(false) }
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_opt_in())
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_logged_in)))) {
		mut var_email := if var_source.array_isset(rt.new_string('wc_bis_email')) { rt.call_function('sanitize_email', [rt.call_function('wp_unslash', [var_source.array_get('wc_bis_email')])]) } else { rt.new_bool(false) }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_email)))) {
			return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_email())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email.dup()]))))) {
			return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_email())
		}
		var_data.array_set('user_id', 0)
		var_data.array_set('user_email', var_email.dup())
		mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email.dup()])
		if rt.is_true(var_user) {
			var_data.array_set('user_id', rt.get_property(var_user, 'ID'))
		}
	} else {
		var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
			return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_user())
		}
		var_data.array_set('user_id', rt.get_property(var_user, 'ID'))
		var_data.array_set('user_email', rt.get_property(var_user, 'user_email'))
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse_product(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut var_product_id := if var_source.array_isset(rt.new_string('wc_bis_product_id')) { rt.call_function('absint', [rt.call_function('wp_unslash', [.array_get()])]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product())
	}
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(, 'Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product')))))) {
		return create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return 
	}
	if rt.is_true() {
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse_posted_attributes(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array, mut var_variation Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) get_error_message(error_code string) string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) get_signup_user_message(signup_code string, mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) string {
	mut signup_code_mutated := signup_code
	mut var_notification_mutated := var_notification
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_signupservice() &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService{
		PhpObjectBase: rt.PhpObjectBase{}
		eligibility_service: rt.new_null()
		notification_management_service: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_config() &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error() &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult() &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notification() &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notificationquery() &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_factory() &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'signup' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.signup(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'is_already_signed_up' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.is_already_signed_up(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'create_customer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.create_customer(dispatch_arg_0)
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parse(mut dispatch_arg_0)
		}
		'parse_user_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parse_user_data(mut dispatch_arg_0)
		}
		'parse_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parse_product(mut dispatch_arg_0)
		}
		'parse_posted_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.parse_posted_attributes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_error_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_error_message(dispatch_arg_0))
		}
		'get_signup_user_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.get_signup_user_message(dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'eligibility_service' { return this.eligibility_service }
		'notification_management_service' { return this.notification_management_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'eligibility_service' { this.eligibility_service = val; return true }
		'notification_management_service' { this.notification_management_service = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_frontend_signupservice_php() {
	// unsupported statement: Stmt_Declare
}
