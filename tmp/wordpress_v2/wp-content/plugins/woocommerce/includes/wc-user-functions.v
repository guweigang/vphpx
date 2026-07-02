import rt
import crypto.md5

fn wc_disable_admin_bar(var_show_admin_bar_arg rt.PhpVal) bool {
	mut var_show_admin_bar := var_show_admin_bar_arg
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_disable_admin_bar'), rt.new_bool(true)])) && !(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))) {
	var_show_admin_bar = false
	}
	return var_show_admin_bar
}

fn wc_create_new_customer(var_email rt.PhpVal, username string, password string, var_args rt.PhpVal) rt.PhpVal {
	mut var_username := username
	mut var_password := password
	mut var_password_generated := false
	mut var_errors := rt.new_null()
	mut var_customer_data := rt.new_null()
	mut var_new_customer_data := rt.new_null()
	mut var_customer_id := rt.new_null()
	if !rt.is_true(var_email) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email.clone()]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('registration-error-invalid-email'), rt.call_function('__', [rt.new_string('Please provide a valid email address.'), rt.new_string('woocommerce')])))
	}
	if rt.is_true(rt.call_function('email_exists', [var_email.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('registration-error-email-exists'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('An account is already registered with %s. Please log in or use a different email address.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_email.clone()])])))
	}
	if var_username == '' {
	var_username = (wc_create_new_customer_username(var_email.clone(), var_args.clone(), '')).str()
	}
	var_username = (rt.call_function('sanitize_user', [rt.new_string((var_username).str())])).str()
	if var_username == '' || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_username', [rt.new_string((var_username).str())]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('registration-error-invalid-username'), rt.call_function('__', [rt.new_string('Please provide a valid account username.'), rt.new_string('woocommerce')])))
	}
	if rt.is_true(rt.call_function('username_exists', [rt.new_string((var_username).str())])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('registration-error-username-exists'), rt.call_function('__', [rt.new_string('An account is already registered with that username. Please choose another.'), rt.new_string('woocommerce')])))
	}
	var_password_generated = false
	if var_password == '' {
	var_password = (rt.call_function('wp_generate_password', []rt.PhpVal{})).str()
	var_password_generated = true
	}
	if var_password == '' {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('registration-error-missing-password'), rt.call_function('__', [rt.new_string('Please create a password for your account.'), rt.new_string('woocommerce')])))
	}
	var_errors = create_wp_error()
	rt.call_function('do_action', [rt.new_string('woocommerce_register_post'), rt.new_string((var_username).str()), var_email.clone(), var_errors.clone()])
	var_errors = rt.call_function('apply_filters', [rt.new_string('woocommerce_registration_errors'), var_errors.clone(), rt.new_string((var_username).str()), var_email.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_errors.clone()])) && rt.is_true(rt.call_method(var_errors, 'get_error_code', []rt.PhpVal{})) {
		return var_errors.clone()
	}
	var_customer_data = rt.call_function('array_merge', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'user_login', val: var_username }, rt.ArrayItem{ key: 'user_pass', val: var_password }, rt.ArrayItem{ key: 'user_email', val: var_email }, rt.ArrayItem{ key: 'role', val: 'customer' }])])
	var_new_customer_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_new_customer_data'), rt.call_function('wp_parse_args', [var_customer_data.clone(), rt.create_array([rt.ArrayItem{ key: 'first_name', val: '' }, rt.ArrayItem{ key: 'last_name', val: '' }, rt.ArrayItem{ key: 'source', val: 'unknown' }])])])
	var_customer_id = rt.call_function('wp_insert_user', [var_new_customer_data.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_customer_id.clone()])) {
		return var_customer_id.clone()
	}
	if var_password_generated {
		rt.call_function('update_user_option', [var_customer_id.clone(), rt.new_string('default_password_nag'), rt.new_bool(true), rt.new_bool(true)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_created_customer'), var_customer_id.clone(), var_new_customer_data.clone(), rt.new_bool(var_password_generated).clone()])
	return var_customer_id.clone()
}

fn wc_create_new_customer_username(var_email rt.PhpVal, var_new_user_args rt.PhpVal, suffix string) rt.PhpVal {
	mut var_suffix := suffix
	mut var_username_parts := rt.new_null()
	mut var_email_parts := rt.new_null()
	mut var_email_username := rt.new_null()
	mut var_username := rt.new_null()
	mut var_illegal_logins := rt.new_null()
	mut var_new_args := map[string]rt.PhpVal{}
	var_username_parts = rt.new_array()
	if var_new_user_args.array_isset(rt.new_string('first_name')) {
		var_username_parts.array_push(rt.call_function('sanitize_user', [var_new_user_args.array_get(rt.new_string('first_name')), rt.new_bool(true)]))
	}
	if var_new_user_args.array_isset(rt.new_string('last_name')) {
		var_username_parts.array_push(rt.call_function('sanitize_user', [var_new_user_args.array_get(rt.new_string('last_name')), rt.new_bool(true)]))
	}
	var_username_parts = rt.call_function('array_filter', [var_username_parts.clone()])
	if !rt.is_true(var_username_parts) {
		var_email_parts = rt.call_function('explode', [rt.new_string('@'), var_email.clone()])
		var_email_username = var_email_parts.array_get(rt.new_int(0))
		if rt.is_true(rt.call_function('in_array', [var_email_username.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'sales' }, rt.ArrayItem{ key: none, val: 'hello' }, rt.ArrayItem{ key: none, val: 'mail' }, rt.ArrayItem{ key: none, val: 'contact' }, rt.ArrayItem{ key: none, val: 'info' }]), rt.new_bool(true)])) {
		var_email_username = var_email_parts.array_get(rt.new_int(1))
		}
		var_username_parts.array_push(rt.call_function('sanitize_user', [var_email_username.clone(), rt.new_bool(true)]))
	}
	var_username = rt.call_function('wc_strtolower', [rt.call_function('implode', [rt.new_string('.'), var_username_parts.clone()])])
	if var_suffix.len > 0 && var_suffix != '0' {
		var_username = rt.concat(var_username, rt.new_string((var_suffix).str()))
	}
	var_illegal_logins = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('illegal_user_logins'), rt.new_array()]))
	if rt.is_true(rt.call_function('in_array', [rt.new_string(var_username.clone().to_string().to_lower()), rt.call_function('array_map', [rt.new_string('strtolower'), var_illegal_logins.clone()]), rt.new_bool(true)])) {
		var_new_args = rt.new_array()
		var_new_args['first_name'] = rt.call_function('apply_filters', [rt.new_string('woocommerce_generated_customer_username'), rt.new_string('woo_user_' + (rt.call_function('zeroise', [rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(9999)]), rt.new_int(4)])).str()), var_email.clone(), rt.create_array_from_native_map(var_new_user_args), rt.new_string((var_suffix).str())])
		return wc_create_new_customer_username(var_email.clone(), rt.create_array_from_native_map(var_new_args), var_suffix)
	}
	if rt.is_true(rt.call_function('username_exists', [var_username.clone()])) {
		var_suffix = '-' + (rt.call_function('zeroise', [rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(9999)]), rt.new_int(4)])).str()
		return wc_create_new_customer_username(var_email.clone(), rt.create_array_from_native_map(var_new_user_args), var_suffix)
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_new_customer_username'), var_username.clone(), var_email.clone(), rt.create_array_from_native_map(var_new_user_args), rt.new_string((var_suffix).str())])
}

