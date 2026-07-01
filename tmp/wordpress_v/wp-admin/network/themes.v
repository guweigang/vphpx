import rt

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_theme() &Class_WP_Theme {
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage network themes.')])])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [rt.new_string('WP_MS_Themes_List_Table')])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_action := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	mut var_s := if !(rt.get_superglobal('_REQUEST').array_get('s')).is_null() { rt.get_superglobal('_REQUEST').array_get('s') } else { rt.new_string('') }
	mut var_temp_args := ['enabled', 'disabled', 'deleted', 'error', 'enabled-auto-update', 'disabled-auto-update']
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [var_temp_args.dup(), rt.get_superglobal('_SERVER').array_get('REQUEST_URI')]))
	mut var_referer := rt.call_function('remove_query_arg', [var_temp_args.dup(), rt.call_function('wp_get_referer', []rt.PhpVal{})])
	if rt.is_true(var_action) {
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable'))) {
			rt.call_function('check_admin_referer', ['enable-theme_' + (rt.get_superglobal('_GET').array_get('theme')).str()])
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.network_enable_theme(arg_0) }(rt.get_superglobal('_GET').array_get('theme'))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_referer.dup(), rt.new_string('/network/themes.php')]))))) {
				rt.call_function('wp_redirect', [rt.call_function('network_admin_url', [rt.new_string('themes.php?enabled=1')])])
			} else {
				rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('enabled'), rt.new_int(1), var_referer.dup()])])
			}
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disable'))) {
			rt.call_function('check_admin_referer', ['disable-theme_' + (rt.get_superglobal('_GET').array_get('theme')).str()])
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.network_disable_theme(arg_0) }(rt.get_superglobal('_GET').array_get('theme'))
			rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('disabled'), rt.new_string('1'), var_referer.dup()])])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			mut var_themes := if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) { rt.cast_array(rt.get_superglobal('_POST').array_get('checked')) } else { rt.new_array() }
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('error'), rt.new_string('none'), var_referer.dup()])])
				// unsupported expression: Expr_Exit
			}
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.network_enable_theme(arg_0) }(rt.cast_array(var_themes))
			rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('enabled'), rt.new_int(var_themes.dup().array_count()), var_referer.dup()])])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			var_themes = if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) { rt.cast_array(rt.get_superglobal('_POST').array_get('checked')) } else { rt.new_array() }
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('error'), rt.new_string('none'), var_referer.dup()])])
				// unsupported expression: Expr_Exit
			}
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.network_disable_theme(arg_0) }(rt.cast_array(var_themes))
			rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('disabled'), rt.new_int(var_themes.dup().array_count()), var_referer.dup()])])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('themes')) {
				var_themes = rt.call_function('explode', [rt.new_string(','), rt.get_superglobal('_GET').array_get('themes')])
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				var_themes = rt.cast_array(rt.get_superglobal('_POST').array_get('checked'))
			} else {
				var_themes = rt.new_array()
			}
			mut var_title := rt.call_function('__', [rt.new_string('Update Themes')])
			mut var_parent_file := 'themes.php'
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			print('<div class="wrap">')
			print('<h1>' + (rt.call_function('esc_html', [var_title.dup()])).str() + '</h1>')
			mut var_url := rt.call_function('self_admin_url', ['update.php?action=update-selected-themes&amp;themes=' + (rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), var_themes.dup()])])).str()])
			var_url = rt.call_function('wp_nonce_url', [var_url.dup(), rt.new_string('bulk-update-themes')])
			print("<iframe src='${var_url.to_string()}' style='width: 100%; height:100%; min-height:850px;'></iframe>")
			print('</div>')
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete-selected'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')]))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete themes for this site.')])])
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-themes')])
			var_themes = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('checked')) { rt.cast_array(rt.get_superglobal('_REQUEST').array_get('checked')) } else { rt.new_array() }
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('error'), rt.new_string('none'), var_referer.dup()])])
				// unsupported expression: Expr_Exit
			}
			var_themes = rt.call_function('array_diff', [var_themes.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_option', [rt.new_string('stylesheet')]) }, rt.ArrayItem{ key: none, val: rt.call_function('get_option', [rt.new_string('template')]) }])])
			if !rt.is_true(var_themes) {
				rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('error'), rt.new_string('main'), var_referer.dup()])])
				// unsupported expression: Expr_Exit
			}
			mut var_theme_info := rt.new_array()
			{
				mut iter_1 := var_themes.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_theme := item_1.val
					mut var_key := item_1.key
					var_theme_info.array_set(var_theme, rt.call_function('wp_get_theme', [var_theme.dup()]))
				}
			}
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/update.php', '3')
			var_parent_file = 'themes.php'
			if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('verify-delete'))) {
				rt.call_function('wp_enqueue_script', [rt.new_string('jquery')])
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
				mut var_themes_to_delete := var_themes.dup().array_count()
				// unsupported statement: Stmt_InlineHTML
				if 1 == var_themes_to_delete {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Delete Theme')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('wp_admin_notice', ['<strong>' + (rt.call_function('__', [rt.new_string('Caution:')])).str() + '</strong> ' + (rt.call_function('__', [rt.new_string('This theme may be active on other sites in the network.')])).str(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('You are about to remove the following theme:')])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Delete Themes')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('wp_admin_notice', ['<strong>' + (rt.call_function('__', [rt.new_string('Caution:')])).str() + '</strong> ' + (rt.call_function('__', [rt.new_string('These themes may be active on other sites in the network.')])).str(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('You are about to remove the following themes:')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				{
					mut iter_1 := var_theme_info.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_theme := item_1.val
						print('<li>' + (rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s by %2$s'), rt.new_string('theme')]), '<strong>' + (rt.call_method(var_theme, 'display', [rt.new_string('Name')])).str() + '</strong>', '<em>' + (rt.call_method(var_theme, 'display', [rt.new_string('Author')])).str() + '</em>'])).str() + '</li>')
					}
				}
				// unsupported statement: Stmt_InlineHTML
				if 1 == var_themes_to_delete {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Are you sure you want to delete this theme?')])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Are you sure you want to delete these themes?')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')]))
				// unsupported statement: Stmt_InlineHTML
				{
					mut iter_1 := rt.cast_array(var_themes).iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_theme := item_1.val
						print('<input type="hidden" name="checked[]" value="' + (rt.call_function('esc_attr', [var_theme.dup()])).str() + '" />')
					}
				}
				rt.call_function('wp_nonce_field', [rt.new_string('bulk-themes')])
				if 1 == var_themes_to_delete {
					rt.call_function('submit_button', [, , , ])
				} else {
					
				}
				// unsupported statement: Stmt_InlineHTML
			}
			{
				mut iter_1 := .iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_theme := item_1.val
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
		} else {
		}
	}
	
}
