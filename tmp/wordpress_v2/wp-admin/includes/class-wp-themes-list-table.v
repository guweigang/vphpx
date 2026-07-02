import rt

struct Class_WP_Themes_List_Table {
	rt.PhpObjectBase
pub mut:
	search_terms rt.PhpVal = rt.new_array()
	features     rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Themes_List_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'ajax', val: true },
		rt.ArrayItem{
			key: 'screen'
			val: if !(var_args_mutated.array_get(rt.new_string('screen'))).is_null() {
				var_args_mutated.array_get(rt.new_string('screen'))
			} else {
				rt.new_null()
			}
		},
	]))
}

fn (mut this Class_WP_Themes_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('switch_themes')])
}

fn (mut this Class_WP_Themes_List_Table) prepare_items() {
	mut var_themes := rt.call_function('wp_get_themes', [
		rt.create_array([rt.ArrayItem{ key: 'allowed', val: true }]),
	])
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) {
		this.search_terms = rt.call_function('array_unique', [
			rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_string('trim'),
					rt.call_function('explode', [rt.new_string(','),
						rt.new_string(rt.call_function('wp_unslash', [
							rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')),
						]).to_string().to_lower())])]),
			]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('features')))) {
		this.features = rt.get_superglobal('_REQUEST').array_get(rt.new_string('features'))
	}
	if rt.is_true(this.search_terms) || rt.is_true(this.features) {
		mut iter_1 := var_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme := item_1.val
			mut var_key := item_1.key
			if !(this.search_theme(var_theme.clone())) {
				var_themes.array_unset(var_key)
			}
		}
	}
	var_themes.array_unset(rt.call_function('get_option', [rt.new_string('stylesheet')]))
	mut iife_temp_0 := Class_WP_Theme{}
	mut iife_result_0 := iife_temp_0.sort_by_name(var_themes.clone())
	mut var_per_page := rt.new_int(36)
	mut var_page := this.get_pagenum()
	mut var_start := rt.mul(rt.sub(var_page, rt.new_int(1)), var_per_page)
	this.dispatch_set_prop('items', rt.call_function('array_slice', [
		var_themes.clone(), var_start.clone(), var_per_page.clone(),
		rt.new_bool(true)]))
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: var_themes.clone().array_count() },
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'infinite_scroll', val: true },
	]))
}

fn (mut this Class_WP_Themes_List_Table) no_items() {
	if rt.is_true(this.search_terms) || rt.is_true(this.features) {
		rt.call_function('_e', [rt.new_string('No items found.')])
		return
	}
	mut var_blog_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])) {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('You only have one theme enabled for this site right now. Visit the Network Admin to <a href="%1$s">enable</a> or <a href="%2$s">install</a> more themes.'),
				]),
				rt.call_function('network_admin_url', [
					rt.new_string('site-themes.php?id=' + var_blog_id.str()),
				]),
				rt.call_function('network_admin_url', [
					rt.new_string('theme-install.php'),
				]),
			])
			return
		} else if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_themes'),
		]))
		{
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('You only have one theme enabled for this site right now. Visit the Network Admin to <a href="%s">enable</a> more themes.'),
				]),
				rt.call_function('network_admin_url', [
					rt.new_string('site-themes.php?id=' + var_blog_id.str()),
				]),
			])
			return
		}
	} else {
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('install_themes'),
		]))
		{
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('You only have one theme installed right now. Live a little! You can choose from over 1,000 free themes in the WordPress Theme Directory at any time: just click on the <a href="%s">Install Themes</a> tab above.'),
				]),
				rt.call_function('admin_url', [
					rt.new_string('theme-install.php'),
				]),
			])
			return
		}
	}
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Only the active theme is available to you. Contact the %s administrator for information about accessing additional themes.'),
		]),
		rt.call_function('get_site_option', [
			rt.new_string('site_name'),
		]),
	])
}