fn wc_set_customer_auth_cookie(var_customer_id rt.PhpVal) {
	rt.call_function('wp_set_current_user', [var_customer_id.clone()])
	rt.call_function('wp_set_auth_cookie', [var_customer_id.clone(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session') }, rt.ArrayItem{ key: none, val: 'init_session_cookie' }])])) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'init_session_cookie', []rt.PhpVal{})
	}
}

fn wc_update_new_customer_past_orders(var_customer_id rt.PhpVal) i64 {
	mut var_linked := i64(0)
	mut var_complete := i64(0)
	mut var_customer := rt.new_null()
	mut var_customer_orders := rt.new_null()
	mut var_order_id := rt.new_null()
	mut var_order := rt.new_null()
	mut var_data_store := rt.new_null()
	var_linked = 0
	var_complete = 0
	var_customer = rt.call_function('get_user_by', [rt.new_string('id'), rt.call_function('absint', [var_customer_id.clone()])])
	var_customer_orders = rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'limit', val: -1 }, rt.ArrayItem{ key: 'customer', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: rt.get_property(var_customer, 'user_email') }]) }]) }, rt.ArrayItem{ key: 'return', val: 'ids' }])])
	if !(!rt.is_true(var_customer_orders)) {
		mut iter_1 := var_customer_orders.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order_id_shadow := item_1.val
			var_order = rt.call_function('wc_get_order', [var_order_id_shadow.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
				continue
			}
			rt.call_method(var_order, 'set_customer_id', [rt.get_property(var_customer, 'ID')])
			rt.call_method(var_order, 'save', []rt.PhpVal{})
			if rt.is_true(rt.call_method(var_order, 'has_downloadable_item', []rt.PhpVal{})) {
				mut iife_temp_0 := Class_WC_Data_Store{}
				mut iife_result_0 := iife_temp_0.load(rt.new_string('customer-download'))
				var_data_store = iife_result_0
				rt.call_method(var_data_store, 'delete_by_order_id', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
				rt.call_function('wc_downloadable_product_permissions', [rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.new_bool(true)])
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_update_new_customer_past_order'), var_order_id_shadow.clone(), var_customer.clone()])
			if rt.is_true(rt.identical(rt.call_method(var_order, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed())) {
				var_complete += 1
			}
			var_linked += 1
		}
	}
	if var_complete != 0 {
		rt.call_function('update_user_meta', [var_customer_id.clone(), rt.new_string('paying_customer'), rt.new_int(1)])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_1 := iife_temp_1.update_site_user_meta(var_customer_id.clone(), rt.new_string('wc_order_count'), rt.new_string(''))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_2 := iife_temp_2.update_site_user_meta(var_customer_id.clone(), rt.new_string('wc_money_spent'), rt.new_string(''))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_3 := iife_temp_3.delete_site_user_meta(var_customer_id.clone(), rt.new_string('wc_last_order'))
	}
	return var_linked
}

fn wc_paying_customer(var_order_id rt.PhpVal) {
	mut var_order := rt.new_null()
	mut var_customer_id := rt.new_null()
	mut var_customer := rt.new_null()
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	var_customer_id = rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_customer_id, rt.new_int(0))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order_refund'), rt.call_method(var_order, 'get_type', []rt.PhpVal{}))))) {
		var_customer = create_wc_customer(var_customer_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_is_paying_customer', []rt.PhpVal{}))))) {
			rt.call_method(var_customer, 'set_is_paying_customer', [rt.new_bool(true)])
			rt.call_method(var_customer, 'save', []rt.PhpVal{})
		}
	}
}

