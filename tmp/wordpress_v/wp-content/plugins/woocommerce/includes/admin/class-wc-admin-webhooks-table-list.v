import rt

struct Class_WC_Admin_Webhooks_Table_List {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) construct()  {
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'webhook' }, rt.ArrayItem{ key: 'plural', val: 'webhooks' }, rt.ArrayItem{ key: 'ajax', val: false }]))
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) no_items()  {
	rt.call_function('esc_html_e', [rt.new_string('No webhooks found.'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) get_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'status', val: rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'topic', val: rt.call_function('__', [rt.new_string('Topic'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'delivery_url', val: rt.call_function('__', [rt.new_string('Delivery URL'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) column_cb(var_webhook rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<input type="checkbox" name="%1$s[]" value="%2$s" />'), rt.get_property(rt.new_object('WC_Admin_Webhooks_Table_List', ['WP_List_Table'], &this), '_args').array_get('singular'), rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})])
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) column_title(var_webhook rt.PhpVal) rt.PhpVal {
	mut var_edit_link := rt.call_function('admin_url', ['admin.php?page=wc-settings&amp;tab=advanced&amp;section=webhooks&amp;edit-webhook=' + (rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})).str()])
	mut var_output := rt.new_string(rt.new_string(''))
	mut var_warning_prefix := if rt.is_true(rt.new_bool(rt.is_true(this.uses_legacy_rest_api(var_webhook.dup())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'legacy_rest_api_is_available', []rt.PhpVal{}))))))) { rt.call_function('sprintf', [rt.new_string('<span title=\'%s\'>⚠️</span>️ '), rt.call_function('esc_html__', [rt.new_string('This webhook is configured to be delivered using the Legacy REST API, but the Legacy REST API plugin is not installed on this site.'), rt.new_string('woocommerce')])]) } else { rt.new_string('') }
	// unsupported expression: Expr_AssignOp_Concat
	mut var_actions := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('ID: %d'), rt.new_string('woocommerce')]), rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'edit', val: '<a href="' + (rt.call_function('esc_url', [var_edit_link.dup()])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Edit'), rt.new_string('woocommerce')])).str() + '</a>' }, rt.ArrayItem{ key: 'delete', val: '<a class="submitdelete" aria-label="' + (rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Delete "%s" permanently'), rt.new_string('woocommerce')]), rt.call_method(var_webhook, 'get_name', []rt.PhpVal{})])])).str() + '" href="' + (rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'delete', val: rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}) }]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=webhooks')])]), rt.new_string('delete-webhook')])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')])).str() + '</a>' }])
	var_actions = rt.call_function('apply_filters', [rt.new_string('webhook_row_actions'), var_actions.dup(), var_webhook.dup()])
	mut var_row_actions := []rt.PhpVal{}
	{
		mut iter_1 := var_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_link := item_1.val
			mut var_action := item_1.key
			var_row_actions << '<span class="' + (rt.call_function('esc_attr', [var_action.dup()])).str() + '">' + (var_link).str() + '</span>'
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	return var_output.dup()
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) column_status(var_webhook rt.PhpVal) rt.PhpVal {
	return rt.call_method(var_webhook, 'get_i18n_status', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) column_topic(var_webhook rt.PhpVal) rt.PhpVal {
	return rt.call_method(var_webhook, 'get_topic', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) column_delivery_url(var_webhook rt.PhpVal) rt.PhpVal {
	return rt.call_method(var_webhook, 'get_delivery_url', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) get_status_label(var_status_name rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_statuses := rt.call_function('wc_get_webhook_statuses', []rt.PhpVal{})
	if var_statuses.array_isset(var_status_name) {
		return rt.create_array([rt.ArrayItem{ key: 'singular', val: rt.call_function('sprintf', [rt.new_string('%s <span class="count">(%s)</span>'), rt.call_function('esc_html', [var_statuses.array_get(var_status_name)]), var_amount.dup()]) }, rt.ArrayItem{ key: 'plural', val: rt.call_function('sprintf', [rt.new_string('%s <span class="count">(%s)</span>'), rt.call_function('esc_html', [var_statuses.array_get(var_status_name)]), var_amount.dup()]) }, rt.ArrayItem{ key: 'context', val: '' }, rt.ArrayItem{ key: 'domain', val: 'woocommerce' }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'singular', val: rt.call_function('sprintf', [rt.new_string('%s <span class="count">(%s)</span>'), rt.call_function('esc_html', [var_status_name.dup()]), var_amount.dup()]) }, rt.ArrayItem{ key: 'plural', val: rt.call_function('sprintf', [rt.new_string('%s <span class="count">(%s)</span>'), rt.call_function('esc_html', [var_status_name.dup()]), var_amount.dup()]) }, rt.ArrayItem{ key: 'context', val: '' }, rt.ArrayItem{ key: 'domain', val: 'woocommerce' }])
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) get_views() rt.PhpVal {
	mut var_status_links := []rt.PhpVal{}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('webhook'))
	mut var_num_webhooks := rt.call_method(var_data_store, 'get_count_webhooks_by_status', []rt.PhpVal{})
	mut var_total_webhooks := rt.call_function('array_sum', [rt.cast_array(var_num_webhooks)])
	mut var_statuses := rt.func_array_keys(rt.call_function('wc_get_webhook_statuses', []rt.PhpVal{}))
	mut var_class := rt.new_string(if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('status')) && !rt.is_true(rt.get_superglobal('_REQUEST').array_get('legacy')) { rt.new_string(' class="current"') } else { rt.new_string('') })
	var_status_links.array_set('all', "<a href='admin.php?page=wc-settings&amp;tab=advanced&amp;section=webhooks'${var_class.to_string()}>" + (rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), var_total_webhooks.dup(), rt.new_string('posts'), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [var_total_webhooks.dup()])])).str() + '</a>')
	{
		mut iter_1 := var_statuses.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status_name := item_1.val
			var_class = rt.new_string(rt.new_string(''))
			if !rt.is_true(var_num_webhooks.array_get(var_status_name)) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('status')) && rt.is_true(rt.identical(rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('status')])]), var_status_name)))) {
				var_class = rt.new_string(rt.new_string(' class="current"'))
			}
			mut var_label := this.get_status_label(var_status_name.dup(), var_num_webhooks.array_get(var_status_name))
			var_status_links.array_set(var_status_name, "<a href='admin.php?page=wc-settings&amp;tab=advanced&amp;section=webhooks&amp;status=${var_status_name.to_string()}'${var_class.to_string()}>" + (rt.call_function('sprintf', [rt.call_function('translate_nooped_plural', [var_label.dup(), var_num_webhooks.array_get(var_status_name)]), rt.call_function('number_format_i18n', [var_num_webhooks.array_get(var_status_name)])])).str() + '</a>')
		}
	}
	mut var_legacy_webhooks_count := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil.class()]), 'get_legacy_webhooks_count', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_legacy_webhooks_count, rt.new_int(0))) {
		var_class = rt.new_string(rt.new_string(''))
		if rt.is_true(rt.identical(rt.new_string('true'), rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get('legacy')).is_null() { rt.get_superglobal('_REQUEST').array_get('legacy') } else { rt.new_string('') }])]))) {
			var_class = rt.new_string(rt.new_string(' class="current"'))
		}
		mut var_label := this.get_status_label(rt.call_function('__', [rt.new_string('Legacy'), rt.new_string('woocommerce')]), var_legacy_webhooks_count.dup())
		var_status_links.array_set('legacy', "<a href='admin.php?page=wc-settings&amp;tab=advanced&amp;section=webhooks&amp;legacy=true'${var_class.to_string()}>" + (rt.call_function('sprintf', [rt.call_function('translate_nooped_plural', [var_label.dup(), var_legacy_webhooks_count.dup()]), rt.call_function('number_format_i18n', [var_legacy_webhooks_count.dup()])])).str() + '</a>')
	}
	return var_status_links.dup()
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) get_bulk_actions() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'delete', val: rt.call_function('__', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) process_bulk_action()  {
	mut var_action := this.current_action()
	mut var_webhooks := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('webhook')) { rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.get_superglobal('_REQUEST').array_get('webhook'))]) } else { []rt.PhpVal{} }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('check_admin_referer', [rt.new_string('woocommerce-settings')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
			rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('You do not have permission to edit Webhooks'), rt.new_string('woocommerce')])])
		}
		if rt.is_true(rt.identical(rt.new_string('delete'), var_action)) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Webhooks{}; return temp.bulk_delete(arg_0) }(var_webhooks.dup())
		}
	}
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) display_tablenav(var_which rt.PhpVal)  {
	print('<div class="tablenav ' + (rt.call_function('esc_attr', [var_which.dup()])).str() + '">')
	if rt.is_true(this.has_items()) {
		print('<div class="alignleft actions bulkactions">')
		this.bulk_actions(var_which.dup())
		print('</div>')
	}
	this.extra_tablenav(var_which.dup())
	this.pagination(var_which.dup())
	print('<br class="clear" />')
	print('</div>')
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal)  {
	mut var_input_id_mutated := var_input_id
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s')) && rt.is_true(rt.new_bool(!(rt.is_true(this.has_items())))))) {
		return rt.new_null()
	}
	var_input_id_mutated = rt.new_string((var_input_id_mutated).str() + '-search-input')
	mut var_search_query := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])]) } else { rt.new_string('') }
	print('<p class="search-box">')
	print('<label class="screen-reader-text" for="' + (rt.call_function('esc_attr', [var_input_id_mutated.dup()])).str() + '">' + (rt.call_function('esc_html', [var_text.dup()])).str() + ':</label>')
	print('<input type="search" id="' + (rt.call_function('esc_attr', [var_input_id_mutated.dup()])).str() + '" name="s" value="' + (rt.call_function('esc_attr', [var_search_query.dup()])).str() + '" />')
	rt.call_function('submit_button', [var_text.dup(), rt.new_string(''), rt.new_string(''), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'search-submit' }])])
	print('</p>')
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) prepare_items()  {
	mut var_per_page := this.get_items_per_page(rt.new_string('woocommerce_webhooks_per_page'))
	mut var_current_page := this.get_pagenum()
	mut var_args := { 'limit': var_per_page, 'offset': var_per_page * var_current_page - 1 }
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('status'))) {
		var_args['status'] = rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('status')])])
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s'))) {
		var_args['search'] = rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])])
		// unsupported statement: Stmt_Nop
	}
	var_args['paginate'] = rt.new_bool(true)
	if rt.is_true(rt.identical(rt.new_string('true'), rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get('legacy')).is_null() { rt.get_superglobal('_REQUEST').array_get('legacy') } else { rt.new_null() }])]))) {
		var_args['api_version'] = // unsupported expression: Expr_UnaryMinus
	}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('webhook'))
	mut var_webhooks := rt.call_method(var_data_store, 'search_webhooks', [var_args.dup()])
	this.dispatch_set_prop('items', rt.call_function('array_map', [rt.new_string('wc_get_webhook'), rt.get_property(var_webhooks, 'webhooks')]))
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: rt.get_property(var_webhooks, 'total') }, rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'total_pages', val: rt.get_property(var_webhooks, 'max_num_pages') }]))
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) get_legacy_api_webhooks_count() i64 {
	return rt.call_function('array_filter', [rt.get_property(rt.new_object('WC_Admin_Webhooks_Table_List', ['WP_List_Table'], &this), 'items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Webhooks_Table_List', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'uses_legacy_rest_api' }])]).array_count()
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) uses_legacy_rest_api(var_webhook rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.call_method(var_webhook, 'get_api_version', []rt.PhpVal{}), rt.new_string('legacy')]))
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Webhooks {
	rt.PhpObjectBase
}

fn create_wc_admin_webhooks_table_list() &Class_WC_Admin_Webhooks_Table_List {
	mut obj := &Class_WC_Admin_Webhooks_Table_List{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
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

fn create_wc_admin_webhooks() &Class_WC_Admin_Webhooks {
	mut obj := &Class_WC_Admin_Webhooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_cb(dispatch_arg_0)
		}
		'column_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_title(dispatch_arg_0)
		}
		'column_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_status(dispatch_arg_0)
		}
		'column_topic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_topic(dispatch_arg_0)
		}
		'column_delivery_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_delivery_url(dispatch_arg_0)
		}
		'get_status_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_status_label(dispatch_arg_0, dispatch_arg_1)
		}
		'get_views' {
			return this.get_views()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'process_bulk_action' {
			this.process_bulk_action()
			return rt.new_null()
		}
		'display_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'search_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.search_box(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'get_legacy_api_webhooks_count' {
			return rt.new_int(this.get_legacy_api_webhooks_count())
		}
		'uses_legacy_rest_api' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.uses_legacy_rest_api(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Webhooks_Table_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Webhooks_Table_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Admin_Webhooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Webhooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Webhooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_webhooks_table_list_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_List_Table')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
