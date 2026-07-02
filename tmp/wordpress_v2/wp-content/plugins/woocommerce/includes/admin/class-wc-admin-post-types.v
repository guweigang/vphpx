import rt

struct Class_WC_Admin_Post_Types {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Post_Types) construct() {
	rt.include_file(@DIR + '/class-wc-admin-meta-boxes.php', '2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('duplicate_post_plugin_activation'),
	])))))
	{
		rt.include_file(@DIR + '/class-wc-admin-duplicate-product.php', '2')
	}
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup_screen' },
		])])
	rt.call_function('add_action', [rt.new_string('check_ajax_referer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup_screen' },
		])])
	rt.call_function('add_filter', [rt.new_string('post_updated_messages'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'post_updated_messages' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_updated_messages'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_updated_messages' },
		])])
	rt.call_function('add_filter', [rt.new_string('bulk_post_updated_messages'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'bulk_post_updated_messages' },
		]),
		rt.new_int(10), rt.new_int(2)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.maybe_display_warning_for_password_protected_coupon()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.new_closure(closure_1_fn)])
	rt.call_function('add_action', [rt.new_string('admin_print_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'disable_autosave' },
		])])
	rt.call_function('add_action', [rt.new_string('edit_form_top'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'edit_form_top' },
		])])
	rt.call_function('add_filter', [rt.new_string('enter_title_here'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enter_title_here' },
		]),
		rt.new_int(1), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('edit_form_after_title'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'edit_form_after_title' },
		])])
	rt.call_function('add_filter', [rt.new_string('default_hidden_meta_boxes'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'hidden_meta_boxes' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('post_submitbox_misc_actions'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_data_visibility' },
		])])
	rt.include_file(@DIR + '/class-wc-admin-upload-downloadable-product.php', '2')
	rt.call_function('add_filter', [rt.new_string('theme_page_templates'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'hide_cpt_archive_templates' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edit_form_top'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'show_cpt_archive_notice' },
		])])
	rt.call_function('add_filter', [rt.new_string('display_post_states'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_display_post_states' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('bulk_edit_custom_box'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'bulk_edit' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('quick_edit_custom_box'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'quick_edit' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('save_post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_hook' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_bulk_and_quick_edit'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_save_post' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_Admin_Post_Types) setup_screen() {
	mut var_wc_list_table := rt.get_superglobal('wc_list_table')
	mut var_request_data := this.request_data()
	mut var_screen_id := rt.new_bool(false)
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_current_screen'),
	]))
	{
		mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
		var_screen_id = if !var_screen.is_null() && !(rt.get_property(var_screen, 'id')).is_null() {
			rt.get_property(var_screen, 'id')
		} else {
			rt.new_string('')
		}
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('screen')))) {
		var_screen_id = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [var_request_data.array_get(rt.new_string('screen'))]),
		])
	}
	mut switch_val_1 := var_screen_id
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-shop_order'))) {
		rt.include_file(@DIR + '/list-tables/class-wc-admin-list-table-orders.php', '2')
		var_wc_list_table = create_wc_admin_list_table_orders()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-shop_coupon'))) {
		rt.include_file(@DIR + '/list-tables/class-wc-admin-list-table-coupons.php', '2')
		var_wc_list_table = create_wc_admin_list_table_coupons()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-product'))) {
		rt.include_file(@DIR + '/list-tables/class-wc-admin-list-table-products.php', '2')
		var_wc_list_table = create_wc_admin_list_table_products()
	}
	rt.call_function('remove_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup_screen' },
		])])
	rt.call_function('remove_action', [rt.new_string('check_ajax_referer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup_screen' },
		])])
}

