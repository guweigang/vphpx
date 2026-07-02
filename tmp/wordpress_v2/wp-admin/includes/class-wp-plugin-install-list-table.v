import rt

struct Class_WP_Plugin_Install_List_Table {
	rt.PhpObjectBase
pub mut:
	order   rt.PhpVal = rt.new_string('ASC')
	orderby rt.PhpVal = rt.new_null()
	groups  rt.PhpVal = rt.new_array()
	error   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Plugin_Install_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('install_plugins')])
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_installed_plugins() rt.PhpVal {
	mut var_plugins := rt.new_array()
	mut var_plugin_info := rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if !(rt.get_property(var_plugin_info, 'no_update')).is_null() {
		mut iter_1 := rt.get_property(var_plugin_info, 'no_update').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			if !(rt.get_property(var_plugin, 'slug')).is_null() {
				rt.set_property(var_plugin, 'upgrade', rt.new_bool(false))
				var_plugins.array_set(rt.get_property(var_plugin, 'slug'), var_plugin.clone())
			}
		}
	}
	if !(rt.get_property(var_plugin_info, 'response')).is_null() {
		mut iter_2 := rt.get_property(var_plugin_info, 'response').iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_plugin := item_2.val
			if !(rt.get_property(var_plugin, 'slug')).is_null() {
				rt.set_property(var_plugin, 'upgrade', rt.new_bool(true))
				var_plugins.array_set(rt.get_property(var_plugin, 'slug'), var_plugin.clone())
			}
		}
	}
	return var_plugins.clone()
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_installed_plugin_slugs() rt.PhpVal {
	return rt.func_array_keys(this.get_installed_plugins())
}

