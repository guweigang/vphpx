import rt

struct Class_WC_Admin_API_Keys {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_API_Keys) construct() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_API_Keys', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'actions' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_settings_page_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_API_Keys', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'screen_option' },
		])])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_save_settings_advanced_keys'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_API_Keys', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'allow_save_settings' },
		]),
	])
}

fn (mut this Class_WC_Admin_API_Keys) allow_save_settings(var_allow rt.PhpVal) bool {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('create-key'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('edit-key'))) {
		return false
	}
	return var_allow.to_bool()
}

fn (mut this Class_WC_Admin_API_Keys) is_api_keys_settings_page() bool {
	return rt.is_true(rt.call_function('is_wc_admin_settings_page', []rt.PhpVal{}))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('section'))
		&& rt.is_true(rt.identical(rt.new_string('advanced'), rt.get_superglobal('_GET').array_get(rt.new_string('tab'))))
		&& rt.is_true(rt.identical(rt.new_string('keys'), rt.get_superglobal('_GET').array_get(rt.new_string('section'))))
	return false
}

fn Class_WC_Admin_API_Keys.page_output() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('hide_save_button', true)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('create-key'))
		|| rt.get_superglobal('_GET').array_isset(rt.new_string('edit-key')) {
		mut var_key_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('edit-key')) { rt.call_function('absint', [
				rt.get_superglobal('_GET').array_get(rt.new_string('edit-key')),
			]) } else { rt.new_int(0) }
		mut var_key_data := Class_WC_Admin_API_Keys.get_key_data(var_key_id.clone())
		mut var_user_id := rt.new_int((var_key_data.array_get(rt.new_string('user_id'))).to_i64())
		if rt.is_true(var_key_id) && rt.is_true(var_user_id)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.clone()]))))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id',
				[]rt.PhpVal{}), var_user_id))))
			{
				rt.call_function('wp_die', [
					rt.call_function('esc_html__', [
						rt.new_string('You do not have permission to edit this API Key'),
						rt.new_string('woocommerce'),
					]),
				])
			}
		}
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/settings/views/html-keys-edit.php', '1')
	} else {
		Class_WC_Admin_API_Keys.table_list_output()
	}
}

fn (mut this Class_WC_Admin_API_Keys) screen_option() {
	mut var_keys_table_list := rt.get_superglobal('keys_table_list')
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('create-key')))
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('edit-key')))
		&& this.is_api_keys_settings_page() {
		var_keys_table_list = create_wc_admin_api_keys_table_list()
		rt.call_function('add_screen_option', [rt.new_string('per_page'),
			rt.create_array([rt.ArrayItem{ key: 'default', val: 10 },
				rt.ArrayItem{ key: 'option', val: 'woocommerce_keys_per_page' }])])
	}
}

fn Class_WC_Admin_API_Keys.table_list_output() {
	mut var_wpdb := rt.new_null()
	mut var_keys_table_list := rt.new_null()
	print('<h2 class="wc-table-list-header">' +
		(rt.call_function('esc_html__', [rt.new_string('REST API'), rt.new_string('woocommerce')])).str() +
		' <a href="' +
		(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=keys&create-key=1')])])).str() +
		'" class="page-title-action">' +
		(rt.call_function('esc_html__', [rt.new_string('Add key'), rt.new_string('woocommerce')])).str() +
		'</a></h2>')
	mut var_count := rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT(key_id) FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('woocommerce_api_keys WHERE 1 = 1;')),
	])
	if rt.is_true(rt.call_function('absint', [var_count.clone()]))
		&& rt.is_true(rt.greater(var_count, rt.new_int(0))) {
		var_keys_table_list.prepare_items()
		print('<input type="hidden" name="page" value="wc-settings" />')
		print('<input type="hidden" name="tab" value="advanced" />')
		print('<input type="hidden" name="section" value="keys" />')
		var_keys_table_list.views()
		var_keys_table_list.search_box(rt.call_function('__', [
			rt.new_string('Search key'),
			rt.new_string('woocommerce'),
		]), rt.new_string('key'))
		var_keys_table_list.display()
	} else {
		print('<div class="woocommerce-BlankState woocommerce-BlankState--api">')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('The WooCommerce REST API allows external apps to view and manage store data. Access is granted only to those with valid API keys.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=advanced&section=keys&create-key=1'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Create an API key'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn Class_WC_Admin_API_Keys.get_key_data(var_key_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_key_id_mutated := var_key_id
	mut var_empty := {
		'key_id':        rt.new_int(0)
		'user_id':       rt.new_string('')
		'description':   rt.new_string('')
		'permissions':   rt.new_string('')
		'truncated_key': rt.new_string('')
		'last_access':   rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_key_id_mutated)) {
		return var_empty.clone()
	}
	mut var_key := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT key_id, user_id, description, permissions, truncated_key, last_access\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_api_keys\n\t\t\t\tWHERE key_id = %d')),
			var_key_id_mutated.clone(),
		]),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.new_bool(var_key.clone().is_null())) {
		return var_empty.clone()
	}
	return var_key.clone()
}

