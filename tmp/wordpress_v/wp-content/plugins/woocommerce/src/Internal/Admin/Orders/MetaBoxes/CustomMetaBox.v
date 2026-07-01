import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox {
	rt.PhpObjectBase
pub mut:
		update_nonce rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) get_formatted_order_meta_data(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_metadata := rt.call_method(var_order_mutated, 'get_meta_data', []rt.PhpVal{})
	mut var_metadata_to_list := rt.new_array()
	{
		mut iter_1 := var_metadata.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			mut var_data := rt.call_method(var_meta, 'get_data', []rt.PhpVal{})
			if rt.is_true(rt.call_function('is_protected_meta', [var_data.array_get('key'), rt.new_string('order')])) {
				continue
			}
			var_metadata_to_list.array_push(rt.create_array([rt.ArrayItem{ key: 'meta_id', val: var_data.array_get('id') }, rt.ArrayItem{ key: 'meta_key', val: var_data.array_get('key') }, rt.ArrayItem{ key: 'meta_value', val: rt.call_function('maybe_serialize', [var_data.array_get('value')]) }]))
		}
	}
	return var_metadata_to_list.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) output(var_order_or_post rt.PhpVal)  {
	if rt.is_true(rt.call_function('is_a', [var_order_or_post.dup(), Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_WP_Post.class()])) {
		mut var_order := rt.call_function('wc_get_order', [var_order_or_post.dup()])
	} else {
		var_order = var_order_or_post
	}
	this.render_custom_meta_form(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](this.get_formatted_order_meta_data(mut rt.cast_object_ptr[Class_WC_Order](var_order))), mut rt.cast_object_ptr[Class_WC_Order](var_order))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) render_custom_meta_form(mut var_metadata_to_list Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array, mut var_order Class_WC_Order)  {
	mut var_metadata_to_list_mutated := var_metadata_to_list
	mut var_order_mutated := var_order
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('list_meta', [var_metadata_to_list_mutated.dup()])
	this.render_meta_form(mut var_order_mutated)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Custom fields can be used to add extra metadata to an order that you can %1$suse in your theme%2$s.'), rt.new_string('woocommerce')])]), '<a href="' + (rt.call_function('esc_attr__', [rt.new_string('https://wordpress.org/support/article/custom-fields/'), rt.new_string('woocommerce')])).str() + '">', rt.new_string('</a>')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) order_meta_keys_autofill(var_deprecated rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_order_mutated.dup(), Class_WC_Order.class()]))))) {
		return rt.new_array()
	}
	mut var_keys := rt.call_function('apply_filters', [rt.new_string('postmeta_form_keys'), rt.new_null(), var_order_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_keys)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_keys.dup().is_array()))))))) {
		mut var_limit := // unsupported expression: Expr_Cast_Int
		var_keys = rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta.class()]), 'get_meta_keys', [var_limit.dup()])
	}
	if rt.is_true(var_keys) {
		rt.call_function('natcasesort', [var_keys.dup()])
	}
	return var_keys.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) render_meta_form(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add New Custom Field:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Value'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add existing'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('New custom field name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enter new'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('add-meta'), rt.new_string('_ajax_nonce-add-meta'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Add Custom Field'), rt.new_string('woocommerce')]), rt.new_string(''), rt.new_string('addmeta'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'newmeta-submit' }, rt.ArrayItem{ key: 'data-wp-lists', val: 'add:the-list:newmeta' }])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) verify_order_edit_permission_for_ajax(order_id i64) rt.PhpVal {
	mut order_id_mutated := order_id
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_shop_orders')]))))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id_mutated).dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.call_function('wp_send_json_error', [rt.new_string('invalid_order_id')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	return var_order.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) search_metakeys_ajax()  {
	rt.call_function('check_ajax_referer', [rt.new_string('search-order-metakeys'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('order_id'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	mut var_order_id := rt.new_int(rt.new_int(rt.get_superglobal('_GET').array_get('order_id').to_i64()))
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_order.dup(), Class_WC_Order.class()]))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	mut var_found_order_meta_keys := this.order_meta_keys_autofill(rt.new_null(), var_order.dup())
	rt.call_function('wp_send_json', [var_found_order_meta_keys.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) add_meta_ajax()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('add-meta'), rt.new_string('_ajax_nonce-add-meta')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('invalid_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_order_id := if !(// unsupported expression: Expr_Cast_Int).is_null() { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_order := this.verify_order_edit_permission_for_ajax((var_order_id).to_i64())
	mut var_select_meta_key := rt.new_string(rt.new_string(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('metakeyselect')).is_null() { rt.get_superglobal('_POST').array_get('metakeyselect') } else { rt.new_string('') }])]).to_string().trim_space()))
	mut var_input_meta_key := rt.new_string(rt.new_string(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('metakeyinput')).is_null() { rt.get_superglobal('_POST').array_get('metakeyinput') } else { rt.new_string('') }])]).to_string().trim_space()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('meta')) && rt.is_true(rt.call_function('in_array', [var_select_meta_key.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: '#NONE#' }]), rt.new_bool(true)])))) && rt.is_true(rt.new_bool(!(rt.is_true(var_input_meta_key)))))) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('meta'))) {
		mut var_meta := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('meta')])
		this.handle_update_meta(mut rt.cast_object_ptr[Class_WC_Order](var_order), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](var_meta))
	} else {
		mut var_meta_value := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('metavalue')).is_null() { rt.get_superglobal('_POST').array_get('metavalue') } else { rt.new_string('') }])])
		mut var_meta_key := if rt.is_true(var_input_meta_key) { var_input_meta_key } else { var_select_meta_key }
		this.handle_add_meta(mut rt.cast_object_ptr[Class_WC_Order](var_order), (var_meta_key).str(), (var_meta_value).str())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) handle_add_meta(mut var_order Class_WC_Order, meta_key string, meta_value string)  {
	mut var_order_mutated := var_order
	mut meta_key_mutated := meta_key
	mut meta_value_mutated := meta_value
	mut var_count := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.call_function('is_protected_meta', [rt.new_string(meta_key_mutated).dup()])) {
		rt.call_function('wp_send_json_error', [rt.new_string('protected_meta')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_metas_for_current_key := rt.call_function('wp_list_filter', [rt.call_method(var_order_mutated, 'get_meta_data', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'key', val: meta_key_mutated }])])
	mut var_meta_ids := rt.call_function('wp_list_pluck', [var_metas_for_current_key.dup(), rt.new_string('id')])
	rt.call_method(var_order_mutated, 'add_meta_data', [rt.new_string(meta_key_mutated).dup(), rt.new_string(meta_value_mutated).dup()])
	rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	mut var_metas_for_current_key_with_new := rt.call_function('wp_list_filter', [rt.call_method(var_order_mutated, 'get_meta_data', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'key', val: meta_key_mutated }])])
	mut var_meta_id := rt.new_int(rt.new_int(0))
	mut var_new_meta_ids := rt.call_function('wp_list_pluck', [var_metas_for_current_key_with_new.dup(), rt.new_string('id')])
	var_new_meta_ids = rt.call_function('array_values', [rt.call_function('array_diff', [var_new_meta_ids.dup(), var_meta_ids.dup()])])
	if var_new_meta_ids.dup().array_count() > 0 {
		var_meta_id = var_new_meta_ids.array_get(0)
	}
	mut var_response := create_wp_ajax_response(rt.create_array([rt.ArrayItem{ key: 'what', val: 'meta' }, rt.ArrayItem{ key: 'id', val: var_meta_id }, rt.ArrayItem{ key: 'data', val: this.list_meta_row(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](rt.create_array([rt.ArrayItem{ key: 'meta_id', val: var_meta_id }, rt.ArrayItem{ key: 'meta_key', val: meta_key_mutated }, rt.ArrayItem{ key: 'meta_value', val: meta_value_mutated }])), (var_count).to_i64()) }, rt.ArrayItem{ key: 'position', val: 1 }]))
	var_response.send()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) handle_update_meta(mut var_order Class_WC_Order, mut var_meta Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array)  {
	mut var_order_mutated := var_order
	mut var_meta_mutated := var_meta
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_meta_mutated.dup().is_array()))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('invalid_meta')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	rt.call_function('array_walk', [var_meta_mutated.dup(), rt.new_string('sanitize_text_field')])
	mut var_mid := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mid)))) {
		rt.call_function('wp_send_json_error', [rt.new_string('invalid_meta_id')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_key := var_meta_mutated.array_get(var_mid).array_get('key')
	mut var_value := var_meta_mutated.array_get(var_mid).array_get('value')
	if rt.is_true(rt.call_function('is_protected_meta', [var_key.dup()])) {
		rt.call_function('wp_send_json_error', [rt.new_string('protected_meta')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(, )) {
		
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) list_meta_row(mut var_entry Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array, count i64) string {
	mut var_entry_mutated := var_entry
	mut count_mutated := count
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) delete_meta_ajax()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) handle_metadata_changes(var_order rt.PhpVal)  {
	mut var_meta := rt.new_null()
	mut var_order_mutated := var_order
}

struct Class_WP_Ajax_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_orders_metaboxes_custommetabox() &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox{
		PhpObjectBase: rt.PhpObjectBase{}
		update_nonce: rt.new_null()
	}
	return obj
}

fn create_wp_ajax_response() &Class_WP_Ajax_Response {
	mut obj := &Class_WP_Ajax_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_formatted_order_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_formatted_order_meta_data(mut dispatch_arg_0)
		}
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.output(dispatch_arg_0)
			return rt.new_null()
		}
		'render_custom_meta_form' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.render_custom_meta_form(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'order_meta_keys_autofill' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.order_meta_keys_autofill(dispatch_arg_0, dispatch_arg_1)
		}
		'render_meta_form' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_meta_form(mut dispatch_arg_0)
			return rt.new_null()
		}
		'verify_order_edit_permission_for_ajax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.verify_order_edit_permission_for_ajax(dispatch_arg_0)
		}
		'search_metakeys_ajax' {
			this.search_metakeys_ajax()
			return rt.new_null()
		}
		'add_meta_ajax' {
			this.add_meta_ajax()
			return rt.new_null()
		}
		'handle_add_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.handle_add_meta(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'handle_update_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_update_meta(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'list_meta_row' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.list_meta_row(mut dispatch_arg_0, dispatch_arg_1))
		}
		'delete_meta_ajax' {
			this.delete_meta_ajax()
			return rt.new_null()
		}
		'handle_metadata_changes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_metadata_changes(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'update_nonce' { return this.update_nonce }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'update_nonce' { this.update_nonce = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Ajax_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Ajax_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Ajax_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_orders_metaboxes_custommetabox_php() {
}
