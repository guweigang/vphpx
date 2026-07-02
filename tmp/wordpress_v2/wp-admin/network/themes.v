import rt

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_theme(_args ...rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_status := rt.new_null()
	mut var_page := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_network_themes'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage network themes.'),
			]),
		])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_MS_Themes_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_action := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	mut var_s := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))
	} else {
		rt.new_string('')
	}
	mut var_temp_args := ['enabled', 'disabled', 'deleted', 'error', 'enabled-auto-update',
		'disabled-auto-update']
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
		rt.create_array_from_list(var_temp_args),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
	]))
	mut var_referer := rt.call_function('remove_query_arg', [
		rt.create_array_from_list(var_temp_args),
		rt.call_function('wp_get_referer', []rt.PhpVal{}),
	])
	if rt.is_true(var_action) {
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable'))) {
			rt.call_function('check_admin_referer', [
				rt.new_string('enable-theme_' +
					(rt.get_superglobal('_GET').array_get(rt.new_string('theme'))).str()),
			])
			mut iife_temp_0 := Class_WP_Theme{}
			mut iife_result_0 :=
				iife_temp_0.network_enable_theme(rt.get_superglobal('_GET').array_get(rt.new_string('theme')))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
				var_referer.clone(),
				rt.new_string('/network/themes.php'),
			])))))
			{
				rt.call_function('wp_redirect', [
					rt.call_function('network_admin_url', [
						rt.new_string('themes.php?enabled=1'),
					]),
				])
			} else {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('enabled'),
						rt.new_int(1), var_referer.clone()]),
				])
			}
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disable'))) {
			rt.call_function('check_admin_referer', [
				rt.new_string('disable-theme_' +
					(rt.get_superglobal('_GET').array_get(rt.new_string('theme'))).str()),
			])
			mut iife_temp_1 := Class_WP_Theme{}
			mut iife_result_1 :=
				iife_temp_1.network_disable_theme(rt.get_superglobal('_GET').array_get(rt.new_string('theme')))
			rt.call_function('wp_safe_redirect', [
				rt.call_function('add_query_arg', [rt.new_string('disabled'),
					rt.new_string('1'), var_referer.clone()]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			mut var_themes := if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
			} else {
				rt.new_array()
			}
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('error'),
						rt.new_string('none'), var_referer.clone()]),
				])
				exit(0)
			}
			mut iife_temp_2 := Class_WP_Theme{}
			mut iife_result_2 := iife_temp_2.network_enable_theme(rt.cast_array(var_themes))
			rt.call_function('wp_safe_redirect', [
				rt.call_function('add_query_arg', [rt.new_string('enabled'),
					rt.new_int(var_themes.clone().array_count()),
					var_referer.clone()]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			var_themes = if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
			} else {
				rt.new_array()
			}
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('error'),
						rt.new_string('none'), var_referer.clone()]),
				])
				exit(0)
			}
			mut iife_temp_3 := Class_WP_Theme{}
			mut iife_result_3 := iife_temp_3.network_disable_theme(rt.cast_array(var_themes))
			rt.call_function('wp_safe_redirect', [
				rt.call_function('add_query_arg', [rt.new_string('disabled'),
					rt.new_int(var_themes.clone().array_count()),
					var_referer.clone()]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('themes')) {
				var_themes = rt.call_function('explode', [rt.new_string(','),
					rt.get_superglobal('_GET').array_get(rt.new_string('themes'))])
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				var_themes =
					rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
			} else {
				var_themes = rt.new_array()
			}
			mut var_title := rt.call_function('__', [rt.new_string('Update Themes')])
			mut var_parent_file := 'themes.php'
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			print('<div class="wrap">')
			print('<h1>' + (rt.call_function('esc_html', [var_title.clone()])).str() + '</h1>')
			mut var_url := rt.call_function('self_admin_url', [
				rt.new_string('update.php?action=update-selected-themes&amp;themes=' +(rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), var_themes.clone()])])).str()),
			])
			var_url = rt.call_function('wp_nonce_url', [var_url.clone(),
				rt.new_string('bulk-update-themes')])
			print("<iframe src='${var_url.to_string()}' style='width: 100%; height:100%; min-height:850px;'></iframe>")
			print('</div>')
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete-selected'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_themes'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to delete themes for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			var_themes = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('checked')) {
				rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('checked')))
			} else {
				rt.new_array()
			}
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('error'),
						rt.new_string('none'), var_referer.clone()]),
				])
				exit(0)
			}
			var_themes = rt.call_function('array_diff', [var_themes.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_function('get_option', [
						rt.new_string('stylesheet'),
					]) },
					rt.ArrayItem{ key: none, val: rt.call_function('get_option', [
						rt.new_string('template'),
					]) },
				])])
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('error'),
						rt.new_string('main'), var_referer.clone()]),
				])
				exit(0)
			}
			mut var_theme_info := rt.new_array()
			mut iter_1 := var_themes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_theme := item_1.val
				mut var_key := item_1.key
				var_theme_info.array_set(var_theme, rt.call_function('wp_get_theme', [
					var_theme.clone(),
				]))
			}
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/update.php', '3')
			var_parent_file = 'themes.php'
			if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('verify-delete'))) {
				rt.call_function('wp_enqueue_script', [rt.new_string('jquery')])
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php',
					'4')
				mut var_themes_to_delete := var_themes.clone().array_count()
				// unsupported statement: Stmt_InlineHTML
				if 1 == var_themes_to_delete {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Delete Theme')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('wp_admin_notice', [
						rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('Caution:')])).str() +
							'</strong> ' +(rt.call_function('__', [rt.new_string('This theme may be active on other sites in the network.')])).str()),
						rt.create_array([
							rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'error' },
							]) },
						]),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('You are about to remove the following theme:'),
					])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Delete Themes')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('wp_admin_notice', [
						rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('Caution:')])).str() +
							'</strong> ' +(rt.call_function('__', [rt.new_string('These themes may be active on other sites in the network.')])).str()),
						rt.create_array([
							rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'error' },
							]) },
						]),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('You are about to remove the following themes:'),
					])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				mut iter_2 := var_theme_info.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_theme := item_2.val
					print('<li>' +
						(rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s by %2$s'), rt.new_string('theme')]), rt.new_string('<strong>' + (rt.call_method(var_theme, 'display', [rt.new_string('Name')])).str() +
						'</strong>'), rt.new_string('<em>' +
						(rt.call_method(var_theme, 'display', [rt.new_string('Author')])).str() +
						'</em>')])).str() + '</li>')
				}
				// unsupported statement: Stmt_InlineHTML
				if 1 == var_themes_to_delete {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('Are you sure you want to delete this theme?'),
					])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('Are you sure you want to delete these themes?'),
					])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
				]))
				// unsupported statement: Stmt_InlineHTML
				mut iter_3 := rt.cast_array(var_themes).iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_theme := item_3.val
					print('<input type="hidden" name="checked[]" value="' +
						(rt.call_function('esc_attr', [var_theme.clone()])).str() + '" />')
				}
				rt.call_function('wp_nonce_field', [rt.new_string('bulk-themes')])
				if 1 == var_themes_to_delete {
					rt.call_function('submit_button', [
						rt.call_function('__', [rt.new_string('Yes, delete this theme')]),
						rt.new_string(''),
						rt.new_string('submit'),
						rt.new_bool(false),
					])
				} else {
					rt.call_function('submit_button', [
						rt.call_function('__', [
							rt.new_string('Yes, delete these themes'),
						]),
						rt.new_string(''),
						rt.new_string('submit'),
						rt.new_bool(false),
					])
				}
				// unsupported statement: Stmt_InlineHTML
				var_referer = rt.call_function('wp_get_referer', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if rt.is_true(var_referer) { rt.call_function('esc_url', [
						var_referer.clone(),
					]) } else { rt.new_string('') })
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('submit_button', [
					rt.call_function('__', [
						rt.new_string('No, return me to the theme list'),
					]),
					rt.new_string(''),
					rt.new_string('submit'),
					rt.new_bool(false),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php',
					'4')
				exit(0)
			}
			mut iter_4 := var_themes.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_theme := item_4.val
				mut var_delete_result := rt.call_function('delete_theme', [
					var_theme.clone(),
					rt.call_function('esc_url', [
						rt.call_function('add_query_arg', [
							rt.create_array([
								rt.ArrayItem{ key: 'verify-delete', val: 1 },
								rt.ArrayItem{ key: 'action', val: 'delete-selected' },
								rt.ArrayItem{
									key: 'checked'
									val: rt.get_superglobal('_REQUEST').array_get(rt.new_string('checked'))
								},
								rt.ArrayItem{
									key: '_wpnonce'
									val: rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))
								},
							]),
							rt.call_function('network_admin_url', [
								rt.new_string('themes.php'),
							]),
						]),
					])])
			}
			mut var_paged := if rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))) {
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))
			} else {
				rt.new_int(1)
			}
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: 'deleted', val: var_themes.clone().array_count() },
						rt.ArrayItem{ key: 'paged', val: var_paged },
						rt.ArrayItem{ key: 's', val: var_s },
					]),
					rt.call_function('network_admin_url', [
						rt.new_string('themes.php'),
					]),
				]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-auto-update')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-auto-update')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-auto-update-selected')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-auto-update-selected'))) {
			if !(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
				&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')]))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to change themes automatic update settings.'),
					]),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('enable-auto-update'), var_action))
				|| rt.is_true(rt.identical(rt.new_string('disable-auto-update'), var_action)) {
				rt.call_function('check_admin_referer', [rt.new_string('updates')])
			} else {
				if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('checked'))) {
					rt.call_function('wp_safe_redirect', [
						rt.call_function('add_query_arg', [rt.new_string('error'),
							rt.new_string('none'), var_referer.clone()]),
					])
					exit(0)
				}
				rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			}
			mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [
				rt.new_string('auto_update_themes'),
				rt.new_array(),
			]))
			if rt.is_true(rt.identical(rt.new_string('enable-auto-update'), var_action)) {
				var_auto_updates.array_push(rt.get_superglobal('_GET').array_get(rt.new_string('theme')))
				var_auto_updates = rt.call_function('array_unique', [
					var_auto_updates.clone()])
				var_referer = rt.call_function('add_query_arg', [
					rt.new_string('enabled-auto-update'),
					rt.new_int(1),
					var_referer.clone(),
				])
			} else if rt.is_true(rt.identical(rt.new_string('disable-auto-update'), var_action)) {
				var_auto_updates = rt.call_function('array_diff', [
					var_auto_updates.clone(),
					rt.create_array([
						rt.ArrayItem{
							key: none
							val: rt.get_superglobal('_GET').array_get(rt.new_string('theme'))
						},
					])])
				var_referer = rt.call_function('add_query_arg', [
					rt.new_string('disabled-auto-update'),
					rt.new_int(1),
					var_referer.clone(),
				])
			} else {
				var_themes = rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('checked')),
				]))
				if rt.is_true(rt.identical(rt.new_string('enable-auto-update-selected'), var_action)) {
					var_auto_updates = rt.call_function('array_merge', [
						var_auto_updates.clone(), var_themes.clone()])
					var_auto_updates = rt.call_function('array_unique', [
						var_auto_updates.clone()])
					var_referer = rt.call_function('add_query_arg', [
						rt.new_string('enabled-auto-update'),
						rt.new_int(var_themes.clone().array_count()),
						var_referer.clone(),
					])
				} else {
					var_auto_updates = rt.call_function('array_diff', [
						var_auto_updates.clone(), var_themes.clone()])
					var_referer = rt.call_function('add_query_arg', [
						rt.new_string('disabled-auto-update'),
						rt.new_int(var_themes.clone().array_count()),
						var_referer.clone(),
					])
				}
			}
			mut var_all_items := rt.call_function('wp_get_themes', []rt.PhpVal{})
			var_auto_updates = rt.call_function('array_intersect', [
				var_auto_updates.clone(), rt.func_array_keys(var_all_items.clone())])
			rt.call_function('update_site_option', [rt.new_string('auto_update_themes'),
				var_auto_updates.clone()])
			rt.call_function('wp_safe_redirect', [var_referer.clone()])
			exit(0)
		} else {
			var_themes = if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
			} else {
				rt.new_array()
			}
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('error'),
						rt.new_string('none'), var_referer.clone()]),
				])
				exit(0)
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			var_referer = rt.call_function('apply_filters', [
				rt.new_string('handle_network_bulk_actions-' +(rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')).str()),
				var_referer.clone(),
				var_action.clone(),
				var_themes.clone(),
			])
			rt.call_function('wp_safe_redirect', [var_referer.clone()])
			exit(0)
		}
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_function('add_thickbox', []rt.PhpVal{})
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen enables and disables the inclusion of themes available to choose in the Appearance menu for each site. It does not activate or deactivate which theme a site is currently using.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('If the network admin disables a theme that is in use, it can still remain selected on that site. If another theme is chosen, the disabled theme will not appear in the site&#8217;s Appearance > Themes screen.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Themes can be enabled on a site by site basis by the network admin on the Edit Site screen (which has a Themes tab); get there via the Edit action link on the All Sites screen. Only network admins are able to install or edit themes.')])).str() +
				'</p>' }]),
	])
	mut var_help_sidebar_autoupdates := rt.new_string('')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
		&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')])) {
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'plugins-themes-auto-updates' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Auto-updates'),
				]) },
				rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('Auto-updates can be enabled or disabled for each individual theme. Themes with auto-updates enabled will display the estimated date of the next auto-update. Auto-updates depends on the WP-Cron task scheduling system.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Please note: Third-party themes and plugins, or custom code, may override WordPress scheduling.')])).str() +
					'</p>' },
			]),
		])
		var_help_sidebar_autoupdates = rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/plugins-themes-auto-updates/">Documentation on Auto-updates</a>')])).str() +
			'</p>')
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Network_Admin_Themes_Screen">Documentation on Network Themes</a>')])).str() +
			'</p>' + var_help_sidebar_autoupdates.str() + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter themes list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Themes list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Themes list'),
			]) },
		]),
	])
	var_title = rt.call_function('__', [rt.new_string('Themes')])
	var_parent_file = 'themes.php'
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	rt.call_function('wp_enqueue_script', [rt.new_string('theme-preview')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Theme')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s'))
		&& rt.is_true(rt.new_int(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')).to_string().len)) {
		print('<span class="subtitle">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Search results for: %s')]),
			rt.new_string('<strong>' + (rt.call_function('esc_html', [var_s.clone()])).str() +
				'</strong>'),
		])
		print('</span>')
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_message := rt.new_string('')
	mut var_type := 'success'
	if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled')) {
		mut var_enabled := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('enabled')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_enabled)) {
			var_message = rt.call_function('__', [rt.new_string('Theme enabled.')])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s theme enabled.'),
					rt.new_string('%s themes enabled.'), var_enabled.clone()]),
				rt.call_function('number_format_i18n', [var_enabled.clone()]),
			])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled')) {
		mut var_disabled := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('disabled')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_disabled)) {
			var_message = rt.call_function('__', [rt.new_string('Theme disabled.')])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s theme disabled.'),
					rt.new_string('%s themes disabled.'), var_disabled.clone()]),
				rt.call_function('number_format_i18n', [var_disabled.clone()]),
			])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('deleted')) {
		mut var_deleted := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('deleted')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_deleted)) {
			var_message = rt.call_function('__', [rt.new_string('Theme deleted.')])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s theme deleted.'),
					rt.new_string('%s themes deleted.'), var_deleted.clone()]),
				rt.call_function('number_format_i18n', [var_deleted.clone()]),
			])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled-auto-update')) {
		var_enabled = rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('enabled-auto-update')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_enabled)) {
			var_message = rt.call_function('__', [
				rt.new_string('Theme will be auto-updated.'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s theme will be auto-updated.'),
					rt.new_string('%s themes will be auto-updated.'),
					var_enabled.clone()]),
				rt.call_function('number_format_i18n', [var_enabled.clone()]),
			])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled-auto-update')) {
		var_disabled = rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('disabled-auto-update')),
		])
		if rt.is_true(rt.identical(rt.new_int(1), var_disabled)) {
			var_message = rt.call_function('__', [
				rt.new_string('Theme will no longer be auto-updated.'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('%s theme will no longer be auto-updated.'),
					rt.new_string('%s themes will no longer be auto-updated.'),
					var_disabled.clone(),
				]),
				rt.call_function('number_format_i18n', [
					var_disabled.clone(),
				]),
			])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('error'))
		&& rt.is_true(rt.identical(rt.new_string('none'), rt.get_superglobal('_GET').array_get(rt.new_string('error')))) {
		var_message = rt.call_function('__', [rt.new_string('No theme selected.')])
		var_type = 'error'
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('error'))
		&& rt.is_true(rt.identical(rt.new_string('main'), rt.get_superglobal('_GET').array_get(rt.new_string('error')))) {
		var_message = rt.call_function('__', [
			rt.new_string('You cannot delete a theme while it is active on the main site.'),
		])
		var_type = 'error'
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_message)))) {
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: var_type },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search installed themes')]),
		rt.new_string('theme'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('broken'), var_status)) {
		print('<p class="clear">' +
			(rt.call_function('__', [rt.new_string('The following themes are installed but incomplete.')])).str() +
			'</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_status.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_page.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_request_filesystem_credentials_modal', []rt.PhpVal{})
	rt.call_function('wp_print_admin_notice_templates', []rt.PhpVal{})
	rt.call_function('wp_print_update_row_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
