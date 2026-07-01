import rt

pub fn Class_WC_Auth.version() i64 {
	return 1
}
struct Class_WC_Auth {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Auth) construct()  {
	rt.call_function('add_filter', [rt.new_string('query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Auth', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_vars' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_endpoint' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('parse_request'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Auth', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_auth_requests' }]), rt.new_int(0)])
}

fn (mut this Class_WC_Auth) add_query_vars(var_vars rt.PhpVal) rt.PhpVal {
	mut var_vars_mutated := var_vars
	var_vars_mutated.array_push('wc-auth-version')
	var_vars_mutated.array_push('wc-auth-route')
	return var_vars_mutated.dup()
}

fn Class_WC_Auth.add_endpoint()  {
	rt.call_function('add_rewrite_rule', [rt.new_string('^wc-auth/v([1]{1})/(.*)?'), rt.new_string('index.php?wc-auth-version=$matches[1]&wc-auth-route=$matches[2]'), rt.new_string('top')])
}

fn (mut this Class_WC_Auth) get_i18n_scope(var_scope rt.PhpVal) rt.PhpVal {
	mut var_permissions := rt.create_array([rt.ArrayItem{ key: 'read', val: rt.call_function('__', [rt.new_string('Read'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'write', val: rt.call_function('__', [rt.new_string('Write'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'read_write', val: rt.call_function('__', [rt.new_string('Read/Write'), rt.new_string('woocommerce')]) }])
	return var_permissions.array_get(var_scope)
}

fn (mut this Class_WC_Auth) get_permissions_in_scope(var_scope rt.PhpVal) rt.PhpVal {
	mut var_permissions := rt.new_array()
	mut switch_val_1 := var_scope
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('read'))) {
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View coupons'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View customers'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View orders and sales reports'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View products'), rt.new_string('woocommerce')]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('write'))) {
		var_permissions.array_push(rt.call_function('__', [rt.new_string('Create webhooks'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('Create coupons'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('Create customers'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('Create orders'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('Create products'), rt.new_string('woocommerce')]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('read_write'))) {
		var_permissions.array_push(rt.call_function('__', [rt.new_string('Create webhooks'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View and manage coupons'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View and manage customers'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View and manage orders and sales reports'), rt.new_string('woocommerce')]))
		var_permissions.array_push(rt.call_function('__', [rt.new_string('View and manage products'), rt.new_string('woocommerce')]))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_api_permissions_in_scope'), var_permissions.dup(), var_scope.dup()])
}

fn (mut this Class_WC_Auth) build_url(var_data rt.PhpVal, var_endpoint rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_url := rt.call_function('wc_get_endpoint_url', ['wc-auth/v' + Class_WC_Auth.version().str(), var_endpoint.dup(), rt.call_function('home_url', [rt.new_string('/')])])
	return rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'app_name', val: rt.call_function('wc_clean', [var_data_mutated.array_get('app_name')]) }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('wc_clean', [var_data_mutated.array_get('user_id')]) }, rt.ArrayItem{ key: 'return_url', val: rt.call_function('rawurlencode', [this.get_formatted_url(var_data_mutated.array_get('return_url'))]) }, rt.ArrayItem{ key: 'callback_url', val: rt.call_function('rawurlencode', [this.get_formatted_url(var_data_mutated.array_get('callback_url'))]) }, rt.ArrayItem{ key: 'scope', val: rt.call_function('wc_clean', [var_data_mutated.array_get('scope')]) }]), var_url.dup()])
}

fn (mut this Class_WC_Auth) get_formatted_url(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	var_url_mutated = rt.call_function('urldecode', [var_url_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_url_mutated.dup(), rt.new_string('://')]))))) {
		var_url_mutated = rt.new_string('https://' + (var_url_mutated).str())
	}
	return var_url_mutated.dup()
}

fn (mut this Class_WC_Auth) make_validation()  {
	mut var_data := rt.new_array()
	mut var_params := rt.create_array([rt.ArrayItem{ key: none, val: 'app_name' }, rt.ArrayItem{ key: none, val: 'user_id' }, rt.ArrayItem{ key: none, val: 'return_url' }, rt.ArrayItem{ key: none, val: 'callback_url' }, rt.ArrayItem{ key: none, val: 'scope' }])
	{
		mut iter_1 := var_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param := item_1.val
			if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(var_param)) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Missing parameter %s'), rt.new_string('woocommerce')]), var_param.dup()]))))
			}
			var_data.array_set(var_param, rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(var_param)]))
			// unsupported statement: Stmt_Nop
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_data.array_get('scope'), rt.create_array([rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{ key: none, val: 'write' }, rt.ArrayItem{ key: none, val: 'read_write' }]), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid scope %s'), rt.new_string('woocommerce')]), rt.call_function('wc_clean', [var_data.array_get('scope')])]))))
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'return_url' }, rt.ArrayItem{ key: none, val: 'callback_url' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param := item_1.val
			var_param = this.get_formatted_url(var_data.array_get(var_param))
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('filter_var', [var_param.dup(), rt.get_constant('FILTER_VALIDATE_URL')]))) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s is not a valid URL'), rt.new_string('woocommerce')]), var_param.dup()]))))
			}
		}
	}
	mut var_callback_url := this.get_formatted_url(var_data.array_get('callback_url'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('The callback_url needs to be over SSL'), rt.new_string('woocommerce')]))))
	}
}

