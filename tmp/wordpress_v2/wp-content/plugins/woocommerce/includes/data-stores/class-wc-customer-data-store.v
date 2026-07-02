import rt

struct Class_WC_Customer_Data_Store {
	rt.PhpObjectBase
pub mut:
	internal_meta_keys rt.PhpVal = rt.new_array()
	meta_type          rt.PhpVal = rt.new_string('user')
}

fn (mut this Class_WC_Customer_Data_Store) exclude_internal_meta_keys(var_meta rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_table_prefix := if rt.is_true(rt.get_property(var_wpdb, 'prefix')) {
		rt.get_property(var_wpdb, 'prefix')
	} else {
		rt.new_string('wp_')
	}
	return
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'meta_key'), this.internal_meta_keys, rt.new_bool(true)])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_meta, 'meta_key'), rt.new_string('_woocommerce_persistent_cart')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_meta, 'meta_key'), rt.new_string('closedpostboxes_')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_meta, 'meta_key'), rt.new_string('metaboxhidden_')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_meta, 'meta_key'), rt.new_string('manageedit-')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [rt.get_property(var_meta, 'meta_key'), var_table_prefix.clone()])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [rt.get_property(var_meta, 'meta_key'), rt.new_string('wp_')])))))
}

fn (mut this Class_WC_Customer_Data_Store) create(var_customer rt.PhpVal) {
	mut var_id := rt.call_function('wc_create_new_customer', [
		rt.call_method(var_customer, 'get_email', []rt.PhpVal{}),
		rt.call_method(var_customer, 'get_username', []rt.PhpVal{}),
		rt.call_method(var_customer, 'get_password', []rt.PhpVal{}),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_id.clone()])) {
		rt.throw_exception(rt.new_object('WC_Data_Exception', []string{}, create_wc_data_exception(rt.call_method(var_id,
			'get_error_code', []rt.PhpVal{}), rt.call_method(var_id, 'get_error_message',
			[]rt.PhpVal{}))))
	}
	rt.call_method(var_customer, 'set_id', [var_id.clone()])
	mut var_wp_user := create_wp_user(var_id.clone())
	if rt.is_true(var_wp_user.exists()) {
		rt.call_method(var_customer, 'set_username', [
			rt.get_property(var_wp_user, 'user_login'),
		])
		rt.call_method(var_customer, 'set_date_created', [
			rt.get_property(var_wp_user, 'user_registered'),
		])
	}
	this.update_user_meta(var_customer.clone())
	rt.call_method(var_customer, 'set_password', [rt.new_string('')])
	rt.call_function('wp_update_user', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_update_customer_args'),
			rt.create_array([
				rt.ArrayItem{ key: 'ID', val: rt.call_method(var_customer, 'get_id', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'role', val: rt.call_method(var_customer, 'get_role',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'display_name', val: rt.call_method(var_customer,
					'get_display_name', []rt.PhpVal{}) },
			]),
			var_customer.clone(),
		]),
	])
	rt.call_method(var_customer, 'set_date_modified', [
		rt.call_function('get_user_meta', [
			rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
			rt.new_string('last_update'),
			rt.new_bool(true),
		]),
	])
	rt.call_method(var_customer, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_customer, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_new_customer'),
		rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
		var_customer.clone()])
}

