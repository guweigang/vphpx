import rt

struct Class_WC_Customer_Data_Store {
	rt.PhpObjectBase
pub mut:
		internal_meta_keys rt.PhpVal = rt.new_array()
		meta_type rt.PhpVal = rt.new_string('user')
}

fn (mut this Class_WC_Customer_Data_Store) exclude_internal_meta_keys(var_meta rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_prefix := if rt.is_true(rt.get_property(var_wpdb, 'prefix')) { rt.get_property(var_wpdb, 'prefix') } else { rt.new_string('wp_') }
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'meta_key'), this.internal_meta_keys, rt.new_bool(true)]))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [rt.get_property(var_meta, 'meta_key'), var_table_prefix.dup()]))))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn (mut this Class_WC_Customer_Data_Store) create(var_customer rt.PhpVal)  {
	mut var_id := rt.call_function('wc_create_new_customer', [rt.call_method(var_customer, 'get_email', []rt.PhpVal{}), rt.call_method(var_customer, 'get_username', []rt.PhpVal{}), rt.call_method(var_customer, 'get_password', []rt.PhpVal{})])
	if rt.is_true(rt.call_function('is_wp_error', [var_id.dup()])) {
		rt.throw_exception(rt.new_object('WC_Data_Exception', []string{}, create_wc_data_exception(rt.call_method(var_id, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_id, 'get_error_message', []rt.PhpVal{}))))
	}
	rt.call_method(var_customer, 'set_id', [var_id.dup()])
	mut var_wp_user := create_wp_user(var_id.dup())
	if rt.is_true(var_wp_user.exists()) {
		rt.call_method(var_customer, 'set_username', [rt.get_property(var_wp_user, 'user_login')])
		rt.call_method(var_customer, 'set_date_created', [rt.get_property(var_wp_user, 'user_registered')])
	}
	this.update_user_meta(var_customer.dup())
	rt.call_method(var_customer, 'set_password', [rt.new_string('')])
	rt.call_function('wp_update_user', [rt.call_function('apply_filters', [rt.new_string('woocommerce_update_customer_args'), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_customer, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'role', val: rt.call_method(var_customer, 'get_role', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'display_name', val: rt.call_method(var_customer, 'get_display_name', []rt.PhpVal{}) }]), var_customer.dup()])])
	rt.call_method(var_customer, 'set_date_modified', [rt.call_function('get_user_meta', [rt.call_method(var_customer, 'get_id', []rt.PhpVal{}), rt.new_string('last_update'), rt.new_bool(true)])])
	rt.call_method(var_customer, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_customer, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_new_customer'), rt.call_method(var_customer, 'get_id', []rt.PhpVal{}), var_customer.dup()])
}

fn (mut this Class_WC_Customer_Data_Store) read(var_customer rt.PhpVal)  {
	mut var_user_object := if rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{})) { rt.call_function('get_user_by', [rt.new_string('id'), rt.call_method(var_customer, 'get_id', []rt.PhpVal{})]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user_object)))) || !rt.is_true(rt.get_property(var_user_object, 'ID')))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid customer.'), rt.new_string('woocommerce')]))))
	}
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut var_user_meta := rt.call_function('array_diff_key', [rt.call_function('array_change_key_case', [rt.call_function('array_map', [rt.new_string('wc_flatten_meta_callback'), rt.call_function('get_user_meta', [var_customer_id.dup()])])]), rt.call_function('array_flip', [rt.create_array([rt.ArrayItem{ key: none, val: 'country' }, rt.ArrayItem{ key: none, val: 'state' }, rt.ArrayItem{ key: none, val: 'postcode' }, rt.ArrayItem{ key: none, val: 'city' }, rt.ArrayItem{ key: none, val: 'address' }, rt.ArrayItem{ key: none, val: 'address_2' }, rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'location' }])]), rt.call_function('array_change_key_case', [rt.cast_array(rt.get_property(var_user_object, 'data'))])])
	rt.call_method(var_customer, 'set_props', [var_user_meta.dup()])
	rt.call_method(var_customer, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'is_paying_customer', val: rt.call_function('get_user_meta', [var_customer_id.dup(), rt.new_string('paying_customer'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'email', val: rt.get_property(var_user_object, 'user_email') }, rt.ArrayItem{ key: 'username', val: rt.get_property(var_user_object, 'user_login') }, rt.ArrayItem{ key: 'display_name', val: rt.get_property(var_user_object, 'display_name') }, rt.ArrayItem{ key: 'date_created', val: rt.get_property(var_user_object, 'user_registered') }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('get_user_meta', [var_customer_id.dup(), rt.new_string('last_update'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'role', val: if !(!rt.is_true(rt.get_property(var_user_object, 'roles').array_get(0))) { rt.get_property(var_user_object, 'roles').array_get(0) } else { rt.new_string('customer') } }])])
	rt.call_method(var_customer, 'read_meta_data', []rt.PhpVal{})
	rt.call_method(var_customer, 'set_object_read', [rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('woocommerce_customer_loaded'), var_customer.dup()])
}

