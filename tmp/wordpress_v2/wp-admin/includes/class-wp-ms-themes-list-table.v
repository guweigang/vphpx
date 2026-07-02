import rt
import crypto.md5

struct Class_WP_MS_Themes_List_Table {
	rt.PhpObjectBase
pub mut:
		site_id rt.PhpVal = rt.new_null()
		is_site_themes bool
		has_items bool
		show_autoupdates bool
}

fn (mut this Class_WP_MS_Themes_List_Table) construct(var_args rt.PhpVal) {
	mut var_status := rt.get_superglobal('status')
	mut var_page := rt.get_superglobal('page')
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'themes' }, rt.ArrayItem{ key: 'screen', val: if !(var_args.array_get(rt.new_string('screen'))).is_null() { var_args.array_get(rt.new_string('screen')) } else { rt.new_null() } }]))
	var_status = if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme_status'))).is_null() { rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme_status')) } else { rt.new_string('all') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'enabled' }, rt.ArrayItem{ key: none, val: 'disabled' }, rt.ArrayItem{ key: none, val: 'upgrade' }, rt.ArrayItem{ key: none, val: 'search' }, rt.ArrayItem{ key: none, val: 'broken' }, rt.ArrayItem{ key: none, val: 'auto-update-enabled' }, rt.ArrayItem{ key: none, val: 'auto-update-disabled' }]), rt.new_bool(true)]))))) {
	var_status = rt.new_string('all')
	}
	var_page = this.get_pagenum()
	this.is_site_themes = if rt.is_true(rt.identical(rt.new_string('site-themes-network'), rt.get_property(rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'screen'), 'id'))) { true } else { false }
	if this.is_site_themes {
		this.site_id = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) { rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('id'))).to_i64()) } else { 0 }
	}
	this.show_autoupdates = rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')])) && !(this.is_site_themes) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
}

fn (mut this Class_WP_MS_Themes_List_Table) get_table_classes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'widefat' }, rt.ArrayItem{ key: none, val: 'plugins' }])
}

fn (mut this Class_WP_MS_Themes_List_Table) ajax_user_can() rt.PhpVal {
	if this.is_site_themes {
		return rt.call_function('current_user_can', [rt.new_string('manage_sites')])
	} else {
		return rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])
	}
	return rt.new_null()
}