fn (mut this Class_WC_Customer_Data_Store) read(var_customer rt.PhpVal) {
	mut var_user_object := if rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{})) { rt.call_function('get_user_by', [
			rt.new_string('id'),
			rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_object))))
		|| !rt.is_true(rt.get_property(var_user_object, 'ID')) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid customer.'),
			rt.new_string('woocommerce'),
		]))))
	}
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut var_user_meta := rt.call_function('array_diff_key', [
		rt.call_function('array_change_key_case', [
			rt.call_function('array_map', [rt.new_string('wc_flatten_meta_callback'),
				rt.call_function('get_user_meta', [var_customer_id.clone()])]),
		]),
		rt.call_function('array_flip', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'country' },
				rt.ArrayItem{ key: none, val: 'state' }, rt.ArrayItem{ key: none, val: 'postcode' },
				rt.ArrayItem{ key: none, val: 'city' }, rt.ArrayItem{ key: none, val: 'address' },
				rt.ArrayItem{ key: none, val: 'address_2' }, rt.ArrayItem{ key: none, val: 'default' },
				rt.ArrayItem{ key: none, val: 'location' }]),
		]),
		rt.call_function('array_change_key_case', [
			rt.cast_array(rt.get_property(var_user_object, 'data')),
		]),
	])
	rt.call_method(var_customer, 'set_props', [var_user_meta.clone()])
	rt.call_method(var_customer, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'is_paying_customer', val: rt.call_function('get_user_meta', [
				var_customer_id.clone(),
				rt.new_string('paying_customer'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'email', val: rt.get_property(var_user_object, 'user_email') },
			rt.ArrayItem{ key: 'username', val: rt.get_property(var_user_object, 'user_login') },
			rt.ArrayItem{ key: 'display_name', val: rt.get_property(var_user_object, 'display_name') },
			rt.ArrayItem{ key: 'date_created', val: rt.get_property(var_user_object,
				'user_registered') },
			rt.ArrayItem{ key: 'date_modified', val: rt.call_function('get_user_meta', [
				var_customer_id.clone(),
				rt.new_string('last_update'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{
				key: 'role'
				val: if !(!rt.is_true(rt.get_property(var_user_object, 'roles').array_get(rt.new_int(0)))) {
					rt.get_property(var_user_object, 'roles').array_get(rt.new_int(0))
				} else {
					rt.new_string('customer')
				}
			},
		]),
	])
	rt.call_method(var_customer, 'read_meta_data', []rt.PhpVal{})
	rt.call_method(var_customer, 'set_object_read', [rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('woocommerce_customer_loaded'),
		var_customer.clone()])
}

fn (mut this Class_WC_Customer_Data_Store) update(var_customer rt.PhpVal) {
	rt.call_function('wp_update_user', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_update_customer_args'),
			rt.create_array([
				rt.ArrayItem{ key: 'ID', val: rt.call_method(var_customer, 'get_id', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'user_email', val: rt.call_method(var_customer, 'get_email',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'display_name', val: rt.call_method(var_customer,
					'get_display_name', []rt.PhpVal{}) },
			]),
			var_customer.clone(),
		]),
	])
	if rt.is_true(rt.call_method(var_customer, 'get_password', []rt.PhpVal{})) {
		rt.call_function('wp_update_user', [
			rt.create_array([
				rt.ArrayItem{ key: 'ID', val: rt.call_method(var_customer, 'get_id', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'user_pass', val: rt.call_method(var_customer, 'get_password',
					[]rt.PhpVal{}) },
			]),
		])
		rt.call_method(var_customer, 'set_password', [rt.new_string('')])
	}
	this.update_user_meta(var_customer.clone())
	rt.call_method(var_customer, 'set_date_modified', [
		rt.call_function('get_user_meta', [
			rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
			rt.new_string('last_update'),
			rt.new_bool(true),
		]),
	])
	rt.call_method(var_customer, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_customer, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_update_customer'),
		rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
		var_customer.clone()])
}

fn (mut this Class_WC_Customer_Data_Store) delete(var_customer rt.PhpVal, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))))) {
		return
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'reassign', val: 0 }])])
	mut var_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	rt.call_function('wp_delete_user',
		[var_id.clone(), var_args_mutated.array_get(rt.new_string('reassign'))])
	rt.call_function('do_action', [rt.new_string('woocommerce_delete_customer'),
		var_id.clone()])
}

