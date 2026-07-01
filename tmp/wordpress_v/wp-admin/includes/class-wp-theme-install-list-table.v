import rt

struct Class_WP_Theme_Install_List_Table {
	rt.PhpObjectBase
pub mut:
	features rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Theme_Install_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('install_themes')])
}

fn (mut this Class_WP_Theme_Install_List_Table) prepare_items() {
	mut var_theme_field_defaults := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme-install.php', '3')
	// unsupported statement: Stmt_Global
	mut var_tab := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('tab'))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get('tab'),
		]) } else { rt.new_string('') }
	mut var_search_terms := rt.new_array()
	mut var_search_string := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s'))) {
		var_search_string = rt.new_string(rt.new_string(rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get('s'),
		]).to_string().to_lower()))
		var_search_terms = rt.call_function('array_unique', [
			rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_string('trim'),
					rt.call_function('explode', [rt.new_string(','),
						var_search_string.dup()])]),
			]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('features'))) {
		this.features = rt.get_superglobal('_REQUEST').array_get('features')
	}
	mut var_paged := this.get_pagenum()
	mut var_per_page := rt.new_int(rt.new_int(36))
	mut var_tabs := rt.new_array()
	var_tabs.array_set('dashboard', rt.call_function('__', [rt.new_string('Search')]))
	if rt.is_true(rt.identical(rt.new_string('search'), var_tab)) {
		var_tabs.array_set('search', rt.call_function('__', [
			rt.new_string('Search Results'),
		]))
	}
	var_tabs.array_set('upload', rt.call_function('_x', [rt.new_string('Upload'),
		rt.new_string('noun')]))
	var_tabs.array_set('featured', rt.call_function('_x', [rt.new_string('Featured'),
		rt.new_string('themes')]))
	var_tabs.array_set('new', rt.call_function('_x', [rt.new_string('Latest'),
		rt.new_string('themes')]))
	var_tabs.array_set('updated', rt.call_function('_x', [
		rt.new_string('Recently Updated'),
		rt.new_string('themes'),
	]))
	mut var_nonmenu_tabs := rt.create_array([
		rt.ArrayItem{ key: none, val: 'theme-information' },
	])
	var_tabs = rt.call_function('apply_filters', [rt.new_string('install_themes_tabs'),
		var_tabs.dup()])
	var_nonmenu_tabs = rt.call_function('apply_filters', [
		rt.new_string('install_themes_nonmenu_tabs'),
		var_nonmenu_tabs.dup(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(var_tab)
		|| rt.is_true(rt.new_bool(!(var_tabs.array_isset(var_tab))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_tab.dup(), rt.cast_array(var_nonmenu_tabs), rt.new_bool(true)])))))))))
	{
		var_tab = rt.call_function('key', [var_tabs.dup()])
	}
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'page', val: var_paged },
		rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{
			key: 'fields'
			val: var_theme_field_defaults
		}])
	mut switch_val_1 := var_tab
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('search'))) {
		mut var_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('type')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get('type'),
			]) } else { rt.new_string('term') }
		mut switch_val_2 := var_type
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('tag'))) {
			var_args.array_set('tag', rt.call_function('array_map', [
				rt.new_string('sanitize_key'),
				var_search_terms.dup(),
			]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('term'))) {
			var_args.array_set('search', var_search_string.dup())
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('author'))) {
			var_args.array_set('author', var_search_string.dup())
		}
		if !(!rt.is_true(this.features)) {
			var_args.array_set('tag', this.features)
			rt.get_superglobal('_REQUEST').array_set('s', rt.call_function('implode', [
				rt.new_string(','),
				this.features,
			]))
			rt.get_superglobal('_REQUEST').array_set('type', 'tag')
		}
		rt.call_function('add_action', [rt.new_string('install_themes_table_header'),
			rt.new_string('install_theme_search_form'), rt.new_int(10),
			rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('featured')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('new')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('updated'))) {
		var_args.array_set('browse', var_tab.dup())
	} else {
		var_args = rt.new_bool(rt.new_bool(false))
	}
	var_args = rt.call_function('apply_filters', [
		rt.new_string('install_themes_table_api_args_${var_tab.to_string()}'),
		var_args.dup(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args)))) {
		return rt.new_null()
	}
	mut var_api := rt.call_function('themes_api', [rt.new_string('query_themes'),
		var_args.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.dup()])) {
		rt.call_function('wp_die', [
			'<p>' + (rt.call_method(var_api, 'get_error_message', []rt.PhpVal{})).str() +
				'</p> <p><a href="#" onclick="document.location.reload(); return false;">' +
				(rt.call_function('__', [rt.new_string('Try Again')])).str() + '</a></p>',
		])
	}
	this.dispatch_set_prop('items', rt.get_property(var_api, 'themes'))
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: rt.get_property(var_api, 'info').array_get('results') },
		rt.ArrayItem{ key: 'per_page', val: var_args.array_get('per_page') },
		rt.ArrayItem{ key: 'infinite_scroll', val: true },
	]))
}

