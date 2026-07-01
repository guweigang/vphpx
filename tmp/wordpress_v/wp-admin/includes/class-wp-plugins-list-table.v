import rt

struct Class_WP_Plugins_List_Table {
	rt.PhpObjectBase
pub mut:
		show_autoupdates bool
}

fn (mut this Class_WP_Plugins_List_Table) construct(var_args rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'plugins' }, rt.ArrayItem{ key: 'screen', val: if !(var_args.array_get('screen')).is_null() { var_args.array_get('screen') } else { rt.new_null() } }]))
	mut var_status := rt.new_string(rt.new_string('all'))
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('plugin_status')) {
		var_status = rt.call_function('sanitize_key', [rt.get_superglobal('_REQUEST').array_get('plugin_status')])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) {
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('add_query_arg', [rt.new_string('s'), rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])]))
	}
	mut var_page := this.get_pagenum()
	this.show_autoupdates = rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('plugin')])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) || rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'screen'), 'in_admin', [rt.new_string('network')]))))
}

fn (mut this Class_WP_Plugins_List_Table) get_table_classes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'widefat' }, rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), '_args').array_get('plural') }])
}

fn (mut this Class_WP_Plugins_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('activate_plugins')])
}

fn (mut this Class_WP_Plugins_List_Table) prepare_items()  {
	mut var_page := rt.new_null()
	mut var_s := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_orderby := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('orderby'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('orderby')]) } else { rt.new_string('') }
	mut var_order := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('order'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('order')]) } else { rt.new_string('') }
	mut var_all_plugins := rt.call_function('apply_filters', [rt.new_string('all_plugins'), rt.call_function('get_plugins', []rt.PhpVal{})])
	mut var_plugins := rt.create_array([rt.ArrayItem{ key: 'all', val: var_all_plugins }, rt.ArrayItem{ key: 'search', val: rt.new_array() }, rt.ArrayItem{ key: 'active', val: rt.new_array() }, rt.ArrayItem{ key: 'inactive', val: rt.new_array() }, rt.ArrayItem{ key: 'recently_activated', val: rt.new_array() }, rt.ArrayItem{ key: 'upgrade', val: rt.new_array() }, rt.ArrayItem{ key: 'mustuse', val: rt.new_array() }, rt.ArrayItem{ key: 'dropins', val: rt.new_array() }, rt.ArrayItem{ key: 'paused', val: rt.new_array() }])
	if rt.is_true(this.show_autoupdates) {
		mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [rt.new_string('auto_update_plugins'), rt.new_array()]))
		var_plugins.array_set('auto-update-enabled', rt.new_array())
		var_plugins.array_set('auto-update-disabled', rt.new_array())
	}
	mut var_screen := rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'screen')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])))))) {
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('show_advanced_plugins'), rt.new_bool(true), rt.new_string('mustuse')])) {
			var_plugins.array_set('mustuse', rt.call_function('get_mu_plugins', []rt.PhpVal{}))
		}
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('show_advanced_plugins'), rt.new_bool(true), rt.new_string('dropins')])) {
			var_plugins.array_set('dropins', rt.call_function('get_dropins', []rt.PhpVal{}))
		}
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])) {
			mut var_current := rt.call_function('get_site_transient', [rt.new_string('update_plugins')])
			{
				mut iter_1 := rt.cast_array(var_plugins.array_get('all')).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_plugin_data := item_1.val
					mut var_plugin_file := item_1.key
					if rt.get_property(var_current, 'response').array_isset(var_plugin_file) {
						var_plugins.array_get_mut('all').array_get_mut(var_plugin_file).array_set('update', true)
						var_plugins.array_get_mut('upgrade').array_set(var_plugin_file, var_plugins.array_get('all').array_get(var_plugin_file))
					}
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')]))))) {
		mut var_show := rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])
		mut var_show_network_active := rt.call_function('apply_filters', [rt.new_string('show_network_active_plugins'), var_show.dup()])
	}
	if rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])) {
		mut var_recently_activated := rt.call_function('get_site_option', [rt.new_string('recently_activated'), rt.new_array()])
	} else {
		var_recently_activated = rt.call_function('get_option', [rt.new_string('recently_activated'), rt.new_array()])
	}
	{
		mut iter_1 := var_recently_activated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_time := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_time.dup().is_long()))))) || rt.is_true(rt.less(rt.add(var_time, rt.get_constant('WEEK_IN_SECONDS')), rt.call_function('time', []rt.PhpVal{}))))) {
				var_recently_activated.array_unset(var_key)
			}
		}
	}
	if rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])) {
		rt.call_function('update_site_option', [rt.new_string('recently_activated'), var_recently_activated.dup()])
	} else {
		rt.call_function('update_option', [rt.new_string('recently_activated'), var_recently_activated.dup(), rt.new_bool(false)])
	}
	mut var_plugin_info := rt.call_function('get_site_transient', [rt.new_string('update_plugins')])
	{
		mut iter_1 := rt.cast_array(var_plugins.array_get('all')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_data := item_1.val
			mut var_plugin_file := item_1.key
			if rt.get_property(var_plugin_info, 'response').array_isset(var_plugin_file) {
				var_plugin_data = rt.call_function('array_merge', [rt.cast_array(rt.get_property(var_plugin_info, 'response').array_get(var_plugin_file)), rt.create_array([rt.ArrayItem{ key: 'update-supported', val: true }]), var_plugin_data.dup()])
			} else if rt.get_property(var_plugin_info, 'no_update').array_isset(var_plugin_file) {
				var_plugin_data = rt.call_function('array_merge', [rt.cast_array(rt.get_property(var_plugin_info, 'no_update').array_get(var_plugin_file)), rt.create_array([rt.ArrayItem{ key: 'update-supported', val: true }]), var_plugin_data.dup()])
			} else if !rt.is_true(var_plugin_data.array_get('update-supported')) {
				var_plugin_data.array_set('update-supported', false)
			}
			mut var_filter_payload := rt.create_array([rt.ArrayItem{ key: 'id', val: var_plugin_file }, rt.ArrayItem{ key: 'slug', val: '' }, rt.ArrayItem{ key: 'plugin', val: var_plugin_file }, rt.ArrayItem{ key: 'new_version', val: '' }, rt.ArrayItem{ key: 'url', val: '' }, rt.ArrayItem{ key: 'package', val: '' }, rt.ArrayItem{ key: 'icons', val: rt.new_array() }, rt.ArrayItem{ key: 'banners', val: rt.new_array() }, rt.ArrayItem{ key: 'banners_rtl', val: rt.new_array() }, rt.ArrayItem{ key: 'tested', val: '' }, rt.ArrayItem{ key: 'requires_php', val: '' }, rt.ArrayItem{ key: 'compatibility', val: create_stdclass() }])
			var_filter_payload = // unsupported expression: Expr_Cast_Object
			mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [rt.new_string('plugin'), rt.new_null(), var_filter_payload.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_auto_update_forced.dup().is_null()))))) {
				var_plugin_data.array_set('auto-update-forced', var_auto_update_forced.dup())
			}
			var_plugins.array_get_mut('all').array_set(var_plugin_file, var_plugin_data.dup())
			if var_plugins.array_get('upgrade').array_isset(var_plugin_file) {
				var_plugins.array_get_mut('upgrade').array_set(var_plugin_file, var_plugin_data.dup())
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')]))))))) && rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin_file.dup()])))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [var_plugin_file.dup()]))))))) {
				if rt.is_true(var_show_network_active) {
					var_plugins.array_get_mut('inactive').array_set(var_plugin_file, var_plugin_data.dup())
				} else {
					var_plugins.array_get('all').array_unset(var_plugin_file)
				}
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')]))))) && rt.is_true(rt.call_function('is_plugin_active_for_network', [var_plugin_file.dup()])))) {
				if rt.is_true(var_show_network_active) {
					var_plugins.array_get_mut('active').array_set(var_plugin_file, var_plugin_data.dup())
				} else {
					var_plugins.array_get('all').array_unset(var_plugin_file)
				}
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')]))))) && rt.is_true(rt.call_function('is_plugin_active', [var_plugin_file.dup()])))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])) && rt.is_true(rt.call_function('is_plugin_active_for_network', [var_plugin_file.dup()])))))) {
				var_plugins.array_get_mut('active').array_set(var_plugin_file, var_plugin_data.dup())
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')]))))) && rt.is_true(rt.call_function('is_plugin_paused', [var_plugin_file.dup()])))) {
					var_plugins.array_get_mut('paused').array_set(var_plugin_file, var_plugin_data.dup())
				}
			} else {
				if var_recently_activated.array_isset(var_plugin_file) {
					var_plugins.array_get_mut('recently_activated').array_set(var_plugin_file, var_plugin_data.dup())
				}
				var_plugins.array_get_mut('inactive').array_set(var_plugin_file, var_plugin_data.dup())
			}
			if rt.is_true(this.show_autoupdates) {
				mut var_enabled := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_plugin_file.dup(), var_auto_updates.dup(), rt.new_bool(true)])) && rt.is_true(var_plugin_data.array_get('update-supported'))))
				if var_plugin_data.array_isset(rt.new_string('auto-update-forced')) {
					var_enabled = // unsupported expression: Expr_Cast_Bool
				}
				if rt.is_true(var_enabled) {
					var_plugins.array_get_mut('auto-update-enabled').array_set(var_plugin_file, var_plugin_data.dup())
				} else {
					var_plugins.array_get_mut('auto-update-disabled').array_set(var_plugin_file, var_plugin_data.dup())
				}
			}
		}
	}
	if rt.is_true(rt.new_int(var_s.dup().to_string().len)) {
		mut var_status := rt.new_string(rt.new_string('search'))
		var_plugins.array_set('search', rt.call_function('array_filter', [var_plugins.array_get('all'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: '_search_callback' }])]))
	}
	var_plugins = rt.call_function('apply_filters', [rt.new_string('plugins_list'), var_plugins.dup()])
	mut var_totals := rt.new_array()
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_list := item_1.val
			mut var_type := item_1.key
			var_totals.array_set(var_type, var_list.dup().array_count())
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_plugins.array_get(var_status)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'search' }]), rt.new_bool(true)]))))))) {
		var_status = rt.new_string(rt.new_string('all'))
	}
	this.dispatch_set_prop('items', rt.new_array())
	{
		mut iter_1 := var_plugins.array_get(var_status).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_data := item_1.val
			mut var_plugin_file := item_1.key
			rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'items').array_set(var_plugin_file, rt.call_function('_get_plugin_data_markup_translate', [var_plugin_file.dup(), var_plugin_data.dup(), rt.new_bool(false), rt.new_bool(true)]))
		}
	}
	mut var_total_this_page := var_totals.array_get(var_status)
	mut var_js_plugins := rt.new_array()
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_list := item_1.val
			mut var_key := item_1.key
			var_js_plugins.array_set(var_key, rt.func_array_keys(var_list.dup()))
		}
	}
	rt.call_function('wp_localize_script', [rt.new_string('updates'), rt.new_string('_wpUpdatesItemCounts'), rt.create_array([rt.ArrayItem{ key: 'plugins', val: var_js_plugins }, rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data', []rt.PhpVal{}) }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_orderby)))) {
		var_orderby = rt.new_string(rt.new_string('Name'))
	} else {
		var_orderby = rt.call_function('ucfirst', [var_orderby.dup()])
	}
	var_order = rt.new_string(rt.new_string(var_order.dup().to_string().to_upper()))
	rt.call_function('uasort', [rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: '_order_callback' }])])
	mut var_plugins_per_page := this.get_items_per_page(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), (rt.get_property(var_screen, 'id')).str() + '_per_page']), rt.new_int(999))
	mut var_start := rt.mul(rt.sub(var_page, rt.new_int(1)), var_plugins_per_page)
	if rt.is_true(rt.greater(var_total_this_page, var_plugins_per_page)) {
		this.dispatch_set_prop('items', rt.call_function('array_slice', [rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'items'), var_start.dup(), var_plugins_per_page.dup()]))
	}
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_this_page }, rt.ArrayItem{ key: 'per_page', val: var_plugins_per_page }]))
}