fn (mut this Class_WC_Customer_Data_Store) update_user_meta(var_customer rt.PhpVal) {
	mut var_updated_props := []rt.PhpVal{}
	mut var_changed_props := rt.call_method(var_customer, 'get_changes', []rt.PhpVal{})
	mut var_meta_key_to_props := {
		'paying_customer': 'is_paying_customer'
		'first_name':      'first_name'
		'last_name':       'last_name'
	}
	for var_meta_key, var_prop in var_meta_key_to_props {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changed_props.clone().array_isset(rt.new_string(prop))))))) {
			continue
		}
		if rt.is_true(rt.call_function('update_user_meta', [
			rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
			rt.new_string(meta_key),
			rt.call_method(var_customer, 'get_${var_prop}', [
				rt.new_string('edit')]),
		]))
		{
			var_updated_props << rt.new_string(prop)
		}
	}
	mut var_billing_address_props := {
		'billing_first_name': 'billing_first_name'
		'billing_last_name':  'billing_last_name'
		'billing_company':    'billing_company'
		'billing_address_1':  'billing_address_1'
		'billing_address_2':  'billing_address_2'
		'billing_city':       'billing_city'
		'billing_state':      'billing_state'
		'billing_postcode':   'billing_postcode'
		'billing_country':    'billing_country'
		'billing_email':      'billing_email'
		'billing_phone':      'billing_phone'
	}
	for var_meta_key, var_prop in var_billing_address_props {
		mut var_prop_key := rt.call_function('substr', [rt.new_string(prop),
			rt.new_int(8)])
		if !(var_changed_props.array_isset(rt.new_string('billing')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changed_props.array_get(rt.new_string('billing')).array_isset(var_prop_key.clone())))))) {
			continue
		}
		if rt.is_true(rt.call_function('update_user_meta', [
			rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
			rt.new_string(meta_key),
			rt.call_method(var_customer, 'get_${var_prop}', [
				rt.new_string('edit')]),
		]))
		{
			var_updated_props << rt.new_string(prop)
		}
	}
	mut var_shipping_address_props := {
		'shipping_first_name': 'shipping_first_name'
		'shipping_last_name':  'shipping_last_name'
		'shipping_company':    'shipping_company'
		'shipping_address_1':  'shipping_address_1'
		'shipping_address_2':  'shipping_address_2'
		'shipping_city':       'shipping_city'
		'shipping_state':      'shipping_state'
		'shipping_postcode':   'shipping_postcode'
		'shipping_country':    'shipping_country'
		'shipping_phone':      'shipping_phone'
	}
	for var_meta_key, var_prop in var_shipping_address_props {
		mut var_prop_key := rt.call_function('substr', [rt.new_string(prop),
			rt.new_int(9)])
		if !(var_changed_props.array_isset(rt.new_string('shipping')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changed_props.array_get(rt.new_string('shipping')).array_isset(var_prop_key.clone())))))) {
			continue
		}
		if rt.is_true(rt.call_function('update_user_meta', [
			rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
			rt.new_string(meta_key),
			rt.call_method(var_customer, 'get_${var_prop}', [
				rt.new_string('edit')]),
		]))
		{
			var_updated_props << rt.new_string(prop)
		}
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_customer_object_updated_props'),
		var_customer.clone(),
		rt.create_array_from_list(var_updated_props),
	])
}

