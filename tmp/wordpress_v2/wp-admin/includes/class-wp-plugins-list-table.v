import rt
import crypto.md5

struct Class_WP_Plugins_List_Table {
	rt.PhpObjectBase
pub mut:
	show_autoupdates bool
}

fn (mut this Class_WP_Plugins_List_Table) construct(var_args rt.PhpVal) {
	mut var_status := rt.get_superglobal('status')
	mut var_page := rt.get_superglobal('page')
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'plural', val: 'plugins' },
		rt.ArrayItem{
			key: 'screen'
			val: if !(var_args.array_get(rt.new_string('screen'))).is_null() {
				var_args.array_get(rt.new_string('screen'))
			} else {
				rt.new_null()
			}
		},
	]))
	var_status = rt.new_string('all')
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('plugin_status')) {
		var_status = rt.call_function('sanitize_key', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('plugin_status')),
		])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) {
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('add_query_arg', [
			rt.new_string('s'),
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]),
		]))
	}
	var_page = this.get_pagenum()
	this.show_autoupdates =
		rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('plugin')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'screen'), 'in_admin', [rt.new_string('network')]))
}

fn (mut this Class_WP_Plugins_List_Table) get_table_classes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'widefat' },
		rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('WP_Plugins_List_Table', [
			'WP_List_Table',
		], &this), '_args').array_get(rt.new_string('plural')) }])
}

fn (mut this Class_WP_Plugins_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('activate_plugins')])
}

fn (mut this Class_WP_Plugins_List_Table) prepare_items() {
	mut var_page := rt.new_null()
	mut var_s := rt.new_null()
	mut var_status := rt.get_superglobal('status')
	mut var_plugins := rt.get_superglobal('plugins')
	mut var_totals := rt.get_superglobal('totals')
	mut var_orderby := rt.get_superglobal('orderby')
	mut var_order := rt.get_superglobal('order')
	var_orderby = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')),
		]) } else { rt.new_string('') }
	var_order = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')),
		]) } else { rt.new_string('') }
	mut var_all_plugins := rt.call_function('apply_filters', [
		rt.new_string('all_plugins'),
		rt.call_function('get_plugins', []rt.PhpVal{}),
	])
	var_plugins = rt.create_array([rt.ArrayItem{ key: 'all', val: var_all_plugins },
		rt.ArrayItem{ key: 'search', val: rt.new_array() }, rt.ArrayItem{
			key: 'active'
			val: rt.new_array()
		}, rt.ArrayItem{ key: 'inactive', val: rt.new_array() },
		rt.ArrayItem{ key: 'recently_activated', val: rt.new_array() },
		rt.ArrayItem{ key: 'upgrade', val: rt.new_array() }, rt.ArrayItem{
			key: 'mustuse'
			val: rt.new_array()
		}, rt.ArrayItem{ key: 'dropins', val: rt.new_array() },
		rt.ArrayItem{ key: 'paused', val: rt.new_array() }])
	if this.show_autoupdates {
		mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('auto_update_plugins'),
			rt.new_array(),
		]))
		var_plugins.array_set('auto-update-enabled', rt.new_array())
		var_plugins.array_set('auto-update-disabled', rt.new_array())
	}
	mut var_screen := rt.get_property(rt.new_object('WP_Plugins_List_Table', [
		'WP_List_Table',
	], &this), 'screen')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| (rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')]))) {
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('show_advanced_plugins'),
			rt.new_bool(true),
			rt.new_string('mustuse'),
		]))
		{
			var_plugins.array_set('mustuse', rt.call_function('get_mu_plugins', []rt.PhpVal{}))
		}
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('show_advanced_plugins'),
			rt.new_bool(true),
			rt.new_string('dropins'),
		]))
		{
			var_plugins.array_set('dropins', rt.call_function('get_dropins', []rt.PhpVal{}))
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_plugins'),
		]))
		{
			mut var_current := rt.call_function('get_site_transient', [
				rt.new_string('update_plugins'),
			])
			mut iter_1 := rt.cast_array(var_plugins.array_get(rt.new_string('all'))).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_plugin_data := item_1.val
				mut var_plugin_file := item_1.key
				if rt.get_property(var_current, 'response').array_isset(var_plugin_file) {
					var_plugins.array_get_mut('all').array_get_mut(var_plugin_file).array_set('update',
						true)
					var_plugins.array_get_mut('upgrade').array_set(var_plugin_file,
						var_plugins.array_get(rt.new_string('all')).array_get(var_plugin_file))
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [
		rt.new_string('network'),
	])))))
	{
		mut var_show := rt.call_function('current_user_can', [
			rt.new_string('manage_network_plugins'),
		])
		mut var_show_network_active := rt.call_function('apply_filters', [
			rt.new_string('show_network_active_plugins'),
			var_show.clone(),
		])
	}
	if rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])) {
		mut var_recently_activated := rt.call_function('get_site_option', [
			rt.new_string('recently_activated'),
			rt.new_array(),
		])
	} else {
		var_recently_activated = rt.call_function('get_option', [
			rt.new_string('recently_activated'),
			rt.new_array(),
		])
	}
	mut iter_2 := var_recently_activated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_time := item_2.val
		mut var_key := item_2.key
		if !(var_time.clone().is_long())
			|| rt.is_true(rt.less(rt.add(var_time, rt.get_constant('WEEK_IN_SECONDS')), rt.call_function('time', []rt.PhpVal{}))) {
			var_recently_activated.array_unset(var_key)
		}
	}
	if rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])) {
		rt.call_function('update_site_option', [rt.new_string('recently_activated'),
			var_recently_activated.clone()])
	} else {
		rt.call_function('update_option', [rt.new_string('recently_activated'),
			var_recently_activated.clone(), rt.new_bool(false)])
	}
	mut var_plugin_info := rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	mut iter_3 := rt.cast_array(var_plugins.array_get(rt.new_string('all'))).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin_data := item_3.val
		mut var_plugin_file := item_3.key
		if rt.get_property(var_plugin_info, 'response').array_isset(var_plugin_file) {
			var_plugin_data = rt.call_function('array_merge', [
				rt.cast_array(rt.get_property(var_plugin_info, 'response').array_get(var_plugin_file)),
				rt.create_array([rt.ArrayItem{ key: 'update-supported', val: true }]),
				var_plugin_data.clone(),
			])
		} else if rt.get_property(var_plugin_info, 'no_update').array_isset(var_plugin_file) {
			var_plugin_data = rt.call_function('array_merge', [
				rt.cast_array(rt.get_property(var_plugin_info, 'no_update').array_get(var_plugin_file)),
				rt.create_array([rt.ArrayItem{ key: 'update-supported', val: true }]),
				var_plugin_data.clone(),
			])
		} else if !rt.is_true(var_plugin_data.array_get(rt.new_string('update-supported'))) {
			var_plugin_data.array_set('update-supported', false)
		}
		mut var_filter_payload := rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_plugin_file },
			rt.ArrayItem{ key: 'slug', val: '' },
			rt.ArrayItem{ key: 'plugin', val: var_plugin_file },
			rt.ArrayItem{ key: 'new_version', val: '' },
			rt.ArrayItem{ key: 'url', val: '' },
			rt.ArrayItem{ key: 'package', val: '' },
			rt.ArrayItem{ key: 'icons', val: rt.new_array() },
			rt.ArrayItem{ key: 'banners', val: rt.new_array() },
			rt.ArrayItem{ key: 'banners_rtl', val: rt.new_array() },
			rt.ArrayItem{ key: 'tested', val: '' },
			rt.ArrayItem{ key: 'requires_php', val: '' },
			rt.ArrayItem{ key: 'compatibility', val: create_stdclass() },
		])
		var_filter_payload = rt.array_to_object(rt.call_function('wp_parse_args', [
			var_plugin_data.clone(),
			var_filter_payload.clone(),
		]))
		mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [
			rt.new_string('plugin'),
			rt.new_null(),
			var_filter_payload.clone(),
		])
		if !(var_auto_update_forced.clone().is_null()) {
			var_plugin_data.array_set('auto-update-forced', var_auto_update_forced.clone())
		}
		var_plugins.array_get_mut('all').array_set(var_plugin_file, var_plugin_data.clone())
		if var_plugins.array_get(rt.new_string('upgrade')).array_isset(var_plugin_file) {
			var_plugins.array_get_mut('upgrade').array_set(var_plugin_file, var_plugin_data.clone())
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])))))
			&& rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin_file.clone()]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [var_plugin_file.clone()]))))) {
			if rt.is_true(var_show_network_active) {
				var_plugins.array_get_mut('inactive').array_set(var_plugin_file,
					var_plugin_data.clone())
			} else {
				var_plugins.array_get(rt.new_string('all')).array_unset(var_plugin_file)
			}
		} else if
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])))))
			&& rt.is_true(rt.call_function('is_plugin_active_for_network', [var_plugin_file.clone()])) {
			if rt.is_true(var_show_network_active) {
				var_plugins.array_get_mut('active').array_set(var_plugin_file,
					var_plugin_data.clone())
			} else {
				var_plugins.array_get(rt.new_string('all')).array_unset(var_plugin_file)
			}
		} else if (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])))))
			&& rt.is_true(rt.call_function('is_plugin_active', [var_plugin_file.clone()])))
			|| (rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')]))
			&& rt.is_true(rt.call_function('is_plugin_active_for_network', [var_plugin_file.clone()]))) {
			var_plugins.array_get_mut('active').array_set(var_plugin_file, var_plugin_data.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])))))
				&& rt.is_true(rt.call_function('is_plugin_paused', [var_plugin_file.clone()])) {
				var_plugins.array_get_mut('paused').array_set(var_plugin_file,
					var_plugin_data.clone())
			}
		} else {
			if var_recently_activated.array_isset(var_plugin_file) {
				var_plugins.array_get_mut('recently_activated').array_set(var_plugin_file,
					var_plugin_data.clone())
			}
			var_plugins.array_get_mut('inactive').array_set(var_plugin_file,
				var_plugin_data.clone())
		}
		if this.show_autoupdates {
			mut var_enabled := rt.new_bool(
				rt.is_true(rt.call_function('in_array', [var_plugin_file.clone(), var_auto_updates.clone(), rt.new_bool(true)]))
				&& rt.is_true(var_plugin_data.array_get(rt.new_string('update-supported'))))
			if var_plugin_data.array_isset(rt.new_string('auto-update-forced')) {
				var_enabled =
					rt.new_bool((var_plugin_data.array_get(rt.new_string('auto-update-forced'))).to_bool())
			}
			if rt.is_true(var_enabled) {
				var_plugins.array_get_mut('auto-update-enabled').array_set(var_plugin_file,
					var_plugin_data.clone())
			} else {
				var_plugins.array_get_mut('auto-update-disabled').array_set(var_plugin_file,
					var_plugin_data.clone())
			}
		}
	}
	if rt.is_true(rt.new_int(var_s.clone().to_string().len)) {
		var_status = rt.new_string('search')
		var_plugins.array_set('search', rt.call_function('array_filter', [
			var_plugins.array_get(rt.new_string('all')),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Plugins_List_Table', [
					'WP_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: '_search_callback' },
			]),
		]))
	}
	var_plugins = rt.call_function('apply_filters', [rt.new_string('plugins_list'),
		var_plugins.clone()])
	var_totals = rt.new_array()
	mut iter_4 := var_plugins.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_list := item_4.val
		mut var_type := item_4.key
		var_totals.array_set(var_type, var_list.clone().array_count())
	}
	if !rt.is_true(var_plugins.array_get(var_status))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'all'
	}, rt.ArrayItem{ key: none, val: 'search' }]), rt.new_bool(true)]))))) {
		var_status = rt.new_string('all')
	}
	this.dispatch_set_prop('items', rt.new_array())
	mut iter_5 := var_plugins.array_get(var_status).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_plugin_data := item_5.val
		mut var_plugin_file := item_5.key
		rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'items').array_set(var_plugin_file, rt.call_function('_get_plugin_data_markup_translate', [
			var_plugin_file.clone(),
			var_plugin_data.clone(),
			rt.new_bool(false),
			rt.new_bool(true),
		]))
	}
	mut var_total_this_page := var_totals.array_get(var_status)
	mut var_js_plugins := rt.new_array()
	mut iter_6 := var_plugins.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_list := item_6.val
		mut var_key := item_6.key
		var_js_plugins.array_set(var_key, rt.func_array_keys(var_list.clone()))
	}
	rt.call_function('wp_localize_script', [rt.new_string('updates'),
		rt.new_string('_wpUpdatesItemCounts'),
		rt.create_array([
			rt.ArrayItem{ key: 'plugins', val: var_js_plugins },
			rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data', []rt.PhpVal{}) },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_orderby)))) {
		var_orderby = rt.new_string('Name')
	} else {
		var_orderby = rt.call_function('ucfirst', [var_orderby.clone()])
	}
	var_order = rt.new_string(var_order.clone().to_string().to_upper())
	rt.call_function('uasort', [
		rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'items'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Plugins_List_Table', [
			'WP_List_Table',
		], &this) }, rt.ArrayItem{ key: none, val: '_order_callback' }]),
	])
	mut var_plugins_per_page := this.get_items_per_page(rt.call_function('str_replace', [
		rt.new_string('-'),
		rt.new_string('_'),
		rt.new_string((rt.get_property(var_screen, 'id')).str() + '_per_page'),
	]), rt.new_int(999))
	mut var_start := rt.mul(rt.sub(var_page, rt.new_int(1)), var_plugins_per_page)
	if rt.is_true(rt.greater(var_total_this_page, var_plugins_per_page)) {
		this.dispatch_set_prop('items', rt.call_function('array_slice', [
			rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this),
				'items'),
			var_start.clone(),
			var_plugins_per_page.clone(),
		]))
	}
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: var_total_this_page },
		rt.ArrayItem{ key: 'per_page', val: var_plugins_per_page },
	]))
}

