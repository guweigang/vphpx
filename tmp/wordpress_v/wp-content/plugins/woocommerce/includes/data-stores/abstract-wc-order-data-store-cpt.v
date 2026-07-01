import rt

struct Class_Abstract_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
		meta_type rt.PhpVal = rt.new_string('post')
		internal_meta_keys rt.PhpVal = rt.new_array()
		internal_data_store_key_getters rt.PhpVal = rt.new_array()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_internal_data_store_key_getters() rt.PhpVal {
	return this.internal_data_store_key_getters
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) create(var_order rt.PhpVal)  {
	rt.call_method(var_order, 'set_version', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))])
	rt.call_method(var_order, 'set_currency', [if rt.is_true(rt.call_method(var_order, 'get_currency', []rt.PhpVal{})) { rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) } else { rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_date_created', [rt.new_string('edit')]))))) {
		rt.call_method(var_order, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	mut var_id := rt.call_function('wp_insert_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_new_order_data'), rt.create_array([rt.ArrayItem{ key: 'post_date', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_type', val: rt.call_method(var_order, 'get_type', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'post_status', val: this.get_post_status(var_order.dup()) }, rt.ArrayItem{ key: 'ping_status', val: 'closed' }, rt.ArrayItem{ key: 'post_author', val: 1 }, rt.ArrayItem{ key: 'post_title', val: this.get_post_title() }, rt.ArrayItem{ key: 'post_password', val: this.get_order_key(var_order.dup()) }, rt.ArrayItem{ key: 'post_parent', val: rt.call_method(var_order, 'get_parent_id', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'post_excerpt', val: this.get_post_excerpt(var_order.dup()) }])]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.dup()]))))))) {
		rt.call_method(var_order, 'set_id', [var_id.dup()])
		this.update_post_meta(var_order.dup())
		rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
		rt.call_method(var_order, 'apply_changes', []rt.PhpVal{})
		this.clear_caches(var_order.dup())
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) order_exists(var_order_id rt.PhpVal) bool {
	mut var_order_id_mutated := var_order_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id_mutated)))) {
		return false
	}
	mut var_post_object := rt.call_function('get_post', [var_order_id_mutated.dup()])
	return rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_object.dup().is_null()))))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_object, 'post_type'), rt.call_function('wc_get_order_types', []rt.PhpVal{}), rt.new_bool(true)]))
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) read(var_order rt.PhpVal)  {
	rt.call_method(var_order, 'set_defaults', []rt.PhpVal{})
	mut var_post_object := rt.call_function('get_post', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_post_object)))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_object, 'post_type'), rt.call_function('wc_get_order_types', []rt.PhpVal{}), rt.new_bool(true)]))))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('Invalid order.'), rt.new_string('woocommerce')]))))
	}
	this.set_order_props(var_order.dup(), mut rt.cast_object_ptr[Class_array](rt.create_array([rt.ArrayItem{ key: 'parent_id', val: rt.get_property(var_post_object, 'post_parent') }, rt.ArrayItem{ key: 'date_created', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_date_gmt')) }, rt.ArrayItem{ key: 'date_modified', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_modified_gmt')) }, rt.ArrayItem{ key: 'status', val: rt.get_property(var_post_object, 'post_status') }])))
	this.read_order_data(var_order.dup(), var_post_object.dup())
	rt.call_method(var_order, 'read_meta_data', []rt.PhpVal{})
	rt.call_method(var_order, 'set_object_read', [rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('version_compare', [rt.call_method(var_order, 'get_version', [rt.new_string('edit')]), rt.new_string('2.3.7'), rt.new_string('<')])) && rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', [rt.new_string('edit')])))) {
		rt.call_method(var_order, 'set_discount_total', [rt.sub(// unsupported expression: Expr_Cast_Double, // unsupported expression: Expr_Cast_Double)])
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) set_order_props(var_order rt.PhpVal, mut var_props Class_array)  {
	mut var_errors := rt.call_method(var_order, 'set_props', [var_props])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_errors, 'WP_Error')))))) {
		return rt.new_null()
	}
	mut var_order_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	mut var_logger := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_logger')])
	{
		mut iter_1 := rt.call_method(var_errors, 'get_error_codes', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error_code := item_1.val
			mut var_property_name := if !(rt.call_method(var_errors, 'get_error_data', [var_error_code.dup()]).array_get('property_name')).is_null() { rt.call_method(var_errors, 'get_error_data', [var_error_code.dup()]).array_get('property_name') } else { rt.new_string('') }
			mut var_error_message := rt.call_method(var_errors, 'get_error_message', [var_error_code.dup()])
			rt.call_method(var_logger, 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error when setting property \'%1$s\' for order %2$d: %3$s'), rt.new_string('woocommerce')]), var_property_name.dup(), var_order_id.dup(), var_error_message.dup()]), rt.create_array([rt.ArrayItem{ key: 'error_code', val: var_error_code }, rt.ArrayItem{ key: 'error_message', val: var_error_message }, rt.ArrayItem{ key: 'order_id', val: var_order_id }, rt.ArrayItem{ key: 'property_name', val: var_property_name }])])
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update(var_order rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_order, 'set_version', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))])
	if rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_order, 'get_date_created', [rt.new_string('edit')]))) {
		rt.call_method(var_order, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	mut var_changes := rt.call_method(var_order, 'get_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_function('array_intersect', [rt.create_array([rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'date_modified' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'parent_id' }, rt.ArrayItem{ key: none, val: 'post_excerpt' }]), rt.func_array_keys(var_changes.dup())])) {
		mut var_post_data := { 'post_date': rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]), 'post_date_gmt': rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]), 'post_status': this.get_post_status(var_order.dup()), 'post_parent': rt.call_method(var_order, 'get_parent_id', []rt.PhpVal{}), 'post_excerpt': this.get_post_excerpt(var_order.dup()), 'post_modified': if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order, 'get_date_modified', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]) } else { rt.call_function('current_time', [rt.new_string('mysql')]) }, 'post_modified_gmt': if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order, 'get_date_modified', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) } else { rt.call_function('current_time', [rt.new_string('mysql'), rt.new_int(1)]) } }
		if rt.is_true(rt.call_function('doing_action', [rt.new_string('save_post')])) {
			rt.call_method(var_GLOBALS.array_get('wpdb'), 'update', [rt.get_property(var_GLOBALS.array_get('wpdb'), 'posts'), var_post_data.dup(), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }])])
			rt.call_function('clean_post_cache', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		} else {
			rt.call_function('wp_update_post', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }]), var_post_data.dup()])])
		}
		rt.call_method(var_order, 'read_meta_data', [rt.new_bool(true)])
		// unsupported statement: Stmt_Nop
	}
	this.update_post_meta(var_order.dup())
	rt.call_method(var_order, 'apply_changes', []rt.PhpVal{})
	this.clear_caches(var_order.dup())
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) delete(var_order rt.PhpVal, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	mut var_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'force_delete', val: false }, rt.ArrayItem{ key: 'suppress_filters', val: false }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return rt.new_null()
	}
	mut var_do_filters := rt.new_bool(rt.new_bool(!(rt.is_true(var_args_mutated.array_get('suppress_filters')))))
	if rt.is_true(var_args_mutated.array_get('force_delete')) {
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_before_delete_order'), var_id.dup(), var_order.dup()])
		}
		rt.call_function('wp_delete_post', [var_id.dup()])
		rt.call_method(var_order, 'set_id', [rt.new_int(0)])
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_delete_order'), var_id.dup()])
		}
	} else {
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_before_trash_order'), var_id.dup(), var_order.dup()])
		}
		rt.call_function('wp_trash_post', [var_id.dup()])
		rt.call_method(var_order, 'set_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.trash()])
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_trash_order'), var_id.dup()])
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_post_status(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_status := rt.call_method(var_order, 'get_status', [rt.new_string('edit')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_status)))) {
		var_order_status = rt.call_function('apply_filters', [rt.new_string('woocommerce_default_order_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.pending()])
	}
	mut var_post_status := var_order_status.dup()
	mut var_valid_statuses := rt.call_function('get_post_stati', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }]), rt.new_bool(true)]))))) && rt.is_true(rt.call_function('in_array', ['wc-' + (var_post_status).str(), var_valid_statuses.dup(), rt.new_bool(true)])))) {
		var_post_status = rt.new_string('wc-' + (var_post_status).str())
	}
	return var_post_status.dup()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_post_excerpt(var_order rt.PhpVal) string {
	return ''
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_post_title() rt.PhpVal {
	return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order &ndash; %s'), rt.new_string('woocommerce')]), rt.call_method(create_datetime(rt.new_string('now')), 'format', [rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'), rt.new_string('Order date parsed by DateTime::format'), rt.new_string('woocommerce')])])])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_order_key(var_order rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_generate_order_key', []rt.PhpVal{})
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) read_order_data(var_order rt.PhpVal, var_post_object rt.PhpVal)  {
	mut var_post_object_mutated := var_post_object
	mut var_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	mut var_meta_data := rt.call_function('get_post_meta', [var_id.dup()])
	mut var_prices_include_tax := if !(var_meta_data.array_get('_prices_include_tax').array_get(0)).is_null() { var_meta_data.array_get('_prices_include_tax').array_get(0) } else { rt.new_string('') }
	this.set_order_props(var_order.dup(), mut rt.cast_object_ptr[Class_array](rt.create_array([rt.ArrayItem{ key: 'currency', val: if !(var_meta_data.array_get('_order_currency').array_get(0)).is_null() { var_meta_data.array_get('_order_currency').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'discount_total', val: if !(var_meta_data.array_get('_cart_discount').array_get(0)).is_null() { var_meta_data.array_get('_cart_discount').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'discount_tax', val: if !(var_meta_data.array_get('_cart_discount_tax').array_get(0)).is_null() { var_meta_data.array_get('_cart_discount_tax').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_total', val: if !(var_meta_data.array_get('_order_shipping').array_get(0)).is_null() { var_meta_data.array_get('_order_shipping').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_tax', val: if !(var_meta_data.array_get('_order_shipping_tax').array_get(0)).is_null() { var_meta_data.array_get('_order_shipping_tax').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'cart_tax', val: if !(var_meta_data.array_get('_order_tax').array_get(0)).is_null() { var_meta_data.array_get('_order_tax').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'total', val: if !(var_meta_data.array_get('_order_total').array_get(0)).is_null() { var_meta_data.array_get('_order_total').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'version', val: if !(var_meta_data.array_get('_order_version').array_get(0)).is_null() { var_meta_data.array_get('_order_version').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'prices_include_tax', val: if rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), var_id.dup(), rt.new_string('_prices_include_tax')])) { rt.identical(rt.new_string('yes'), var_prices_include_tax) } else { rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')])) } }])))
	{
		mut iter_1 := rt.call_method(var_order, 'get_extra_data_keys', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			mut var_function := rt.new_string('set_' + (var_key).str())
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: var_function }])])) {
				rt.call_method(var_order, var_function, [if !(var_meta_data.array_get('_' + (var_key).str()).array_get(0)).is_null() { var_meta_data.array_get('_' + (var_key).str()).array_get(0) } else { rt.new_string('') }])
			}
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_post_meta(var_order rt.PhpVal)  {
	mut var_updated_props := []rt.PhpVal{}
	mut var_meta_key_to_props := { '_order_currency': 'currency', '_cart_discount': 'discount_total', '_cart_discount_tax': 'discount_tax', '_order_shipping': 'shipping_total', '_order_shipping_tax': 'shipping_tax', '_order_tax': 'cart_tax', '_order_total': 'total', '_order_version': 'version', '_prices_include_tax': 'prices_include_tax' }
	mut var_props_to_update := this.get_props_to_update(var_order.dup(), var_meta_key_to_props.dup())
	{
		mut iter_1 := var_props_to_update.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prop := item_1.val
			mut var_meta_key := item_1.key
			mut var_value := rt.call_method(var_order, "get_${var_prop.to_string()}", [rt.new_string('edit')])
			var_value = if rt.is_true(rt.new_bool(var_value.dup().is_string())) { rt.call_function('wp_slash', [var_value.dup()]) } else { var_value }
			if rt.is_true(rt.identical(rt.new_string('prices_include_tax'), var_prop)) {
				var_value = rt.new_string(if rt.is_true(var_value) { rt.new_string('yes') } else { rt.new_string('no') })
			}
			mut var_updated := this.update_or_delete_post_meta(var_order.dup(), var_meta_key.dup(), var_value.dup())
			if rt.is_true(var_updated) {
				var_updated_props << var_prop.dup()
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_object_updated_props'), var_order.dup(), var_updated_props.dup()])
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) clear_caches(var_order rt.PhpVal)  {
	rt.call_function('clean_post_cache', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	rt.call_function('wc_delete_shop_order_transients', [var_order.dup()])
	rt.call_function('wp_cache_delete', ['order-items-' + (rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str(), rt.new_string('orders')])
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.orders_cache_usage_is_enabled() }()) {
		mut var_order_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caches_OrderCache.class()])
		rt.call_method(var_order_cache, 'remove', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) read_items(var_order rt.PhpVal, var_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_order, 'get_id', []rt.PhpVal{}))) {
		return []rt.PhpVal{}
	}
	mut var_items := if rt.is_true(rt.less(rt.new_int(0), rt.call_method(, 'get_id', []rt.PhpVal{}))) { rt.call_function('wp_cache_get', [ + ().str(), rt.new_string('orders')]) } else { rt.new_bool(false) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_items)) {
		var_items = rt.call_method(, 'get_results', [])
		{
			mut iter_1 := var_items.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				
			}
		}
	}
	
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_order_item_type(var_order rt.PhpVal, var_order_item_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_order_item_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_product_post_caches_for_order_items(mut var_line_items_all Class_array, mut var_raw_meta_data_collection Class_array)  {
	mut var_raw_meta_data_collection_mutated := var_raw_meta_data_collection
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_refund_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal)  {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_needs_processing_transients(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal)  {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) delete_items(var_order rt.PhpVal, var_type rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_payment_token_ids(var_order rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_payment_token_ids(var_order rt.PhpVal, var_token_ids rt.PhpVal)  {
	mut var_token_ids_mutated := var_token_ids
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_title(mut var_order Class_WC_Order) rt.PhpVal {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_order_from_object(var_order rt.PhpVal) bool {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_post_modified_data(var_data rt.PhpVal, var_postarr rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_order_meta_from_object(var_order rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refund_orders_join_clause(order_id i64) string {
	mut var_wpdb := rt.new_null()
	mut order_id_mutated := order_id
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refund_orders_batch_join_clause(mut var_order_ids Class_array) string {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refund_parent_column() string {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_batch_refund_totals(mut var_order_ids Class_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refunded_item_meta_total(var_order rt.PhpVal, item_type string, mut var_meta_keys Class_array) f64 {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_total_tax_refunded(var_order rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_total_shipping_tax_refunded(var_order rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_total_shipping_refunded(var_order rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_refund_total_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
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

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_abstract_wc_order_data_store_cpt() &Class_Abstract_WC_Order_Data_Store_CPT {
	mut obj := &Class_Abstract_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
		meta_type: rt.new_string('post')
		internal_meta_keys: rt.new_array()
		internal_data_store_key_getters: rt.new_array()
	}
	return obj
}

fn create_wc_data_store_wp() &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_internal_data_store_key_getters' {
			return this.get_internal_data_store_key_getters()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'order_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.order_exists(dispatch_arg_0))
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'set_order_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.set_order_props(dispatch_arg_0, mut dispatch_arg_1)
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
		'get_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post_status(dispatch_arg_0)
		}
		'get_post_excerpt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_post_excerpt(dispatch_arg_0))
		}
		'get_post_title' {
			return this.get_post_title()
		}
		'get_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_key(dispatch_arg_0)
		}
		'read_order_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.read_order_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_post_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'clear_caches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_caches(dispatch_arg_0)
			return rt.new_null()
		}
		'read_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.read_items(dispatch_arg_0, dispatch_arg_1)
		}
		'get_order_item_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_order_item_type(dispatch_arg_0, dispatch_arg_1)
		}
		'prime_order_item_caches_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_order_item_caches_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prime_product_post_caches_for_order_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.prime_product_post_caches_for_order_items(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'prime_refund_caches_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_refund_caches_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prime_needs_processing_transients' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_needs_processing_transients(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete_items(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_payment_token_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_payment_token_ids(dispatch_arg_0)
		}
		'update_payment_token_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_payment_token_ids(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_title' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_title(mut dispatch_arg_0)
		}
		'update_order_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_order_from_object(dispatch_arg_0))
		}
		'update_post_modified_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_post_modified_data(dispatch_arg_0, dispatch_arg_1)
		}
		'update_order_meta_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_order_meta_from_object(dispatch_arg_0)
			return rt.new_null()
		}
		'get_refund_orders_join_clause' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_refund_orders_join_clause(dispatch_arg_0))
		}
		'get_refund_orders_batch_join_clause' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_refund_orders_batch_join_clause(mut dispatch_arg_0))
		}
		'get_refund_parent_column' {
			return rt.new_string(this.get_refund_parent_column())
		}
		'get_batch_refund_totals' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_batch_refund_totals(mut dispatch_arg_0)
		}
		'get_refunded_item_meta_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_float(this.get_refunded_item_meta_total(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'get_total_tax_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_tax_refunded(dispatch_arg_0)
		}
		'get_total_shipping_tax_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_shipping_tax_refunded(dispatch_arg_0)
		}
		'get_total_shipping_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_shipping_refunded(dispatch_arg_0)
		}
		'prime_refund_total_caches_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_refund_total_caches_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Abstract_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_type' { return this.meta_type }
		'internal_meta_keys' { return this.internal_meta_keys }
		'internal_data_store_key_getters' { return this.internal_data_store_key_getters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_type' { this.meta_type = val; return true }
		'internal_meta_keys' { this.internal_meta_keys = val; return true }
		'internal_data_store_key_getters' { this.internal_data_store_key_getters = val; return true }
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


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_data_stores_abstract_wc_order_data_store_cpt_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