fn (mut this Class_WC_Customer_Data_Store) update(var_customer rt.PhpVal)  {
	rt.call_function('wp_update_user', [rt.call_function('apply_filters', [rt.new_string('woocommerce_update_customer_args'), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_customer, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'user_email', val: rt.call_method(var_customer, 'get_email', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'display_name', val: rt.call_method(var_customer, 'get_display_name', []rt.PhpVal{}) }]), var_customer.dup()])])
	if rt.is_true(rt.call_method(var_customer, 'get_password', []rt.PhpVal{})) {
		rt.call_function('wp_update_user', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_customer, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'user_pass', val: rt.call_method(var_customer, 'get_password', []rt.PhpVal{}) }])])
		rt.call_method(var_customer, 'set_password', [rt.new_string('')])
	}
	this.update_user_meta(var_customer.dup())
	rt.call_method(var_customer, 'set_date_modified', [rt.call_function('get_user_meta', [rt.call_method(var_customer, 'get_id', []rt.PhpVal{}), rt.new_string('last_update'), rt.new_bool(true)])])
	rt.call_method(var_customer, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_customer, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_update_customer'), rt.call_method(var_customer, 'get_id', []rt.PhpVal{}), var_customer.dup()])
}

fn (mut this Class_WC_Customer_Data_Store) delete(var_customer rt.PhpVal, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'reassign', val: 0 }])])
	mut var_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	rt.call_function('wp_delete_user', [var_id.dup(), var_args_mutated.array_get('reassign')])
	rt.call_function('do_action', [rt.new_string('woocommerce_delete_customer'), var_id.dup()])
}

fn (mut this Class_WC_Customer_Data_Store) update_user_meta(var_customer rt.PhpVal)  {
	mut var_updated_props := []rt.PhpVal{}
	mut var_changed_props := rt.call_method(var_customer, 'get_changes', []rt.PhpVal{})
	mut var_meta_key_to_props := { 'paying_customer': 'is_paying_customer', 'first_name': 'first_name', 'last_name': 'last_name' }
	for var_meta_key, var_prop in var_meta_key_to_props {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changed_props.dup().array_isset(rt.new_string(prop))))))) {
			continue
		}
		if rt.is_true(rt.call_function('update_user_meta', [rt.call_method(var_customer, 'get_id', []rt.PhpVal{}), rt.new_string(meta_key), rt.call_method(var_customer, "get_${var_prop}", [rt.new_string('edit')])])) {
			var_updated_props << rt.new_string(prop).dup()
		}
	}
	mut var_billing_address_props := { 'billing_first_name': 'billing_first_name', 'billing_last_name': 'billing_last_name', 'billing_company': 'billing_company', 'billing_address_1': 'billing_address_1', 'billing_address_2': 'billing_address_2', 'billing_city': 'billing_city', 'billing_state': 'billing_state', 'billing_postcode': 'billing_postcode', 'billing_country': 'billing_country', 'billing_email': 'billing_email', 'billing_phone': 'billing_phone' }
	for var_meta_key, var_prop in var_billing_address_props {
		mut var_prop_key := rt.call_function('substr', [rt.new_string(prop), rt.new_int(8)])
		if rt.is_true(rt.new_bool(!(var_changed_props.array_isset(rt.new_string('billing'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changed_props.array_get('billing').array_isset(var_prop_key.dup())))))))) {
			continue
		}
		if rt.is_true(rt.call_function('update_user_meta', [rt.call_method(var_customer, 'get_id', []rt.PhpVal{}), rt.new_string(meta_key), rt.call_method(var_customer, "get_${var_prop}", [rt.new_string('edit')])])) {
			var_updated_props << rt.new_string(prop).dup()
		}
	}
	mut var_shipping_address_props := { 'shipping_first_name': 'shipping_first_name', 'shipping_last_name': 'shipping_last_name', 'shipping_company': 'shipping_company', 'shipping_address_1': 'shipping_address_1', 'shipping_address_2': 'shipping_address_2', 'shipping_city': 'shipping_city', 'shipping_state': 'shipping_state', 'shipping_postcode': 'shipping_postcode', 'shipping_country': 'shipping_country', 'shipping_phone': 'shipping_phone' }
	for var_meta_key, var_prop in var_shipping_address_props {
		mut var_prop_key := rt.call_function('substr', [rt.new_string(prop), rt.new_int(9)])
		if rt.is_true(rt.new_bool(!(var_changed_props.array_isset(rt.new_string('shipping'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changed_props.array_get('shipping').array_isset(var_prop_key.dup())))))))) {
			continue
		}
		if rt.is_true(rt.call_function('update_user_meta', [rt.call_method(var_customer, 'get_id', []rt.PhpVal{}), rt.new_string(meta_key), rt.call_method(var_customer, "get_${var_prop}", [rt.new_string('edit')])])) {
			var_updated_props << rt.new_string(prop).dup()
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_customer_object_updated_props'), var_customer.dup(), var_updated_props.dup()])
}