fn (mut this Class_WC_Admin_Post_Types) post_updated_messages(var_messages rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_messages_mutated := var_messages
	var_messages_mutated.array_set('product', rt.create_array([
		rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Product updated. %1$sView Product%2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<a id="woocommerce-product-updated-message-view-product__link" href="' +
				(rt.call_function('esc_url', [rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])])).str() +
				'">'),
			rt.new_string('</a>'),
		]) },
		rt.ArrayItem{ key: 2, val: rt.call_function('__', [
			rt.new_string('Custom field updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 3, val: rt.call_function('__', [
			rt.new_string('Custom field deleted.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 4, val: rt.call_function('__', [
			rt.new_string('Product updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 5, val: rt.call_function('__', [
			rt.new_string('Revision restored.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 6, val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Product published. %1$sView Product%2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<a id="woocommerce-product-updated-message-view-product__link" href="' +
				(rt.call_function('esc_url', [rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])])).str() +
				'">'),
			rt.new_string('</a>'),
		]) },
		rt.ArrayItem{ key: 7, val: rt.call_function('__', [
			rt.new_string('Product saved.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 8, val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Product submitted. <a target="_blank" href="%s">Preview product</a>'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.new_string('preview'),
					rt.new_string('true'),
					rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')]),
				]),
			]),
		]) },
		rt.ArrayItem{ key: 9, val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Product scheduled for: %1$s. <a target="_blank" href="%2$s">Preview product</a>'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<strong>' +
				(rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('M j, Y @ G:i'), rt.new_string('woocommerce')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])])).str() +
				'</strong>'),
			rt.call_function('esc_url', [
				rt.call_function('get_permalink', [
					rt.get_property(var_post, 'ID'),
				]),
			]),
		]) },
		rt.ArrayItem{ key: 10, val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Product draft updated. <a target="_blank" href="%s">Preview product</a>'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.new_string('preview'),
					rt.new_string('true'),
					rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')]),
				]),
			]),
		]) },
	]))
	var_messages_mutated =
		this.order_updated_messages(mut rt.cast_object_ptr[Class_array](var_messages_mutated))
	var_messages_mutated.array_set('shop_coupon', rt.create_array([
		rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('__', [
			rt.new_string('Coupon updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 2, val: rt.call_function('__', [
			rt.new_string('Custom field updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 3, val: rt.call_function('__', [
			rt.new_string('Custom field deleted.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 4, val: rt.call_function('__', [
			rt.new_string('Coupon updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 5, val: rt.call_function('__', [
			rt.new_string('Revision restored.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 6, val: rt.call_function('__', [
			rt.new_string('Coupon updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 7, val: rt.call_function('__', [
			rt.new_string('Coupon saved.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 8, val: rt.call_function('__', [
			rt.new_string('Coupon submitted.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 9, val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Coupon scheduled for: %s.'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('M j, Y @ G:i'), rt.new_string('woocommerce')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])])).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{ key: 10, val: rt.call_function('__', [
			rt.new_string('Coupon draft updated.'),
			rt.new_string('woocommerce'),
		]) },
	]))
	return var_messages_mutated.clone()
}

fn (mut this Class_WC_Admin_Post_Types) order_updated_messages(mut var_messages Class_array) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_theorder := rt.new_null()
	mut var_messages_mutated := var_messages
	if !(!var_theorder.is_null())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theorder, 'WC_Abstract_Order')))))) {
		if !(!var_post.is_null())
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), rt.get_property(var_post, 'post_type'))))) {
			return rt.new_object('array', []string{}, var_messages_mutated)
		} else {
			mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
			mut iife_result_1 := iife_temp_1.init_theorder_object(var_post.clone())
		}
	}
	var_messages_mutated.array_set('shop_order', rt.create_array([
		rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('__', [
			rt.new_string('Order updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 2, val: rt.call_function('__', [
			rt.new_string('Custom field updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 3, val: rt.call_function('__', [
			rt.new_string('Custom field deleted.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 4, val: rt.call_function('__', [
			rt.new_string('Order updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 5, val: rt.call_function('__', [
			rt.new_string('Revision restored.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 6, val: rt.call_function('__', [
			rt.new_string('Order updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 7, val: rt.call_function('__', [
			rt.new_string('Order saved.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 8, val: rt.call_function('__', [
			rt.new_string('Order submitted.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 9, val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Order scheduled for: %s.'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('date_i18n', [rt.call_function('__', [rt.new_string('M j, Y @ G:i'), rt.new_string('woocommerce')]), rt.call_function('strtotime', [if !(rt.call_method(var_theorder, 'get_date_created', []rt.PhpVal{})).is_null() { rt.call_method(var_theorder, 'get_date_created', []rt.PhpVal{}) } else { rt.get_property(var_post, 'post_date') }])])).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{ key: 10, val: rt.call_function('__', [
			rt.new_string('Order draft updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 11, val: rt.call_function('__', [
			rt.new_string('Order updated and sent.'),
			rt.new_string('woocommerce'),
		]) },
	]))
	return rt.new_object('array', []string{}, var_messages_mutated)
}

fn (mut this Class_WC_Admin_Post_Types) bulk_post_updated_messages(var_bulk_messages rt.PhpVal, var_bulk_counts rt.PhpVal) rt.PhpVal {
	mut var_bulk_messages_mutated := var_bulk_messages
	var_bulk_messages_mutated.array_set('product', rt.create_array([
		rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [
			rt.new_string('%s product updated.'),
			rt.new_string('%s products updated.'),
			var_bulk_counts.array_get(rt.new_string('updated')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'locked', val: rt.call_function('_n', [
			rt.new_string('%s product not updated, somebody is editing it.'),
			rt.new_string('%s products not updated, somebody is editing them.'),
			var_bulk_counts.array_get(rt.new_string('locked')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [
			rt.new_string('%s product permanently deleted.'),
			rt.new_string('%s products permanently deleted.'),
			var_bulk_counts.array_get(rt.new_string('deleted')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [
			rt.new_string('%s product moved to the Trash.'),
			rt.new_string('%s products moved to the Trash.'),
			var_bulk_counts.array_get(rt.new_string('trashed')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [
			rt.new_string('%s product restored from the Trash.'),
			rt.new_string('%s products restored from the Trash.'),
			var_bulk_counts.array_get(rt.new_string('untrashed')),
			rt.new_string('woocommerce'),
		]) },
	]))
	var_bulk_messages_mutated.array_set('shop_order', rt.create_array([
		rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [
			rt.new_string('%s order updated.'),
			rt.new_string('%s orders updated.'),
			var_bulk_counts.array_get(rt.new_string('updated')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'locked', val: rt.call_function('_n', [
			rt.new_string('%s order not updated, somebody is editing it.'),
			rt.new_string('%s orders not updated, somebody is editing them.'),
			var_bulk_counts.array_get(rt.new_string('locked')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [
			rt.new_string('%s order permanently deleted.'),
			rt.new_string('%s orders permanently deleted.'),
			var_bulk_counts.array_get(rt.new_string('deleted')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [
			rt.new_string('%s order moved to the Trash.'),
			rt.new_string('%s orders moved to the Trash.'),
			var_bulk_counts.array_get(rt.new_string('trashed')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [
			rt.new_string('%s order restored from the Trash.'),
			rt.new_string('%s orders restored from the Trash.'),
			var_bulk_counts.array_get(rt.new_string('untrashed')),
			rt.new_string('woocommerce'),
		]) },
	]))
	var_bulk_messages_mutated.array_set('shop_coupon', rt.create_array([
		rt.ArrayItem{ key: 'updated', val: rt.call_function('_n', [
			rt.new_string('%s coupon updated.'),
			rt.new_string('%s coupons updated.'),
			var_bulk_counts.array_get(rt.new_string('updated')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'locked', val: rt.call_function('_n', [
			rt.new_string('%s coupon not updated, somebody is editing it.'),
			rt.new_string('%s coupons not updated, somebody is editing them.'),
			var_bulk_counts.array_get(rt.new_string('locked')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'deleted', val: rt.call_function('_n', [
			rt.new_string('%s coupon permanently deleted.'),
			rt.new_string('%s coupons permanently deleted.'),
			var_bulk_counts.array_get(rt.new_string('deleted')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'trashed', val: rt.call_function('_n', [
			rt.new_string('%s coupon moved to the Trash.'),
			rt.new_string('%s coupons moved to the Trash.'),
			var_bulk_counts.array_get(rt.new_string('trashed')),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'untrashed', val: rt.call_function('_n', [
			rt.new_string('%s coupon restored from the Trash.'),
			rt.new_string('%s coupons restored from the Trash.'),
			var_bulk_counts.array_get(rt.new_string('untrashed')),
			rt.new_string('woocommerce'),
		]) },
	]))
	return var_bulk_messages_mutated.clone()
}

fn (mut this Class_WC_Admin_Post_Types) maybe_display_warning_for_password_protected_coupon() {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return
	}
	if !(var_GLOBALS.array_isset(rt.new_string('post')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.get_property(var_GLOBALS.array_get(rt.new_string('post')), 'post_type'))))) {
		return
	}
	rt.call_function('wp_admin_notice', [
		rt.call_function('__', [
			rt.new_string('This coupon is password protected. WooCommerce does not support password protection for coupons. You can temporarily hide a coupon by making it private. Alternatively, usage limits and restrictions can be configured below.'),
			rt.new_string('woocommerce'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'warning' },
			rt.ArrayItem{ key: 'id', val: 'wc-password-protected-coupon-warning' },
			rt.ArrayItem{
				key: 'additional_classes'
				val: if !rt.is_true(rt.get_property(var_GLOBALS.array_get(rt.new_string('post')), 'post_password')) { rt.create_array([
						rt.ArrayItem{ key: none, val: 'hidden' },
					]) } else { rt.new_array() }
			},
		]),
	])
}

fn (mut this Class_WC_Admin_Post_Types) bulk_edit(var_column_name rt.PhpVal, var_post_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('price'), var_column_name))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), var_post_type)))) {
		return
	}
	mut var_shipping_class := rt.call_function('get_terms', [
		rt.new_string('product_shipping_class'),
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }]),
	])
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/admin/views/html-bulk-edit-product.php', '1')
}

fn (mut this Class_WC_Admin_Post_Types) quick_edit(var_column_name rt.PhpVal, var_post_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('price'), var_column_name))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), var_post_type)))) {
		return
	}
	mut var_shipping_class := rt.call_function('get_terms', [
		rt.new_string('product_shipping_class'),
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }]),
	])
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/admin/views/html-quick-edit-product.php', '1')
}

fn (mut this Class_WC_Admin_Post_Types) bulk_and_quick_edit_hook(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	rt.call_function('remove_action', [rt.new_string('save_post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_hook' },
		])])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_bulk_and_quick_edit'),
		var_post_id.clone(),
		var_post.clone(),
	])
	rt.call_function('add_action', [rt.new_string('save_post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Post_Types', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'bulk_and_quick_edit_hook' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_Admin_Post_Types) bulk_and_quick_edit_save_post(var_post_id rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_request_data := this.request_data()
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.is_true(rt.new_string('DOING_AUTOSAVE'))
	if rt.is_true(iife_result_2) {
		return var_post_id.clone()
	}
	if rt.is_true(rt.call_function('wp_is_post_revision', [var_post_id.clone()]))
		|| rt.is_true(rt.call_function('wp_is_post_autosave', [var_post_id.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post, 'post_type')))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()]))))) {
		return var_post_id.clone()
	}
	if !(var_request_data.array_isset(rt.new_string('woocommerce_quick_edit_nonce')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_request_data.array_get(rt.new_string('woocommerce_quick_edit_nonce')), rt.new_string('woocommerce_quick_edit_nonce')]))))) {
		return var_post_id.clone()
	}
	mut var_product := rt.call_function('wc_get_product', [var_post.clone()])
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('woocommerce_quick_edit')))) {
		this.quick_edit_save(var_post_id.clone(), var_product.clone())
	} else {
		this.bulk_edit_save(var_post_id.clone(), var_product.clone())
	}
	return var_post_id.clone()
}

