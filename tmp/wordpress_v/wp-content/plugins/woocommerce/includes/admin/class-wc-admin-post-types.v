import rt

struct Class_WC_Admin_Post_Types {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Post_Types) construct()  {
	rt.include_file(@DIR + '/class-wc-admin-meta-boxes.php', '2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('duplicate_post_plugin_activation')]))))) {
		rt.include_file(@DIR + '/class-wc-admin-duplicate-product.php', '2')
	}
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_screen' }])])
	rt.call_function('add_action', [rt.new_string('check_ajax_referer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_screen' }])])
	rt.call_function('add_filter', [rt.new_string('post_updated_messages'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'post_updated_messages' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_updated_messages'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'order_updated_messages' }])])
	rt.call_function('add_filter', [rt.new_string('bulk_post_updated_messages'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bulk_post_updated_messages' }]), rt.new_int(10), rt.new_int(2)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	this.maybe_display_warning_for_password_protected_coupon()
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_1_fn)])
	rt.call_function('add_action', [rt.new_string('admin_print_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'disable_autosave' }])])
	rt.call_function('add_action', [rt.new_string('edit_form_top'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'edit_form_top' }])])
	rt.call_function('add_filter', [rt.new_string('enter_title_here'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enter_title_here' }]), rt.new_int(1), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('edit_form_after_title'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'edit_form_after_title' }])])
	rt.call_function('add_filter', [rt.new_string('default_hidden_meta_boxes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hidden_meta_boxes' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('post_submitbox_misc_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_data_visibility' }])])
	rt.include_file(@DIR + '/class-wc-admin-upload-downloadable-product.php', '2')
	rt.call_function('add_filter', [rt.new_string('theme_page_templates'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hide_cpt_archive_templates' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edit_form_top'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'show_cpt_archive_notice' }])])
	rt.call_function('add_filter', [rt.new_string('display_post_states'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_display_post_states' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('bulk_edit_custom_box'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bulk_edit' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('quick_edit_custom_box'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'quick_edit' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_hook' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_bulk_and_quick_edit'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_save_post' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_Admin_Post_Types) setup_screen()  {
	// unsupported statement: Stmt_Global
	mut var_request_data := this.request_data()
	mut var_screen_id := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')])) {
		mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
		var_screen_id = if !(var_screen).is_null() && !(rt.get_property(var_screen, 'id')).is_null() { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	}
	if !(!rt.is_true(var_request_data.array_get('screen'))) {
		var_screen_id = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_request_data.array_get('screen')])])
	}
	mut switch_val_1 := var_screen_id
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-shop_order'))) {
		rt.include_file(@DIR + '/list-tables/class-wc-admin-list-table-orders.php', '2')
		mut var_wc_list_table := create_wc_admin_list_table_orders()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-shop_coupon'))) {
		rt.include_file(@DIR + '/list-tables/class-wc-admin-list-table-coupons.php', '2')
		var_wc_list_table = create_wc_admin_list_table_coupons()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-product'))) {
		rt.include_file(@DIR + '/list-tables/class-wc-admin-list-table-products.php', '2')
		var_wc_list_table = create_wc_admin_list_table_products()
	}
	rt.call_function('remove_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_screen' }])])
	rt.call_function('remove_action', [rt.new_string('check_ajax_referer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_screen' }])])
}