fn (mut this Class_WP_Theme_Install_List_Table) no_items() {
	rt.call_function('_e', [rt.new_string('No themes match your request.')])
}

fn (mut this Class_WP_Theme_Install_List_Table) get_views() rt.PhpVal {
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
			var_display_tabs['theme-install-' + var_action.str()] = rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('self_admin_url', [
					'theme-install.php?tab=' + var_action.str(),
				]) },
				rt.ArrayItem{ key: 'label', val: var_text },
				rt.ArrayItem{ key: 'current', val: rt.identical(var_action, var_tab) },
			])
		}
	}
	return this.get_views_links(var_display_tabs.dup())
}

fn (mut this Class_WP_Theme_Install_List_Table) display() {
	rt.call_function('wp_nonce_field', [
		'fetch-list-' +(rt.call_function('get_class', [rt.new_object('WP_Theme_Install_List_Table', ['WP_Themes_List_Table'], &this)])).str(),
		rt.new_string('_ajax_fetch_list_nonce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('install_themes_table_header')])
	// unsupported statement: Stmt_InlineHTML
	this.pagination(rt.new_string('top'))
	// unsupported statement: Stmt_InlineHTML
	this.display_rows_or_placeholder()
	// unsupported statement: Stmt_InlineHTML
	this.tablenav(rt.new_string('bottom'))
}

fn (mut this Class_WP_Theme_Install_List_Table) display_rows() {
	mut var_themes := rt.get_property(rt.new_object('WP_Theme_Install_List_Table', [
		'WP_Themes_List_Table',
	], &this), 'items')
	{
		mut iter_1 := var_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme := item_1.val
			// unsupported statement: Stmt_InlineHTML
			this.single_row(var_theme.dup())
			// unsupported statement: Stmt_InlineHTML
		}
	}
	this.theme_installer()
}

fn (mut this Class_WP_Theme_Install_List_Table) single_row(var_theme rt.PhpVal) {
	mut var_themes_allowedtags := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_theme) {
		return rt.new_null()
	}
	mut var_name := rt.call_function('wp_kses', [rt.get_property(var_theme, 'name'),
		var_themes_allowedtags.dup()])
	mut var_author := rt.call_function('wp_kses', [rt.get_property(var_theme, 'author'),
		var_themes_allowedtags.dup()])
	mut var_preview_title := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Preview &#8220;%s&#8221;')]),
		var_name.dup(),
	])
	mut var_preview_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'tab', val: 'theme-information' },
			rt.ArrayItem{ key: 'theme', val: rt.get_property(var_theme, 'slug') }]),
		rt.call_function('self_admin_url', [rt.new_string('theme-install.php')]),
	])
	mut var_actions := rt.new_array()
	mut var_install_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'action', val: 'install-theme' },
			rt.ArrayItem{ key: 'theme', val: rt.get_property(var_theme, 'slug') }]),
		rt.call_function('self_admin_url', [rt.new_string('update.php')]),
	])
	mut var_update_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'action', val: 'upgrade-theme' },
			rt.ArrayItem{ key: 'theme', val: rt.get_property(var_theme, 'slug') }]),
		rt.call_function('self_admin_url', [rt.new_string('update.php')]),
	])
	mut var_status := this._get_theme_status(var_theme.dup())
	mut switch_val_3 := var_status
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('update_available'))) {
		var_actions.array_push(rt.call_function('sprintf', [
			rt.new_string('<a class="install-now" href="%s" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [var_update_url.dup(),
					'upgrade-theme_' + (rt.get_property(var_theme, 'slug')).str()]),
			]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Update to version %s')]),
					rt.get_property(var_theme, 'version'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Update'),
			]),
		]))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('newer_installed')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('latest_installed'))) {
		var_actions.array_push(rt.call_function('sprintf', [
			rt.new_string('<span class="install-now">%s</span>'),
			rt.call_function('_x', [rt.new_string('Installed'),
				rt.new_string('theme')]),
		]))
	} else {
		var_actions.array_push(rt.call_function('sprintf', [
			rt.new_string('<a class="install-now" href="%s" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [var_install_url.dup(),
					'install-theme_' + (rt.get_property(var_theme, 'slug')).str()]),
			]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Install %s'),
						rt.new_string('theme')]),
					var_name.dup(),
				]),
			]),
			rt.call_function('_x', [
				rt.new_string('Install Now'),
				rt.new_string('theme'),
			]),
		]))
	}
	var_actions.array_push(rt.call_function('sprintf', [
		rt.new_string('<a class="install-theme-preview" href="%s" aria-label="%s">%s</a>'),
		rt.call_function('esc_url', [var_preview_url.dup()]),
		rt.call_function('esc_attr', [var_preview_title.dup()]),
		rt.call_function('_x', [rt.new_string('Preview'), rt.new_string('verb')]),
	]))
	var_actions = rt.call_function('apply_filters', [
		rt.new_string('theme_install_actions'),
		var_actions.dup(),
		var_theme.dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_preview_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_preview_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		(rt.get_property(var_theme, 'screenshot_url')).str() + '?ver=' +
			(rt.get_property(var_theme, 'version')).str(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_name)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('By %s')]),
		var_author.dup()])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_action)
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Details')])
	// unsupported statement: Stmt_InlineHTML
	this.install_theme_info(var_theme.dup())
}