fn (mut this Class_WP_Plugins_List_Table) _search_callback(var_plugin rt.PhpVal) bool {
	mut var_s := rt.new_null()
	mut iter_7 := var_plugin.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		if var_value.clone().is_string()
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.call_function('strip_tags', [var_value.clone()]), rt.call_function('urldecode', [var_s.clone()])]))))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Plugins_List_Table) _order_callback(var_plugin_a rt.PhpVal, var_plugin_b rt.PhpVal) i64 {
	mut var_orderby := rt.new_null()
	mut var_order := rt.new_null()
	mut var_a := var_plugin_a.array_get(var_orderby)
	mut var_b := var_plugin_b.array_get(var_orderby)
	if rt.is_true(rt.identical(var_a, var_b)) {
		return 0
	}
	if rt.is_true(rt.identical(rt.new_string('DESC'), var_order)) {
		return (rt.call_function('strcasecmp', [var_b.clone(),
			var_a.clone()])).to_i64()
	} else {
		return (rt.call_function('strcasecmp', [var_a.clone(),
			var_b.clone()])).to_i64()
	}
	return i64(0)
}

fn (mut this Class_WP_Plugins_List_Table) no_items() {
	mut var_plugins := rt.new_null()
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) {
		mut var_s := rt.call_function('esc_html', [
			rt.call_function('urldecode', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]),
			]),
		])
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('No plugins found for: %s.')]),
			rt.new_string('<strong>' + var_s.str() + '</strong>'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
			print(' <a href="' +
				(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugin-install.php?tab=search&s=' + (rt.call_function('urlencode', [var_s.clone()])).str())])])).str() +
				'">' +
				(rt.call_function('__', [rt.new_string('Search for plugins in the WordPress Plugin Directory.')])).str() +
				'</a>')
		}
	} else if !(!rt.is_true(var_plugins.array_get(rt.new_string('all')))) {
		rt.call_function('_e', [rt.new_string('No plugins found.')])
	} else {
		rt.call_function('_e', [rt.new_string('No plugins are currently available.')])
	}
}