fn (mut this Class_WP_Plugin_Install_List_Table) prepare_items() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php',
		'4')
	mut var_tabs := rt.get_superglobal('tabs')
	mut var_tab := rt.get_superglobal('tab')
	mut var_paged := rt.get_superglobal('paged')
	mut var_type := rt.get_superglobal('type')
	mut var_term := rt.get_superglobal('term')
	var_tab = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('tab')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('tab')),
		]) } else { rt.new_string('') }
	var_paged = this.get_pagenum()
	mut var_per_page := rt.new_int(36)
	var_tabs = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('search'), var_tab)) {
		var_tabs.array_set('search', rt.call_function('__', [
			rt.new_string('Search Results'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('beta'), var_tab))
		|| rt.is_true(rt.call_function('str_contains', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.new_string('-')])) {
		var_tabs.array_set('beta', rt.call_function('_x', [rt.new_string('Beta Testing'),
			rt.new_string('Plugin Installer')]))
	}
	var_tabs.array_set('featured', rt.call_function('_x', [rt.new_string('Featured'),
		rt.new_string('Plugin Installer')]))
	var_tabs.array_set('popular', rt.call_function('_x', [rt.new_string('Popular'),
		rt.new_string('Plugin Installer')]))
	var_tabs.array_set('recommended', rt.call_function('_x', [
		rt.new_string('Recommended'),
		rt.new_string('Plugin Installer'),
	]))
	var_tabs.array_set('favorites', rt.call_function('_x', [rt.new_string('Favorites'),
		rt.new_string('Plugin Installer')]))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_plugins')])) {
		var_tabs.array_set('upload', rt.call_function('__', [
			rt.new_string('Upload Plugin'),
		]))
	}
	mut var_nonmenu_tabs := rt.create_array([
		rt.ArrayItem{ key: none, val: 'plugin-information' },
	])
	var_tabs = rt.call_function('apply_filters', [rt.new_string('install_plugins_tabs'),
		var_tabs.clone()])
	var_nonmenu_tabs = rt.call_function('apply_filters', [
		rt.new_string('install_plugins_nonmenu_tabs'),
		var_nonmenu_tabs.clone(),
	])
	if !rt.is_true(var_tab) || (!(var_tabs.array_isset(var_tab))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_tab.clone(), rt.cast_array(var_nonmenu_tabs), rt.new_bool(true)])))))) {
		var_tab = rt.call_function('key', [var_tabs.clone()])
	}
	mut var_installed_plugins := this.get_installed_plugins()
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'page', val: var_paged },
		rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'locale', val: rt.call_function('get_user_locale',
			[]rt.PhpVal{}) }])
	mut switch_val_1 := var_tab
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('search'))) {
		var_type = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('type')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('type')),
			]) } else { rt.new_string('term') }
		var_term = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')),
			]) } else { rt.new_string('') }
		mut switch_val_2 := var_type
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('tag'))) {
			var_args.array_set('tag', rt.call_function('sanitize_title_with_dashes', [
				var_term.clone(),
			]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('term'))) {
			var_args.array_set('search', var_term.clone())
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('author'))) {
			var_args.array_set('author', var_term.clone())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('featured')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('popular')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('new')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('beta'))) {
		var_args.array_set('browse', var_tab.clone())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recommended'))) {
		var_args.array_set('browse', var_tab.clone())
		var_args.array_set('installed_plugins', rt.func_array_keys(var_installed_plugins.clone()))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('favorites'))) {
		mut var_action := rt.new_string('save_wporg_username_' +
			(rt.call_function('get_current_user_id', []rt.PhpVal{})).str())
		if rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))
			&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))]), var_action.clone()])) {
			mut var_user := if rt.get_superglobal('_GET').array_isset(rt.new_string('user')) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('user')),
				]) } else { rt.call_function('get_user_option', [
					rt.new_string('wporg_favorites'),
				]) }
			if !(rt.get_superglobal('_GET').array_isset(rt.new_string('save')))
				|| rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('save'))) {
				rt.call_function('update_user_meta', [
					rt.call_function('get_current_user_id', []rt.PhpVal{}),
					rt.new_string('wporg_favorites'),
					var_user.clone(),
				])
			}
		} else {
			var_user = rt.call_function('get_user_option', [
				rt.new_string('wporg_favorites'),
			])
		}
		if rt.is_true(var_user) {
			var_args.array_set('user', var_user.clone())
		} else {
			var_args = rt.new_bool(false)
		}
		rt.call_function('add_action', [rt.new_string('install_plugins_favorites'),
			rt.new_string('install_plugins_favorites_form'), rt.new_int(9),
			rt.new_int(0)])
	} else {
		var_args = rt.new_bool(false)
	}
	var_args = rt.call_function('apply_filters', [
		rt.new_string('install_plugins_table_api_args_${var_tab.to_string()}'),
		var_args.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args)))) {
		return
	}
	mut var_api := rt.call_function('plugins_api', [rt.new_string('query_plugins'),
		var_args.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
		this.error = var_api.clone()
		return
	}
	this.dispatch_set_prop('items', rt.get_property(var_api, 'plugins'))
	if rt.is_true(this.orderby) {
		rt.call_function('uasort', [
			rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
				'WP_List_Table',
			], &this), 'items'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Plugin_Install_List_Table', [
					'WP_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'order_callback' },
			]),
		])
	}
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{
			key: 'total_items'
			val: rt.get_property(var_api, 'info').array_get(rt.new_string('results'))
		},
		rt.ArrayItem{ key: 'per_page', val: var_args.array_get(rt.new_string('per_page')) },
	]))
	if rt.get_property(var_api, 'info').array_isset(rt.new_string('groups')) {
		this.groups = rt.get_property(var_api, 'info').array_get(rt.new_string('groups'))
	}
	if rt.is_true(var_installed_plugins) {
		mut var_js_plugins := rt.call_function('array_fill_keys', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'all' },
				rt.ArrayItem{ key: none, val: 'search' }, rt.ArrayItem{ key: none, val: 'active' },
				rt.ArrayItem{ key: none, val: 'inactive' }, rt.ArrayItem{
					key: none
					val: 'recently_activated'
				}, rt.ArrayItem{ key: none, val: 'mustuse' },
				rt.ArrayItem{ key: none, val: 'dropins' }]),
			rt.new_array(),
		])
		var_js_plugins.array_set('all', rt.call_function('array_values', [
			rt.call_function('wp_list_pluck', [var_installed_plugins.clone(),
				rt.new_string('plugin')]),
		]))
		mut var_upgrade_plugins := rt.call_function('wp_filter_object_list', [
			var_installed_plugins.clone(), rt.create_array([
				rt.ArrayItem{ key: 'upgrade', val: true },
			]),
			rt.new_string('and'), rt.new_string('plugin')])
		if rt.is_true(var_upgrade_plugins) {
			var_js_plugins.array_set('upgrade', rt.call_function('array_values', [
				var_upgrade_plugins.clone(),
			]))
		}
		rt.call_function('wp_localize_script', [rt.new_string('updates'),
			rt.new_string('_wpUpdatesItemCounts'),
			rt.create_array([
				rt.ArrayItem{ key: 'plugins', val: var_js_plugins },
				rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data',
					[]rt.PhpVal{}) },
			])])
	}
}

