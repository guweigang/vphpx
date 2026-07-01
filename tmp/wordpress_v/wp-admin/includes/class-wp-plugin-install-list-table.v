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
		{
			mut iter_1 := rt.get_property(var_plugin_info, 'no_update').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_plugin := item_1.val
				if !(rt.get_property(var_plugin, 'slug')).is_null() {
					rt.set_property(var_plugin, 'upgrade', rt.new_bool(false))
					var_plugins.array_set(rt.get_property(var_plugin, 'slug'), var_plugin.dup())
				}
			}
		}
	}
	if !(rt.get_property(var_plugin_info, 'response')).is_null() {
		{
			mut iter_1 := rt.get_property(var_plugin_info, 'response').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_plugin := item_1.val
				if !(rt.get_property(var_plugin, 'slug')).is_null() {
					rt.set_property(var_plugin, 'upgrade', rt.new_bool(true))
					var_plugins.array_set(rt.get_property(var_plugin, 'slug'), var_plugin.dup())
				}
			}
		}
	}
	return var_plugins.dup()
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_installed_plugin_slugs() rt.PhpVal {
	return rt.func_array_keys(this.get_installed_plugins())
}

fn (mut this Class_WP_Plugin_Install_List_Table) prepare_items() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php',
		'4')
	// unsupported statement: Stmt_Global
	mut var_tab := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('tab'))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get('tab'),
		]) } else { rt.new_string('') }
	mut var_paged := this.get_pagenum()
	mut var_per_page := rt.new_int(rt.new_int(36))
	mut var_tabs := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('search'), var_tab)) {
		var_tabs.array_set('search', rt.call_function('__', [
			rt.new_string('Search Results'),
		]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('beta'), var_tab))
		|| rt.is_true(rt.call_function('str_contains', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.new_string('-')]))))
	{
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
		var_tabs.dup()])
	var_nonmenu_tabs = rt.call_function('apply_filters', [
		rt.new_string('install_plugins_nonmenu_tabs'),
		var_nonmenu_tabs.dup(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(var_tab)
		|| rt.is_true(rt.new_bool(!(var_tabs.array_isset(var_tab))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_tab.dup(), rt.cast_array(var_nonmenu_tabs), rt.new_bool(true)])))))))))
	{
		var_tab = rt.call_function('key', [var_tabs.dup()])
	}
	mut var_installed_plugins := this.get_installed_plugins()
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'page', val: var_paged },
		rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'locale', val: rt.call_function('get_user_locale',
			[]rt.PhpVal{}) }])
	mut switch_val_1 := var_tab
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('search'))) {
		mut var_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('type')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get('type'),
			]) } else { rt.new_string('term') }
		mut var_term := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get('s'),
			]) } else { rt.new_string('') }
		mut switch_val_2 := var_type
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('tag'))) {
			var_args.array_set('tag', rt.call_function('sanitize_title_with_dashes', [
				var_term.dup(),
			]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('term'))) {
			var_args.array_set('search', var_term.dup())
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('author'))) {
			var_args.array_set('author', var_term.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('featured')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('popular')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('new')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('beta'))) {
		var_args.array_set('browse', var_tab.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recommended'))) {
		var_args.array_set('browse', var_tab.dup())
		var_args.array_set('installed_plugins', rt.func_array_keys(var_installed_plugins.dup()))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('favorites'))) {
		mut var_action := rt.new_string('save_wporg_username_' +
			(rt.call_function('get_current_user_id', []rt.PhpVal{})).str())
		if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))
			&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('_wpnonce')]), var_action.dup()]))))
		{
			mut var_user := if rt.get_superglobal('_GET').array_isset(rt.new_string('user')) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get('user'),
				]) } else { rt.call_function('get_user_option', [
					rt.new_string('wporg_favorites'),
				]) }
			if rt.is_true(rt.new_bool(
				!(rt.get_superglobal('_GET').array_isset(rt.new_string('save')))
				|| rt.is_true(rt.get_superglobal('_GET').array_get('save'))))
			{
				rt.call_function('update_user_meta', [
					rt.call_function('get_current_user_id', []rt.PhpVal{}),
					rt.new_string('wporg_favorites'),
					var_user.dup(),
				])
			}
		} else {
			var_user = rt.call_function('get_user_option', [
				rt.new_string('wporg_favorites'),
			])
		}
		if rt.is_true(var_user) {
			var_args.array_set('user', var_user.dup())
		} else {
			var_args = rt.new_bool(rt.new_bool(false))
		}
		rt.call_function('add_action', [rt.new_string('install_plugins_favorites'),
			rt.new_string('install_plugins_favorites_form'), rt.new_int(9),
			rt.new_int(0)])
	} else {
		var_args = rt.new_bool(rt.new_bool(false))
	}
	var_args = rt.call_function('apply_filters', [
		rt.new_string('install_plugins_table_api_args_${var_tab.to_string()}'),
		var_args.dup(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args)))) {
		return rt.new_null()
	}
	mut var_api := rt.call_function('plugins_api', [rt.new_string('query_plugins'),
		var_args.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.dup()])) {
		this.error = var_api.dup()
		return rt.new_null()
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
		rt.ArrayItem{ key: 'total_items', val: rt.get_property(var_api, 'info').array_get('results') },
		rt.ArrayItem{ key: 'per_page', val: var_args.array_get('per_page') },
	]))
	if rt.get_property(var_api, 'info').array_isset(rt.new_string('groups')) {
		this.groups = rt.get_property(var_api, 'info').array_get('groups')
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
			rt.call_function('wp_list_pluck', [var_installed_plugins.dup(),
				rt.new_string('plugin')]),
		]))
		mut var_upgrade_plugins := rt.call_function('wp_filter_object_list', [
			var_installed_plugins.dup(), rt.create_array([
				rt.ArrayItem{ key: 'upgrade', val: true },
			]),
			rt.new_string('and'), rt.new_string('plugin')])
		if rt.is_true(var_upgrade_plugins) {
			var_js_plugins.array_set('upgrade', rt.call_function('array_values', [
				var_upgrade_plugins.dup(),
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
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('wp_admin_notice', [var_error_message.dup(),
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
	// unsupported statement: Stmt_Global
	mut var_display_tabs := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_tabs).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_text := item_1.val
			mut var_action := item_1.key
			var_display_tabs['plugin-install-' + var_action.str()] = rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('self_admin_url', [
					'plugin-install.php?tab=' + var_action.str(),
				]) },
				rt.ArrayItem{ key: 'label', val: var_text },
				rt.ArrayItem{ key: 'current', val: rt.identical(var_action, var_tab) },
			])
		}
	}
	var_display_tabs.delete('plugin-install-upload')
	return this.get_views_links(var_display_tabs.dup())
}

