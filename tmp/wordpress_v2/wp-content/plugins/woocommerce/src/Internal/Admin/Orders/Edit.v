import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit {
	rt.PhpObjectBase
pub mut:
	screen_id              rt.PhpVal = rt.new_null()
	custom_meta_box        rt.PhpVal = rt.new_null()
	taxonomies_meta_box    rt.PhpVal = rt.new_null()
	order                  rt.PhpVal = rt.new_null()
	current_action         rt.PhpVal = rt.new_null()
	message                i64
	orders_page_controller rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit.add_order_meta_boxes(screen_id string, title string) {
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-order-data'),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s data'),
				rt.new_string('woocommerce')]),
			rt.new_string(title),
		]),
		rt.new_string('WC_Meta_Box_Order_Data::output'), rt.new_string(screen_id),
		rt.new_string('normal'), rt.new_string('high')])
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-order-items'),
		rt.call_function('__', [rt.new_string('Items'), rt.new_string('woocommerce')]),
		rt.new_string('WC_Meta_Box_Order_Items::output'), rt.new_string(screen_id),
		rt.new_string('normal'), rt.new_string('high')])
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-order-notes'),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s notes'),
				rt.new_string('woocommerce')]),
			rt.new_string(title),
		]),
		rt.new_string('WC_Meta_Box_Order_Notes::output'), rt.new_string(screen_id),
		rt.new_string('side'), rt.new_string('default')])
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-order-downloads'),
		rt.new_string(
			(rt.call_function('__', [rt.new_string('Downloadable product permissions'), rt.new_string('woocommerce')])).str() +(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Note: Permissions for order items will automatically be granted when the order status changes to processing/completed.'), rt.new_string('woocommerce')])])).str()),
		rt.new_string('WC_Meta_Box_Order_Downloads::output'),
		rt.new_string(screen_id), rt.new_string('normal'), rt.new_string('default')])
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-order-actions'),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s actions'),
				rt.new_string('woocommerce')]),
			rt.new_string(title),
		]),
		rt.new_string('WC_Meta_Box_Order_Actions::output'), rt.new_string(screen_id),
		rt.new_string('side'), rt.new_string('high')])
	Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit.maybe_register_order_attribution(screen_id,
		title)
}