fn wc_customer_bought_product(var_customer_email rt.PhpVal, var_user_id_arg rt.PhpVal, var_product_id rt.PhpVal) bool {
	mut var_user_id := var_user_id_arg
	mut var_wpdb := rt.new_null()
	mut var_email := rt.new_null()
	mut var_status := rt.new_null()
	mut var_result := rt.new_null()
	mut var_use_lookup_tables := rt.new_null()
	mut var_cache_version := rt.new_null()
	mut var_aggregation_version := ''
	mut var_cache_group := ''
	mut var_cache_key := rt.new_null()
	mut var_cache_value := rt.new_null()
	mut var_user := rt.new_null()
	mut var_original_user_id := rt.new_null()
	mut var_emails := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_statuses := rt.new_null()
	mut var_order_table := rt.new_null()
	mut var_identity_clause := rt.new_null()
	mut var_sql := rt.new_null()
	var_result = rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_customer_bought_product'), rt.new_null(), var_customer_email.clone(), var_user_id.clone(), var_product_id.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) {
		return (var_result).to_bool()
	}
	var_use_lookup_tables = rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_bought_product_use_lookup_tables'), rt.new_bool(false), var_customer_email.clone(), var_user_id.clone(), var_product_id.clone()])
	if rt.is_true(var_use_lookup_tables) {
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.get_transient_version(rt.new_string('woocommerce_reports'))
	var_cache_version = iife_result_4
	} else if rt.is_true(rt.identical(rt.new_string(''), var_customer_email)) && rt.is_true(var_user_id) {
	var_cache_version = wc_get_customer_order_count(var_user_id.clone())
	} else {
	mut iife_temp_5 := Class_WC_Cache_Helper{}
	mut iife_result_5 := iife_temp_5.get_transient_version(rt.new_string('orders'))
	var_cache_version = iife_result_5
	}
	var_aggregation_version = 'v2'
	var_cache_group = 'orders'
	var_cache_key = rt.new_string('wc_customer_bought_product_' + md5.hexhash((var_customer_email).str() + '-' + (var_user_id).str() + '-' + (var_use_lookup_tables).str() + '-' + var_aggregation_version))
	var_cache_value = rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string((var_cache_group).str()).clone()])
	if var_cache_value.array_isset(rt.new_string('value')) && var_cache_value.array_isset(rt.new_string('version')) && rt.is_true(rt.identical(var_cache_value.array_get(rt.new_string('version')), var_cache_version)) {
	var_result = var_cache_value.array_get(rt.new_string('value'))
	} else {
		var_user = rt.new_null()
		var_original_user_id = var_user_id.clone()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) && rt.is_true(var_customer_email) && rt.is_true(rt.call_function('is_email', [var_customer_email.clone()])) {
		var_user = rt.call_function('get_user_by', [rt.new_string('email'), var_customer_email.clone()])
		var_user_id = if !(rt.get_property(var_user, 'ID')).is_null() { rt.get_property(var_user, 'ID') } else { var_user_id }
		}
		if rt.is_true(var_user_id) && rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		var_user = rt.call_function('get_user_by', [rt.new_string('id'), var_user_id.clone()])
		var_user_id = if !(rt.get_property(var_user, 'ID')).is_null() { rt.get_property(var_user, 'ID') } else { var_user_id }
		}
		var_emails = rt.create_array([rt.ArrayItem{ key: none, val: var_customer_email }])
		if rt.is_true(var_original_user_id) {
			var_user_email = if !(rt.get_property(var_user, 'user_email')).is_null() { rt.get_property(var_user, 'user_email') } else { rt.new_string('') }
			if rt.is_true(var_user_email) && rt.is_true(rt.call_function('is_email', [var_user_email.clone()])) && rt.is_true(rt.identical(rt.new_string(var_user_email.clone().to_string().to_lower()), rt.new_string(var_customer_email.clone().to_string().to_lower()))) {
			var_emails = rt.new_array()
			}
		}
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(rt.is_true(var_email) && rt.is_true(rt.call_function('is_email', [var_email.clone()])))
			}
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(rt.is_true(var_email) && rt.is_true(rt.call_function('is_email', [var_email.clone()])))
			}
		var_emails = rt.call_function('array_unique', [rt.call_function('array_filter', [var_emails.clone(), rt.new_closure(closure_7_fn)])])
		if !rt.is_true(var_emails) && rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
			rt.call_function('wp_cache_set', [var_cache_key.clone(), rt.create_array([rt.ArrayItem{ key: 'version', val: var_cache_version }, rt.ArrayItem{ key: 'value', val: rt.new_array() }]), rt.new_string((var_cache_group).str()).clone(), rt.get_constant('MONTH_IN_SECONDS')])
			return false
		}
		var_emails = rt.call_function('array_map', [rt.new_string('esc_sql'), var_emails.clone()])
		var_statuses = rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{})])
		mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_8 := iife_temp_8.custom_orders_table_usage_is_enabled()
		if rt.is_true(iife_result_8) {
			closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_status := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_string("wc-${var_status.to_string()}")
				}
			closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_status := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_string("wc-${var_status.to_string()}")
				}
			var_statuses = rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_statuses.clone()])
			mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
			mut iife_result_11 := iife_temp_11.get_orders_table_name()
			var_order_table = iife_result_11
			var_identity_clause = rt.new_array()
			if rt.is_true(var_user_id) {
				var_identity_clause.array_push('orders.customer_id = ' + (rt.call_function('absint', [var_user_id.clone()])).str())
			}
			if !(!rt.is_true(var_emails)) {
				var_identity_clause.array_push('orders.billing_email IN ( \'' + (rt.call_function('implode', [rt.new_string('\',\''), var_emails.clone()])).str() + '\' )')
			}
			var_identity_clause = rt.call_function('implode', [rt.new_string(' OR '), var_identity_clause.clone()])
			if rt.is_true(var_use_lookup_tables) {
			var_sql = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT product_or_variation_id\n\t\t\t\tFROM (\n\t\t\t\t\tSELECT CASE WHEN product_id != 0 THEN product_id ELSE variation_id END AS product_or_variation_id\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_product_lookup lookup\n\t\t\t\t\t\tINNER JOIN ')), var_order_table), rt.new_string(' AS orders ON lookup.order_id = orders.ID\n\t\t\t\t\tWHERE orders.status IN ( \'')) + (rt.call_function('implode', [rt.new_string('\',\''), var_statuses.clone()])).str() + "' )\n\t\t\t\t\t\tAND ( ${var_identity_clause.to_string()} )\n\t\t\t\t) AS subquery\n\t\t\t\tWHERE product_or_variation_id != 0").str())
			} else {
			var_sql = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT itemmeta.meta_value\n\t\t\t\tFROM '), var_order_table), rt.new_string(' AS orders\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items AS items ON orders.id = items.order_id\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta AS itemmeta ON items.order_item_id = itemmeta.order_item_id\n\t\t\t\tWHERE orders.status IN ( \'')) + (rt.call_function('implode', [rt.new_string('\',\''), var_statuses.clone()])).str() + "' )\n\t\t\t\t\tAND itemmeta.meta_key   IN ( '_product_id', '_variation_id' )\n\t\t\t\t\tAND itemmeta.meta_value != '0'\n\t\t\t\t\tAND ( ${var_identity_clause.to_string()} )").str())
			}
		} else {
			var_identity_clause = rt.new_array()
			if rt.is_true(var_user_id) {
				var_identity_clause.array_push('( postmeta.meta_key = \'_customer_user\' AND postmeta.meta_value = \'' + (rt.call_function('absint', [var_user_id.clone()])).str() + '\' )')
			}
			if !(!rt.is_true(var_emails)) {
				var_identity_clause.array_push('( postmeta.meta_key = \'_billing_email\' AND postmeta.meta_value IN ( \'' + (rt.call_function('implode', [rt.new_string('\',\''), var_emails.clone()])).str() + '\' ) )')
			}
			var_identity_clause = rt.call_function('implode', [rt.new_string(' OR '), var_identity_clause.clone()])
			if rt.is_true(var_use_lookup_tables) {
			var_sql = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT product_or_variation_id\n\t\t\t\tFROM (\n\t\t\t\t\tSELECT CASE WHEN lookup.product_id != 0 THEN lookup.product_id ELSE lookup.variation_id END AS product_or_variation_id\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_product_lookup AS lookup\n\t\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts ON posts.ID = lookup.order_id\n\t\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta ON posts.ID = postmeta.post_id\n\t\t\t\t\tWHERE posts.post_status IN ( \'wc-')) + (rt.call_function('implode', [rt.new_string('\',\'wc-'), var_statuses.clone()])).str() + "' )\n\t\t\t\t\t\tAND ( ${var_identity_clause.to_string()} )\n\t\t\t\t) AS subquery\n\t\t\t\tWHERE product_or_variation_id != 0").str())
			} else {
			var_sql = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT itemmeta.meta_value\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items AS items\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta AS itemmeta ON items.order_item_id = itemmeta.order_item_id\n\t\t\t\tWHERE items.order_id IN (\n\t\t\t\t\t\tSELECT posts.ID as order_id\n\t\t\t\t\t\tFROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts\n\t\t\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta ON posts.ID = postmeta.post_id\n\t\t\t\t\t\tWHERE posts.post_type   = \'shop_order\'\n\t\t\t\t\t\t  AND posts.post_status IN ( \'wc-')) + (rt.call_function('implode', [rt.new_string('\',\'wc-'), var_statuses.clone()])).str() + "' )\n\t\t\t\t\t\t  AND ( ${var_identity_clause.to_string()} )\n\t\t\t\t)\n\t\t\t\tAND itemmeta.meta_key   IN ( '_product_id', '_variation_id' )\n\t\t\t\tAND itemmeta.meta_value != '0'").str())
			}
		}
		var_result = rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_wpdb, 'get_col', [var_sql.clone()])])
		rt.call_function('wp_cache_set', [var_cache_key.clone(), rt.create_array([rt.ArrayItem{ key: 'version', val: var_cache_version }, rt.ArrayItem{ key: 'value', val: var_result }]), rt.new_string((var_cache_group).str()).clone(), rt.get_constant('MONTH_IN_SECONDS')])
	}
	return (rt.call_function('in_array', [rt.call_function('absint', [var_product_id.clone()]), var_result.clone(), rt.new_bool(true)])).to_bool()
}