fn (mut this Class_WC_Admin_Post_Types) quick_edit_save(var_post_id rt.PhpVal, var_product rt.PhpVal) {
	mut var_product_mutated := var_product
	mut var_request_data := this.request_data()
	mut var_data_store := rt.call_method(var_product_mutated, 'get_data_store', []rt.PhpVal{})
	mut var_old_regular_price := rt.call_method(var_product_mutated, 'get_regular_price',
		[]rt.PhpVal{})
	mut var_old_sale_price := rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{})
	mut var_input_to_props := {
		'_weight':     'weight'
		'_length':     'length'
		'_width':      'width'
		'_height':     'height'
		'_visibility': 'catalog_visibility'
		'_tax_class':  'tax_class'
		'_tax_status': 'tax_status'
	}
	for var_input_var, var_prop in var_input_to_props {
		if var_request_data.array_isset(rt.new_string(input_var)) {
			rt.call_method(var_product_mutated, 'set_${var_prop}', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						var_request_data.array_get(rt.new_string(input_var)),
					]),
				]),
			])
		}
	}
	if var_request_data.array_isset(rt.new_string('_sku')) {
		mut var_sku := rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{})
		mut var_new_sku := rt.new_string((rt.call_function('wc_clean', [
			var_request_data.array_get(rt.new_string('_sku')),
		])).str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_sku, var_sku)))) {
			if !(!rt.is_true(var_new_sku)) {
				mut var_unique_sku := rt.call_function('wc_product_has_unique_sku', [
					var_post_id.clone(),
					var_new_sku.clone(),
				])
				if rt.is_true(var_unique_sku) {
					rt.call_method(var_product_mutated, 'set_sku', [
						rt.call_function('wc_clean', [
							rt.call_function('wp_unslash', [var_new_sku.clone()]),
						]),
					])
				}
			} else {
				rt.call_method(var_product_mutated, 'set_sku', [
					rt.new_string('')])
			}
		}
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_shipping_class')))) {
		if rt.is_true(rt.identical(rt.new_string('_no_shipping_class'),
			var_request_data.array_get(rt.new_string('_shipping_class'))))
		{
			rt.call_method(var_product_mutated, 'set_shipping_class_id', [
				rt.new_int(0)])
		} else {
			mut var_shipping_class_id := rt.call_method(var_data_store,
				'get_shipping_class_id_by_slug', [
				rt.call_function('wc_clean', [
					var_request_data.array_get(rt.new_string('_shipping_class')),
				]),
			])
			rt.call_method(var_product_mutated, 'set_shipping_class_id', [
				var_shipping_class_id.clone()])
		}
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_tax_class')))) {
		mut var_tax_class := rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash',
				[var_request_data.array_get(rt.new_string('_tax_class'))]),
		])
		if rt.is_true(rt.identical(rt.new_string('standard'), var_tax_class)) {
			var_tax_class = rt.new_string('')
		}
		rt.call_method(var_product_mutated, 'set_tax_class', [
			var_tax_class.clone()])
	}
	rt.call_method(var_product_mutated, 'set_featured', [
		rt.new_bool(var_request_data.array_isset(rt.new_string('_featured'))),
	])
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.simple()]))
		|| rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) {
		if var_request_data.array_isset(rt.new_string('_regular_price')) {
			mut var_new_regular_price := if rt.is_true(rt.identical(rt.new_string(''), var_request_data.array_get(rt.new_string('_regular_price')))) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [
					var_request_data.array_get(rt.new_string('_regular_price')),
				]) }
			rt.call_method(var_product_mutated, 'set_regular_price', [
				var_new_regular_price.clone()])
		} else {
			var_new_regular_price = rt.new_null()
		}
		if var_request_data.array_isset(rt.new_string('_sale_price')) {
			mut var_new_sale_price := if rt.is_true(rt.identical(rt.new_string(''), var_request_data.array_get(rt.new_string('_sale_price')))) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [
					var_request_data.array_get(rt.new_string('_sale_price')),
				]) }
			rt.call_method(var_product_mutated, 'set_sale_price', [
				var_new_sale_price.clone()])
		} else {
			var_new_sale_price = rt.new_null()
		}
		mut var_price_changed := rt.new_bool(false)
		if !(var_new_regular_price.clone().is_null())
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_regular_price, var_old_regular_price)))) {
			var_price_changed = rt.new_bool(true)
		} else if !(var_new_sale_price.clone().is_null())
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_sale_price, var_old_sale_price)))) {
			var_price_changed = rt.new_bool(true)
		}
		if rt.is_true(var_price_changed) {
			rt.call_method(var_product_mutated, 'set_date_on_sale_to', [
				rt.new_string(''),
			])
			rt.call_method(var_product_mutated, 'set_date_on_sale_from', [
				rt.new_string(''),
			])
		}
	}
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{}))
		&& var_request_data.array_isset(rt.new_string('_cogs_value')) {
		mut var_cogs_value := var_request_data.array_get(rt.new_string('_cogs_value'))
		var_cogs_value = if rt.is_true(rt.identical(rt.new_string(''), var_cogs_value)) { rt.new_null() } else { rt.new_float((rt.call_function('wc_format_decimal', [
				var_cogs_value.clone(),
			])).to_f64()) }
		rt.call_method(var_product_mutated, 'set_cogs_value', [
			var_cogs_value.clone()])
	}
	mut var_manage_stock := rt.new_string((if
		!(!rt.is_true(var_request_data.array_get(rt.new_string('_manage_stock'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(), rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{}))))) {
		'yes'
	} else {
		'no'
	}).str())
	mut var_backorders := if !(!rt.is_true(var_request_data.array_get(rt.new_string('_backorders')))) { rt.call_function('wc_clean', [
			var_request_data.array_get(rt.new_string('_backorders')),
		]) } else { rt.new_string('no') }
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_stock_status')))) {
		mut var_stock_status := rt.call_function('wc_clean', [
			var_request_data.array_get(rt.new_string('_stock_status')),
		])
	} else {
		var_stock_status = if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variable(),
		]))
		{ rt.new_null() } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() }
	}
	rt.call_method(var_product_mutated, 'set_manage_stock', [
		var_manage_stock.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.external(), rt.call_method(var_product_mutated,
		'get_type', []rt.PhpVal{})))))
	{
		rt.call_method(var_product_mutated, 'set_backorders', [
			var_backorders.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		mut var_stock_amount := if rt.is_true(rt.identical(rt.new_string('yes'), var_manage_stock)) && var_request_data.array_isset(rt.new_string('_stock')) && rt.call_function('wp_unslash', [var_request_data.array_get(rt.new_string('_stock'))]).is_long() || rt.call_function('wp_unslash', [var_request_data.array_get(rt.new_string('_stock'))]).is_double() { rt.call_function('wc_stock_amount', [
				rt.call_function('wp_unslash', [var_request_data.array_get(rt.new_string('_stock'))]),
			]) } else { rt.new_string('') }
		rt.call_method(var_product_mutated, 'set_stock_quantity', [
			var_stock_amount.clone()])
	}
	var_product_mutated = this.maybe_update_stock_status(var_product_mutated.clone(),
		var_stock_status.clone())
	rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_product_quick_edit_save'),
		var_product_mutated.clone()])
}

