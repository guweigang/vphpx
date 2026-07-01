import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.meta_key_name() string {
	return '_edit_lock'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) get_lock(mut var_order Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order) bool {
	mut var_order_mutated := var_order
	mut var_lock := rt.call_method(var_order_mutated, 'get_meta', [Class_Automattic_WooCommerce_Internal_Admin_Orders_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.meta_key_name(), rt.new_bool(true), rt.new_string('edit')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_lock)))) {
		return false
	}
	var_lock = rt.call_function('explode', [rt.new_string(':'), var_lock.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_time := rt.call_function('absint', [var_lock.array_get(0)])
	mut var_user_id := if var_lock.array_isset(rt.new_int(1)) { rt.call_function('absint', [var_lock.array_get(1)]) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_time)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_by', [rt.new_string('id'), var_user_id.dup()]))))))) {
		return false
	}
	mut var_time_window := rt.call_function('apply_filters', [rt.new_string('wp_check_post_lock_window'), rt.new_int(150)])
	if rt.is_true(rt.greater_equal(rt.call_function('time', []rt.PhpVal{}), rt.add(var_time, var_time_window))) {
		return false
	}
	return (rt.call_function('compact', [rt.new_string('time'), rt.new_string('user_id')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) is_locked_by_another_user(mut var_order Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order) bool {
	mut var_order_mutated := var_order
	mut var_lock := rt.new_bool(this.get_lock(mut var_order_mutated))
	return rt.is_true(var_lock) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) is_locked(mut var_order Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order) bool {
	mut var_order_mutated := var_order
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) lock(mut var_order Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order) bool {
	mut var_order_mutated := var_order
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return false
	}
	rt.call_method(var_order_mutated, 'update_meta_data', [Class_Automattic_WooCommerce_Internal_Admin_Orders_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.meta_key_name(), (rt.call_function('time', []rt.PhpVal{})).str() + ':' + (var_user_id).str()])
	rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	return (rt.call_method(var_order_mutated, 'get_meta', [Class_Automattic_WooCommerce_Internal_Admin_Orders_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.meta_key_name(), rt.new_bool(true), rt.new_string('edit')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) refresh_lock_ajax(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_order_id := rt.call_function('absint', [if !(var_data.array_get('wc-refresh-order-lock')).is_null() { var_data.array_get('wc-refresh-order-lock') } else { rt.new_int(0) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return var_response_mutated.dup()
	}
	var_response_mutated.array_unset(rt.new_string('wp-refresh-post-lock'))
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_order.dup(), Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order.class()]))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.call_method(var_order, 'get_type', []rt.PhpVal{})]), 'cap'), 'edit_post'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))))))) {
		return var_response_mutated.dup()
	}
	var_response_mutated.array_set('wc-refresh-order-lock', rt.new_array())
	if !(this.is_locked_by_another_user(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](var_order))) {
		var_response_mutated.array_get_mut('wc-refresh-order-lock').array_set('lock', this.lock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](var_order)))
	} else {
		mut var_current_lock := rt.new_bool(this.get_lock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](var_order)))
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), var_current_lock.array_get('user_id')])
		var_response_mutated.array_get_mut('wc-refresh-order-lock').array_set('error', rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s has taken over and is currently editing.'), rt.new_string('woocommerce')]), rt.get_property(var_user, 'display_name')]) }, rt.ArrayItem{ key: 'user_name', val: rt.get_property(var_user, 'display_name') }, rt.ArrayItem{ key: 'user_avatar_src', val: if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) { rt.call_function('get_avatar_url', [rt.get_property(var_user, 'ID'), rt.create_array([rt.ArrayItem{ key: 'size', val: 64 }])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'user_avatar_src_2x', val: if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) { rt.call_function('get_avatar_url', [rt.get_property(var_user, 'ID'), rt.create_array([rt.ArrayItem{ key: 'size', val: 128 }])]) } else { rt.new_string('') } }]))
	}
	return var_response_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) check_locked_orders_ajax(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	if rt.is_true(rt.new_bool(!rt.is_true(var_data.array_get('wc-check-locked-orders')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.array_get('wc-check-locked-orders').is_array()))))))) {
		return var_response_mutated.dup()
	}
	var_response_mutated.array_set('wc-check-locked-orders', rt.new_array())
	mut var_order_ids := rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('absint'), var_data.array_get('wc-check-locked-orders')])])
	{
		mut iter_1 := var_order_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order_id := item_1.val
			mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_order.dup(), Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order.class()]))))))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(this.is_locked_by_another_user(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](var_order))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.call_method(var_order, 'get_type', []rt.PhpVal{})]), 'cap'), 'edit_post'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))))))) {
				continue
			}
			var_response_mutated.array_get_mut('wc-check-locked-orders').array_set(var_order_id, true)
		}
	}
	return var_response_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) render_dialog(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_lock := rt.new_bool(this.get_lock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](var_order_mutated)))
	mut var_user := if rt.is_true(var_lock) { rt.call_function('get_user_by', [rt.new_string('id'), var_lock.array_get('user_id')]) } else { rt.new_bool(false) }
	mut var_locked := rt.new_bool(rt.new_bool(rt.is_true(var_user) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	mut var_edit_url := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class()]), 'get_edit_url', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
	mut var_sendback_url := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sendback_url)))) {
		var_sendback_url = rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class()]), 'get_base_page_url', [rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{})])
	}
	mut var_sendback_text := rt.call_function('__', [rt.new_string('Go back'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_locked) { '' } else { 'hidden' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_locked) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_avatar', [rt.get_property(var_user, 'ID'), rt.new_int(64)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is currently editing this order. Do you want to take over?'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.get_property(var_user, 'display_name')])])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_sendback_url.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_sendback_text.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('claim-lock'), rt.new_string('1'), rt.call_function('wp_nonce_url', [var_edit_url.dup(), 'claim-lock-' + (rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str()])])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Take over'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_sendback_url.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_sendback_text.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn create_automattic_woocommerce_internal_admin_orders_editlock() &Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_lock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.get_lock(mut dispatch_arg_0))
		}
		'is_locked_by_another_user' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_locked_by_another_user(mut dispatch_arg_0))
		}
		'is_locked' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_locked(mut dispatch_arg_0))
		}
		'lock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.lock(mut dispatch_arg_0))
		}
		'refresh_lock_ajax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.refresh_lock_ajax(dispatch_arg_0, dispatch_arg_1)
		}
		'check_locked_orders_ajax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.check_locked_orders_ajax(dispatch_arg_0, dispatch_arg_1)
		}
		'render_dialog' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_dialog(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_orders_editlock_php() {
}