fn wc_current_user_has_role(var_role rt.PhpVal) rt.PhpVal {
	return rt.new_bool(wc_user_has_role(rt.call_function('wp_get_current_user', []rt.PhpVal{}), var_role.clone()))
}

fn wc_user_has_role(var_user_arg rt.PhpVal, var_role rt.PhpVal) bool {
	mut var_user := var_user_arg
	if !(var_user.clone().is_object()) {
	var_user = rt.call_function('get_userdata', [var_user.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return false
	}
	return (rt.call_function('in_array', [var_role.clone(), rt.get_property(var_user, 'roles'), rt.new_bool(true)])).to_bool()
}

fn wc_customer_has_capability(var_allcaps rt.PhpVal, var_caps rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_user_id := rt.new_null()
	mut var_order := rt.new_null()
	mut var_order_id := rt.new_null()
	mut var_download := rt.new_null()
	if var_caps.array_isset(rt.new_int(0)) {
		mut switch_val_1 := var_caps.array_get(rt.new_int(0))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('view_order'))) {
			var_user_id = rt.new_int(var_args.array_get(rt.new_int(1)).to_i64())
			var_order = rt.call_function('wc_get_order', [var_args.array_get(rt.new_int(2))])
			if rt.is_true(var_order) && rt.is_true(rt.identical(var_user_id, rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}))) {
				var_allcaps['view_order'] = true
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pay_for_order'))) {
			var_user_id = rt.new_int(var_args.array_get(rt.new_int(1)).to_i64())
			var_order_id = if var_args.array_isset(rt.new_int(2)) { var_args.array_get(rt.new_int(2)) } else { rt.new_null() }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
				var_allcaps['pay_for_order'] = true
			}
			var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
			if rt.is_true(var_order) && rt.is_true(rt.identical(var_user_id, rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}))))) {
				var_allcaps['pay_for_order'] = true
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order_again'))) {
			var_user_id = rt.new_int(var_args.array_get(rt.new_int(1)).to_i64())
			var_order = rt.call_function('wc_get_order', [var_args.array_get(rt.new_int(2))])
			if rt.is_true(var_order) && rt.is_true(rt.identical(var_user_id, rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}))) {
				var_allcaps['order_again'] = true
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cancel_order'))) {
			var_user_id = rt.new_int(var_args.array_get(rt.new_int(1)).to_i64())
			var_order = rt.call_function('wc_get_order', [var_args.array_get(rt.new_int(2))])
			if rt.is_true(var_order) && rt.is_true(rt.identical(var_user_id, rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}))) {
				var_allcaps['cancel_order'] = true
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download_file'))) {
			var_user_id = rt.new_int(var_args.array_get(rt.new_int(1)).to_i64())
			var_download = var_args.array_get(rt.new_int(2))
			if rt.is_true(var_download) && rt.is_true(rt.identical(var_user_id, rt.call_method(var_download, 'get_user_id', []rt.PhpVal{}))) {
				var_allcaps['download_file'] = true
			}
		}
	}
	return var_allcaps.clone()
}