fn (mut this Class_WC_Admin_Post_Types) bulk_edit_save(var_post_id rt.PhpVal, var_product rt.PhpVal) {
	mut var_product_mutated := var_product
	mut var_request_data := this.request_data()
	mut var_data_store := rt.call_method(var_product_mutated, 'get_data_store', []rt.PhpVal{})
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('change_weight'))))
		&& var_request_data.array_isset(rt.new_string('_weight')) {
		rt.call_method(var_product_mutated, 'set_weight', [
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[var_request_data.array_get(rt.new_string('_weight'))]),
			]),
		])
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('change_dimensions')))) {
		if var_request_data.array_isset(rt.new_string('_length')) {
			rt.call_method(var_product_mutated, 'set_length', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						var_request_data.array_get(rt.new_string('_length')),
					]),
				]),
			])
		}
		if var_request_data.array_isset(rt.new_string('_width')) {
			rt.call_method(var_product_mutated, 'set_width', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						var_request_data.array_get(rt.new_string('_width')),
					]),
				]),
			])
		}
		if var_request_data.array_isset(rt.new_string('_height')) {
			rt.call_method(var_product_mutated, 'set_height', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						var_request_data.array_get(rt.new_string('_height')),
					]),
				]),
			])
		}
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_tax_status')))) {
		rt.call_method(var_product_mutated, 'set_tax_status', [
			rt.call_function('wc_clean', [var_request_data.array_get(rt.new_string('_tax_status'))]),
		])
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_tax_class')))) {
		mut var_tax_class := rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash',
				[var_request_data.array_get(rt.new_string('_tax_class'))]),
		])
		if rt.is_true(rt.identical(rt.new_string('standard'), var_tax_class)) {
			var_tax_class = rt.new_string('')
		}
		rt.call_method(var_product_mutated, 'set_tax_class', [
			var_tax_class.clone()])
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_shipping_class')))) {
		if rt.is_true(rt.identical(rt.new_string('_no_shipping_class'),
			var_request_data.array_get(rt.new_string('_shipping_class'))))
		{
			rt.call_method(var_product_mutated, 'set_shipping_class_id', [
				rt.new_int(0)])
		} else {
			mut var_shipping_class_id := rt.call_method(var_data_store,
				'get_shipping_class_id_by_slug', [
				rt.call_function('wc_clean', [
					var_request_data.array_get(rt.new_string('_shipping_class')),
				]),
			])
			rt.call_method(var_product_mutated, 'set_shipping_class_id', [
				var_shipping_class_id.clone()])
		}
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_visibility')))) {
		rt.call_method(var_product_mutated, 'set_catalog_visibility', [
			rt.call_function('wc_clean', [var_request_data.array_get(rt.new_string('_visibility'))]),
		])
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_featured')))) {
		rt.call_method(var_product_mutated, 'set_featured', [
			rt.call_function('wp_unslash', [var_request_data.array_get(rt.new_string('_featured'))]),
		])
	}
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_sold_individually')))) {
		if rt.is_true(rt.identical(rt.new_string('yes'),
			var_request_data.array_get(rt.new_string('_sold_individually'))))
		{
			rt.call_method(var_product_mutated, 'set_sold_individually', [
				rt.new_string('yes'),
			])
		} else {
			rt.call_method(var_product_mutated, 'set_sold_individually', [
				rt.new_string(''),
			])
		}
	}
	mut var_change_price_product_types := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_bulk_edit_save_price_product_types'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.simple() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.external() },
		]),
	])
	mut var_can_product_type_change_price := rt.new_bool(false)
	mut iter_1 := var_change_price_product_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_type := item_1.val
		if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
			var_product_type.clone()]))
		{
			var_can_product_type_change_price = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(var_can_product_type_change_price) {
		mut var_regular_price_changed := rt.new_bool(this.set_new_price(var_product_mutated.clone(),
			rt.new_string('regular')))
		mut var_sale_price_changed := rt.new_bool(this.set_new_price(var_product_mutated.clone(),
			rt.new_string('sale')))
		if rt.is_true(var_regular_price_changed) || rt.is_true(var_sale_price_changed) {
			rt.call_method(var_product_mutated, 'set_date_on_sale_to', [
				rt.new_string(''),
			])
			rt.call_method(var_product_mutated, 'set_date_on_sale_from', [
				rt.new_string(''),
			])
			if rt.is_true(rt.less(rt.call_method(var_product_mutated, 'get_regular_price',
				[]rt.PhpVal{}),
				rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{})))
			{
				rt.call_method(var_product_mutated, 'set_sale_price', [
					rt.new_string('')])
			}
		}
	}
	mut var_was_managing_stock := rt.new_string((if rt.is_true(rt.call_method(var_product_mutated,
		'get_manage_stock', []rt.PhpVal{}))
	{
		'yes'
	} else {
		'no'
	}).str())
	mut var_backorders := rt.call_method(var_product_mutated, 'get_backorders', []rt.PhpVal{})
	var_backorders = if !(!rt.is_true(var_request_data.array_get(rt.new_string('_backorders')))) { rt.call_function('wc_clean', [
			var_request_data.array_get(rt.new_string('_backorders')),
		]) } else { var_backorders }
	if !(!rt.is_true(var_request_data.array_get(rt.new_string('_manage_stock')))) {
		mut var_manage_stock := rt.new_string((if
			rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('wc_clean', [var_request_data.array_get(rt.new_string('_manage_stock'))])))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(), rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{}))))) {
			'yes'
		} else {
			'no'
		}).str())
	} else {
		var_manage_stock = var_was_managing_stock.clone()
	}
	mut var_stock_amount := if rt.is_true(rt.identical(rt.new_string('yes'), var_manage_stock)) && !(!rt.is_true(var_request_data.array_get(rt.new_string('change_stock')))) && var_request_data.array_isset(rt.new_string('_stock')) { rt.call_function('wc_stock_amount', [
			var_request_data.array_get(rt.new_string('_stock')),
		]) } else { rt.call_method(var_product_mutated, 'get_stock_quantity', []rt.PhpVal{}) }
	rt.call_method(var_product_mutated, 'set_manage_stock', [
		var_manage_stock.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.external(), rt.call_method(var_product_mutated,
		'get_type', []rt.PhpVal{})))))
	{
		rt.call_method(var_product_mutated, 'set_backorders', [
			var_backorders.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		mut var_change_stock := rt.call_function('absint', [
			var_request_data.array_get(rt.new_string('change_stock')),
		])
		mut switch_val_2 := var_change_stock
		if rt.is_true(rt.equal(switch_val_2, rt.new_int(2))) {
			rt.call_function('wc_update_product_stock', [var_product_mutated.clone(),
				var_stock_amount.clone(), rt.new_string('increase'),
				rt.new_bool(true)])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(3))) {
			rt.call_function('wc_update_product_stock', [var_product_mutated.clone(),
				var_stock_amount.clone(), rt.new_string('decrease'),
				rt.new_bool(true)])
		} else {
			rt.call_function('wc_update_product_stock', [var_product_mutated.clone(),
				var_stock_amount.clone(), rt.new_string('set'),
				rt.new_bool(true)])
		}
	} else {
		rt.call_method(var_product_mutated, 'set_stock_quantity', [
			rt.new_string('')])
		rt.call_method(var_product_mutated, 'set_manage_stock', [
			rt.new_string('no')])
	}
	mut var_stock_status := if !rt.is_true(var_request_data.array_get(rt.new_string('_stock_status'))) { rt.new_null() } else { rt.call_function('wc_clean', [
			var_request_data.array_get(rt.new_string('_stock_status')),
		]) }
	var_product_mutated = this.maybe_update_stock_status(var_product_mutated.clone(),
		var_stock_status.clone())
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		this.maybe_update_cogs_value(mut rt.cast_object_ptr[Class_WC_Product](var_product_mutated), mut
			rt.cast_object_ptr[Class_array](var_request_data))
	}
	rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_product_bulk_edit_save'),
		var_product_mutated.clone()])
}

