import rt
import crypto.md5

fn wc_disable_admin_bar(var_show_admin_bar rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_disable_admin_bar'), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))))))) {
		var_show_admin_bar = false
	}
	return var_show_admin_bar
}

fn wc_create_new_customer(var_email rt.PhpVal, username string, password string, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(var_email) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email.dup()]))))))) {
		return create_wp_error(rt.new_string('registration-error-invalid-email'), rt.call_function('__', [rt.new_string('Please provide a valid email address.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.call_function('email_exists', [var_email.dup()])) {
		return create_wp_error(rt.new_string('registration-error-email-exists'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('An account is already registered with %s. Please log in or use a different email address.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_email.dup()])]))
	}
	if username == '' {
		username = (wc_create_new_customer_username(var_email.dup(), var_args.dup(), '')).str()
	}
	username = (rt.call_function('sanitize_user', [rt.new_string(username)])).str()
	if rt.is_true(rt.new_bool(username == '' || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_username', [rt.new_string(username)]))))))) {
		return create_wp_error(rt.new_string('registration-error-invalid-username'), rt.call_function('__', [rt.new_string('Please provide a valid account username.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.call_function('username_exists', [rt.new_string(username)])) {
		return create_wp_error(rt.new_string('registration-error-username-exists'), rt.call_function('__', [rt.new_string('An account is already registered with that username. Please choose another.'), rt.new_string('woocommerce')]))
	}
	mut var_password_generated := false
	if password == '' {
		password = (rt.call_function('wp_generate_password', []rt.PhpVal{})).str()
		var_password_generated = true
	}
	if password == '' {
		return create_wp_error(rt.new_string('registration-error-missing-password'), rt.call_function('__', [rt.new_string('Please create a password for your account.'), rt.new_string('woocommerce')]))
	}
	mut var_errors := create_wp_error()
	rt.call_function('do_action', [rt.new_string('woocommerce_register_post'), rt.new_string(username), var_email.dup(), var_errors.dup()])
	var_errors = rt.call_function('apply_filters', [rt.new_string('woocommerce_registration_errors'), var_errors.dup(), rt.new_string(username), var_email.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_errors.dup()])) && rt.is_true(rt.call_method(var_errors, 'get_error_code', []rt.PhpVal{})))) {
		return var_errors.dup()
	}
	mut var_customer_data := rt.call_function('array_merge', [var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'user_login', val: username }, rt.ArrayItem{ key: 'user_pass', val: password }, rt.ArrayItem{ key: 'user_email', val: var_email }, rt.ArrayItem{ key: 'role', val: 'customer' }])])
	mut var_new_customer_data := rt.call_function('apply_filters', [rt.new_string('woocommerce_new_customer_data'), rt.call_function('wp_parse_args', [var_customer_data.dup(), rt.create_array([rt.ArrayItem{ key: 'first_name', val: '' }, rt.ArrayItem{ key: 'last_name', val: '' }, rt.ArrayItem{ key: 'source', val: 'unknown' }])])])
	mut var_customer_id := rt.call_function('wp_insert_user', [var_new_customer_data.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_customer_id.dup()])) {
		return var_customer_id.dup()
	}
	if var_password_generated {
		rt.call_function('update_user_option', [var_customer_id.dup(), rt.new_string('default_password_nag'), rt.new_bool(true), rt.new_bool(true)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_created_customer'), var_customer_id.dup(), var_new_customer_data.dup(), rt.new_bool(var_password_generated).dup()])
	return var_customer_id.dup()
}

fn wc_create_new_customer_username(var_email rt.PhpVal, var_new_user_args rt.PhpVal, suffix string) rt.PhpVal {
	mut var_username_parts := rt.new_array()
	if var_new_user_args.array_isset(rt.new_string('first_name')) {
		var_username_parts.array_push(rt.call_function('sanitize_user', [var_new_user_args.array_get('first_name'), rt.new_bool(true)]))
	}
	if var_new_user_args.array_isset(rt.new_string('last_name')) {
		var_username_parts.array_push(rt.call_function('sanitize_user', [var_new_user_args.array_get('last_name'), rt.new_bool(true)]))
	}
	var_username_parts = rt.call_function('array_filter', [var_username_parts.dup()])
	if !rt.is_true(var_username_parts) {
		mut var_email_parts := rt.call_function('explode', [rt.new_string('@'), var_email.dup()])
		mut var_email_username := var_email_parts.array_get(0)
		if rt.is_true(rt.call_function('in_array', [var_email_username.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'sales' }, rt.ArrayItem{ key: none, val: 'hello' }, rt.ArrayItem{ key: none, val: 'mail' }, rt.ArrayItem{ key: none, val: 'contact' }, rt.ArrayItem{ key: none, val: 'info' }]), rt.new_bool(true)])) {
			var_email_username = var_email_parts.array_get(1)
		}
		var_username_parts.array_push(rt.call_function('sanitize_user', [var_email_username.dup(), rt.new_bool(true)]))
	}
	mut var_username := rt.call_function('wc_strtolower', [rt.call_function('implode', [rt.new_string('.'), var_username_parts.dup()])])
	if var_suffix.len > 0 && var_suffix != '0' {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_illegal_logins := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('illegal_user_logins'), rt.new_array()]))
	if rt.is_true(rt.call_function('in_array', [rt.new_string(var_username.dup().to_string().to_lower()), rt.call_function('array_map', [rt.new_string('strtolower'), var_illegal_logins.dup()]), rt.new_bool(true)])) {
		mut var_new_args := rt.new_array()
		var_new_args['first_name'] = rt.call_function('apply_filters', [rt.new_string('woocommerce_generated_customer_username'), 'woo_user_' + (rt.call_function('zeroise', [rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(9999)]), rt.new_int(4)])).str(), var_email.dup(), var_new_user_args.dup(), rt.new_string(suffix)])
		return wc_create_new_customer_username(var_email.dup(), var_new_args.dup(), suffix)
	}
	if rt.is_true(rt.call_function('username_exists', [var_username.dup()])) {
		suffix = '-' + (rt.call_function('zeroise', [rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(9999)]), rt.new_int(4)])).str()
		return wc_create_new_customer_username(var_email.dup(), var_new_user_args.dup(), suffix)
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_new_customer_username'), var_username.dup(), var_email.dup(), var_new_user_args.dup(), rt.new_string(suffix)])
}