fn (mut this Class_WP_Plugin_Install_List_Table) views() {
	mut var_views := this.get_views()
	var_views = rt.call_function('apply_filters', [
		rt.concat(rt.new_string('views_'), rt.get_property(rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'id')),
		var_views.dup(),
	])
	rt.call_method(rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'render_screen_reader_content', [
		rt.new_string('heading_views'),
	])
	rt.call_function('printf', [
		'<p>' +
			(rt.call_function('__', [rt.new_string('Plugins extend and expand the functionality of WordPress. You may install plugins from the <a href="%s">WordPress Plugin Directory</a> right on this page, or upload a plugin in .zip format by clicking the button above.')])).str() +
			'</p>',
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/plugins/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_views)) {
		{
			mut iter_1 := var_views.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_view := item_1.val
				mut var_class := item_1.key
				var_views.array_set(var_class,
					"\t<li class='${var_class.to_string()}'>${var_view.to_string()}")
			}
		}
		print((rt.call_function('implode', [rt.new_string(' </li>\n'), var_views.dup()])).str() +
			'</li>\n')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('install_search_form', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Plugin_Install_List_Table) display() {
	mut var_singular := rt.get_property(rt.new_object('WP_Plugin_Install_List_Table', [
		'WP_List_Table',
	], &this), '_args').array_get('singular')
	mut var_data_attr := rt.new_string(rt.new_string(''))
	if rt.is_true(var_singular) {
		var_data_attr =
			rt.new_string(rt.new_string(" data-wp-lists='list:${var_singular.to_string()}'"))
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
}

fn (mut this Class_WP_Plugin_Install_List_Table) display_tablenav(var_which rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_table_classes() rt.PhpVal {
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_columns() rt.PhpVal {
}

fn (mut this Class_WP_Plugin_Install_List_Table) order_callback(var_plugin_a rt.PhpVal, var_plugin_b rt.PhpVal) i64 {
}

fn (mut this Class_WP_Plugin_Install_List_Table) display_rows() {
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_dependencies_notice(var_plugin_data rt.PhpVal) string {
}

fn (mut this Class_WP_Plugin_Install_List_Table) get_more_details_link(var_name rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_plugin_install_list_table() &Class_WP_Plugin_Install_List_Table {
	mut obj := &Class_WP_Plugin_Install_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		order:         rt.new_string('ASC')
		orderby:       rt.new_null()
		groups:        rt.new_array()
		error:         rt.new_null()
	}
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
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

pub fn init_wp_admin_includes_class_wp_plugin_install_list_table_php() {
}