fn (mut this Class_WP_Plugins_List_Table) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal) {
	mut var_text_mutated := var_text
	mut var_input_id_mutated := var_input_id
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.has_items())))) {
		return
	}
	var_input_id_mutated = rt.new_string(var_input_id_mutated.str() + '-search-input')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))) {
		print('<input type="hidden" name="orderby" value="' +
			(rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))])).str() +
			'" />')
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))) {
		print('<input type="hidden" name="order" value="' +
			(rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))])).str() +
			'" />')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_text_mutated)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_admin_search_query', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [var_text_mutated.clone(),
		rt.new_string('hide-if-js'), rt.new_string(''), rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'search-submit' }])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Plugins_List_Table) get_columns() rt.PhpVal {
	mut var_status := rt.new_null()
	mut var_columns := {
		'cb':          if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_status.clone(),
			map[string]rt.PhpVal{},
			rt.new_bool(true),
		])))))
		{ '<input type="checkbox" />' } else { '' }
		'name':        rt.call_function('__', [rt.new_string('Plugin')])
		'description': rt.call_function('__', [rt.new_string('Description')])
	}
	if this.show_autoupdates
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'mustuse'
	}, rt.ArrayItem{ key: none, val: 'dropins' }]), rt.new_bool(true)]))))) {
		var_columns['auto-updates'] = rt.call_function('__', [
			rt.new_string('Automatic Updates'),
		])
	}
	return var_columns.clone()
}

fn (mut this Class_WP_Plugins_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_Plugins_List_Table) get_views() rt.PhpVal {
	mut var_totals := rt.new_null()
	mut var_status := rt.new_null()
	mut var_status_links := rt.new_array()
	mut iter_8 := var_totals.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_count := item_8.val
		mut var_type := item_8.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_count)))) {
			continue
		}
		mut switch_val_1 := var_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('all'))) {
			mut var_text := rt.call_function('_nx', [
				rt.new_string('All <span class="count">(%s)</span>'),
				rt.new_string('All <span class="count">(%s)</span>'),
				var_count.clone(),
				rt.new_string('plugins'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('active'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Active <span class="count">(%s)</span>'),
				rt.new_string('Active <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recently_activated'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Recently Active <span class="count">(%s)</span>'),
				rt.new_string('Recently Active <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('inactive'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Inactive <span class="count">(%s)</span>'),
				rt.new_string('Inactive <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mustuse'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Must-Use <span class="count">(%s)</span>'),
				rt.new_string('Must-Use <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('dropins'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Drop-in <span class="count">(%s)</span>'),
				rt.new_string('Drop-ins <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('paused'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Paused <span class="count">(%s)</span>'),
				rt.new_string('Paused <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrade'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Update Available <span class="count">(%s)</span>'),
				rt.new_string('Update Available <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-update-enabled'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Auto-updates Enabled <span class="count">(%s)</span>'),
				rt.new_string('Auto-updates Enabled <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-update-disabled'))) {
			var_text = rt.call_function('_n', [
				rt.new_string('Auto-updates Disabled <span class="count">(%s)</span>'),
				rt.new_string('Auto-updates Disabled <span class="count">(%s)</span>'),
				var_count.clone(),
			])
		} else {
			var_text = rt.call_function('apply_filters', [
				rt.new_string('plugins_list_status_text'),
				rt.new_string(''),
				var_count.clone(),
				var_type.clone(),
			])
			if !rt.is_true(var_text) || !(var_text.clone().is_string()) {
				var_text = var_type
			}
			var_text = rt.new_string((rt.call_function('esc_html', [var_text.clone()])).str() +
				' ' +(rt.call_function('sprintf', [rt.new_string('<span class="count">(%s)</span>'), rt.call_function('number_format_i18n', [var_count.clone()])])).str())
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('search'), var_type)))) {
			var_status_links.array_set(var_type, rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('add_query_arg', [
					rt.new_string('plugin_status'),
					var_type.clone(),
					rt.new_string('plugins.php'),
				]) },
				rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
					var_text.clone(),
					rt.call_function('number_format_i18n', [var_count.clone()]),
				]) },
				rt.ArrayItem{ key: 'current', val: rt.identical(var_type, var_status) },
			]))
		}
	}
	return this.get_views_links(var_status_links.clone())
}

fn (mut this Class_WP_Plugins_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_status := rt.new_null()
	mut var_actions := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('active'), var_status)))) {
		var_actions.array_set('activate-selected', if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_Plugins_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'in_admin', [rt.new_string('network')]))
		{ rt.call_function('_x', [rt.new_string('Network Activate'),
				rt.new_string('plugin')]) } else { rt.call_function('_x', [
				rt.new_string('Activate'),
				rt.new_string('plugin'),
			]) })
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('inactive'), var_status))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('recent'), var_status)))) {
		var_actions.array_set('deactivate-selected', if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_Plugins_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'in_admin', [rt.new_string('network')]))
		{ rt.call_function('_x', [rt.new_string('Network Deactivate'),
				rt.new_string('plugin')]) } else { rt.call_function('_x', [
				rt.new_string('Deactivate'),
				rt.new_string('plugin'),
			]) })
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'screen'), 'in_admin', [rt.new_string('network')])) {
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_plugins'),
		]))
		{
			var_actions.array_set('update-selected', rt.call_function('__', [
				rt.new_string('Update'),
			]))
		}
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_plugins')]))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('active'), var_status)))) {
			var_actions.array_set('delete-selected', rt.call_function('__', [
				rt.new_string('Delete'),
			]))
		}
		if this.show_autoupdates {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-update-enabled'),
				var_status))))
			{
				var_actions.array_set('enable-auto-update-selected', rt.call_function('__', [
					rt.new_string('Enable Auto-updates'),
				]))
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-update-disabled'),
				var_status))))
			{
				var_actions.array_set('disable-auto-update-selected', rt.call_function('__', [
					rt.new_string('Disable Auto-updates'),
				]))
			}
		}
	}
	return var_actions.clone()
}

fn (mut this Class_WP_Plugins_List_Table) bulk_actions(which string) {
	mut var_status := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [var_status.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'mustuse' },
			rt.ArrayItem{ key: none, val: 'dropins' }]),
		rt.new_bool(true)]))
	{
		return
	}
	this.Class_WP_List_Table.bulk_actions(rt.new_string(which))
}

fn (mut this Class_WP_Plugins_List_Table) extra_tablenav(var_which rt.PhpVal) {
	mut var_status := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_status.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'recently_activated' },
			rt.ArrayItem{ key: none, val: 'mustuse' },
			rt.ArrayItem{ key: none, val: 'dropins' },
		]),
		rt.new_bool(true)])))))
	{
		return
	}
	print('<div class="alignleft actions">')
	if rt.is_true(rt.identical(rt.new_string('recently_activated'), var_status)) {
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Clear List')]),
			rt.new_string(''),
			rt.new_string('clear-recent-list'),
			rt.new_bool(false),
		])
	} else if rt.is_true(rt.identical(rt.new_string('top'), var_which))
		&& rt.is_true(rt.identical(rt.new_string('mustuse'), var_status)) {
		print('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Files in the %s directory are executed automatically.')]), rt.new_string('<code>' + (rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string('/'), rt.get_constant('WPMU_PLUGIN_DIR')])).str() +
			'</code>')])).str() + '</p>')
	} else if rt.is_true(rt.identical(rt.new_string('top'), var_which))
		&& rt.is_true(rt.identical(rt.new_string('dropins'), var_status)) {
		print('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Drop-ins are single files, found in the %s directory, that replace or enhance WordPress features in ways that are not possible for traditional plugins.')]), rt.new_string('<code>' + (rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), rt.get_constant('WP_CONTENT_DIR')])).str() +
			'</code>')])).str() + '</p>')
	}
	print('</div>')
}