fn (mut this Class_WP_Plugin_Install_List_Table) no_items() {
	if !(this.error).is_null() {
		mut var_error_message := rt.new_string('<p>' +
			(rt.call_method(this.error, 'get_error_message', []rt.PhpVal{})).str() + '</p>')
		var_error_message = rt.concat(var_error_message, rt.new_string(
			'<p class="hide-if-no-js"><button class="button try-again">' +
			(rt.call_function('__', [rt.new_string('Try Again')])).str() + '</button></p>'))
		rt.call_function('wp_admin_notice', [var_error_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'inline' },
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
				rt.ArrayItem{ key: 'paragraph_wrap', val: false },
			])])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('No plugins found. Try a different search.'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_views() rt.PhpVal {
	mut var_tabs := rt.new_null()
	mut var_tab := rt.new_null()
	mut var_display_tabs := rt.new_array()
	mut iter_3 := rt.cast_array(var_tabs).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_text := item_3.val
		mut var_action := item_3.key
		var_display_tabs['plugin-install-' + var_action.str()] = rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('self_admin_url', [
				rt.new_string('plugin-install.php?tab=' + var_action.str()),
			]) },
			rt.ArrayItem{ key: 'label', val: var_text },
			rt.ArrayItem{ key: 'current', val: rt.identical(var_action, var_tab) },
		])
	}
	var_display_tabs.delete('plugin-install-upload')
	return this.get_views_links(var_display_tabs.clone())
}

fn (mut this Class_WP_Plugin_Install_List_Table) views() {
	mut var_views := this.get_views()
	var_views = rt.call_function('apply_filters', [
		rt.concat(rt.new_string('views_'), rt.get_property(rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'id')),
		var_views.clone(),
	])
	rt.call_method(rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'render_screen_reader_content', [
		rt.new_string('heading_views'),
	])
	rt.call_function('printf', [
		rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Plugins extend and expand the functionality of WordPress. You may install plugins from the <a href="%s">WordPress Plugin Directory</a> right on this page, or upload a plugin in .zip format by clicking the button above.')])).str() +
			'</p>'),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/plugins/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_views)) {
		mut iter_4 := var_views.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_view := item_4.val
			mut var_class := item_4.key
			var_views.array_set(var_class,
				"\t<li class='${var_class.to_string()}'>${var_view.to_string()}")
		}
		print((rt.call_function('implode', [rt.new_string(' </li>\n'), var_views.clone()])).str() +
			'</li>\n')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('install_search_form', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Plugin_Install_List_Table) display() {
	mut var_singular := rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
		'WP_List_Table',
	], &this), '_args').array_get(rt.new_string('singular'))
	mut var_data_attr := rt.new_string('')
	if rt.is_true(var_singular) {
		var_data_attr = rt.new_string(" data-wp-lists='list:${var_singular.to_string()}'")
	}
	this.display_tablenav(rt.new_string('top'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
		this.get_table_classes()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'render_screen_reader_content', [rt.new_string('heading_list')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data_attr)
	// unsupported statement: Stmt_InlineHTML
	this.display_rows_or_placeholder()
	// unsupported statement: Stmt_InlineHTML
	this.display_tablenav(rt.new_string('bottom'))
}

fn (mut this Class_WP_Plugin_Install_List_Table) display_tablenav(var_which rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('featured'),
		var_GLOBALS.array_get(rt.new_string('tab'))))
	{
		return
	}
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('wp_referer_field', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('install_plugins_table_header')])
		// unsupported statement: Stmt_InlineHTML
		this.pagination(var_which.clone())
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		this.pagination(var_which.clone())
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_table_classes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'widefat' },
		rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
			'WP_List_Table',
		], &this), '_args').array_get(rt.new_string('plural')) }])
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_columns() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_Plugin_Install_List_Table) order_callback(var_plugin_a rt.PhpVal, var_plugin_b rt.PhpVal) i64 {
	mut var_orderby := this.orderby
	if !(
		!(rt.get_property(var_plugin_a, '{"nodeType":"Expr_Variable","line":454,"name":"orderby"}')).is_null()
		&& !(rt.get_property(var_plugin_b, '{"nodeType":"Expr_Variable","line":454,"name":"orderby"}')).is_null()) {
		return 0
	}
	mut var_a := rt.get_property(var_plugin_a,
		'{"nodeType":"Expr_Variable","line":458,"name":"orderby"}')
	mut var_b := rt.get_property(var_plugin_b,
		'{"nodeType":"Expr_Variable","line":459,"name":"orderby"}')
	return (if rt.is_true(rt.identical(rt.new_string('DESC'), this.order)) {
		rt.new_null()
	} else {
		rt.new_null()
	}).to_i64()
}

