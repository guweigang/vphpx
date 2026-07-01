import rt

struct Class_WC_Privacy_Erasers {
	rt.PhpObjectBase
}

fn Class_WC_Privacy_Erasers.customer_data_eraser(var_email_address rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	mut var_response := { 'items_removed': rt.new_bool(false), 'items_retained': rt.new_bool(false), 'messages': map[string]rt.PhpVal{}, 'done': rt.new_bool(true) }
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
		return var_response.dup()
	}
	mut var_customer := create_wc_customer(rt.get_property(var_user, 'ID'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer)))) {
		return var_response.dup()
	}
	mut var_props_to_erase := rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_erase_customer_personal_data_props'), rt.create_array([rt.ArrayItem{ key: 'billing_first_name', val: rt.call_function('__', [rt.new_string('Billing First Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_last_name', val: rt.call_function('__', [rt.new_string('Billing Last Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_company', val: rt.call_function('__', [rt.new_string('Billing Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_address_1', val: rt.call_function('__', [rt.new_string('Billing Address 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_address_2', val: rt.call_function('__', [rt.new_string('Billing Address 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_city', val: rt.call_function('__', [rt.new_string('Billing City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_postcode', val: rt.call_function('__', [rt.new_string('Billing Postal/Zip Code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_state', val: rt.call_function('__', [rt.new_string('Billing State'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_country', val: rt.call_function('__', [rt.new_string('Billing Country / Region'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_phone', val: rt.call_function('__', [rt.new_string('Billing Phone Number'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_email', val: rt.call_function('__', [rt.new_string('Email Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_first_name', val: rt.call_function('__', [rt.new_string('Shipping First Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_last_name', val: rt.call_function('__', [rt.new_string('Shipping Last Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_company', val: rt.call_function('__', [rt.new_string('Shipping Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_address_1', val: rt.call_function('__', [rt.new_string('Shipping Address 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_address_2', val: rt.call_function('__', [rt.new_string('Shipping Address 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_city', val: rt.call_function('__', [rt.new_string('Shipping City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_postcode', val: rt.call_function('__', [rt.new_string('Shipping Postal/Zip Code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_state', val: rt.call_function('__', [rt.new_string('Shipping State'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_country', val: rt.call_function('__', [rt.new_string('Shipping Country / Region'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_phone', val: rt.call_function('__', [rt.new_string('Shipping Phone Number'), rt.new_string('woocommerce')]) }]), var_customer])
	{
		mut iter_1 := var_props_to_erase.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_prop := item_1.key
			mut var_erased := rt.new_bool(rt.new_bool(false))
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: 'get_' + (var_prop).str() }])])) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: 'set_' + (var_prop).str() }])])))) {
				mut var_value := rt.call_method(var_customer, "get_${var_prop.to_string()}", [rt.new_string('edit')])
				if rt.is_true(var_value) {
					rt.call_method(var_customer, "set_${var_prop.to_string()}", [rt.new_string('')])
					var_erased = rt.new_bool(rt.new_bool(true))
				}
			}
			var_erased = rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_erase_customer_personal_data_prop'), var_erased.dup(), var_prop.dup(), var_customer])
			if rt.is_true(var_erased) {
				var_response.array_get_mut('messages').array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Removed customer "%s"'), rt.new_string('woocommerce')]), var_label.dup()]))
				var_response['items_removed'] = rt.new_bool(true)
			}
		}
	}
	var_customer.save()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_erase_personal_data_customer'), var_response.dup(), var_customer])
}

fn Class_WC_Privacy_Erasers.order_data_eraser(var_email_address rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	var_page_mutated = // unsupported expression: Expr_Cast_Int
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	mut var_erasure_enabled := rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_erasure_request_removes_order_data'), rt.new_string('no')])])
	mut var_response := { 'items_removed': rt.new_bool(false), 'items_retained': rt.new_bool(false), 'messages': map[string]rt.PhpVal{}, 'done': rt.new_bool(true) }
	mut var_order_query := { 'limit': rt.new_int(10), 'page': var_page_mutated, 'customer': map[string]rt.PhpVal{} }
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		var_order_query.array_get_mut('customer').array_push(// unsupported expression: Expr_Cast_Int)
	}
	mut var_orders := rt.call_function('wc_get_orders', [var_order_query.dup()])
	if 0 < var_orders.dup().array_count() {
		{
			mut iter_1 := var_orders.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_order := item_1.val
				if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_erase_order_personal_data'), var_erasure_enabled.dup(), var_order.dup()])) {
					Class_WC_Privacy_Erasers.remove_order_personal_data(var_order.dup())
					var_response.array_get_mut('messages').array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Removed personal data from order %s.'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})]))
					var_response['items_removed'] = rt.new_bool(true)
				} else {
					var_response.array_get_mut('messages').array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Personal data within order %s has been retained.'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})]))
					var_response['items_retained'] = rt.new_bool(true)
				}
			}
		}
		var_response['done'] = rt.new_bool(10 > var_orders.dup().array_count())
	} else {
		var_response['done'] = rt.new_bool(true)
	}
	return var_response.dup()
}

fn Class_WC_Privacy_Erasers.download_data_eraser(var_email_address rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	var_page_mutated = // unsupported expression: Expr_Cast_Int
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	mut var_erasure_enabled := rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_erasure_request_removes_download_data'), rt.new_string('no')])])
	mut var_response := { 'items_removed': rt.new_bool(false), 'items_retained': rt.new_bool(false), 'messages': map[string]rt.PhpVal{}, 'done': rt.new_bool(true) }
	mut var_downloads_query := { 'limit': // unsupported expression: Expr_UnaryMinus, 'page': var_page_mutated, 'return': rt.new_string('ids') }
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		var_downloads_query['user_id'] = // unsupported expression: Expr_Cast_Int
	} else {
		var_downloads_query['user_email'] = var_email_address.dup()
	}
	mut var_customer_download_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download'))
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_erase_download_personal_data'), var_erasure_enabled.dup(), var_email_address.dup()])) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
			mut var_result := rt.call_method(var_customer_download_data_store, 'delete_by_user_id', [// unsupported expression: Expr_Cast_Int])
		} else {
			var_result = rt.call_method(var_customer_download_data_store, 'delete_by_user_email', [var_email_address.dup()])
		}
		if rt.is_true(var_result) {
			var_response.array_get_mut('messages').array_push(rt.call_function('__', [rt.new_string('Removed access to downloadable files.'), rt.new_string('woocommerce')]))
			var_response['items_removed'] = rt.new_bool(true)
		}
	} else {
		var_response.array_get_mut('messages').array_push(rt.call_function('__', [rt.new_string('Customer download permissions have been retained.'), rt.new_string('woocommerce')]))
		var_response['items_retained'] = rt.new_bool(true)
	}
	return var_response.dup()
}

fn Class_WC_Privacy_Erasers.remove_order_personal_data(var_order rt.PhpVal)  {
	mut var_anonymized_data := map[string]rt.PhpVal{}
	rt.call_function('do_action', [rt.new_string('woocommerce_privacy_before_remove_order_personal_data'), var_order.dup()])
	mut var_props_to_remove := rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_remove_order_personal_data_props'), rt.create_array([rt.ArrayItem{ key: 'customer_ip_address', val: 'ip' }, rt.ArrayItem{ key: 'customer_user_agent', val: 'text' }, rt.ArrayItem{ key: 'billing_first_name', val: 'text' }, rt.ArrayItem{ key: 'billing_last_name', val: 'text' }, rt.ArrayItem{ key: 'billing_company', val: 'text' }, rt.ArrayItem{ key: 'billing_address_1', val: 'text' }, rt.ArrayItem{ key: 'billing_address_2', val: 'text' }, rt.ArrayItem{ key: 'billing_city', val: 'text' }, rt.ArrayItem{ key: 'billing_postcode', val: 'text' }, rt.ArrayItem{ key: 'billing_state', val: 'address_state' }, rt.ArrayItem{ key: 'billing_country', val: 'address_country' }, rt.ArrayItem{ key: 'billing_phone', val: 'phone' }, rt.ArrayItem{ key: 'billing_email', val: 'email' }, rt.ArrayItem{ key: 'shipping_first_name', val: 'text' }, rt.ArrayItem{ key: 'shipping_last_name', val: 'text' }, rt.ArrayItem{ key: 'shipping_company', val: 'text' }, rt.ArrayItem{ key: 'shipping_address_1', val: 'text' }, rt.ArrayItem{ key: 'shipping_address_2', val: 'text' }, rt.ArrayItem{ key: 'shipping_city', val: 'text' }, rt.ArrayItem{ key: 'shipping_postcode', val: 'text' }, rt.ArrayItem{ key: 'shipping_state', val: 'address_state' }, rt.ArrayItem{ key: 'shipping_country', val: 'address_country' }, rt.ArrayItem{ key: 'shipping_phone', val: 'phone' }, rt.ArrayItem{ key: 'customer_id', val: 'numeric_id' }, rt.ArrayItem{ key: 'transaction_id', val: 'numeric_id' }]), var_order.dup()])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_props_to_remove)) && rt.is_true(rt.new_bool(var_props_to_remove.dup().is_array())))) {
		{
			mut iter_1 := var_props_to_remove.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_data_type := item_1.val
				mut var_prop := item_1.key
				mut var_value := rt.call_method(var_order, "get_${var_prop.to_string()}", [rt.new_string('edit')])
				if !rt.is_true(var_value) || !rt.is_true(var_data_type) {
					continue
				}
				mut var_anon_value := if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_privacy_anonymize_data')])) { rt.call_function('wp_privacy_anonymize_data', [var_data_type.dup(), var_value.dup()]) } else { rt.new_string('') }
				var_anonymized_data.array_set(var_prop, rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_remove_order_personal_data_prop_value'), var_anon_value.dup(), var_prop.dup(), var_value.dup(), var_data_type.dup(), var_order.dup()]))
			}
		}
	}
	rt.call_method(var_order, 'set_props', [var_anonymized_data.dup()])
	mut var_meta_to_remove := rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_remove_order_personal_data_meta'), rt.create_array([rt.ArrayItem{ key: 'Payer first name', val: 'text' }, rt.ArrayItem{ key: 'Payer last name', val: 'text' }, rt.ArrayItem{ key: 'Payer PayPal address', val: 'email' }, rt.ArrayItem{ key: 'Transaction ID', val: 'numeric_id' }])])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_meta_to_remove)) && rt.is_true(rt.new_bool(var_meta_to_remove.dup().is_array())))) {
		{
			mut iter_1 := var_meta_to_remove.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_data_type := item_1.val
				mut var_meta_key := item_1.key
				mut var_value := rt.call_method(var_order, 'get_meta', [var_meta_key.dup()])
				if !rt.is_true(var_value) || !rt.is_true(var_data_type) {
					continue
				}
				mut var_anon_value := if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_privacy_anonymize_data')])) { rt.call_function('wp_privacy_anonymize_data', [var_data_type.dup(), var_value.dup()]) } else { rt.new_string('') }
				var_anon_value = rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_remove_order_personal_data_meta_value'), var_anon_value.dup(), var_meta_key.dup(), var_value.dup(), var_data_type.dup(), var_order.dup()])
				if rt.is_true(var_anon_value) {
					rt.call_method(var_order, 'update_meta_data', [var_meta_key.dup(), var_anon_value.dup()])
				} else {
					rt.call_method(var_order, 'delete_meta_data', [var_meta_key.dup()])
				}
			}
		}
	}
	rt.call_method(var_order, 'update_meta_data', [rt.new_string('_anonymized'), rt.new_string('yes')])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	mut var_notes := rt.call_function('wc_get_order_notes', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }])])
	{
		mut iter_1 := var_notes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note := item_1.val
			rt.call_function('wc_delete_order_note', [rt.get_property(var_note, 'id')])
		}
	}
	rt.call_method(var_order, 'add_order_note', [rt.call_function('__', [rt.new_string('Personal data removed.'), rt.new_string('woocommerce')])])
	rt.call_function('do_action', [rt.new_string('woocommerce_privacy_remove_order_personal_data'), var_order.dup()])
}