fn (mut this Class_WP_MS_Themes_List_Table) prepare_items() {
	mut var_page := rt.new_null()
	mut var_status := rt.get_superglobal('status')
	mut var_totals := rt.get_superglobal('totals')
	mut var_orderby := rt.get_superglobal('orderby')
	mut var_order := rt.get_superglobal('order')
	mut var_s := rt.get_superglobal('s')
	var_orderby = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))]) } else { rt.new_string('') }
	var_order = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))]) } else { rt.new_string('') }
	var_s = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]) } else { rt.new_string('') }
	mut var_themes := rt.create_array([rt.ArrayItem{ key: 'all', val: rt.call_function('apply_filters', [rt.new_string('all_themes'), rt.call_function('wp_get_themes', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'search', val: rt.new_array() }, rt.ArrayItem{ key: 'enabled', val: rt.new_array() }, rt.ArrayItem{ key: 'disabled', val: rt.new_array() }, rt.ArrayItem{ key: 'upgrade', val: rt.new_array() }, rt.ArrayItem{ key: 'broken', val: if this.is_site_themes { rt.new_array() } else { rt.call_function('wp_get_themes', [rt.create_array([rt.ArrayItem{ key: 'errors', val: true }])]) } }])
	if this.show_autoupdates {
		mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [rt.new_string('auto_update_themes'), rt.new_array()]))
		var_themes.array_set('auto-update-enabled', rt.new_array())
		var_themes.array_set('auto-update-disabled', rt.new_array())
	}
	if this.is_site_themes {
	mut var_themes_per_page := this.get_items_per_page(rt.new_string('site_themes_network_per_page'))
	mut var_allowed_where := rt.new_string('site')
	} else {
	var_themes_per_page = this.get_items_per_page(rt.new_string('themes_network_per_page'))
	var_allowed_where = rt.new_string('network')
	}
	mut var_current := rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	mut var_maybe_update := rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) && !(this.is_site_themes) && rt.is_true(var_current))
	mut iter_1 := rt.cast_array(var_themes.array_get(rt.new_string('all'))).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_theme := item_1.val
		mut var_key := item_1.key
		if this.is_site_themes && rt.is_true(rt.call_method(var_theme, 'is_allowed', [rt.new_string('network')])) {
			var_themes.array_get(rt.new_string('all')).array_unset(var_key)
			continue
		}
		if rt.is_true(var_maybe_update) && rt.get_property(var_current, 'response').array_isset(var_key) {
			rt.set_property(var_themes.array_get(rt.new_string('all')).array_get(var_key), 'update', rt.new_bool(true))
			var_themes.array_get_mut('upgrade').array_set(var_key, var_themes.array_get(rt.new_string('all')).array_get(var_key))
		}
		mut var_filter := rt.new_string((if rt.is_true(rt.call_method(var_theme, 'is_allowed', [var_allowed_where.clone(), this.site_id])) { 'enabled' } else { 'disabled' }).str())
		var_themes.array_get_mut(var_filter).array_set(var_key, var_themes.array_get(rt.new_string('all')).array_get(var_key))
		mut var_theme_data := rt.create_array([rt.ArrayItem{ key: 'update_supported', val: if !(rt.get_property(var_theme, 'update_supported')).is_null() { rt.get_property(var_theme, 'update_supported') } else { rt.new_bool(true) } }])
		if rt.get_property(var_current, 'response').array_isset(var_key) {
		var_theme_data = rt.call_function('array_merge', [rt.cast_array(rt.get_property(var_current, 'response').array_get(var_key)), var_theme_data.clone()])
		} else if rt.get_property(var_current, 'no_update').array_isset(var_key) {
		var_theme_data = rt.call_function('array_merge', [rt.cast_array(rt.get_property(var_current, 'no_update').array_get(var_key)), var_theme_data.clone()])
		} else {
			var_theme_data.array_set('update_supported', false)
		}
		rt.set_property(var_theme, 'update_supported', var_theme_data.array_get(rt.new_string('update_supported')))
		mut var_filter_payload := rt.create_array([rt.ArrayItem{ key: 'theme', val: var_key }, rt.ArrayItem{ key: 'new_version', val: '' }, rt.ArrayItem{ key: 'url', val: '' }, rt.ArrayItem{ key: 'package', val: '' }, rt.ArrayItem{ key: 'requires', val: '' }, rt.ArrayItem{ key: 'requires_php', val: '' }])
		var_filter_payload = rt.array_to_object(rt.call_function('array_merge', [var_filter_payload.clone(), rt.call_function('array_intersect_key', [var_theme_data.clone(), var_filter_payload.clone()])]))
		mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [rt.new_string('theme'), rt.new_null(), var_filter_payload.clone()])
		if !(var_auto_update_forced.clone().is_null()) {
			rt.set_property(var_theme, 'auto_update_forced', var_auto_update_forced.clone())
		}
		if this.show_autoupdates {
			mut var_enabled := rt.new_bool(rt.is_true(rt.call_function('in_array', [var_key.clone(), var_auto_updates.clone(), rt.new_bool(true)])) && rt.is_true(rt.get_property(var_theme, 'update_supported')))
			if !(rt.get_property(var_theme, 'auto_update_forced')).is_null() {
			var_enabled = rt.new_bool((rt.get_property(var_theme, 'auto_update_forced')).to_bool())
			}
			if rt.is_true(var_enabled) {
				var_themes.array_get_mut('auto-update-enabled').array_set(var_key, var_theme.clone())
			} else {
				var_themes.array_get_mut('auto-update-disabled').array_set(var_key, var_theme.clone())
			}
		}
	}
	if rt.is_true(var_s) {
		var_status = rt.new_string('search')
		var_themes.array_set('search', rt.call_function('array_filter', [rt.call_function('array_merge', [var_themes.array_get(rt.new_string('all')), var_themes.array_get(rt.new_string('broken'))]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: '_search_callback' }])]))
	}
	var_totals = rt.new_array()
	mut var_js_themes := rt.new_array()
	mut iter_2 := var_themes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_list := item_2.val
		mut var_type := item_2.key
		var_totals.array_set(var_type, var_list.clone().array_count())
		var_js_themes.array_set(var_type, rt.func_array_keys(var_list.clone()))
	}
	if !rt.is_true(var_themes.array_get(var_status)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'search' }]), rt.new_bool(true)]))))) {
	var_status = rt.new_string('all')
	}
	this.dispatch_set_prop('items', var_themes.array_get(var_status))
	mut iife_temp_0 := Class_WP_Theme{}
	mut iife_result_0 := iife_temp_0.sort_by_name(rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'items'))
	this.has_items = !(!rt.is_true(var_themes.array_get(rt.new_string('all'))))
	mut var_total_this_page := var_totals.array_get(var_status)
	rt.call_function('wp_localize_script', [rt.new_string('updates'), rt.new_string('_wpUpdatesItemCounts'), rt.create_array([rt.ArrayItem{ key: 'themes', val: var_js_themes }, rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data', []rt.PhpVal{}) }])])
	if rt.is_true(var_orderby) {
		var_orderby = rt.call_function('ucfirst', [var_orderby.clone()])
		var_order = rt.new_string(var_order.clone().to_string().to_upper())
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
		this.dispatch_set_prop('items', rt.call_function('array_slice', [rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'items'), var_start.clone(), var_themes_per_page.clone(), rt.new_bool(true)]))
	}
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_this_page }, rt.ArrayItem{ key: 'per_page', val: var_themes_per_page }]))
}