fn (mut this Class_WP_Themes_List_Table) tablenav(which string) {
	if rt.is_true(rt.less_equal(this.get_pagination_arg(rt.new_string('total_pages')),
		rt.new_int(1)))
	{
		return
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_which)
	// unsupported statement: Stmt_InlineHTML
	this.pagination(rt.new_string(which))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Themes_List_Table) display() {
	rt.call_function('wp_nonce_field', [
		rt.new_string('fetch-list-' +(rt.call_function('get_class', [rt.new_object('WP_Themes_List_Table', ['WP_List_Table'], &this)])).str()),
		rt.new_string('_ajax_fetch_list_nonce'),
	])
	// unsupported statement: Stmt_InlineHTML
	this.tablenav('top')
	// unsupported statement: Stmt_InlineHTML
	this.display_rows_or_placeholder()
	// unsupported statement: Stmt_InlineHTML
	this.tablenav('bottom')
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Themes_List_Table) get_columns() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_Themes_List_Table) display_rows_or_placeholder() {
	if rt.is_true(this.has_items()) {
		this.display_rows()
	} else {
		print('<div class="no-items">')
		this.no_items()
		print('</div>')
	}
}

fn (mut this Class_WP_Themes_List_Table) display_rows() {
	mut var_themes := rt.get_property(rt.new_object('WP_Themes_List_Table', [
		'WP_List_Table',
	], &this), 'items')
	mut iter_2 := var_themes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_theme := item_2.val
		// unsupported statement: Stmt_InlineHTML
		mut var_template := rt.call_method(var_theme, 'get_template', []rt.PhpVal{})
		mut var_stylesheet := rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
		mut var_title := rt.call_method(var_theme, 'display', [
			rt.new_string('Name')])
		mut var_version := rt.call_method(var_theme, 'display', [
			rt.new_string('Version'),
		])
		mut var_author := rt.call_method(var_theme, 'display', [
			rt.new_string('Author')])
		mut var_activate_link := rt.call_function('wp_nonce_url', [
			rt.new_string('themes.php?action=activate&amp;template=' +
				(rt.call_function('urlencode', [var_template.clone()])).str() + '&amp;stylesheet=' +
				(rt.call_function('urlencode', [var_stylesheet.clone()])).str()),
			rt.new_string('switch-theme_' + var_stylesheet.str()),
		])
		mut var_actions := rt.new_array()
		var_actions.array_set('activate', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" class="activatelink" aria-label="%s">%s</a>'),
			var_activate_link.clone(),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Activate &#8220;%s&#8221;'),
						rt.new_string('theme')]),
					var_title.clone(),
				]),
			]),
			rt.call_function('_x', [
				rt.new_string('Activate'),
				rt.new_string('theme'),
			]),
		]))
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
			var_actions.array_get(rt.new_string('preview')) = rt.concat(var_actions.array_get(rt.new_string('preview')), rt.call_function('sprintf', [
				rt.new_string('<a href="%s" class="load-customize hide-if-no-customize">%s</a>'),
				rt.call_function('wp_customize_url', [var_stylesheet.clone()]),
				rt.call_function('__', [rt.new_string('Live Preview')]),
			]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')])) {
			var_actions.array_set('delete', rt.call_function('sprintf', [
				rt.new_string('<a class="submitdelete deletion" href="%s" onclick="return confirm( \'%s\' );">%s</a>'),
				rt.call_function('wp_nonce_url', [
					rt.new_string('themes.php?action=delete&amp;stylesheet=' +
						(rt.call_function('urlencode', [var_stylesheet.clone()])).str()),
					rt.new_string('delete-theme_' + var_stylesheet.str()),
				]),
				rt.call_function('esc_js', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string("You are about to delete this theme '%s'\n  'Cancel' to stop, 'OK' to delete."),
						]),
						var_title.clone(),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('Delete'),
				]),
			]))
		}
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('theme_action_links'),
			var_actions.clone(),
			var_theme.clone(),
			rt.new_string('all'),
		])
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('theme_action_links_${var_stylesheet.to_string()}'),
			var_actions.clone(),
			var_theme.clone(),
			rt.new_string('all'),
		])
		mut var_delete_action := rt.new_string((if var_actions.array_isset(rt.new_string('delete')) {
			'<div class="delete-theme">' +
				(var_actions.array_get(rt.new_string('delete'))).str() + '</div>'
		} else {
			''
		}).str())
		var_actions.array_unset(rt.new_string('delete'))
		mut var_screenshot := rt.call_method(var_theme, 'get_screenshot', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_screenshot) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.new_string(var_screenshot.str() + '?ver=' +
					(rt.get_property(var_theme, 'version')).str()),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_customize_url', [var_stylesheet.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_screenshot) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.new_string(var_screenshot.str() + '?ver=' +
					(rt.get_property(var_theme, 'version')).str()),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_title)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('By %s')]),
			var_author.clone()])
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 := var_actions.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_action := item_3.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_action)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Details')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_delete_action)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('theme_update_available', [var_theme.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Version:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_version)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_method(var_theme, 'display', [rt.new_string('Description')]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_theme, 'parent', []rt.PhpVal{})) {
			rt.call_function('printf', [
				rt.new_string(' <p class="howto">' +
					(rt.call_function('__', [rt.new_string('This <a href="%1$s">child theme</a> requires its parent theme, %2$s.')])).str() +
					'</p>'),
				rt.call_function('__', [
					rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/'),
				]),
				rt.call_method(rt.call_method(var_theme, 'parent', []rt.PhpVal{}), 'display', [
					rt.new_string('Name'),
				]),
			])
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Themes_List_Table) search_theme(var_theme rt.PhpVal) bool {
	mut iter_4 := this.features.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_word := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_word.clone(), rt.call_method(var_theme, 'get', [
				rt.new_string('Tags')]),
			rt.new_bool(true)])))))
		{
			return false
		}
	}
	mut iter_5 := this.search_terms.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_word := item_5.val
		if rt.is_true(rt.call_function('in_array', [var_word.clone(),
			rt.call_method(var_theme, 'get', [rt.new_string('Tags')]),
			rt.new_bool(true)]))
		{
			continue
		}
		mut iter_6 := rt.create_array([rt.ArrayItem{ key: none, val: 'Name' },
			rt.ArrayItem{ key: none, val: 'Description' }, rt.ArrayItem{ key: none, val: 'Author' },
			rt.ArrayItem{ key: none, val: 'AuthorURI' }]).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_header := item_6.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
				rt.call_function('strip_tags', [
					rt.call_method(var_theme, 'display', [var_header.clone(),
						rt.new_bool(false), rt.new_bool(true)]),
				]),
				var_word.clone(),
			])))))
			{
				continue
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
			rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}),
			var_word.clone(),
		])))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
			rt.call_method(var_theme, 'get_template', []rt.PhpVal{}),
			var_word.clone(),
		])))))
		{
			continue
		}
		return false
	}
	return true
}

