import rt

struct Class_WC_Shortcode_My_Account {
	rt.PhpObjectBase
}

fn Class_WC_Shortcode_My_Account.get(var_atts rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WC_Shortcodes{}
	mut iife_result_0 := iife_temp_0.shortcode_wrapper(rt.create_array([
		rt.ArrayItem{ key: none, val: @STRUCT },
		rt.ArrayItem{ key: none, val: 'output' },
	]), var_atts.clone())
	return iife_result_0
}

fn Class_WC_Shortcode_My_Account.output(var_atts rt.PhpVal) {
	mut var_wp := rt.new_null()
	if rt.is_true(rt.new_bool(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart').is_null())) {
		return
	}
	Class_WC_Shortcode_My_Account.my_account_add_notices()
	if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('lost-password')) {
		Class_WC_Shortcode_My_Account.lost_password()
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('wc_get_template', [rt.new_string('myaccount/form-login.php')])
		return
	}
	Class_WC_Shortcode_My_Account.my_account(var_atts.clone())
}

fn Class_WC_Shortcode_My_Account.my_account_add_notices() {
	mut var_wp := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		mut var_message := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_my_account_message'),
			rt.new_string(''),
		])
		if !(!rt.is_true(var_message)) {
			rt.call_function('wc_add_notice', [var_message.clone()])
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('password-reset')))) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [
				rt.new_string('Your password has been reset successfully.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('customer-logout'))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		rt.call_function('wc_add_notice', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Are you sure you want to log out? <a href="%s">Confirm and log out</a>'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('wc_logout_url', []rt.PhpVal{}),
			]),
		])
	}
	if rt.is_true(rt.call_function('get_user_option', [rt.new_string('default_password_nag')]))
		&& rt.is_true(rt.call_function('wc_is_current_account_menu_item', [rt.new_string('dashboard')]))
		|| rt.is_true(rt.call_function('wc_is_current_account_menu_item', [rt.new_string('edit-account')])) {
		rt.call_function('wc_add_notice', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your account with %s is using a temporary password. We emailed you a link to change your password.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_function('wp_specialchars_decode', [
						rt.call_function('get_option', [rt.new_string('blogname')]),
						rt.get_constant('ENT_QUOTES'),
					]),
				]),
			]),
			rt.new_string('notice'),
			rt.new_array(),
			rt.new_bool(true),
		])
	}
}

fn Class_WC_Shortcode_My_Account.my_account(var_atts rt.PhpVal) {
	mut var_args := rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'order_count', val: 15 }]),
		var_atts.clone(),
		rt.new_string('woocommerce_my_account'),
	])
	rt.call_function('wc_get_template', [rt.new_string('myaccount/my-account.php'),
		rt.create_array([
			rt.ArrayItem{ key: 'current_user', val: rt.call_function('get_user_by', [
				rt.new_string('id'),
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
			]) },
			rt.ArrayItem{
				key: 'order_count'
				val: if rt.is_true(rt.identical(rt.new_string('all'),
					var_args.array_get(rt.new_string('order_count'))))
				{
					-1
				} else {
					var_args.array_get(rt.new_string('order_count'))
				}
			},
		])])
}

fn Class_WC_Shortcode_My_Account.view_order(var_order_id rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_order'), var_order_id.clone()]))))) {
		rt.call_function('wc_print_notice', [
			rt.new_string(
				(rt.call_function('esc_html__', [rt.new_string('Invalid order.'), rt.new_string('woocommerce')])).str() +
				' <a href="' +
				(rt.call_function('esc_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])).str() +
				'" class="wc-forward">' +
				(rt.call_function('esc_html__', [rt.new_string('My account'), rt.new_string('woocommerce')])).str() +
				'</a>'),
			rt.new_string('error'),
		])
		return
	}
	mut var_status := create_stdclass()
	rt.set_property(var_status, 'name', rt.call_function('wc_get_order_status_name', [
		rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
	]))
	rt.call_function('wc_get_template', [rt.new_string('myaccount/view-order.php'),
		rt.create_array([rt.ArrayItem{ key: 'status', val: var_status },
			rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order,
				'get_id', []rt.PhpVal{}) }])])
}