fn Class_WC_Privacy_Erasers.customer_tokens_eraser(var_email_address rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	mut var_response := { 'items_removed': rt.new_bool(false), 'items_retained': rt.new_bool(false), 'messages': map[string]rt.PhpVal{}, 'done': rt.new_bool(true) }
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
		return var_response.dup()
	}
	mut var_tokens := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Payment_Tokens{}; return temp.get_tokens(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_user, 'ID') }]))
	if !rt.is_true(var_tokens) {
		return var_response.dup()
	}
	{
		mut iter_1 := var_tokens.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token := item_1.val
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Payment_Tokens{}; return temp.delete(arg_0) }(rt.call_method(var_token, 'get_id', []rt.PhpVal{}))
			var_response.array_get_mut('messages').array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Removed payment token "%d"'), rt.new_string('woocommerce')]), rt.call_method(var_token, 'get_id', []rt.PhpVal{})]))
			var_response['items_removed'] = rt.new_bool(true)
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_erase_personal_data_tokens'), var_response.dup(), var_tokens.dup()])
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

fn create_wc_privacy_erasers() &Class_WC_Privacy_Erasers {
	mut obj := &Class_WC_Privacy_Erasers{
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

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_tokens() &Class_WC_Payment_Tokens {
	mut obj := &Class_WC_Payment_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Privacy_Erasers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'customer_data_eraser' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Privacy_Erasers.customer_data_eraser(dispatch_arg_0, dispatch_arg_1)
		}
		'order_data_eraser' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Privacy_Erasers.order_data_eraser(dispatch_arg_0, dispatch_arg_1)
		}
		'download_data_eraser' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Privacy_Erasers.download_data_eraser(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_order_personal_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Privacy_Erasers.remove_order_personal_data(dispatch_arg_0)
			return rt.new_null()
		}
		'customer_tokens_eraser' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Privacy_Erasers.customer_tokens_eraser(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Privacy_Erasers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Privacy_Erasers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_privacy_erasers_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