fn (mut this Class_WC_Admin_API_Keys) actions() {
	if this.is_api_keys_settings_page() {
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('revoke-key')) {
			this.revoke_key()
		}
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
			&& rt.get_superglobal('_REQUEST').array_isset(rt.new_string('key')) {
			this.bulk_actions()
		}
	}
}

fn Class_WC_Admin_API_Keys.notices() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('revoked')) {
		mut var_revoked := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('revoked')),
		])
		mut iife_temp_0 := Class_WC_Admin_Settings{}
		mut iife_result_0 := iife_temp_0.add_message(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d API key permanently revoked.'),
				rt.new_string('%d API keys permanently revoked.'),
				var_revoked.clone(), rt.new_string('woocommerce')]),
			var_revoked.clone(),
		]))
	}
}

fn (mut this Class_WC_Admin_API_Keys) revoke_key() {
	mut var_wpdb := rt.new_null()
	rt.call_function('check_admin_referer', [rt.new_string('revoke')])
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('revoke-key')) {
		mut var_key_id := rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('revoke-key')),
		])
		mut var_user_id := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_api_keys WHERE key_id = %d')),
				var_key_id.clone(),
			]),
		])).to_i64())
		if rt.is_true(var_key_id) && rt.is_true(var_user_id)
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.clone()]))
			|| rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_user_id)) {
			this.remove_key(var_key_id.clone())
		} else {
			rt.call_function('wp_die', [
				rt.call_function('esc_html__', [
					rt.new_string('You do not have permission to revoke this API Key'),
					rt.new_string('woocommerce'),
				]),
			])
		}
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('esc_url_raw', [
			rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'revoked', val: 1 },
				]),
				rt.call_function('admin_url', [
					rt.new_string('admin.php?page=wc-settings&tab=advanced&section=keys'),
				]),
			]),
		]),
	])
	exit(0)
}

fn (mut this Class_WC_Admin_API_Keys) bulk_actions() {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-settings')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You do not have permission to edit API Keys'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) {
		mut var_action := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))]),
		])
		mut var_keys := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('key')) { rt.call_function('array_map', [
				rt.new_string('absint'),
				rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('key'))),
			]) } else { rt.new_array() }
		if rt.is_true(rt.identical(rt.new_string('revoke'), var_action)) {
			this.bulk_revoke_key(var_keys.clone())
		}
	}
}

fn (mut this Class_WC_Admin_API_Keys) bulk_revoke_key(var_keys rt.PhpVal) {
	mut var_keys_mutated := var_keys
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('remove_users'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You do not have permission to revoke API Keys'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	mut var_qty := rt.new_int(0)
	mut iter_1 := var_keys_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key_id := item_1.val
		mut var_result := this.remove_key(var_key_id.clone())
		if rt.is_true(var_result) {
			rt.post_inc(var_qty)
		}
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('esc_url_raw', [
			rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'revoked', val: var_qty },
				]),
				rt.call_function('admin_url', [
					rt.new_string('admin.php?page=wc-settings&tab=advanced&section=keys'),
				]),
			]),
		]),
	])
	exit(0)
}

fn (mut this Class_WC_Admin_API_Keys) remove_key(var_key_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_key_id_mutated := var_key_id
	mut var_delete := rt.call_method(var_wpdb, 'delete', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys'),
		rt.create_array([rt.ArrayItem{ key: 'key_id', val: var_key_id_mutated }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' }]),
	])
	return var_delete.clone()
}

struct Class_WC_Admin_API_Keys_Table_List {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_wc_admin_api_keys() &Class_WC_Admin_API_Keys {
	mut obj := &Class_WC_Admin_API_Keys{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_admin_api_keys_table_list(_args ...rt.PhpVal) &Class_WC_Admin_API_Keys_Table_List {
	mut obj := &Class_WC_Admin_API_Keys_Table_List{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_API_Keys) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'allow_save_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.allow_save_settings(dispatch_arg_0))
		}
		'is_api_keys_settings_page' {
			return rt.new_bool(this.is_api_keys_settings_page())
		}
		'page_output' {
			Class_WC_Admin_API_Keys.page_output()
			return rt.new_null()
		}
		'screen_option' {
			this.screen_option()
			return rt.new_null()
		}
		'table_list_output' {
			Class_WC_Admin_API_Keys.table_list_output()
			return rt.new_null()
		}
		'get_key_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_API_Keys.get_key_data(dispatch_arg_0)
		}
		'actions' {
			this.actions()
			return rt.new_null()
		}
		'notices' {
			Class_WC_Admin_API_Keys.notices()
			return rt.new_null()
		}
		'revoke_key' {
			this.revoke_key()
			return rt.new_null()
		}
		'bulk_actions' {
			this.bulk_actions()
			return rt.new_null()
		}
		'bulk_revoke_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bulk_revoke_key(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_key(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_API_Keys) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_API_Keys) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_API_Keys_Table_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_API_Keys_Table_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	create_wc_admin_api_keys()
}