fn wc_shop_manager_has_capability(var_allcaps rt.PhpVal, var_caps rt.PhpVal, var_args rt.PhpVal, var_user rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(wc_user_has_role(var_user.clone(), rt.new_string('shop_manager')))) {
		var_allcaps['edit_users'] = true
	}
	return var_allcaps.clone()
}

fn wc_modify_editable_roles(var_roles rt.PhpVal) rt.PhpVal {
	mut var_shop_manager_editable_roles := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_super_admin', []rt.PhpVal{})) {
		return var_roles.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(wc_current_user_has_role(rt.new_string('administrator')))))) {
		var_roles.delete('administrator')
		if rt.is_true(wc_current_user_has_role(rt.new_string('shop_manager'))) {
			var_shop_manager_editable_roles = rt.call_function('apply_filters', [rt.new_string('woocommerce_shop_manager_editable_roles'), rt.create_array([rt.ArrayItem{ key: none, val: 'customer' }])])
			return rt.call_function('array_intersect_key', [rt.create_array_from_native_map(var_roles), rt.call_function('array_flip', [var_shop_manager_editable_roles.clone()])])
		}
	}
	return var_roles.clone()
}

fn wc_modify_map_meta_cap(var_caps rt.PhpVal, var_cap rt.PhpVal, var_user_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_userdata := rt.new_null()
	mut var_shop_manager_editable_roles := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_super_admin', []rt.PhpVal{})) {
		return var_caps.clone()
	}
	mut switch_val_2 := var_cap
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('edit_user'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('remove_user'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('promote_user'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('delete_user'))) {
		if !(var_args.array_isset(rt.new_int(0))) || rt.is_true(rt.identical(var_args.array_get(rt.new_int(0)), var_user_id)) {
		} else if rt.is_true(rt.new_bool(!(rt.is_true(wc_current_user_has_role(rt.new_string('administrator')))))) {
			if rt.is_true(rt.new_bool(wc_user_has_role(var_args.array_get(rt.new_int(0)), rt.new_string('administrator')))) {
				var_caps.array_push('do_not_allow')
			} else if rt.is_true(wc_current_user_has_role(rt.new_string('shop_manager'))) {
				var_userdata = rt.call_function('get_userdata', [var_args.array_get(rt.new_int(0))])
				var_shop_manager_editable_roles = rt.call_function('apply_filters', [rt.new_string('woocommerce_shop_manager_editable_roles'), rt.create_array([rt.ArrayItem{ key: none, val: 'customer' }])])
				if rt.is_true(rt.call_function('property_exists', [var_userdata.clone(), rt.new_string('roles')])) && !(!rt.is_true(rt.get_property(var_userdata, 'roles'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_intersect', [rt.get_property(var_userdata, 'roles'), var_shop_manager_editable_roles.clone()]))))) {
					var_caps.array_push('do_not_allow')
				}
			}
		}
	}
	return var_caps.clone()
}

fn wc_get_customer_download_permissions(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_data_store := rt.new_null()
	mut iife_temp_12 := Class_WC_Data_Store{}
	mut iife_result_12 := iife_temp_12.load(rt.new_string('customer-download'))
	var_data_store = iife_result_12
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_permission_list'), rt.call_method(var_data_store, 'get_downloads_for_customer', [var_customer_id.clone()]), var_customer_id.clone()])
	return rt.new_null()
}

fn wc_get_customer_available_downloads(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_downloads := []rt.PhpVal{}
	mut var__product := rt.new_null()
	mut var_order := rt.new_null()
	mut var_file_number := i64(0)
	mut var_results := rt.new_null()
	mut var_result := rt.new_null()
	mut var_order_id := i64(0)
	mut var_product_id := i64(0)
	mut var_download_file := rt.new_null()
	mut var_download_name := rt.new_null()
	var_downloads = rt.new_array()
	var__product = rt.new_null()
	var_order = rt.new_null()
	var_file_number = 0
	var_results = wc_get_customer_download_permissions(var_customer_id.clone())
	if rt.is_true(var_results) {
		mut iter_2 := var_results.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_result_shadow := item_2.val
			var_order_id = rt.get_property(var_result_shadow, 'order_id').to_i64()
			if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.new_int(var_order_id))))) {
			var_order = rt.call_function('wc_get_order', [rt.new_int(var_order_id).clone()])
			var__product = rt.new_null()
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{}))))) {
				continue
			}
			var_product_id = rt.get_property(var_result_shadow, 'product_id').to_i64()
			if rt.is_true(rt.new_bool(!(rt.is_true(var__product)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var__product, 'get_id', []rt.PhpVal{}), rt.new_int(var_product_id))))) {
			var_file_number = 0
			var__product = rt.call_function('wc_get_product', [rt.new_int(var_product_id).clone()])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var__product)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var__product, 'exists', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var__product, 'has_file', [rt.get_property(var_result_shadow, 'download_id')]))))) {
				continue
			}
			var_download_file = rt.call_method(var__product, 'get_file', [rt.get_property(var_result_shadow, 'download_id')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_download_file, 'get_enabled', []rt.PhpVal{}))))) {
				continue
			}
			var_download_name = rt.call_function('apply_filters', [rt.new_string('woocommerce_downloadable_product_name'), var_download_file.array_get(rt.new_string('name')), var__product.clone(), rt.get_property(var_result_shadow, 'download_id'), rt.new_int(var_file_number).clone()])
			var_downloads << rt.create_array([rt.ArrayItem{ key: 'download_url', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'download_file', val: var_product_id }, rt.ArrayItem{ key: 'order', val: rt.get_property(var_result_shadow, 'order_key') }, rt.ArrayItem{ key: 'email', val: rt.call_function('rawurlencode', [rt.get_property(var_result_shadow, 'user_email')]) }, rt.ArrayItem{ key: 'key', val: rt.get_property(var_result_shadow, 'download_id') }]), rt.call_function('home_url', [rt.new_string('/')])]) }, rt.ArrayItem{ key: 'download_id', val: rt.get_property(var_result_shadow, 'download_id') }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(var__product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_name', val: rt.call_method(var__product, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_url', val: if rt.is_true(rt.call_method(var__product, 'is_visible', []rt.PhpVal{})) { rt.call_method(var__product, 'get_permalink', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'download_name', val: var_download_name }, rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_key', val: rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloads_remaining', val: rt.get_property(var_result_shadow, 'downloads_remaining') }, rt.ArrayItem{ key: 'access_expires', val: rt.get_property(var_result_shadow, 'access_expires') }, rt.ArrayItem{ key: 'file', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_download_file, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'file', val: rt.call_method(var_download_file, 'get_file', []rt.PhpVal{}) }]) }])
			var_file_number += 1
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_available_downloads'), rt.create_array_from_list(var_downloads), var_customer_id.clone()])
}