fn (mut this Class_WP_Plugin_Install_List_Table) display_rows() {
	mut var_plugins_allowedtags := {
		'a':       {
			'href':   rt.new_array()
			'title':  rt.new_array()
			'target': rt.new_array()
		}
		'abbr':    {
			'title': rt.new_array()
		}
		'acronym': {
			'title': rt.new_array()
		}
		'code':    rt.new_array()
		'pre':     rt.new_array()
		'em':      rt.new_array()
		'strong':  rt.new_array()
		'ul':      rt.new_array()
		'ol':      rt.new_array()
		'li':      rt.new_array()
		'p':       rt.new_array()
		'br':      rt.new_array()
	}
	mut var_plugins_group_titles := rt.create_array([
		rt.ArrayItem{ key: 'Performance', val: rt.call_function('_x', [
			rt.new_string('Performance'),
			rt.new_string('Plugin installer group title'),
		]) },
		rt.ArrayItem{ key: 'Social', val: rt.call_function('_x', [
			rt.new_string('Social'),
			rt.new_string('Plugin installer group title'),
		]) },
		rt.ArrayItem{ key: 'Tools', val: rt.call_function('_x', [
			rt.new_string('Tools'),
			rt.new_string('Plugin installer group title'),
		]) },
	])
	mut var_group := rt.new_null()
	mut iter_5 := rt.cast_array(rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
		'WP_List_Table',
	], &this), 'items')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_plugin := item_5.val
		if rt.is_true(rt.new_bool(var_plugin.clone().is_object())) {
			var_plugin = rt.cast_array(var_plugin)
		}
		if var_plugin.array_isset(rt.new_string('group'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_plugin.array_get(rt.new_string('group')), var_group)))) {
			if this.groups.array_isset(var_plugin.array_get(rt.new_string('group'))) {
				mut var_group_name :=
					this.groups.array_get(var_plugin.array_get(rt.new_string('group')))
				if var_plugins_group_titles.array_isset(var_group_name) {
					var_group_name = var_plugins_group_titles.array_get(var_group_name)
				}
			} else {
				var_group_name = var_plugin.array_get(rt.new_string('group'))
			}
			if !(!rt.is_true(var_group)) {
				print('</div></div>')
			}
			print('<div class="plugin-group"><h3>' +
				(rt.call_function('esc_html', [var_group_name.clone()])).str() + '</h3>')
			print('<div class="plugin-items">')
			var_group = var_plugin.array_get(rt.new_string('group'))
		}
		mut var_title := rt.call_function('wp_kses', [
			var_plugin.array_get(rt.new_string('name')),
			rt.create_array_from_native_map(var_plugins_allowedtags),
		])
		mut var_description := rt.call_function('strip_tags', [
			var_plugin.array_get(rt.new_string('short_description')),
		])
		var_description = rt.call_function('apply_filters', [
			rt.new_string('plugin_install_description'),
			var_description.clone(),
			var_plugin.clone(),
		])
		mut var_version := rt.call_function('wp_kses', [
			var_plugin.array_get(rt.new_string('version')),
			rt.create_array_from_native_map(var_plugins_allowedtags),
		])
		mut var_name := rt.call_function('strip_tags', [
			rt.new_string(var_title.str() + ' ' + var_version.str()),
		])
		mut var_author := rt.call_function('wp_kses', [
			var_plugin.array_get(rt.new_string('author')),
			rt.create_array_from_native_map(var_plugins_allowedtags),
		])
		if !(!rt.is_true(var_author)) {
			var_author = rt.new_string(' <cite>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('By %s')]), var_author.clone()])).str() +
				'</cite>')
		}
		mut var_requires_php := if !(var_plugin.array_get(rt.new_string('requires_php'))).is_null() {
			var_plugin.array_get(rt.new_string('requires_php'))
		} else {
			rt.new_null()
		}
		mut var_requires_wp := if !(var_plugin.array_get(rt.new_string('requires'))).is_null() {
			var_plugin.array_get(rt.new_string('requires'))
		} else {
			rt.new_null()
		}
		mut var_compatible_php := rt.call_function('is_php_version_compatible', [
			var_requires_php.clone(),
		])
		mut var_compatible_wp := rt.call_function('is_wp_version_compatible', [
			var_requires_wp.clone(),
		])
		mut var_tested_wp := rt.new_bool(!rt.is_true(var_plugin.array_get(rt.new_string('tested')))
			|| rt.is_true(rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), var_plugin.array_get(rt.new_string('tested')), rt.new_string('<=')])))
		mut var_action_links := rt.new_array()
		var_action_links.array_push(rt.call_function('wp_get_plugin_action_button', [
			var_name.clone(),
			var_plugin.clone(),
			var_compatible_php.clone(),
			var_compatible_wp.clone(),
		]))
		mut var_details_link := rt.call_function('self_admin_url', [
			rt.new_string('plugin-install.php?tab=plugin-information&amp;plugin=' +
				(var_plugin.array_get(rt.new_string('slug'))).str() + '&amp;TB_iframe=true&amp;width=600&amp;height=550'),
		])
		var_action_links.array_push(rt.call_function('sprintf', [
			rt.new_string('<a href="%s" class="thickbox open-plugin-details-modal" aria-label="%s" data-title="%s">%s</a>'),
			rt.call_function('esc_url', [var_details_link.clone()]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('More information about %s')]),
					var_name.clone(),
				]),
			]),
			rt.call_function('esc_attr', [
				var_name.clone(),
			]),
			rt.call_function('__', [
				rt.new_string('More Details'),
			]),
		]))
		if !(!rt.is_true(var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('svg')))) {
			mut var_plugin_icon_url :=
				var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('svg'))
		} else if !(!rt.is_true(var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('2x')))) {
			var_plugin_icon_url =
				var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('2x'))
		} else if !(!rt.is_true(var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('1x')))) {
			var_plugin_icon_url =
				var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('1x'))
		} else {
			var_plugin_icon_url =
				var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('default'))
		}
		var_action_links = rt.call_function('apply_filters', [
			rt.new_string('plugin_install_action_links'),
			var_action_links.clone(),
			var_plugin.clone(),
		])
		mut var_last_updated_timestamp := rt.call_function('strtotime', [
			var_plugin.array_get(rt.new_string('last_updated')),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('sanitize_html_class', [
			var_plugin.array_get(rt.new_string('slug')),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
			mut var_incompatible_notice_message := rt.new_string('')
			if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
				var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('__', [
					rt.new_string('This plugin does not work with your versions of WordPress and PHP.'),
				]))
				if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str()),
						rt.call_function('self_admin_url', [
							rt.new_string('update-core.php'),
						]),
						rt.call_function('esc_url', [
							rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
						]),
					]))
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('wp_update_php_annotation', [
						rt.new_string('</p><p><em>'),
						rt.new_string('</em>'),
						rt.new_bool(false),
					]))
				} else if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_core'),
				]))
				{
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
						rt.call_function('self_admin_url', [
							rt.new_string('update-core.php'),
						]),
					]))
				} else if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_php'),
				]))
				{
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
						rt.call_function('esc_url', [
							rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
						]),
					]))
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('wp_update_php_annotation', [
						rt.new_string('</p><p><em>'),
						rt.new_string('</em>'),
						rt.new_bool(false),
					]))
				}
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
				var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('__', [
					rt.new_string('This plugin does not work with your version of WordPress.'),
				]))
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_core'),
				]))
				{
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
						rt.call_function('self_admin_url', [
							rt.new_string('update-core.php'),
						]),
					]))
				}
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
				var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('__', [
					rt.new_string('This plugin does not work with your version of PHP.'),
				]))
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_php'),
				]))
				{
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
						rt.call_function('esc_url', [
							rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
						]),
					]))
					var_incompatible_notice_message = rt.concat(var_incompatible_notice_message, rt.call_function('wp_update_php_annotation', [
						rt.new_string('</p><p><em>'),
						rt.new_string('</em>'),
						rt.new_bool(false),
					]))
				}
			}
			rt.call_function('wp_admin_notice', [var_incompatible_notice_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'notice-alt' },
						rt.ArrayItem{ key: none, val: 'inline' },
					]) }])])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_details_link.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_title)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_plugin_icon_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_action_links) {
			print('<ul class="plugin-action-buttons"><li>' +
				(rt.call_function('implode', [rt.new_string('</li><li>'), var_action_links.clone()])).str() +
				'</li></ul>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_description)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_author)
		// unsupported statement: Stmt_InlineHTML
		mut var_dependencies_notice :=
			rt.new_string(this.get_dependencies_notice(var_plugin.clone()))
		if !(!rt.is_true(var_dependencies_notice)) {
			rt.echo_val(var_dependencies_notice)
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_star_rating', [
			rt.create_array([
				rt.ArrayItem{ key: 'rating', val: var_plugin.array_get(rt.new_string('rating')) },
				rt.ArrayItem{ key: 'type', val: 'percent' },
				rt.ArrayItem{ key: 'number', val: var_plugin.array_get(rt.new_string('num_ratings')) },
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('number_format_i18n', [
			var_plugin.array_get(rt.new_string('num_ratings')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Last Updated:')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('%s ago')]),
			rt.call_function('human_time_diff', [var_last_updated_timestamp.clone()])])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.greater_equal(var_plugin.array_get(rt.new_string('active_installs')),
			rt.new_int(1000000)))
		{
			mut var_active_installs_millions := rt.call_function('floor', [
				rt.div(var_plugin.array_get(rt.new_string('active_installs')), rt.new_int(1000000)),
			])
			mut var_active_installs_text := rt.call_function('sprintf', [
				rt.call_function('_nx', [rt.new_string('%s+ Million'),
					rt.new_string('%s+ Million'), var_active_installs_millions.clone(),
					rt.new_string('Active plugin installations')]),
				rt.call_function('number_format_i18n', [var_active_installs_millions.clone()]),
			])
		} else if rt.is_true(rt.identical(rt.new_int(0),
			var_plugin.array_get(rt.new_string('active_installs'))))
		{
			var_active_installs_text = rt.call_function('_x', [
				rt.new_string('Less Than 10'),
				rt.new_string('Active plugin installations'),
			])
		} else {
			var_active_installs_text = rt.new_string(
				(rt.call_function('number_format_i18n', [var_plugin.array_get(rt.new_string('active_installs'))])).str() +
				'+')
		}
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('%s Active Installations')]),
			var_active_installs_text.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tested_wp)))) {
			print('<span class="compatibility-untested">' +
				(rt.call_function('__', [rt.new_string('Untested with your version of WordPress')])).str() +
				'</span>')
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
			print('<span class="compatibility-incompatible">' +
				(rt.call_function('__', [rt.new_string('<strong>Incompatible</strong> with your version of WordPress')])).str() +
				'</span>')
		} else {
			print('<span class="compatibility-compatible">' +
				(rt.call_function('__', [rt.new_string('<strong>Compatible</strong> with your version of WordPress')])).str() +
				'</span>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(var_group)) {
		print('</div></div>')
	}
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_dependencies_notice(var_plugin_data rt.PhpVal) string {
	if !rt.is_true(var_plugin_data.array_get(rt.new_string('requires_plugins'))) {
		return ''
	}
	mut var_no_name_markup :=
		rt.new_string('<div class="plugin-dependency"><span class="plugin-dependency-name">%s</span></div>')
	mut var_has_name_markup :=
		rt.new_string('<div class="plugin-dependency"><span class="plugin-dependency-name">%s</span> %s</div>')
	mut var_dependencies_list := rt.new_string('')
	mut iter_6 := var_plugin_data.array_get(rt.new_string('requires_plugins')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_dependency := item_6.val
		mut iife_temp_0 := Class_WP_Plugin_Dependencies{}
		mut iife_result_0 := iife_temp_0.get_dependency_data(var_dependency.clone())
		mut var_dependency_data := iife_result_0
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_dependency_data))))
			&& !(!rt.is_true(var_dependency_data.array_get(rt.new_string('name'))))
			&& !(!rt.is_true(var_dependency_data.array_get(rt.new_string('slug'))))
			&& !(!rt.is_true(var_dependency_data.array_get(rt.new_string('version')))) {
			mut var_more_details_link := this.get_more_details_link(var_dependency_data.array_get(rt.new_string('name')),
				var_dependency_data.array_get(rt.new_string('slug')))
			var_dependencies_list = rt.concat(var_dependencies_list, rt.call_function('sprintf', [
				var_has_name_markup.clone(),
				rt.call_function('esc_html', [var_dependency_data.array_get(rt.new_string('name'))]),
				var_more_details_link.clone(),
			]))
			continue
		}
		mut var_result := rt.call_function('plugins_api', [
			rt.new_string('plugin_information'),
			rt.create_array([rt.ArrayItem{ key: 'slug', val: var_dependency }]),
		])
		if !(!rt.is_true(rt.get_property(var_result, 'name'))) {
			var_more_details_link = this.get_more_details_link(rt.get_property(var_result, 'name'), rt.get_property(var_result,
				'slug'))
			var_dependencies_list = rt.concat(var_dependencies_list, rt.call_function('sprintf', [
				var_has_name_markup.clone(),
				rt.call_function('esc_html', [rt.get_property(var_result, 'name')]),
				var_more_details_link.clone(),
			]))
			continue
		}
		var_dependencies_list = rt.concat(var_dependencies_list, rt.call_function('sprintf', [
			var_no_name_markup.clone(),
			rt.call_function('esc_html', [var_dependency.clone()]),
		]))
	}
	mut var_dependencies_notice := rt.call_function('sprintf', [
		rt.new_string('<div class="plugin-dependencies notice notice-alt notice-info inline"><p class="plugin-dependencies-explainer-text">%s</p> %s</div>'),
		rt.new_string('<strong>' +
			(rt.call_function('__', [rt.new_string('Additional plugins are required')])).str() +
			'</strong>'),
		var_dependencies_list.clone(),
	])
	return var_dependencies_notice.str()
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_more_details_link(var_name rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	mut var_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'tab', val: 'plugin-information' },
			rt.ArrayItem{ key: 'plugin', val: var_slug }, rt.ArrayItem{
				key: 'TB_iframe'
				val: 'true'
			}, rt.ArrayItem{ key: 'width', val: '600' }, rt.ArrayItem{ key: 'height', val: '550' }]),
		rt.call_function('network_admin_url', [rt.new_string('plugin-install.php')]),
	])
	mut var_more_details_link := rt.call_function('sprintf', [
		rt.new_string('<a href="%1$s" class="more-details-link thickbox open-plugin-details-modal" aria-label="%2$s" data-title="%3$s">%4$s</a>'),
		rt.call_function('esc_url', [var_url.clone()]),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('More information about %s')]),
			rt.call_function('esc_html', [var_name_mutated.clone()]),
		]),
		rt.call_function('esc_attr', [
			var_name_mutated.clone(),
		]),
		rt.call_function('__', [
			rt.new_string('More Details'),
		]),
	])
	return var_more_details_link.clone()
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

