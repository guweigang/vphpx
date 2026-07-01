import rt

struct Class_WP_MS_Themes_List_Table {
	rt.PhpObjectBase
pub mut:
		site_id rt.PhpVal = rt.new_null()
		is_site_themes bool
		has_items bool
		show_autoupdates bool
}

fn (mut this Class_WP_MS_Themes_List_Table) construct(var_args rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'themes' }, rt.ArrayItem{ key: 'screen', val: if !(var_args.array_get('screen')).is_null() { var_args.array_get('screen') } else { rt.new_null() } }]))
	mut var_status := if !(rt.get_superglobal('_REQUEST').array_get('theme_status')).is_null() { rt.get_superglobal('_REQUEST').array_get('theme_status') } else { rt.new_string('all') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'enabled' }, rt.ArrayItem{ key: none, val: 'disabled' }, rt.ArrayItem{ key: none, val: 'upgrade' }, rt.ArrayItem{ key: none, val: 'search' }, rt.ArrayItem{ key: none, val: 'broken' }, rt.ArrayItem{ key: none, val: 'auto-update-enabled' }, rt.ArrayItem{ key: none, val: 'auto-update-disabled' }]), rt.new_bool(true)]))))) {
		var_status = rt.new_string(rt.new_string('all'))
	}
	mut var_page := this.get_pagenum()
	this.is_site_themes = if rt.is_true(rt.identical(rt.new_string('site-themes-network'), rt.get_property(rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'screen'), 'id'))) { true } else { false }
	if rt.is_true(this.is_site_themes) {
		this.site_id = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	}
	this.show_autoupdates = rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')])) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_site_themes)))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
}

fn (mut this Class_WP_MS_Themes_List_Table) get_table_classes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'widefat' }, rt.ArrayItem{ key: none, val: 'plugins' }])
}

fn (mut this Class_WP_MS_Themes_List_Table) ajax_user_can() rt.PhpVal {
	if rt.is_true(this.is_site_themes) {
		return rt.call_function('current_user_can', [rt.new_string('manage_sites')])
	} else {
		return rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])
	}
	return rt.new_null()
}

