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
	eligibility_service             rt.PhpVal = rt.new_null()
	notification_management_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) init(mut var_eligibility_service Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService, mut var_notification_management_service Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService) {
	this.eligibility_service = var_eligibility_service
	this.notification_management_service = var_notification_management_service
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) signup(product_id i64, user_id i64, user_email string, mut var_posted_attributes Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut product_id_mutated := product_id
	mut user_id_mutated := user_id
	mut var_posted_attributes_mutated := var_posted_attributes
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_0 := iife_temp_0.allows_signups()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_failed()))
	}
	if user_email == '' && user_id_mutated == 0 {
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_request()))
	}
	mut var_product := rt.call_function('wc_get_product', [rt.new_int(product_id_mutated).clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service,
		'is_product_eligible', [var_product.clone()])))))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	}
	if rt.is_true(rt.call_method(this.eligibility_service, 'is_stock_status_eligible', [
		rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{}),
	]))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_request()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service,
		'product_allows_signups', [var_product.clone()])))))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	}
	mut var_notification := this.is_already_signed_up(product_id_mutated, user_id_mutated,
		user_email, mut var_posted_attributes_mutated)
	if rt.is_true(rt.new_bool(rt.instance_of(var_notification,
		'Automattic_WooCommerce_Internal_StockNotifications_Notification')))
	{
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active(), rt.call_method(var_notification,
			'get_status', []rt.PhpVal{})))
		{
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult',
				[]string{}, create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined(),
				var_notification.clone()))
		}
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending(), rt.call_method(var_notification,
			'get_status', []rt.PhpVal{})))
		{
			mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
			mut iife_result_1 := iife_temp_1.requires_double_opt_in()
			if rt.is_true(iife_result_1) {
				return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult',
					[]string{}, create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined_double_opt_in(),
					var_notification.clone()))
			}
			rt.call_method(var_notification, 'set_status', [
				Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active(),
			])
			rt.call_method(var_notification, 'save', []rt.PhpVal{})
			rt.call_function('do_action', [
				rt.new_string('woocommerce_customer_stock_notifications_signup'),
				var_notification.clone(),
			])
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult',
				[]string{}, create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success(),
				var_notification.clone()))
		}
	}
	mut var_account_created := rt.new_null()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_2 := iife_temp_2.creates_account_on_signup()
	if user_id_mutated == 0 && rt.is_true(iife_result_2) {
		var_account_created = this.create_customer(user_email)
		user_id_mutated = (if rt.is_true(var_account_created) {
			var_account_created
		} else {
			rt.new_int(user_id_mutated)
		}).to_i64()
	}
	var_notification = create_automattic_woocommerce_internal_stocknotifications_notification()
	rt.call_method(var_notification, 'set_status', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active(),
	])
	rt.call_method(var_notification, 'set_product_id', [rt.new_int(product_id_mutated).clone()])
	rt.call_method(var_notification, 'set_user_id', [rt.new_int(user_id_mutated).clone()])
	rt.call_method(var_notification, 'set_user_email', [rt.new_string(user_email)])
	if !(!rt.is_true(var_posted_attributes_mutated)) {
		rt.call_method(var_notification, 'update_meta_data', [
			rt.new_string('posted_attributes'),
			var_posted_attributes_mutated,
		])
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_3 := iife_temp_3.requires_double_opt_in()
	if rt.is_true(iife_result_3) {
		rt.call_method(var_notification, 'set_status', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending(),
		])
	}
	mut var_saved := rt.call_method(var_notification, 'save', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_failed()))
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_customer_stock_notifications_signup'),
		var_notification.clone(),
	])
	mut var_signup_code :=
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_4 := iife_temp_4.requires_double_opt_in()
	if rt.is_true(iife_result_4) {
		var_signup_code = if rt.is_true(var_account_created) {
			Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created_double_opt_in()
		} else {
			Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_double_opt_in()
		}
	} else if rt.is_true(var_account_created) {
		var_signup_code =
			Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created()
	}
	return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult',
		[]string{}, create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(var_signup_code.clone(),
		var_notification.clone()))
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
	mut var_found := rt.new_bool(false)
	if !(user_id_mutated == 0) {
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}
		mut iife_result_5 := iife_temp_5.notification_exists_by_user_id(rt.new_int(product_id_mutated),
			rt.new_int(user_id_mutated))
		var_found = iife_result_5
	} else {
		mut iife_temp_6 :=
			Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}
		mut iife_result_6 := iife_temp_6.notification_exists_by_email(rt.new_int(product_id_mutated),
			rt.new_string(user_email))
		var_found = iife_result_6
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
		return rt.new_null()
	}
	mut var_query_args := rt.create_array([
		rt.ArrayItem{ key: 'product_id', val: product_id_mutated },
	])
	if !(user_id_mutated == 0) {
		var_query_args.array_set('user_id', user_id_mutated)
	} else {
		var_query_args.array_set('user_email', user_email)
	}
	var_query_args.array_set('return', 'ids')
	var_query_args.array_set('limit', 1)
	if !(!rt.is_true(var_posted_attributes_mutated)) {
		var_query_args.array_set('meta_query', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: 'posted_attributes' },
				rt.ArrayItem{ key: 'value', val: rt.call_function('maybe_serialize', [
					var_posted_attributes_mutated,
				]) },
				rt.ArrayItem{ key: 'compare', val: '=' },
			]) },
		]))
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}
	mut iife_result_7 := iife_temp_7.get_notifications(var_query_args.clone())
	mut var_ids := iife_result_7
	if !rt.is_true(var_ids) || !(var_ids.array_get(rt.new_int(0)).is_long()
		|| var_ids.array_get(rt.new_int(0)).is_double()) {
		return rt.new_null()
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
	mut iife_result_8 := iife_temp_8.get_notification(var_ids.array_get(rt.new_int(0)))
	mut var_notification := iife_result_8
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notification)))) {
		return rt.new_null()
	}
	return var_notification.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) create_customer(user_email string) rt.PhpVal {
	if user_email == ''
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.new_string(user_email)]))))) {
		return rt.new_null()
	}
	mut var_username := rt.call_function('wc_create_new_customer_username', [
		rt.new_string(user_email),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_username = rt.call_function('sanitize_user', [var_username.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !rt.is_true(var_username)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_username', [var_username.clone()]))))) {
		return rt.new_null()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_password := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_registration_generate_password'),
	])))
	{ rt.new_string('') } else { rt.call_function('wp_generate_password', []rt.PhpVal{}) }
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_user_id := rt.call_function('wc_create_new_customer', [
		rt.new_string(user_email),
		var_username.clone(),
		var_password.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_function('is_a', [var_user_id.clone(),
		rt.new_string('WP_Error')]))
	{
		return rt.new_null()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Internal_StockNotifications_Frontend_Throwable')
	{
		mut var_e := var_e_1.clone()
		return rt.new_null()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return var_user_id.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut var_parsed_data := this.parse_user_data(mut var_source)
	if rt.is_true(rt.call_function('is_wp_error', [var_parsed_data.clone()])) {
		return var_parsed_data.clone()
	}
	mut var_product := this.parse_product(mut var_source)
	if rt.is_true(rt.call_function('is_wp_error', [var_product.clone()])) {
		return var_product.clone()
	}
	var_parsed_data.array_set('product_id', rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product_Variation')))
	{
		mut var_posted_attributes := this.parse_posted_attributes(mut var_source, mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product](var_product))
		if !(!rt.is_true(var_posted_attributes)) {
			var_parsed_data.array_set('posted_attributes', var_posted_attributes.clone())
		}
	}
	return var_parsed_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse_user_data(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_is_logged_in := rt.call_function('is_user_logged_in', []rt.PhpVal{})
	mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_9 := iife_temp_9.requires_account()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_logged_in)))) && rt.is_true(iife_result_9) {
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_requires_account()))
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_10 := iife_temp_10.creates_account_on_signup()
	mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_11 := iife_temp_11.requires_account()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_logged_in)))) && rt.is_true(iife_result_10)
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_11)))) {
		mut var_opt_in := if var_source.array_isset(rt.new_string('wc_bis_opt_in')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					var_source.array_get(rt.new_string('wc_bis_opt_in')),
				]),
			]) } else { rt.new_bool(false) }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('on'), var_opt_in)))) {
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
				[]string{},
				create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_opt_in()))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_logged_in)))) {
		mut var_email := if var_source.array_isset(rt.new_string('wc_bis_email')) { rt.call_function('sanitize_email', [
				rt.call_function('wp_unslash', [
					var_source.array_get(rt.new_string('wc_bis_email')),
				]),
			]) } else { rt.new_bool(false) }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_email)))) {
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
				[]string{},
				create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_email()))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
			var_email.clone()])))))
		{
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
				[]string{},
				create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_email()))
		}
		var_data.array_set('user_id', 0)
		var_data.array_set('user_email', var_email.clone())
		mut var_user := rt.call_function('get_user_by', [rt.new_string('email'),
			var_email.clone()])
		if rt.is_true(var_user) {
			var_data.array_set('user_id', rt.get_property(var_user, 'ID'))
		}
	} else {
		var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
				[]string{},
				create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_user()))
		}
		var_data.array_set('user_id', rt.get_property(var_user, 'ID'))
		var_data.array_set('user_email', rt.get_property(var_user, 'user_email'))
	}
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse_product(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array) rt.PhpVal {
	mut var_product_id := if var_source.array_isset(rt.new_string('wc_bis_product_id')) { rt.call_function('absint', [
			rt.call_function('wp_unslash', [
				var_source.array_get(rt.new_string('wc_bis_product_id')),
			]),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	}
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product'))))))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service,
		'is_product_eligible', [var_product.clone()])))))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service,
		'product_allows_signups', [var_product.clone()])))))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	}
	return var_product.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) parse_posted_attributes(mut var_source Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array, mut var_variation Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product',
		[]string{}, var_variation),
		'Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product_Variation'))))))
	{
		return rt.new_array()
	}
	mut var_product := rt.call_function('wc_get_product', [var_variation.get_parent_id()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return rt.new_array()
	}
	mut var_posted_attributes := rt.new_array()
	mut iter_1 := rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attribute := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute.array_get(rt.new_string('is_variation')))))) {
			continue
		}
		mut var_attribute_key :=
			rt.new_string('attribute_' +(rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])).str())
		if var_source.array_isset(var_attribute_key) {
			if rt.is_true(var_attribute.array_get(rt.new_string('is_taxonomy'))) {
				mut var_value := rt.call_function('sanitize_title', [
					rt.call_function('wp_unslash', [var_source.array_get(var_attribute_key)]),
				])
			} else {
				var_value = rt.call_function('html_entity_decode', [
					rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [var_source.array_get(var_attribute_key)]),
					]),
					rt.get_constant('ENT_QUOTES'),
					rt.call_function('get_bloginfo', [
						rt.new_string('charset'),
					]),
				])
			}
			if !(!rt.is_true(var_value)) || rt.is_true(rt.identical(rt.new_string('0'), var_value)) {
				var_posted_attributes.array_set(var_attribute_key, var_value.clone())
			}
		}
	}
	mut var_variation_attributes := var_variation.get_variation_attributes()
	var_variation_attributes = rt.call_function('array_filter', [
		var_variation_attributes.clone()])
	mut var_diff := rt.call_function('array_diff', [var_posted_attributes.clone(),
		var_variation_attributes.clone()])
	return if !(!rt.is_true(var_diff)) { var_diff } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) get_error_message(error_code string) string {
	mut switch_val_1 := rt.new_string(error_code)
	if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_product()))
	{
		return (rt.call_function('wp_kses_post', [
			rt.call_function('__', [rt.new_string('Invalid product.'),
				rt.new_string('woocommerce')]),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_user()))
	{
		return (rt.call_function('wp_kses_post', [
			rt.call_function('__', [rt.new_string('Invalid user.'),
				rt.new_string('woocommerce')]),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_email()))
	{
		return (rt.call_function('wp_kses_post', [
			rt.call_function('__', [rt.new_string('Invalid email address.'),
				rt.new_string('woocommerce')]),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_opt_in()))
	{
		return (rt.call_function('wp_kses_post', [
			rt.call_function('__', [
				rt.new_string('To proceed, please consent to the creation of a new account with your e-mail.'),
				rt.new_string('woocommerce'),
			]),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_rate_limited()))
	{
		return (rt.call_function('wp_kses_post', [
			rt.call_function('__', [
				rt.new_string('You have already signed up too many times. Please try again later.'),
				rt.new_string('woocommerce'),
			]),
		])).str()
	} else {
		return (rt.call_function('wp_kses_post', [
			rt.call_function('__', [
				rt.new_string('Failed to sign up. Please try again.'),
				rt.new_string('woocommerce'),
			]),
		])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) get_signup_user_message(signup_code string, mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) string {
	mut signup_code_mutated := signup_code
	mut var_notification_mutated := var_notification
	mut var_message := rt.new_string('')
	mut var_has_action_button := rt.new_bool(false)
	mut switch_val_2 := rt.new_string(signup_code_mutated)
	if rt.is_true(rt.equal(switch_val_2,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success()))
	{
		var_message = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('You have successfully signed up! You will be notified when "%s" is back in stock.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_notification_mutated, 'get_product_name', []rt.PhpVal{}),
		])
	} else if rt.is_true(rt.equal(switch_val_2,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_double_opt_in()))
	{
		var_message = rt.call_function('esc_html__', [
			rt.new_string('Thanks for signing up! Please complete the sign-up process by following the verification link sent to your e-mail.'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_2,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created()))
	{
		var_message = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('You have successfully signed up and will be notified when "%s" is back in stock! Note that a new account has been created for you; please check your e-mail for details.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_notification_mutated, 'get_product_name', []rt.PhpVal{}),
		])
	} else if rt.is_true(rt.equal(switch_val_2,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_success_account_created_double_opt_in()))
	{
		var_message = rt.call_function('esc_html__', [
			rt.new_string('Thanks for signing up! An account has been created for you. Please complete the sign-up process by following the verification link sent to your e-mail.'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_2,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined()))
	{
		var_message = rt.call_function('esc_html__', [
			rt.new_string('You have already joined this waitlist.'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_2,
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.signup_already_joined_double_opt_in()))
	{
		mut var_notice_text := rt.call_function('esc_html__', [
			rt.new_string('You have already joined this waitlist. Please complete the sign-up process by following the verification link sent to your e-mail.'),
			rt.new_string('woocommerce'),
		])
		mut var_url := rt.call_method(this.notification_management_service,
			'get_resend_verification_email_url', [var_notification_mutated])
		mut var_button_class := rt.call_function('wc_wp_theme_get_element_class_name', [
			rt.new_string('button'),
		])
		mut var_wp_button_class := rt.new_string((if rt.is_true(var_button_class) {
			' ' + var_button_class.str()
		} else {
			''
		}).str())
		var_message = rt.call_function('sprintf', [
			rt.new_string('<a href="%s" class="button wc-forward%s">%s</a> %s'),
			var_url.clone(),
			var_wp_button_class.clone(),
			rt.call_function('esc_html_x', [rt.new_string('Resend verification'),
				rt.new_string('notice action'), rt.new_string('woocommerce')]),
			var_notice_text.clone(),
		])
		var_has_action_button = rt.new_bool(true)
	} else {
		var_message = rt.new_string('')
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_action_button)))) {
		var_button_class = rt.call_function('wc_wp_theme_get_element_class_name', [
			rt.new_string('button'),
		])
		var_wp_button_class = rt.new_string((if rt.is_true(var_button_class) {
			' ' + var_button_class.str()
		} else {
			''
		}).str())
		var_message = rt.call_function('sprintf', [
			rt.new_string('<a href="%s" class="button wc-forward%s">%s</a> %s'),
			rt.call_function('wc_get_account_endpoint_url', [
				rt.new_string('stock-notifications'),
			]),
			var_wp_button_class.clone(),
			rt.call_function('esc_html_x', [
				rt.new_string('Manage notifications'),
				rt.new_string('notice action'),
				rt.new_string('woocommerce'),
			]),
			var_message.clone(),
		])
	}
	return var_message.str()
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

fn create_automattic_woocommerce_internal_stocknotifications_frontend_signupservice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService{
		PhpObjectBase:                   rt.PhpObjectBase{}
		eligibility_service:             rt.new_null()
		notification_management_service: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_config(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notification(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notificationquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_factory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'signup' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return this.signup(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'is_already_signed_up' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return this.is_already_signed_up(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut
				dispatch_arg_3)
		}
		'create_customer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.create_customer(dispatch_arg_0)
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.parse(mut dispatch_arg_0)
		}
		'parse_user_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.parse_user_data(mut dispatch_arg_0)
		}
		'parse_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.parse_product(mut dispatch_arg_0)
		}
		'parse_posted_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_WC_Product](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.parse_posted_attributes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_error_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_error_message(dispatch_arg_0))
		}
		'get_signup_user_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_signup_user_message(dispatch_arg_0, mut dispatch_arg_1))
		}
		else {
			return none
		}
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
		'eligibility_service' {
			this.eligibility_service = val
			return true
		}
		'notification_management_service' {
			this.notification_management_service = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
