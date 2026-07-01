import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_views_html_keys_edit_php() {
	mut var_key_id := rt.new_null()
	mut var_key_data := map[string]rt.PhpVal{}
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Key details'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('API keys open up access to potentially sensitive information. Only share them with organizations you trust.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Stick to one key per client: this makes it easier to revoke access in the future for a single client, without causing disruption for others.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_key_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Description'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Friendly name for identifying this key.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_key_data.array_get('description')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add a meaningful description, including a note of the person, company or app you are sharing the key with.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('User'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Owner of these keys.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_user_id := if !(!rt.is_true(var_key_data.array_get('user_id'))) { rt.call_function('absint', [var_key_data.array_get('user_id')]) } else { var_current_user_id }
	mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), var_user_id.dup()])
	mut var_user_string := rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s (#%2$s &ndash; %3$s)'), rt.new_string('woocommerce')]), rt.get_property(var_user, 'display_name'), rt.call_function('absint', [rt.get_property(var_user, 'ID')]), rt.get_property(var_user, 'user_email')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a user&hellip;'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('htmlspecialchars', [rt.call_function('wp_kses_post', [var_user_string.dup()])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Permissions'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Select the access type of these keys.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	mut var_permissions := { 'read': rt.call_function('__', [rt.new_string('Read'), rt.new_string('woocommerce')]), 'write': rt.call_function('__', [rt.new_string('Write'), rt.new_string('woocommerce')]), 'read_write': rt.call_function('__', [rt.new_string('Read/Write'), rt.new_string('woocommerce')]) }
	for var_permission_id, var_permission_name in var_permissions {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(permission_id)]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_key_data.array_get('permissions'), rt.new_string(permission_id), rt.new_bool(true)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_permission_name.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Write-only keys do not prevent clients from seeing information about the entities they are updating.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Consumer key ending in'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_key_data.array_get('truncated_key')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Last access'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_key_data.array_get('last_access'))) {
			mut var_date := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s at %2$s'), rt.new_string('woocommerce')]), rt.call_function('date_i18n', [rt.call_function('wc_date_format', []rt.PhpVal{}), rt.call_function('strtotime', [var_key_data.array_get('last_access')])]), rt.call_function('date_i18n', [rt.call_function('wc_time_format', []rt.PhpVal{}), rt.call_function('strtotime', [var_key_data.array_get('last_access')])])])
			rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_api_key_last_access_datetime'), var_date.dup(), var_key_data.array_get('last_access')])]))
		} else {
			rt.call_function('esc_html_e', [rt.new_string('Unknown'), rt.new_string('woocommerce')])
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_key_fields'), var_key_data.dup()])
	// unsupported statement: Stmt_InlineHTML
	if 0 == var_key_id.dup().to_i64() {
		rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Generate API key'), rt.new_string('woocommerce')]), rt.new_string('primary'), rt.new_string('update_api_key')])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Save changes'), rt.new_string('woocommerce')]), rt.new_string('primary'), rt.new_string('update_api_key'), rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'revoke-key', val: var_key_id }]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=keys')])]), rt.new_string('revoke')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Revoke key'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Consumer key'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied!'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Consumer secret'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied!'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('QRCode'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