fn (mut this Class_WP_MS_Themes_List_Table) prepare_items()  {
	mut var_page := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_orderby := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('orderby'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('orderby')]) } else { rt.new_string('') }
	mut var_order := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('order'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('order')]) } else { rt.new_string('') }
	mut var_s := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('s')]) } else { rt.new_string('') }
	mut var_themes := rt.create_array([rt.ArrayItem{ key: 'all', val: rt.call_function('apply_filters', [rt.new_string('all_themes'), rt.call_function('wp_get_themes', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'search', val: rt.new_array() }, rt.ArrayItem{ key: 'enabled', val: rt.new_array() }, rt.ArrayItem{ key: 'disabled', val: rt.new_array() }, rt.ArrayItem{ key: 'upgrade', val: rt.new_array() }, rt.ArrayItem{ key: 'broken', val: if rt.is_true(this.is_site_themes) { rt.new_array() } else { rt.call_function('wp_get_themes', [rt.create_array([rt.ArrayItem{ key: 'errors', val: true }])]) } }])
	if rt.is_true(this.show_autoupdates) {
		mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [rt.new_string('auto_update_themes'), rt.new_array()]))
		var_themes.array_set('auto-update-enabled', rt.new_array())
		var_themes.array_set('auto-update-disabled', rt.new_array())
	}
	if rt.is_true(this.is_site_themes) {
		mut var_themes_per_page := this.get_items_per_page(rt.new_string('site_themes_network_per_page'))
		mut var_allowed_where := rt.new_string(rt.new_string('site'))
	} else {
		var_themes_per_page = this.get_items_per_page(rt.new_string('themes_network_per_page'))
		var_allowed_where = rt.new_string(rt.new_string('network'))
	}
	mut var_current := rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	mut var_maybe_update := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_site_themes)))))) && rt.is_true(var_current)))
	{
		mut iter_1 := rt.cast_array(var_themes.array_get('all')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(this.is_site_themes) && rt.is_true(rt.call_method(var_theme, 'is_allowed', [rt.new_string('network')])))) {
				var_themes.array_get('all').array_unset(var_key)
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_maybe_update) && rt.get_property(var_current, 'response').array_isset(var_key))) {
				rt.set_property(var_themes.array_get('all').array_get(var_key), 'update', rt.new_bool(true))
				var_themes.array_get_mut('upgrade').array_set(var_key, var_themes.array_get('all').array_get(var_key))
			}
			mut var_filter := rt.new_string(if rt.is_true(rt.call_method(var_theme, 'is_allowed', [var_allowed_where.dup(), this.site_id])) { rt.new_string('enabled') } else { rt.new_string('disabled') })
			var_themes.array_get_mut(var_filter).array_set(var_key, var_themes.array_get('all').array_get(var_key))
			mut var_theme_data := rt.create_array([rt.ArrayItem{ key: 'update_supported', val: if !(rt.get_property(var_theme, 'update_supported')).is_null() { rt.get_property(var_theme, 'update_supported') } else { rt.new_bool(true) } }])
			if rt.get_property(var_current, 'response').array_isset(var_key) {
				var_theme_data = rt.call_function('array_merge', [rt.cast_array(rt.get_property(var_current, 'response').array_get(var_key)), var_theme_data.dup()])
			} else if rt.get_property(var_current, 'no_update').array_isset(var_key) {
				var_theme_data = rt.call_function('array_merge', [rt.cast_array(rt.get_property(var_current, 'no_update').array_get(var_key)), var_theme_data.dup()])
			} else {
				var_theme_data.array_set('update_supported', false)
			}
			rt.set_property(var_theme, 'update_supported', var_theme_data.array_get('update_supported'))
			mut var_filter_payload := rt.create_array([rt.ArrayItem{ key: 'theme', val: var_key }, rt.ArrayItem{ key: 'new_version', val: '' }, rt.ArrayItem{ key: 'url', val: '' }, rt.ArrayItem{ key: 'package', val: '' }, rt.ArrayItem{ key: 'requires', val: '' }, rt.ArrayItem{ key: 'requires_php', val: '' }])
			var_filter_payload = // unsupported expression: Expr_Cast_Object
			mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [rt.new_string('theme'), rt.new_null(), var_filter_payload.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_auto_update_forced.dup().is_null()))))) {
				rt.set_property(var_theme, 'auto_update_forced', var_auto_update_forced.dup())
			}
			if rt.is_true(this.show_autoupdates) {
				mut var_enabled := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_key.dup(), var_auto_updates.dup(), rt.new_bool(true)])) && rt.is_true(rt.get_property(var_theme, 'update_supported'))))
				if !(rt.get_property(var_theme, 'auto_update_forced')).is_null() {
					var_enabled = // unsupported expression: Expr_Cast_Bool
				}
				if rt.is_true(var_enabled) {
					var_themes.array_get_mut('auto-update-enabled').array_set(var_key, var_theme.dup())
				} else {
					var_themes.array_get_mut('auto-update-disabled').array_set(var_key, var_theme.dup())
				}
			}
		}
	}
	if rt.is_true(var_s) {
		mut var_status := rt.new_string(rt.new_string('search'))
		var_themes.array_set('search', rt.call_function('array_filter', [rt.call_function('array_merge', [var_themes.array_get('all'), var_themes.array_get('broken')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: '_search_callback' }])]))
	}
	mut var_totals := rt.new_array()
	mut var_js_themes := rt.new_array()
	{
		mut iter_1 := var_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_list := item_1.val
			mut var_type := item_1.key
			var_totals.array_set(var_type, var_list.dup().array_count())
			var_js_themes.array_set(var_type, rt.func_array_keys(var_list.dup()))
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_themes.array_get(var_status)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'search' }]), rt.new_bool(true)]))))))) {
		var_status = rt.new_string(rt.new_string('all'))
	}
	this.dispatch_set_prop('items', var_themes.array_get(var_status))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.sort_by_name(arg_0) }(rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'items'))
	this.has_items = !(!rt.is_true(var_themes.array_get('all')))
	mut var_total_this_page := var_totals.array_get(var_status)
	rt.call_function('wp_localize_script', [rt.new_string('updates'), rt.new_string('_wpUpdatesItemCounts'), rt.create_array([rt.ArrayItem{ key: 'themes', val: var_js_themes }, rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data', []rt.PhpVal{}) }])])
	if rt.is_true(var_orderby) {
		var_orderby = rt.call_function('ucfirst', [var_orderby.dup()])
		var_order = rt.new_string(rt.new_string(var_order.dup().to_string().to_upper()))
		if rt.is_true(rt.identical(rt.new_string('Name'), var_orderby)) {
			if rt.is_true(rt.identical(rt.new_string('ASC'), var_order)) {
				this.dispatch_set_prop('items', rt.call_function('array_reverse', [rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'items')]))
			}
		} else {
			rt.call_function('uasort', [rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: '_order_callback' }])])
		}
	}
	mut var_start := rt.mul(rt.sub(var_page, rt.new_int(1)), var_themes_per_page)
	if rt.is_true(rt.greater(var_total_this_page, var_themes_per_page)) {
		this.dispatch_set_prop('items', rt.call_function('array_slice', [rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'items'), var_start.dup(), var_themes_per_page.dup(), rt.new_bool(true)]))
	}
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_this_page }, rt.ArrayItem{ key: 'per_page', val: var_themes_per_page }]))
}

