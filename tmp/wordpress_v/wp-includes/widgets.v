import rt

fn register_widget(widget string) {
	mut var_wp_widget_factory := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_widget_factory, 'register', [rt.new_string(widget)])
}

fn unregister_widget(var_widget rt.PhpVal) {
	mut var_wp_widget_factory := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_widget_factory, 'unregister', [var_widget.dup()])
}

fn register_sidebars(number i64, var_args rt.PhpVal) {
	mut var_wp_registered_sidebars := rt.new_null()
	// unsupported statement: Stmt_Global
	number = (// unsupported expression: Expr_Cast_Int).to_i64()
	if rt.is_true(rt.new_bool(var_args.dup().is_string())) {
		rt.call_function('parse_str', [var_args.dup(), var_args.dup()])
	}
	{
		mut var_i := 1
		for {
			if !(var_i <= number) { break }
			mut var__args := var_args.dup()
			if number > 1 {
				if var_args.array_isset(rt.new_string('name')) {
					var__args.array_set('name', rt.call_function('sprintf', [var_args.array_get('name'), rt.new_int(var_i).dup()]))
				} else {
					var__args.array_set('name', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sidebar %d')]), rt.new_int(var_i).dup()]))
				}
			} else {
				var__args.array_set('name', if !(var_args.array_get('name')).is_null() { var_args.array_get('name') } else { rt.call_function('__', [rt.new_string('Sidebar')]) })
			}
			if var_args.array_isset(rt.new_string('id')) {
				var__args.array_set('id', var_args.array_get('id'))
				mut var_n := 2
				for rt.is_true(is_registered_sidebar(var__args.array_get('id'))) {
					var__args.array_set('id', (var_args.array_get('id')).str() + '-' + (rt.post_inc(rt.new_int(var_n))).str())
				}
			} else {
				var_n = var_wp_registered_sidebars.dup().array_count()
				for {
					var__args.array_set('id', 'sidebar-' + (rt.pre_inc(rt.new_int(var_n))).str())
					if !(rt.is_true(is_registered_sidebar(var__args.array_get('id')))) {
						break
					}
				}
			}
			register_sidebar(var__args.dup())
			var_i += 1
		}
	}
}

fn register_sidebar(var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_i := var_wp_registered_sidebars.dup().array_count() + 1
	mut var_id_is_empty := rt.new_bool(!rt.is_true(var_args.array_get('id')))
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sidebar %d')]), rt.new_int(var_i).dup()]) }, rt.ArrayItem{ key: 'id', val: "sidebar-${var_i.str()}" }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'class', val: '' }, rt.ArrayItem{ key: 'before_widget', val: '<li id="%1$s" class="widget %2$s">' }, rt.ArrayItem{ key: 'after_widget', val: '</li>\n' }, rt.ArrayItem{ key: 'before_title', val: '<h2 class="widgettitle">' }, rt.ArrayItem{ key: 'after_title', val: '</h2>\n' }, rt.ArrayItem{ key: 'before_sidebar', val: '' }, rt.ArrayItem{ key: 'after_sidebar', val: '' }, rt.ArrayItem{ key: 'show_in_rest', val: false }])
	mut var_sidebar := rt.call_function('wp_parse_args', [var_args.dup(), rt.call_function('apply_filters', [rt.new_string('register_sidebar_defaults'), var_defaults.dup()])])
	if rt.is_true(var_id_is_empty) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('No %1$s was set in the arguments array for the "%2$s" sidebar. Defaulting to "%3$s". Manually set the %1$s to "%3$s" to silence this notice and keep existing sidebar content.')]), rt.new_string('<code>id</code>'), var_sidebar.array_get('name'), var_sidebar.array_get('id')]), rt.new_string('4.2.0')])
	}
	var_wp_registered_sidebars.array_set(var_sidebar.array_get('id'), var_sidebar.dup())
	rt.call_function('add_theme_support', [rt.new_string('widgets')])
	rt.call_function('do_action', [rt.new_string('register_sidebar'), var_sidebar.dup()])
	return var_sidebar.array_get('id')
}

fn unregister_sidebar(var_sidebar_id rt.PhpVal) {
	mut var_wp_registered_sidebars := rt.new_null()
	// unsupported statement: Stmt_Global
	var_wp_registered_sidebars.array_unset(var_sidebar_id)
}

fn is_registered_sidebar(var_sidebar_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.new_bool(var_wp_registered_sidebars.array_isset(var_sidebar_id))
}

fn wp_register_sidebar_widget(var_id rt.PhpVal, name string, output_callback string, var_options rt.PhpVal, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var__wp_deprecated_widgets_callbacks := rt.new_null()
	// unsupported statement: Stmt_Global
	var_id = var_id.to_lower()
	if output_callback == '' {
		var_wp_registered_widgets.array_unset(rt.new_string(var_id))
		return rt.new_null()
	}
	mut var_id_base := _get_widget_id_base(rt.new_string(var_id).dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(output_callback), var__wp_deprecated_widgets_callbacks.dup(), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string(output_callback)]))))))) {
		var_wp_registered_widget_controls.array_unset(rt.new_string(var_id))
		var_wp_registered_widget_updates.array_unset(var_id_base)
		return rt.new_null()
	}
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'classname', val: output_callback }])
	var_options = rt.call_function('wp_parse_args', [var_options.dup(), var_defaults.dup()])
	mut var_widget := rt.create_array([rt.ArrayItem{ key: 'name', val: name }, rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'callback', val: output_callback }, rt.ArrayItem{ key: 'params', val: var_params }])
	var_widget = rt.call_function('array_merge', [var_widget.dup(), var_options.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [rt.new_string(output_callback)])) && rt.is_true(rt.new_bool(!(var_wp_registered_widgets.array_isset(rt.new_string(var_id))) || rt.is_true(rt.call_function('did_action', [rt.new_string('widgets_init')])))))) {
		rt.call_function('do_action', [rt.new_string('wp_register_sidebar_widget'), var_widget.dup()])
		var_wp_registered_widgets.array_set(var_id, var_widget.dup())
	}
}