fn (mut this Class_WP_MS_Themes_List_Table) _search_callback(var_theme rt.PhpVal) bool {
	mut var_theme_mutated := var_theme
	mut var_term := rt.new_null()
	if rt.is_true(rt.new_bool(var_term.clone().is_null())) {
	var_term = rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))])
	}
	mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'Name' }, rt.ArrayItem{ key: none, val: 'Description' }, rt.ArrayItem{ key: none, val: 'Author' }, rt.ArrayItem{ key: none, val: 'Author' }, rt.ArrayItem{ key: none, val: 'AuthorURI' }]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.call_method(var_theme_mutated, 'display', [var_field.clone(), rt.new_bool(false), rt.new_bool(true)]), var_term.clone()]))))) {
			return true
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{}), var_term.clone()]))))) {
		return true
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.call_method(var_theme_mutated, 'get_template', []rt.PhpVal{}), var_term.clone()]))))) {
		return true
	}
	return false
}

fn (mut this Class_WP_MS_Themes_List_Table) _order_callback(var_theme_a rt.PhpVal, var_theme_b rt.PhpVal) rt.PhpVal {
	mut var_orderby := rt.new_null()
	mut var_order := rt.new_null()
	mut var_a := var_theme_a.array_get(var_orderby)
	mut var_b := var_theme_b.array_get(var_orderby)
	return if rt.is_true(rt.identical(rt.new_string('DESC'), var_order)) { rt.new_null() } else { rt.new_null() }
}

fn (mut this Class_WP_MS_Themes_List_Table) no_items() {
	if this.has_items {
		rt.call_function('_e', [rt.new_string('No themes found.')])
	} else {
		rt.call_function('_e', [rt.new_string('No themes are currently available.')])
	}
}