fn (mut this Class_WP_Plugins_List_Table) _search_callback(var_plugin rt.PhpVal) bool {
	mut var_s := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := var_plugin.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_Plugins_List_Table) _order_callback(var_plugin_a rt.PhpVal, var_plugin_b rt.PhpVal) i64 {
	mut var_orderby := rt.new_null()
	mut var_order := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_a := var_plugin_a.array_get(var_orderby)
	mut var_b := var_plugin_b.array_get(var_orderby)
	if rt.is_true(rt.identical(var_a, var_b)) {
		return 0
	}
	if rt.is_true(rt.identical(rt.new_string('DESC'), var_order)) {
		return (rt.call_function('strcasecmp', [var_b.dup(), var_a.dup()])).to_i64()
	} else {
		return (rt.call_function('strcasecmp', [var_a.dup(), var_b.dup()])).to_i64()
	}
	return i64(0)
}

fn (mut this Class_WP_Plugins_List_Table) no_items()  {
	mut var_plugins := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s'))) {
		mut var_s := rt.call_function('esc_html', [rt.call_function('urldecode', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])])])
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('No plugins found for: %s.')]), '<strong>' + (var_s).str() + '</strong>'])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])))) {
			print(' <a href="' + (rt.call_function('esc_url', [])).str() + '">' + (rt.call_function('__', [rt.new_string('Search for plugins in the WordPress Plugin Directory.')])).str() + '</a>')
		}
	} else if !(!rt.is_true(var_plugins.array_get('all'))) {
		rt.call_function('_e', [rt.new_string('No plugins found.')])
	} else {
		rt.call_function('_e', [rt.new_string('No plugins are currently available.')])
	}
}

