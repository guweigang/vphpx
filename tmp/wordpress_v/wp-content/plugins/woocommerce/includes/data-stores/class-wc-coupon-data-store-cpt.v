import rt
import crypto.md5

struct Class_WC_Coupon_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
		meta_type rt.PhpVal = rt.new_string('post')
		internal_meta_keys rt.PhpVal = rt.new_array()
		updated_props rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) create(var_coupon rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'get_date_created', [rt.new_string('edit')]))))) {
		rt.call_method(var_coupon, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	mut var_coupon_id := rt.call_function('wp_insert_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_new_coupon_data'), rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'shop_coupon' }, rt.ArrayItem{ key: 'post_status', val: if rt.is_true(rt.call_method(var_coupon, 'get_status', [rt.new_string('edit')])) { rt.call_method(var_coupon, 'get_status', [rt.new_string('edit')]) } else { rt.new_string('publish') } }, rt.ArrayItem{ key: 'post_author', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_title', val: rt.call_method(var_coupon, 'get_code', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'post_content', val: '' }, rt.ArrayItem{ key: 'post_excerpt', val: rt.call_method(var_coupon, 'get_description', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'post_date', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_coupon, 'get_date_created', []rt.PhpVal{}), 'getOffsetTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_coupon, 'get_date_created', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})]) }])]), rt.new_bool(true)])
	if rt.is_true(var_coupon_id) {
		rt.call_method(var_coupon, 'set_id', [var_coupon_id.dup()])
		this.update_post_meta(var_coupon.dup())
		rt.call_method(var_coupon, 'save_meta_data', []rt.PhpVal{})
		rt.call_method(var_coupon, 'apply_changes', []rt.PhpVal{})
		rt.call_function('delete_transient', [rt.new_string('rest_api_coupons_type_count')])
		rt.call_function('do_action', [rt.new_string('woocommerce_new_coupon'), var_coupon_id.dup(), var_coupon.dup()])
	}
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) read(var_coupon rt.PhpVal)  {
	rt.call_method(var_coupon, 'set_defaults', []rt.PhpVal{})
	mut var_post_object := rt.call_function('get_post', [rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_post_object)))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid coupon.'), rt.new_string('woocommerce')]))))
	}
	mut var_coupon_id := rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})
	mut var_limit_usage_to_x_items := rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('limit_usage_to_x_items'), rt.new_bool(true)])
	rt.call_method(var_coupon, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'code', val: rt.get_property(var_post_object, 'post_title') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_post_object, 'post_excerpt') }, rt.ArrayItem{ key: 'status', val: rt.get_property(var_post_object, 'post_status') }, rt.ArrayItem{ key: 'date_created', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_date_gmt')) }, rt.ArrayItem{ key: 'date_modified', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_modified_gmt')) }, rt.ArrayItem{ key: 'date_expires', val: if rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), var_coupon_id.dup(), rt.new_string('date_expires')])) { rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('date_expires'), rt.new_bool(true)]) } else { rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('expiry_date'), rt.new_bool(true)]) } }, rt.ArrayItem{ key: 'discount_type', val: rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('discount_type'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('coupon_amount'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'usage_count', val: rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('usage_count'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'individual_use', val: rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('individual_use'), rt.new_bool(true)])) }, rt.ArrayItem{ key: 'product_ids', val: this.get_coupon_meta_as_array(var_coupon_id.dup(), 'product_ids') }, rt.ArrayItem{ key: 'excluded_product_ids', val: this.get_coupon_meta_as_array(var_coupon_id.dup(), 'exclude_product_ids') }, rt.ArrayItem{ key: 'usage_limit', val: rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('usage_limit'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'usage_limit_per_user', val: rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('usage_limit_per_user'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'limit_usage_to_x_items', val: if rt.is_true(rt.greater(var_limit_usage_to_x_items, rt.new_int(0))) { var_limit_usage_to_x_items } else { rt.new_null() } }, rt.ArrayItem{ key: 'free_shipping', val: rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('free_shipping'), rt.new_bool(true)])) }, rt.ArrayItem{ key: 'product_categories', val: rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('product_categories'), rt.new_bool(true)]))]) }, rt.ArrayItem{ key: 'excluded_product_categories', val: rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('exclude_product_categories'), rt.new_bool(true)]))]) }, rt.ArrayItem{ key: 'exclude_sale_items', val: rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('exclude_sale_items'), rt.new_bool(true)])) }, rt.ArrayItem{ key: 'minimum_amount', val: rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('minimum_amount'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'maximum_amount', val: rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('maximum_amount'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'email_restrictions', val: rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_post_meta', [var_coupon_id.dup(), rt.new_string('customer_email'), rt.new_bool(true)]))]) }])])
	rt.call_method(var_coupon, 'read_meta_data', []rt.PhpVal{})
	rt.call_method(var_coupon, 'set_object_read', [rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('woocommerce_coupon_loaded'), var_coupon.dup()])
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_coupon_meta_as_array(var_coupon_id rt.PhpVal, meta_key string) rt.PhpVal {
	mut var_coupon_id_mutated := var_coupon_id
	mut var_meta_value := rt.call_function('get_post_meta', [var_coupon_id_mutated.dup(), rt.new_string(meta_key), rt.new_bool(true)])
	return rt.call_function('array_filter', [if rt.is_true(rt.new_bool(var_meta_value.dup().is_array())) { var_meta_value } else { rt.call_function('explode', [rt.new_string(','), var_meta_value.dup()]) }])
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) update(var_coupon rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_coupon, 'save_meta_data', []rt.PhpVal{})
	mut var_changes := rt.call_method(var_coupon, 'get_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_function('array_intersect', [rt.create_array([rt.ArrayItem{ key: none, val: 'code' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'date_modified' }, rt.ArrayItem{ key: none, val: 'status' }]), rt.func_array_keys(var_changes.dup())])) {
		mut var_post_data := { 'post_title': rt.call_method(var_coupon, 'get_code', [rt.new_string('edit')]), 'post_excerpt': rt.call_method(var_coupon, 'get_description', [rt.new_string('edit')]), 'post_status': rt.call_method(var_coupon, 'get_status', [rt.new_string('edit')]), 'post_date': rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_coupon, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]), 'post_date_gmt': rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_coupon, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]), 'post_modified': if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_coupon, 'get_date_modified', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]) } else { rt.call_function('current_time', [rt.new_string('mysql')]) }, 'post_modified_gmt': if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_coupon, 'get_date_modified', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) } else { rt.call_function('current_time', [rt.new_string('mysql'), rt.new_int(1)]) } }
		if rt.is_true(rt.call_function('doing_action', [rt.new_string('save_post')])) {
			rt.call_method(var_GLOBALS.array_get('wpdb'), 'update', [rt.get_property(var_GLOBALS.array_get('wpdb'), 'posts'), var_post_data.dup(), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}) }])])
			rt.call_function('clean_post_cache', [rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})])
		} else {
			rt.call_function('wp_update_post', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}) }]), var_post_data.dup()])])
		}
		rt.call_method(var_coupon, 'read_meta_data', [rt.new_bool(true)])
		// unsupported statement: Stmt_Nop
	}
	this.update_post_meta(var_coupon.dup())
	rt.call_method(var_coupon, 'apply_changes', []rt.PhpVal{})
	rt.call_function('delete_transient', [rt.new_string('rest_api_coupons_type_count')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_hashed_code := rt.new_string(rt.new_string(md5.hexhash(rt.call_function('wc_strtolower', [rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})]).to_string())))
		rt.call_function('wp_cache_delete', [(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('coupons'))).str() + 'coupon_id_from_code_' + (var_hashed_code).str(), rt.new_string('coupons')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_coupon'), rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), var_coupon.dup()])
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) delete(var_coupon rt.PhpVal, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'force_delete', val: false }])])
	mut var_id := rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return rt.new_null()
	}
	if rt.is_true(var_args_mutated.array_get('force_delete')) {
		rt.call_function('wp_delete_post', [var_id.dup()])
		mut var_hashed_code := rt.new_string(rt.new_string(md5.hexhash(rt.call_function('wc_strtolower', [rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})]).to_string())))
		rt.call_function('wp_cache_delete', [(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('coupons'))).str() + 'coupon_id_from_code_' + (var_hashed_code).str(), rt.new_string('coupons')])
		rt.call_method(var_coupon, 'set_id', [rt.new_int(0)])
		rt.call_function('do_action', [rt.new_string('woocommerce_delete_coupon'), var_id.dup()])
	} else {
		rt.call_function('wp_trash_post', [var_id.dup()])
		rt.call_method(var_coupon, 'set_status', [rt.new_string('trash')])
		rt.call_function('do_action', [rt.new_string('woocommerce_trash_coupon'), var_id.dup()])
	}
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) update_post_meta(var_coupon rt.PhpVal)  {
	mut var_meta_key_to_props := { 'discount_type': 'discount_type', 'coupon_amount': 'amount', 'individual_use': 'individual_use', 'product_ids': 'product_ids', 'exclude_product_ids': 'excluded_product_ids', 'usage_limit': 'usage_limit', 'usage_limit_per_user': 'usage_limit_per_user', 'limit_usage_to_x_items': 'limit_usage_to_x_items', 'usage_count': 'usage_count', 'date_expires': 'date_expires', 'free_shipping': 'free_shipping', 'product_categories': 'product_categories', 'exclude_product_categories': 'excluded_product_categories', 'exclude_sale_items': 'exclude_sale_items', 'minimum_amount': 'minimum_amount', 'maximum_amount': 'maximum_amount', 'customer_email': 'email_restrictions' }
	mut var_props_to_update := this.get_props_to_update(var_coupon.dup(), var_meta_key_to_props.dup())
	{
		mut iter_1 := var_props_to_update.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prop := item_1.val
			mut var_meta_key := item_1.key
			mut var_value := rt.call_method(var_coupon, "get_${var_prop.to_string()}", [rt.new_string('edit')])
			var_value = if rt.is_true(rt.new_bool(var_value.dup().is_string())) { rt.call_function('wp_slash', [var_value.dup()]) } else { var_value }
			mut switch_val_1 := var_prop
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('individual_use'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('free_shipping'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('exclude_sale_items'))) {
				var_value = rt.call_function('wc_bool_to_string', [var_value.dup()])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_ids'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('excluded_product_ids'))) {
				var_value = rt.call_function('implode', [rt.new_string(','), rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('intval'), var_value.dup()])])])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_categories'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('excluded_product_categories'))) {
				var_value = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('intval'), var_value.dup()])])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email_restrictions'))) {
				var_value = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('sanitize_email'), var_value.dup()])])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_expires'))) {
				var_value = if rt.is_true(var_value) { rt.call_method(var_value, 'getTimestamp', []rt.PhpVal{}) } else { rt.new_null() }
			}
			mut var_updated := this.update_or_delete_post_meta(var_coupon.dup(), var_meta_key.dup(), var_value.dup())
			if rt.is_true(var_updated) {
				this.updated_props.array_push(var_prop.dup())
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_coupon_object_updated_props'), var_coupon.dup(), this.updated_props])
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) increase_usage_count(var_coupon rt.PhpVal, used_by string, var_order rt.PhpVal) rt.PhpVal {
	mut var_coupon_held_key_for_user := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		var_coupon_held_key_for_user = rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}), 'get_coupon_held_keys_for_users', [var_order.dup(), rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})])
	}
	mut var_new_count := this.update_usage_count_meta(var_coupon.dup(), 'increase')
	if var_used_by.len > 0 && var_used_by != '0' {
		this.add_coupon_used_by(var_coupon.dup(), rt.new_string(used_by), var_coupon_held_key_for_user.dup())
		rt.call_method(var_coupon, 'set_used_by', [rt.cast_array(rt.call_function('get_post_meta', [rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), rt.new_string('_used_by')]))])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_increase_coupon_usage_count'), var_coupon.dup(), var_new_count.dup(), rt.new_string(used_by)])
	return var_new_count.dup()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) add_coupon_used_by(var_coupon rt.PhpVal, var_used_by rt.PhpVal, var_coupon_held_key rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(var_coupon_held_key) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_result := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tUPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' SET meta_key = %s, meta_value = %s WHERE meta_key = %s LIMIT 1')), rt.new_string('_used_by'), var_used_by.dup(), var_coupon_held_key.dup()])])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
			rt.call_function('add_post_meta', [rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), rt.new_string('_used_by'), rt.new_string(var_used_by.dup().to_string().to_lower())])
		}
	} else {
		rt.call_function('add_post_meta', [rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), rt.new_string('_used_by'), rt.new_string(var_used_by.dup().to_string().to_lower())])
	}
	this.refresh_coupon_data(var_coupon.dup())
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) decrease_usage_count(var_coupon rt.PhpVal, used_by string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_new_count := this.update_usage_count_meta(var_coupon.dup(), 'decrease')
	if var_used_by.len > 0 && var_used_by != '0' {
		mut var_meta_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_used_by\' AND meta_value = %s AND post_id = %d LIMIT 1;')), rt.new_string(used_by), rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})])])
		if rt.is_true(var_meta_id) {
			rt.call_function('delete_metadata_by_mid', [rt.new_string('post'), var_meta_id.dup()])
			rt.call_method(var_coupon, 'set_used_by', [rt.cast_array(rt.call_function('get_post_meta', [rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), rt.new_string('_used_by')]))])
			this.refresh_coupon_data(var_coupon.dup())
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_decrease_coupon_usage_count'), var_coupon.dup(), var_new_count.dup(), rt.new_string(used_by)])
	return var_new_count.dup()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) update_usage_count_meta(var_coupon rt.PhpVal, operation string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_id := rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})
	mut var_operator := rt.new_string(if rt.is_true(rt.identical(rt.new_string('increase'), rt.new_string(operation))) { rt.new_string('+') } else { rt.new_string('-') })
	rt.call_function('add_post_meta', [var_id.dup(), rt.new_string('usage_count'), rt.call_method(var_coupon, 'get_usage_count', [rt.new_string('edit')]), rt.new_bool(true)])
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' SET meta_value = meta_value ')), var_operator), rt.new_string(' 1 WHERE meta_key = \'usage_count\' AND post_id = %d;')), var_id.dup()])])
	this.refresh_coupon_data(var_coupon.dup())
	return // unsupported expression: Expr_Cast_Int
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_tentative_usage_count(var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_coupon_id_mutated := var_coupon_id
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'get_var', [this.get_tentative_usage_query(var_coupon_id_mutated.dup())])
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_usage_by_user_id(var_coupon rt.PhpVal, var_user_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_usage_count := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT COUNT( meta_id ) FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = \'_used_by\' AND meta_value = %s;')), rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), var_user_id.dup()])])
	mut var_tentative_usage_count := this.get_tentative_usages_for_user(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: var_user_id }]))
	return rt.add(var_tentative_usage_count, var_usage_count)
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_usage_by_email(var_coupon rt.PhpVal, var_email rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_usage_count := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT COUNT( meta_id ) FROM '), rt.get_property(, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = \'_used_by\' AND meta_value = %s;')), rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), var_email.dup()])])
	mut var_tentative_usage_count := this.get_tentative_usages_for_user(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: var_email }]))
	return rt.add(var_tentative_usage_count, var_usage_count)
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_tentative_usages_for_user(var_coupon_id rt.PhpVal, var_user_aliases rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_coupon_id_mutated := var_coupon_id
	// unsupported statement: Stmt_Global
	return rt.call_method(, 'get_var', [])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_tentative_held_time() rt.PhpVal {
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) check_and_hold_coupon(var_coupon rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_tentative_usage_query(var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_coupon_id_mutated := var_coupon_id
	return rt.new_null()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) check_and_hold_coupon_for_user(var_coupon rt.PhpVal, var_user_aliases rt.PhpVal, var_user_alias rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_tentative_usage_query_for_user(var_coupon_id rt.PhpVal, var_user_aliases rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_coupon_id_mutated := var_coupon_id
	return rt.new_null()
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) refresh_coupon_data(var_coupon rt.PhpVal)  {
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_code_by_id(var_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) get_ids_by_code(var_code rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

struct Class_WC_Data_Store_WP {
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

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_coupon_data_store_cpt() &Class_WC_Coupon_Data_Store_CPT {
	mut obj := &Class_WC_Coupon_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
		meta_type: rt.new_string('post')
		internal_meta_keys: rt.new_array()
		updated_props: rt.new_array()
	}
	return obj
}

fn create_wc_data_store_wp() &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
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

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'get_coupon_meta_as_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_coupon_meta_as_array(dispatch_arg_0, dispatch_arg_1)
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
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_post_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'increase_usage_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.increase_usage_count(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_coupon_used_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_coupon_used_by(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'decrease_usage_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.decrease_usage_count(dispatch_arg_0, dispatch_arg_1)
		}
		'update_usage_count_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.update_usage_count_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tentative_usage_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tentative_usage_count(dispatch_arg_0)
		}
		'get_usage_by_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_usage_by_user_id(dispatch_arg_0, dispatch_arg_1)
		}
		'get_usage_by_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_usage_by_email(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tentative_usages_for_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_tentative_usages_for_user(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tentative_held_time' {
			return this.get_tentative_held_time()
		}
		'check_and_hold_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.check_and_hold_coupon(dispatch_arg_0)
		}
		'get_tentative_usage_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tentative_usage_query(dispatch_arg_0)
		}
		'check_and_hold_coupon_for_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_and_hold_coupon_for_user(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_tentative_usage_query_for_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_tentative_usage_query_for_user(dispatch_arg_0, dispatch_arg_1)
		}
		'refresh_coupon_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.refresh_coupon_data(dispatch_arg_0)
			return rt.new_null()
		}
		'get_code_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_code_by_id(dispatch_arg_0)
		}
		'get_ids_by_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_ids_by_code(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Coupon_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_type' { return this.meta_type }
		'internal_meta_keys' { return this.internal_meta_keys }
		'updated_props' { return this.updated_props }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Coupon_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_type' { this.meta_type = val; return true }
		'internal_meta_keys' { this.internal_meta_keys = val; return true }
		'updated_props' { this.updated_props = val; return true }
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


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_coupon_data_store_cpt_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
