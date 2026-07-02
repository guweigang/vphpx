import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_title := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	mut var_widgets_access := rt.call_function('get_user_setting', [
		rt.new_string('widgets_access'),
	])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('widgets-access')) {
		rt.call_function('check_admin_referer', [rt.new_string('widgets-access')])
		var_widgets_access = rt.new_string((if rt.is_true(rt.identical(rt.new_string('on'),
			rt.get_superglobal('_GET').array_get(rt.new_string('widgets-access'))))
		{
			'on'
		} else {
			'off'
		}).str())
		rt.call_function('set_user_setting', [rt.new_string('widgets_access'),
			var_widgets_access.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('on'), var_widgets_access)) {
		rt.call_function('add_filter', [rt.new_string('admin_body_class'),
			rt.new_string('wp_widgets_access_body_class')])
	} else {
		rt.call_function('wp_enqueue_script', [rt.new_string('admin-widgets')])
		if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
			rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
		}
	}
	rt.call_function('do_action', [rt.new_string('sidebar_admin_setup')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Widgets are independent sections of content that can be placed into any widgetized area provided by your theme (commonly called sidebars). To populate your sidebars/widget areas with individual widgets, drag and drop the title bars into the desired area. By default, only the first widget area is expanded. To populate additional widget areas, click on their title bars to expand them.')])).str() +
				'</p>\n\t<p>' +
				(rt.call_function('__', [rt.new_string('The Available Widgets section contains all the widgets you can choose from. Once you drag a widget into a sidebar, it will open to allow you to configure its settings. When you are happy with the widget settings, click the Save button and the widget will go live on your site. If you click Delete, it will remove the widget.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'removing-reusing' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Removing and Reusing'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('If you want to remove the widget but save its setting for possible future use, just drag it into the Inactive Widgets area. You can add them back anytime from there. This is especially helpful when you switch to a theme with fewer or different widget areas.')])).str() +
				'</p>\n\t<p>' +
				(rt.call_function('__', [rt.new_string('Widgets may be used multiple times. You can give each widget a title, to display on your site, but it&#8217;s not required.')])).str() +
				'</p>\n\t<p>' +
				(rt.call_function('__', [rt.new_string('Enabling Accessibility Mode, via Screen Options, allows you to use Add and Edit buttons instead of using drag and drop.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'missing-widgets' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Missing Widgets'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Many themes show some sidebar widgets by default until you edit your sidebars, but they are not automatically displayed in your sidebar management tool. After you make your first widget change, you can re-add the default widgets by adding them from the Available Widgets area.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('When changing themes, there is often some variation in the number and setup of widget areas/sidebars and sometimes these conflicts make the transition a bit less smooth. If you changed themes and seem to be missing widgets, scroll down on this screen to the Inactive Widgets area, where all of your widgets and their settings will have been saved.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/appearance-widgets-screen-classic-editor/">Documentation on Widgets</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	mut var_sidebars_widgets := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	if !rt.is_true(var_sidebars_widgets) {
		var_sidebars_widgets = rt.call_function('wp_get_widget_defaults', []rt.PhpVal{})
	}
	mut iter_1 := var_sidebars_widgets.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_widgets := item_1.val
		mut var_sidebar_id := item_1.key
		if rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_id)) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_registered_sidebar', [
			var_sidebar_id.clone(),
		])))))
		{
			if !(!rt.is_true(var_widgets)) {
				rt.call_function('register_sidebar', [
					rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
							rt.new_string('Inactive Sidebar (not used)'),
						]) },
						rt.ArrayItem{ key: 'id', val: var_sidebar_id },
						rt.ArrayItem{ key: 'class', val: 'inactive-sidebar orphan-sidebar' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('This sidebar is no longer available and does not show anywhere on your site. Remove each of the widgets below to fully remove this inactive sidebar.'),
						]) },
						rt.ArrayItem{ key: 'before_widget', val: '' },
						rt.ArrayItem{ key: 'after_widget', val: '' },
						rt.ArrayItem{ key: 'before_title', val: '' },
						rt.ArrayItem{ key: 'after_title', val: '' },
					]),
				])
			} else {
				var_sidebars_widgets.array_unset(var_sidebar_id)
			}
		}
	}
	rt.call_function('register_sidebar', [
		rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Inactive Widgets'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'wp_inactive_widgets' },
			rt.ArrayItem{ key: 'class', val: 'inactive-sidebar' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Drag widgets here to remove them from the sidebar but keep their settings.'),
			]) },
			rt.ArrayItem{ key: 'before_widget', val: '' },
			rt.ArrayItem{ key: 'after_widget', val: '' },
			rt.ArrayItem{ key: 'before_title', val: '' },
			rt.ArrayItem{ key: 'after_title', val: '' },
		]),
	])
	rt.call_function('retrieve_widgets', []rt.PhpVal{})
	if rt.get_superglobal('_POST').array_isset(rt.new_string('savewidget'))
		|| rt.get_superglobal('_POST').array_isset(rt.new_string('removewidget')) {
		mut var_widget_id := rt.get_superglobal('_POST').array_get(rt.new_string('widget-id'))
		rt.call_function('check_admin_referer', [
			rt.new_string('save-delete-widget-${var_widget_id.to_string()}'),
		])
		mut var_number := if rt.get_superglobal('_POST').array_isset(rt.new_string('multi_number')) {
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('multi_number'))).to_i64())
		} else {
			rt.new_string('')
		}
		if rt.is_true(var_number) {
			mut iter_2 := rt.get_superglobal('_POST').iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_val := item_2.val
				mut var_key := item_2.key
				if var_val.clone().is_array()
					&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/__i__|%i%/'), rt.call_function('key', [var_val.clone()])])) {
					rt.get_superglobal('_POST').array_set(var_key, rt.create_array([
						rt.ArrayItem{ key: var_number, val: rt.call_function('array_shift', [
							var_val.clone(),
						]) },
					]))
					break
				}
			}
		}
		mut var_sidebar_id := rt.get_superglobal('_POST').array_get(rt.new_string('sidebar'))
		mut var_position := rt.new_int(if rt.get_superglobal('_POST').array_isset(
			var_sidebar_id.str() + '_position')
		{
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string(var_sidebar_id.str() +
				'_position'))).to_i64()) - 1
		} else {
			0
		})
		mut var_id_base := rt.get_superglobal('_POST').array_get(rt.new_string('id_base'))
		mut var_sidebar := if !(var_sidebars_widgets.array_get(var_sidebar_id)).is_null() {
			var_sidebars_widgets.array_get(var_sidebar_id)
		} else {
			rt.new_array()
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('removewidget'))
			&& rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('removewidget'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_widget_id.clone(),
				var_sidebar.clone(),
				rt.new_bool(true),
			])))))
			{
				rt.call_function('wp_redirect', [
					rt.call_function('admin_url', [rt.new_string('widgets.php?error=0')]),
				])
				exit(0)
			}
			var_sidebar = rt.call_function('array_diff', [var_sidebar.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_widget_id }])])
			mut var__POST := rt.create_array([
				rt.ArrayItem{ key: 'sidebar', val: var_sidebar_id },
				rt.ArrayItem{ key: 'widget-' + var_id_base.str(), val: rt.new_array() },
				rt.ArrayItem{ key: 'the-widget-id', val: var_widget_id },
				rt.ArrayItem{ key: 'delete_widget', val: '1' },
			])
			rt.call_function('do_action', [rt.new_string('delete_widget'),
				var_widget_id.clone(), var_sidebar_id.clone(),
				var_id_base.clone()])
		}
		rt.get_superglobal('_POST').array_set('widget-id', var_sidebar.clone())
		mut iter_3 := rt.cast_array(var_wp_registered_widget_updates).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_control := item_3.val
			mut var_name := item_3.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, var_id_base))))
				|| !(rt.call_function('is_callable', [var_control.array_get(rt.new_string('callback'))])) {
				continue
			}
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_function('call_user_func_array', [
				var_control.array_get(rt.new_string('callback')),
				var_control.array_get(rt.new_string('params')),
			])
			rt.call_function('ob_end_clean', []rt.PhpVal{})
			break
		}
		var_sidebars_widgets.array_set(var_sidebar_id, var_sidebar.clone())
		if !(rt.get_superglobal('_POST').array_isset(rt.new_string('delete_widget'))) {
			mut iter_4 := var_sidebars_widgets.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_sidebar_widget := item_4.val
				mut var_sidebar_widget_id := item_4.key
				if rt.is_true(rt.new_bool(var_sidebar_widget.clone().is_array())) {
					var_sidebars_widgets.array_set(var_sidebar_widget_id, rt.call_function('array_diff', [
						var_sidebar_widget.clone(),
						rt.create_array([rt.ArrayItem{ key: none, val: var_widget_id }]),
					]))
				}
			}
			rt.call_function('array_splice', [var_sidebars_widgets.array_get(var_sidebar_id),
				var_position.clone(), rt.new_int(0), var_widget_id.clone()])
		}
		rt.call_function('wp_set_sidebars_widgets', [var_sidebars_widgets.clone()])
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [rt.new_string('widgets.php?message=0')]),
		])
		exit(0)
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('removeinactivewidgets')) {
		rt.call_function('check_admin_referer', [
			rt.new_string('remove-inactive-widgets'),
			rt.new_string('_wpnonce_remove_inactive_widgets'),
		])
		if rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('removeinactivewidgets'))) {
			mut iter_5 :=
				var_sidebars_widgets.array_get(rt.new_string('wp_inactive_widgets')).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_widget_id_shadow := item_5.val
				mut var_key := item_5.key
				mut var_pieces := rt.call_function('explode', [
					rt.new_string('-'), var_widget_id_shadow.clone()])
				mut var_multi_number := rt.call_function('array_pop', [
					var_pieces.clone()])
				var_id_base = rt.call_function('implode', [rt.new_string('-'),
					var_pieces.clone()])
				mut var_widget := rt.call_function('get_option', [
					rt.new_string('widget_' + var_id_base.str()),
				])
				var_widget.array_unset(var_multi_number)
				rt.call_function('update_option', [
					rt.new_string('widget_' + var_id_base.str()),
					var_widget.clone(),
				])
				var_sidebars_widgets.array_get(rt.new_string('wp_inactive_widgets')).array_unset(var_key)
			}
			rt.call_function('wp_set_sidebars_widgets', [var_sidebars_widgets.clone()])
		}
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [rt.new_string('widgets.php?message=0')]),
		])
		exit(0)
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('editwidget'))
		&& rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('editwidget'))) {
		var_widget_id = rt.get_superglobal('_GET').array_get(rt.new_string('editwidget'))
		if rt.get_superglobal('_GET').array_isset(rt.new_string('addnew')) {
			mut var_keys := rt.func_array_keys(var_wp_registered_sidebars.clone())
			var_sidebar = rt.call_function('reset', [var_keys.clone()])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('base'))
				&& rt.get_superglobal('_GET').array_isset(rt.new_string('num')) {
				mut iter_6 := var_wp_registered_widget_controls.iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_control := item_6.val
					if rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get(rt.new_string('base')),
						var_control.array_get(rt.new_string('id_base'))))
					{
						mut var_control_callback := var_control.array_get(rt.new_string('callback'))
						mut var_multi_number :=
							rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('num'))).to_i64())
						var_control.array_get_mut('params').array_get_mut(0).array_set('number', -1)
						var_control.array_set('id',
							(var_control.array_get(rt.new_string('id_base'))).str() + '-' +
							var_multi_number.str())
						var_widget_id = var_control.array_get(rt.new_string('id'))
						var_wp_registered_widget_controls.array_set(var_control.array_get(rt.new_string('id')),
							var_control.clone())
						break
					}
				}
			}
		}
		if var_wp_registered_widget_controls.array_isset(var_widget_id) && !(!var_control.is_null()) {
			mut var_control := var_wp_registered_widget_controls.array_get(var_widget_id)
			mut var_control_callback := var_control.array_get(rt.new_string('callback'))
		} else if !(var_wp_registered_widget_controls.array_isset(var_widget_id))
			&& var_wp_registered_widgets.array_isset(var_widget_id) {
			mut var_name := rt.call_function('esc_html', [
				rt.call_function('strip_tags',
					[var_wp_registered_widgets.array_get(var_widget_id).array_get(rt.new_string('name'))]),
			])
		}
		if !(!var_name.is_null()) {
			var_name = rt.call_function('esc_html', [
				rt.call_function('strip_tags', [var_control.array_get(rt.new_string('name'))]),
			])
		}
		if !(!var_sidebar.is_null()) {
			var_sidebar = if !(rt.get_superglobal('_GET').array_get(rt.new_string('sidebar'))).is_null() {
				rt.get_superglobal('_GET').array_get(rt.new_string('sidebar'))
			} else {
				rt.new_string('wp_inactive_widgets')
			}
		}
		if !(!var_multi_number.is_null()) {
			mut var_multi_number := if !(var_control.array_get(rt.new_string('params')).array_get(rt.new_int(0)).array_get(rt.new_string('number'))).is_null() {
				var_control.array_get(rt.new_string('params')).array_get(rt.new_int(0)).array_get(rt.new_string('number'))
			} else {
				rt.new_string('')
			}
		}
		var_id_base = if !(var_control.array_get(rt.new_string('id_base'))).is_null() {
			var_control.array_get(rt.new_string('id_base'))
		} else {
			var_control.array_get(rt.new_string('id'))
		}
		mut var_width := rt.new_string(' style="width:' +
			(rt.call_function('max', [var_control.array_get(rt.new_string('width')), rt.new_int(350)])).str() +
			'px"')
		mut var_key := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) {
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('key'))).to_i64())
		} else {
			0
		})
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_width)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Widget %s')]),
			var_name.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_callable', [var_control_callback.clone()])) {
			rt.call_function('call_user_func_array', [var_control_callback.clone(),
				var_control.array_get(rt.new_string('params'))])
		} else {
			print('<p>' +
				(rt.call_function('__', [rt.new_string('There are no options for this widget.')])).str() +
				'</p>\n')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Select both the sidebar for this widget and the position of the widget in that sidebar.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sidebar')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Position')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_7 := var_wp_registered_sidebars.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_sidebar_data := item_7.val
			mut var_sidebar_name := item_7.key
			print("\t\t<tr><td><label><input type='radio' name='sidebar' value='" +
				(rt.call_function('esc_attr', [var_sidebar_name.clone()])).str() + "'" +
				(rt.call_function('checked', [var_sidebar_name.clone(), var_sidebar.clone(), rt.new_bool(false)])).str() +
				rt.concat(rt.concat(rt.new_string(' /> '), var_sidebar_data.array_get(rt.new_string('name'))), rt.new_string('</label></td><td>')))
			if rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_name))
				|| rt.is_true(rt.call_function('str_starts_with', [var_sidebar_name.clone(), rt.new_string('orphaned_widgets')])) {
				print('&nbsp;')
			} else {
				if !(var_sidebars_widgets.array_isset(var_sidebar_name))
					|| !(var_sidebars_widgets.array_get(var_sidebar_name).is_array()) {
					mut var_widget_count := 1
					var_sidebars_widgets.array_set(var_sidebar_name, rt.new_array())
				} else {
					var_widget_count =
						var_sidebars_widgets.array_get(var_sidebar_name).array_count()
					if rt.get_superglobal('_GET').array_isset(rt.new_string('addnew'))
						|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_widget_id.clone(), var_sidebars_widgets.array_get(var_sidebar_name), rt.new_bool(true)]))))) {
						var_widget_count += 1
					}
				}
				mut var_selected := rt.new_string('')
				print("\t\t<select name='${var_sidebar_name.to_string()}_position'>\n")
				print("\t\t<option value=''>" +
					(rt.call_function('__', [rt.new_string('&mdash; Select &mdash;')])).str() +
					'</option>\n')
				mut var_i := 1
				for {
					if !(var_i <= var_widget_count) { break
					 }
					if rt.is_true(rt.call_function('in_array', [
						var_widget_id.clone(), var_sidebars_widgets.array_get(var_sidebar_name),
						rt.new_bool(true)]))
					{
						var_selected = rt.call_function('selected', [
							rt.new_int(var_i).clone(), rt.add(var_key, rt.new_int(1)),
							rt.new_bool(false)])
					}
					print("\t\t<option value='${var_i.str()}'${var_selected.to_string()}> ${var_i.str()} </option>\n")
					var_i += 1
				}
				print('\t\t</select>\n')
			}
			print('</td></tr>\n')
		}
		// unsupported statement: Stmt_InlineHTML
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('addnew'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Delete')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Cancel')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Cancel')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Save Widget')]),
			rt.new_string('primary alignright'),
			rt.new_string('savewidget'),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_widget_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_id_base.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_multi_number.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [
			rt.new_string('save-delete-widget-${var_widget_id.to_string()}'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		exit(0)
	}
	mut var_messages := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Changes saved.'),
		]) },
	])
	mut var_errors := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Error while saving.'),
		]) },
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Error in displaying the widget settings form.'),
		]) },
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		rt.call_function('printf', [
			rt.new_string(' <a class="page-title-action hide-if-no-customize" href="%1$s">%2$s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{ key: 'autofocus', val: rt.create_array([
								rt.ArrayItem{ key: 'panel', val: 'widgets' },
							]) },
						]) },
						rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [
							rt.call_function('remove_query_arg', [
								rt.call_function('wp_removable_query_args', []rt.PhpVal{}),
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
								]),
							]),
						]) },
					]),
					rt.call_function('admin_url', [
						rt.new_string('customize.php'),
					]),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Manage with Live Preview'),
			]),
		])
	}
	mut var_nonce := rt.call_function('wp_create_nonce', [
		rt.new_string('widgets-access'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('urlencode', [var_nonce.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Enable accessibility mode')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('urlencode', [var_nonce.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Disable accessibility mode')])
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('message'))
		&& var_messages.array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('message'))) {
		rt.call_function('wp_admin_notice', [
			var_messages.array_get(rt.get_superglobal('_GET').array_get(rt.new_string('message'))),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
		])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('error'))
		&& var_errors.array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('error'))) {
		rt.call_function('wp_admin_notice', [
			var_errors.array_get(rt.get_superglobal('_GET').array_get(rt.new_string('error'))),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
		])
	}
	rt.call_function('do_action', [rt.new_string('widgets_admin_page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Available Widgets')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Available Widgets')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Deactivate'), rt.new_string('removing-widget')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('To activate a widget drag it to a sidebar or click on it. To deactivate a widget and delete its settings, drag it back.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_list_widgets', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut var_theme_sidebars := rt.new_array()
	mut iter_8 := var_wp_registered_sidebars.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_registered_sidebar := item_8.val
		mut var_sidebar_shadow := item_8.key
		if rt.is_true(rt.call_function('str_contains', [var_registered_sidebar.array_get(rt.new_string('class')), rt.new_string('inactive-sidebar')]))
			|| rt.is_true(rt.call_function('str_starts_with', [var_sidebar_shadow.clone(), rt.new_string('orphaned_widgets')])) {
			mut var_wrap_class := 'widgets-holder-wrap'
			if !(!rt.is_true(var_registered_sidebar.array_get(rt.new_string('class')))) {
				var_wrap_class = var_wrap_class + ' ' +
					(var_registered_sidebar.array_get(rt.new_string('class'))).str()
			}
			mut var_is_inactive_widgets := (rt.identical(rt.new_string('wp_inactive_widgets'),
				var_registered_sidebar.array_get(rt.new_string('id')))).to_bool()
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_wrap_class.str()).clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_list_widget_controls', [
				var_registered_sidebar.array_get(rt.new_string('id')),
				var_registered_sidebar.array_get(rt.new_string('name')),
			])
			// unsupported statement: Stmt_InlineHTML
			if var_is_inactive_widgets {
				// unsupported statement: Stmt_InlineHTML
				mut var_attributes := {
					'id': 'inactive-widgets-control-remove'
				}
				if !rt.is_true(var_sidebars_widgets.array_get(rt.new_string('wp_inactive_widgets'))) {
					var_attributes['disabled'] = ''
				}
				rt.call_function('submit_button', [
					rt.call_function('__', [rt.new_string('Clear Inactive Widgets')]),
					rt.new_string('delete'),
					rt.new_string('removeinactivewidgets'),
					rt.new_bool(false),
					rt.create_array_from_native_map(var_attributes),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('wp_nonce_field', [
					rt.new_string('remove-inactive-widgets'),
					rt.new_string('_wpnonce_remove_inactive_widgets'),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if var_is_inactive_widgets {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [
					rt.new_string('This will clear all items from the inactive widgets list. You will not be able to restore any customizations.'),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			var_theme_sidebars.array_set(var_sidebar_shadow, var_registered_sidebar.clone())
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_sidebar_index := 0
	mut var_split := rt.new_int(0)
	mut var_single_sidebar_class := ''
	mut var_sidebars_count := var_theme_sidebars.clone().array_count()
	if var_sidebars_count > 1 {
		var_split = rt.new_int((rt.call_function('ceil', [
			rt.new_int(var_sidebars_count / 2),
		])).to_i64())
	} else {
		var_single_sidebar_class = ' single-sidebar'
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_single_sidebar_class)
	// unsupported statement: Stmt_InlineHTML
	mut iter_9 := var_theme_sidebars.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_registered_sidebar := item_9.val
		mut var_sidebar_shadow := item_9.key
		mut var_wrap_class := 'widgets-holder-wrap'
		if !(!rt.is_true(var_registered_sidebar.array_get(rt.new_string('class')))) {
			var_wrap_class = var_wrap_class + ' sidebar-' +
				(var_registered_sidebar.array_get(rt.new_string('class'))).str()
		}
		if var_sidebar_index > 0 {
			var_wrap_class = var_wrap_class + ' closed'
		}
		if rt.is_true(var_split)
			&& rt.is_true(rt.identical(rt.new_int(var_sidebar_index), var_split)) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_wrap_class.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_list_widget_controls', [var_sidebar_shadow.clone(),
			var_registered_sidebar.array_get(rt.new_string('name'))])
		// unsupported statement: Stmt_InlineHTML
		var_sidebar_index += 1
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('save-sidebar-widgets'),
		rt.new_string('_wpnonce_widgets'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Cancel')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Widget')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('sidebar_admin_page')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