fn (mut this Class_WP_Plugins_List_Table) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal)  {
	mut var_text_mutated := var_text
	mut var_input_id_mutated := var_input_id
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s')) && rt.is_true(rt.new_bool(!(rt.is_true(this.has_items())))))) {
		return rt.new_null()
	}
	var_input_id_mutated = rt.new_string((var_input_id_mutated).str() + '-search-input')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('orderby'))) {
		print( + )
	}
	if !(!rt.is_true(.array_get())) {
		print()
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Plugins_List_Table) get_columns() rt.PhpVal {
	mut var_status := rt.new_null()
}

fn (mut this Class_WP_Plugins_List_Table) get_sortable_columns() rt.PhpVal {
}

fn (mut this Class_WP_Plugins_List_Table) get_views() rt.PhpVal {
	mut var_totals := rt.new_null()
	mut var_status := rt.new_null()
}

fn (mut this Class_WP_Plugins_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_status := rt.new_null()
}

fn (mut this Class_WP_Plugins_List_Table) bulk_actions(which string)  {
	mut var_status := rt.new_null()
}

fn (mut this Class_WP_Plugins_List_Table) extra_tablenav(var_which rt.PhpVal)  {
	mut var_status := rt.new_null()
}

fn (mut this Class_WP_Plugins_List_Table) current_action() string {
}