fn (mut this Class_WC_Customer_Data_Store) is_cot_in_use() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Customer_Data_Store) get_last_order(var_customer rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_0 := iife_temp_0.get_site_user_meta(var_customer_id.clone(),
		rt.new_string('wc_last_order'), rt.new_bool(true))
	mut var_last_order_id := iife_result_0
	mut var_last_customer_order := rt.new_bool(false)
	if !(!rt.is_true(var_last_order_id)) {
		var_last_customer_order = rt.call_function('wc_get_order', [
			var_last_order_id.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_last_customer_order, 'WC_Order'))))))
		|| rt.is_true(rt.new_bool(rt.call_method(var_last_customer_order, 'get_customer_id', []rt.PhpVal{}).to_i64() != var_customer_id.clone().to_i64())) {
		var_last_order_id = rt.new_string('')
	}
	var_last_order_id = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_get_last_order'),
		var_last_order_id.clone(),
		var_customer.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string(''), var_last_order_id)) {
		mut var_order_statuses_sql := rt.new_string("( '" +
			(rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{}))])])).str() +
			"' )")
		if this.is_cot_in_use() {
			mut iife_temp_1 :=
				Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
			mut iife_result_1 := iife_temp_1.get_orders_table_name()
			mut var_sql := rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('SELECT id FROM %i WHERE customer_id = %d AND status IN ${var_order_statuses_sql.to_string()} ORDER BY id DESC LIMIT 1'),
				iife_result_1,
				var_customer_id.clone(),
			])
			var_last_order_id = rt.call_method(var_wpdb, 'get_var', [
				var_sql.clone()])
		} else {
			var_last_order_id = rt.call_method(var_wpdb, 'get_var', [
				rt.new_string((
					rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT posts.ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(" AS meta on posts.ID = meta.post_id\n\t\t\t\tWHERE meta.meta_key   = '_customer_user'\n\t\t\t\tAND   meta.meta_value = '")) +
					(rt.call_function('esc_sql', [var_customer_id.clone()])).str() +
					"'\n\t\t\t\tAND   posts.post_type = 'shop_order'\n\t\t\t\tAND   posts.post_status IN ${var_order_statuses_sql.to_string()}\n\t\t\t\tORDER BY posts.ID DESC\n\t\t\t\tLIMIT 1").str()),
			])
		}
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_2 := iife_temp_2.update_site_user_meta(var_customer_id.clone(),
			rt.new_string('wc_last_order'), var_last_order_id.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_order_id)))) {
		return false
	}
	return (rt.call_function('wc_get_order', [
		rt.call_function('absint', [var_last_order_id.clone()]),
	])).to_bool()
}

fn (mut this Class_WC_Customer_Data_Store) get_order_count(var_customer rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_3 := iife_temp_3.get_site_user_meta(var_customer_id.clone(),
		rt.new_string('wc_order_count'), rt.new_bool(true))
	mut var_count := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_get_order_count'),
		iife_result_3,
		var_customer.clone(),
	])
	mut var_order_statuses_sql := rt.new_string("( '" +
		(rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{}))])])).str() +
		"' )")
	if rt.is_true(rt.identical(rt.new_string(''), var_count)) {
		if this.is_cot_in_use() {
			mut iife_temp_4 :=
				Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
			mut iife_result_4 := iife_temp_4.get_orders_table_name()
			mut var_sql := rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('SELECT COUNT(id) FROM %i WHERE customer_id = %d AND status IN ${var_order_statuses_sql.to_string()}'),
				iife_result_4,
				var_customer_id.clone(),
			])
			var_count = rt.call_method(var_wpdb, 'get_var', [
				var_sql.clone()])
		} else {
			var_count = rt.call_method(var_wpdb, 'get_var', [
				rt.new_string((
					rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*)\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(" AS meta ON posts.ID = meta.post_id\n\t\t\t\tWHERE   meta.meta_key   = '_customer_user'\n\t\t\t\tAND     posts.post_type = 'shop_order'\n\t\t\t\tAND     posts.post_status IN ")), var_order_statuses_sql), rt.new_string("\n\t\t\t\tAND     meta_value = '")) +
					(rt.call_function('esc_sql', [var_customer_id.clone()])).str() + "'").str()),
			])
		}
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_5 := iife_temp_5.update_site_user_meta(var_customer_id.clone(),
			rt.new_string('wc_order_count'), var_count.clone())
	}
	return rt.call_function('absint', [var_count.clone()])
}