fn (mut this Class_WP_Plugins_List_Table) current_action() string {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('clear-recent-list')) {
		return 'clear-recent-list'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_WP_Plugins_List_Table) display_rows() {
	mut var_status := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_Plugins_List_Table', ['WP_List_Table'], &this), 'screen'), 'in_admin', [rt.new_string('network')])))))
		&& rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'mustuse'
	}, rt.ArrayItem{ key: none, val: 'dropins' }]), rt.new_bool(true)])) {
		return
	}
	mut iter_9 := rt.get_property(rt.new_object('WP_Plugins_List_Table', [
		'WP_List_Table',
	], &this), 'items').iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_plugin_data := item_9.val
		mut var_plugin_file := item_9.key
		this.single_row(rt.create_array([rt.ArrayItem{ key: none, val: var_plugin_file },
			rt.ArrayItem{ key: none, val: var_plugin_data }]))
	}
}

fn (mut this Class_WP_Plugins_List_Table) single_row(var_item rt.PhpVal) {
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
	mut list_tmp_1 := var_item
	var_plugin_file = list_tmp_1.array_get(0)
	var_plugin_data = list_tmp_1.array_get(1)
	mut var_plugin_slug := if !(var_plugin_data.array_get(rt.new_string('slug'))).is_null() { var_plugin_data.array_get(rt.new_string('slug')) } else { rt.call_function('sanitize_title', [
			var_plugin_data.array_get(rt.new_string('Name')),
		]) }
	mut var_plugin_id_attr := var_plugin_slug.clone()
	mut var_suffix := rt.new_int(2)
	for rt.is_true(rt.call_function('in_array', [var_plugin_id_attr.clone(),
		rt.create_array_from_list(var_plugin_id_attrs), rt.new_bool(true)])) {
		var_plugin_id_attr =
			rt.new_string('${var_plugin_slug.to_string()}-${var_suffix.to_string()}')
		rt.pre_inc(var_suffix)
	}
	var_plugin_id_attrs << var_plugin_id_attr.clone()
	mut var_context := var_status.clone()
	mut var_screen := rt.get_property(rt.new_object('WP_Plugins_List_Table', [
		'WP_List_Table',
	], &this), 'screen')
	mut var_actions := rt.create_array([rt.ArrayItem{ key: 'deactivate', val: '' },
		rt.ArrayItem{ key: 'activate', val: '' }, rt.ArrayItem{ key: 'details', val: '' },
		rt.ArrayItem{ key: 'delete', val: '' }])
	mut var_restrict_network_active := rt.new_bool(false)
	mut var_restrict_network_only := rt.new_bool(false)
	mut var_requires_php := if !(var_plugin_data.array_get(rt.new_string('RequiresPHP'))).is_null() {
		var_plugin_data.array_get(rt.new_string('RequiresPHP'))
	} else {
		rt.new_null()
	}
	mut var_requires_wp := if !(var_plugin_data.array_get(rt.new_string('RequiresWP'))).is_null() {
		var_plugin_data.array_get(rt.new_string('RequiresWP'))
	} else {
		rt.new_null()
	}
	mut var_compatible_php := rt.call_function('is_php_version_compatible', [
		var_requires_php.clone()])
	mut var_compatible_wp := rt.call_function('is_wp_version_compatible', [
		var_requires_wp.clone()])
	mut iife_temp_0 := Class_WP_Plugin_Dependencies{}
	mut iife_result_0 := iife_temp_0.has_dependents(var_plugin_file.clone())
	mut var_has_dependents := iife_result_0
	mut iife_temp_1 := Class_WP_Plugin_Dependencies{}
	mut iife_result_1 := iife_temp_1.has_active_dependents(var_plugin_file.clone())
	mut var_has_active_dependents := iife_result_1
	mut iife_temp_2 := Class_WP_Plugin_Dependencies{}
	mut iife_result_2 := iife_temp_2.has_unmet_dependencies(var_plugin_file.clone())
	mut var_has_unmet_dependencies := iife_result_2
	mut iife_temp_3 := Class_WP_Plugin_Dependencies{}
	mut iife_result_3 := iife_temp_3.has_circular_dependency(var_plugin_file.clone())
	mut var_has_circular_dependency := iife_result_3
	if rt.is_true(rt.identical(rt.new_string('mustuse'), var_context)) {
		mut var_is_active := rt.new_bool(true)
	} else if rt.is_true(rt.identical(rt.new_string('dropins'), var_context)) {
		mut var_dropins := rt.call_function('_get_dropins', []rt.PhpVal{})
		mut var_plugin_name := var_plugin_file
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_plugin_file,
			var_plugin_data.array_get(rt.new_string('Name'))))))
		{
			var_plugin_name = rt.concat(var_plugin_name, rt.new_string('<br />' +
				(var_plugin_data.array_get(rt.new_string('Name'))).str()))
		}
		if rt.is_true(rt.identical(rt.new_bool(true),
			var_dropins.array_get(var_plugin_file).array_get(rt.new_int(1))))
		{
			var_is_active = rt.new_bool(true)
			mut var_description := rt.new_string('<p><strong>' +
				(var_dropins.array_get(var_plugin_file).array_get(rt.new_int(0))).str() + '</strong></p>')
		} else if
			rt.is_true(rt.call_function('defined', [var_dropins.array_get(var_plugin_file).array_get(rt.new_int(1))]))
			&& rt.is_true(rt.call_function('constant', [var_dropins.array_get(var_plugin_file).array_get(rt.new_int(1))])) {
			var_is_active = rt.new_bool(true)
			var_description = rt.new_string('<p><strong>' +
				(var_dropins.array_get(var_plugin_file).array_get(rt.new_int(0))).str() + '</strong></p>')
		} else {
			var_is_active = rt.new_bool(false)
			var_description = rt.new_string('<p><strong>' +
				(var_dropins.array_get(var_plugin_file).array_get(rt.new_int(0))).str() + ' <span class="error-message">' + (rt.call_function('__', [rt.new_string('Inactive:')])).str() +
				'</span></strong> ' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Requires %1$s in %2$s file.')]), rt.new_string("<code>define('" + (var_dropins.array_get(var_plugin_file).array_get(rt.new_int(1))).str() + "', true);</code>"), rt.new_string('<code>wp-config.php</code>')])).str() +
				'</p>')
		}
		if rt.is_true(var_plugin_data.array_get(rt.new_string('Description'))) {
			var_description = rt.concat(var_description, rt.new_string('<p>' +
				(var_plugin_data.array_get(rt.new_string('Description'))).str() + '</p>'))
		}
	} else {
		if rt.is_true(rt.call_method(var_screen, 'in_admin', [
			rt.new_string('network')]))
		{
			var_is_active = rt.call_function('is_plugin_active_for_network', [
				var_plugin_file.clone()])
		} else {
			var_is_active = rt.call_function('is_plugin_active', [
				var_plugin_file.clone()])
			var_restrict_network_active = rt.new_bool(
				rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.call_function('is_plugin_active_for_network', [var_plugin_file.clone()])))
			var_restrict_network_only = rt.new_bool(
				rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin_file.clone()]))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_active)))))
		}
		if rt.is_true(rt.call_method(var_screen, 'in_admin', [
			rt.new_string('network')]))
		{
			if rt.is_true(var_is_active) {
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('manage_network_plugins'),
				]))
				{
					if rt.is_true(var_has_active_dependents) {
						var_actions.array_set('deactivate',
							(rt.call_function('__', [rt.new_string('Network Deactivate')])).str() +
							'<span class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('You cannot deactivate this plugin as other plugins require it.')])).str() +
							'</span>')
					} else {
						mut var_deactivate_url := rt.new_string('plugins.php?action=deactivate' +
							'&amp;plugin=' +
							(rt.call_function('urlencode', [var_plugin_file.clone()])).str() +
							'&amp;plugin_status=' + var_context.str() + '&amp;paged=' +
							var_page.str() + '&amp;s=' + var_s.str())
						var_actions.array_set('deactivate', rt.call_function('sprintf', [
							rt.new_string('<a href="%s" id="deactivate-%s" aria-label="%s">%s</a>'),
							rt.call_function('wp_nonce_url', [
								var_deactivate_url.clone(),
								rt.new_string('deactivate-plugin_' +
									var_plugin_file.str())]),
							rt.call_function('esc_attr', [var_plugin_id_attr.clone()]),
							rt.call_function('esc_attr', [
								rt.call_function('sprintf', [
									rt.call_function('_x', [
										rt.new_string('Network Deactivate %s'),
										rt.new_string('plugin'),
									]),
									var_plugin_data.array_get(rt.new_string('Name')),
								]),
							]),
							rt.call_function('_x', [
								rt.new_string('Network Deactivate'),
								rt.new_string('plugin'),
							]),
						]))
					}
				}
			} else {
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('manage_network_plugins'),
				]))
				{
					if rt.is_true(var_compatible_php) && rt.is_true(var_compatible_wp) {
						if rt.is_true(var_has_unmet_dependencies) {
							var_actions.array_set('activate',
								(rt.call_function('_x', [rt.new_string('Network Activate'), rt.new_string('plugin')])).str() +
								'<span class="screen-reader-text">' +
								(rt.call_function('__', [rt.new_string('You cannot activate this plugin as it has unmet requirements.')])).str() +
								'</span>')
						} else {
							mut var_activate_url := rt.new_string('plugins.php?action=activate' +
								'&amp;plugin=' +
								(rt.call_function('urlencode', [var_plugin_file.clone()])).str() +
								'&amp;plugin_status=' + var_context.str() + '&amp;paged=' +
								var_page.str() + '&amp;s=' + var_s.str())
							var_actions.array_set('activate', rt.call_function('sprintf', [
								rt.new_string('<a href="%s" id="activate-%s" class="edit" aria-label="%s">%s</a>'),
								rt.call_function('wp_nonce_url', [
									var_activate_url.clone(),
									rt.new_string('activate-plugin_' + var_plugin_file.str())]),
								rt.call_function('esc_attr', [
									var_plugin_id_attr.clone()]),
								rt.call_function('esc_attr', [
									rt.call_function('sprintf', [
										rt.call_function('_x', [
											rt.new_string('Network Activate %s'),
											rt.new_string('plugin'),
										]),
										var_plugin_data.array_get(rt.new_string('Name')),
									])]),
								rt.call_function('_x', [rt.new_string('Network Activate'),
									rt.new_string('plugin')]),
							]))
						}
					} else {
						var_actions.array_set('activate', rt.call_function('sprintf', [
							rt.new_string('<span>%s</span>'),
							rt.call_function('_x', [rt.new_string('Cannot Activate'),
								rt.new_string('plugin')]),
						]))
					}
				}
				if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_plugins')]))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [var_plugin_file.clone()]))))) {
					if rt.is_true(var_has_dependents)
						&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_circular_dependency)))) {
						var_actions.array_set('delete',
							(rt.call_function('__', [rt.new_string('Delete')])).str() +
							'<span class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('You cannot delete this plugin as other plugins require it.')])).str() +
							'</span>')
					} else {
						mut var_delete_url := rt.new_string('plugins.php?action=delete-selected' +
							'&amp;checked[]=' +
							(rt.call_function('urlencode', [var_plugin_file.clone()])).str() +
							'&amp;plugin_status=' + var_context.str() + '&amp;paged=' +
							var_page.str() + '&amp;s=' + var_s.str())
						var_actions.array_set('delete', rt.call_function('sprintf', [
							rt.new_string('<a href="%s" id="delete-%s" class="delete" aria-label="%s">%s</a>'),
							rt.call_function('wp_nonce_url', [
								var_delete_url.clone(), rt.new_string('bulk-plugins')]),
							rt.call_function('esc_attr', [var_plugin_id_attr.clone()]),
							rt.call_function('esc_attr', [
								rt.call_function('sprintf', [
									rt.call_function('_x', [rt.new_string('Delete %s'),
										rt.new_string('plugin')]),
									var_plugin_data.array_get(rt.new_string('Name')),
								]),
							]),
							rt.call_function('__', [
								rt.new_string('Delete'),
							]),
						]))
					}
				}
			}
		} else {
			if rt.is_true(var_restrict_network_active) {
				var_actions = rt.create_array([
					rt.ArrayItem{ key: 'network_active', val: rt.call_function('__', [
						rt.new_string('Network Active'),
					]) },
				])
			} else if rt.is_true(var_restrict_network_only) {
				var_actions = rt.create_array([
					rt.ArrayItem{ key: 'network_only', val: rt.call_function('__', [
						rt.new_string('Network Only'),
					]) },
				])
			} else if rt.is_true(var_is_active) {
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('deactivate_plugin'),
					var_plugin_file.clone(),
				]))
				{
					if rt.is_true(var_has_active_dependents) {
						var_actions.array_set('deactivate',
							(rt.call_function('__', [rt.new_string('Deactivate')])).str() +
							'<span class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('You cannot deactivate this plugin as other plugins depend on it.')])).str() +
							'</span>')
					} else {
						var_deactivate_url = rt.new_string('plugins.php?action=deactivate' +
							'&amp;plugin=' +
							(rt.call_function('urlencode', [var_plugin_file.clone()])).str() +
							'&amp;plugin_status=' + var_context.str() + '&amp;paged=' +
							var_page.str() + '&amp;s=' + var_s.str())
						var_actions.array_set('deactivate', rt.call_function('sprintf', [
							rt.new_string('<a href="%s" id="deactivate-%s" aria-label="%s">%s</a>'),
							rt.call_function('wp_nonce_url', [
								var_deactivate_url.clone(),
								rt.new_string('deactivate-plugin_' +
									var_plugin_file.str())]),
							rt.call_function('esc_attr', [var_plugin_id_attr.clone()]),
							rt.call_function('esc_attr', [
								rt.call_function('sprintf', [
									rt.call_function('_x', [
										rt.new_string('Deactivate %s'),
										rt.new_string('plugin'),
									]),
									var_plugin_data.array_get(rt.new_string('Name')),
								]),
							]),
							rt.call_function('__', [
								rt.new_string('Deactivate'),
							]),
						]))
					}
				}
				if rt.is_true(rt.call_function('current_user_can', [rt.new_string('resume_plugin'), var_plugin_file.clone()]))
					&& rt.is_true(rt.call_function('is_plugin_paused', [var_plugin_file.clone()])) {
					mut var_resume_url := rt.new_string('plugins.php?action=resume' +
						'&amp;plugin=' +
						(rt.call_function('urlencode', [var_plugin_file.clone()])).str() +
						'&amp;plugin_status=' + var_context.str() + '&amp;paged=' + var_page.str() +
						'&amp;s=' + var_s.str())
					var_actions.array_set('resume', rt.call_function('sprintf', [
						rt.new_string('<a href="%s" id="resume-%s" class="resume-link" aria-label="%s">%s</a>'),
						rt.call_function('wp_nonce_url', [var_resume_url.clone(),
							rt.new_string('resume-plugin_' + var_plugin_file.str())]),
						rt.call_function('esc_attr', [var_plugin_id_attr.clone()]),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('_x', [rt.new_string('Resume %s'),
									rt.new_string('plugin')]),
								var_plugin_data.array_get(rt.new_string('Name')),
							]),
						]),
						rt.call_function('__', [
							rt.new_string('Resume'),
						]),
					]))
				}
			} else {
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('activate_plugin'),
					var_plugin_file.clone(),
				]))
				{
					if rt.is_true(var_compatible_php) && rt.is_true(var_compatible_wp) {
						if rt.is_true(var_has_unmet_dependencies) {
							var_actions.array_set('activate',
								(rt.call_function('_x', [rt.new_string('Activate'), rt.new_string('plugin')])).str() +
								'<span class="screen-reader-text">' +
								(rt.call_function('__', [rt.new_string('You cannot activate this plugin as it has unmet requirements.')])).str() +
								'</span>')
						} else {
							var_activate_url = rt.new_string('plugins.php?action=activate' +
								'&amp;plugin=' +
								(rt.call_function('urlencode', [var_plugin_file.clone()])).str() +
								'&amp;plugin_status=' + var_context.str() + '&amp;paged=' +
								var_page.str() + '&amp;s=' + var_s.str())
							var_actions.array_set('activate', rt.call_function('sprintf', [
								rt.new_string('<a href="%s" id="activate-%s" class="edit" aria-label="%s">%s</a>'),
								rt.call_function('wp_nonce_url', [
									var_activate_url.clone(),
									rt.new_string('activate-plugin_' + var_plugin_file.str())]),
								rt.call_function('esc_attr', [
									var_plugin_id_attr.clone()]),
								rt.call_function('esc_attr', [
									rt.call_function('sprintf', [
										rt.call_function('_x', [
											rt.new_string('Activate %s'),
											rt.new_string('plugin'),
										]),
										var_plugin_data.array_get(rt.new_string('Name')),
									])]),
								rt.call_function('_x', [rt.new_string('Activate'),
									rt.new_string('plugin')]),
							]))
						}
					} else {
						var_actions.array_set('activate', rt.call_function('sprintf', [
							rt.new_string('<span>%s</span>'),
							rt.call_function('_x', [rt.new_string('Cannot Activate'),
								rt.new_string('plugin')]),
						]))
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_plugins')])) {
					if rt.is_true(var_has_dependents)
						&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_circular_dependency)))) {
						var_actions.array_set('delete',
							(rt.call_function('__', [rt.new_string('Delete')])).str() +
							'<span class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('You cannot delete this plugin as other plugins require it.')])).str() +
							'</span>')
					} else {
						var_delete_url = rt.new_string('plugins.php?action=delete-selected' +
							'&amp;checked[]=' +
							(rt.call_function('urlencode', [var_plugin_file.clone()])).str() +
							'&amp;plugin_status=' + var_context.str() + '&amp;paged=' +
							var_page.str() + '&amp;s=' + var_s.str())
						var_actions.array_set('delete', rt.call_function('sprintf', [
							rt.new_string('<a href="%s" id="delete-%s" class="delete" aria-label="%s">%s</a>'),
							rt.call_function('wp_nonce_url', [
								var_delete_url.clone(), rt.new_string('bulk-plugins')]),
							rt.call_function('esc_attr', [var_plugin_id_attr.clone()]),
							rt.call_function('esc_attr', [
								rt.call_function('sprintf', [
									rt.call_function('_x', [rt.new_string('Delete %s'),
										rt.new_string('plugin')]),
									var_plugin_data.array_get(rt.new_string('Name')),
								]),
							]),
							rt.call_function('__', [
								rt.new_string('Delete'),
							]),
						]))
					}
				}
			}
		}
	}
	var_actions = rt.call_function('array_filter', [var_actions.clone()])
	if rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])) {
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('network_admin_plugin_action_links'),
			var_actions.clone(),
			var_plugin_file.clone(),
			var_plugin_data.clone(),
			var_context.clone(),
		])
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('network_admin_plugin_action_links_${var_plugin_file.to_string()}'),
			var_actions.clone(),
			var_plugin_file.clone(),
			var_plugin_data.clone(),
			var_context.clone(),
		])
	} else {
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('plugin_action_links'),
			var_actions.clone(),
			var_plugin_file.clone(),
			var_plugin_data.clone(),
			var_context.clone(),
		])
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('plugin_action_links_${var_plugin_file.to_string()}'),
			var_actions.clone(),
			var_plugin_file.clone(),
			var_plugin_data.clone(),
			var_context.clone(),
		])
	}
	mut var_class :=
		rt.new_string((if rt.is_true(var_is_active) { 'active' } else { 'inactive' }).str())
	mut var_checkbox_id := rt.new_string('checkbox_' +
		md5.hexhash(var_plugin_file.clone().to_string()))
	mut var_disabled := rt.new_string('')
	if rt.is_true(var_has_dependents) || rt.is_true(var_has_unmet_dependencies) {
		var_disabled = rt.new_string('disabled')
	}
	if rt.is_true(var_restrict_network_active) || rt.is_true(var_restrict_network_only)
		|| rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'mustuse'
	}, rt.ArrayItem{ key: none, val: 'dropins' }]), rt.new_bool(true)]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
		mut var_checkbox := rt.new_string('')
	} else {
		var_checkbox = rt.call_function('sprintf', [
			rt.new_string('<label class="label-covers-full-cell" for="%1$s">' +
				'<span class="screen-reader-text">%2$s</span></label>' +
				'<input type="checkbox" name="checked[]" value="%3$s" id="%1$s" ' +
				var_disabled.str() + '/>'),
			var_checkbox_id.clone(),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Select %s')]),
				var_plugin_data.array_get(rt.new_string('Name')),
			]),
			rt.call_function('esc_attr', [
				var_plugin_file.clone(),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('dropins'), var_context)))) {
		var_description = rt.new_string('<p>' +
			(if rt.is_true(var_plugin_data.array_get(rt.new_string('Description'))) { var_plugin_data.array_get(rt.new_string('Description')) } else { rt.new_string('&nbsp;') }).str() +
			'</p>')
		var_plugin_name = var_plugin_data.array_get(rt.new_string('Name'))
	}
	if  ((!(!rt.is_true(var_totals.array_get(rt.new_string('upgrade'))))
		&& !(!rt.is_true(var_plugin_data.array_get(rt.new_string('update')))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
		var_class = rt.concat(var_class, rt.new_string(' update'))
	}
	mut var_paused := rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'in_admin', [rt.new_string('network')])))))
		&& rt.is_true(rt.call_function('is_plugin_paused', [var_plugin_file.clone()])))
	if rt.is_true(var_paused) {
		var_class = rt.concat(var_class, rt.new_string(' paused'))
	}
	if rt.is_true(rt.call_function('is_uninstallable_plugin', [
		var_plugin_file.clone()]))
	{
		var_class = rt.concat(var_class, rt.new_string(' is-uninstallable'))
	}
	rt.call_function('printf', [
		rt.new_string('<tr class="%s" data-slug="%s" data-plugin="%s">'),
		rt.call_function('esc_attr', [var_class.clone()]),
		rt.call_function('esc_attr', [var_plugin_slug.clone()]),
		rt.call_function('esc_attr', [var_plugin_file.clone()]),
	])
	mut list_tmp_2 := this.get_column_info()
	var_columns = list_tmp_2.array_get(0)
	var_hidden = list_tmp_2.array_get(1)
	var_sortable = list_tmp_2.array_get(2)
	var_primary = list_tmp_2.array_get(3)
	mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [
		rt.new_string('auto_update_plugins'),
		rt.new_array(),
	]))
	for var_column_name, var_column_display_name in var_columns {
		mut var_extra_classes := rt.new_string('')
		if rt.is_true(rt.call_function('in_array', [rt.new_string(column_name),
			var_hidden.clone(), rt.new_bool(true)]))
		{
			var_extra_classes = rt.new_string(' hidden')
		}
		mut switch_val_2 := rt.new_string(column_name)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('cb'))) {
			print("<th scope='row' class='check-column'>${var_checkbox.to_string()}</th>")
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('name'))) {
			print("<td class='plugin-title column-primary'><strong>${var_plugin_name.to_string()}</strong>")
			rt.echo_val(this.row_actions(var_actions.clone(), rt.new_bool(true)))
			print('</td>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('description'))) {
			mut var_classes := rt.new_string('column-description desc')
			print("<td class='${var_classes.to_string()}${var_extra_classes.to_string()}'>\n\t\t\t\t\t\t<div class='plugin-description'>${var_description.to_string()}</div>\n\t\t\t\t\t\t<div class='${var_class.to_string()} second plugin-version-author-uri'>")
			mut var_plugin_meta := rt.new_array()
			if !(!rt.is_true(var_plugin_data.array_get(rt.new_string('Version')))) {
				var_plugin_meta.array_push(rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Version %s')]),
					var_plugin_data.array_get(rt.new_string('Version')),
				]))
			}
			if !(!rt.is_true(var_plugin_data.array_get(rt.new_string('Author')))) {
				mut var_author := var_plugin_data.array_get(rt.new_string('Author'))
				if !(!rt.is_true(var_plugin_data.array_get(rt.new_string('AuthorURI')))) {
					var_author = rt.new_string('<a href="' +
						(var_plugin_data.array_get(rt.new_string('AuthorURI'))).str() + '">' + (var_plugin_data.array_get(rt.new_string('Author'))).str() + '</a>')
				}
				var_plugin_meta.array_push(rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('By %s')]),
					var_author.clone(),
				]))
			}
			if var_plugin_data.array_isset(rt.new_string('slug'))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
				var_plugin_meta.array_push(rt.call_function('sprintf', [
					rt.new_string('<a href="%s" class="thickbox open-plugin-details-modal" aria-label="%s" data-title="%s">%s</a>'),
					rt.call_function('esc_url', [
						rt.call_function('network_admin_url', [
							rt.new_string('plugin-install.php?tab=plugin-information&plugin=' +
								(var_plugin_data.array_get(rt.new_string('slug'))).str() + '&TB_iframe=true&width=600&height=550'),
						]),
					]),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('More information about %s'),
							]),
							var_plugin_name.clone(),
						]),
					]),
					rt.call_function('esc_attr', [
						var_plugin_name.clone(),
					]),
					rt.call_function('__', [
						rt.new_string('View details'),
					]),
				]))
			} else if !(!rt.is_true(var_plugin_data.array_get(rt.new_string('PluginURI')))) {
				mut var_aria_label := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Visit plugin site for %s')]),
					var_plugin_name.clone(),
				])
				var_plugin_meta.array_push(rt.call_function('sprintf', [
					rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
					rt.call_function('esc_url', [
						var_plugin_data.array_get(rt.new_string('PluginURI')),
					]),
					rt.call_function('esc_attr', [
						var_aria_label.clone(),
					]),
					rt.call_function('__', [
						rt.new_string('Visit plugin site'),
					]),
				]))
			}
			var_plugin_meta = rt.call_function('apply_filters', [
				rt.new_string('plugin_row_meta'),
				var_plugin_meta.clone(),
				var_plugin_file.clone(),
				var_plugin_data.clone(),
				var_status.clone(),
			])
			rt.echo_val(rt.call_function('implode', [rt.new_string(' | '),
				var_plugin_meta.clone()]))
			print('</div>')
			if rt.is_true(var_has_dependents) {
				this.add_dependents_to_dependency_plugin_row(var_plugin_file.clone())
			}
			mut iife_temp_4 := Class_WP_Plugin_Dependencies{}
			mut iife_result_4 := iife_temp_4.has_dependencies(var_plugin_file.clone())
			if rt.is_true(iife_result_4) {
				this.add_dependencies_to_dependent_plugin_row(var_plugin_file.clone())
			}
			rt.call_function('do_action', [rt.new_string('after_plugin_row_meta'),
				var_plugin_file.clone(), var_plugin_data.clone()])
			if rt.is_true(var_paused) {
				mut var_notice_text := rt.call_function('__', [
					rt.new_string('This plugin failed to load properly and is paused during recovery mode.'),
				])
				rt.call_function('printf', [
					rt.new_string('<p><span class="dashicons dashicons-warning"></span> <strong>%s</strong></p>'),
					var_notice_text.clone(),
				])
				mut var_error := rt.call_function('wp_get_plugin_error', [
					var_plugin_file.clone()])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_error)))) {
					rt.call_function('printf', [
						rt.new_string('<div class="error-display"><p>%s</p></div>'),
						rt.call_function('wp_get_extension_error_description', [
							var_error.clone(),
						]),
					])
				}
			}
			print('</td>')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('auto-updates'))) {
			if !(this.show_autoupdates)
				|| rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{
				key: none
				val: 'mustuse'
			}, rt.ArrayItem{ key: none, val: 'dropins' }]), rt.new_bool(true)])) {
			}
			print("<td class='column-auto-updates${var_extra_classes.to_string()}'>")
			mut var_html := rt.new_array()
			if var_plugin_data.array_isset(rt.new_string('auto-update-forced')) {
				if rt.is_true(var_plugin_data.array_get(rt.new_string('auto-update-forced'))) {
					mut var_text := rt.call_function('__', [
						rt.new_string('Auto-updates enabled'),
					])
				} else {
					var_text = rt.call_function('__', [
						rt.new_string('Auto-updates disabled'),
					])
				}
				mut var_action := rt.new_string('unavailable')
				mut var_time_class := rt.new_string(' hidden')
			} else if !rt.is_true(var_plugin_data.array_get(rt.new_string('update-supported'))) {
				var_text = rt.new_string('')
				var_action = rt.new_string('unavailable')
				var_time_class = rt.new_string(' hidden')
			} else if rt.is_true(rt.call_function('in_array', [
				var_plugin_file.clone(), var_auto_updates.clone(),
				rt.new_bool(true)]))
			{
				var_text = rt.call_function('__', [rt.new_string('Disable auto-updates')])
				var_action = rt.new_string('disable')
				var_time_class = rt.new_string('')
			} else {
				var_text = rt.call_function('__', [rt.new_string('Enable auto-updates')])
				var_action = rt.new_string('enable')
				var_time_class = rt.new_string(' hidden')
			}
			mut var_query_args := rt.create_array([
				rt.ArrayItem{ key: 'action', val: '${var_action.to_string()}-auto-update' },
				rt.ArrayItem{ key: 'plugin', val: var_plugin_file },
				rt.ArrayItem{ key: 'paged', val: var_page },
				rt.ArrayItem{ key: 'plugin_status', val: var_status },
			])
			mut var_url := rt.call_function('add_query_arg', [
				var_query_args.clone(), rt.new_string('plugins.php')])
			if rt.is_true(rt.identical(rt.new_string('unavailable'), var_action)) {
				var_html.array_push('<span class="label">' + var_text.str() + '</span>')
			} else {
				var_html.array_push(rt.call_function('sprintf', [
					rt.new_string('<a href="%s" class="toggle-auto-update aria-button-if-js" data-wp-action="%s">'),
					rt.call_function('wp_nonce_url', [var_url.clone(),
						rt.new_string('updates')]),
					var_action.clone(),
				]))
				var_html.array_push('<span class="dashicons dashicons-update spin hidden" aria-hidden="true"></span>')
				var_html.array_push('<span class="label">' + var_text.str() + '</span>')
				var_html.array_push('</a>')
			}
			if !(!rt.is_true(var_plugin_data.array_get(rt.new_string('update')))) {
				var_html.array_push(rt.call_function('sprintf', [
					rt.new_string('<div class="auto-update-time%s">%s</div>'),
					var_time_class.clone(),
					rt.call_function('wp_get_auto_update_message', []rt.PhpVal{}),
				]))
			}
			var_html = rt.call_function('implode', [rt.new_string(''),
				var_html.clone()])
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('plugin_auto_update_setting_html'),
				var_html.clone(),
				var_plugin_file.clone(),
				var_plugin_data.clone(),
			]))
			rt.call_function('wp_admin_notice', [rt.new_string(''),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'notice-alt' },
						rt.ArrayItem{ key: none, val: 'inline' },
						rt.ArrayItem{ key: none, val: 'hidden' },
					]) }])])
			print('</td>')
		} else {
			var_classes =
				rt.new_string('${var_column_name} column-${var_column_name} ${var_class.to_string()}')
			print("<td class='${var_classes.to_string()}${var_extra_classes.to_string()}'>")
			rt.call_function('do_action', [rt.new_string('manage_plugins_custom_column'),
				rt.new_string(column_name), var_plugin_file.clone(),
				var_plugin_data.clone()])
			print('</td>')
		}
	}
	print('</tr>')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
		rt.call_function('printf', [
			rt.new_string('<tr class="plugin-update-tr"><td colspan="%s" class="plugin-update colspanchange">'),
			rt.call_function('esc_attr', [this.get_column_count()]),
		])
		mut var_incompatible_message := rt.new_string('')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
			var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('__', [
				rt.new_string('This plugin does not work with your versions of WordPress and PHP.'),
			]))
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('sprintf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str()),
					rt.call_function('self_admin_url', [
						rt.new_string('update-core.php'),
					]),
					rt.call_function('esc_url', [
						rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
					]),
				]))
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('wp_update_php_annotation', [
					rt.new_string('</p><p><em>'),
					rt.new_string('</em>'),
					rt.new_bool(false),
				]))
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_core'),
			]))
			{
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('sprintf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
					rt.call_function('self_admin_url', [
						rt.new_string('update-core.php'),
					]),
				]))
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_php'),
			]))
			{
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('sprintf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
					rt.call_function('esc_url', [
						rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
					]),
				]))
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('wp_update_php_annotation', [
					rt.new_string('</p><p><em>'),
					rt.new_string('</em>'),
					rt.new_bool(false),
				]))
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
			var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('__', [
				rt.new_string('This plugin does not work with your version of WordPress.'),
			]))
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_core'),
			]))
			{
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('sprintf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
					rt.call_function('self_admin_url', [
						rt.new_string('update-core.php'),
					]),
				]))
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
			var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('__', [
				rt.new_string('This plugin does not work with your version of PHP.'),
			]))
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_php'),
			]))
			{
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('sprintf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
					rt.call_function('esc_url', [
						rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
					]),
				]))
				var_incompatible_message = rt.concat(var_incompatible_message, rt.call_function('wp_update_php_annotation', [
					rt.new_string('</p><p><em>'),
					rt.new_string('</em>'),
					rt.new_bool(false),
				]))
			}
		}
		rt.call_function('wp_admin_notice', [var_incompatible_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'notice-alt' },
					rt.ArrayItem{ key: none, val: 'inline' },
					rt.ArrayItem{ key: none, val: 'update-message' },
				]) }])])
		print('</td></tr>')
	}
	rt.call_function('do_action', [rt.new_string('after_plugin_row'),
		var_plugin_file.clone(), var_plugin_data.clone(), var_status.clone()])
	rt.call_function('do_action', [
		rt.new_string('after_plugin_row_${var_plugin_file.to_string()}'),
		var_plugin_file.clone(),
		var_plugin_data.clone(),
		var_status.clone(),
	])
}