fn wc_get_customer_total_spent(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_customer := rt.new_null()
	var_customer = create_wc_customer(var_user_id.clone())
	return rt.call_method(var_customer, 'get_total_spent', []rt.PhpVal{})
}

fn wc_get_customer_order_count(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_customer := rt.new_null()
	var_customer = create_wc_customer(var_user_id.clone())
	return rt.call_method(var_customer, 'get_order_count', []rt.PhpVal{})
}

fn wc_reset_order_customer_id_on_deleted_user(var_user_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_table_ds := rt.new_null()
	mut var_order_table := rt.new_null()
	mut iife_temp_13 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_13 := iife_temp_13.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_13) {
		var_order_table_ds = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class()])
		mut iife_temp_14 := Class_{"nodeType":"Expr_Variable","line":902,"name":"order_table_ds"}{}
		mut iife_result_14 := iife_temp_14.get_orders_table_name()
		var_order_table = iife_result_14
		rt.call_method(var_wpdb, 'update', [var_order_table.clone(), rt.create_array([rt.ArrayItem{ key: 'customer_id', val: 0 }, rt.ArrayItem{ key: 'date_updated_gmt', val: rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]) }]), rt.create_array([rt.ArrayItem{ key: 'customer_id', val: var_user_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	}
	mut iife_temp_15 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_15 := iife_temp_15.custom_orders_table_usage_is_enabled()
	mut iife_temp_16 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_16 := iife_temp_16.is_custom_order_tables_in_sync()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_15)))) || rt.is_true(iife_result_16) {
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 0 }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_customer_user' }, rt.ArrayItem{ key: 'meta_value', val: var_user_id }])])
	}
}

