import rt

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_notices := rt.new_null()
	mut var_name := rt.new_null()
	mut var_stat_totals := rt.new_null()
	mut var_akismet_user := rt.new_null()
	mut var_kses_allow_link_href := {
		'a': {
			'href': rt.new_bool(true)
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('akismet_header')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('akismet_header')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_0 := Class_Akismet{}
		mut iife_result_0 := iife_temp_0.view(rt.new_string('logo'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_Akismet{}
	mut iife_result_1 := iife_temp_1.get_api_key()
	if rt.is_true(iife_result_1) {
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_2 := Class_Akismet_Admin{}
		mut iife_result_2 := iife_temp_2.display_status()
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_notices)) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_notices.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_notice := item_1.val
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_3 := Class_Akismet{}
			mut iife_result_3 := iife_temp_3.view(rt.new_string('notice'), rt.call_function('array_merge', [
				var_notice.clone(),
				rt.create_array([rt.ArrayItem{ key: 'parent_view', val: var_name }]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_stat_totals.array_isset(rt.new_string('all'))
		&& var_stat_totals.array_isset(rt.new_string('6-months')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Statistics'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_4 := Class_Akismet{}
		mut iife_result_4 := iife_temp_4.get_access_token()
		mut iife_temp_5 := Class_Akismet{}
		mut iife_result_5 := iife_temp_5.get_access_token()
		mut iife_temp_6 := Class_Akismet{}
		mut iife_result_6 := iife_temp_6.get_access_token()
		mut iife_temp_7 := Class_Akismet{}
		mut iife_result_7 := iife_temp_7.get_access_token()
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('sprintf', [
				rt.new_string('https://tools.akismet.com/1.0/snapshot.php?blog=%s&token=%s&height=200&locale=%s&is_redecorated=1'),
				rt.call_function('rawurlencode', [
					rt.call_function('get_option', [rt.new_string('home')]),
				]),
				rt.call_function('rawurlencode', [
					iife_result_4,
				]),
				rt.call_function('get_user_locale', []rt.PhpVal{}),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string('snapshot-' +
				(rt.call_function('filemtime', [rt.new_string(@FILE)])).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Akismet stats'),
			rt.new_string('akismet')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Past six months'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('number_format', [
			rt.get_property(var_stat_totals.array_get(rt.new_string('6-months')), 'spam'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('_n', [rt.new_string('Spam blocked'),
				rt.new_string('Spam blocked'),
				rt.get_property(var_stat_totals.array_get(rt.new_string('6-months')),
					'spam'),
				rt.new_string('akismet')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('All time'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('number_format', [
			rt.get_property(var_stat_totals.array_get(rt.new_string('all')), 'spam'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('_n', [rt.new_string('Spam blocked'),
				rt.new_string('Spam blocked'),
				rt.get_property(var_stat_totals.array_get(rt.new_string('all')),
					'spam'),
				rt.new_string('akismet')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Accuracy'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.new_float(rt.get_property(var_stat_totals.array_get(rt.new_string('all')),
			'accuracy').to_f64()))
		// unsupported statement: Stmt_InlineHTML
		print(
			(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s missed spam'), rt.new_string('%s missed spam'), rt.get_property(var_stat_totals.array_get(rt.new_string('all')), 'missed_spam'), rt.new_string('akismet')]), rt.call_function('number_format', [rt.get_property(var_stat_totals.array_get(rt.new_string('all')), 'missed_spam')])])])).str() +
			', ')
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('%s false positive'),
					rt.new_string('%s false positives'),
					rt.get_property(var_stat_totals.array_get(rt.new_string('all')),
						'false_positives'),
					rt.new_string('akismet'),
				]),
				rt.call_function('number_format', [
					rt.get_property(var_stat_totals.array_get(rt.new_string('all')),
						'false_positives'),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_8 := Class_Akismet_Admin{}
		mut iife_result_8 := iife_temp_8.get_page_url(rt.new_string('stats'))
		mut iife_temp_9 := Class_Akismet_Admin{}
		mut iife_result_9 := iife_temp_9.get_page_url(rt.new_string('stats'))
		rt.echo_val(rt.call_function('esc_url', [iife_result_8]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('View detailed stats'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('akismet_show_compatible_plugins'),
		rt.new_bool(true),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_10 := Class_Akismet{}
		mut iife_result_10 := iife_temp_10.view(rt.new_string('compatible-plugins'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_akismet_user) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Settings'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_11 := Class_Akismet_Admin{}
		mut iife_result_11 := iife_temp_11.get_page_url()
		mut iife_temp_12 := Class_Akismet_Admin{}
		mut iife_result_12 := iife_temp_12.get_page_url()
		rt.echo_val(rt.call_function('esc_url', [iife_result_11]))
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_13 := Class_Akismet{}
		mut iife_result_13 := iife_temp_13.predefined_api_key()
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_13)))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('API key'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('get_option', [rt.new_string('wordpress_api_key')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.new_string('regular-text code ' +
					(rt.get_property(var_akismet_user, 'status')).str()),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Copy API key'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.include_file((rt.call_function('plugin_dir_path', [rt.new_string(@FILE)])).str() +
				'../_inc/img/copy.svg', '1')
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.get_superglobal('_GET').array_isset(rt.new_string('ssl_status')) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('SSL status'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_http_supports', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
			])))))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Disabled.'),
					rt.new_string('akismet')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('Your Web server cannot make SSL requests; contact your Web host and ask them to add support for SSL requests.'),
					rt.new_string('akismet'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				mut var_ssl_disabled := rt.call_function('get_option', [
					rt.new_string('akismet_ssl_disabled'),
				])
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(var_ssl_disabled) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [
						rt.new_string('Temporarily disabled.'),
						rt.new_string('akismet'),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [
						rt.new_string('Akismet encountered a problem with a previous SSL request and disabled it temporarily. It will begin using SSL for requests again shortly.'),
						rt.new_string('akismet'),
					])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Enabled.'),
						rt.new_string('akismet')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [
						rt.new_string('All systems functional.'),
						rt.new_string('akismet'),
					])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Comments'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_bool(true),
			rt.call_function('in_array', [
				rt.call_function('get_option', [
					rt.new_string('akismet_show_user_comments_approved'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: none, val: false },
					rt.ArrayItem{ key: none, val: '1' },
					rt.ArrayItem{ key: none, val: 'true' },
				]),
				rt.new_bool(true),
			])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Show the number of approved comments beside each comment author.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Spam filtering'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Akismet Anti-spam strictness'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('1'),
			rt.call_function('get_option', [rt.new_string('akismet_strictness')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Silently discard the worst and most pervasive spam so I never see it.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_bool(true),
			rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
				rt.new_string('akismet_strictness'),
			]), rt.new_string('1'))))])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Always put spam in the Spam folder for review.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Note:'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		mut var_delete_interval := rt.call_function('max', [rt.new_int(1),
			rt.new_int(rt.call_function('apply_filters', [
				rt.new_string('akismet_delete_comment_interval'),
				rt.new_int(15),
			]).to_i64())])
		mut var_spam_folder_link := rt.call_function('sprintf', [
			rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [
					rt.new_string('edit-comments.php?comment_status=spam'),
				]),
			]),
			rt.call_function('esc_html__', [
				rt.new_string('spam folder'),
				rt.new_string('akismet'),
			]),
		])
		mut var_delete_message := rt.call_function('_n', [
			rt.new_string('Spam in the %1$s older than %2$d day is deleted automatically.'),
			rt.new_string('Spam in the %1$s older than %2$d days is deleted automatically.'),
			var_delete_interval.clone(),
			rt.new_string('akismet'),
		])
		rt.call_function('printf', [
			rt.call_function('wp_kses', [var_delete_message.clone(),
				rt.create_array_from_native_map(var_kses_allow_link_href)]),
			rt.call_function('wp_kses', [var_spam_folder_link.clone(),
				rt.create_array_from_native_map(var_kses_allow_link_href)]),
			rt.call_function('esc_html', [var_delete_interval.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Privacy'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Akismet privacy notice'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('display'),
			rt.call_function('get_option', [
				rt.new_string('akismet_comment_form_privacy_notice'),
			])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Display a privacy notice under your comment forms.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.is_true(rt.call_function('in_array', [
			rt.call_function('get_option', [
				rt.new_string('akismet_comment_form_privacy_notice'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'display' },
				rt.ArrayItem{ key: none, val: 'hide' },
			]),
			rt.new_bool(true),
		]))
		{ rt.call_function('checked', [rt.new_string('hide'),
				rt.call_function('get_option', [
					rt.new_string('akismet_comment_form_privacy_notice'),
				]),
				rt.new_bool(false)]) } else { rt.new_string('checked="checked"') })
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Do not display privacy notice.'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('To help your site with transparency under privacy laws like the GDPR, Akismet can display a notice to your users under your comment forms.'),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('akismet_show_mcp_setting'),
			rt.new_bool(true),
		]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Tool access'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_string('1'),
				rt.call_function('get_option', [
					rt.new_string('akismet_enable_mcp_access'),
				])])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Allow '),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Model Context Protocol'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('MCP'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string(' clients to access Akismet data and functionality'),
				rt.new_string('akismet'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string('MCP (Model Context Protocol) allows AI assistants to access Akismet statistics and spam checking features.'),
				rt.new_string('akismet'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_14 := Class_Akismet{}
		mut iife_result_14 := iife_temp_14.predefined_api_key()
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_14)))) {
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_15 := Class_Akismet_Admin{}
			mut iife_result_15 := iife_temp_15.get_page_url(rt.new_string('delete_key'))
			mut iife_temp_16 := Class_Akismet_Admin{}
			mut iife_result_16 := iife_temp_16.get_page_url(rt.new_string('delete_key'))
			rt.echo_val(rt.call_function('esc_url', [iife_result_15]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Disconnect this account'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [Class_Akismet_Admin.nonce()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save changes'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_17 := Class_Akismet{}
		mut iife_result_17 := iife_temp_17.predefined_api_key()
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_17)))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Account'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Subscription type'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.get_property(var_akismet_user, 'account_name'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Status'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(Class_Akismet.user_status_cancelled(), rt.get_property(var_akismet_user,
				'status')))
			{
				rt.call_function('esc_html_e', [rt.new_string('Cancelled'),
					rt.new_string('akismet')])
			} else if rt.is_true(rt.identical(Class_Akismet.user_status_suspended(), rt.get_property(var_akismet_user,
				'status')))
			{
				rt.call_function('esc_html_e', [rt.new_string('Suspended'),
					rt.new_string('akismet')])
			} else if rt.is_true(rt.identical(Class_Akismet.user_status_missing(), rt.get_property(var_akismet_user,
				'status')))
			{
				rt.call_function('esc_html_e', [rt.new_string('Missing'),
					rt.new_string('akismet')])
			} else if rt.is_true(rt.identical(Class_Akismet.user_status_no_sub(), rt.get_property(var_akismet_user,
				'status')))
			{
				rt.call_function('esc_html_e', [rt.new_string('No subscription found'),
					rt.new_string('akismet')])
			} else {
				rt.call_function('esc_html_e', [rt.new_string('Active'),
					rt.new_string('akismet')])
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.get_property(var_akismet_user, 'next_billing_date')) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Next billing date'),
					rt.new_string('akismet')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('gmdate', [rt.new_string('F j, Y'),
						rt.get_property(var_akismet_user, 'next_billing_date')]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'status'),
				Class_Akismet.user_status_active()))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Account overview'),
					rt.new_string('akismet')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_18 := Class_Akismet{}
			mut iife_result_18 := iife_temp_18.view(rt.new_string('get'), rt.create_array([
				rt.ArrayItem{
					key: 'text'
					val: if rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'account_type'), rt.new_string('free-api-key'))) && rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_active())) { rt.call_function('__', [
							rt.new_string('Upgrade'),
							rt.new_string('akismet'),
						]) } else { rt.call_function('__', [
							rt.new_string('Change'),
							rt.new_string('akismet'),
						]) }
				},
				rt.ArrayItem{ key: 'redirect', val: 'upgrade' },
				rt.ArrayItem{
					key: 'utm_content'
					val: if
						rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'account_type'), rt.new_string('free-api-key')))
						&& rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_active())) {
						'config_upgrade'
					} else {
						'config_change'
					}
				},
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_19 := Class_Akismet{}
	mut iife_result_19 := iife_temp_19.view(rt.new_string('footer'))
	// unsupported statement: Stmt_InlineHTML
}