fn (mut this Class_WP_Themes_List_Table) _js_vars(var_extra_args rt.PhpVal) {
	mut var_search_string := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('esc_attr', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]),
		]) } else { rt.new_string('') }
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'search', val: var_search_string },
		rt.ArrayItem{ key: 'features', val: this.features },
		rt.ArrayItem{ key: 'paged', val: this.get_pagenum() },
		rt.ArrayItem{
			key: 'total_pages'
			val: if !(!rt.is_true(rt.get_property(rt.new_object('WP_Themes_List_Table', [
				'WP_List_Table',
			], &this), '_pagination_args').array_get(rt.new_string('total_pages')))) {
				rt.get_property(rt.new_object('WP_Themes_List_Table', [
					'WP_List_Table',
				], &this), '_pagination_args').array_get(rt.new_string('total_pages'))
			} else {
				rt.new_int(1)
			}
		},
	])
	if rt.is_true(rt.new_bool(var_extra_args.clone().is_array())) {
		var_args = rt.call_function('array_merge', [var_args.clone(),
			var_extra_args.clone()])
	}
	rt.call_function('printf', [
		rt.new_string('<script>var theme_list_args = %s;</script>\n'),
		rt.call_function('wp_json_encode', [var_args.clone(),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
	])
	this.Class_WP_List_Table._js_vars()
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_themes_list_table(arg_0 rt.PhpVal) &Class_WP_Themes_List_Table {
	mut obj := &Class_WP_Themes_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		search_terms:  rt.new_array()
		features:      rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme(_args ...rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Themes_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
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
		'tablenav' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'display' {
			this.display()
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'display_rows_or_placeholder' {
			this.display_rows_or_placeholder()
			return rt.new_null()
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'search_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.search_theme(dispatch_arg_0))
		}
		'_js_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._js_vars(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Themes_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'search_terms' { return this.search_terms }
		'features' { return this.features }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Themes_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'search_terms' {
			this.search_terms = val
			return true
		}
		'features' {
			this.features = val
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
}