fn (mut this Class_WC_Admin_Post_Types) disable_autosave() {
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))
		&& rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [rt.get_property(var_post, 'ID')]), rt.call_function('wc_get_order_types', [rt.new_string('order-meta-boxes')]), rt.new_bool(true)])) {
		rt.call_function('wp_dequeue_script', [rt.new_string('autosave')])
	}
}

fn (mut this Class_WC_Admin_Post_Types) edit_form_top(var_post rt.PhpVal) {
	print('<input type="hidden" id="original_post_title" name="original_post_title" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_post, 'post_title')])).str() + '" />')
}

fn (mut this Class_WC_Admin_Post_Types) enter_title_here(var_text rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	mut switch_val_3 := rt.get_property(var_post, 'post_type')
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('product'))) {
		var_text_mutated = rt.call_function('esc_html__', [rt.new_string('Product name'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('shop_coupon'))) {
		var_text_mutated = rt.call_function('esc_html__', [rt.new_string('Coupon code'),
			rt.new_string('woocommerce')])
	}
	return var_text_mutated.clone()
}

fn (mut this Class_WC_Admin_Post_Types) edit_form_after_title(var_post rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.get_property(var_post, 'post_type'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Description (optional)'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_post, 'post_excerpt'))
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WC_Admin_Post_Types) hidden_meta_boxes(var_hidden rt.PhpVal, var_screen rt.PhpVal) rt.PhpVal {
	mut var_hidden_mutated := var_hidden
	mut var_screen_mutated := var_screen
	if rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_screen_mutated, 'post_type')))
		&& rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen_mutated, 'base'))) {
		var_hidden_mutated = rt.call_function('array_merge', [
			var_hidden_mutated.clone(), rt.create_array([
				rt.ArrayItem{ key: none, val: 'postcustom' },
			])])
	}
	return var_hidden_mutated.clone()
}