fn (mut this Class_WP_Plugins_List_Table) get_primary_column_name() string {
	return 'name'
}

fn (mut this Class_WP_Plugins_List_Table) add_dependents_to_dependency_plugin_row(var_dependency rt.PhpVal) {
	mut iife_temp_5 := Class_WP_Plugin_Dependencies{}
	mut iife_result_5 := iife_temp_5.get_dependent_names(var_dependency.clone())
	mut var_dependent_names := iife_result_5
	if !rt.is_true(var_dependent_names) {
		return
	}
	mut var_dependency_note := rt.call_function('__', [
		rt.new_string('Note: This plugin cannot be deactivated or deleted until the plugins that require it are deactivated or deleted.'),
	])
	mut var_comma := rt.call_function('wp_get_list_item_separator', []rt.PhpVal{})
	mut var_required_by := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('<strong>Required by:</strong> %s')]),
		rt.call_function('implode', [var_comma.clone(), var_dependent_names.clone()]),
	])
	rt.call_function('printf', [
		rt.new_string('<div class="required-by"><p>%1$s</p><p>%2$s</p></div>'),
		var_required_by.clone(),
		var_dependency_note.clone(),
	])
}

fn (mut this Class_WP_Plugins_List_Table) add_dependencies_to_dependent_plugin_row(var_dependent rt.PhpVal) {
	mut iife_temp_6 := Class_WP_Plugin_Dependencies{}
	mut iife_result_6 := iife_temp_6.get_dependency_names(var_dependent.clone())
	mut var_dependency_names := iife_result_6
	if rt.is_true(rt.identical(rt.new_array(), var_dependency_names)) {
		return
	}
	mut var_links := rt.new_array()
	mut iter_10 := var_dependency_names.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_name := item_10.val
		mut var_slug := item_10.key
		var_links << this.get_dependency_view_details_link(var_name.clone(), var_slug.clone())
	}
	mut var_is_active := if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('is_plugin_active_for_network', [
			var_dependent.clone(),
		]) } else { rt.call_function('is_plugin_active', [var_dependent.clone()]) }
	mut var_comma := rt.call_function('wp_get_list_item_separator', []rt.PhpVal{})
	mut var_requires := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('<strong>Requires:</strong> %s')]),
		rt.call_function('implode', [var_comma.clone(), rt.create_array_from_list(var_links)]),
	])
	mut var_notice := rt.new_string('')
	mut var_error_message := rt.new_string('')
	mut iife_temp_7 := Class_WP_Plugin_Dependencies{}
	mut iife_result_7 := iife_temp_7.has_unmet_dependencies(var_dependent.clone())
	if rt.is_true(iife_result_7) {
		if rt.is_true(var_is_active) {
			var_error_message = rt.call_function('__', [
				rt.new_string('This plugin is active but may not function correctly because required plugins are missing or inactive.'),
			])
		} else {
			var_error_message = rt.call_function('__', [
				rt.new_string('This plugin cannot be activated because required plugins are missing or inactive.'),
			])
		}
		var_notice = rt.call_function('wp_get_admin_notice', [
			var_error_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'inline' },
					rt.ArrayItem{ key: none, val: 'notice-alt' },
				]) },
			])])
	}
	rt.call_function('printf', [
		rt.new_string('<div class="requires"><p>%1$s</p>%2$s</div>'),
		var_requires.clone(),
		var_notice.clone(),
	])
}