fn Class_WC_Shortcode_My_Account.edit_account() {
	rt.call_function('wc_get_template', [
		rt.new_string('myaccount/form-edit-account.php'),
		rt.create_array([
			rt.ArrayItem{ key: 'user', val: rt.call_function('get_user_by', [
				rt.new_string('id'),
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
			]) },
		]),
	])
}

fn Class_WC_Shortcode_My_Account.edit_address(load_address string) {
	mut load_address_mutated := load_address
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	load_address_mutated = (rt.call_function('sanitize_key', [
		rt.new_string(load_address_mutated).clone()])).str()
	mut var_country := rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string(load_address_mutated + '_country'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_country)))) {
		var_country = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_base_country', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string('billing'), rt.new_string(load_address_mutated))) {
		mut var_allowed_countries := rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_countries.clone().array_isset(var_country.clone())))))) {
			var_country = rt.call_function('current', [
				rt.func_array_keys(var_allowed_countries.clone()),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('shipping'), rt.new_string(load_address_mutated))) {
		var_allowed_countries = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_shipping_countries', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_countries.clone().array_isset(var_country.clone())))))) {
			var_country = rt.call_function('current', [
				rt.func_array_keys(var_allowed_countries.clone()),
			])
		}
	}
	mut var_address := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_address_fields', [var_country.clone(),
		rt.new_string(load_address_mutated + '_')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-country-select')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-address-i18n')])
	mut iter_1 := var_address.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_key := item_1.key
		mut var_value := rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			var_key.clone(),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
			mut switch_val_1 := var_key
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('billing_email')))
				|| rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_email'))) {
				var_value = rt.get_property(var_current_user, 'user_email')
			}
		}
		var_address.array_get_mut(var_key).array_set('value', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_my_account_edit_address_field_value'),
			var_value.clone(),
			var_key.clone(),
			rt.new_string(load_address_mutated).clone(),
		]))
	}
	rt.call_function('wc_get_template', [
		rt.new_string('myaccount/form-edit-address.php'),
		rt.create_array([rt.ArrayItem{ key: 'load_address', val: load_address_mutated },
			rt.ArrayItem{ key: 'address', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_address_to_edit'),
				var_address.clone(),
				rt.new_string(load_address_mutated).clone(),
			]) }]),
	])
}

fn Class_WC_Shortcode_My_Account.lost_password() {
	mut var_rp_id := rt.new_null()
	mut var_rp_key := rt.new_null()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('reset-link-sent')))) {
		rt.call_function('wc_get_template', [
			rt.new_string('myaccount/lost-password-confirmation.php'),
		])
		return
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('show-reset-form')))) {
		if rt.get_superglobal('_COOKIE').array_isset('wp-resetpass-' + (rt.get_constant('COOKIEHASH')).str()) && rt.is_true(rt.less(rt.new_int(0), rt.call_function('strpos', [rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp-resetpass-' + (rt.get_constant('COOKIEHASH')).str())), rt.new_string(':')]))) {
			mut list_tmp_1 := rt.call_function('array_map', [
				rt.new_string('wc_clean'),
				rt.call_function('explode', [
					rt.new_string(':'),
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp-resetpass-' +
							(rt.get_constant('COOKIEHASH')).str())),
					]),
					rt.new_int(2),
				])])
			var_rp_id = list_tmp_1.array_get(0)
			var_rp_key = list_tmp_1.array_get(1)
			mut var_userdata := rt.call_function('get_userdata', [
				rt.call_function('absint', [var_rp_id.clone()]),
			])
			mut var_rp_login := if rt.is_true(var_userdata) {
				rt.get_property(var_userdata, 'user_login')
			} else {
				rt.new_string('')
			}
			mut var_user := Class_WC_Shortcode_My_Account.check_password_reset_key(var_rp_key.clone(),
				var_rp_login.clone())
			if rt.is_true(rt.new_bool(var_user.clone().is_object())) {
				rt.call_function('wc_get_template', [
					rt.new_string('myaccount/form-reset-password.php'),
					rt.create_array([rt.ArrayItem{ key: 'key', val: var_rp_key },
						rt.ArrayItem{ key: 'login', val: var_rp_login }]),
				])
				return
			}
		}
	}
	rt.call_function('wc_get_template', [
		rt.new_string('myaccount/form-lost-password.php'),
		rt.create_array([rt.ArrayItem{ key: 'form', val: 'lost_password' }]),
	])
}