fn (mut this Class_WC_Auth) create_keys(var_app_name rt.PhpVal, var_app_user_id rt.PhpVal, var_scope rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_description := rt.call_function('sprintf', [rt.new_string('%s - API (%s)'), rt.call_function('wc_trim_string', [rt.call_function('wc_clean', [var_app_name.dup()]), rt.new_int(170)]), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])])
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_permissions := if rt.is_true(rt.call_function('in_array', [var_scope.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{ key: none, val: 'write' }, rt.ArrayItem{ key: none, val: 'read_write' }]), rt.new_bool(true)])) { rt.call_function('sanitize_text_field', [var_scope.dup()]) } else { rt.new_string('read') }
	mut var_consumer_key := rt.new_string('ck_' + (rt.call_function('wc_rand_hash', []rt.PhpVal{})).str())
	mut var_consumer_secret := rt.new_string('cs_' + (rt.call_function('wc_rand_hash', []rt.PhpVal{})).str())
	rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys', rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_user, 'ID') }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'permissions', val: var_permissions }, rt.ArrayItem{ key: 'consumer_key', val: rt.call_function('wc_api_hash', [var_consumer_key.dup()]) }, rt.ArrayItem{ key: 'consumer_secret', val: var_consumer_secret }, rt.ArrayItem{ key: 'truncated_key', val: rt.call_function('substr', [var_consumer_key.dup(), // unsupported expression: Expr_UnaryMinus]) }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])])
	return rt.create_array([rt.ArrayItem{ key: 'key_id', val: rt.get_property(var_wpdb, 'insert_id') }, rt.ArrayItem{ key: 'user_id', val: var_app_user_id }, rt.ArrayItem{ key: 'consumer_key', val: var_consumer_key }, rt.ArrayItem{ key: 'consumer_secret', val: var_consumer_secret }, rt.ArrayItem{ key: 'key_permissions', val: var_permissions }])
}

fn (mut this Class_WC_Auth) post_consumer_data(var_consumer_data rt.PhpVal, var_url rt.PhpVal) bool {
	mut var_consumer_data_mutated := var_consumer_data
	mut var_url_mutated := var_url
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [var_consumer_data_mutated.dup()]) }, rt.ArrayItem{ key: 'timeout', val: 60 }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json;charset=' + (rt.call_function('get_bloginfo', [rt.new_string('charset')])).str() }]) }])
	mut var_response := rt.call_function('wp_safe_remote_post', [rt.call_function('esc_url_raw', [var_url_mutated.dup()]), var_params.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}))))
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('An error occurred in the request and at the time were unable to send the consumer data'), rt.new_string('woocommerce')]))))
	}
	return true
}

fn (mut this Class_WC_Auth) handle_auth_requests()  {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-auth-version'))) {
		rt.get_property(var_wp, 'query_vars').array_set('wc-auth-version', rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wc-auth-version')])]))
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-auth-route'))) {
		rt.get_property(var_wp, 'query_vars').array_set('wc-auth-route', rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wc-auth-route')])]))
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('wc-auth-version'))) && !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('wc-auth-route'))) {
		this.auth_endpoint(rt.get_property(var_wp, 'query_vars').array_get('wc-auth-route'))
	}
}

