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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	mut var_widgets_access := rt.call_function('get_user_setting', [rt.new_string('widgets_access')])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('widgets-access')) {
		rt.call_function('check_admin_referer', [rt.new_string('widgets-access')])
		var_widgets_access = rt.new_string(if rt.is_true(rt.identical(rt.new_string('on'), rt.get_superglobal('_GET').array_get('widgets-access'))) { rt.new_string('on') } else { rt.new_string('off') })
		rt.call_function('set_user_setting', [rt.new_string('widgets_access'), var_widgets_access.dup()])
	}
	if rt.is_true(rt.identical(rt.new_string('on'), var_widgets_access)) {
		rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.new_string('wp_widgets_access_body_class')])
	} else {
		rt.call_function('wp_enqueue_script', [rt.new_string('admin-widgets')])
		if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
			rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
		}
	}
	rt.call_function('do_action', [rt.new_string('sidebar_admin_setup')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Widgets are independent sections of content that can be placed into any widgetized area provided by your theme (commonly called sidebars). To populate your sidebars/widget areas with individual widgets, drag and drop the title bars into the desired area. By default, only the first widget area is expanded. To populate additional widget areas, click on their title bars to expand them.')])).str() + '</p>\n\t<p>' + (rt.call_function('__', [rt.new_string('The Available Widgets section contains all the widgets you can choose from. Once you drag a widget into a sidebar, it will open to allow you to configure its settings. When you are happy with the widget settings, click the Save button and the widget will go live on your site. If you click Delete, it will remove the widget.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'removing-reusing' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Removing and Reusing')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('If you want to remove the widget but save its setting for possible future use, just drag it into the Inactive Widgets area. You can add them back anytime from there. This is especially helpful when you switch to a theme with fewer or different widget areas.')])).str() + '</p>\n\t<p>' + (rt.call_function('__', [rt.new_string('Widgets may be used multiple times. You can give each widget a title, to display on your site, but it&#8217;s not required.')])).str() + '</p>\n\t<p>' + (rt.call_function('__', [rt.new_string('Enabling Accessibility Mode, via Screen Options, allows you to use Add and Edit buttons instead of using drag and drop.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'missing-widgets' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Missing Widgets')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Many themes show some sidebar widgets by default until you edit your sidebars, but they are not automatically displayed in your sidebar management tool. After you make your first widget change, you can re-add the default widgets by adding them from the Available Widgets area.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('When changing themes, there is often some variation in the number and setup of widget areas/sidebars and sometimes these conflicts make the transition a bit less smooth. If you changed themes and seem to be missing widgets, scroll down on this screen to the Inactive Widgets area, where all of your widgets and their settings will have been saved.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/appearance-widgets-screen-classic-editor/">Documentation on Widgets</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	mut var_sidebars_widgets := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	if !rt.is_true(var_sidebars_widgets) {
		var_sidebars_widgets = rt.call_function('wp_get_widget_defaults', []rt.PhpVal{})
	}
	{
		mut iter_1 := var_sidebars_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widgets := item_1.val
			mut var_sidebar_id := item_1.key
			if rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_id)) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_registered_sidebar', [var_sidebar_id.dup()]))))) {
				if !(!rt.is_true(var_widgets)) {
					rt.call_function('register_sidebar', [rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Inactive Sidebar (not used)')]) }, rt.ArrayItem{ key: 'id', val: var_sidebar_id }, rt.ArrayItem{ key: 'class', val: 'inactive-sidebar orphan-sidebar' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This sidebar is no longer available and does not show anywhere on your site. Remove each of the widgets below to fully remove this inactive sidebar.')]) }, rt.ArrayItem{ key: 'before_widget', val: '' }, rt.ArrayItem{ key: 'after_widget', val: '' }, rt.ArrayItem{ key: 'before_title', val: '' }, rt.ArrayItem{ key: 'after_title', val: '' }])])
				} else {
					var_sidebars_widgets.array_unset(var_sidebar_id)
				}
			}
		}
	}
	rt.call_function('register_sidebar', [rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Inactive Widgets')]) }, rt.ArrayItem{ key: 'id', val: 'wp_inactive_widgets' }, rt.ArrayItem{ key: 'class', val: 'inactive-sidebar' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Drag widgets here to remove them from the sidebar but keep their settings.')]) }, rt.ArrayItem{ key: 'before_widget', val: '' }, rt.ArrayItem{ key: 'after_widget', val: '' }, rt.ArrayItem{ key: 'before_title', val: '' }, rt.ArrayItem{ key: 'after_title', val: '' }])])
	rt.call_function('retrieve_widgets', []rt.PhpVal{})
	if rt.get_superglobal('_POST').array_isset(rt.new_string('savewidget')) || rt.get_superglobal('_POST').array_isset(rt.new_string('removewidget')) {
		mut var_widget_id := rt.get_superglobal('_POST').array_get('widget-id')
		rt.call_function('check_admin_referer', [rt.new_string("save-delete-widget-${var_widget_id.to_string()}")])
		mut var_number := if rt.get_superglobal('_POST').array_isset(rt.new_string('multi_number')) { // unsupported expression: Expr_Cast_Int } else { rt.new_string('') }
		if rt.is_true(var_number) {
			{
				mut iter_1 := rt.get_superglobal('_POST').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_val := item_1.val
					mut var_key := item_1.key
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_val.dup().is_array())) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/__i__|%i%/'), rt.call_function('key', [var_val.dup()])])))) {
						rt.get_superglobal('_POST').array_set(var_key, rt.create_array([rt.ArrayItem{ key: var_number, val: rt.call_function('array_shift', [var_val.dup()]) }]))
						break
					}
				}
			}
		}
		mut var_sidebar_id := rt.get_superglobal('_POST').array_get('sidebar')
		mut var_position := if rt.get_superglobal('_POST').array_isset((var_sidebar_id).str() + '_position') { rt.sub(// unsupported expression: Expr_Cast_Int, rt.new_int(1)) } else { rt.new_int(0) }
		mut var_id_base := rt.get_superglobal('_POST').array_get('id_base')
		mut var_sidebar := if !(var_sidebars_widgets.array_get(var_sidebar_id)).is_null() { var_sidebars_widgets.array_get(var_sidebar_id) } else { rt.new_array() }
		if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('removewidget')) && rt.is_true(rt.get_superglobal('_POST').array_get('removewidget')))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_widget_id.dup(), var_sidebar.dup(), rt.new_bool(true)]))))) {
				rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('widgets.php?error=0')])])
				// unsupported expression: Expr_Exit
			}
			var_sidebar = rt.call_function('array_diff', [var_sidebar.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_widget_id }])])
			mut var__POST := rt.create_array([rt.ArrayItem{ key: 'sidebar', val: var_sidebar_id }, rt.ArrayItem{ key: 'widget-' + (var_id_base).str(), val: rt.new_array() }, rt.ArrayItem{ key: 'the-widget-id', val: var_widget_id }, rt.ArrayItem{ key: 'delete_widget', val: '1' }])
			rt.call_function('do_action', [rt.new_string('delete_widget'), var_widget_id.dup(), var_sidebar_id.dup(), var_id_base.dup()])
		}
		rt.get_superglobal('_POST').array_set('widget-id', var_sidebar.dup())
		{
			mut iter_1 := rt.cast_array(var_wp_registered_widget_updates).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_control := item_1.val
				mut var_name := item_1.key
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_control.array_get('callback')]))))))) {
					continue
				}
				rt.call_function('ob_start', []rt.PhpVal{})
				rt.call_function('call_user_func_array', [var_control.array_get('callback'), var_control.array_get('params')])
				rt.call_function('ob_end_clean', []rt.PhpVal{})
				break
			}
		}
		var_sidebars_widgets.array_set(var_sidebar_id, var_sidebar.dup())
		if !(rt.get_superglobal('_POST').array_isset(rt.new_string('delete_widget'))) {
			{
				mut iter_1 := var_sidebars_widgets.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_sidebar_widget := item_1.val
					mut var_sidebar_widget_id := item_1.key
					if rt.is_true(rt.new_bool(var_sidebar_widget.dup().is_array())) {
						var_sidebars_widgets.array_set(var_sidebar_widget_id, rt.call_function('array_diff', [var_sidebar_widget.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_widget_id }])]))
					}
				}
			}
			rt.call_function('array_splice', [var_sidebars_widgets.array_get(var_sidebar_id), var_position.dup(), rt.new_int(0), var_widget_id.dup()])
		}
		rt.call_function('wp_set_sidebars_widgets', [var_sidebars_widgets.dup()])
		rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('widgets.php?message=0')])])
		// unsupported expression: Expr_Exit
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('removeinactivewidgets')) {
		rt.call_function('check_admin_referer', [rt.new_string('remove-inactive-widgets'), rt.new_string('_wpnonce_remove_inactive_widgets')])
		if rt.is_true(rt.get_superglobal('_POST').array_get('removeinactivewidgets')) {
			{
				mut iter_1 := var_sidebars_widgets.array_get('wp_inactive_widgets').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_widget_id_shadow := item_1.val
					mut var_key := item_1.key
					mut var_pieces := rt.call_function('explode', [rt.new_string('-'), var_widget_id_shadow.dup()])
					mut var_multi_number := rt.call_function('array_pop', [var_pieces.dup()])
					var_id_base = rt.call_function('implode', [rt.new_string('-'), var_pieces.dup()])
					mut var_widget := rt.call_function('get_option', ['widget_' + (var_id_base).str()])
					var_widget.array_unset(var_multi_number)
					rt.call_function('update_option', ['widget_' + (var_id_base).str(), var_widget.dup()])
					var_sidebars_widgets.array_get('wp_inactive_widgets').array_unset(var_key)
				}
			}
			rt.call_function('wp_set_sidebars_widgets', [var_sidebars_widgets.dup()])
		}
		rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('widgets.php?message=0')])])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('editwidget')) && rt.is_true(rt.get_superglobal('_GET').array_get('editwidget')))) {
		var_widget_id = rt.get_superglobal('_GET').array_get('editwidget')
		if rt.get_superglobal('_GET').array_isset(rt.new_string('addnew')) {
			mut var_keys := rt.func_array_keys(var_wp_registered_sidebars.dup())
			var_sidebar = rt.call_function('reset', [var_keys.dup()])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('base')) && rt.get_superglobal('_GET').array_isset(rt.new_string('num')) {
				{
					mut iter_1 := var_wp_registered_widget_controls.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_control := item_1.val
						if rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get('base'), var_control.array_get('id_base'))) {
							mut var_control_callback := var_control.array_get('callback')
							mut var_multi_number := // unsupported expression: Expr_Cast_Int
							var_control.array_get_mut('params').array_get_mut(0).array_set('number', // unsupported expression: Expr_UnaryMinus)
							var_control.array_set('id', (var_control.array_get('id_base')).str() + '-' + (var_multi_number).str())
							var_widget_id = var_control.array_get('id')
							var_wp_registered_widget_controls.array_set(var_control.array_get('id'), var_control.dup())
							break
						}
					}
				}
			}
		}
		if var_wp_registered_widget_controls.array_isset(var_widget_id) && !(!(var_control).is_null()) {
			mut var_control := var_wp_registered_widget_controls.array_get(var_widget_id)
			mut var_control_callback := var_control.array_get('callback')
		} else if !(var_wp_registered_widget_controls.array_isset(var_widget_id)) && var_wp_registered_widgets.array_isset(var_widget_id) {
			mut var_name := rt.call_function('esc_html', [rt.call_function('strip_tags', [var_wp_registered_widgets.array_get(var_widget_id).array_get('name')])])
		}
		if !(!(var_name).is_null()) {
			var_name = rt.call_function('esc_html', [rt.call_function('strip_tags', [var_control.array_get('name')])])
		}
		if !(!(var_sidebar).is_null()) {
			var_sidebar = if !(rt.get_superglobal('_GET').array_get('sidebar')).is_null() { rt.get_superglobal('_GET').array_get('sidebar') } else { rt.new_string('wp_inactive_widgets') }
		}
		if !(!(var_multi_number).is_null()) {
			mut var_multi_number := if !(var_control.array_get('params').array_get(0).array_get('number')).is_null() { var_control.array_get('params').array_get(0).array_get('number') } else { rt.new_string('') }
		}
		var_id_base = if !(var_control.array_get('id_base')).is_null() { var_control.array_get('id_base') } else { var_control.array_get('id') }
		mut var_width := rt.new_string(' style="width:' + (rt.call_function('max', [var_control.array_get('width'), rt.new_int(350)])).str() + 'px"')
		mut var_key := if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_width)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Widget %s')]), var_name.dup()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_callable', [var_control_callback.dup()])) {
			rt.call_function('call_user_func_array', [var_control_callback.dup(), var_control.array_get('params')])
		} else {
			print('<p>' + (rt.call_function('__', [rt.new_string('There are no options for this widget.')])).str() + '</p>\n')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Select both the sidebar for this widget and the position of the widget in that sidebar.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sidebar')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [])
		// unsupported statement: Stmt_InlineHTML
	}
	
}