fn wp_widget_description(var_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_id.dup()]))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	if var_wp_registered_widgets.array_get(var_id).array_isset(rt.new_string('description')) {
		return rt.call_function('esc_html', [var_wp_registered_widgets.array_get(var_id).array_get('description')])
	}
	return rt.new_null()
}

fn wp_sidebar_description(var_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_id.dup()]))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	if var_wp_registered_sidebars.array_get(var_id).array_isset(rt.new_string('description')) {
		return rt.call_function('wp_kses', [var_wp_registered_sidebars.array_get(var_id).array_get('description'), rt.new_string('sidebar_description')])
	}
	return rt.new_null()
}

fn wp_unregister_sidebar_widget(var_id rt.PhpVal) {
	rt.call_function('do_action', [rt.new_string('wp_unregister_sidebar_widget'), var_id.dup()])
	wp_register_sidebar_widget(var_id.dup(), '', '', rt.new_null())
	wp_unregister_widget_control(var_id.dup())
}

fn wp_register_widget_control(var_id rt.PhpVal, name string, control_callback string, var_options rt.PhpVal, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var__wp_deprecated_widgets_callbacks := rt.new_null()
	// unsupported statement: Stmt_Global
	var_id = var_id.to_lower()
	mut var_id_base := _get_widget_id_base(rt.new_string(var_id).dup())
	if control_callback == '' {
		var_wp_registered_widget_controls.array_unset(rt.new_string(var_id))
		var_wp_registered_widget_updates.array_unset(var_id_base)
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(control_callback), var__wp_deprecated_widgets_callbacks.dup(), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string(control_callback)]))))))) {
		var_wp_registered_widgets.array_unset(rt.new_string(var_id))
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_wp_registered_widget_controls.array_isset(rt.new_string(var_id)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('widgets_init')]))))))) {
		return rt.new_null()
	}
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'width', val: 250 }, rt.ArrayItem{ key: 'height', val: 200 }])
	var_options = rt.call_function('wp_parse_args', [var_options.dup(), var_defaults.dup()])
	var_options.array_set('width', // unsupported expression: Expr_Cast_Int)
	var_options.array_set('height', // unsupported expression: Expr_Cast_Int)
	mut var_widget := rt.create_array([rt.ArrayItem{ key: 'name', val: name }, rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'callback', val: control_callback }, rt.ArrayItem{ key: 'params', val: var_params }])
	var_widget = rt.call_function('array_merge', [var_widget.dup(), var_options.dup()])
	var_wp_registered_widget_controls.array_set(var_id, var_widget.dup())
	if var_wp_registered_widget_updates.array_isset(var_id_base) {
		return rt.new_null()
	}
	if var_widget.array_get('params').array_get(0).array_isset(rt.new_string('number')) {
		var_widget.array_get_mut('params').array_get_mut(0).array_set('number', // unsupported expression: Expr_UnaryMinus)
	}
	var_widget.array_unset(rt.new_string('width'))
	var_widget.array_unset(rt.new_string('height'))
	var_widget.array_unset(rt.new_string('name'))
	var_widget.array_unset(rt.new_string('id'))
	var_wp_registered_widget_updates.array_set(var_id_base, var_widget.dup())
}

fn _register_widget_update_callback(var_id_base rt.PhpVal, var_update_callback rt.PhpVal, var_options rt.PhpVal, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_wp_registered_widget_updates := rt.new_null()
	// unsupported statement: Stmt_Global
	if var_wp_registered_widget_updates.array_isset(var_id_base) {
		if !rt.is_true(var_update_callback) {
			.array_unset()
		}
		return rt.new_null()
	}
	
}



pub fn init_wp_includes_widgets_php() {
	mut var_GLOBALS := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_wp_registered_sidebars := rt.new_array()
	mut var_wp_registered_widgets := rt.new_array()
	mut var_wp_registered_widget_controls := rt.new_array()
	mut var_wp_registered_widget_updates := rt.new_array()
	mut var__wp_sidebars_widgets := rt.new_array()
	var_GLOBALS.array_set('_wp_deprecated_widgets_callbacks', rt.create_array([rt.ArrayItem{ key: none, val: 'wp_widget_pages' }, rt.ArrayItem{ key: none, val: 'wp_widget_pages_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_calendar' }, rt.ArrayItem{ key: none, val: 'wp_widget_calendar_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_archives' }, rt.ArrayItem{ key: none, val: 'wp_widget_archives_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_links' }, rt.ArrayItem{ key: none, val: 'wp_widget_meta' }, rt.ArrayItem{ key: none, val: 'wp_widget_meta_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_search' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_entries' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_entries_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_tag_cloud' }, rt.ArrayItem{ key: none, val: 'wp_widget_tag_cloud_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_categories' }, rt.ArrayItem{ key: none, val: 'wp_widget_categories_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_text' }, rt.ArrayItem{ key: none, val: 'wp_widget_text_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_rss' }, rt.ArrayItem{ key: none, val: 'wp_widget_rss_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_comments' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_comments_control' }]))
}