fn (mut this Class_WC_Customer_Data_Store) is_cot_in_use() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Customer_Data_Store) get_last_order(var_customer rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut var_last_order_id := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_last_order'), rt.new_bool(true))
	mut var_last_customer_order := rt.new_bool(rt.new_bool(false))
	if !(!rt.is_true(var_last_order_id)) {
		var_last_customer_order = rt.call_function('wc_get_order', [var_last_order_id.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_last_customer_order, 'WC_Order')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_last_order_id = rt.new_string(rt.new_string(''))
	}
	var_last_order_id = rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_get_last_order'), var_last_order_id.dup(), var_customer.dup()])
	if rt.is_true(rt.identical(rt.new_string(''), var_last_order_id)) {
		// unsupported statement: Stmt_Global
		mut var_order_statuses_sql := rt.new_string('( \'' + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{}))])])).str() + '\' )')
		if this.is_cot_in_use() {
			mut var_sql := rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT id FROM %i WHERE customer_id = %d AND status IN ${var_order_statuses_sql.to_string()} ORDER BY id DESC LIMIT 1"), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}; return temp.get_orders_table_name() }(), var_customer_id.dup()])
			var_last_order_id = rt.call_method(var_wpdb, 'get_var', [var_sql.dup()])
		} else {
			var_last_order_id = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT posts.ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta on posts.ID = meta.post_id\n\t\t\t\tWHERE meta.meta_key   = \'_customer_user\'\n\t\t\t\tAND   meta.meta_value = \'')) + (rt.call_function('esc_sql', [var_customer_id.dup()])).str() + "'\n\t\t\t\tAND   posts.post_type = 'shop_order'\n\t\t\t\tAND   posts.post_status IN ${var_order_statuses_sql.to_string()}\n\t\t\t\tORDER BY posts.ID DESC\n\t\t\t\tLIMIT 1"])
		}
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.update_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_last_order'), var_last_order_id.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_order_id)))) {
		return false
	}
	return (rt.call_function('wc_get_order', [rt.call_function('absint', [var_last_order_id.dup()])])).to_bool()
}

fn (mut this Class_WC_Customer_Data_Store) get_order_count(var_customer rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut var_count := rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_get_order_count'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_order_count'), rt.new_bool(true)), var_customer.dup()])
	mut var_order_statuses_sql := rt.new_string('( \'' + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{}))])])).str() + '\' )')
	if rt.is_true(rt.identical(rt.new_string(''), var_count)) {
		// unsupported statement: Stmt_Global
		if this.is_cot_in_use() {
			mut var_sql := rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT COUNT(id) FROM %i WHERE customer_id = %d AND status IN ${var_order_statuses_sql.to_string()}"), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}; return temp.get_orders_table_name() }(), var_customer_id.dup()])
			var_count = rt.call_method(var_wpdb, 'get_var', [var_sql.dup()])
		} else {
			var_count = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*)\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta ON posts.ID = meta.post_id\n\t\t\t\tWHERE   meta.meta_key   = \'_customer_user\'\n\t\t\t\tAND     posts.post_type = \'shop_order\'\n\t\t\t\tAND     posts.post_status IN ')), var_order_statuses_sql), rt.new_string('\n\t\t\t\tAND     meta_value = \'')) + (rt.call_function('esc_sql', [var_customer_id.dup()])).str() + '\''])
		}
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.update_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_order_count'), var_count.dup())
	}
	return rt.call_function('absint', [var_count.dup()])
}