fn wc_set_customer_auth_cookie(var_customer_id rt.PhpVal) {
	rt.call_function('wp_set_current_user', [var_customer_id.dup()])
	rt.call_function('wp_set_auth_cookie', [var_customer_id.dup(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session') }, rt.ArrayItem{ key: none, val: 'init_session_cookie' }])])) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'init_session_cookie', []rt.PhpVal{})
	}
}

fn wc_update_new_customer_past_orders(var_customer_id rt.PhpVal) i64 {
	mut var_linked := 0
	mut var_complete := 0
	mut var_customer := rt.call_function('get_user_by', [rt.new_string('id'), rt.call_function('absint', [var_customer_id.dup()])])
	mut var_customer_orders := rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'limit', val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: 'customer', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: rt.get_property(var_customer, 'user_email') }]) }]) }, rt.ArrayItem{ key: 'return', val: 'ids' }])])
	if !(!rt.is_true(var_customer_orders)) {
		{
			mut iter_1 := var_customer_orders.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_order_id := item_1.val
				mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
					continue
				}
				rt.call_method(var_order, 'set_customer_id', [rt.get_property(var_customer, 'ID')])
				rt.call_method(var_order, 'save', []rt.PhpVal{})
				if rt.is_true(rt.call_method(var_order, 'has_downloadable_item', []rt.PhpVal{})) {
					mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download'))
					rt.call_method(var_data_store, 'delete_by_order_id', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
					rt.call_function('wc_downloadable_product_permissions', [rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.new_bool(true)])
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_update_new_customer_past_order'), var_order_id.dup(), var_customer.dup()])
				if rt.is_true(rt.identical(rt.call_method(var_order, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed())) {
					var_complete += 1
				}
				var_linked += 1
			}
		}
	}
	if var_complete != 0 {
		rt.call_function('update_user_meta', [var_customer_id.dup(), rt.new_string('paying_customer'), rt.new_int(1)])
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.update_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_order_count'), rt.new_string(''))
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.update_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_money_spent'), rt.new_string(''))
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.delete_site_user_meta(arg_0, arg_1) }(var_customer_id.dup(), rt.new_string('wc_last_order'))
	}
	return var_linked
}

fn wc_paying_customer(var_order_id rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	mut var_customer_id := rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_customer_id, rt.new_int(0))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_customer := create_wc_customer(var_customer_id.dup())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_is_paying_customer', []rt.PhpVal{}))))) {
			rt.call_method(var_customer, 'set_is_paying_customer', [rt.new_bool(true)])
			rt.call_method(var_customer, 'save', []rt.PhpVal{})
		}
	}
}

fn wc_customer_bought_product(var_customer_email rt.PhpVal, var_user_id rt.PhpVal, var_product_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_email := rt.new_null()
	mut var_status := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_result := rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_customer_bought_product'), rt.new_null(), var_customer_email.dup(), var_user_id.dup(), var_product_id.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_result).to_bool()
	}
	mut var_use_lookup_tables := rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_bought_product_use_lookup_tables'), rt.new_bool(false), var_customer_email.dup(), var_user_id.dup(), var_product_id.dup()])
	if rt.is_true(var_use_lookup_tables) {
		mut var_cache_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0) }(rt.new_string('woocommerce_reports'))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_customer_email)) && rt.is_true(var_user_id))) {
		var_cache_version = wc_get_customer_order_count(var_user_id.dup())
	} else {
		var_cache_version = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0) }(rt.new_string('orders'))
	}
	mut var_aggregation_version := 'v2'
	mut var_cache_group := 'orders'
	mut var_cache_key := rt.new_string('wc_customer_bought_product_' + md5.hexhash( +  + (var_use_lookup_tables).str() + '-' + var_aggregation_version))
	mut var_cache_value := rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string(var_cache_group).dup()])
	if rt.is_true(rt.new_bool(var_cache_value.array_isset(rt.new_string('value')) && var_cache_value.array_isset(rt.new_string('version')) && rt.is_true(rt.identical(var_cache_value.array_get('version'), var_cache_version)))) {
		var_result = var_cache_value.array_get('value')
	} else {
		mut var_user := rt.new_null()
		mut var_original_user_id := var_user_id.dup()
		if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
			
		}
		if rt.is_true() {
		}
		
	}
	return ().to_bool()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer() &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wc_user_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('add_filter', [rt.new_string('show_admin_bar'), rt.new_string('wc_disable_admin_bar'), rt.new_int(10), rt.new_int(1)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_create_new_customer')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_payment_complete'), rt.new_string('wc_paying_customer')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.new_string('wc_paying_customer')])
}