fn (mut this Class_WP_MS_Themes_List_Table) get_columns() rt.PhpVal {
	mut var_columns := { 'cb': rt.new_string('<input type="checkbox" />'), 'name': rt.call_function('__', [rt.new_string('Theme')]), 'description': rt.call_function('__', [rt.new_string('Description')]) }
	if this.show_autoupdates {
		var_columns['auto-updates'] = rt.call_function('__', [rt.new_string('Automatic Updates')])
	}
	return var_columns.clone()
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
	mut var_status_links := rt.new_array()
	mut iter_4 := var_totals.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_count := item_4.val
		mut var_type := item_4.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_count)))) {
			continue
		}
		mut switch_val_1 := var_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('all'))) {
		mut var_text := rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), var_count.clone(), rt.new_string('themes')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enabled'))) {
		var_text = rt.call_function('_nx', [rt.new_string('Enabled <span class="count">(%s)</span>'), rt.new_string('Enabled <span class="count">(%s)</span>'), var_count.clone(), rt.new_string('themes')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disabled'))) {
		var_text = rt.call_function('_nx', [rt.new_string('Disabled <span class="count">(%s)</span>'), rt.new_string('Disabled <span class="count">(%s)</span>'), var_count.clone(), rt.new_string('themes')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrade'))) {
		var_text = rt.call_function('_nx', [rt.new_string('Update Available <span class="count">(%s)</span>'), rt.new_string('Update Available <span class="count">(%s)</span>'), var_count.clone(), rt.new_string('themes')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('broken'))) {
		var_text = rt.call_function('_nx', [rt.new_string('Broken <span class="count">(%s)</span>'), rt.new_string('Broken <span class="count">(%s)</span>'), var_count.clone(), rt.new_string('themes')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-update-enabled'))) {
		var_text = rt.call_function('_n', [rt.new_string('Auto-updates Enabled <span class="count">(%s)</span>'), rt.new_string('Auto-updates Enabled <span class="count">(%s)</span>'), var_count.clone()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-update-disabled'))) {
		var_text = rt.call_function('_n', [rt.new_string('Auto-updates Disabled <span class="count">(%s)</span>'), rt.new_string('Auto-updates Disabled <span class="count">(%s)</span>'), var_count.clone()])
		}
		if this.is_site_themes {
		mut var_url := rt.new_string('site-themes.php?id=' + (this.site_id).str())
		} else {
		var_url = rt.new_string('themes.php')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('search'), var_type)))) {
			var_status_links.array_set(var_type, rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('theme_status'), var_type.clone(), var_url.clone()])]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [var_text.clone(), rt.call_function('number_format_i18n', [var_count.clone()])]) }, rt.ArrayItem{ key: 'current', val: rt.identical(var_type, var_status) }]))
		}
	}
	return this.get_views_links(var_status_links.clone())
}

fn (mut this Class_WP_MS_Themes_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_status := rt.new_null()
	mut var_actions := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('enabled'), var_status)))) {
		var_actions.array_set('enable-selected', if this.is_site_themes { rt.call_function('__', [rt.new_string('Enable')]) } else { rt.call_function('__', [rt.new_string('Network Enable')]) })
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('disabled'), var_status)))) {
		var_actions.array_set('disable-selected', if this.is_site_themes { rt.call_function('__', [rt.new_string('Disable')]) } else { rt.call_function('__', [rt.new_string('Network Disable')]) })
	}
	if !(this.is_site_themes) {
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) {
			var_actions.array_set('update-selected', rt.call_function('__', [rt.new_string('Update')]))
		}
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')])) {
			var_actions.array_set('delete-selected', rt.call_function('__', [rt.new_string('Delete')]))
		}
	}
	if this.show_autoupdates {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-update-enabled'), var_status)))) {
			var_actions.array_set('enable-auto-update-selected', rt.call_function('__', [rt.new_string('Enable Auto-updates')]))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-update-disabled'), var_status)))) {
			var_actions.array_set('disable-auto-update-selected', rt.call_function('__', [rt.new_string('Disable Auto-updates')]))
		}
	}
	return var_actions.clone()
}

fn (mut this Class_WP_MS_Themes_List_Table) display_rows() {
	mut iter_5 := rt.get_property(rt.new_object('WP_MS_Themes_List_Table', ['WP_List_Table'], &this), 'items').iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_theme := item_5.val
		this.single_row(var_theme.clone())
	}
}