fn (mut this Class_WC_Customer_Data_Store) get_total_spent(var_customer rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut var_spent := rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_get_total_spent'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_money_spent'), rt.new_bool(true)), var_customer.dup()])
	if rt.is_true(rt.identical(rt.new_string(''), var_spent)) {
		// unsupported statement: Stmt_Global
		mut var_statuses := rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{})])
		mut var_statuses_sql := rt.new_string('( \'wc-' + (rt.call_function('implode', [rt.new_string('\',\'wc-'), var_statuses.dup()])).str() + '\' )')
		if this.is_cot_in_use() {
			mut var_sql := rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT SUM(total_amount) FROM %i WHERE customer_id = %d AND status IN ${var_statuses_sql.to_string()}"), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}; return temp.get_orders_table_name() }(), var_customer_id.dup()])
		} else {
			mut var_has_sql_modification_filter := rt.call_function('has_filter', [rt.new_string('woocommerce_customer_get_total_spent_query')])
			if rt.is_true(var_has_sql_modification_filter) {
				var_sql = rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(, ), ), ), ), ), ) + (rt.call_function('esc_sql', [var_customer_id.dup()])).str() + "'\n\t\t\t\t\tAND     posts.post_type     = 'shop_order'\n\t\t\t\t\tAND     posts.post_status   IN ${var_statuses_sql.to_string()}\n\t\t\t\t\tAND     meta2.meta_key      = '_order_total'")
			} else {
				var_sql = rt.new_string( + (rt.call_function('esc_sql', [.dup()])).str() + "'\n\t\t\t\t\t\t\t\t  AND posts.post_type     = 'shop_order'\n\t\t\t\t\t\t\t\t  AND posts.post_status IN ${var_statuses_sql.to_string()}\n\t\t\t\t\t)\n\t\t\t\t\tAND postmeta.meta_key = '_order_total'")
			}
		}
		var_sql = rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_get_total_spent_query'), var_sql.dup(), var_customer.dup()])
		var_spent = rt.call_method(var_wpdb, 'get_var', [var_sql.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_spent)))) {
			var_spent = rt.new_int(rt.new_int(0))
		}
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.update_site_user_meta(arg_0, arg_1, arg_2) }(var_customer_id.dup(), rt.new_string('wc_money_spent'), var_spent.dup())
	}
	return rt.call_function('wc_format_decimal', [var_spent.dup(), rt.new_int(2)])
}

fn (mut this Class_WC_Customer_Data_Store) search_customers(var_term rt.PhpVal, limit string) rt.PhpVal {
	mut var_results := 
	if rt.is_true() {
	}
	
}

fn (mut this Class_WC_Customer_Data_Store) get_user_ids_for_billing_email(var_emails rt.PhpVal) rt.PhpVal {
	mut var_emails_mutated := var_emails
}

fn (mut this Class_WC_Customer_Data_Store) query_customers(mut var_args Class_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_WC_Data_Exception {
	rt.PhpObjectBase
}

struct Class_WP_User {
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

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

fn create_wc_customer_data_store() &Class_WC_Customer_Data_Store {
	mut obj := &Class_WC_Customer_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
		internal_meta_keys: rt.new_array()
		meta_type: rt.new_string('user')
	}
	return obj
}

fn create_wc_data_store_wp() &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_exception() &Class_WC_Data_Exception {
	mut obj := &Class_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user() &Class_WP_User {
	mut obj := &Class_WP_User{
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

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'exclude_internal_meta_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.exclude_internal_meta_keys(dispatch_arg_0))
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_user_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_user_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'is_cot_in_use' {
			return rt.new_bool(this.is_cot_in_use())
		}
		'get_last_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_last_order(dispatch_arg_0))
		}
		'get_order_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_count(dispatch_arg_0)
		}
		'get_total_spent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_spent(dispatch_arg_0)
		}
		'search_customers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.search_customers(dispatch_arg_0, dispatch_arg_1)
		}
		'get_user_ids_for_billing_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_user_ids_for_billing_email(dispatch_arg_0)
		}
		'query_customers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.query_customers(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Customer_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internal_meta_keys' { return this.internal_meta_keys }
		'meta_type' { return this.meta_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Customer_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internal_meta_keys' { this.internal_meta_keys = val; return true }
		'meta_type' { this.meta_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_customer_data_store_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