fn (mut this Class_WC_Admin_Post_Types) product_data_visibility() {
	mut var_post := rt.new_null()
	mut var_thepostid := rt.get_superglobal('thepostid')
	mut var_product_object := rt.get_superglobal('product_object')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post,
		'post_type')))))
	{
		return
	}
	var_thepostid = rt.get_property(var_post, 'ID')
	var_product_object = if rt.is_true(var_thepostid) { rt.call_function('wc_get_product', [
			var_thepostid.clone(),
		]) } else { create_wc_product() }
	mut var_current_visibility := rt.call_method(var_product_object, 'get_catalog_visibility',
		[]rt.PhpVal{})
	mut var_current_featured := rt.call_function('wc_bool_to_string', [
		rt.call_method(var_product_object, 'get_featured', []rt.PhpVal{}),
	])
	mut var_visibility_options := rt.call_function('wc_get_product_visibility_options',
		[]rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Catalog visibility:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if var_visibility_options.array_isset(var_current_visibility) { rt.call_function('esc_html', [
			var_visibility_options.array_get(var_current_visibility),
		]) } else { rt.call_function('esc_html', [var_current_visibility.clone()]) })
	if rt.is_true(rt.identical(rt.new_string('yes'), var_current_featured)) {
		print(', ' +(rt.call_function('esc_html__', [rt.new_string('Featured'), rt.new_string('woocommerce')])).str())
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_visibility.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_featured.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print('<p>' +
		(rt.call_function('esc_html__', [rt.new_string('This setting determines which shop pages products will be listed on.'), rt.new_string('woocommerce')])).str() +
		'</p>')
	mut iter_2 := var_visibility_options.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_label := item_2.val
		mut var_name := item_2.key
		print('<input type="radio" name="_visibility" id="_visibility_' +
			(rt.call_function('esc_attr', [var_name.clone()])).str() + '" value="' +
			(rt.call_function('esc_attr', [var_name.clone()])).str() + '" ' +
			(rt.call_function('checked', [var_current_visibility.clone(), var_name.clone(), rt.new_bool(false)])).str() +
			' data-label="' + (rt.call_function('esc_attr', [var_label.clone()])).str() +
			'" /> <label for="_visibility_' +
			(rt.call_function('esc_attr', [var_name.clone()])).str() + '" class="selectit">' +
			(rt.call_function('esc_html', [var_label.clone()])).str() + '</label><br />')
	}
	print('<br /><input type="checkbox" name="_featured" id="_featured" ' +
		(rt.call_function('checked', [var_current_featured.clone(), rt.new_string('yes'), rt.new_bool(false)])).str() +
		' /> <label for="_featured">' +
		(rt.call_function('esc_html__', [rt.new_string('This is a featured product'), rt.new_string('woocommerce')])).str() +
		'</label><br />')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('OK'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Post_Types) process_product_file_download_paths(var_product_id rt.PhpVal, var_variation_id rt.PhpVal, var_downloadable_files rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Admin_Post_Types::process_product_file_download_paths'),
		rt.new_string('3.3'),
		rt.new_string(''),
	])
	mut iife_temp_3 := Class_WC_Post_Data{}
	mut iife_result_3 := iife_temp_3.process_product_file_download_paths(var_product_id.clone(),
		var_variation_id.clone(), var_downloadable_files.clone())
}