fn (mut this Class_WP_Plugins_List_Table) display_rows()  {
	mut var_status := rt.new_null()
}

fn (mut this Class_WP_Plugins_List_Table) single_row(var_item rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_page := rt.new_null()
	mut var_s := rt.new_null()
	mut var_totals := rt.new_null()
	mut var_plugin_id_attrs := []rt.PhpVal{}
	mut var_plugin_file := rt.new_null()
	mut var_plugin_data := rt.new_null()
	mut var_columns := map[string]rt.PhpVal{}
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
}

fn (mut this Class_WP_Plugins_List_Table) get_primary_column_name() string {
}

fn (mut this Class_WP_Plugins_List_Table) add_dependents_to_dependency_plugin_row(var_dependency rt.PhpVal)  {
}

fn (mut this Class_WP_Plugins_List_Table) add_dependencies_to_dependent_plugin_row(var_dependent rt.PhpVal)  {
}

fn (mut this Class_WP_Plugins_List_Table) get_dependency_view_details_link(var_name rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Plugins_List_Table) get_view_details_link(var_name rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_plugins_list_table(arg_0 rt.PhpVal) &Class_WP_Plugins_List_Table {
	mut obj := &Class_WP_Plugins_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Plugins_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return rt.new_int(this._order_callback(dispatch_arg_0, dispatch_arg_1))
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'search_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.search_box(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_views' {
			return this.get_views()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'bulk_actions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.bulk_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'current_action' {
			return rt.new_string(this.current_action())
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
		'get_primary_column_name' {
			return rt.new_string(this.get_primary_column_name())
		}
		'add_dependents_to_dependency_plugin_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_dependents_to_dependency_plugin_row(dispatch_arg_0)
			return rt.new_null()
		}
		'add_dependencies_to_dependent_plugin_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_dependencies_to_dependent_plugin_row(dispatch_arg_0)
			return rt.new_null()
		}
		'get_dependency_view_details_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_dependency_view_details_link(dispatch_arg_0, dispatch_arg_1)
		}
		'get_view_details_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_view_details_link(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Plugins_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'show_autoupdates' { return rt.new_bool(this.show_autoupdates) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Plugins_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_class_wp_plugins_list_table_php() {
}