fn (mut this Class_WP_Theme_Install_List_Table) theme_installer() {
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Theme_Install_List_Table) theme_installer_single(var_theme rt.PhpVal) {
}

fn (mut this Class_WP_Theme_Install_List_Table) install_theme_info(var_theme rt.PhpVal) {
	mut var_themes_allowedtags := rt.new_null()
}

fn (mut this Class_WP_Theme_Install_List_Table) _js_vars(var_extra_args rt.PhpVal) {
	mut var_tab := rt.new_null()
	mut var_type := rt.new_null()
}

fn (mut this Class_WP_Theme_Install_List_Table) _get_theme_status(var_theme rt.PhpVal) rt.PhpVal {
}

struct Class_WP_Themes_List_Table {
	rt.PhpObjectBase
}

fn create_wp_theme_install_list_table() &Class_WP_Theme_Install_List_Table {
	mut obj := &Class_WP_Theme_Install_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		features:      rt.new_array()
	}
	return obj
}

fn create_wp_themes_list_table() &Class_WP_Themes_List_Table {
	mut obj := &Class_WP_Themes_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme_Install_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'ajax_user_can' {
			return this.ajax_user_can()
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
		'display' {
			this.display()
			return rt.new_null()
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row(dispatch_arg_0)
			return rt.new_null()
		}
		'theme_installer' {
			this.theme_installer()
			return rt.new_null()
		}
		'theme_installer_single' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.theme_installer_single(dispatch_arg_0)
			return rt.new_null()
		}
		'install_theme_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.install_theme_info(dispatch_arg_0)
			return rt.new_null()
		}
		'_js_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._js_vars(dispatch_arg_0)
			return rt.new_null()
		}
		'_get_theme_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._get_theme_status(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Theme_Install_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'features' { return this.features }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Theme_Install_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'features' {
			this.features = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Themes_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Themes_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Themes_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_admin_includes_class_wp_theme_install_list_table_php() {
}