fn (mut this Class_WC_Customer_Data_Store) get_total_spent(var_customer rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id := rt.call_method(var_customer, 'get_id', []rt.PhpVal{})
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_6 := iife_temp_6.get_site_user_meta(var_customer_id.clone(),
		rt.new_string('wc_money_spent'), rt.new_bool(true))
	mut var_spent := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_get_total_spent'),
		iife_result_6,
		var_customer.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string(''), var_spent)) {
		mut var_statuses := rt.call_function('array_map', [rt.new_string('esc_sql'),
			rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{})])
		mut var_statuses_sql := rt.new_string("( 'wc-" +
			(rt.call_function('implode', [rt.new_string("','wc-"), var_statuses.clone()])).str() +
			"' )")
		if this.is_cot_in_use() {
			mut iife_temp_7 :=
				Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
			mut iife_result_7 := iife_temp_7.get_orders_table_name()
			mut var_sql := rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('SELECT SUM(total_amount) FROM %i WHERE customer_id = %d AND status IN ${var_statuses_sql.to_string()}'),
				iife_result_7,
				var_customer_id.clone(),
			])
		} else {
			mut var_has_sql_modification_filter := rt.call_function('has_filter', [
				rt.new_string('woocommerce_customer_get_total_spent_query'),
			])
			if rt.is_true(var_has_sql_modification_filter) {
				var_sql = rt.new_string((
					rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT SUM(meta2.meta_value)\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta ON posts.ID = meta.post_id\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(" AS meta2 ON posts.ID = meta2.post_id\n\t\t\t\t\tWHERE   meta.meta_key       = '_customer_user'\n\t\t\t\t\tAND     meta.meta_value     = '")) +
					(rt.call_function('esc_sql', [var_customer_id.clone()])).str() +
					"'\n\t\t\t\t\tAND     posts.post_type     = 'shop_order'\n\t\t\t\t\tAND     posts.post_status   IN ${var_statuses_sql.to_string()}\n\t\t\t\t\tAND     meta2.meta_key      = '_order_total'").str())
			} else {
				var_sql = rt.new_string((
					rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT SUM(postmeta.meta_value)\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta ON posts.ID = postmeta.post_id\n\t\t\t\t\tWHERE posts.ID IN (\n\t\t\t\t\t\t\t\tSELECT posts.ID as order_id\n\t\t\t\t\t\t\t\tFROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts LEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(" AS postmeta ON posts.ID = postmeta.post_id\n\t\t\t\t\t\t\t\tWHERE postmeta.meta_key   = '_customer_user'\n\t\t\t\t\t\t\t\t  AND postmeta.meta_value = '")) +
					(rt.call_function('esc_sql', [var_customer_id.clone()])).str() +
					"'\n\t\t\t\t\t\t\t\t  AND posts.post_type     = 'shop_order'\n\t\t\t\t\t\t\t\t  AND posts.post_status IN ${var_statuses_sql.to_string()}\n\t\t\t\t\t)\n\t\t\t\t\tAND postmeta.meta_key = '_order_total'").str())
			}
		}
		var_sql = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_customer_get_total_spent_query'),
			var_sql.clone(),
			var_customer.clone(),
		])
		var_spent = rt.call_method(var_wpdb, 'get_var', [var_sql.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_spent)))) {
			var_spent = rt.new_int(0)
		}
		mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_8 := iife_temp_8.update_site_user_meta(var_customer_id.clone(),
			rt.new_string('wc_money_spent'), var_spent.clone())
	}
	return rt.call_function('wc_format_decimal', [var_spent.clone(),
		rt.new_int(2)])
}

