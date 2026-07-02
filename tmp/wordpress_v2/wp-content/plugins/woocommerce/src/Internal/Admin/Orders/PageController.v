import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController {
	rt.PhpObjectBase
pub mut:
	order_type             rt.PhpVal = rt.new_string('')
	redirection_controller rt.PhpVal = rt.new_null()
	orders_table           rt.PhpVal = rt.new_null()
	order_edit_form        rt.PhpVal = rt.new_null()
	current_action         rt.PhpVal = rt.new_string('')
	order                  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) verify_edit_permission() {
	if rt.is_true(rt.identical(rt.new_string('edit_order'), this.current_action))
		&& !(!(this.order).is_null())
		|| rt.is_true(rt.new_bool(!(rt.is_true(this.order)))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You attempted to edit an order that does not exist. Perhaps it was deleted?'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(this.order, 'get_type',
		[]rt.PhpVal{}), this.order_type))))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [rt.new_string('Order type mismatch.'),
				rt.new_string('woocommerce')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [this.order_type]), 'cap'), 'edit_post'), rt.call_method(this.order, 'get_id', []rt.PhpVal{})])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You do not have permission to edit this order.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_method(this.order, 'get_status',
		[]rt.PhpVal{})))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You cannot edit this item because it is in the Trash. Please restore it and try again.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) verify_create_permission() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [this.order_type]), 'cap'), 'publish_posts')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string("You don't have permission to create a new order."),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if !(this.order).is_null() {
		this.verify_edit_permission()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) handle_edit_lock() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.order)))) {
		return
	}
	mut var_edit_lock := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.class(),
	])
	mut var_locked := rt.call_method(var_edit_lock, 'is_locked_by_another_user', [
		this.order,
	])
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('claim-lock'))))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce')) } else { rt.new_string('') }, rt.new_string('claim-lock-' + (rt.call_method(this.order, 'get_id', []rt.PhpVal{})).str())])) {
		rt.call_method(var_edit_lock, 'lock', [this.order])
		rt.call_function('wp_safe_redirect', [
			rt.new_string(this.get_edit_url((rt.call_method(this.order, 'get_id', []rt.PhpVal{})).to_i64())),
		])
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_locked)))) {
		rt.call_method(var_edit_lock, 'lock', [this.order])
	}
	closure_1_fn := fn [var_edit_lock] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(var_edit_lock, 'render_dialog', [this.order])
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) setup() {
	mut var_plugin_page := rt.new_null()
	mut var_pagenow := rt.new_null()
	this.redirection_controller = create_automattic_woocommerce_internal_admin_orders_postsredirectioncontroller(rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PageController',
		[]string{}, &this))
	if rt.is_true(rt.identical(rt.new_string('admin_menu'), rt.call_function('current_action',
		[]rt.PhpVal{})))
	{
		this.register_menu()
	} else {
		rt.call_function('add_action', [rt.new_string('admin_menu'),
			rt.new_string('register_menu'), rt.new_int(9)])
	}
	if !rt.is_true(var_plugin_page)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('admin.php'), var_pagenow))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_plugin_page.clone(), rt.new_string('wc-orders')]))))) {
		return
	}
	this.set_order_type()
	this.set_action()
	mut var_page_suffix := rt.new_string((if rt.is_true(rt.identical(rt.new_string('shop_order'),
		this.order_type))
	{
		''
	} else {
		'--' + (this.order_type).str()
	}).str())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus{}
	mut iife_result_1 := iife_temp_1.can_view_woocommerce_menu_item()
	mut var_page_name := rt.new_string((
		if rt.is_true(iife_result_1) { 'woocommerce_page_wc-orders' } else { 'admin_page_wc-orders' } +
		var_page_suffix.str()).str())
	rt.call_function('add_action', [rt.new_string('load-${var_page_name.to_string()}'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PageController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_load_page_action' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_title'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PageController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_page_title' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) handle_load_page_action() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.set_property(var_screen, 'post_type', this.order_type)
	if rt.is_true(rt.call_function('method_exists', [
		rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PageController', []string{},
			&this),
		rt.new_string('setup_action_' + (this.current_action).str()),
	]))
	{
		rt.call_method(rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PageController',
			[]string{}, &this), rt.concat(rt.new_string('setup_action_'), this.current_action),
			[]rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) set_page_title(var_admin_title rt.PhpVal) rt.PhpVal {
	mut var_admin_title_mutated := var_admin_title
	if !(this.is_order_screen((this.order_type).str(), '')) {
		return var_admin_title_mutated.clone()
	}
	mut var_wp_order_type := rt.call_function('get_post_type_object', [this.order_type])
	mut var_labels := rt.call_function('get_post_type_labels', [
		var_wp_order_type.clone()])
	if this.is_order_screen((this.order_type).str(), 'list') {
		var_admin_title_mutated = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('%1$s &lsaquo; %2$s &#8212; WordPress'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.get_property(var_labels, 'name'),
			]),
			rt.call_function('esc_html', [
				rt.call_function('get_bloginfo', [rt.new_string('name')]),
			]),
		])
	} else if this.is_order_screen((this.order_type).str(), 'edit') {
		var_admin_title_mutated = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('%1$s #%2$s &lsaquo; %3$s &#8212; WordPress'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.get_property(var_labels, 'edit_item'),
			]),
			rt.call_function('absint', [
				rt.call_method(this.order, 'get_id', []rt.PhpVal{}),
			]),
			rt.call_function('esc_html', [
				rt.call_function('get_bloginfo', [rt.new_string('name')]),
			]),
		])
	} else if this.is_order_screen((this.order_type).str(), 'new') {
		var_admin_title_mutated = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('%1$s &lsaquo; %2$s &#8212; WordPress'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.get_property(var_labels, 'add_new_item'),
			]),
			rt.call_function('esc_html', [
				rt.call_function('get_bloginfo', [rt.new_string('name')]),
			]),
		])
	}
	return var_admin_title_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) set_order_type() {
	mut var_plugin_page := rt.new_null()
	this.order_type = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-orders--' },
			rt.ArrayItem{ key: none, val: 'wc-orders' }]),
		rt.new_string(''),
		var_plugin_page.clone(),
	])
	this.order_type = if !rt.is_true(this.order_type) {
		rt.new_string('shop_order')
	} else {
		this.order_type
	}
	mut var_wc_order_type := rt.call_function('wc_get_order_type', [this.order_type])
	mut var_wp_order_type := rt.call_function('get_post_type_object', [this.order_type])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_order_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_wp_order_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_wp_order_type, 'show_ui')))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_wp_order_type, 'cap'), 'edit_posts')]))))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) set_action() {
	mut switch_val_1 := if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('action'))]),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		this.current_action = rt.new_string('edit_order')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('new'))) {
		this.current_action = rt.new_string('new_order')
	} else {
		this.current_action = rt.new_string('list_orders')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) register_menu() {
	mut var_order_types := rt.call_function('wc_get_order_types', [
		rt.new_string('admin-menu'),
	])
	mut iter_1 := var_order_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_order_type := item_1.val
		mut var_post_type := rt.call_function('get_post_type_object', [
			var_order_type.clone()])
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus{}
		mut iife_result_2 := iife_temp_2.can_view_woocommerce_menu_item()
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus{}
		mut iife_result_3 := iife_temp_3.can_view_woocommerce_menu_item()
		rt.call_function('add_submenu_page', [
			rt.new_string((if rt.is_true(iife_result_2) { 'woocommerce' } else { 'admin.php' }).str()),
			rt.get_property(rt.get_property(var_post_type, 'labels'), 'name'),
			rt.get_property(rt.get_property(var_post_type, 'labels'), 'menu_name'),
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
			rt.new_string('wc-orders' +
				if rt.is_true(rt.identical(rt.new_string('shop_order'), var_order_type)) { '' } else { '--' +
				var_order_type.str() }),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PageController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'output' },
			]),
		])
	}
	closure_5_fn := fn [var_order_types] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iter_2 := var_order_types.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_order_type := item_2.val
			rt.call_function('remove_submenu_page', [rt.new_string('woocommerce'),
				rt.new_string('edit.php?post_type=' + var_order_type.str())])
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_closure(closure_5_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) output() {
	mut switch_val_2 := this.current_action
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('edit_order')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('new_order'))) {
		rt.call_method(this.order_edit_form, 'display', []rt.PhpVal{})
	} else {
		rt.call_method(this.orders_table, 'prepare_items', []rt.PhpVal{})
		rt.call_method(this.orders_table, 'display', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) setup_action_list_orders() {
	this.orders_table = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Orders_ListTable.class(),
	])
	rt.call_method(this.orders_table, 'setup', [
		rt.create_array([rt.ArrayItem{ key: 'order_type', val: this.order_type }]),
	])
	if rt.is_true(rt.call_method(this.orders_table, 'current_action', []rt.PhpVal{})) {
		rt.call_method(this.orders_table, 'handle_bulk_actions', []rt.PhpVal{})
	}
	this.strip_http_referer()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) strip_http_referer() {
	mut var_current_url := rt.call_function('esc_url_raw', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).is_null() {
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
		} else {
			rt.new_string('')
		}]),
	])
	mut var_stripped_url := rt.call_function('remove_query_arg', [
		rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' },
			rt.ArrayItem{ key: none, val: '_wpnonce' }]),
		var_current_url.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_stripped_url, var_current_url)))) {
		rt.call_function('wp_safe_redirect', [var_stripped_url.clone()])
		exit(0)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) prepare_order_edit_form() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.order))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.current_action, rt.create_array([rt.ArrayItem{
		key: none
		val: 'new_order'
	}, rt.ArrayItem{ key: none, val: 'edit_order' }]), rt.new_bool(true)]))))) {
		return
	}
	this.order_edit_form = if !(this.order_edit_form).is_null() {
		this.order_edit_form
	} else {
		create_automattic_woocommerce_internal_admin_orders_edit()
	}
	rt.call_method(this.order_edit_form, 'setup', [this.order])
	rt.call_method(this.order_edit_form, 'set_current_action', [this.current_action])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) setup_action_edit_order() {
	mut var_theorder := rt.get_superglobal('theorder')
	this.order = rt.call_function('wc_get_order', [
		rt.call_function('absint', [if rt.get_superglobal('_GET').array_isset(rt.new_string('id')) {
			rt.get_superglobal('_GET').array_get(rt.new_string('id'))
		} else {
			rt.new_int(0)
		}]),
	])
	this.verify_edit_permission()
	this.handle_edit_lock()
	var_theorder = this.order
	this.prepare_order_edit_form()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) setup_action_new_order() {
	mut var_theorder := rt.get_superglobal('theorder')
	this.verify_create_permission()
	mut var_order_class_name :=
		rt.call_function('wc_get_order_type', [this.order_type]).array_get(rt.new_string('class_name'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_class_name))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_order_class_name.clone()]))))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	this.order = rt.create_object_dynamically(var_order_class_name, []rt.PhpVal{})
	rt.call_method(this.order, 'set_object_read', [rt.new_bool(false)])
	rt.call_method(this.order, 'set_status', [rt.new_string('auto-draft')])
	rt.call_method(this.order, 'set_created_via', [rt.new_string('admin')])
	rt.call_method(this.order, 'save', []rt.PhpVal{})
	this.handle_edit_lock()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [
		rt.new_string('wp_scheduled_auto_draft_delete'),
	])))))
	{
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('daily'), rt.new_string('wp_scheduled_auto_draft_delete')])
	}
	var_theorder = this.order
	this.prepare_order_edit_form()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) get_order_type() rt.PhpVal {
	return this.order_type
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) get_orders_url() string {
	return (if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))
	{
		rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-orders')])
	} else {
		rt.call_function('admin_url', [rt.new_string('edit.php?post_type=shop_order')])
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) get_edit_url(order_id i64) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})))))
	{
		return
			(rt.call_function('admin_url', [rt.new_string('post.php?post=' + (rt.call_function('absint', [rt.new_int(order_id)])).str())])).str() +
			'&action=edit'
	}
	mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_order)) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'debug', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Attempted to determine the edit URL for order %d, however the order does not exist.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_int(order_id),
			]),
		])
		mut var_order_type := rt.new_string('shop_order')
	} else {
		var_order_type = rt.call_method(var_order, 'get_type', []rt.PhpVal{})
	}
	mut var_base_url := rt.new_string(this.get_base_page_url(var_order_type.clone()))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Orders_Exception') {
		mut var_e := var_e_1.clone()
		return ''
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return (rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'action', val: 'edit' },
			rt.ArrayItem{ key: 'id', val: rt.call_function('absint', [
				rt.new_int(order_id),
			]) }]),
		var_base_url.clone(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) get_new_page_url(order_type string) string {
	mut order_type_mutated := order_type
	mut var_url := if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))
	{ rt.call_function('add_query_arg', [rt.new_string('action'),
			rt.new_string('new'),
			rt.new_string(this.get_base_page_url(rt.new_string(order_type_mutated)))]) } else { rt.call_function('admin_url', [
			rt.new_string('post-new.php?post_type=' + order_type_mutated),
		]) }
	return var_url.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) get_base_page_url(var_order_type rt.PhpVal) string {
	mut var_order_type_mutated := var_order_type
	mut var_order_types_with_ui := rt.call_function('wc_get_order_types', [
		rt.new_string('admin-menu'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_order_type_mutated.clone(), var_order_types_with_ui.clone(),
		rt.new_bool(true)])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_Exception',
			[]string{}, create_automattic_woocommerce_internal_admin_orders_exception(rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Invalid order type: %s.'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [var_order_type_mutated.clone()]),
		]))))
	}
	return (rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-orders' +
			if rt.is_true(rt.identical(rt.new_string('shop_order'), var_order_type_mutated)) { '' } else { '--' +
			var_order_type_mutated.str() }),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) is_order_screen(type string, action string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('current_screen'),
	])))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('%s must be called after the current_screen action.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(@METHOD),
				]),
			]),
			rt.new_string('7.9.0')])
		return false
	}
	mut var_valid_types := rt.call_function('wc_get_order_types', [
		rt.new_string('view-order'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(type),
		var_valid_types.clone(),
		rt.new_bool(true),
	])))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('%s is not a valid order type.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(type),
				]),
			]),
			rt.new_string('7.9.0')])
		return false
	}
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))
	{
		if var_action.len > 0 && var_action != '0' {
			mut switch_val_3 := rt.new_string(action)
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('edit'))) {
				mut var_is_action := rt.identical(rt.new_string('edit_order'), this.current_action)
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('list'))) {
				var_is_action = rt.identical(rt.new_string('list_orders'), this.current_action)
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('new'))) {
				var_is_action = rt.identical(rt.new_string('new_order'), this.current_action)
			} else {
				var_is_action = rt.new_bool(false)
			}
		}
		mut var_type_match := rt.identical(rt.new_string(type), this.order_type)
		mut var_action_match := rt.new_bool(!(var_action.len > 0 && var_action != '0')
			|| rt.is_true(var_is_action))
	} else {
		mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
		if var_action.len > 0 && var_action != '0' {
			mut switch_val_4 := rt.new_string(action)
			if rt.is_true(rt.equal(switch_val_4, rt.new_string('edit'))) {
				mut var_screen_match := rt.new_bool(
					rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'base')))
					&& rt.is_true(rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), rt.new_string('post'), rt.get_constant('FILTER_VALIDATE_INT')])))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('list'))) {
				var_screen_match = rt.identical(rt.new_string('edit'), rt.get_property(var_screen,
					'base'))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('new'))) {
				var_screen_match = rt.new_bool(
					rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'base')))
					&& rt.is_true(rt.identical(rt.new_string('add'), rt.get_property(var_screen, 'action'))))
			} else {
				var_screen_match = rt.new_bool(false)
			}
		}
		var_type_match = rt.identical(rt.new_string(type), rt.get_property(var_screen, 'post_type'))
		var_action_match = rt.new_bool(!(var_action.len > 0 && var_action != '0')
			|| rt.is_true(var_screen_match))
	}
	return rt.is_true(var_type_match) && rt.is_true(var_action_match)
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_orders_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController{
		PhpObjectBase:          rt.PhpObjectBase{}
		order_type:             rt.new_string('')
		redirection_controller: rt.new_null()
		orders_table:           rt.new_null()
		order_edit_form:        rt.new_null()
		current_action:         rt.new_string('')
		order:                  rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_postsredirectioncontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_wc_admin_menus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_edit(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'verify_edit_permission' {
			this.verify_edit_permission()
			return rt.new_null()
		}
		'verify_create_permission' {
			this.verify_create_permission()
			return rt.new_null()
		}
		'handle_edit_lock' {
			this.handle_edit_lock()
			return rt.new_null()
		}
		'setup' {
			this.setup()
			return rt.new_null()
		}
		'handle_load_page_action' {
			this.handle_load_page_action()
			return rt.new_null()
		}
		'set_page_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_page_title(dispatch_arg_0)
		}
		'set_order_type' {
			this.set_order_type()
			return rt.new_null()
		}
		'set_action' {
			this.set_action()
			return rt.new_null()
		}
		'register_menu' {
			this.register_menu()
			return rt.new_null()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		'setup_action_list_orders' {
			this.setup_action_list_orders()
			return rt.new_null()
		}
		'strip_http_referer' {
			this.strip_http_referer()
			return rt.new_null()
		}
		'prepare_order_edit_form' {
			this.prepare_order_edit_form()
			return rt.new_null()
		}
		'setup_action_edit_order' {
			this.setup_action_edit_order()
			return rt.new_null()
		}
		'setup_action_new_order' {
			this.setup_action_new_order()
			return rt.new_null()
		}
		'get_order_type' {
			return this.get_order_type()
		}
		'get_orders_url' {
			return rt.new_string(this.get_orders_url())
		}
		'get_edit_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_edit_url(dispatch_arg_0))
		}
		'get_new_page_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_new_page_url(dispatch_arg_0))
		}
		'get_base_page_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_base_page_url(dispatch_arg_0))
		}
		'is_order_screen' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_order_screen(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_type' { return this.order_type }
		'redirection_controller' { return this.redirection_controller }
		'orders_table' { return this.orders_table }
		'order_edit_form' { return this.order_edit_form }
		'current_action' { return this.current_action }
		'order' { return this.order }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_type' {
			this.order_type = val
			return true
		}
		'redirection_controller' {
			this.redirection_controller = val
			return true
		}
		'orders_table' {
			this.orders_table = val
			return true
		}
		'order_edit_form' {
			this.order_edit_form = val
			return true
		}
		'current_action' {
			this.current_action = val
			return true
		}
		'order' {
			this.order = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Orders_PageController', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_orders_pagecontroller()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PageController',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_orders_postsredirectioncontroller()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_orders_wc_admin_menus()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Orders_Edit', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_orders_edit()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_Edit', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Orders_Exception', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_orders_exception()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_Exception', []string{},
			obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
