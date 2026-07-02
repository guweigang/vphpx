import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_sites'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage themes for this site.'),
			]),
		])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.call_function('get_site_screen_help_tab_args', []rt.PhpVal{}),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.call_function('get_site_screen_help_sidebar_content', []rt.PhpVal{}),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter site themes list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Site themes list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Site themes list'),
			]) },
		]),
	])
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_MS_Themes_List_Table'),
	])
	mut var_action := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	mut var_s := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))
	} else {
		rt.new_string('')
	}
	mut var_temp_args := ['enabled', 'disabled', 'error']
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
		rt.create_array_from_list(var_temp_args),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
	]))
	mut var_referer := rt.call_function('remove_query_arg', [
		rt.create_array_from_list(var_temp_args),
		rt.call_function('wp_get_referer', []rt.PhpVal{}),
	])
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged')))) {
		var_referer = rt.call_function('add_query_arg', [rt.new_string('paged'),
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))).to_i64()),
			var_referer.clone()])
	}
	mut var_id := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Invalid site ID.')]),
		])
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	mut var_details := rt.call_function('get_site', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_details)))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('The requested site does not exist.')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('can_edit_network', [
		rt.get_property(var_details, 'site_id'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to access this page.'),
			]),
			rt.new_int(403),
		])
	}
	mut var_is_main_site := rt.call_function('is_main_site', [
		var_id.clone()])
	if rt.is_true(var_action) {
		rt.call_function('switch_to_blog', [var_id.clone()])
		mut var_allowed_themes := rt.call_function('get_option', [
			rt.new_string('allowedthemes'),
		])
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable'))) {
			rt.call_function('check_admin_referer', [
				rt.new_string('enable-theme_' +
					(rt.get_superglobal('_GET').array_get(rt.new_string('theme'))).str()),
			])
			mut var_theme := rt.get_superglobal('_GET').array_get(rt.new_string('theme'))
			var_action = rt.new_string('enabled')
			mut var_n := rt.new_int(1)
			if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed_themes)))) {
				var_allowed_themes = rt.create_array([
					rt.ArrayItem{ key: var_theme, val: true },
				])
			} else {
				var_allowed_themes.array_set(var_theme, true)
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disable'))) {
			rt.call_function('check_admin_referer', [
				rt.new_string('disable-theme_' +
					(rt.get_superglobal('_GET').array_get(rt.new_string('theme'))).str()),
			])
			var_theme = rt.get_superglobal('_GET').array_get(rt.new_string('theme'))
			var_action = rt.new_string('disabled')
			var_n = rt.new_int(1)
			if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed_themes)))) {
				var_allowed_themes = rt.new_array()
			} else {
				var_allowed_themes.array_unset(var_theme)
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				mut var_themes :=
					rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
				var_action = rt.new_string('enabled')
				var_n = rt.new_int(var_themes.clone().array_count())
				mut iter_1 := rt.cast_array(var_themes).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_theme_shadow := item_1.val
					var_allowed_themes.array_set(var_theme_shadow, true)
				}
			} else {
				var_action = rt.new_string('error')
				var_n = rt.new_string('none')
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				var_themes =
					rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
				var_action = rt.new_string('disabled')
				var_n = rt.new_int(var_themes.clone().array_count())
				mut iter_2 := rt.cast_array(var_themes).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_theme_shadow := item_2.val
					var_allowed_themes.array_unset(var_theme_shadow)
				}
			} else {
				var_action = rt.new_string('error')
				var_n = rt.new_string('none')
			}
		} else {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
				var_themes =
					rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
				var_n = rt.new_int(var_themes.clone().array_count())
				mut var_screen := rt.get_property(rt.call_function('get_current_screen',
					[]rt.PhpVal{}), 'id')
				var_referer = rt.call_function('apply_filters', [
					rt.new_string('handle_network_bulk_actions-${var_screen.to_string()}'),
					var_referer.clone(),
					var_action.clone(),
					var_themes.clone(),
					var_id.clone(),
				])
			} else {
				var_action = rt.new_string('error')
				var_n = rt.new_string('none')
			}
		}
		rt.call_function('update_option', [rt.new_string('allowedthemes'),
			var_allowed_themes.clone(), rt.new_bool(false)])
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		rt.call_function('wp_safe_redirect', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: var_id },
					rt.ArrayItem{ key: var_action, val: var_n }]),
				var_referer.clone(),
			]),
		])
		exit(0)
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('update-site'), rt.get_superglobal('_GET').array_get(rt.new_string('action')))) {
		rt.call_function('wp_safe_redirect', [var_referer.clone()])
		exit(0)
	}
	rt.call_function('add_thickbox', []rt.PhpVal{})
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	mut var_title := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Edit Site: %s')]),
		rt.call_function('esc_html', [rt.get_property(var_details, 'blogname')]),
	])
	mut var_parent_file := 'sites.php'
	mut var_submenu_file := 'sites.php'
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_home_url', [var_id.clone(), rt.new_string('/')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Visit')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_admin_url', [var_id.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dashboard')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('network_edit_site_nav', [
		rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id },
			rt.ArrayItem{ key: 'selected', val: 'site-themes' }]),
	])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled')) {
		mut var_enabled := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('enabled')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_enabled)) {
			mut var_message := rt.call_function('__', [rt.new_string('Theme enabled.')])
		} else {
			var_message = rt.call_function('_n', [rt.new_string('%s theme enabled.'),
				rt.new_string('%s themes enabled.'), var_enabled.clone()])
		}
		rt.call_function('wp_admin_notice', [
			rt.call_function('sprintf', [var_message.clone(),
				rt.call_function('number_format_i18n', [var_enabled.clone()])]),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' }]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled')) {
		mut var_disabled := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('disabled')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_disabled)) {
			var_message = rt.call_function('__', [rt.new_string('Theme disabled.')])
		} else {
			var_message = rt.call_function('_n', [rt.new_string('%s theme disabled.'),
				rt.new_string('%s themes disabled.'), var_disabled.clone()])
		}
		rt.call_function('wp_admin_notice', [
			rt.call_function('sprintf', [var_message.clone(),
				rt.call_function('number_format_i18n', [var_disabled.clone()])]),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' }]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('error'))
		&& rt.is_true(rt.identical(rt.new_string('none'), rt.get_superglobal('_GET').array_get(rt.new_string('error')))) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('No theme selected.')]),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' }]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Network enabled themes are not shown on this screen.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search installed themes')]),
		rt.new_string('theme'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
