import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_options_to_update := []rt.PhpVal{}
	rt.include_file(@DIR + '/admin.php', '4')
	mut var_title := rt.call_function('__', [rt.new_string('Settings')])
	mut var_this_file := 'options.php'
	mut var_parent_file := 'options-general.php'
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	mut var_option_page := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('option_page'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('option_page')]) } else { rt.new_string('') }
	mut var_capability := rt.new_string(rt.new_string('manage_options'))
	if !rt.is_true(var_option_page) {
		var_option_page = rt.new_string(rt.new_string('options'))
	}
	var_capability = rt.call_function('apply_filters', [rt.new_string("option_page_capability_${var_option_page.to_string()}"), var_capability.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_capability.dup()]))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage options for this site.')])).str() + '</p>', rt.new_int(403)])
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('adminhash'))) {
		mut var_new_admin_details := rt.call_function('get_option', [rt.new_string('adminhash')])
		mut var_redirect := 'options-general.php?updated=false'
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_new_admin_details.dup().is_array())) && rt.is_true(rt.call_function('hash_equals', [var_new_admin_details.array_get('hash'), rt.get_superglobal('_GET').array_get('adminhash')])))) && !(!rt.is_true(var_new_admin_details.array_get('newemail'))))) {
			rt.call_function('update_option', [rt.new_string('admin_email'), var_new_admin_details.array_get('newemail')])
			rt.call_function('delete_option', [rt.new_string('adminhash')])
			rt.call_function('delete_option', [rt.new_string('new_admin_email')])
			var_redirect = 'options-general.php?updated=true'
		}
		rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string(var_redirect).dup()])])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('dismiss'))) && rt.is_true(rt.identical(rt.new_string('new_admin_email'), rt.get_superglobal('_GET').array_get('dismiss'))))) {
		rt.call_function('check_admin_referer', ['dismiss-' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str() + '-new_admin_email'])
		rt.call_function('delete_option', [rt.new_string('adminhash')])
		rt.call_function('delete_option', [rt.new_string('new_admin_email')])
		rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('options-general.php?updated=true')])])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_options')]))))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete these items.')])).str() + '</p>', rt.new_int(403)])
	}
	mut var_allowed_options := rt.create_array([rt.ArrayItem{ key: 'general', val: rt.create_array([rt.ArrayItem{ key: none, val: 'blogname' }, rt.ArrayItem{ key: none, val: 'blogdescription' }, rt.ArrayItem{ key: none, val: 'site_icon' }, rt.ArrayItem{ key: none, val: 'gmt_offset' }, rt.ArrayItem{ key: none, val: 'date_format' }, rt.ArrayItem{ key: none, val: 'time_format' }, rt.ArrayItem{ key: none, val: 'start_of_week' }, rt.ArrayItem{ key: none, val: 'timezone_string' }, rt.ArrayItem{ key: none, val: 'WPLANG' }, rt.ArrayItem{ key: none, val: 'new_admin_email' }]) }, rt.ArrayItem{ key: 'discussion', val: rt.create_array([rt.ArrayItem{ key: none, val: 'default_pingback_flag' }, rt.ArrayItem{ key: none, val: 'default_ping_status' }, rt.ArrayItem{ key: none, val: 'default_comment_status' }, rt.ArrayItem{ key: none, val: 'comments_notify' }, rt.ArrayItem{ key: none, val: 'moderation_notify' }, rt.ArrayItem{ key: none, val: 'comment_moderation' }, rt.ArrayItem{ key: none, val: 'require_name_email' }, rt.ArrayItem{ key: none, val: 'comment_previously_approved' }, rt.ArrayItem{ key: none, val: 'comment_max_links' }, rt.ArrayItem{ key: none, val: 'moderation_keys' }, rt.ArrayItem{ key: none, val: 'disallowed_keys' }, rt.ArrayItem{ key: none, val: 'show_avatars' }, rt.ArrayItem{ key: none, val: 'avatar_rating' }, rt.ArrayItem{ key: none, val: 'avatar_default' }, rt.ArrayItem{ key: none, val: 'close_comments_for_old_posts' }, rt.ArrayItem{ key: none, val: 'close_comments_days_old' }, rt.ArrayItem{ key: none, val: 'thread_comments' }, rt.ArrayItem{ key: none, val: 'thread_comments_depth' }, rt.ArrayItem{ key: none, val: 'page_comments' }, rt.ArrayItem{ key: none, val: 'comments_per_page' }, rt.ArrayItem{ key: none, val: 'default_comments_page' }, rt.ArrayItem{ key: none, val: 'comment_order' }, rt.ArrayItem{ key: none, val: 'comment_registration' }, rt.ArrayItem{ key: none, val: 'show_comments_cookies_opt_in' }, rt.ArrayItem{ key: none, val: 'wp_notes_notify' }]) }, rt.ArrayItem{ key: 'media', val: rt.create_array([rt.ArrayItem{ key: none, val: 'thumbnail_size_w' }, rt.ArrayItem{ key: none, val: 'thumbnail_size_h' }, rt.ArrayItem{ key: none, val: 'thumbnail_crop' }, rt.ArrayItem{ key: none, val: 'medium_size_w' }, rt.ArrayItem{ key: none, val: 'medium_size_h' }, rt.ArrayItem{ key: none, val: 'large_size_w' }, rt.ArrayItem{ key: none, val: 'large_size_h' }, rt.ArrayItem{ key: none, val: 'image_default_size' }, rt.ArrayItem{ key: none, val: 'image_default_align' }, rt.ArrayItem{ key: none, val: 'image_default_link_type' }]) }, rt.ArrayItem{ key: 'reading', val: rt.create_array([rt.ArrayItem{ key: none, val: 'posts_per_page' }, rt.ArrayItem{ key: none, val: 'posts_per_rss' }, rt.ArrayItem{ key: none, val: 'rss_use_excerpt' }, rt.ArrayItem{ key: none, val: 'show_on_front' }, rt.ArrayItem{ key: none, val: 'page_on_front' }, rt.ArrayItem{ key: none, val: 'page_for_posts' }, rt.ArrayItem{ key: none, val: 'blog_public' }]) }, rt.ArrayItem{ key: 'writing', val: rt.create_array([rt.ArrayItem{ key: none, val: 'default_category' }, rt.ArrayItem{ key: none, val: 'default_email_category' }, rt.ArrayItem{ key: none, val: 'default_link_category' }, rt.ArrayItem{ key: none, val: 'default_post_format' }]) }])
	var_allowed_options.array_set('misc', rt.new_array())
	var_allowed_options.array_set('options', rt.new_array())
	var_allowed_options.array_set('privacy', rt.new_array())
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_post_by_email_configuration'), rt.new_bool(true)])) {
		var_allowed_options.array_get_mut('writing').array_push('mailserver_url')
		var_allowed_options.array_get_mut('writing').array_push('mailserver_port')
		var_allowed_options.array_get_mut('writing').array_push('mailserver_login')
		var_allowed_options.array_get_mut('writing').array_push('mailserver_pass')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_utf8_charset', []rt.PhpVal{}))))) {
		var_allowed_options.array_get_mut('reading').array_push('blog_charset')
	}
	if rt.is_true(rt.less(rt.call_function('get_site_option', [rt.new_string('initial_db_version')]), rt.new_int(32453))) {
		var_allowed_options.array_get_mut('writing').array_push('use_smilies')
		var_allowed_options.array_get_mut('writing').array_push('use_balanceTags')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_SITEURL')]))))) {
			var_allowed_options.array_get_mut('general').array_push('siteurl')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_HOME')]))))) {
			var_allowed_options.array_get_mut('general').array_push('home')
		}
		var_allowed_options.array_get_mut('general').array_push('users_can_register')
		var_allowed_options.array_get_mut('general').array_push('default_role')
		if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_option', [rt.new_string('blog_public')]))) {
			var_allowed_options.array_get_mut('writing').array_push('ping_sites')
		}
		var_allowed_options.array_get_mut('media').array_push('uploads_use_yearmonth_folders')
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_option', [rt.new_string('upload_url_path')])) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_option', [rt.new_string('upload_path')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			var_allowed_options.array_get_mut('media').array_push('upload_path')
			var_allowed_options.array_get_mut('media').array_push('upload_url_path')
		}
	}
	var_allowed_options = rt.call_function('apply_filters_deprecated', [rt.new_string('whitelist_options'), rt.create_array([rt.ArrayItem{ key: none, val: var_allowed_options }]), rt.new_string('5.5.0'), rt.new_string('allowed_options'), rt.call_function('__', [rt.new_string('Please consider writing more inclusive code.')])])
	var_allowed_options = rt.call_function('apply_filters', [rt.new_string('allowed_options'), var_allowed_options.dup()])
	if rt.is_true(rt.identical(rt.new_string('update'), var_action)) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('options'), var_option_page)) && !(rt.get_superglobal('_POST').array_isset(rt.new_string('option_page'))))) {
			mut var_unregistered := true
			rt.call_function('check_admin_referer', [rt.new_string('update-options')])
		} else {
			var_unregistered = false
			rt.call_function('check_admin_referer', [(var_option_page).str() + '-options'])
		}
		if !(var_allowed_options.array_isset(var_option_page)) {
			rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The %s options page is not in the allowed options list.')]), '<code>' + (rt.call_function('esc_html', [var_option_page.dup()])).str() + '</code>'])])
		}
		if rt.is_true(rt.identical(rt.new_string('options'), var_option_page)) {
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_options')]))))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to modify unregistered settings for this site.')])])
			}
			mut var_options := if rt.get_superglobal('_POST').array_isset(rt.new_string('page_options')) { rt.call_function('explode', [rt.new_string(','), rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('page_options')])]) } else { rt.new_null() }
		} else {
			var_options = var_allowed_options.array_get(var_option_page)
		}
		if rt.is_true(rt.identical(rt.new_string('general'), var_option_page)) {
			if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('date_format'))) && rt.get_superglobal('_POST').array_isset(rt.new_string('date_format_custom')) && rt.is_true(rt.identical(rt.new_string('\\c\\u\\s\\t\\o\\m'), rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('date_format')]))))) {
				rt.get_superglobal('_POST').array_set('date_format', rt.get_superglobal('_POST').array_get('date_format_custom'))
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('time_format'))) && rt.get_superglobal('_POST').array_isset(rt.new_string('time_format_custom')) && rt.is_true(rt.identical(rt.new_string('\\c\\u\\s\\t\\o\\m'), rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('time_format')]))))) {
				rt.get_superglobal('_POST').array_set('time_format', rt.get_superglobal('_POST').array_get('time_format_custom'))
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('timezone_string'))) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^UTC[+-]/'), rt.get_superglobal('_POST').array_get('timezone_string')])))) {
				rt.get_superglobal('_POST').array_set('gmt_offset', rt.get_superglobal('_POST').array_get('timezone_string'))
				rt.get_superglobal('_POST').array_set('gmt_offset', rt.call_function('preg_replace', [rt.new_string('/UTC\\+?/'), rt.new_string(''), rt.get_superglobal('_POST').array_get('gmt_offset')]))
				rt.get_superglobal('_POST').array_set('timezone_string', '')
			} else if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('timezone_string')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_POST').array_get('timezone_string'), rt.call_function('timezone_identifiers_list', [Class_DateTimeZone.all_with_bc()]), rt.new_bool(true)]))))))) {
				mut var_current_timezone_string := rt.call_function('get_option', [rt.new_string('timezone_string')])
				if !(!rt.is_true(var_current_timezone_string)) {
					rt.get_superglobal('_POST').array_set('timezone_string', var_current_timezone_string.dup())
				} else {
					rt.get_superglobal('_POST').array_set('gmt_offset', rt.call_function('get_option', [rt.new_string('gmt_offset')]))
					rt.get_superglobal('_POST').array_set('timezone_string', '')
				}
				rt.call_function('add_settings_error', [rt.new_string('general'), rt.new_string('settings_updated'), rt.call_function('__', [rt.new_string('The timezone you have entered is not valid. Please select a valid timezone.')]), rt.new_string('error')])
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('WPLANG'))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')])))) {
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
				if rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) {
					mut var_language := rt.call_function('wp_download_language_pack', [rt.get_superglobal('_POST').array_get('WPLANG')])
					if rt.is_true(var_language) {
						rt.get_superglobal('_POST').array_set('WPLANG', var_language.dup())
					}
				}
			}
		}
		if rt.is_true(var_options) {
			mut var_user_language_old := rt.call_function('get_user_locale', []rt.PhpVal{})
			{
				mut iter_1 := var_options.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_option := item_1.val
					if var_unregistered {
						rt.call_function('_deprecated_argument', [rt.new_string('options.php'), rt.new_string('2.7.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %1$s setting is unregistered. Unregistered settings are deprecated. See <a href="%2$s">documentation on the Settings API</a>.')]), '<code>' + (rt.call_function('esc_html', [var_option.dup()])).str() + '</code>', rt.call_function('__', [rt.new_string('https://developer.wordpress.org/plugins/settings/settings-api/')])])])
					}
					var_option = rt.new_string(rt.new_string(var_option.dup().to_string().trim_space()))
					mut var_value := rt.new_null()
					if rt.get_superglobal('_POST').array_isset(var_option) {
						var_value = rt.get_superglobal('_POST').array_get(var_option)
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
							var_value = rt.new_string(rt.new_string(var_value.dup().to_string().trim_space()))
						}
						var_value = rt.call_function('wp_unslash', [var_value.dup()])
					}
					rt.call_function('update_option', [var_option.dup(), var_value.dup()])
				}
			}
			var_GLOBALS.array_unset(rt.new_string('locale'))
			mut var_user_language_new := rt.call_function('get_user_locale', []rt.PhpVal{})
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_function('load_default_textdomain', [var_user_language_new.dup()])
			}
		} else {
			rt.call_function('add_settings_error', [rt.new_string('general'), rt.new_string('settings_updated'), rt.call_function('__', [rt.new_string('Settings save failed.')]), rt.new_string('error')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(rt.call_function('get_settings_errors', []rt.PhpVal{}).array_count()))))) {
			rt.call_function('add_settings_error', [rt.new_string('general'), rt.new_string('settings_updated'), rt.call_function('__', [rt.new_string('Settings saved.')]), rt.new_string('success')])
		}
		rt.call_function('set_transient', [rt.new_string('settings_errors'), rt.call_function('get_settings_errors', []rt.PhpVal{}), rt.new_int(30)])
		mut var_goback := rt.call_function('add_query_arg', [rt.new_string('settings-updated'), rt.new_string('true'), rt.call_function('wp_get_referer', []rt.PhpVal{})])
		rt.call_function('wp_redirect', [var_goback.dup()])
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('All Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', ['<strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ' + (rt.call_function('__', [rt.new_string('This page allows direct access to your site settings. You can break things here. Please be cautious!')])).str(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('options-options')])
	// unsupported statement: Stmt_InlineHTML
	var_options = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' ORDER BY option_name'))])
	{
		mut iter_1 := rt.cast_array(var_options).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			mut var_disabled := false
			if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_option, 'option_name'))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('home'), rt.get_property(, 'option_name'))) && rt.is_true(rt.call_function('defined', [rt.new_string('WP_HOME')])))) {
				var_disabled = true
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(, )) && rt.is_true(rt.call_function('defined', [])))) {
				var_disabled = 
			}
			if rt.is_true(rt.call_function('is_serialized', [])) {
				if rt.is_true() {
				} else {
				}
			} else if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
				
			} else {
			}
			
		}
	}
}