fn create_wp_plugin_install_list_table(_args ...rt.PhpVal) &Class_WP_Plugin_Install_List_Table {
	mut obj := &Class_WP_Plugin_Install_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		order:         rt.new_string('ASC')
		orderby:       rt.new_null()
		groups:        rt.new_array()
		error:         rt.new_null()
	}
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_plugin_dependencies(_args ...rt.PhpVal) &Class_WP_Plugin_Dependencies {
	mut obj := &Class_WP_Plugin_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Plugin_Install_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'ajax_user_can' {
			return this.ajax_user_can()
		}
		'get_installed_plugins' {
			return this.get_installed_plugins()
		}
		'get_installed_plugin_slugs' {
			return this.get_installed_plugin_slugs()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_views' {
			return this.get_views()
		}
		'views' {
			this.views()
			return rt.new_null()
		}
		'display' {
			this.display()
			return rt.new_null()
		}
		'display_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'get_table_classes' {
			return this.get_table_classes()
		}
		'get_columns' {
			return this.get_columns()
		}
		'order_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.order_callback(dispatch_arg_0, dispatch_arg_1))
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'get_dependencies_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_dependencies_notice(dispatch_arg_0))
		}
		'get_more_details_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_more_details_link(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Plugin_Install_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order' { return this.order }
		'orderby' { return this.orderby }
		'groups' { return this.groups }
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Plugin_Install_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order' {
			this.order = val
			return true
		}
		'orderby' {
			this.orderby = val
			return true
		}
		'groups' {
			this.groups = val
			return true
		}
		'error' {
			this.error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WP_Plugin_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Plugin_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