fn (mut this Class_WC_Auth) auth_endpoint(var_route rt.PhpVal)  {
	mut var_route_mutated := var_route
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_consumer_data := rt.new_array()
	var_route_mutated = rt.new_string(rt.new_string(rt.call_function('wc_clean', [var_route_mutated.dup()]).to_string().to_lower()))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.make_validation()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_data := rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('login'), var_route_mutated)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')])) && rt.is_true(rt.call_method(fn () rt.PhpVal { mut temp := Class_Jetpack{}; return temp.connection() }(), 'has_connected_owner', []rt.PhpVal{})))) {
			if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack{}; return temp.is_module_active(arg_0) }(rt.new_string('sso'))) {
				mut var_redirect_url := this.build_url(var_data.dup(), rt.new_string('authorize'))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				mut var_login_url := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_Jetpack_Connection_SSO{}; return temp.get_instance() }(), 'build_sso_button_url', [rt.create_array([rt.ArrayItem{ key: 'redirect_to', val: rt.call_function('rawurlencode', [rt.call_function('esc_url_raw', [var_redirect_url.dup()])]) }, rt.ArrayItem{ key: 'action', val: 'login' }])])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_function('wp_safe_redirect', [var_login_url.dup()])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				// unsupported expression: Expr_Exit
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_function('wc_get_template', [rt.new_string('auth/form-login.php'), rt.create_array([rt.ArrayItem{ key: 'app_name', val: rt.call_function('wc_clean', [var_data.array_get('app_name')]) }, rt.ArrayItem{ key: 'return_url', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'success', val: 0 }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('wc_clean', [var_data.array_get('user_id')]) }]), this.get_formatted_url(var_data.array_get('return_url'))]) }, rt.ArrayItem{ key: 'redirect_url', val: this.build_url(var_data.dup(), rt.new_string('authorize')) }])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		// unsupported expression: Expr_Exit
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('login'), var_route_mutated)) && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))) {
		rt.call_function('wp_redirect', [rt.call_function('esc_url_raw', [this.build_url(var_data.dup(), rt.new_string('authorize'))])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		// unsupported expression: Expr_Exit
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('authorize'), var_route_mutated)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))))) {
		rt.call_function('wp_redirect', [rt.call_function('esc_url_raw', [this.build_url(var_data.dup(), rt.new_string('login'))])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		// unsupported expression: Expr_Exit
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('authorize'), var_route_mutated)) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))) {
		rt.call_function('wc_get_template', [rt.new_string('auth/form-grant-access.php'), rt.create_array([rt.ArrayItem{ key: 'app_name', val: rt.call_function('wc_clean', [var_data.array_get('app_name')]) }, rt.ArrayItem{ key: 'callback_url', val: this.get_formatted_url(var_data.array_get('callback_url')) }, rt.ArrayItem{ key: 'return_url', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'success', val: 0 }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('wc_clean', [var_data.array_get('user_id')]) }]), this.get_formatted_url(var_data.array_get('return_url'))]) }, rt.ArrayItem{ key: 'scope', val: this.get_i18n_scope(rt.call_function('wc_clean', [var_data.array_get('scope')])) }, rt.ArrayItem{ key: 'permissions', val: this.get_permissions_in_scope(rt.call_function('wc_clean', [var_data.array_get('scope')])) }, rt.ArrayItem{ key: 'granted_url', val: rt.call_function('wp_nonce_url', [this.build_url(var_data.dup(), rt.new_string('access_granted')), rt.new_string('wc_auth_grant_access'), rt.new_string('wc_auth_nonce')]) }, rt.ArrayItem{ key: 'logout_url', val: rt.call_function('wp_logout_url', [this.build_url(var_data.dup(), rt.new_string('login'))]) }, rt.ArrayItem{ key: 'user', val: rt.call_function('wp_get_current_user', []rt.PhpVal{}) }])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		// unsupported expression: Expr_Exit
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('access_granted'), var_route_mutated)) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))) {
		if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('wc_auth_nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wc_auth_nonce')])]), rt.new_string('wc_auth_grant_access')]))))))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid nonce verification'), rt.new_string('woocommerce')]))))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_consumer_data = this.create_keys(var_data.array_get('app_name'), var_data.array_get('user_id'), var_data.array_get('scope'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_response := rt.new_bool(this.post_consumer_data(var_consumer_data.dup(), this.get_formatted_url(var_data.array_get('callback_url'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(var_response) {
			rt.call_function('wp_redirect', [rt.call_function('esc_url_raw', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'success', val: 1 }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('wc_clean', [var_data.array_get('user_id')]) }]), this.get_formatted_url(var_data.array_get('return_url'))])])])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			// unsupported expression: Expr_Exit
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('You do not have permission to access this page'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		this.maybe_delete_key(var_consumer_data.dup())
		rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Error: %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]), rt.call_function('esc_html__', [rt.new_string('Access denied'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'response', val: 401 }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_WC_Auth) maybe_delete_key(var_key rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if var_key.array_isset(rt.new_string('key_id')) {
		rt.call_method(var_wpdb, 'delete', [(rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys', rt.create_array([rt.ArrayItem{ key: 'key_id', val: var_key.array_get('key_id') }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	}
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

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_SSO {
	rt.PhpObjectBase
}

fn create_wc_auth() &Class_WC_Auth {
	mut obj := &Class_WC_Auth{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
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

fn create_jetpack() &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_sso() &Class_Automattic_Jetpack_Connection_SSO {
	mut obj := &Class_Automattic_Jetpack_Connection_SSO{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Auth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_query_vars(dispatch_arg_0)
		}
		'add_endpoint' {
			Class_WC_Auth.add_endpoint()
			return rt.new_null()
		}
		'get_i18n_scope' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_i18n_scope(dispatch_arg_0)
		}
		'get_permissions_in_scope' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_permissions_in_scope(dispatch_arg_0)
		}
		'build_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.build_url(dispatch_arg_0, dispatch_arg_1)
		}
		'get_formatted_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_url(dispatch_arg_0)
		}
		'make_validation' {
			this.make_validation()
			return rt.new_null()
		}
		'create_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.create_keys(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'post_consumer_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.post_consumer_data(dispatch_arg_0, dispatch_arg_1))
		}
		'handle_auth_requests' {
			this.handle_auth_requests()
			return rt.new_null()
		}
		'auth_endpoint' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.auth_endpoint(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_delete_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_delete_key(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Auth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Auth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Connection_SSO) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_SSO) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_SSO) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_auth_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	create_wc_auth()
}