fn (mut this Class_WC_Admin_Post_Types) hide_cpt_archive_templates(var_page_templates rt.PhpVal, var_theme rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_page_templates_mutated := var_page_templates
	mut var_shop_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('shop')])
	if rt.is_true(var_post)
		&& rt.is_true(rt.identical(rt.call_function('absint', [rt.get_property(var_post, 'ID')]), var_shop_page_id)) {
		var_page_templates_mutated = rt.new_array()
	}
	return var_page_templates_mutated.clone()
}

fn (mut this Class_WC_Admin_Post_Types) show_cpt_archive_notice(var_post rt.PhpVal) {
	mut var_shop_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('shop')])
	if rt.is_true(var_post)
		&& rt.is_true(rt.identical(rt.call_function('absint', [rt.get_property(var_post, 'ID')]), var_shop_page_id)) {
		print('<div class="notice notice-info">')
		print('<p>' +
			(rt.call_function('sprintf', [rt.call_function('wp_kses_post', [rt.call_function('__', [rt.new_string('This is the WooCommerce shop page. The shop page is a special archive that lists your products. <a href="%s">You can read more about this here</a>.'), rt.new_string('woocommerce')])]), rt.new_string('https://woocommerce.com/document/woocommerce-pages/#section-4')])).str() +
			'</p>')
		print('</div>')
	}
}

fn (mut this Class_WC_Admin_Post_Types) add_display_post_states(var_post_states rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_states_mutated := var_post_states
	if rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [
		rt.new_string('shop')]), rt.get_property(var_post, 'ID')))
	{
		var_post_states_mutated.array_set('wc_page_for_shop', rt.call_function('__', [
			rt.new_string('Shop Page'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [
		rt.new_string('cart')]), rt.get_property(var_post, 'ID')))
	{
		var_post_states_mutated.array_set('wc_page_for_cart', rt.call_function('__', [
			rt.new_string('Cart Page'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [
		rt.new_string('checkout'),
	]), rt.get_property(var_post, 'ID')))
	{
		var_post_states_mutated.array_set('wc_page_for_checkout', rt.call_function('__', [
			rt.new_string('Checkout Page'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [
		rt.new_string('myaccount'),
	]), rt.get_property(var_post, 'ID')))
	{
		var_post_states_mutated.array_set('wc_page_for_myaccount', rt.call_function('__', [
			rt.new_string('My Account Page'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [
		rt.new_string('terms'),
	]), rt.get_property(var_post, 'ID')))
	{
		var_post_states_mutated.array_set('wc_page_for_terms', rt.call_function('__', [
			rt.new_string('Terms and Conditions Page'),
			rt.new_string('woocommerce'),
		]))
	}
	return var_post_states_mutated.clone()
}

fn (mut this Class_WC_Admin_Post_Types) maybe_update_stock_status(var_product rt.PhpVal, var_stock_status rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_stock_status_mutated := var_stock_status
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.external(),
	]))
	{
		rt.call_method(var_product_mutated, 'set_stock_status', [
			Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock(),
		])
	} else if !var_stock_status_mutated.is_null() {
		if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'get_manage_stock', []rt.PhpVal{}))))) {
			mut iter_3 :=
				rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{}).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_child_id := item_3.val
				mut var_child := rt.call_function('wc_get_product', [
					var_child_id.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated,
					'get_manage_stock', []rt.PhpVal{})))))
				{
					rt.call_method(var_child, 'set_stock_status', [
						var_stock_status_mutated.clone()])
					rt.call_method(var_child, 'save', []rt.PhpVal{})
				}
			}
			mut iife_temp_4 := Class_WC_Product_Variable{}
			mut iife_result_4 := iife_temp_4.sync(var_product_mutated.clone(), rt.new_bool(false))
			var_product_mutated = iife_result_4
		} else {
			rt.call_method(var_product_mutated, 'set_stock_status', [
				var_stock_status_mutated.clone()])
		}
	}
	return var_product_mutated.clone()
}