fn (mut this Class_WP_MS_Themes_List_Table) column_cb(var_item rt.PhpVal) {
	mut var_theme := var_item
	mut var_checkbox_id := rt.new_string('checkbox_' + md5.hexhash(rt.call_method(var_theme, 'get', [rt.new_string('Name')]).to_string()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_checkbox_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_checkbox_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Select %s')]), rt.call_method(var_theme, 'display', [rt.new_string('Name')])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_MS_Themes_List_Table) column_name(var_theme rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_page := rt.new_null()
	mut var_s := rt.new_null()
	mut var_theme_mutated := var_theme
	mut var_context := var_status.clone()
	if this.is_site_themes {
	mut var_url := rt.new_string((rt.concat(rt.concat(rt.new_string('site-themes.php?id='), this.site_id), rt.new_string('&amp;'))).str())
	mut var_allowed := rt.call_method(var_theme_mutated, 'is_allowed', [rt.new_string('site'), this.site_id])
	} else {
	var_url = rt.new_string('themes.php?')
	var_allowed = rt.call_method(var_theme_mutated, 'is_allowed', [rt.new_string('network')])
	}
	mut var_actions := rt.create_array([rt.ArrayItem{ key: 'enable', val: '' }, rt.ArrayItem{ key: 'disable', val: '' }, rt.ArrayItem{ key: 'delete', val: '' }])
	mut var_stylesheet := rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{})
	mut var_theme_key := rt.call_function('urlencode', [var_stylesheet.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme_mutated, 'errors', []rt.PhpVal{}))))) {
			var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'enable' }, rt.ArrayItem{ key: 'theme', val: var_theme_key }, rt.ArrayItem{ key: 'paged', val: var_page }, rt.ArrayItem{ key: 's', val: var_s }]), var_url.clone()])
			if this.is_site_themes {
			mut var_aria_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Enable %s')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Name')])])
			} else {
			var_aria_label = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Network Enable %s')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Name')])])
			}
			var_actions.array_set('enable', rt.call_function('sprintf', [rt.new_string('<a href="%s" class="edit" aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [var_url.clone(), rt.new_string('enable-theme_' + (var_stylesheet).str())])]), rt.call_function('esc_attr', [var_aria_label.clone()]), if this.is_site_themes { rt.call_function('__', [rt.new_string('Enable')]) } else { rt.call_function('__', [rt.new_string('Network Enable')]) }]))
		}
	} else {
		var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'disable' }, rt.ArrayItem{ key: 'theme', val: var_theme_key }, rt.ArrayItem{ key: 'paged', val: var_page }, rt.ArrayItem{ key: 's', val: var_s }]), var_url.clone()])
		if this.is_site_themes {
		var_aria_label = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Disable %s')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Name')])])
		} else {
		var_aria_label = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Network Disable %s')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Name')])])
		}
		var_actions.array_set('disable', rt.call_function('sprintf', [rt.new_string('<a href="%s" aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [var_url.clone(), rt.new_string('disable-theme_' + (var_stylesheet).str())])]), rt.call_function('esc_attr', [var_aria_label.clone()]), if this.is_site_themes { rt.call_function('__', [rt.new_string('Disable')]) } else { rt.call_function('__', [rt.new_string('Network Disable')]) }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed)))) && !(this.is_site_themes) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('stylesheet')]), var_stylesheet)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('template')]), var_stylesheet)))) {
		var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'delete-selected' }, rt.ArrayItem{ key: 'checked[]', val: var_theme_key }, rt.ArrayItem{ key: 'theme_status', val: var_context }, rt.ArrayItem{ key: 'paged', val: var_page }, rt.ArrayItem{ key: 's', val: var_s }]), rt.new_string('themes.php')])
		var_aria_label = rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('Delete %s'), rt.new_string('theme')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Name')])])
		var_actions.array_set('delete', rt.call_function('sprintf', [rt.new_string('<a href="%s" class="delete" aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [var_url.clone(), rt.new_string('bulk-themes')])]), rt.call_function('esc_attr', [var_aria_label.clone()]), rt.call_function('__', [rt.new_string('Delete')])]))
	}
	var_actions = rt.call_function('apply_filters', [rt.new_string('theme_action_links'), rt.call_function('array_filter', [var_actions.clone()]), var_theme_mutated.clone(), var_context.clone()])
	var_actions = rt.call_function('apply_filters', [rt.new_string("theme_action_links_${var_stylesheet.to_string()}"), var_actions.clone(), var_theme_mutated.clone(), var_context.clone()])
	rt.echo_val(this.row_actions(var_actions.clone(), rt.new_bool(true)))
}

fn (mut this Class_WP_MS_Themes_List_Table) column_description(var_theme rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_totals := rt.new_null()
	mut var_theme_mutated := var_theme
	if rt.is_true(rt.call_method(var_theme_mutated, 'errors', []rt.PhpVal{})) {
		mut var_pre := rt.new_string((if rt.is_true(rt.identical(rt.new_string('broken'), var_status)) { '<strong class="error-message">' + (rt.call_function('__', [rt.new_string('Broken Theme:')])).str() + '</strong> ' } else { '' }).str())
		rt.call_function('wp_admin_notice', [rt.new_string((var_pre).str() + (rt.call_method(rt.call_method(var_theme_mutated, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'additional_classes', val: 'inline' }])])
	}
	if this.is_site_themes {
	mut var_allowed := rt.call_method(var_theme_mutated, 'is_allowed', [rt.new_string('site'), this.site_id])
	} else {
	var_allowed = rt.call_method(var_theme_mutated, 'is_allowed', [rt.new_string('network')])
	}
	mut var_class := rt.new_string((if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed)))) { 'inactive' } else { 'active' }).str())
	if !(!rt.is_true(var_totals.array_get(rt.new_string('upgrade')))) && !(!rt.is_true(rt.get_property(var_theme_mutated, 'update'))) {
		var_class = rt.concat(var_class, rt.new_string(' update'))
	}
	print('<div class=\'theme-description\'><p>' + (rt.call_method(var_theme_mutated, 'display', [rt.new_string('Description')])).str() + "</p></div>\n\t\t\t<div class='${var_class.to_string()} second theme-version-author-uri'>")
	mut var_stylesheet := rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{})
	mut var_theme_meta := rt.new_array()
	if rt.is_true(rt.call_method(var_theme_mutated, 'get', [rt.new_string('Version')])) {
		var_theme_meta.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Version')])]))
	}
	var_theme_meta.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('By %s')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Author')])]))
	if rt.is_true(rt.call_method(var_theme_mutated, 'get', [rt.new_string('ThemeURI')])) {
		mut var_aria_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Visit theme site for %s')]), rt.call_method(var_theme_mutated, 'display', [rt.new_string('Name')])])
		var_theme_meta.array_push(rt.call_function('sprintf', [rt.new_string('<a href="%s" aria-label="%s">%s</a>'), rt.call_method(var_theme_mutated, 'display', [rt.new_string('ThemeURI')]), rt.call_function('esc_attr', [var_aria_label.clone()]), rt.call_function('__', [rt.new_string('Visit Theme Site')])]))
	}
	if rt.is_true(rt.call_method(var_theme_mutated, 'parent', []rt.PhpVal{})) {
		var_theme_meta.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Child theme of %s')]), rt.new_string('<strong>' + (rt.call_method(rt.call_method(var_theme_mutated, 'parent', []rt.PhpVal{}), 'display', [rt.new_string('Name')])).str() + '</strong>')]))
	}
	var_theme_meta = rt.call_function('apply_filters', [rt.new_string('theme_row_meta'), var_theme_meta.clone(), var_stylesheet.clone(), var_theme_mutated.clone(), var_status.clone()])
	rt.echo_val(rt.call_function('implode', [rt.new_string(' | '), var_theme_meta.clone()]))
	print('</div>')
}