fn (mut this Class_WP_MS_Themes_List_Table) _search_callback(var_theme rt.PhpVal) bool {
	mut var_theme_mutated := var_theme
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(var_term.dup().is_null())) {
		mut var_term := rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'Name' }, rt.ArrayItem{ key: none, val: 'Description' }, rt.ArrayItem{ key: none, val: 'Author' }, rt.ArrayItem{ key: none, val: 'Author' }, rt.ArrayItem{ key: none, val: 'AuthorURI' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return true
			}
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return true
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return true
	}
	return false
}

fn (mut this Class_WP_MS_Themes_List_Table) _order_callback(var_theme_a rt.PhpVal, var_theme_b rt.PhpVal) rt.PhpVal {
	mut var_orderby := rt.new_null()
	mut var_order := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_a := var_theme_a.array_get(var_orderby)
	mut var_b := var_theme_b.array_get(var_orderby)
	return if rt.is_true(rt.identical(rt.new_string('DESC'), var_order)) { // unsupported expression: Expr_BinaryOp_Spaceship } else { // unsupported expression: Expr_BinaryOp_Spaceship }
}

fn (mut this Class_WP_MS_Themes_List_Table) no_items()  {
	if rt.is_true(this.has_items) {
		rt.call_function('_e', [rt.new_string('No themes found.')])
	} else {
		rt.call_function('_e', [rt.new_string('No themes are currently available.')])
	}
}

fn (mut this Class_WP_MS_Themes_List_Table) get_columns() rt.PhpVal {
	mut var_columns := { 'cb': rt.new_string('<input type="checkbox" />'), 'name': rt.call_function('__', [rt.new_string('Theme')]), 'description': rt.call_function('__', [rt.new_string('Description')]) }
	if rt.is_true(this.show_autoupdates) {
		var_columns['auto-updates'] = rt.call_function('__', [rt.new_string('Automatic Updates')])
	}
	return var_columns.dup()
}

fn (mut this Class_WP_MS_Themes_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Theme')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Theme Name.')]) }, rt.ArrayItem{ key: none, val: 'asc' }]) }])
}

fn (mut this Class_WP_MS_Themes_List_Table) get_primary_column_name() string {
	return 'name'
}