fn (mut this Class_WC_Customer_Data_Store) search_customers(var_term rt.PhpVal, limit string) rt.PhpVal {
	mut var_results := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_pre_search_customers'),
		rt.new_bool(false),
		var_term.clone(),
		rt.new_string(limit),
	])
	if rt.is_true(rt.new_bool(var_results.clone().is_array())) {
		return var_results.clone()
	}
	mut var_query := create_wp_user_query(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_search_customers'),
		rt.create_array([
			rt.ArrayItem{ key: 'search', val: '*' +
				(rt.call_function('esc_attr', [var_term.clone()])).str() + '*' },
			rt.ArrayItem{ key: 'search_columns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'user_login' },
				rt.ArrayItem{ key: none, val: 'user_url' },
				rt.ArrayItem{ key: none, val: 'user_email' },
				rt.ArrayItem{ key: none, val: 'user_nicename' },
				rt.ArrayItem{ key: none, val: 'display_name' },
			]) },
			rt.ArrayItem{ key: 'fields', val: 'ID' },
			rt.ArrayItem{ key: 'number', val: limit },
		]),
		var_term.clone(),
		rt.new_string(limit),
		rt.new_string('main_query'),
	]))
	mut var_query2 := create_wp_user_query(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_search_customers'),
		rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ID' },
			rt.ArrayItem{ key: 'number', val: limit }, rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'OR' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: 'first_name' },
					rt.ArrayItem{ key: 'value', val: var_term },
					rt.ArrayItem{ key: 'compare', val: 'LIKE' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: 'last_name' },
					rt.ArrayItem{ key: 'value', val: var_term },
					rt.ArrayItem{ key: 'compare', val: 'LIKE' },
				]) },
			]) }]),
		var_term.clone(),
		rt.new_string(limit),
		rt.new_string('meta_query'),
	]))
	var_results = rt.call_function('wp_parse_id_list', [
		rt.call_function('array_merge', [rt.cast_array(var_query.get_results()),
			rt.cast_array(var_query2.get_results())]),
	])
	if var_limit.len > 0 && var_limit != '0'
		&& rt.is_true(rt.greater(rt.new_int(var_results.clone().array_count()), rt.new_string(limit))) {
		var_results = rt.call_function('array_slice', [var_results.clone(),
			rt.new_int(0), rt.new_string(limit)])
	}
	return var_results.clone()
}

fn (mut this Class_WC_Customer_Data_Store) get_user_ids_for_billing_email(var_emails rt.PhpVal) rt.PhpVal {
	mut var_emails_mutated := var_emails
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.3.0')])
	var_emails_mutated = rt.call_function('array_unique', [
		rt.call_function('array_map', [rt.new_string('strtolower'),
			rt.call_function('array_map', [rt.new_string('sanitize_email'),
				var_emails_mutated.clone()])]),
	])
	mut var_users_query := create_wp_user_query(rt.create_array([
		rt.ArrayItem{ key: 'fields', val: 'ID' },
		rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: 'billing_email' },
				rt.ArrayItem{ key: 'value', val: var_emails_mutated },
				rt.ArrayItem{ key: 'compare', val: 'IN' },
			]) },
		]) },
	]))
	return rt.call_function('array_unique', [var_users_query.get_results()])
}