fn (mut this Class_WP_MS_Themes_List_Table) column_autoupdates(var_theme rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_page := rt.new_null()
	mut var_theme_mutated := var_theme
	mut var_auto_updates := rt.new_null()
	mut var_available_updates := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_auto_updates)))) {
	var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [rt.new_string('auto_update_themes'), rt.new_array()]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_available_updates)))) {
	var_available_updates = rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	}
	mut var_stylesheet := rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{})
	if !(rt.get_property(var_theme_mutated, 'auto_update_forced')).is_null() {
		if rt.is_true(rt.get_property(var_theme_mutated, 'auto_update_forced')) {
		mut var_text := rt.call_function('__', [rt.new_string('Auto-updates enabled')])
		} else {
		var_text = rt.call_function('__', [rt.new_string('Auto-updates disabled')])
		}
	mut var_action := rt.new_string('unavailable')
	mut var_time_class := rt.new_string(' hidden')
	} else if !rt.is_true(rt.get_property(var_theme_mutated, 'update_supported')) {
	var_text = rt.new_string('')
	var_action = rt.new_string('unavailable')
	var_time_class = rt.new_string(' hidden')
	} else if rt.is_true(rt.call_function('in_array', [var_stylesheet.clone(), var_auto_updates.clone(), rt.new_bool(true)])) {
	var_text = rt.call_function('__', [rt.new_string('Disable auto-updates')])
	var_action = rt.new_string('disable')
	var_time_class = rt.new_string('')
	} else {
	var_text = rt.call_function('__', [rt.new_string('Enable auto-updates')])
	var_action = rt.new_string('enable')
	var_time_class = rt.new_string(' hidden')
	}
	mut var_query_args := { 'action': rt.new_string("${var_action.to_string()}-auto-update"), 'theme': var_stylesheet, 'paged': var_page, 'theme_status': var_status }
	mut var_url := rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_query_args), rt.new_string('themes.php')])
	if rt.is_true(rt.identical(rt.new_string('unavailable'), var_action)) {
		var_html.array_push('<span class="label">' + (var_text).str() + '</span>')
	} else {
		var_html.array_push(rt.call_function('sprintf', [rt.new_string('<a href="%s" class="toggle-auto-update aria-button-if-js" data-wp-action="%s">'), rt.call_function('wp_nonce_url', [var_url.clone(), rt.new_string('updates')]), var_action.clone()]))
		var_html.array_push('<span class="dashicons dashicons-update spin hidden" aria-hidden="true"></span>')
		var_html.array_push('<span class="label">' + (var_text).str() + '</span>')
		var_html.array_push('</a>')
	}
	if rt.get_property(var_available_updates, 'response').array_isset(var_stylesheet) {
		var_html.array_push(rt.call_function('sprintf', [rt.new_string('<div class="auto-update-time%s">%s</div>'), var_time_class.clone(), rt.call_function('wp_get_auto_update_message', []rt.PhpVal{})]))
	}
	mut var_html := rt.call_function('implode', [rt.new_string(''), var_html.clone()])
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('theme_auto_update_setting_html'), var_html.clone(), var_stylesheet.clone(), var_theme_mutated.clone()]))
	rt.call_function('wp_admin_notice', [rt.new_string(''), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'notice-alt' }, rt.ArrayItem{ key: none, val: 'inline' }, rt.ArrayItem{ key: none, val: 'hidden' }]) }])])
}