fn (mut this Class_WP_MS_Themes_List_Table) get_views() rt.PhpVal {
	mut var_totals := rt.new_null()
	mut var_status := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_status_links := rt.new_array()
	{
		mut iter_1 := var_totals.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_count := item_1.val
			mut var_type := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_count)))) {
				continue
			}
			mut switch_val_1 := var_type
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('all'))) {
				mut var_text := rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), var_count.dup(), rt.new_string('themes')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enabled'))) {
				var_text = rt.call_function('_nx', [rt.new_string('Enabled <span class="count">(%s)</span>'), rt.new_string('Enabled <span class="count">(%s)</span>'), var_count.dup(), rt.new_string('themes')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disabled'))) {
				var_text = rt.call_function('_nx', [rt.new_string('Disabled <span class="count">(%s)</span>'), rt.new_string('Disabled <span class="count">(%s)</span>'), var_count.dup(), rt.new_string('themes')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrade'))) {
				var_text = rt.call_function('_nx', [rt.new_string('Update Available <span class="count">(%s)</span>'), rt.new_string('Update Available <span class="count">(%s)</span>'), var_count.dup(), rt.new_string('themes')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('broken'))) {
				var_text = rt.call_function('_nx', [rt.new_string('Broken <span class="count">(%s)</span>'), rt.new_string('Broken <span class="count">(%s)</span>'), var_count.dup(), rt.new_string('themes')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-update-enabled'))) {
				var_text = rt.call_function('_n', [rt.new_string('Auto-updates Enabled <span class="count">(%s)</span>'), rt.new_string('Auto-updates Enabled <span class="count">(%s)</span>'), var_count.dup()])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-update-disabled'))) {
				var_text = rt.call_function('_n', [rt.new_string('Auto-updates Disabled <span class="count">(%s)</span>'), rt.new_string('Auto-updates Disabled <span class="count">(%s)</span>'), var_count.dup()])
			}
			if rt.is_true(this.is_site_themes) {
				mut var_url := rt.new_string( + ().str())
			} else {
				var_url = rt.new_string()
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				
			}
		}
	}
	return 
}

fn (mut this Class_WP_MS_Themes_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_status := rt.new_null()
}

fn (mut this Class_WP_MS_Themes_List_Table) display_rows()  {
}

fn (mut this Class_WP_MS_Themes_List_Table) column_cb(var_item rt.PhpVal)  {
}

fn (mut this Class_WP_MS_Themes_List_Table) column_name(var_theme rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_page := rt.new_null()
	mut var_s := rt.new_null()
	mut var_theme_mutated := var_theme
}

fn (mut this Class_WP_MS_Themes_List_Table) column_description(var_theme rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_totals := rt.new_null()
	mut var_theme_mutated := var_theme
}

fn (mut this Class_WP_MS_Themes_List_Table) column_autoupdates(var_theme rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_page := rt.new_null()
	mut var_theme_mutated := var_theme
}

fn (mut this Class_WP_MS_Themes_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

fn (mut this Class_WP_MS_Themes_List_Table) single_row_columns(var_item rt.PhpVal)  {
	mut var_columns := map[string]rt.PhpVal{}
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
}

fn (mut this Class_WP_MS_Themes_List_Table) single_row(var_theme rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_totals := rt.new_null()
	mut var_theme_mutated := var_theme
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_ms_themes_list_table(arg_0 rt.PhpVal) &Class_WP_MS_Themes_List_Table {
	mut obj := &Class_WP_MS_Themes_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		site_id: rt.new_null()
		is_site_themes: false
		has_items: false
		show_autoupdates: false
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme() &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_MS_Themes_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_table_classes' {
			return this.get_table_classes()
		}
		'ajax_user_can' {
			return this.ajax_user_can()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'_search_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._search_callback(dispatch_arg_0))
		}
		'_order_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._order_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_primary_column_name' {
			return rt.new_string(this.get_primary_column_name())
		}
		'get_views' {
			return this.get_views()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'column_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_name(dispatch_arg_0)
			return rt.new_null()
		}
		'column_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_description(dispatch_arg_0)
			return rt.new_null()
		}
		'column_autoupdates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_autoupdates(dispatch_arg_0)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'single_row_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row_columns(dispatch_arg_0)
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_MS_Themes_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'site_id' { return this.site_id }
		'is_site_themes' { return rt.new_bool(this.is_site_themes) }
		'has_items' { return rt.new_bool(this.has_items) }
		'show_autoupdates' { return rt.new_bool(this.show_autoupdates) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_MS_Themes_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'site_id' { this.site_id = val; return true }
		'is_site_themes' { this.is_site_themes = (val).to_bool(); return true }
		'has_items' { this.has_items = (val).to_bool(); return true }
		'show_autoupdates' { this.show_autoupdates = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_admin_includes_class_wp_ms_themes_list_table_php() {
}