fn (mut this Class_WC_Admin_Post_Types) post_updated_messages(var_messages rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_messages_mutated := var_messages
	// unsupported statement: Stmt_Global
	var_messages_mutated.array_set('product', rt.create_array([rt.ArrayItem{ key: 0, val: '' }, rt.ArrayItem{ key: 1, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product updated. %1$sView Product%2$s'), rt.new_string('woocommerce')]), '<a id="woocommerce-product-updated-message-view-product__link" href="' + (rt.call_function('esc_url', [rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])])).str() + '">', rt.new_string('</a>')]) }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Custom field updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Custom field deleted.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Product updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 5, val: rt.call_function('__', [rt.new_string('Revision restored.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 6, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product published. %1$sView Product%2$s'), rt.new_string('woocommerce')]), '<a id="woocommerce-product-updated-message-view-product__link" href="' + (rt.call_function('esc_url', [rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])])).str() + '">', rt.new_string('</a>')]) }, rt.ArrayItem{ key: 7, val: rt.call_function('__', [rt.new_string('Product saved.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 8, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product submitted. <a target="_blank" href="%s">Preview product</a>'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('preview'), rt.new_string('true'), rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])])])]) }, rt.ArrayItem{ key: 9, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product scheduled for: %1$s. <a target="_blank" href="%2$s">Preview product</a>'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('M j, Y @ G:i'), rt.new_string('woocommerce')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])])).str() + '</strong>', rt.call_function('esc_url', [rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])])]) }, rt.ArrayItem{ key: 10, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product draft updated. <a target="_blank" href="%s">Preview product</a>'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('preview'), rt.new_string('true'), rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])])])]) }]))
	var_messages_mutated = this.order_updated_messages(mut rt.cast_object_ptr[Class_array](var_messages_mutated))
	var_messages_mutated.array_set('shop_coupon', rt.create_array([rt.ArrayItem{ key: 0, val: '' }, rt.ArrayItem{ key: 1, val: rt.call_function('__', [rt.new_string('Coupon updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Custom field updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Custom field deleted.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Coupon updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 5, val: rt.call_function('__', [rt.new_string('Revision restored.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 6, val: rt.call_function('__', [rt.new_string('Coupon updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 7, val: rt.call_function('__', [rt.new_string('Coupon saved.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 8, val: rt.call_function('__', [rt.new_string('Coupon submitted.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 9, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Coupon scheduled for: %s.'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('M j, Y @ G:i'), rt.new_string('woocommerce')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])])).str() + '</strong>']) }, rt.ArrayItem{ key: 10, val: rt.call_function('__', [rt.new_string('Coupon draft updated.'), rt.new_string('woocommerce')]) }]))
	return var_messages_mutated.dup()
}

fn (mut this Class_WC_Admin_Post_Types) order_updated_messages(mut var_messages Class_array) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_theorder := rt.new_null()
	mut var_messages_mutated := var_messages
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(!(var_theorder).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theorder, 'WC_Abstract_Order')))))))) {
		if rt.is_true(rt.new_bool(!(!(var_post).is_null()) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return rt.new_object('array', []string{}, var_messages_mutated)
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.init_theorder_object(arg_0) }(var_post.dup())
		}
	}
	var_messages_mutated.array_set('shop_order', rt.create_array([rt.ArrayItem{ key: 0, val: '' }, rt.ArrayItem{ key: 1, val: rt.call_function('__', [rt.new_string('Order updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Custom field updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Custom field deleted.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Order updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 5, val: rt.call_function('__', [rt.new_string('Revision restored.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 6, val: rt.call_function('__', [rt.new_string('Order updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 7, val: rt.call_function('__', [rt.new_string('Order saved.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 8, val: rt.call_function('__', [rt.new_string('Order submitted.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 9, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order scheduled for: %s.'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('M j, Y @ G:i'), rt.new_string('woocommerce')]), rt.call_function('strtotime', [if !(rt.call_method(var_theorder, 'get_date_created', []rt.PhpVal{})).is_null() { rt.call_method(var_theorder, 'get_date_created', []rt.PhpVal{}) } else { rt.get_property(var_post, 'post_date') }])])).str() + '</strong>']) }, rt.ArrayItem{ key: 10, val: rt.call_function('__', [rt.new_string('Order draft updated.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 11, val: rt.call_function('__', [rt.new_string('Order updated and sent.'), rt.new_string('woocommerce')]) }]))
	return rt.new_object('array', []string{}, var_messages_mutated)
}

fn (mut this Class_WC_Admin_Post_Types) bulk_post_updated_messages(var_bulk_messages rt.PhpVal, var_bulk_counts rt.PhpVal) rt.PhpVal {
	mut var_bulk_messages_mutated := var_bulk_messages
	var_bulk_messages_mutated.array_set('product', rt.create_array([rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [rt.new_string('%s product updated.'), rt.new_string('%s products updated.'), var_bulk_counts.array_get('updated'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'locked', val: rt.call_function('_n', [rt.new_string('%s product not updated, somebody is editing it.'), rt.new_string('%s products not updated, somebody is editing them.'), var_bulk_counts.array_get('locked'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [rt.new_string('%s product permanently deleted.'), rt.new_string('%s products permanently deleted.'), var_bulk_counts.array_get('deleted'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [rt.new_string('%s product moved to the Trash.'), rt.new_string('%s products moved to the Trash.'), var_bulk_counts.array_get('trashed'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [rt.new_string('%s product restored from the Trash.'), rt.new_string('%s products restored from the Trash.'), var_bulk_counts.array_get('untrashed'), rt.new_string('woocommerce')]) }]))
	var_bulk_messages_mutated.array_set('shop_order', rt.create_array([rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [rt.new_string('%s order updated.'), rt.new_string('%s orders updated.'), var_bulk_counts.array_get('updated'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'locked', val: rt.call_function('_n', [rt.new_string('%s order not updated, somebody is editing it.'), rt.new_string('%s orders not updated, somebody is editing them.'), var_bulk_counts.array_get('locked'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [rt.new_string('%s order permanently deleted.'), rt.new_string('%s orders permanently deleted.'), var_bulk_counts.array_get('deleted'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [rt.new_string('%s order moved to the Trash.'), rt.new_string('%s orders moved to the Trash.'), var_bulk_counts.array_get('trashed'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [rt.new_string('%s order restored from the Trash.'), rt.new_string('%s orders restored from the Trash.'), var_bulk_counts.array_get('untrashed'), rt.new_string('woocommerce')]) }]))
	var_bulk_messages_mutated.array_set('shop_coupon', rt.create_array([rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [rt.new_string('%s coupon updated.'), rt.new_string('%s coupons updated.'), var_bulk_counts.array_get('updated'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'locked', val: rt.call_function('_n', [rt.new_string('%s coupon not updated, somebody is editing it.'), rt.new_string('%s coupons not updated, somebody is editing them.'), var_bulk_counts.array_get('locked'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [rt.new_string('%s coupon permanently deleted.'), rt.new_string('%s coupons permanently deleted.'), var_bulk_counts.array_get('deleted'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [rt.new_string('%s coupon moved to the Trash.'), rt.new_string('%s coupons moved to the Trash.'), var_bulk_counts.array_get('trashed'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [rt.new_string('%s coupon restored from the Trash.'), rt.new_string('%s coupons restored from the Trash.'), var_bulk_counts.array_get('untrashed'), rt.new_string('woocommerce')]) }]))
	return var_bulk_messages_mutated.dup()
}

fn (mut this Class_WC_Admin_Post_Types) maybe_display_warning_for_password_protected_coupon()  {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')]))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(var_GLOBALS.array_isset(rt.new_string('post'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('This coupon is password protected. WooCommerce does not support password protection for coupons. You can temporarily hide a coupon by making it private. Alternatively, usage limits and restrictions can be configured below.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'id', val: 'wc-password-protected-coupon-warning' }, rt.ArrayItem{ key: 'additional_classes', val: if !rt.is_true(rt.get_property(var_GLOBALS.array_get('post'), 'post_password')) { rt.create_array([rt.ArrayItem{ key: none, val: 'hidden' }]) } else { rt.new_array() } }])])
}

fn (mut this Class_WC_Admin_Post_Types) bulk_edit(var_column_name rt.PhpVal, var_post_type rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_shipping_class := rt.call_function('get_terms', [rt.new_string('product_shipping_class'), rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }])])
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/admin/views/html-bulk-edit-product.php', '1')
}

fn (mut this Class_WC_Admin_Post_Types) quick_edit(var_column_name rt.PhpVal, var_post_type rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_shipping_class := rt.call_function('get_terms', [rt.new_string('product_shipping_class'), rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }])])
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/admin/views/html-quick-edit-product.php', '1')
}

fn (mut this Class_WC_Admin_Post_Types) bulk_and_quick_edit_hook(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	rt.call_function('remove_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_hook' }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_product_bulk_and_quick_edit'), var_post_id.dup(), var_post.dup()])
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_hook' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_Admin_Post_Types) bulk_and_quick_edit_save_post(var_post_id rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_request_data := this.request_data()
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('DOING_AUTOSAVE'))) {
		return var_post_id.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_post_revision', [var_post_id.dup()])) || rt.is_true(rt.call_function('wp_is_post_autosave', [var_post_id.dup()])))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()]))))))) {
		return var_post_id.dup()
	}
	if rt.is_true(rt.new_bool(!(var_request_data.array_isset(rt.new_string('woocommerce_quick_edit_nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_request_data.array_get('woocommerce_quick_edit_nonce'), rt.new_string('woocommerce_quick_edit_nonce')]))))))) {
		return var_post_id.dup()
	}
	mut var_product := rt.call_function('wc_get_product', [var_post.dup()])
	if !(!rt.is_true(var_request_data.array_get('woocommerce_quick_edit'))) {
		this.quick_edit_save(var_post_id.dup(), var_product.dup())
	} else {
		this.bulk_edit_save(var_post_id.dup(), var_product.dup())
	}
	return var_post_id.dup()
}

fn (mut this Class_WC_Admin_Post_Types) quick_edit_save(var_post_id rt.PhpVal, var_product rt.PhpVal)  {
	mut var_product_mutated := var_product
	mut var_request_data := this.request_data()
	mut var_data_store := rt.call_method(var_product_mutated, 'get_data_store', []rt.PhpVal{})
	mut var_old_regular_price := rt.call_method(var_product_mutated, 'get_regular_price', []rt.PhpVal{})
	mut var_old_sale_price := rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{})
	mut var_input_to_props := { '_weight': 'weight', '_length': 'length', '_width': 'width', '_height': 'height', '_visibility': 'catalog_visibility', '_tax_class': 'tax_class', '_tax_status': 'tax_status' }
	for var_input_var, var_prop in var_input_to_props {
		if var_request_data.array_isset(rt.new_string(input_var)) {
			rt.call_method(var_product_mutated, "set_${var_prop}", [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_request_data.array_get(input_var)])])])
		}
	}
	if var_request_data.array_isset(rt.new_string('_sku')) {
		mut var_sku := rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{})
		mut var_new_sku := // unsupported expression: Expr_Cast_String
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if !(!rt.is_true(var_new_sku)) {
				mut var_unique_sku := rt.call_function('wc_product_has_unique_sku', [var_post_id.dup(), var_new_sku.dup()])
				if rt.is_true(var_unique_sku) {
					rt.call_method(var_product_mutated, 'set_sku', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_new_sku.dup()])])])
				}
			} else {
				rt.call_method(var_product_mutated, 'set_sku', [rt.new_string('')])
			}
		}
	}
	if !(!rt.is_true(var_request_data.array_get('_shipping_class'))) {
		if rt.is_true(rt.identical(rt.new_string('_no_shipping_class'), var_request_data.array_get('_shipping_class'))) {
			rt.call_method(var_product_mutated, 'set_shipping_class_id', [rt.new_int(0)])
		} else {
			mut var_shipping_class_id := rt.call_method(var_data_store, 'get_shipping_class_id_by_slug', [rt.call_function('wc_clean', [])])
			rt.call_method(var_product_mutated, 'set_shipping_class_id', [var_shipping_class_id.dup()])
		}
	}
	if !(!rt.is_true(var_request_data.array_get('_tax_class'))) {
		mut var_tax_class := rt.call_function('sanitize_title', [])
		if rt.is_true(rt.identical(, )) {
			
		}
		
	}
	
}

fn (mut this Class_WC_Admin_Post_Types) bulk_edit_save(var_post_id rt.PhpVal, var_product rt.PhpVal)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_Admin_Post_Types) disable_autosave()  {
	mut var_post := rt.new_null()
}

fn (mut this Class_WC_Admin_Post_Types) edit_form_top(var_post rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Post_Types) enter_title_here(var_text rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
}

fn (mut this Class_WC_Admin_Post_Types) edit_form_after_title(var_post rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Post_Types) hidden_meta_boxes(var_hidden rt.PhpVal, var_screen rt.PhpVal) rt.PhpVal {
	mut var_hidden_mutated := var_hidden
	mut var_screen_mutated := var_screen
}

fn (mut this Class_WC_Admin_Post_Types) product_data_visibility()  {
	mut var_post := rt.new_null()
}

fn (mut this Class_WC_Admin_Post_Types) process_product_file_download_paths(var_product_id rt.PhpVal, var_variation_id rt.PhpVal, var_downloadable_files rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Post_Types) hide_cpt_archive_templates(var_page_templates rt.PhpVal, var_theme rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_page_templates_mutated := var_page_templates
}

fn (mut this Class_WC_Admin_Post_Types) show_cpt_archive_notice(var_post rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Post_Types) add_display_post_states(var_post_states rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_states_mutated := var_post_states
}

fn (mut this Class_WC_Admin_Post_Types) maybe_update_stock_status(var_product rt.PhpVal, var_stock_status rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_stock_status_mutated := var_stock_status
}

fn (mut this Class_WC_Admin_Post_Types) set_new_price(var_product rt.PhpVal, var_price_type rt.PhpVal) bool {
	mut var_product_mutated := var_product
	return false
}

fn (mut this Class_WC_Admin_Post_Types) request_data() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Post_Types) maybe_update_cogs_value(mut var_product Class_WC_Product, mut var_request_data Class_array)  {
	mut var_product_mutated := var_product
	mut var_request_data_mutated := var_request_data
}

struct Class_WC_Admin_List_Table_Orders {
	rt.PhpObjectBase
}

struct Class_WC_Admin_List_Table_Coupons {
	rt.PhpObjectBase
}

struct Class_WC_Admin_List_Table_Products {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_admin_post_types() &Class_WC_Admin_Post_Types {
	mut obj := &Class_WC_Admin_Post_Types{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_admin_list_table_orders() &Class_WC_Admin_List_Table_Orders {
	mut obj := &Class_WC_Admin_List_Table_Orders{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_list_table_coupons() &Class_WC_Admin_List_Table_Coupons {
	mut obj := &Class_WC_Admin_List_Table_Coupons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_list_table_products() &Class_WC_Admin_List_Table_Products {
	mut obj := &Class_WC_Admin_List_Table_Products{
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

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Post_Types) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'setup_screen' {
			this.setup_screen()
			return rt.new_null()
		}
		'post_updated_messages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.post_updated_messages(dispatch_arg_0)
		}
		'order_updated_messages' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.order_updated_messages(mut dispatch_arg_0)
		}
		'bulk_post_updated_messages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.bulk_post_updated_messages(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_display_warning_for_password_protected_coupon' {
			this.maybe_display_warning_for_password_protected_coupon()
			return rt.new_null()
		}
		'bulk_edit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.bulk_edit(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'quick_edit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.quick_edit(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'bulk_and_quick_edit_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.bulk_and_quick_edit_hook(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'bulk_and_quick_edit_save_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.bulk_and_quick_edit_save_post(dispatch_arg_0, dispatch_arg_1)
		}
		'quick_edit_save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.quick_edit_save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'bulk_edit_save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.bulk_edit_save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'disable_autosave' {
			this.disable_autosave()
			return rt.new_null()
		}
		'edit_form_top' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.edit_form_top(dispatch_arg_0)
			return rt.new_null()
		}
		'enter_title_here' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.enter_title_here(dispatch_arg_0, dispatch_arg_1)
		}
		'edit_form_after_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.edit_form_after_title(dispatch_arg_0)
			return rt.new_null()
		}
		'hidden_meta_boxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.hidden_meta_boxes(dispatch_arg_0, dispatch_arg_1)
		}
		'product_data_visibility' {
			this.product_data_visibility()
			return rt.new_null()
		}
		'process_product_file_download_paths' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.process_product_file_download_paths(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'hide_cpt_archive_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.hide_cpt_archive_templates(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'show_cpt_archive_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.show_cpt_archive_notice(dispatch_arg_0)
			return rt.new_null()
		}
		'add_display_post_states' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_display_post_states(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_update_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.maybe_update_stock_status(dispatch_arg_0, dispatch_arg_1)
		}
		'set_new_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_new_price(dispatch_arg_0, dispatch_arg_1))
		}
		'request_data' {
			return this.request_data()
		}
		'maybe_update_cogs_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.maybe_update_cogs_value(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Post_Types) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Post_Types) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_List_Table_Orders) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_List_Table_Orders) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_List_Table_Orders) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_List_Table_Coupons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_List_Table_Coupons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_List_Table_Coupons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_List_Table_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_List_Table_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_List_Table_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_post_types_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Post_Types'), rt.new_bool(false)])) {
		create_wc_admin_post_types()
		return rt.new_null()
	}
}