fn Class_WC_Shortcode_My_Account.retrieve_password() bool {
	mut var_login := if rt.get_superglobal('_POST').array_isset(rt.new_string('user_login')) { rt.call_function('sanitize_user', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('user_login'))]),
		]) } else { rt.new_string('') }
	if !rt.is_true(var_login) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [rt.new_string('Enter a username or email address.'),
				rt.new_string('woocommerce')]),
			rt.new_string('error'),
		])
		return false
	} else {
		mut var_user_data := rt.call_function('get_user_by', [
			rt.new_string('login'), var_login.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_data))))
		&& rt.is_true(rt.call_function('is_email', [var_login.clone()]))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_get_username_from_email'), rt.new_bool(true)])) {
		var_user_data = rt.call_function('get_user_by', [rt.new_string('email'),
			var_login.clone()])
	}
	mut var_errors := create_wp_error()
	rt.call_function('do_action',
		[rt.new_string('lostpassword_post'), var_errors, var_user_data.clone()])
	if rt.is_true(var_errors.get_error_code()) {
		rt.call_function('wc_add_notice', [var_errors.get_error_message(),
			rt.new_string('error')])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_data)))) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [rt.new_string('Invalid username or email.'),
				rt.new_string('woocommerce')]),
			rt.new_string('error'),
		])
		return false
	}
	mut var_user_login := rt.get_property(var_user_data, 'user_login')
	rt.call_function('do_action', [rt.new_string('retrieve_password'),
		var_user_login.clone()])
	mut var_allow := rt.call_function('apply_filters', [
		rt.new_string('allow_password_reset'),
		rt.new_bool(true),
		rt.get_property(var_user_data, 'ID'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allow)))) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [
				rt.new_string('Password reset is not allowed for this user'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('error'),
		])
		return false
	} else if rt.is_true(rt.call_function('is_wp_error', [var_allow.clone()])) {
		rt.call_function('wc_add_notice', [
			rt.call_method(var_allow, 'get_error_message', []rt.PhpVal{}),
			rt.new_string('error'),
		])
		return false
	}
	mut var_key := rt.call_function('get_password_reset_key', [
		var_user_data.clone()])
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{})
	rt.call_function('do_action', [
		rt.new_string('woocommerce_reset_password_notification'),
		var_user_login.clone(),
		var_key.clone(),
	])
	return true
}

fn Class_WC_Shortcode_My_Account.check_password_reset_key(var_key rt.PhpVal, var_login rt.PhpVal) bool {
	mut var_key_mutated := var_key
	mut var_login_mutated := var_login
	mut var_user := rt.call_function('check_password_reset_key', [
		var_key_mutated.clone(), var_login_mutated.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [
				rt.new_string('This key is invalid or has already been used. Please reset your password again if needed.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('error'),
		])
		return false
	}
	return var_user.to_bool()
}

fn Class_WC_Shortcode_My_Account.reset_password(var_user rt.PhpVal, var_new_pass rt.PhpVal) {
	mut var_user_mutated := var_user
	rt.call_function('do_action', [rt.new_string('password_reset'),
		var_user_mutated.clone(), var_new_pass.clone()])
	rt.call_function('wp_set_password', [var_new_pass.clone(),
		rt.get_property(var_user_mutated, 'ID')])
	rt.call_function('update_user_meta', [rt.get_property(var_user_mutated, 'ID'),
		rt.new_string('default_password_nag'), rt.new_bool(false)])
	Class_WC_Shortcode_My_Account.set_reset_password_cookie()
	rt.call_function('wc_set_customer_auth_cookie', [
		rt.get_property(var_user_mutated, 'ID'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_disable_password_change_notification'),
		rt.new_bool(false),
	])))))
	{
		rt.call_function('wp_password_change_notification', [
			var_user_mutated.clone()])
	}
}

