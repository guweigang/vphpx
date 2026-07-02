import rt

struct Class_WC_Meta_Box_Order_Actions {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Order_Actions.output(var_post rt.PhpVal) {
	mut var_theorder := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.init_theorder_object(var_post.clone())
	mut var_order := var_theorder
	mut var_order_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	mut var_order_actions :=
		Class_WC_Meta_Box_Order_Actions.get_available_order_actions_for_order(var_order.clone())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_order_actions_start'),
		var_order_id.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose an action...'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_order_actions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_title := item_1.val
		mut var_action := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_action.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Apply'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'),
		var_order_id.clone()]))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
			mut var_delete_text := rt.call_function('__', [
				rt.new_string('Delete permanently'),
				rt.new_string('woocommerce'),
			])
		} else {
			var_delete_text = rt.call_function('__', [rt.new_string('Move to Trash'),
				rt.new_string('woocommerce')])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			Class_WC_Meta_Box_Order_Actions.get_trash_or_delete_order_link(var_order_id.to_i64()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_delete_text.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(), rt.call_method(var_order, 'get_status', []rt.PhpVal{}))) { rt.call_function('esc_attr__', [
			rt.new_string('Create'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('esc_attr__', [rt.new_string('Update'),
			rt.new_string('woocommerce')]) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(), rt.call_method(var_order, 'get_status', []rt.PhpVal{}))) { rt.call_function('esc_html__', [
			rt.new_string('Create'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('esc_html__', [rt.new_string('Update'),
			rt.new_string('woocommerce')]) })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_order_actions_end'),
		var_order_id.clone()])
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Meta_Box_Order_Actions.get_trash_or_delete_order_link(order_id i64) string {
	mut order_id_mutated := order_id
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_1) {
		mut var_order_type := rt.call_method(rt.call_function('wc_get_order', [
			rt.new_int(order_id_mutated).clone(),
		]), 'get_type', []rt.PhpVal{})
		mut var_order_list_url := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class(),
		]), 'get_base_page_url', [var_order_type.clone()])
		mut var_trash_order_url := rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'action', val: 'trash' },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: none, val: order_id_mutated },
				]) }, rt.ArrayItem{ key: '_wp_http_referer', val: var_order_list_url }]),
			var_order_list_url.clone(),
		])
		return (rt.call_function('wp_nonce_url', [var_trash_order_url.clone(),
			rt.new_string('bulk-orders')])).str()
	}
	return (rt.call_function('get_delete_post_link', [rt.new_int(order_id_mutated).clone()])).str()
}

fn Class_WC_Meta_Box_Order_Actions.save(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_post_id.clone()])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('wc_order_action')))) {
		mut var_action := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('wc_order_action')),
			]),
		])
		if rt.is_true(rt.identical(rt.new_string('send_order_details'), var_action)) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_before_resend_order_emails'),
				var_order.clone(),
				rt.new_string('customer_invoice'),
			])
			rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
			rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer',
				[]rt.PhpVal{}), 'customer_invoice', [var_order.clone()])
			rt.call_method(var_order, 'add_order_note', [
				rt.call_function('__', [
					rt.new_string('Order details manually sent to customer.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_bool(false),
				rt.new_bool(true),
				rt.create_array([
					rt.ArrayItem{
						key: 'note_group'
						val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.email_notification()
					},
				]),
			])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_after_resend_order_email'),
				var_order.clone(),
				rt.new_string('customer_invoice'),
			])
			rt.call_function('add_filter', [rt.new_string('redirect_post_location'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'set_email_sent_message' }])])
		} else if rt.is_true(rt.identical(rt.new_string('send_order_details_admin'), var_action)) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_before_resend_order_emails'),
				var_order.clone(),
				rt.new_string('new_order'),
			])
			rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
			rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_new_order_email_allows_resend'),
				rt.new_string('__return_true'),
			])
			rt.call_method(rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
				'mailer', []rt.PhpVal{}), 'emails').array_get(rt.new_string('WC_Email_New_Order')),
				'trigger', [rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
				var_order.clone(), rt.new_bool(true)])
			rt.call_function('remove_filter', [
				rt.new_string('woocommerce_new_order_email_allows_resend'),
				rt.new_string('__return_true'),
			])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_after_resend_order_email'),
				var_order.clone(),
				rt.new_string('new_order'),
			])
			rt.call_function('add_filter', [rt.new_string('redirect_post_location'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'set_email_sent_message' }])])
		} else if rt.is_true(rt.identical(rt.new_string('regenerate_download_permissions'),
			var_action))
		{
			mut iife_temp_2 := Class_WC_Data_Store{}
			mut iife_result_2 := iife_temp_2.load(rt.new_string('customer-download'))
			mut var_data_store := iife_result_2
			rt.call_method(var_data_store, 'delete_by_order_id', [
				var_post_id.clone()])
			rt.call_function('wc_downloadable_product_permissions', [
				var_post_id.clone(), rt.new_bool(true)])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
			rt.new_string('woocommerce_order_action_' +
				(rt.call_function('sanitize_title', [var_action.clone()])).str()),
		])))))
		{
			rt.call_function('do_action', [
				rt.new_string('woocommerce_order_action_' +
					(rt.call_function('sanitize_title', [var_action.clone()])).str()),
				var_order.clone(),
			])
		}
	}
}

fn Class_WC_Meta_Box_Order_Actions.set_email_sent_message(var_location rt.PhpVal) rt.PhpVal {
	return rt.call_function('add_query_arg', [rt.new_string('message'),
		rt.new_int(11), var_location.clone()])
}

fn Class_WC_Meta_Box_Order_Actions.get_available_order_actions_for_order(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_actions := {
		'send_order_details':              rt.call_function('__', [
			rt.new_string('Send order details to customer'),
			rt.new_string('woocommerce'),
		])
		'send_order_details_admin':        rt.call_function('__', [
			rt.new_string('Resend new order notification'),
			rt.new_string('woocommerce'),
		])
		'regenerate_download_permissions': rt.call_function('__', [
			rt.new_string('Regenerate download permissions'),
			rt.new_string('woocommerce'),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_actions'),
		rt.create_array_from_native_map(var_actions), var_order_mutated.clone()])
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_meta_box_order_actions(_args ...rt.PhpVal) &Class_WC_Meta_Box_Order_Actions {
	mut obj := &Class_WC_Meta_Box_Order_Actions{
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Order_Actions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Actions.output(dispatch_arg_0)
			return rt.new_null()
		}
		'get_trash_or_delete_order_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_WC_Meta_Box_Order_Actions.get_trash_or_delete_order_link(dispatch_arg_0))
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Actions.save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_email_sent_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Meta_Box_Order_Actions.set_email_sent_message(dispatch_arg_0)
		}
		'get_available_order_actions_for_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Meta_Box_Order_Actions.get_available_order_actions_for_order(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Order_Actions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Order_Actions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