fn (mut this Class_WC_Admin_Post_Types) set_new_price(var_product rt.PhpVal, var_price_type rt.PhpVal) bool {
	mut var_product_mutated := var_product
	mut var_request_data := this.request_data()
	if !rt.is_true(var_request_data.array_get(rt.new_string('change_${var_price_type.to_string()}_price')))
		|| !(var_request_data.array_isset(rt.new_string('_${var_price_type.to_string()}_price'))) {
		return false
	}
	mut var_old_price := rt.call_method(var_product_mutated,
		'get_${var_price_type.to_string()}_price', []rt.PhpVal{})
	var_old_price = rt.new_float(if rt.is_true(rt.identical(rt.new_string(''), var_old_price)) {
		rt.new_float((rt.call_method(var_product_mutated, 'get_regular_price', []rt.PhpVal{})).to_f64())
	} else {
		rt.new_float(var_old_price.to_f64())
	})
	mut var_price_changed := rt.new_bool(false)
	mut var_change_price := rt.call_function('absint', [
		var_request_data.array_get(rt.new_string('change_${var_price_type.to_string()}_price')),
	])
	mut var_raw_price := rt.call_function('wc_clean', [
		rt.call_function('wp_unslash', [
			var_request_data.array_get(rt.new_string('_${var_price_type.to_string()}_price')),
		]),
	])
	mut var_is_percentage := rt.new_bool((rt.call_function('strstr', [
		var_raw_price.clone(), rt.new_string('%')])).to_bool())
	mut var_price := rt.call_function('wc_format_decimal', [var_raw_price.clone()])
	mut switch_val_4 := var_change_price
	if rt.is_true(rt.equal(switch_val_4, rt.new_int(1))) {
		if !rt.is_true(var_price) {
			mut var_new_price := rt.call_method(var_product_mutated, 'get_regular_price',
				[]rt.PhpVal{})
		} else {
			var_new_price = var_price.clone()
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(2))) {
		if rt.is_true(var_is_percentage) {
			mut var_percent := rt.div(var_price, rt.new_int(100))
			var_new_price = rt.add(var_old_price, rt.mul(var_old_price, var_percent))
		} else if !(!rt.is_true(var_price)) {
			var_new_price = rt.add(var_old_price, var_price)
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(3))) {
		if rt.is_true(var_is_percentage) {
			var_percent = rt.div(var_price, rt.new_int(100))
			var_new_price = rt.call_function('max', [rt.new_int(0),
				rt.sub(var_old_price, rt.mul(var_old_price, var_percent))])
		} else if !(!rt.is_true(var_price)) {
			var_new_price = rt.call_function('max', [rt.new_int(0),
				rt.sub(var_old_price, var_price)])
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(4))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('sale'), var_price_type)))) {
		}
		mut var_regular_price := rt.call_method(var_product_mutated, 'get_regular_price',
			[]rt.PhpVal{})
		if rt.is_true(var_is_percentage) && var_regular_price.clone().is_long()
			|| var_regular_price.clone().is_double() {
			var_percent = rt.div(var_price, rt.new_int(100))
			mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			mut iife_result_5 := iife_temp_5.round(rt.mul(var_regular_price, var_percent), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}))
			var_new_price = rt.call_function('max', [rt.new_int(0),
				rt.sub(var_regular_price, iife_result_5)])
		} else {
			var_new_price = rt.call_function('max', [rt.new_int(0),
				rt.new_float(var_regular_price.to_f64()) - rt.new_float(var_price.to_f64())])
		}
	} else {
	}
	if !var_new_price.is_null()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_price, var_old_price)))) {
		var_price_changed = rt.new_bool(true)
		mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_6 := iife_temp_6.round(var_new_price.clone(), rt.call_function('wc_get_price_decimals',
			[]rt.PhpVal{}))
		var_new_price = iife_result_6
		rt.call_method(var_product_mutated, 'set_${var_price_type.to_string()}_price', [
			var_new_price.clone(),
		])
	}
	return var_price_changed.to_bool()
	return false
}

fn (mut this Class_WC_Admin_Post_Types) request_data() rt.PhpVal {
	return rt.get_superglobal('_REQUEST').clone()
}

fn (mut this Class_WC_Admin_Post_Types) maybe_update_cogs_value(mut var_product Class_WC_Product, mut var_request_data Class_array) {
	mut var_product_mutated := var_product
	mut var_request_data_mutated := var_request_data
	mut var_change_cogs_value := rt.call_function('absint', [
		var_request_data_mutated.array_get(rt.new_string('change_cogs_value')),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_change_cogs_value)))) {
		return
	}
	mut var_cogs_value := rt.call_function('wc_clean', [
		rt.call_function('wp_unslash', [if !(var_request_data_mutated.array_get(rt.new_string('_cogs_value'))).is_null() {
			var_request_data_mutated.array_get(rt.new_string('_cogs_value'))
		} else {
			rt.new_string('')
		}]),
	])
	rt.call_method(var_product_mutated, 'set_cogs_value', [if rt.is_true(rt.identical(rt.new_string(''), var_cogs_value)) { rt.new_null() } else { rt.new_float((rt.call_function('wc_format_decimal', [
			var_cogs_value.clone(),
		])).to_f64()) }])
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

struct Class_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Post_Data {
	rt.PhpObjectBase
}

struct Class_WC_Product_Variable {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

fn create_wc_admin_post_types() &Class_WC_Admin_Post_Types {
	mut obj := &Class_WC_Admin_Post_Types{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_admin_list_table_orders(_args ...rt.PhpVal) &Class_WC_Admin_List_Table_Orders {
	mut obj := &Class_WC_Admin_List_Table_Orders{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_list_table_coupons(_args ...rt.PhpVal) &Class_WC_Admin_List_Table_Coupons {
	mut obj := &Class_WC_Admin_List_Table_Coupons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_list_table_products(_args ...rt.PhpVal) &Class_WC_Admin_List_Table_Products {
	mut obj := &Class_WC_Admin_List_Table_Products{
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

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product(_args ...rt.PhpVal) &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_post_data(_args ...rt.PhpVal) &Class_WC_Post_Data {
	mut obj := &Class_WC_Post_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_variable(_args ...rt.PhpVal) &Class_WC_Product_Variable {
	mut obj := &Class_WC_Product_Variable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.maybe_update_cogs_value(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
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

fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Post_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Post_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Post_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Variable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Variable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Post_Types'),
		rt.new_bool(false)]))
	{
		create_wc_admin_post_types()
		return rt.new_null()
	}
	create_wc_admin_post_types()
}