fn Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit.add_save_meta_boxes() {
	rt.call_function('add_action', [rt.new_string('woocommerce_process_shop_order_meta'),
		rt.new_string('WC_Meta_Box_Order_Items::save'), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_process_shop_order_meta'),
		rt.new_string('WC_Meta_Box_Order_Downloads::save'), rt.new_int(30),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_process_shop_order_meta'),
		rt.new_string('WC_Meta_Box_Order_Data::save'), rt.new_int(40)])
	rt.call_function('add_action', [rt.new_string('woocommerce_process_shop_order_meta'),
		rt.new_string('WC_Meta_Box_Order_Actions::save'), rt.new_int(50),
		rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) enqueue_scripts() {
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('post')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) get_page_controller() rt.PhpVal {
	if !(!(this.orders_page_controller).is_null()) {
		this.orders_page_controller = rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class(),
		])
	}
	return this.orders_page_controller
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) setup(mut var_order Class_WC_Order) {
	this.order = var_order
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'is_block_editor', [rt.new_bool(false)])
	this.screen_id = rt.get_property(var_current_screen, 'id')
	if !(!(this.custom_meta_box).is_null()) {
		this.custom_meta_box = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox.class(),
		])
	}
	if !(!(this.taxonomies_meta_box).is_null()) {
		this.taxonomies_meta_box = rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox.class(),
		])
	}
	this.add_save_meta_boxes()
	this.handle_order_update()
	this.add_order_meta_boxes((this.screen_id).str(), (rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	])).str())
	this.add_order_specific_meta_box()
	this.add_order_taxonomies_meta_box()
	rt.call_function('do_action', [rt.new_string('add_meta_boxes'), this.screen_id, this.order])
	rt.call_function('do_action', [
		rt.new_string('add_meta_boxes_' + (this.screen_id).str()),
		this.order,
	])
	this.enqueue_scripts()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) set_current_action(action string) {
	this.current_action = rt.new_string(action)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) add_order_specific_meta_box() {
	rt.call_function('add_meta_box', [rt.new_string('order_custom'),
		rt.call_function('__', [rt.new_string('Custom Fields'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_Edit',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_custom_meta_box' }]),
		this.screen_id, rt.new_string('normal')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) add_order_taxonomies_meta_box() {
	rt.call_method(this.taxonomies_meta_box, 'add_taxonomies_meta_boxes', [this.screen_id,
		rt.call_method(this.order, 'get_type', []rt.PhpVal{})])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit.maybe_register_order_attribution(screen_id string, title string) {
	mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_feature_controller,
		'feature_is_enabled', [rt.new_string('order_attribution')])))))
	{
		return
	}
	mut var_order_attribution_meta_box := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution.class(),
	])
	closure_1_fn := fn [var_order_attribution_meta_box] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_post_or_order := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_order := if rt.is_true(rt.new_bool(rt.instance_of(var_post_or_order, 'WC_Order'))) { var_post_or_order } else { rt.call_function('wc_get_order', [
				var_post_or_order.clone(),
			]) }
		if true {
			rt.call_method(var_order_attribution_meta_box, 'output', [var_order])
		}
		return rt.new_null()
	}
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-order-source-data'),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s attribution'),
				rt.new_string('woocommerce')]),
			rt.new_string(title),
		]),
		rt.new_closure(closure_1_fn), rt.new_string(screen_id),
		rt.new_string('side'), rt.new_string('high')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_analytics_enabled'),
	])))))
	{
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.is_order_edit_screen()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return
	}
	mut var_customer_history_meta_box := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomerHistory.class(),
	])
	closure_3_fn := fn [var_customer_history_meta_box] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_post_or_order := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_order := if rt.is_true(rt.new_bool(rt.instance_of(var_post_or_order, 'WC_Order'))) { var_post_or_order } else { rt.call_function('wc_get_order', [
				var_post_or_order.clone(),
			]) }
		if true {
			rt.call_method(var_customer_history_meta_box, 'output', [var_order])
		}
		return rt.new_null()
	}
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-customer-history'),
		rt.call_function('__', [rt.new_string('Customer history'),
			rt.new_string('woocommerce')]),
		rt.new_closure(closure_3_fn), rt.new_string(screen_id),
		rt.new_string('side'), rt.new_string('high')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) handle_order_update() {
	if !(!(this.order).is_null()) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit_order'), rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('action'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('action'))
		} else {
			rt.new_string('')
		}]),
	])))))
	{
		return
	}
	rt.call_function('check_admin_referer', [
		rt.new_string(this.get_order_edit_nonce_action()),
	])
	mut var_taxonomy_input := if rt.get_superglobal('_POST').array_isset(rt.new_string('tax_input')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('tax_input')),
		]) } else { rt.new_null() }
	rt.call_method(this.taxonomies_meta_box, 'save_taxonomies',
		[this.order, var_taxonomy_input.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_process_shop_order_meta'),
		rt.call_method(this.order, 'get_id', []rt.PhpVal{}), this.order])
	rt.call_method(this.custom_meta_box, 'handle_metadata_changes', [this.order])
	this.message = 1
	mut var_edit_lock := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.class(),
	])
	rt.call_method(var_edit_lock, 'lock', [this.order])
	this.redirect_order(mut rt.cast_object_ptr[Class_WC_Order](this.order))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) redirect_order(mut var_order Class_WC_Order) {
	mut var_redirect_to := rt.call_method(this.get_page_controller(), 'get_edit_url', [
		var_order.get_id(),
	])
	if !(this.message).is_null() {
		var_redirect_to = rt.call_function('add_query_arg', [
			rt.new_string('message'), rt.new_int(this.message),
			var_redirect_to.clone()])
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_redirect_order_location'),
			var_redirect_to.clone(),
			var_order.get_id(),
			var_order,
		]),
	])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) get_order_edit_nonce_action() string {
	return 'update-order_' + (rt.call_method(this.order, 'get_id', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) render_custom_meta_box() {
	rt.call_method(this.custom_meta_box, 'output', [this.order])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) display() {
	mut var_messages := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_updated_messages'),
		rt.new_array(),
	])
	mut var_message := rt.new_int(this.message)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('message')) {
		var_message = rt.call_function('absint',
			[rt.get_superglobal('_GET').array_get(rt.new_string('message'))])
	}
	if !var_message.is_null() {
		var_message = if !(var_messages.array_get(rt.call_method(this.order, 'get_type',
			[]rt.PhpVal{})).array_get(var_message)).is_null() {
			var_messages.array_get(rt.call_method(this.order, 'get_type', []rt.PhpVal{})).array_get(var_message)
		} else {
			rt.new_bool(false)
		}
	}
	this.render_wrapper_start('', var_message.str())
	this.render_meta_boxes()
	this.render_wrapper_end()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) render_wrapper_start(notice string, message string) {
	mut message_mutated := message
	mut var_post_type := rt.call_function('get_post_type_object', [
		rt.call_method(this.order, 'get_type', []rt.PhpVal{}),
	])
	mut var_edit_page_url := rt.call_method(this.get_page_controller(), 'get_edit_url', [
		rt.call_method(this.order, 'get_id', []rt.PhpVal{}),
	])
	mut var_form_action := rt.new_string('edit_order')
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	mut var_new_page_url := rt.call_method(this.get_page_controller(), 'get_new_page_url', [
		rt.call_method(this.order, 'get_type', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.identical(rt.new_string('new_order'), this.current_action)) { rt.call_function('esc_html', [
			rt.get_property(rt.get_property(var_post_type, 'labels'), 'add_new_item'),
		]) } else { rt.call_function('esc_html', [
			rt.get_property(rt.get_property(var_post_type, 'labels'), 'edit_item'),
		]) })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('edit_order'), this.current_action)) {
		print(' <a href="' + (rt.call_function('esc_url', [var_new_page_url.clone()])).str() +
			'" class="page-title-action">' +
			(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type, 'labels'), 'add_new')])).str() +
			'</a>')
	}
	// unsupported statement: Stmt_InlineHTML
	if var_notice.len > 0 && var_notice != '0' {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.new_string(notice)]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_string(message_mutated)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.new_string(message_mutated).clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_edit_page_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('order_edit_form_tag'), this.order])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [
		rt.new_string(this.get_order_edit_nonce_action()),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('order_edit_form_top'), this.order])
	rt.call_function('wp_nonce_field', [rt.new_string('meta-box-order'),
		rt.new_string('meta-box-order-nonce'), rt.new_bool(false)])
	rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'),
		rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_form_action.clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_order_status := rt.call_method(this.order, 'get_status', [
		rt.new_string('edit'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_order_status.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_is_order_status', [
		rt.new_string('wc-' + var_order_status.str()),
	]))
	{ 'wc-' + var_order_status.str() } else { var_order_status }]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(var_referer) { rt.call_function('esc_url', [
			var_referer.clone()]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(this.order, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_int(1), rt.call_method(rt.call_function('get_current_screen',
		[]rt.PhpVal{}), 'get_columns', []rt.PhpVal{})))
	{
		'1'
	} else {
		'2'
	})
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) render_meta_boxes() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [this.screen_id, rt.new_string('side'), this.order])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [this.screen_id, rt.new_string('normal'), this.order])
	rt.call_function('do_meta_boxes', [this.screen_id, rt.new_string('advanced'), this.order])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) render_wrapper_end() {
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_orders_edit(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit{
		PhpObjectBase:          rt.PhpObjectBase{}
		screen_id:              rt.new_null()
		custom_meta_box:        rt.new_null()
		taxonomies_meta_box:    rt.new_null()
		order:                  rt.new_null()
		current_action:         rt.new_null()
		message:                i64(0)
		orders_page_controller: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_order_meta_boxes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit.add_order_meta_boxes(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'add_save_meta_boxes' {
			Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit.add_save_meta_boxes()
			return rt.new_null()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'get_page_controller' {
			return this.get_page_controller()
		}
		'setup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setup(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_current_action' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_current_action(dispatch_arg_0)
			return rt.new_null()
		}
		'add_order_specific_meta_box' {
			this.add_order_specific_meta_box()
			return rt.new_null()
		}
		'add_order_taxonomies_meta_box' {
			this.add_order_taxonomies_meta_box()
			return rt.new_null()
		}
		'maybe_register_order_attribution' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit.maybe_register_order_attribution(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'handle_order_update' {
			this.handle_order_update()
			return rt.new_null()
		}
		'redirect_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.redirect_order(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_edit_nonce_action' {
			return rt.new_string(this.get_order_edit_nonce_action())
		}
		'render_custom_meta_box' {
			this.render_custom_meta_box()
			return rt.new_null()
		}
		'display' {
			this.display()
			return rt.new_null()
		}
		'render_wrapper_start' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.render_wrapper_start(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'render_meta_boxes' {
			this.render_meta_boxes()
			return rt.new_null()
		}
		'render_wrapper_end' {
			this.render_wrapper_end()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'screen_id' { return this.screen_id }
		'custom_meta_box' { return this.custom_meta_box }
		'taxonomies_meta_box' { return this.taxonomies_meta_box }
		'order' { return this.order }
		'current_action' { return this.current_action }
		'message' { return rt.new_int(this.message) }
		'orders_page_controller' { return this.orders_page_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'screen_id' {
			this.screen_id = val
			return true
		}
		'custom_meta_box' {
			this.custom_meta_box = val
			return true
		}
		'taxonomies_meta_box' {
			this.taxonomies_meta_box = val
			return true
		}
		'order' {
			this.order = val
			return true
		}
		'current_action' {
			this.current_action = val
			return true
		}
		'message' {
			this.message = val.to_i64()
			return true
		}
		'orders_page_controller' {
			this.orders_page_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