fn wc_review_is_from_verified_owner(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_verified := rt.new_null()
	var_verified = rt.call_function('get_comment_meta', [var_comment_id.clone(), rt.new_string('verified'), rt.new_bool(true)])
	mut iife_temp_17 := Class_WC_Comments{}
	mut iife_result_17 := iife_temp_17.add_comment_purchase_verification(var_comment_id.clone())
	return if rt.is_true(rt.identical(rt.new_string(''), var_verified)) { iife_result_17 } else { (var_verified).to_bool() }
}

fn wc_disable_author_archives_for_customers() {
	mut var_author := rt.new_null()
	mut var_user := rt.new_null()
	if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
		var_user = rt.call_function('get_user_by', [rt.new_string('id'), var_author.clone()])
		if rt.is_true(rt.call_function('user_can', [var_user.clone(), rt.new_string('customer')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('user_can', [var_user.clone(), rt.new_string('edit_posts')]))))) {
			rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])])
			exit(0)
		}
	}
}

fn wc_update_profile_last_update_time(var_user_id rt.PhpVal, var_old rt.PhpVal) {
	wc_set_user_last_update_time(var_user_id.clone())
}

fn wc_meta_update_last_update_time(var_meta_id rt.PhpVal, var_user_id rt.PhpVal, var_meta_key rt.PhpVal, var__meta_value rt.PhpVal) {
	mut var_keys_to_track := rt.new_null()
	mut var_update_time := false
	var_keys_to_track = rt.call_function('apply_filters', [rt.new_string('woocommerce_user_last_update_fields'), rt.create_array([rt.ArrayItem{ key: none, val: 'first_name' }, rt.ArrayItem{ key: none, val: 'last_name' }])])
	var_update_time = if rt.is_true(rt.call_function('in_array', [var_meta_key.clone(), var_keys_to_track.clone(), rt.new_bool(true)])) { true } else { false }
	var_update_time = if rt.is_true(rt.identical(rt.new_string('billing_'), rt.call_function('substr', [var_meta_key.clone(), rt.new_int(0), rt.new_int(8)]))) { true } else { var_update_time }
	var_update_time = if rt.is_true(rt.identical(rt.new_string('shipping_'), rt.call_function('substr', [var_meta_key.clone(), rt.new_int(0), rt.new_int(9)]))) { true } else { var_update_time }
	if var_update_time {
		wc_set_user_last_update_time(var_user_id.clone())
	}
}

fn wc_set_user_last_update_time(var_user_id rt.PhpVal) {
	rt.call_function('update_user_meta', [var_user_id.clone(), rt.new_string('last_update'), rt.call_function('gmdate', [rt.new_string('U')])])
}

fn wc_get_customer_saved_methods_list(var_customer_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_saved_payment_methods_list'), rt.new_array(), var_customer_id.clone()])
	return rt.new_null()
}

fn wc_get_customer_last_order(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_customer := rt.new_null()
	var_customer = create_wc_customer(var_customer_id.clone())
	return rt.call_method(var_customer, 'get_last_order', []rt.PhpVal{})
}

fn wc_delete_user_data(var_user_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_payment_tokens := rt.new_null()
	mut var_payment_token := rt.new_null()
	rt.call_method(var_wpdb, 'delete', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_sessions'), rt.create_array([rt.ArrayItem{ key: 'session_key', val: var_user_id }])])
	rt.call_method(var_wpdb, 'delete', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys'), rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id }])])
	mut iife_temp_18 := Class_WC_Payment_Tokens{}
	mut iife_result_18 := iife_temp_18.get_customer_tokens(var_user_id.clone())
	var_payment_tokens = iife_result_18
	mut iter_3 := var_payment_tokens.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_payment_token_shadow := item_3.val
		rt.call_method(var_payment_token_shadow, 'delete', []rt.PhpVal{})
	}
}

fn wc_maybe_store_user_agent(var_user_login rt.PhpVal, var_user rt.PhpVal) {
	mut var_admin_user_agents := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'), rt.new_string('no')]))) && rt.is_true(rt.call_function('user_can', [var_user.clone(), rt.new_string('manage_woocommerce')])) {
		var_admin_user_agents = rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_option', [rt.new_string('woocommerce_tracker_ua'), rt.new_array()]))])
		var_admin_user_agents.array_push(rt.call_function('wc_get_user_agent', []rt.PhpVal{}))
		rt.call_function('update_option', [rt.new_string('woocommerce_tracker_ua'), rt.call_function('array_unique', [var_admin_user_agents.clone()]), rt.new_bool(false)])
	}
}

