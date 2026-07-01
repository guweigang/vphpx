import rt

struct Class_WC_Admin_API_Keys_Table_List {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) construct()  {
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'key' }, rt.ArrayItem{ key: 'plural', val: 'keys' }, rt.ArrayItem{ key: 'ajax', val: false }]))
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) no_items()  {
	rt.call_function('esc_html_e', [rt.new_string('No keys found.'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) get_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'truncated_key', val: rt.call_function('__', [rt.new_string('Consumer key ending in'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'user', val: rt.call_function('__', [rt.new_string('User'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'permissions', val: rt.call_function('__', [rt.new_string('Permissions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'last_access', val: rt.call_function('__', [rt.new_string('Last access'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) column_cb(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<input type="checkbox" name="key[]" value="%1$s" />'), var_key.array_get('key_id')])
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) column_title(var_key rt.PhpVal) rt.PhpVal {
	mut var_url := rt.call_function('admin_url', ['admin.php?page=wc-settings&tab=advanced&section=keys&edit-key=' + (var_key.array_get('key_id')).str()])
	mut var_user_id := rt.new_int(rt.new_int(var_key.array_get('user_id').to_i64()))
	mut var_can_edit := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.dup()])) || rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_user_id))))
	mut var_output := rt.new_string(rt.new_string('<strong>'))
	if rt.is_true(var_can_edit) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !rt.is_true(var_key.array_get('description')) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(var_can_edit) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	mut var_actions := { 'id': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('ID: %d'), rt.new_string('woocommerce')]), var_key.array_get('key_id')]) }
	if rt.is_true(var_can_edit) {
		var_actions['edit'] = '<a href="' + (rt.call_function('esc_url', [var_url.dup()])).str() + '">' + (rt.call_function('__', [rt.new_string('View/Edit'), rt.new_string('woocommerce')])).str() + '</a>'
		var_actions['trash'] = '<a class="submitdelete" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Revoke API key'), rt.new_string('woocommerce')])).str() + '" href="' + (rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'revoke-key', val: var_key.array_get('key_id') }]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=keys')])]), rt.new_string('revoke')])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Revoke'), rt.new_string('woocommerce')])).str() + '</a>'
	}
	mut var_row_actions := []rt.PhpVal{}
	for var_action, var_link in var_actions {
		var_row_actions << '<span class="' + (rt.call_function('esc_attr', [rt.new_string(action)])).str() + '">' + (var_link).str() + '</span>'
	}
	// unsupported expression: Expr_AssignOp_Concat
	return var_output.dup()
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) column_truncated_key(var_key rt.PhpVal) string {
	return '<code>***' + (rt.call_function('esc_html', [var_key.array_get('truncated_key')])).str() + '</code>'
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) column_user(var_key rt.PhpVal) string {
	mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), var_key.array_get('user_id')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return ''
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')])) {
		return '<a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_user, 'ID') }]), rt.call_function('admin_url', [rt.new_string('user-edit.php')])])])).str() + '">' + (rt.call_function('esc_html', [rt.get_property(var_user, 'display_name')])).str() + '</a>'
	}
	return (rt.call_function('esc_html', [rt.get_property(var_user, 'display_name')])).str()
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) column_permissions(var_key rt.PhpVal) string {
	mut var_permission_key := var_key.array_get('permissions')
	mut var_permissions := rt.create_array([rt.ArrayItem{ key: 'read', val: rt.call_function('__', [rt.new_string('Read'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'write', val: rt.call_function('__', [rt.new_string('Write'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'read_write', val: rt.call_function('__', [rt.new_string('Read/Write'), rt.new_string('woocommerce')]) }])
	if var_permissions.array_isset(var_permission_key) {
		return (rt.call_function('esc_html', [var_permissions.array_get(var_permission_key)])).str()
	} else {
		return ''
	}
	return ''
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) column_last_access(var_key rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_key.array_get('last_access'))) {
		mut var_date := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s at %2$s'), rt.new_string('woocommerce')]), rt.call_function('date_i18n', [rt.call_function('wc_date_format', []rt.PhpVal{}), rt.call_function('strtotime', [var_key.array_get('last_access')])]), rt.call_function('date_i18n', [rt.call_function('wc_time_format', []rt.PhpVal{}), rt.call_function('strtotime', [var_key.array_get('last_access')])])])
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_api_key_last_access_datetime'), var_date.dup(), var_key.array_get('last_access')])
	}
	return rt.call_function('__', [rt.new_string('Unknown'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) get_bulk_actions() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('remove_users')]))))) {
		return []rt.PhpVal{}
	}
	return rt.create_array([rt.ArrayItem{ key: 'revoke', val: rt.call_function('__', [rt.new_string('Revoke'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal)  {
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

fn (mut this Class_WC_Admin_API_Keys_Table_List) prepare_items()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_per_page := this.get_items_per_page(rt.new_string('woocommerce_keys_per_page'))
	mut var_current_page := this.get_pagenum()
	if rt.is_true(rt.less(rt.new_int(1), var_current_page)) {
		mut var_offset := rt.mul(var_per_page, rt.sub(var_current_page, rt.new_int(1)))
	} else {
		var_offset = rt.new_int(rt.new_int(0))
	}
	mut var_search := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s'))) {
		var_search = rt.new_string('AND description LIKE \'%' + (rt.call_function('esc_sql', [rt.call_method(var_wpdb, 'esc_like', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])])])])).str() + '%\' ')
		// unsupported statement: Stmt_Nop
	}
	mut var_keys := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.new_string('SELECT key_id, user_id, description, permissions, truncated_key, last_access FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_api_keys WHERE 1 = 1 ')), var_search) + (rt.call_method(var_wpdb, 'prepare', [rt.new_string('ORDER BY key_id DESC LIMIT %d OFFSET %d;'), var_per_page.dup(), var_offset.dup()])).str(), rt.get_constant('ARRAY_A')])
	mut var_count := rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(key_id) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_api_keys WHERE 1 = 1 ')), var_search), rt.new_string(';'))])
	this.dispatch_set_prop('items', var_keys.dup())
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_count }, rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [rt.div(var_count, var_per_page)]) }]))
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wc_admin_api_keys_table_list() &Class_WC_Admin_API_Keys_Table_List {
	mut obj := &Class_WC_Admin_API_Keys_Table_List{
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

fn (mut this Class_WC_Admin_API_Keys_Table_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'column_truncated_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_truncated_key(dispatch_arg_0))
		}
		'column_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_user(dispatch_arg_0))
		}
		'column_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_permissions(dispatch_arg_0))
		}
		'column_last_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_last_access(dispatch_arg_0)
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
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
		else { return none }
	}
}

fn (this &Class_WC_Admin_API_Keys_Table_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_api_keys_table_list_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_List_Table')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