fn (mut this Class_WP_Plugins_List_Table) get_dependency_view_details_link(var_name rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
	mut iife_temp_8 := Class_WP_Plugin_Dependencies{}
	mut iife_result_8 := iife_temp_8.get_dependency_data(var_slug.clone())
	mut var_dependency_data := iife_result_8
	if rt.is_true(rt.identical(rt.new_bool(false), var_dependency_data))
		|| rt.is_true(rt.identical(var_name, var_slug))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, var_dependency_data.array_get(rt.new_string('name'))))))
		|| !rt.is_true(var_dependency_data.array_get(rt.new_string('version'))) {
		return var_name.clone()
	}
	return this.get_view_details_link(var_name.clone(), var_slug.clone())
}

fn (mut this Class_WP_Plugins_List_Table) get_view_details_link(var_name rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
	mut var_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'tab', val: 'plugin-information' },
			rt.ArrayItem{ key: 'plugin', val: var_slug }, rt.ArrayItem{
				key: 'TB_iframe'
				val: 'true'
			}, rt.ArrayItem{ key: 'width', val: '600' }, rt.ArrayItem{ key: 'height', val: '550' }]),
		rt.call_function('network_admin_url', [rt.new_string('plugin-install.php')]),
	])
	mut var_name_attr := rt.call_function('esc_attr', [var_name.clone()])
	return rt.call_function('sprintf', [
		rt.new_string("<a href='%s' class='thickbox open-plugin-details-modal' aria-label='%s' data-title='%s'>%s</a>"),
		rt.call_function('esc_url', [var_url.clone()]),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('More information about %s')]),
			var_name_attr.clone(),
		]),
		var_name_attr.clone(),
		rt.call_function('esc_html', [
			var_name.clone(),
		]),
	])
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

fn create_wp_plugins_list_table(arg_0 rt.PhpVal) &Class_WP_Plugins_List_Table {
	mut obj := &Class_WP_Plugins_List_Table{
		PhpObjectBase:    rt.PhpObjectBase{}
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

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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
		else {
			return none
		}
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
		'show_autoupdates' {
			this.show_autoupdates = val.to_bool()
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