fn wc_user_logged_in(var_user_login rt.PhpVal, var_user rt.PhpVal) {
	wc_update_user_last_active(rt.get_property(var_user, 'ID'))
	rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'), rt.new_string('_woocommerce_load_saved_cart_after_login'), rt.new_int(1)])
}

fn wc_current_user_is_active() {
	wc_update_user_last_active(rt.call_function('get_current_user_id', []rt.PhpVal{}))
}

fn wc_update_user_last_active(var_user_id rt.PhpVal) {
	mut var_threshold := rt.new_null()
	mut var_now := rt.new_null()
	mut var_last_active := rt.new_null()
	if rt.is_true(var_user_id) {
		var_threshold = rt.get_constant('MINUTE_IN_SECONDS')
		if rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_login')])) {
		var_threshold = rt.new_int(0)
		} else if rt.is_true(rt.call_function('doing_action', [rt.new_string('wp')])) {
		var_threshold = rt.mul(rt.new_int(5), rt.get_constant('MINUTE_IN_SECONDS'))
		}
		var_threshold = rt.new_int((rt.call_function('apply_filters', [rt.new_string('woocommerce_update_user_last_active_threshold'), var_threshold.clone()])).to_i64())
		var_now = rt.call_function('time', []rt.PhpVal{})
		var_last_active = rt.call_function('get_user_meta', [var_user_id.clone(), rt.new_string('wc_last_active'), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_last_active)))) || rt.is_true(rt.greater(rt.sub(var_now, var_last_active), var_threshold)) {
			rt.call_function('update_user_meta', [var_user_id.clone(), rt.new_string('wc_last_active'), rt.new_string((var_now).str()), rt.new_string((var_last_active).str())])
		}
	}
}

fn wc_translate_user_roles(var_translation rt.PhpVal, var_text rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.new_string('5.2'), rt.new_string('<')])) {
		return var_translation.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('User role'), var_context)) && rt.is_true(rt.call_function('in_array', [var_text.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'Shop manager' }, rt.ArrayItem{ key: none, val: 'Customer' }]), rt.new_bool(true)])) {
		return rt.call_function('translate_user_role', [var_text.clone(), rt.new_string('woocommerce')])
	}
	return var_translation.clone()
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

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_{"nodeType":"Expr_Variable","line":902,"name":"order_table_ds"} {
	rt.PhpObjectBase
}

struct Class_WC_Comments {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_{"nodetype":"expr_variable","line":902,"name":"order_table_ds"}(_args ...rt.PhpVal) &Class_{"nodeType":"Expr_Variable","line":902,"name":"order_table_ds"} {
	mut obj := &Class_{"nodeType":"Expr_Variable","line":902,"name":"order_table_ds"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_comments(_args ...rt.PhpVal) &Class_WC_Comments {
	mut obj := &Class_WC_Comments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_tokens(_args ...rt.PhpVal) &Class_WC_Payment_Tokens {
	mut obj := &Class_WC_Payment_Tokens{
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


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_{"nodeType":"Expr_Variable","line":902,"name":"order_table_ds"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_{"nodeType":"Expr_Variable","line":902,"name":"order_table_ds"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_{"nodeType":"Expr_Variable","line":902,"name":"order_table_ds"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Comments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Comments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Comments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Payment_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	rt.call_function('add_filter', [rt.new_string('show_admin_bar'), rt.new_string('wc_disable_admin_bar'), rt.new_int(10), rt.new_int(1)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_create_new_customer')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_payment_complete'), rt.new_string('wc_paying_customer')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.new_string('wc_paying_customer')])
	rt.call_function('add_filter', [rt.new_string('user_has_cap'), rt.new_string('wc_customer_has_capability'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('user_has_cap'), rt.new_string('wc_shop_manager_has_capability'), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('editable_roles'), rt.new_string('wc_modify_editable_roles')])
	rt.call_function('add_filter', [rt.new_string('map_meta_cap'), rt.new_string('wc_modify_map_meta_cap'), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('deleted_user'), rt.new_string('wc_reset_order_customer_id_on_deleted_user')])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_disable_author_archives_for_customers')])
	rt.call_function('add_action', [rt.new_string('profile_update'), rt.new_string('wc_update_profile_last_update_time'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('update_user_meta'), rt.new_string('wc_meta_update_last_update_time'), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('delete_user'), rt.new_string('wc_delete_user_data')])
	rt.call_function('add_action', [rt.new_string('wp_login'), rt.new_string('wc_maybe_store_user_agent'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_login'), rt.new_string('wc_user_logged_in'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp'), rt.new_string('wc_current_user_is_active'), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('gettext_with_context_default'), rt.new_string('wc_translate_user_roles'), rt.new_int(10), rt.new_int(3)])
}