fn (mut this Class_WP_MS_Themes_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	mut var_theme := var_item
	mut var_stylesheet := rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('manage_themes_custom_column'), var_column_name.clone(), var_stylesheet.clone(), var_theme.clone()])
}

fn (mut this Class_WP_MS_Themes_List_Table) single_row_columns(var_item rt.PhpVal) {
	mut var_columns := map[string]rt.PhpVal{}
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
	mut list_tmp_1 := this.get_column_info()
	var_columns = (list_tmp_1).array_get(0)
	var_hidden = (list_tmp_1).array_get(1)
	var_sortable = (list_tmp_1).array_get(2)
	var_primary = (list_tmp_1).array_get(3)
	for var_column_name, var_column_display_name in var_columns {
		mut var_extra_classes := rt.new_string('')
		if rt.is_true(rt.call_function('in_array', [rt.new_string(column_name), var_hidden.clone(), rt.new_bool(true)])) {
			var_extra_classes = rt.concat(var_extra_classes, rt.new_string(' hidden'))
		}
		mut switch_val_2 := rt.new_string(column_name)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('cb'))) {
			print('<th scope="row" class="check-column">')
			this.column_cb(var_item.clone())
			print('</th>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('name'))) {
			mut var_active_theme_label := rt.new_string('')
			if !(!rt.is_true(this.site_id)) {
				mut var_stylesheet := rt.call_function('get_blog_option', [this.site_id, rt.new_string('stylesheet')])
				mut var_template := rt.call_function('get_blog_option', [this.site_id, rt.new_string('template')])
				if rt.is_true(rt.identical(rt.call_method(var_item, 'get_template', []rt.PhpVal{}), var_template)) {
				var_active_theme_label = rt.new_string(' &mdash; ' + (rt.call_function('__', [rt.new_string('Active Theme')])).str())
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_stylesheet, var_template)))) && rt.is_true(rt.identical(rt.call_method(var_item, 'get_stylesheet', []rt.PhpVal{}), var_stylesheet)) {
				var_active_theme_label = rt.new_string(' &mdash; ' + (rt.call_function('__', [rt.new_string('Active Child Theme')])).str())
				}
			}
			print("<td class='theme-title column-primary${var_extra_classes.to_string()}'><strong>" + (rt.call_method(var_item, 'display', [rt.new_string('Name')])).str() + (var_active_theme_label).str() + '</strong>')
			this.column_name(var_item.clone())
			print('</td>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('description'))) {
			print("<td class='column-description desc${var_extra_classes.to_string()}'>")
			this.column_description(var_item.clone())
			print('</td>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('auto-updates'))) {
			print("<td class='column-auto-updates${var_extra_classes.to_string()}'>")
			this.column_autoupdates(var_item.clone())
			print('</td>')
		} else {
			print("<td class='${var_column_name} column-${var_column_name}${var_extra_classes.to_string()}'>")
			this.column_default(var_item.clone(), rt.new_string(column_name))
			print('</td>')
		}
	}
}

