import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Utilities_Users.is_site_administrator(user_id i64) bool {
	mut user_id_mutated := user_id
	mut var_user := if 0 == user_id_mutated { rt.call_function('wp_get_current_user', []rt.PhpVal{}) } else { rt.call_function('get_user_by', [rt.new_string('id'), rt.new_int(user_id_mutated).dup()]) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_user)) {
		return false
	}
	return (if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_method(var_user, 'has_cap', [rt.new_string('manage_sites')]) } else { rt.call_method(var_user, 'has_cap', [rt.new_string('manage_options')]) }).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Utilities_Users.get_user_in_current_site(var_user_id rt.PhpVal, mut var_requesting_user_id Class_Automattic_WooCommerce_Internal_Utilities_?int) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
	mut var_requesting_user_id_mutated := var_requesting_user_id
	var_user_id_mutated = if rt.is_true(rt.new_bool(var_user_id_mutated.dup().is_long() || var_user_id_mutated.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_legacy_proxy := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()])
	var_requesting_user_id_mutated = if rt.is_true(rt.greater(var_requesting_user_id_mutated, rt.new_int(0))) { var_requesting_user_id_mutated } else { rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'ID') }
	mut var_error := create_wp_error(rt.new_string('wc_user_invalid_id'), rt.call_function('__', [rt.new_string('Invalid user ID.'), rt.new_string('woocommerce')]))
	if rt.is_true(rt.less_equal(var_user_id_mutated, rt.new_int(0))) {
		return mut var_error
	}
	mut var_user := rt.call_function('get_userdata', [var_user_id_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))))) {
		return mut var_error
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('is_multisite')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('is_user_member_of_blog'), rt.get_property(var_user, 'ID')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('user_can'), var_requesting_user_id_mutated.dup(), rt.new_string('manage_network_users')]))))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_user)
}

fn Class_Automattic_WooCommerce_Internal_Utilities_Users.should_user_verify_order_email(var_order_id rt.PhpVal, var_supplied_email rt.PhpVal, context string) bool {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	mut var_billing_email := rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})
	mut var_customer_id := rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})
	if !rt.is_true(var_billing_email) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_customer_id) && rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_customer_id)))) {
		return false
	}
	mut var_verification_grace_period := // unsupported expression: Expr_Cast_Int
	mut var_date_created := rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_a', [var_date_created.dup(), Class_Automattic_WooCommerce_Internal_Utilities_WC_DateTime.class(), rt.new_bool(true)])) && rt.is_true(rt.less_equal(rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_method(var_date_created, 'getTimestamp', []rt.PhpVal{})), var_verification_grace_period)))) {
		return false
	}
	mut var_session := rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session')
	mut var_session_email := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('is_a', [var_session.dup(), Class_Automattic_WooCommerce_Internal_Utilities_WC_Session.class()])) {
		mut var_customer := rt.call_method(var_session, 'get', [rt.new_string('customer')])
		var_session_email = if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_customer.dup().is_array())) && var_customer.array_isset(rt.new_string('email')))) { var_customer.array_get('email') } else { rt.new_string('') }
	}
	mut var_can_view_orders := rt.call_function('current_user_can', [rt.new_string('read_private_shop_orders')])
	mut var_session_email_match := rt.new_bool(rt.new_bool(!(!rt.is_true(var_session_email)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [var_session_email.dup(), var_billing_email.dup()])))))
	mut var_supplied_email_match := rt.new_bool(rt.new_bool(!(!rt.is_true(var_supplied_email)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [var_supplied_email.dup(), var_billing_email.dup()])))))
	mut var_email_verification_required := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_session_email_match)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_supplied_email_match)))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_can_view_orders))))))
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Utilities_Users.get_site_user_meta(user_id i64, key string, single bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut user_id_mutated := user_id
	// unsupported statement: Stmt_Global
	mut var_site_specific_key := rt.new_string(key + '_' + rt.call_method(var_wpdb, 'get_blog_prefix', [rt.call_function('get_current_blog_id', []rt.PhpVal{})]).to_string().trim_right(' \t\n\r'))
	return rt.call_function('get_user_meta', [rt.new_int(user_id_mutated).dup(), var_site_specific_key.dup(), rt.new_bool(single)])
}

fn Class_Automattic_WooCommerce_Internal_Utilities_Users.update_site_user_meta(user_id i64, meta_key string, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut user_id_mutated := user_id
	// unsupported statement: Stmt_Global
	mut var_site_specific_key := rt.new_string(meta_key + '_' + rt.call_method(var_wpdb, 'get_blog_prefix', [rt.call_function('get_current_blog_id', []rt.PhpVal{})]).to_string().trim_right(' \t\n\r'))
	return rt.call_function('update_user_meta', [rt.new_int(user_id_mutated).dup(), var_site_specific_key.dup(), var_meta_value.dup(), rt.new_string(prev_value)])
}

fn Class_Automattic_WooCommerce_Internal_Utilities_Users.delete_site_user_meta(var_user_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_user_id_mutated := var_user_id
	// unsupported statement: Stmt_Global
	mut var_site_specific_key := rt.new_string((var_meta_key).str() + '_' + rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{}).to_string().trim_right(' \t\n\r'))
	return rt.call_function('delete_user_meta', [var_user_id_mutated.dup(), var_site_specific_key.dup(), rt.new_string(meta_value)])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_site_administrator' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_Users.is_site_administrator(dispatch_arg_0))
		}
		'get_user_in_current_site' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Utilities_Users.get_user_in_current_site(dispatch_arg_0, mut dispatch_arg_1)
		}
		'should_user_verify_order_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_Users.should_user_verify_order_email(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_site_user_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Internal_Utilities_Users.get_site_user_meta(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_site_user_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Utilities_Users.update_site_user_meta(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'delete_site_user_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Utilities_Users.delete_site_user_meta(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_users_php() {
}