fn Class_WC_Shortcode_My_Account.set_reset_password_cookie(value string) {
	mut value_mutated := value
	mut var_rp_cookie := rt.new_string('wp-resetpass-' + (rt.get_constant('COOKIEHASH')).str())
	mut var_rp_path := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('current', [
			rt.call_function('explode', [rt.new_string('?'),
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
				])]),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_string(value_mutated)) {
		rt.call_function('setcookie', [var_rp_cookie.clone(),
			rt.new_string(value_mutated).clone(), rt.new_int(0),
			var_rp_path.clone(), rt.get_constant('COOKIE_DOMAIN'),
			rt.call_function('is_ssl', []rt.PhpVal{}), rt.new_bool(true)])
	} else {
		rt.call_function('setcookie', [var_rp_cookie.clone(),
			rt.new_string(' '),
			rt.sub(rt.call_function('time', []rt.PhpVal{}),
				rt.get_constant('YEAR_IN_SECONDS')),
			var_rp_path.clone(), rt.get_constant('COOKIE_DOMAIN'),
			rt.call_function('is_ssl', []rt.PhpVal{}), rt.new_bool(true)])
	}
}

fn Class_WC_Shortcode_My_Account.add_payment_method() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')]),
		])
		exit(0)
	} else {
		rt.call_function('do_action', [
			rt.new_string('before_woocommerce_add_payment_method'),
		])
		rt.call_function('wc_get_template', [
			rt.new_string('myaccount/form-add-payment-method.php'),
		])
		rt.call_function('do_action', [
			rt.new_string('after_woocommerce_add_payment_method'),
		])
	}
}

struct Class_WC_Shortcodes {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_shortcode_my_account(_args ...rt.PhpVal) &Class_WC_Shortcode_My_Account {
	mut obj := &Class_WC_Shortcode_My_Account{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcodes(_args ...rt.PhpVal) &Class_WC_Shortcodes {
	mut obj := &Class_WC_Shortcodes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn (mut this Class_WC_Shortcode_My_Account) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcode_My_Account.get(dispatch_arg_0)
		}
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shortcode_My_Account.output(dispatch_arg_0)
			return rt.new_null()
		}
		'my_account_add_notices' {
			Class_WC_Shortcode_My_Account.my_account_add_notices()
			return rt.new_null()
		}
		'my_account' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shortcode_My_Account.my_account(dispatch_arg_0)
			return rt.new_null()
		}
		'view_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shortcode_My_Account.view_order(dispatch_arg_0)
			return rt.new_null()
		}
		'edit_account' {
			Class_WC_Shortcode_My_Account.edit_account()
			return rt.new_null()
		}
		'edit_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_Shortcode_My_Account.edit_address(dispatch_arg_0)
			return rt.new_null()
		}
		'lost_password' {
			Class_WC_Shortcode_My_Account.lost_password()
			return rt.new_null()
		}
		'retrieve_password' {
			return rt.new_bool(Class_WC_Shortcode_My_Account.retrieve_password())
		}
		'check_password_reset_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Shortcode_My_Account.check_password_reset_key(dispatch_arg_0,
				dispatch_arg_1))
		}
		'reset_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Shortcode_My_Account.reset_password(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_reset_password_cookie' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_Shortcode_My_Account.set_reset_password_cookie(dispatch_arg_0)
			return rt.new_null()
		}
		'add_payment_method' {
			Class_WC_Shortcode_My_Account.add_payment_method()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shortcode_My_Account) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_My_Account) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shortcodes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcodes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcodes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