fn (mut this Class_WC_Customer_Data_Store) query_customers(mut var_args Class_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_site_specific_key := rt.new_string(rt.call_method(var_wpdb, 'get_blog_prefix', [
		rt.call_function('get_current_blog_id', []rt.PhpVal{}),
	]).to_string().trim_right(' \t\n\r'))
	mut var_defaults := {
		'order':    rt.new_string('asc')
		'orderby':  rt.new_string('registered_date')
		'per_page': rt.new_int(10)
		'page':     rt.new_int(1)
		'search':   rt.new_string('')
		'role':     rt.new_string('customer')
		'include':  []rt.PhpVal{}
		'exclude':  []rt.PhpVal{}
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated,
		rt.create_array_from_native_map(var_defaults)])
	mut var_orderby_key := var_args_mutated.array_get(rt.new_string('orderby'))
	var_args_mutated.array_set('order',
		var_args_mutated.array_get(rt.new_string('order')).to_string().to_lower())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_args_mutated.array_get(rt.new_string('order')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' }]),
		rt.new_bool(true),
	])))))
	{
		var_args_mutated.array_set('order', 'asc')
	}
	mut var_query_args := rt.create_array([
		rt.ArrayItem{ key: 'order', val: var_args_mutated.array_get(rt.new_string('order')) },
		rt.ArrayItem{ key: 'number', val: rt.call_function('absint', [
			var_args_mutated.array_get(rt.new_string('per_page')),
		]) },
		rt.ArrayItem{ key: 'exclude', val: rt.call_function('array_map', [
			rt.new_string('absint'),
			rt.cast_array(var_args_mutated.array_get(rt.new_string('exclude'))),
		]) },
		rt.ArrayItem{ key: 'include', val: rt.call_function('array_map', [
			rt.new_string('absint'),
			rt.cast_array(var_args_mutated.array_get(rt.new_string('include'))),
		]) },
	])
	var_query_args.array_set('offset', rt.mul(rt.sub(rt.call_function('max', [
		rt.new_int(1),
		rt.new_int(var_args_mutated.array_get(rt.new_string('page')).to_i64()),
	]), rt.new_int(1)), var_query_args.array_get(rt.new_string('number'))))
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('search')))) {
		mut var_search := rt.call_function('sanitize_text_field', [
			var_args_mutated.array_get(rt.new_string('search')),
		])
		var_query_args.array_set('search', var_search.clone())
		var_query_args.array_set('search_columns', rt.create_array([
			rt.ArrayItem{ key: none, val: 'user_login' },
			rt.ArrayItem{ key: none, val: 'user_url' },
			rt.ArrayItem{ key: none, val: 'user_email' },
			rt.ArrayItem{ key: none, val: 'user_nicename' },
			rt.ArrayItem{ key: none, val: 'display_name' },
		]))
	}
	mut switch_val_1 := var_orderby_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('ID'))) {
		var_query_args.array_set('orderby', 'ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('display_name'))) {
		var_query_args.array_set('orderby', 'display_name')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc_order_count'))) {
		var_query_args.array_set('meta_key', 'wc_order_count_' + var_site_specific_key.str())
		var_query_args.array_set('orderby', 'meta_value_num')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc_money_spent'))) {
		var_query_args.array_set('meta_key', 'wc_money_spent_' + var_site_specific_key.str())
		var_query_args.array_set('orderby', 'meta_value_num')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc_last_active'))) {
		var_query_args.array_set('meta_key', 'wc_last_active')
		var_query_args.array_set('orderby', 'meta_value_num')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('user_registered')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('registered_date'))) {
		var_query_args.array_set('orderby', 'user_registered')
	} else {
		var_query_args.array_set('orderby', 'user_registered')
	}
	if rt.is_true(rt.identical(rt.new_string('customer'),
		var_args_mutated.array_get(rt.new_string('role'))))
	{
		var_query_args.array_set('role', 'customer')
	}
	var_query_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_query_args'),
		var_query_args.clone(),
		var_args_mutated,
	])
	var_query_args.array_set('number', rt.call_function('absint', [if var_query_args.array_get(rt.new_string('number')).to_i64() <= 0 {
		var_defaults['per_page']
	} else {
		var_query_args.array_get(rt.new_string('number'))
	}]))
	mut var_wp_user_query := create_wp_user_query(var_query_args.clone())
	mut var_customers := []rt.PhpVal{}
	mut iter_1 := var_wp_user_query.get_results().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_user := item_1.val
		var_customers << create_wc_customer(rt.get_property(var_user, 'ID'))
	}
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'customers', val: var_customers },
		rt.ArrayItem{ key: 'total', val: rt.get_property(var_wp_user_query, 'total_users') },
		rt.ArrayItem{ key: 'max_num_pages', val: rt.call_function('ceil', [
			rt.div(rt.get_property(var_wp_user_query, 'total_users'),
				var_query_args.array_get(rt.new_string('number'))),
		]) },
	]))
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
	code    i64
	file    string
	line    i64
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

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_wc_customer_data_store(_args ...rt.PhpVal) &Class_WC_Customer_Data_Store {
	mut obj := &Class_WC_Customer_Data_Store{
		PhpObjectBase:      rt.PhpObjectBase{}
		internal_meta_keys: rt.new_array()
		meta_type:          rt.new_string('user')
	}
	return obj
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_exception(_args ...rt.PhpVal) &Class_WC_Data_Exception {
	mut obj := &Class_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
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

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.query_customers(mut dispatch_arg_0)
		}
		else {
			return none
		}
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
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		'meta_type' {
			this.meta_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
		else {
			return none
		}
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
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