fn (mut this Class_WP_MS_Themes_List_Table) single_row(var_theme rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_totals := rt.new_null()
	mut var_theme_mutated := var_theme
	if this.is_site_themes {
	mut var_allowed := rt.call_method(var_theme_mutated, 'is_allowed', [rt.new_string('site'), this.site_id])
	} else {
	var_allowed = rt.call_method(var_theme_mutated, 'is_allowed', [rt.new_string('network')])
	}
	mut var_stylesheet := rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{})
	mut var_class := rt.new_string((if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed)))) { 'inactive' } else { 'active' }).str())
	if !(!rt.is_true(var_totals.array_get(rt.new_string('upgrade')))) && !(!rt.is_true(rt.get_property(var_theme_mutated, 'update'))) {
		var_class = rt.concat(var_class, rt.new_string(' update'))
	}
	rt.call_function('printf', [rt.new_string('<tr class="%s" data-slug="%s">'), rt.call_function('esc_attr', [var_class.clone()]), rt.call_function('esc_attr', [var_stylesheet.clone()])])
	this.single_row_columns(var_theme_mutated.clone())
	print('</tr>')
	if this.is_site_themes {
		rt.call_function('remove_action', [rt.new_string("after_theme_row_${var_stylesheet.to_string()}"), rt.new_string('wp_theme_update_row')])
	}
	rt.call_function('do_action', [rt.new_string('after_theme_row'), var_stylesheet.clone(), var_theme_mutated.clone(), var_status.clone()])
	rt.call_function('do_action', [rt.new_string("after_theme_row_${var_stylesheet.to_string()}"), var_stylesheet.clone(), var_theme_mutated.clone(), var_status.clone()])
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



fn main() {
	defer {
		rt.shutdown()
	}

}
